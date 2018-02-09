<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ Import Namespace="System.Xml" %>


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
	//dim  sXMLData, lXML, lBufferArea;
    bool bLoop;
    int iTry = 0;
       
	sma = VB.space(79);
    object x = new object();
	rev_func_srv.PopulateBuffer(xmlReqDoc, "ENTITY_INFO", ref emi);
	rev_func_srv.PopulateBuffer(xmlReqDoc, "TAX_ACCT", ref eta);
	echk = VB.space(31);
    

	rev_func_srv.PopulateBuffer(xmlReqDoc, "NAME_ADDRESS", ref ena1);
	
	ena2 = new string [ena1.Length]; //(UBound(ena1))
	for(int i = 0; i< ena2.Length; i++)
    {
		ena2[i] = VB.mid(ena1[i], 102);
		ena1[i] = VB.mid(ena1[i], 1, 101);
	}

	bLoop = false;
	iTry = 0;
	CString sLMH ;
	
	do
    {       
        
		bool a = objGenCityBuffer.RTTIE010(ref sma, ref emi, ref eta, ref echk, ref ena1, ref ena2);

		if(objGenCityBuffer.ErrorNumber == 148 )
        {
        }        	
		else if(objGenCityBuffer.ErrorNumber != 0 )
        {
			bLoop = true;

            sLMH = "AccountInfo.asp  " + "inAcctNo='" + inAcctNo + "'" + VB.vbcrlf + " xmlReqDoc=" + xmlProc.XMLToString(xmlReqDoc) + " ip='" + mSession_RmtAdd + "'";
			Email_Successful(sLMH);
			sLMH ="AccountInfo.asp  " +  "inAcctNo='" + inAcctNo + "'" + VB.vbcrlf + " xmlOut=" + xmlProc.XMLToString(xmlOut) + " ip='" + mSession_RmtAdd + "'";
			Email_Successful(sLMH);
			sLMH = "sma = " + ReturnArray(sma);
			Email_Successful(sLMH);
			sLMH = "emi = " + ReturnArray(emi);
			Email_Successful(sLMH);
			sLMH = "eta = " + ReturnArray(eta);
			Email_Successful(sLMH);
			sLMH = "echk = " + ReturnArray(echk);
			Email_Successful(sLMH);
			sLMH = "ena1 = " + ReturnArray(ena1);
			Email_Successful(sLMH);

			sLMH = "SAG: " + objGenCityBuffer.ErrorMessage + " inAcctNo='" + inAcctNo + "'" + " ip='" + mSession_RmtAdd + "'";
			rev_func_srv.DoError("AccountInfo", "5010003:" + objGenCityBuffer.ErrorNumber,"", sLMH , xmlOut, msApp);
        }
		else
        {
			bLoop = true;
			iTry = 0;
		}
        
		iTry = iTry + 1;
    }while( bLoop != true && iTry != 5);

	if(iTry == 5 )
    {
		rev_func_srv.DoError("AccountInfo", "5010004", "", 
				"SAG: Mainframe is busy, Submit again...", xmlOut, msApp);
	}
	
	if(objGenCityBuffer.ErrorNumber == 0 )
    {
		for(int i = 0; i < ena1.Count(); i++)
        {
			ena1[i] = ena1[i] + ena2[i];
		}
	
		rev_func_srv.PopulateXML("ERROR_INFO", sma, xmlOut, ref xmlOut);
		rev_func_srv.PopulateXML( "ENTITY_INFO", emi, xmlOut, ref xmlOut);
		rev_func_srv.PopulateXML( "TAX_ACCT", eta, xmlOut, ref xmlOut);
		rev_func_srv.PopulateXML( "ECHECK", VB.space(31),  xmlOut, ref xmlOut);
		rev_func_srv.PopulateXML( "NAME_ADDRESS", ena1,  xmlOut, ref xmlOut);
	}
	
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
		objEmail.AddAddress("edd@is-partner.com");
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

msApp = "AI";
mSession_RmtAdd = CopMvcUtil.GetString(Request.ServerVariables["REMOTE_ADDR"]);

//on error resume next

//'''Rev1<
sErrorHeader = "AccountInfo.asp ran with the following error." + VB.vbcrlf +
			 "The program ran @ " + VB.Now() + VB.vbcrlf + VB.vbcrlf + VB.vbcrlf;
             
bCheck = false;

