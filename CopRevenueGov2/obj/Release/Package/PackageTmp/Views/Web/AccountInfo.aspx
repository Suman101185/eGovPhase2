<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="CopRevenueGov2.Service" %>


<script runat="server">

CopMvcUtil util = new CopMvcUtil();
RevFuncSrv rev_func_srv = new RevFuncSrv();
FuncSrv func_srv = new FuncSrv();
XMLUtil xmlProc = new XMLUtil();

string msApp= string.Empty;


//dim a, j, k, lComplexNode, lSimpleNode, lStrExport, lStrTemp, lLen
//dim xmlTmplDoc,  strBufferv;
//dim  emi, eta(), echk, ena1(), ena2();

//dim lFunctionCode,  outAcctNo, sTemp;

string [] ena1;
string [] ena2;
string  emi = string.Empty;
string [] eta;

string inAcctNo;
bool bCheck;
XmlDocument xmlReqDoc = new XmlDocument();
XmlDocument xmlOut = new XmlDocument();
XmlDocument xmlTmplDoc = new XmlDocument();
CopRevenueGov2.Service.EOLGenCityBuffer objGenCityBuffer = new CopRevenueGov2.Service.EOLGenCityBuffer();
CopRevenueGov2.Service.Persits_MailSender objEmail = null;
string sma;
string mSession_RmtAdd = string.Empty;
CString sErrorHeader = string.Empty;
CString gsDebug = string.Empty, gsDebugUp = string.Empty;
CString sTemp = string.Empty;
string echk = string.Empty;
int i;


//''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
void ExitAsp()
{
    
	objGenCityBuffer = null;
	objEmail = null;
	xmlOut = null;
	xmlTmplDoc = null;
	xmlReqDoc = null;

	Response.End();
}


void CallRttie010()
{
   
    /*xmlOut = RTTIE010.CallService(xmlReqDoc);*/
    /*This has been changed(By Sudipta Roy) for pointing to new helper class*/
    /*for consuming the registrtion and login service in Web reference methodology*/
    xmlOut = RTTIE010_New.CallService(xmlReqDoc);
    

    xmlProc.ispXmlSetFieldVal(xmlOut, gsDebug, "DEBUG", "", 0);
   
    Response.Write(xmlProc.XMLToString(xmlOut));
}

void Email_Successful(string sMessage)
{
	CopRevenueGov2.Service.Persits_MailSender objEmail;
	
	if(string.IsNullOrEmpty(inAcctNo))
    {
		inAcctNo = "9999999";
	}
	
	objEmail = (CopRevenueGov2.Service.Persits_MailSender)VB.CreateObject("Persits.MailSender");

	if(objEmail == null)
    {
    }
	else
    {
		objEmail.Host = CopMvcUtil.Session("EMAIL_IP_ADDR");
		objEmail.From = CopMvcUtil.Session("EMAIL_FROM");
		objEmail.AddAddress("sudiptaroy2030@gmail.com");
		objEmail.Subject = "Revenue Web Error - " + CopMvcUtil.Session("ENVIRONMENT");
		objEmail.Body = sMessage;
		objEmail.Send();		
	}
}

CString ReturnArray(object vData)
{
    CString sTemp = string.Empty;
    int  i;
    
	if(VB.IsArray(vData))
    {
        string[] varray = (string[])vData;

        for (i = 0; i < varray.Length; i++)
        {
            sTemp = sTemp + varray[i];
		}
    }
	else
    {
        sTemp = vData.ToString();
	}

	return sTemp;
}


</script>

<%
 
/*   
''Rev1 - ehd 3-12-03
''The following statements is for verifing that the website is up an running.
''It is used when the page is called from a VB Program - VerifyWeb 
''test line added by Gary - 8-31-2010
''20100913 EHD Merged in changes from Larry and Gary to return emails with buffer data on errors. Which was
''done when I was on Vacation week of 20100830 becuase a user keep failing for some unknown reason. Every other
''user was working fine. Also changed the TO email from Tim to Ed and commented out Larry on the CC.
*/

Response.CacheControl = "no-cache";
Response.AddHeader("Pragma", "no-cache");
Response.Expires = 0;
Response.ContentType = "text/xml";

rev_func_srv.CreateXmlBufferObj(xmlOut, util.GetXMLString(Server.MapPath(@"~/views/web/xml/AcctTemplate.xml")), false);
rev_func_srv.CreateXmlBufferObj(xmlReqDoc, util.GetXMLString(Request), false);

CallRttie010();

ExitAsp();


    
%>




