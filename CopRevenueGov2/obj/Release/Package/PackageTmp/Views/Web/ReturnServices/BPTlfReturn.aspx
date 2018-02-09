﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<%@ Import Namespace="System.Xml" %>

<script runat="server">

    CopMvcUtil util = new CopMvcUtil();
    RevFuncSrv rev_func_srv = new RevFuncSrv();
    FuncSrv func_srv = new FuncSrv();
    XMLUtil xmlProc = new XMLUtil();


    string msApp = string.Empty;
    string inAcctNo = string.Empty;
    string sma = string.Empty;
    string info = string.Empty;
    string pg1 = string.Empty;
    string lsFunction = string.Empty;
    string scha = string.Empty;
    string schb = string.Empty;
    string schc1 = string.Empty;
    string schd = string.Empty;
    string sche = string.Empty;
    XmlDocument xmlReqDoc = new XmlDocument();
    XmlDocument xmlOut = new XmlDocument();
    XmlDocument xmlTmplDoc = new XmlDocument();
    CopRevenueGov2.Service.EOL_BPTlf objBPTReturn = new CopRevenueGov2.Service.EOL_BPTlf();
    CopRevenueGov2.Service.Persits_MailSender objEmail = null;
    XMLUtil xUtil = new XMLUtil();
    string mSession_RmtAdd = string.Empty;
    CString sErrorHeader = string.Empty;
    CString gsDebug = string.Empty;
    CString sTemp = string.Empty;
    CString echk = string.Empty;
    string gsDebugUp = string.Empty;
    bool a;
    int i, j, k, lComplexNode, lSimpleNode, lStrExport, lStrTemp, lLen;


    //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    void ExitAsp()
    {

        objBPTReturn = null;
        objEmail = null;
        xmlOut = null;
        xmlTmplDoc = null;
        xmlReqDoc = null;

        Response.End();
    }
    void CallRttie030()
    {
        xmlOut = RTTIE030.CallService(xmlReqDoc);
        xmlProc.ispXmlSetFieldVal(xmlOut, gsDebug, "DEBUG", "", 0);
        Response.Write(xmlProc.XMLToString(xmlOut));
    }


    //void CallRttie030()
    //{
    //    sma = VB.space(79);

        
    //    rev_func_srv.PopulateBuffer(xmlReqDoc, "BPT_INFO",ref info);
    //    rev_func_srv.PopulateBuffer(xmlReqDoc, "BPT_PG1", ref pg1);
    //    rev_func_srv.PopulateBuffer(xmlReqDoc, "BPT_SCH_A", ref scha);
    //    rev_func_srv.PopulateBuffer(xmlReqDoc, "BPT_SCH_B", ref schb);
    //    rev_func_srv.PopulateBuffer(xmlReqDoc, "BPT_SCH_C1",ref  schc1);
    //    rev_func_srv.PopulateBuffer(xmlReqDoc, "BPT_SCH_D", ref schd);
    //    rev_func_srv.PopulateBuffer(xmlReqDoc, "BPT_SCH_E", ref sche);
    //    bool bLoop = false;
    //    int iTry = 0;
    //    do
    //    {
    //        a = objBPTReturn.RTTIE030(ref sma, ref info, ref pg1, ref scha, ref schb, ref schc1, ref schd, ref sche);
    //        if (objBPTReturn.ErrorNumber == 148)
    //        {
    //        }
    //        else if (objBPTReturn.ErrorNumber != 0)
    //        {
    //            rev_func_srv.DoError("BPTlfReturn", "5030003", "", "SAG: ", xmlOut, msApp);
    //            bLoop = true;

    //        }
    //        else
    //        {
    //            bLoop = true;
    //            iTry = 0;
    //        }

    //        iTry = iTry + 1;
    //    } while (bLoop != true && iTry != 5);

    //    if (iTry == 5)
    //    {
    //        rev_func_srv.DoError("BPTlfReturn", "5030004", "",
    //                "SAG: Mainframe is busy, Submit again...", xmlOut, msApp);
    //    }

    //    if (objBPTReturn.ErrorNumber == 0)
    //    {
    //        rev_func_srv.PopulateXML("ERROR_INFO", sma, xmlOut, ref xmlOut);
    //        rev_func_srv.PopulateXML("BPT_INFO", info, xmlOut, ref xmlOut);
    //        rev_func_srv.PopulateXML("BPT_PG1", pg1, xmlOut, ref xmlOut);
    //        rev_func_srv.PopulateXML("BPT_SCH_A", scha, xmlOut, ref xmlOut);
    //        rev_func_srv.PopulateXML("BPT_SCH_B", schb, xmlOut, ref xmlOut);
    //        rev_func_srv.PopulateXML("BPT_SCH_C1", schc1, xmlOut, ref xmlOut);
    //        rev_func_srv.PopulateXML("BPT_SCH_D", schd, xmlOut, ref xmlOut);
    //        rev_func_srv.PopulateXML("BPT_SCH_E", sche, xmlOut, ref xmlOut);
    //    }

    //    xmlProc.ispXmlSetFieldVal(xmlOut, sma + info + pg1 + scha + schb + schc1 + schd + sche, "DEBUG", "", 0);
    //    Response.Write(xmlProc.XMLToString(xmlOut));
    //}
    public void WR_PopulateBuffer(XmlDocument oXML, string sSection, object vData)
    {
        string liSectCounter = string.Empty;
        XmlDocument lTmplXML = new XmlDocument();
        lTmplXML.LoadXml(xUtil.ispXmlGetRecordXml(oXML, sSection, 0));
        liSectCounter = xUtil.ispXmlGetRecCount(oXML, sSection, "");
        if (lTmplXML.DocumentElement.GetAttributeNode("OCCURS") != null)
        {
            int count = 0;
            string sTemp = string.Empty;
            string sData = string.Empty;
            string lYear = string.Empty, lMonth = string.Empty, lDay = string.Empty;
            int dataLength = 0;
            if (lTmplXML.DocumentElement.GetAttributeNode("LENGTH") != null)
            {
                int.TryParse(lTmplXML.DocumentElement.GetAttributeNode("LENGTH").InnerText, out dataLength);
            }

            int.TryParse(lTmplXML.DocumentElement.GetAttributeNode("OCCURS").InnerText, out count);
            if (count > 0)
            {
                for (int j = 0; j < count; j++)
                {
                    sTemp = string.Empty;
                    sData = string.Empty;
                    int sectcounter = 0;
                    int.TryParse(liSectCounter, out sectcounter);

                    if (j >= sectcounter)
                    {
                        sData = sData + VB.space(dataLength);
                    }
                    else
                    {
                        for (int k = 0; k < lTmplXML.DocumentElement.ChildNodes.Count; k++)
                        {
                            XmlNode lChildNode = lTmplXML.DocumentElement.ChildNodes.Item(k);
                            int.TryParse(lChildNode.Attributes.GetNamedItem("LENGTH").InnerText, out dataLength);
                            sTemp = oXML.DocumentElement.GetElementsByTagName(sSection).Item(j).ChildNodes.Item(k).InnerText.Trim().ToUpper();
                            if (lChildNode.Attributes.GetNamedItem("TYPE").InnerText == "N")
                            {
                                sData = sData + new String('0', dataLength - VB.len(sTemp)) + sTemp;
                            }
                            else if (lChildNode.Attributes.GetNamedItem("TYPE").InnerText == "C")
                            {
                                if (VB.IsNumeric(sTemp))
                                {
                                    sTemp = sTemp.Replace(".", "");
                                    sTemp = sTemp.Replace(",", "");
                                    sTemp = sTemp.Replace("$", "");
                                    sTemp = VB.mid(VB.FormatCurrency(sTemp, 2), 0);
                                }
                                sData = sData + new String('0', dataLength - VB.len(sTemp)) + sTemp;
                                sData = sData + sTemp + VB.space(dataLength - VB.len(sTemp));
                            }
                            else if (lChildNode.Attributes.GetNamedItem("TYPE").InnerText == "D")
                            {
                                if (VB.IsDate(sTemp))
                                {
                                    DateTime Tempdate;
                                    DateTime.TryParse(sTemp, out Tempdate);
                                    lYear = AspUtils.Util.GetString(Tempdate.Year);
                                    lMonth = AspUtils.Util.GetString(Tempdate.Month);
                                    lDay = AspUtils.Util.GetString(Tempdate.Day);

                                    if (VB.len(lYear) < 4)
                                    {
                                        if (AspUtils.Util.GetInt(lYear) < 20)
                                        {
                                            lYear = "20" + lYear;
                                        }
                                        else
                                        {
                                            lYear = "19" + lYear;
                                        }

                                        if (VB.len(lMonth) < 2)
                                        {
                                            lMonth = "0" + lMonth;
                                        }

                                        if (VB.len(lDay) < 2)
                                        {
                                            lDay = "0" + lDay;
                                        }
                                        sTemp = lYear + lMonth + lDay;
                                    }
                                    else
                                    {
                                        sTemp = string.Empty;
                                    }
                                    sData = sData + sTemp + VB.space(dataLength - VB.len(sTemp));
                                }
                                else
                                {
                                    sData = sData + sTemp + VB.space(dataLength - VB.len(sTemp));
                                }
                            }
                        }
                        if (VB.IsArray(vData))
                        {
                            string[] tempData = (string[])vData;
                            string[] varray = new string[tempData.Length];

                            tempData.CopyTo(varray, 0);
                            gsDebugUp = gsDebugUp + sData;
                            varray[j] = sData;
                            vData = varray;
                        }
                        else
                        {
                            gsDebugUp = gsDebugUp + sData;
                            vData = sData;
                        }
                    }
                }
            }
        }
    }



