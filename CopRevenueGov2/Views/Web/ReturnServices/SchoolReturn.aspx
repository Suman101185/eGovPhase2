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

XmlDocument xmlTmplDoc = new XmlDocument();
XmlDocument xmlReqDoc = new XmlDocument();
XmlDocument xmlOut = new XmlDocument();
CString gsDebug = string.Empty;
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

void CallRttie036()
    {
        xmlOut = RTTIE036.CallService(xmlReqDoc);
        xmlProc.ispXmlSetFieldVal(xmlOut, gsDebug, "DEBUG", "", 0);
        Response.Write(xmlProc.XMLToString(xmlOut));
    }

</script>


<%

Response.CacheControl = "no-cache";
Response.AddHeader("Pragma", "no-cache");
Response.Expires = 0;
Response.ContentType = "text/xml";
        
msApp = "SR";


rev_func_srv.CreateXmlBufferObj(xmlOut, util.GetXMLString(Server.MapPath("~/Views/web/xml/SchoolReturn.xml")), false);

rev_func_srv.CreateXmlBufferObj(xmlReqDoc, util.GetXMLString(Request), false);

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
