﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<%@ Import Namespace="System.Xml" %>



<script runat="server">

    CopMvcUtil util = new CopMvcUtil();
    RevFuncSrv rev_func_srv = new RevFuncSrv();
    FuncSrv func_srv = new FuncSrv();
    XMLUtil xmlProc = new XMLUtil();
  

    string msApp = string.Empty;
    string lsEntityType = string.Empty;
    string sma = string.Empty;
    string emi = string.Empty;
    string[] eta;
    string lsEntityNo = string.Empty;
    XmlDocument xmlReqDoc = new XmlDocument();
    XmlDocument xmlOut = new XmlDocument();
    XmlDocument xmlTmplDoc = new XmlDocument();
    XmlDocument lobjXML = new XmlDocument();
    CopRevenueGov2.Service.EOL_DelinquentForm objAcctBalanceCall = new CopRevenueGov2.Service.EOL_DelinquentForm();
    CopRevenueGov2.Service.Persits_MailSender objEmail = null;
    XMLUtil xUtil = new XMLUtil();
    string mSession_RmtAdd = string.Empty;
    CString sErrorHeader = string.Empty;
    CString gsDebug = string.Empty;
    string sTemp = string.Empty;
    CString echk = string.Empty;
    string gsDebugUp = string.Empty;
    bool a;
    int i, j, k, lComplexNode, lSimpleNode, lStrExport, lStrTemp, lLen;
    string[] aRow;
    string[] aCol;


    //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    void ExitAsp()
    {

        objAcctBalanceCall = null;
        objEmail = null;
        xmlOut = null;
        xmlTmplDoc = null;
        xmlReqDoc = null;

        Response.End();
        Response.Flush();
        Response.Clear();

    }


    void CallRttie022()
    {
        sma = VB.space(79);
        rev_func_srv.PopulateBuffer(xmlReqDoc, "DEL_INFO", emi, ref gsDebugUp);
        rev_func_srv.PopulateBuffer(xmlReqDoc, "DEL_ACCT", eta, ref gsDebugUp);
        bool bLoop = false;
        int iTry = 0;
        do
        {
            a = objAcctBalanceCall.RTTIE022(ref sma, ref emi, ref eta);
            if (objAcctBalanceCall.ErrorNumber == 148)
            {
            }
            else if (objAcctBalanceCall.ErrorNumber != 0)
            {
                rev_func_srv.DoError("AccountBalanceCall", "5030003", "", "SAG: ", xmlOut, msApp);
                bLoop = true;

            }
            else
            {
                bLoop = true;
                iTry = 0;
            }

            iTry = iTry + 1;
        } while (bLoop == true || iTry <= 5);

        if (iTry == 5)
        {
            rev_func_srv.DoError("AccountBalanceCall", "5030004", "",
                    "SAG: Mainframe is busy, Submit again...", xmlOut, msApp);
        }

        if (objAcctBalanceCall.ErrorNumber == 0)
        {


            rev_func_srv.PopulateXML("ERROR_INFO", sma, xmlOut, xmlOut);
            rev_func_srv.PopulateXML("DEL_INFO", emi, xmlOut, xmlOut);
            rev_func_srv.PopulateXML("DEL_ACCT", eta, xmlOut, xmlOut);

        }

        xmlProc.ispXmlSetFieldVal(xmlOut, gsDebug, "DEBUG", "", 0);
        Response.Write(xmlProc.XMLToString(xmlOut));
    }
   



</script>

