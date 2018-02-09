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
    int iTry;
    string emi = string.Empty;
    string [] eta = new string[1];
    string wntl = string.Empty;
    
	//dim  sXMLData, lXML, lBufferArea, sConvert
	
    bool bLoop;
	string sma = VB.space(79);
    

	rev_func_srv.PopulateBuffer(xmlReqDoc, "ENTITY_INFO", emi);	
	rev_func_srv.PopulateBuffer(xmlReqDoc, "TAX_ACCT", eta);
	rev_func_srv.PopulateBuffer(xmlReqDoc, "WAGE_NTL", wntl);


	bLoop = false;
	iTry = 0;
	do
    {

		bool a = objCouponForm.RTTIE016(ref sma, ref emi, ref eta, ref wntl);


		if(objCouponForm.ErrorNumber == 148 )
        {
		}
		else if( objCouponForm.ErrorNumber != 0 || objCouponForm.ErrorMessage != "") 
        {
			rev_func_srv.DoError( "PayCouponRecv.asp", "5010003:" + objCouponForm.ErrorNumber, 
					"", "SAG: " + objCouponForm.ErrorMessage, xmlOut, msApp);
					
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


	if(iTry == 5 )
    {
		rev_func_srv.DoError("PayCouponRecv.asp", "5010004", "", 
				"SAG: Mainframe is busy, Submit again...", xmlOut, msApp);
	}
	
	if(objCouponForm.ErrorNumber == 0)
    {
		rev_func_srv.PopulateXML("ERROR_INFO", sma, xmlOut, xmlOut);
		rev_func_srv.PopulateXML("ENTITY_INFO", emi, xmlOut, xmlOut);
		rev_func_srv.PopulateXML("TAX_ACCT", eta, xmlOut, xmlOut);
		rev_func_srv.PopulateXML("WAGE_NTL", wntl, xmlOut, xmlOut);
	}

	string sConvert = xmlProc.ispXmlGetFieldVal(xmlOut, "ENTITY_INFO NAME", "", 0);
    sConvert = ispProperCase(sConvert);
	xmlProc.ispXmlSetFieldVal(xmlOut, sConvert, "ENTITY_INFO NAME", "", 0);

	sConvert = xmlProc.ispXmlGetFieldVal(xmlOut, "ENTITY_INFO ADDRESS1", "", 0);		
	sConvert = ispProperCase(sConvert);
	xmlProc.ispXmlSetFieldVal(xmlOut, sConvert, "ENTITY_INFO ADDRESS1", "", 0);

	sConvert = xmlProc.ispXmlGetFieldVal(xmlOut, "ENTITY_INFO ADDRESS2", "", 0);		
	sConvert = ispProperCase(sConvert);
	xmlProc.ispXmlSetFieldVal(xmlOut, sConvert, "ENTITY_INFO ADDRESS2", "", 0);

	sConvert = xmlProc.ispXmlGetFieldVal(xmlOut, "ENTITY_INFO ADDRESS3", "", 0);	
	sConvert = ispProperCase(sConvert);
	xmlProc.ispXmlSetFieldVal(xmlOut, sConvert, "ENTITY_INFO ADDRESS3", "", 0 );

	sConvert = xmlProc.ispXmlGetFieldVal(xmlOut, "ENTITY_INFO CITY", "", 0);			
	sConvert = ispProperCase(sConvert);
	xmlProc.ispXmlSetFieldVal(xmlOut, sConvert, "ENTITY_INFO CITY", "", 0);

	for(int i = 0; i< 198; i++)
    {
		sConvert = xmlProc.ispXmlGetFieldVal(xmlOut, "TAX_ACCT ACCOUNT", "", i);
		if(sConvert == "60")
        {
	 	   sConvert = xmlProc.ispXmlGetFieldVal(xmlOut, "TAX_ACCT BRT_ADDRESS1", "", i);			
		   sConvert = ispProperCase(sConvert);
		   xmlProc.ispXmlSetFieldVal(xmlOut, sConvert, "TAX_ACCT BRT_ADDRESS1", "", i);
		}
    }


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

dim a, i, j, k, lComplexNode, lSimpleNode, lStrExport, lStrTemp, lLen
dim xmlTmplDoc, xmlReqDoc, strBufferv,xmlOut
dim sma, emi, eta(), wntl
dim  objEmail, sConvert
    
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
rev_func_srv.CreateXmlBufferObj(xmlOut, util.GetXMLString(Server.MapPath("../xml/PayCoupon.xml")), false);


inAcctNo = xmlProc.ispXmlGetFieldVal(xmlReqDoc, "ENTITY_INFO ENTITY_ID", "", 0);


objCouponForm = (CopRevenueGov2.Service.EOL_CouponForm) VB.CreateObject("EOL.CouponForm");
if(objCouponForm == null)
{
	rev_func_srv.DoError("PayCouponRecv", "5010001", "", 
			"Object not loaded: 'EOL.CouponForm'", xmlOut, msApp);
}
objCouponForm.ServerAddress = CopMvcUtil.Session("SagAddress");


CallRttie016();

	if(xmlProc.ispXmlGetFieldVal(xmlOut, "ENTITY_INFO ENTITY_ID", "", 0) != "" )
    {
		Session["AccNum"] = xmlProc.ispXmlGetFieldVal(xmlOut, "ENTITY_INFO ENTITY_ID", "", 0);
    }
	else
    {
		xmlProc.ispXmlSetFieldVal(xmlOut, inAcctNo, "ENTITY_INFO ENTITY_ID", "", 0 );
		Session["AccNum"] = inAcctNo;
	}


	Response.Write(xmlProc.XMLToString(xmlOut));

	rev_func_srv.LogInformation(xmlOut, msApp, "Response");

	rev_func_srv.WriteDebugFile( CopMvcUtil.Session("AccNum") + "." + msApp + ".debug.txt", 
			"<DEBUGINFO>" + VB.vbCrLf + "<REQUSET>" + xmlProc.XMLToString(xmlReqDoc).Replace("<?xml version=\"1.0\"?>", "") + "</REQUSET>" 
			+ VB.vbCrLf + VB.vbCrLf + VB.vbCrLf + 
			"<RESPONSE>" +  xmlProc.XMLToString(xmlOut).Replace("<?xml version=\"1.0\"?>", "")  + "</RESPONSE>" + VB.vbCrLf + "</DEBUGINFO>";


ExitAsp();




%>


