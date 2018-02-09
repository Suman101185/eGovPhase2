<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ Import Namespace="System.Xml" %>
<script runat="server">

CopMvcUtil util = new CopMvcUtil();
RevFuncSrv rev_func_srv = new RevFuncSrv();
FuncSrv func_srv = new FuncSrv();
XMLUtil xmlProc = new XMLUtil();

string  msApp = string.Empty;
XmlDocument xmlOut = new XmlDocument();
XmlDocument xmlReqDoc = new XmlDocument();
    
string  gsDebug, gsDebugUp;
string lsAccountNo = string.Empty;
CopRevenueGov2.Service.EOL_UOForm objUOFormCall = new CopRevenueGov2.Service.EOL_UOForm();


void ExitAsp()
{
	objUOFormCall = null;
	xmlOut = null;
	xmlReqDoc = null;

	Response.End();
}


void CallRttie035()
{
	//dim sXMLData, lXML, lBufferArea
        
    bool bLoop;
    int iTry;
    string sma =  string.Empty;
    string acct= string.Empty;
    string amts =  string.Empty;
    string[] uo3 = new string[1];

	sma = VB.space(8) + "00000000000" + VB.space(60);


	UO_PopulateBuffer(xmlReqDoc, "UO_ACCT", acct);
	UO_PopulateBuffer(xmlReqDoc, "UO_AMTS", amts);
	UO_PopulateBuffer(xmlReqDoc, "UO3_PAGE", uo3);


	bLoop = false;
	iTry = 0;
	do
    {
		bool a = objUOFormCall.RTTIE035(ref sma,ref acct, ref amts,ref uo3);

		if(objUOFormCall.ErrorNumber == 148 )
        {
		}
		else if(objUOFormCall.ErrorNumber != 0 )
        {
			rev_func_srv.DoError("UOFormCall.asp", "5030003:" + objUOFormCall.ErrorNumber, 
					"", "SAG: " + objUOFormCall.ErrorMessage, xmlOut, msApp);
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

	if(iTry == 5)
    {
		rev_func_srv.DoError("UOFormCall.asp", "5030004", "", 
				"SAG: Mainframe is busy, Submit again...", xmlOut, msApp);
	}

	if(objUOFormCall.ErrorNumber == 0 )
    {
		rev_func_srv.PopulateXML("ERROR_INFO", sma, xmlOut, xmlOut);
		rev_func_srv.PopulateXML("UO_ACCT", acct, xmlOut, xmlOut);
		rev_func_srv.PopulateXML("UO_AMTS", amts, xmlOut, xmlOut);
		rev_func_srv.PopulateXML("UO3_PAGE", uo3, xmlOut, xmlOut);
	}

	Session["EOLFORMXML"] = xmlProc.XMLToString(xmlOut).Replace(VB.vbcrlf,"");
	Response.Write(xmlProc.XMLToString(xmlOut));
}


void UO_PopulateBuffer(XmlDocument oXML, string sSection, object vData)
{
    rev_func_srv.PopulateBuffer(oXML, sSection, vData, ref gsDebugUp);
}



</script>


<%

Response.CacheControl = "no-cache";
Response.AddHeader("Pragma", "no-cache");
Response.Expires = 0;
Response.ContentType = "text/xml";

msApp = "UOForm";


Session["EOLFORMXML"] = "";

rev_func_srv.CreateXmlBufferObj(xmlOut, util.GetXMLString(Server.MapPath("../../xml/UOForm")), false);

rev_func_srv.CreateXmlBufferObj(xmlReqDoc, util.GetXMLString(Request), false);

lsAccountNo = xmlProc.ispXmlGetFieldVal(xmlReqDoc, "UO_ACCT/ACCOUNT_ID", "", 0);

objUOFormCall = (CopRevenueGov2.Service.EOL_UOForm)VB.CreateObject("EOL.UOForm");

if(objUOFormCall == null)
{
	rev_func_srv.DoError("UOFormCall", "5030001", "", "Object not loaded: 'EOL.UOForm'", xmlOut, msApp);
}
else
{
	objUOFormCall.ServerAddress = CopMvcUtil.Session("SagAddress");
	CallRttie035();
}

if(xmlProc.ispXmlGetFieldVal(xmlOut, "UO_ACCT/ACCOUNT_ID", "", 0) == "" )
{
	xmlProc.ispXmlSetFieldVal( xmlOut, lsAccountNo, "UO_INFO/ACCOUNT_ID", "", 0);
}

rev_func_srv.LogInformation( xmlOut, msApp, "Response");
xmlProc.ispXmlSetFieldVal( xmlReqDoc, gsDebugUp, "DEBUG", "", 0);

xmlProc.ispXmlSetFieldVal( xmlOut, gsDebug, "DEBUG", "", 0);

rev_func_srv.WriteDebugFile( CopMvcUtil.Session("AccNum") + "." + msApp + ".debug.txt", 
		"<DEBUGINFO>" + VB.vbCrLf + "<REQUSET>" + xmlProc.XMLToString(xmlReqDoc).Replace("<?xml version=\"1.0\"?>", "") + "</REQUSET>" 
		+ VB.vbCrLf + VB.vbCrLf + VB.vbCrLf + 
		"<RESPONSE>" + xmlProc.XMLToString(xmlOut).Replace( "<?xml version=\"1.0\"?>", "") + "</RESPONSE>" + VB.vbCrLf + "</DEBUGINFO>";

ExitAsp();

%>