<%

    Response.CacheControl = "no-cache";
    Response.AddHeader("Pragma", "no-cache");
    Response.Expires = 0;
    Response.ContentType = "text/xml";

    msApp = "AB";
    mSession_RmtAdd = CopMvcUtil.GetString(Request.ServerVariables["REMOTE_ADDR"]);

    rev_func_srv.CreateXmlBufferObj(xmlOut, util.GetXMLString(Server.MapPath("../xml/DelinquentForm")), false);
    rev_func_srv.CreateXmlBufferObj(xmlReqDoc, util.GetXMLString(Request), false);

    sTemp = xmlProc.ispXmlGetFieldVal(xmlReqDoc, "DEL_ACCT_DELIMITED", "", 0);
    aRow = sTemp.Split('|');
    
    for(int i = 0; i< aRow.Length;i++)
    {
	if( i > 0 )
    {
	    xUtil.ispAppendNodeXml(xmlReqDoc, "*", 0, lobjXML, "DEL_ACCT", 0);
	}
	
	aCol =  aRow[i].Split(':');  
	xmlProc.ispXmlSetFieldVal(xmlReqDoc, aCol[0], "DEL_ACCT/FUNCTION_CODE", "", i);
    xmlProc.ispXmlSetFieldVal(xmlReqDoc, aCol[1], "DEL_ACCT/ACCOUNT_TYPE", "", i);
    xmlProc.ispXmlSetFieldVal(xmlReqDoc, aCol[2], "DEL_ACCT/ACCOUNT_ID", "", i);
    xmlProc.ispXmlSetFieldVal(xmlReqDoc, aCol[3], "DEL_ACCT/PERIOD", "", i);
    xmlProc.ispXmlSetFieldVal(xmlReqDoc, aCol[4], "DEL_ACCT/PRINCIPAL_DUE", "", i);
    xmlProc.ispXmlSetFieldVal(xmlReqDoc, aCol[5], "DEL_ACCT/INTEREST_DUE", "", i);
    xmlProc.ispXmlSetFieldVal(xmlReqDoc, aCol[6], "DEL_ACCT/PENALTY_DUE", "", i);
    xmlProc.ispXmlSetFieldVal(xmlReqDoc, aCol[7], "DEL_ACCT/OTHER_DUE", "", i);
    xmlProc.ispXmlSetFieldVal(xmlReqDoc, aCol[8], "DEL_ACCT/BRT_ENTITY", "", i);
    xmlProc.ispXmlSetFieldVal(xmlReqDoc, aCol[9], "DEL_ACCT/BRT_ADDRESS", "", i);
    xmlProc.ispXmlSetFieldVal(xmlReqDoc, aCol[10], "DEL_ACCT/FILL", "", i);
    }

    lsEntityType = xmlProc.ispXmlGetFieldVal(xmlReqDoc, "DEL_INFO/ENTITY_TYPE", "", 0);
    lsEntityNo = xmlProc.ispXmlGetFieldVal(xmlReqDoc, "DEL_INFO/ENTITY_ID", "", 0);

    objAcctBalanceCall = (CopRevenueGov2.Service.EOL_DelinquentForm)VB.CreateObject("EOL.DelinquentForm");

    if (objAcctBalanceCall == null)
    {
        rev_func_srv.DoError("AccountBalanceCall", "5040001", "",
                "Object not loaded: 'EOL.DelinquentForm'", xmlOut, msApp);
    }
    else
    {
        objAcctBalanceCall.ServerAddress = CopMvcUtil.GetString(Session["SagAddress"]);

        CallRttie022();
    }

    if (xmlProc.ispXmlGetFieldVal(xmlOut, "DEL_INFO/ENTITY_ID", "", 0) != "")
    {
        xmlProc.ispXmlSetFieldVal(xmlOut, lsEntityNo, "DEL_INFO/ENTITY_ID", "", 0);
        xmlProc.ispXmlSetFieldVal(xmlOut, lsEntityType, "DEL_INFO/ENTITY_TYPE", "", 0);
      
    }

    if (Session["AccNum"] != null && !string.IsNullOrEmpty(Session["AccNum"].ToString()))
    {
        Session["AccNum"] = xmlProc.ispXmlGetFieldVal(xmlOut, "DEL_INFO/ENTITY_ID", "", 0);
    }

    rev_func_srv.LogInformation(xmlOut, msApp, "Response");
    xmlProc.ispXmlSetFieldVal(xmlReqDoc, gsDebugUp, "DEBUG", "", 0);
    rev_func_srv.WriteDebugFile(CopMvcUtil.Session("AccNum") + "." + msApp + ".debug.txt",
            "<DEBUGINFO>" + VB.vbcrlf + "<REQUSET>" + xmlProc.XMLToString(xmlReqDoc).Replace("<?xml version=\"1.0\"?>", "") + "</REQUSET>"
            + VB.vbcrlf + VB.vbcrlf + VB.vbcrlf +
            "<RESPONSE>" + xmlProc.XMLToString(xmlOut).Replace("<?xml version=\"1.0\"?>", "") + "</RESPONSE>" + VB.vbcrlf + "</DEBUGINFO>");



    ExitAsp();


    
%>




