<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ Import Namespace="System.Xml" %>
<script runat="server">

CopMvcUtil util = new CopMvcUtil();
RevFuncSrv rev_func_srv = new RevFuncSrv();
FuncSrv func_srv = new FuncSrv();
XMLUtil xmlProc = new XMLUtil();
string msApp= string.Empty;
CopRevenueGov2.Service.EOL_CouponForm objCouponForm = new CopRevenueGov2.Service.EOL_CouponForm();

string gsDebug, gsDebugUp;
 
XmlDocument xmlReqDoc = new XmlDocument();
XmlDocument xmlOut = new XmlDocument();
XmlDocument xmlTmplDoc = new XmlDocument();

void ExitAsp()
{
	objCouponForm = null;
	xmlOut = null;
	xmlTmplDoc = null;
	xmlReqDoc = null;

	Response.End();
}

void CallRttie016()
{
    xmlOut = RTTIE016.CallService(xmlReqDoc);
    xmlProc.ispXmlSetFieldVal(xmlOut, gsDebug, "DEBUG", "", 0); 
}


string ispProperCase(string val)
{
    string sTng;
    string [] vTmp;
    
    int i=0;
	
	if(val == "" )
    {
		sTng = val;
    }
	else
    {
		vTmp = val.Split(' ');
		sTng =  VB.Left(vTmp[0], 1).ToUpper();//  Ucase(left(Vtmp(0),1))
        
		if(vTmp[0].Length > 1 )
        {
			sTng = sTng + VB.mid(vTmp[0],2).ToLower();  //LCase(mid(vTmp(0),2))
		}
		
		for(i = 0; i < vTmp.Length; i++)
        {
			sTng = sTng + " " +  VB.mid(vTmp[i],1).ToUpper();  //    Ucase(left(vTmp(i),1))
			if(vTmp[i].Length > 1 )
            {
				sTng = sTng + VB.mid(vTmp[i],2).ToLower(); //LCase(Mid(vTmp(i),2))
			}
        }	
			
    }

    return sTng;
	
}


 </script>

<%
//'''Rev1 - ehd 3-12-03
//'''The following statements is for verifing that the website is up an running.
//'''It is used when the page is called from a VB Program - VerifyWeb 


    
string lFunctionCode, inAcctNo, outAcctNo, sErrorHeader, sTemp;
bool bCheck;


	Response.CacheControl = "no-cache";
	Response.AddHeader("Pragma", "no-cache");
	Response.Expires = 0;
	Response.ContentType = "text/xml";


msApp = "CP";


sErrorHeader = "PayCouponRecv.asp ran with the following error." + VB.vbcrlf +
			 "The program ran @ " + DateTime.Now.ToString() + VB.vbcrlf + VB.vbcrlf + VB.vbcrlf;
bCheck = false;

rev_func_srv.CreateXmlBufferObj(xmlReqDoc, util.GetString(Request), false);
rev_func_srv.CreateXmlBufferObj(xmlOut, util.GetXMLString(Server.MapPath(@"~/views/web/xml/PayCoupon.xml")), false);

inAcctNo = xmlProc.ispXmlGetFieldVal(xmlReqDoc,"ENTITY_INFO/ENTITY_ID","", 0);



if (objCouponForm == null)
{
    rev_func_srv.DoError("PayCouponRecv", "5010001", "",
            "Object not loaded: 'EOL.CouponForm'", xmlOut, msApp);
}
objCouponForm.ServerAddress = CopMvcUtil.Session("SagAddress");


CallRttie016();

	if(xmlProc.ispXmlGetFieldVal(xmlOut, "ENTITY_INFO/ENTITY_ID", "", 0) != "" )
    {
		Session["AccNum"] = xmlProc.ispXmlGetFieldVal(xmlOut, "ENTITY_INFO/ENTITY_ID", "", 0);
    }
	else
    {
		xmlProc.ispXmlSetFieldVal(xmlOut, inAcctNo, "ENTITY_INFO/ENTITY_ID", "", 0 );
		Session["AccNum"] = inAcctNo;
	}


	Response.Write(xmlProc.XMLToString(xmlOut));

	rev_func_srv.LogInformation(xmlOut, msApp, "Response");

	rev_func_srv.WriteDebugFile( CopMvcUtil.Session("AccNum") + "." + msApp + ".debug.txt", 
			"<DEBUGINFO>" + VB.vbCrLf + "<REQUSET>" + xmlProc.XMLToString(xmlReqDoc).Replace("<?xml version=\"1.0\"?>", "") + "</REQUSET>" 
			+ VB.vbCrLf + VB.vbCrLf + VB.vbCrLf + 
			"<RESPONSE>" +  xmlProc.XMLToString(xmlOut).Replace("<?xml version=\"1.0\"?>", "")  + "</RESPONSE>" + VB.vbCrLf + "</DEBUGINFO>");


ExitAsp();




%>


