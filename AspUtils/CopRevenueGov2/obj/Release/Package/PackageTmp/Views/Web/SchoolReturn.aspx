<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.Xml" %>

<script runat="server">

CopMvcUtil util = new CopMvcUtil();
RevFuncSrv rev_func_srv = new RevFuncSrv();
FuncSrv func_srv = new FuncSrv();
XMLUtil xmlProc = new XMLUtil();

bool bLoop;
string sma= string.Empty;
string eschool = string.Empty;
string amt = string.Empty;


//dim a, i, j, k, lComplexNode, lSimpleNode, lStrExport, lStrTemp, lLen
//dim xmlTmplDoc, xmlReqDoc, strBufferv, gsDebug, gsDebugUp, xmlOut
//dim objSchoolReturn, objEmail
//dim sma, eschool, amt, inAcctNo, lsFunction

XmlDocument xmlTmplDoc = new XmlDocument();
XmlDocument xmlReqDoc = new XmlDocument();
XmlDocument xmlOut = new XmlDocument();
CopRevenueGov2.Service.EOL_SchoolForm objSchoolReturn = null;
    
string msApp = string.Empty;
string inAcctNo= string.Empty;
string gsDebugUp = string.Empty;
string lsFunction = string.Empty;

protected void ExitAsp()
{
    //objSchoolReturn = null;
	//xmlOut = null;
	xmlTmplDoc = null;
	xmlReqDoc = null;
	Response.End();
}


protected void CallRttie036()
    {
    //dim bLoop, sXMLData, lXML, lBufferArea, iTry
    int iTry =0;
    bool bLoop;
	sma = VB.space(79);

	rev_func_srv.PopulateBuffer(xmlReqDoc, "SCHOOL_INFO", eschool);	
	rev_func_srv.PopulateBuffer(xmlReqDoc, "AMT_INFO", amt);

	bLoop = false;
	iTry = 0;
    
	do
    {
		bool a = objSchoolReturn.RTTIE036(ref sma, ref eschool, ref amt);

		if(objSchoolReturn.ErrorNumber == 148)
        {
		}
		else if(objSchoolReturn.ErrorNumber != 0 )
        {
			rev_func_srv.DoError("SchoolReturn", "5030003:" + objSchoolReturn.ErrorNumber, 
					"", "SAG: " + objSchoolReturn.ErrorMessage, xmlOut, msApp);

			bLoop = true;
        }
		else
        {
			bLoop = true;
			iTry = 0;
		}
		iTry = iTry + 1;
    }
	while( bLoop == true || iTry == 5);

	if(iTry == 5)
    {
		rev_func_srv.DoError("SchoolReturn", "5030004", "", 
				"SAG: Mainframe is busy, Submit again...", xmlOut, msApp);
    }


	if(objSchoolReturn.ErrorNumber == 0 )
    {
		rev_func_srv.PopulateXML("ERROR_INFO", sma, xmlOut, xmlOut);
		rev_func_srv.PopulateXML("SCHOOL_INFO", eschool, xmlOut, xmlOut);
		rev_func_srv.PopulateXML("AMT_INFO", amt, xmlOut, xmlOut);
	}

	xmlProc.ispXmlSetFieldVal(xmlOut, sma + eschool + amt, "DEBUG", "", 0);
	
	Response.Write(xmlProc.XMLToString(xmlOut));
}
</script>


<%

Response.CacheControl = "no-cache";
Response.AddHeader("Pragma", "no-cache");
Response.Expires = 0;
Response.ContentType = "text/xml";
        
msApp = "SR";


rev_func_srv.CreateXmlBufferObj(xmlOut, Server.MapPath("xml\SchoolReturn.xml"), false);

rev_func_srv.CreateXmlBufferObj(xmlReqDoc, util.GetString(Request), false);

inAcctNo = xmlProc.ispXmlGetFieldVal(xmlReqDoc, "SCHOOL_INFO/ACCOUNT_ID", "", 0);
lsFunction = xmlProc.ispXmlGetFieldVal(xmlReqDoc, "SCHOOL_INFO/RETURN_STATUS", "", 0);

objSchoolReturn = (CopRevenueGov2.Service.EOL_SchoolForm)VB.CreateObject("EOL.SchoolForm");

if(objSchoolReturn == null) 
{
	rev_func_srv.DoError("SchoolReturn", "5030001", "", 
			"Object not loaded: 'EOL.SchoolForm'", xmlOut, msApp);
}
objSchoolReturn.ServerAddress = CopMvcUtil.Session("SagAddress");

CallRttie036();

if (xmlProc.ispXmlGetFieldVal(xmlOut, "SCHOOL_INFO/ACCOUNT_ID", "", 0) == "")
{
	xmlProc.ispXmlSetFieldVal(xmlOut, inAcctNo, "SCHOOL_INFO/ACCOUNT_ID", "", 0);
}

xmlProc.ispXmlSetFieldVal(xmlOut, lsFunction, "SCHOOL_INFO/RETURN_STATUS", "", 0);

rev_func_srv.LogInformation(xmlOut, msApp, "Response");
xmlProc.ispXmlSetFieldVal(xmlReqDoc, gsDebugUp, "DEBUG", "", 0);

	rev_func_srv.WriteDebugFile(CopMvcUtil.Session("AccNum") + "." + msApp + ".debug.txt", 
			"<DEBUGINFO>" + VB.vbCrLf + "<REQUEST>" +xmlProc.XMLToString(xmlReqDoc).Replace( "<?xml version=\"1.0\"?>", "") + "</REQUEST>" 
			+ VB.vbCrLf + VB.vbCrLf + VB.vbCrLf + 
			"<RESPONSE>" + xmlProc.XMLToString(xmlOut).Replace( "<?xml version=\"1.0\"?>", "") + "</RESPONSE>" + VB.vbCrLf + "</DEBUGINFO>");

ExitAsp();




%>
