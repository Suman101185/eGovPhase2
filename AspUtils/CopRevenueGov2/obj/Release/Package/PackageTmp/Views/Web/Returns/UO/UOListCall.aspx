<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ Import Namespace="System.Xml" %>

<script runat="server">

CopMvcUtil util = new CopMvcUtil();
RevFuncSrv rev_func_srv = new RevFuncSrv();
FuncSrv func_srv = new FuncSrv();
XMLUtil xmlProc = new XMLUtil();
string msApp = string.Empty;

XmlDocument xmlOut = new XmlDocument();
XmlDocument xmlReqDoc = new XmlDocument();
CopRevenueGov2.Service.EOL_UOList objUOListCall = new CopRevenueGov2.Service.EOL_UOList(); 

string gsDebug = string.Empty;
string gsDebugUp = string.Empty;
string lsEntityNo = string.Empty;
string lsAccountNo = string.Empty;
    
//''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
void ExitAsp()
{

	objUOListCall = null;
	xmlOut = null;
	xmlReqDoc = null;

	Response.End();
}

//''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
void CallRttie034()
{
    
    
    bool bLoop;
    int iTry;
    string sma = string.Empty;
    string info = string.Empty;
    string [] acct = new string[1];
    
	sma = VB.space(79);

	rev_func_srv.PopulateBuffer(xmlReqDoc, "UO_INFO", info, ref gsDebugUp);
	rev_func_srv.PopulateBuffer(xmlReqDoc, "UO_ACCT", acct, ref gsDebugUp);

	bLoop = false;
	iTry = 0;
	do
    {
		bool a = objUOListCall.RTTIE034(ref sma,ref  info,ref  acct);

		if(objUOListCall.ErrorNumber == 148 )
        {
		}
		else if(objUOListCall.ErrorNumber != 0 )
        {
			rev_func_srv.DoError("UOListCall", "5030003:" + objUOListCall.ErrorNumber, 
					"", "SAG: " + objUOListCall.ErrorMessage, xmlOut, msApp);

			bLoop = true;
        }
		else
        {
			bLoop = true;
			iTry = 0;
		}
		iTry = iTry + 1;
    }
	while(bLoop == true || iTry == 5);

	if(iTry == 5 )
    {
		rev_func_srv.DoError("UOListCall", "5030004", "", 
				"SAG: Mainframe is busy, Submit again...", xmlOut, msApp);
	}

	if(objUOListCall.ErrorNumber == 0 )
    {
		rev_func_srv.PopulateXML( "ERROR_INFO", sma, xmlOut, xmlOut);
		rev_func_srv.PopulateXML("UO_INFO", info, xmlOut, xmlOut);
		rev_func_srv.PopulateXML("UO_ACCT", acct, xmlOut, xmlOut);
	}	

	xmlProc.ispXmlSetFieldVal(xmlOut, gsDebug, "DEBUG", "", 0);
	Response.Write(xmlOut);
}


</script>


<%

Response.CacheControl = "no-cache";
Response.AddHeader("Pragma", "no-cache");
Response.Expires = 0;
Response.ContentType = "text/xml";

msApp = "UOList";    

rev_func_srv.CreateXmlBufferObj(xmlOut,  util.GetXMLString(Server.MapPath("../../xml/UOList")), false);

rev_func_srv.CreateXmlBufferObj(xmlReqDoc,util.GetString(Request), false);
lsEntityNo = xmlProc.ispXmlGetFieldVal(xmlReqDoc, "UO_INFO/ENTITY_ID", "", 0);
lsAccountNo = xmlProc.ispXmlGetFieldVal(xmlReqDoc, "UO_INFO/ACCOUNT_ID", "", 0);

objUOListCall = (CopRevenueGov2.Service.EOL_UOList)VB.CreateObject("EOL.UOList");
if(objUOListCall == null)
{
	rev_func_srv.DoError("UOListCall.asp", "5030001", "", "Object not loaded: 'EOL.UOList'", xmlOut, msApp);
}
else
{
	objUOListCall.ServerAddress = CopMvcUtil.Session("SagAddress");
	CallRttie034();
}

if (xmlProc.ispXmlGetFieldVal(xmlOut, "UO_INFO/ENTITY_ID", "", 0) == "")
{
	xmlProc.ispXmlSetFieldVal(xmlOut, lsEntityNo, "UO_INFO/ENTITY_ID", "", 0);
	xmlProc.ispXmlSetFieldVal(xmlOut, lsAccountNo, "UO_INFO/ACCOUNT_ID", "", 0);
}

rev_func_srv.LogInformation(xmlOut, msApp, "Response");
xmlProc.ispXmlSetFieldVal(xmlReqDoc, gsDebugUp, "DEBUG", "", 0);

rev_func_srv.WriteDebugFile( CopMvcUtil.Session("AccNum") + "." + msApp + ".debug.txt", 
		"<DEBUGINFO>" + VB.vbCrLf + "<REQUSET>" + xmlProc.XMLToString(xmlReqDoc).Replace("<?xml version=\"1.0\"?>", "") + "</REQUSET>" 
		+ VB.vbCrLf + VB.vbCrLf + VB.vbCrLf + 
		"<RESPONSE>" + xmlProc.XMLToString(xmlOut).Replace("<?xml version=\"1.0\"?>", "") + "</RESPONSE>" + VB.vbCrLf + "</DEBUGINFO>";

ExitAsp();




%>