</script>

<%

    Response.CacheControl = "no-cache";
    Response.AddHeader("Pragma", "no-cache");
    Response.Expires = 0;
    Response.ContentType = "text/xml";

    msApp = "BPTlf";
    mSession_RmtAdd = CopMvcUtil.GetString(Request.ServerVariables["REMOTE_ADDR"]);

    rev_func_srv.CreateXmlBufferObj(xmlOut, util.GetXMLString(Server.MapPath("~/Views/Web/XML/BPTlfReturn.xml")), false);
    rev_func_srv.CreateXmlBufferObj(xmlReqDoc, util.GetXMLString(Request), false);

    inAcctNo = xmlProc.ispXmlGetFieldVal(xmlReqDoc, "BPT_INFO/ACCOUNT_ID", "", 0);
    lsFunction = xmlProc.ispXmlGetFieldVal(xmlReqDoc, "BPT_INFO/RETURN_STATUS", "", 0);

    objBPTReturn = (CopRevenueGov2.Service.EOL_BPTlf)VB.CreateObject("EOL.BPTlf");

    if (objBPTReturn == null)
    {
        rev_func_srv.DoError("BPTlfReturn", "5030001", "",
                "Object not loaded: 'EOL.BPTezForm'", xmlOut, msApp);
    }

    objBPTReturn.ServerAddress = CopMvcUtil.GetString(Session["SagAddress"]);

    CallRttie030();

    if (xmlProc.ispXmlGetFieldVal(xmlOut, "BPT_INFO/ACCOUNT_ID", "", 0) != "")
    {

        xmlProc.ispXmlSetFieldVal(xmlOut, inAcctNo.ToString(), "BPT_INFO/ACCOUNT_ID", "", 0);
    }

    xmlProc.ispXmlSetFieldVal(xmlOut, lsFunction, "BPT_INFO/RETURN_STATUS", "", 0);
    rev_func_srv.LogInformation(xmlOut, msApp, "Response");
    xmlProc.ispXmlSetFieldVal(xmlReqDoc, gsDebugUp, "DEBUG", "", 0);
    rev_func_srv.WriteDebugFile(CopMvcUtil.Session("AccNum") + "." + msApp + ".debug.txt",
            "<DEBUGINFO>" + VB.vbcrlf + "<REQUSET>" + xmlProc.XMLToString(xmlReqDoc).Replace("<?xml version=\"1.0\"?>", "") + "</REQUSET>"
            + VB.vbcrlf + VB.vbcrlf + VB.vbcrlf +
            "<RESPONSE>" + xmlProc.XMLToString(xmlOut).Replace("<?xml version=\"1.0\"?>", "") + "</RESPONSE>" + VB.vbcrlf + "</DEBUGINFO>");



    ExitAsp();


    
%>




