<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.Xml" %>

<script runat="server">

CopMvcUtil util = new CopMvcUtil();
RevFuncSrv rev_func_srv = new RevFuncSrv();
FuncSrv func_srv = new FuncSrv();
XMLUtil xmlProc = new XMLUtil();

XmlDocument xmlTmplDoc = new XmlDocument();
XmlDocument xmlReqDoc = new XmlDocument();
XmlDocument xmlOut = new XmlDocument();
CopRevenueGov2.Service.EOL_Code1Form objAddressCheck = new CopRevenueGov2.Service.EOL_Code1Form();

string strBufferv, gsDebug, gsDebugUp;
string sma = string.Empty;
string ai = string.Empty;
string cc = string.Empty; 
string xs = string.Empty;
string msApp= string.Empty;


public string GetAddress(string Addr1, string Addr2, string ZipCode)
{

    string response = string.Empty;
    
    try
    {
        CString req_url = CopMvcUtil.Session("WsAddress") + "/Code1?addr1=" + Addr1
                + "&addr2=" + Addr2 + "&zipcode=" + ZipCode;

        HttpWebRequest oHTTPRequest = HttpWebRequest.Create(req_url) as HttpWebRequest;   
        WebResponse oHTTPResponse = oHTTPRequest.GetResponse();

        System.IO.StreamReader sr = new System.IO.StreamReader(oHTTPResponse.GetResponseStream());
        response = System.Web.HttpUtility.HtmlDecode(sr.ReadToEnd());
    }
    catch (WebException ex)
    {
        response = ex.Message;
    }

    return response;
    
}

protected void ExitAsp()
{
	xmlOut = null;
	xmlTmplDoc = null;
	xmlReqDoc = null;
	Response.End();
}
void CallAddressCheck()
{
    xmlOut = Code1Service.CallService(xmlReqDoc);
    xmlProc.ispXmlSetFieldVal(xmlOut, gsDebug, "DEBUG", "", 0);
    Response.Write(xmlProc.XMLToString(xmlOut));
}


</script>


<%
//'''EHD - 2008.12.01 - New for the Code1 Addition

    msApp = "AC";	//Address Check - Using Code1

	Response.CacheControl = "no-cache";
	Response.AddHeader("Pragma", "no-cache");
	Response.Expires = 0;
	Response.ContentType = "text/xml";


// rev_func_srv.CreateXmlBufferObj(xmlReqDoc, util.GetString(Request), false);

//string sAdd1, sAdd2, sZip;
//sAdd1 = xmlProc.ispXmlGetFieldVal(xmlReqDoc, "ADD1", "", 0);
//sAdd2 = xmlProc.ispXmlGetFieldVal(xmlReqDoc, "ADD2", "", 0);
//sZip = xmlProc.ispXmlGetFieldVal(xmlReqDoc, "ZIP", "", 0);

//Response.Write(GetAddress(sAdd1, sAdd2, sZip));
//Response.End();


rev_func_srv.CreateXmlBufferObj(xmlOut, util.GetXMLString(Server.MapPath(@"~/views/web/xml/Code1AddressCheck.xml")), false);
rev_func_srv.CreateXmlBufferObj(xmlReqDoc, util.GetString(Request), false);

//objAddressCheck = (CopRevenueGov2.Service.EOL_Code1Form)VB.CreateObject("EOL.Code1Form");

//if(objAddressCheck == null)
//{    
//    rev_func_srv.DoError( "AccountInfo", "5010001", "", 
//    "Object not loaded: 'EOL.Code1Form'", xmlOut, msApp);                
//}

objAddressCheck.ServerAddress = CopMvcUtil.Session("SagAddress");


 CallAddressCheck();


if(xmlProc.ispXmlGetFieldVal(xmlOut, "ENTITY_INFO/ENTITY_ID", "", 0) != "")
{
	Session["AccNum"] = xmlProc.ispXmlGetFieldVal(xmlOut, "ENTITY_INFO/ENTITY_ID", "", 0);
}

	
rev_func_srv.LogInformation(xmlOut, msApp, "Response");
xmlProc.ispXmlSetFieldVal(xmlReqDoc, gsDebugUp, "DEBUG", "", 0);

rev_func_srv.WriteDebugFile(CopMvcUtil.Session("AccNum") + "." + msApp + ".debug.txt", 
		"<DEBUGINFO>" + VB.vbCrLf + "<REQUSET>" + xmlProc.XMLToString(xmlReqDoc).Replace("<?xml version=\"1.0\"?>", "") + "</REQUSET>" 
		+ VB.vbcrlf + VB.vbcrlf + VB.vbcrlf + 
		"<RESPONSE>" + xmlProc.XMLToString(xmlOut).Replace( "<?xml version=\"1.0\"?>", "") + 
        "</RESPONSE>" + VB.vbCrLf + "</DEBUGINFO>");



ExitAsp();



%>