if(Session["ENVIRONMENT"] == "")
{
	sErrorHeader = "The Daily Web Verification program ran with the following error." + VB.vbcrlf +
			 "The program ran @ " + VB.Now() + VB.vbcrlf + VB.vbcrlf + VB.vbcrlf;
}

    
rev_func_srv.CreateXmlBufferObj(xmlReqDoc,  util.GetXMLString(Request), false);
rev_func_srv.CreateXmlBufferObj(xmlOut, util.GetXMLString(Server.MapPath("~/views/web/xml/AcctTemplate.xml")), false);

//'''Rev1<
if(xmlProc.ispXmlGetFieldVal(xmlReqDoc, "ENTITY_INFO/FUNCTION_CODE", "", 0) == "CHECK")
{
	bCheck = true;
	rev_func_srv.CreateXmlBufferObj(xmlReqDoc, util.GetXMLString(Server.MapPath("~/views/web/xml/AcctTemplate.xml")), false);
	if(Session["ENVIRONMENT"] == "P" )
    {
		xmlProc.ispXmlSetFieldVal(xmlReqDoc, "I", "ENTITY_INFO/FUNCTION_CODE", "", 0);
		xmlProc.ispXmlSetFieldVal(xmlReqDoc, "232972994", "ENTITY_INFO/ENTITY_ID", "", 0);
		xmlProc.ispXmlSetFieldVal(xmlReqDoc, "", "ENTITY_INFO/ACCOUNT_ID", "", 0);
		xmlProc.ispXmlSetFieldVal(xmlReqDoc, "10008013", "ENTITY_INFO/PIN", "", 0);
    }
	else
    {
		xmlProc.ispXmlSetFieldVal( xmlReqDoc, "I", "ENTITY_INFO/FUNCTION_CODE", "", 0);
		xmlProc.ispXmlSetFieldVal( xmlReqDoc, "261393920", "ENTITY_INFO/ENTITY_ID", "", 0);
		xmlProc.ispXmlSetFieldVal( xmlReqDoc, "", "ENTITY_INFO/ACCOUNT_ID", "", 0);
		xmlProc.ispXmlSetFieldVal( xmlReqDoc, "111", "ENTITY_INFO/PIN", "", 0);
	}
}
//'''>Rev1

inAcctNo = xmlProc.ispXmlGetFieldVal(xmlReqDoc, "ENTITY_INFO/ENTITY_ID", "", 0);

objGenCityBuffer = (CopRevenueGov2.Service.EOLGenCityBuffer)VB.CreateObject("EOL.GenCityBuffer");

if(objGenCityBuffer == null) 
{
	rev_func_srv.DoError("AccountInfo", "5010001", "", 
			"Object not loaded: 'EOL.GenCityBuffer'", xmlOut, msApp);
}

objGenCityBuffer.ServerAddress = CopMvcUtil.GetString(Session["SagAddress"]);

CallRttie010();

if(bCheck == false)
{
	if(xmlProc.ispXmlGetFieldVal(xmlOut, "ENTITY_INFO/ENTITY_ID", "", 0) != "" )
    {
		Session["AccNum"] = xmlProc.ispXmlGetFieldVal(xmlOut, "ENTITY_INFO/ENTITY_ID", "", 0);
    }
	else
    {
		xmlProc.ispXmlSetFieldVal(xmlOut, inAcctNo.ToString(), "ENTITY_INFO/ENTITY_ID", "", 0);
		Session["AccNum"] = inAcctNo;
	}
	
	rev_func_srv.LogInformation( xmlOut, msApp, "Response");
	xmlProc.ispXmlSetFieldVal( xmlReqDoc, gsDebugUp, "DEBUG", "", 0);

	rev_func_srv.WriteDebugFile( CopMvcUtil.Session("AccNum") + "." + msApp + ".debug.txt", "<DEBUGINFO>" + VB.vbcrlf + "<REQUSET>" + xmlProc.XMLToString(xmlReqDoc).Replace("<?xml version=\"1.0\"?>", "") + "</REQUSET>" 	+ VB.vbcrlf + VB.vbcrlf + VB.vbcrlf + 	"<RESPONSE>" + xmlProc.XMLToString(xmlOut).Replace("<?xml version=\"1.0\"?>", "") + "</RESPONSE>" + VB.vbcrlf + "</DEBUGINFO>");

//	WriteDebugFile session("AccNum") & "." & msApp & ".req.xml", xmlReqDoc.xml
//	WriteDebugFile session("AccNum") & "." & msApp & ".resp.xml", xmlOut.xml
//	WriteDebugFile session("AccNum") & "." & msApp & ".raw.req.txt", gsDebugUp
//	WriteDebugFile session("AccNum") & "." & msApp & ".raw.resp.txt", gsDebug
}
else
{
//'''Rev1<
	objEmail =  (CopRevenueGov2.Service.Persits_MailSender)VB.CreateObject("Persits.MailSender");

	if(objEmail == null) {
			rev_func_srv.DoError("AccountInfo", "5010005", "", 
					"Object not loaded: 'Persits.MailSender'", xmlOut, msApp);
	}
	
		objEmail.Host = CopMvcUtil.Session("EMAIL_IP_ADDR");
		objEmail.From = CopMvcUtil.Session("EMAIL_FROM");
		string [] temp = CopMvcUtil.Session("EMAIL_COMMENTS_TO").Split(',');
		for(i = 0 ; i< temp.Length; i ++)
        {
			objEmail.AddAddress( temp[i]);
		}
			
		temp = CopMvcUtil.Session("EMAIL_COMMENTS_CC").Split(',');
		for(i = 0; i < temp.Length; i++)
        {
			objEmail.AddCC(temp[i]);
		}
		
		objEmail.Subject = "Revenue Web Verification - " +  CopMvcUtil.Session("ENVIRONMENT");
		if(xmlProc.ispXmlGetFieldVal(xmlOut, "ERROR_INFO/ERROR", "", 0) != "0" )
        {
			sErrorHeader = sErrorHeader 
					+ "Server: " + CopMvcUtil.Session("SERVERIP") + VB.vbcrlf 
					+ "Program: " + xmlProc.ispXmlGetFieldVal(xmlOut, "ERROR_INFO/PROGRAM", "", 0) + VB.vbcrlf 
					+ "Error: " + xmlProc.ispXmlGetFieldVal(xmlOut, "ERROR_INFO/ERROR", "", 0) + VB.vbcrlf 
					+ "Line: " + xmlProc.ispXmlGetFieldVal(xmlOut, "ERROR_INFO/LINE", "", 0) + VB.vbcrlf 
					+ "Message: " + xmlProc.ispXmlGetFieldVal(xmlOut, "ERROR_INFO/MESSAGE", "", 0);
			sTemp = rev_func_srv.WriteEmailFile("Error.txt", sErrorHeader);
        }
		else
        {
			sErrorHeader = "The Daily Web Verification program ran without any errors." + VB.vbcrlf 
					+ "All systems are up and running correctly. The following data was " + VB.vbcrlf 
					+ "retrieved for the verification account @ " + VB.Now() + VB.vbcrlf + VB.vbcrlf + VB.vbcrlf 
					+ xmlProc.ispXmlGetRecordXml(xmlOut, "NAME_ADDRESS", 0);
			sTemp = rev_func_srv.WriteEmailFile("Verify.txt", sErrorHeader);
		}
		objEmail.Body = sErrorHeader;
//'		.isHTML = true
		objEmail.Send();

	
	rev_func_srv.LogInformation( xmlOut, msApp, "Response");
	xmlProc.ispXmlSetFieldVal(xmlReqDoc, gsDebugUp, "DEBUG", "", 0);

	rev_func_srv.WriteDebugFile(inAcctNo + "." + msApp + ".CHECK.debug.txt", 
			"<DEBUGINFO>" + VB.vbcrlf + "<REQUSET>"  + xmlProc.XMLToString(xmlReqDoc).Replace("<?xml version=\"1.0\"?>", "") + "</REQUSET>" 
			+ VB.vbcrlf + VB.vbcrlf + VB.vbcrlf + 
			"<RESPONSE>" + xmlProc.XMLToString(xmlOut).Replace( "<?xml version=\"1.0\"?>", "") + "</RESPONSE>" + VB.vbcrlf + "</DEBUGINFO>");

	
//'	WriteDebugFile inAcctNo & "." & msApp & ".CHECK.req.xml", xmlReqDoc.xml
//'	WriteDebugFile inAcctNo & "." & msApp & ".CHECK.resp.xml", xmlOut.xml
//'	WriteDebugFile inAcctNo & "." & msApp & ".CHECK.raw.req.txt", gsDebugUp
//'	WriteDebugFile inAcctNo & "." & msApp & ".CHECK.raw.resp.txt", gsDebug

//'	Session.Abandon
//'''>Rev1
}

ExitAsp();


    
%>




