using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Xml;
using System.Net.Mail;
using System.Text;
using AspUtils;

namespace CopRevenueGov2.Helpers
{


    public class RevFuncSrv
    {

        XMLUtil xUtil = new XMLUtil();
        //'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        public void CreateXmlBufferObj(XmlDocument objXML, string xmlData, bool bAsnyc)
        {
            //objXML.async = bAsnyc;
            if (!string.IsNullOrEmpty(xmlData))
            {
                objXML.LoadXml(xmlData);
            }
            objXML = new XmlDocument();
            
        }
        //'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        public string Pad0(string sInput)
        {
            string output = string.Empty;
            if (VB.len(sInput) == 1)
            {
                output = "0" + sInput;
            }
            else
            {
                output = sInput;
            }
            return output;
        }
        //'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        public void LogInformation(XmlDocument xmlObj, string sApp, string sStatus)
        {

            string sSystem = string.Empty, sEntityId = string.Empty, sTime = string.Empty, sMessage = string.Empty, sFunction = string.Empty, sFile = string.Empty, sDate = string.Empty;
            DateTime sCurrent = System.DateTime.Now;
            sDate = sCurrent.Year.ToString() + "-" + Pad0(sCurrent.Month.ToString()) + "-" + Pad0(sCurrent.Day.ToString());
            sTime = Pad0(sCurrent.Hour.ToString()) + ":" + Pad0(sCurrent.Minute.ToString()) + ":" + Pad0(sCurrent.Second.ToString());
            sSystem = COPSession.ENVIRONMENT;

            // sEntityId = inAcctNo;
            sMessage = xUtil.ispXmlGetFieldVal(xmlObj, "ERROR_INFO/MESSAGE", "", 0);
            if (sApp == "AI")
            {
                sFunction = xUtil.ispXmlGetFieldVal(xmlObj, "ENTITY_INFO/FUNCTION_CODE", "", 0);
            }
            else if (sApp == "SR")
            {
                sFunction = xUtil.ispXmlGetFieldVal(xmlObj, "SCHOOL_INFO/RETURN_STATUS", "", 0);
            }
            else if (sApp == "WR")
            {
                sFunction = xUtil.ispXmlGetFieldVal(xmlObj, "WAGE_INFO/RETURN_STATUS", "", 0);
            }

            if (sStatus.ToUpper() != "ERROR")
            {
                if (sApp == "AI")
                {
                    switch (sFunction)
                    {
                        case "I":
                            sMessage = "Inquire";
                            break;
                        case "A":
                            sMessage = "Add";
                            break;
                        case "U":
                            sMessage = "Update";
                            break;
                        case "2":
                            sMessage = "Generate Pin";
                            break;
                        case "3":
                            sMessage = "Change Pin";
                            break;
                        case "4":
                            sMessage = "Forgot Pin";
                            break;
                        default:
                            sMessage = "Inquire";
                            break;
                    }
                }
                else if (sApp == "WR" || sApp == "SR")
                {
                    if (sFunction == "INQ")
                    {
                        sMessage = "Inquire";
                    }
                    else
                    {
                        sMessage = "Add/Update";

                    }

                }
            }
            DateTime dtsdate;
            DateTime.TryParse(sDate, out dtsdate);

            WriteLogFile(dtsdate, " " + sEntityId + " , " + sTime + " , " + sApp + " , " + sStatus + " , " + sMessage + " , " + sFunction + " , " + sDate + " , " + sSystem + "  ");

        }
        //'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        public string CheckForSubDirectory(string sDirectory, string sInterval)
        {
             /*
            'sDirectory - the parent directory's currently are LOG, EMAIL or DEBUG
            'sInterval  - M for Monthly, D for Daily
            'Returns    - The current path for files
             */

            string sCurrentdate = string.Empty;
            DateTime sDate = System.DateTime.Now;
            if (sInterval.ToUpper() == "D")
            {
                sCurrentdate = sDate.Year.ToString() + Pad0(sDate.Month.ToString()) + Pad0(sDate.Day.ToString());
            }
            else if (sInterval.ToUpper() == "M")
            {
                sCurrentdate = sDate.Year.ToString() + Pad0(sDate.Month.ToString());
            }


            if (sDirectory.IndexOf(sCurrentdate) != -1)
            {

            }
            else
            {

                sDirectory = HttpContext.Current.Server.MapPath(sDirectory);

                sDirectory += @"\";
                sDirectory += sCurrentdate;

                DirectoryInfo f = Directory.CreateDirectory(sDirectory);
                sDirectory += @"\";
            }

            return sDirectory;

        }
        //'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        public void WriteLogFile(DateTime sDate, string sOutPut)
        {

            string LOG_PATH = CheckForSubDirectory(COPAppSettings.LOG_PATH, "M");
            DateTime tempDate;
            string lDate = string.Empty;

            tempDate = sDate.AddDays(-1);
            lDate = tempDate.Year.ToString() + "-" + Pad0(tempDate.Month.ToString()) + "-" + Pad0(tempDate.Day.ToString());

            if ((File.Exists(LOG_PATH + lDate + ".txt")))
            {
                SmtpClient smtpClient = new SmtpClient(COPSession.EMAIL_IP_ADDR);
                MailMessage mailMsg = new MailMessage();

                string[] arrToAdd;
                string[] arrCCAdd;

                if (!string.IsNullOrEmpty(COPSession.EMAIL_LOG_TO))
                {
                    arrToAdd = COPSession.EMAIL_LOG_TO.Split(',');
                    foreach (string item in arrToAdd)
                    {
                        mailMsg.To.Add(item);
                    }
                }
                if ( !string.IsNullOrEmpty(COPSession.EMAIL_LOG_CC))
                {
                    arrCCAdd = COPSession.EMAIL_LOG_CC.Split(',');
                    foreach (string item in arrCCAdd)
                    {
                        mailMsg.CC.Add(item);
                    }

                }
                if (mailMsg.To.Count > 0)
                {
                    mailMsg.Subject = "Revenue Web Log";
                    mailMsg.Body = "Log file is attached...";
                    Attachment attachFile = new Attachment(LOG_PATH + lDate + ".txt");
                    mailMsg.Attachments.Add(attachFile);
                    smtpClient.Send(mailMsg);
                }
            }

            if (File.Exists(LOG_PATH + lDate + ".txt"))
            {
                using (StreamWriter sw = File.AppendText(LOG_PATH + lDate + ".txt"))
                {
                    sw.WriteLine(sOutPut);
                }
            }

        }
        //'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        public void WriteDebugFile(string sFileName, string sOutPut)
        {
            string sTemp = string.Empty;
            string strFileToSend = string.Empty;
            string DEBUG_PATH = CheckForSubDirectory(COPAppSettings.DEBUG_PATH, "D");
            if (COPSession.DEBUG)
            {
                sTemp = System.DateTime.Now.ToLongDateString().Replace(":", "");
                sTemp = sTemp.Replace(" ", "");
                sFileName = COPSession.ENVIRONMENT + sFileName.Replace(".", "-" + sTemp + ".");
                strFileToSend = DEBUG_PATH + sFileName;
                using (StreamWriter sw = File.CreateText(strFileToSend))
                {
                    sw.WriteLine(sOutPut);
                }
            }
        }
        //'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        public string WriteEmailFile(string sFileName, string sOutPut)
        {
            
            string sTemp = string.Empty;
            string strFileToSend = string.Empty;
            string EMAIL_PATH = CheckForSubDirectory(COPAppSettings.EMAIL_PATH, "M");
            sTemp = System.DateTime.Now.ToLongDateString().Replace(":", "");
            sTemp = sTemp.Replace(" ", "");
            sFileName = COPSession.ENVIRONMENT + sFileName.Replace(".", "-" + sTemp + ".");
            strFileToSend = EMAIL_PATH.Replace("I:", @"\\Isp_Domain_nt\data") + sFileName;
            using (StreamWriter sw = File.CreateText(strFileToSend))
            {
                sw.WriteLine(sOutPut);
                sw.Close();                
            }

            return strFileToSend;
        }
        //'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        public void PopulateBuffer(XmlDocument oXML, string sSection, ref string vData)
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
                    dataLength = CopMvcUtil.GetInt(lTmplXML.DocumentElement.GetAttributeNode("LENGTH").InnerText);
                }

                count = CopMvcUtil.GetInt(lTmplXML.DocumentElement.GetAttributeNode("OCCURS").InnerText);
                if (count > 0)
                {
                    for (int j = 0; j < count; j++)
                    {
                        sTemp = string.Empty;
                        sData = string.Empty;
                        int sectcounter = CopMvcUtil.GetInt(liSectCounter);

                        if (j >= sectcounter)
                        {
                            sData +=  VB.space(dataLength);
                        }
                        else
                        {
                            for (int k = 0; k < lTmplXML.DocumentElement.ChildNodes.Count; k++)
                            {
                                XmlNode lChildNode = lTmplXML.DocumentElement.ChildNodes.Item(k);
                                int len_lChild = CopMvcUtil.GetInt(lChildNode.Attributes.GetNamedItem("LENGTH").InnerText);
                                sTemp = oXML.DocumentElement.GetElementsByTagName(sSection).Item(j).ChildNodes.Item(k).InnerText.Trim().ToUpper();
                                if (lChildNode.Attributes.GetNamedItem("TYPE").InnerText == "N")
                                {
                                    sData = sData + new string('0', len_lChild - VB.len(sTemp)) + sTemp;
                                }
                                else if (lChildNode.Attributes.GetNamedItem("TYPE").InnerText == "C")
                                {
   
                                        sTemp = sTemp.Replace(".", "");
                                        sTemp = sTemp.Replace(",", "");
                                        sTemp = sTemp.Replace("$", "");

                                        sData = sData + new string('0', len_lChild - VB.len(sTemp)) + sTemp;
     
                                }
                                else if (lChildNode.Attributes.GetNamedItem("TYPE").InnerText == "D")
                                {
                                    if (VB.IsDate(sTemp))
                                    {
                                        DateTime Tempdate = CopMvcUtil.GetDate(sTemp);

                                        lYear = CopMvcUtil.GetString(Tempdate.Year);
                                        lMonth = CopMvcUtil.GetString(Tempdate.Month);
                                        lDay = CopMvcUtil.GetString(Tempdate.Day);

                                        if (VB.len(lYear) < 4)
                                        {
                                            if (CopMvcUtil.GetInt(lYear) < 20)
                                            {
                                                lYear = "20" + lYear;
                                            }
                                            else
                                            {
                                                lYear = "19" + lYear;
                                            }
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
                                    sData = sData + sTemp + VB.space(len_lChild - VB.len(sTemp));
                                }
                                else
                                {
                                    sData = sData + sTemp + VB.space(len_lChild - VB.len(sTemp));
                                }

                            }
                        }
                        vData = sData;
                    }
                }
            }
        }

        //'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        public void PopulateBuffer(XmlDocument oXML, string sSection, ref string[] vData)
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
                    dataLength = CopMvcUtil.GetInt(lTmplXML.DocumentElement.GetAttributeNode("LENGTH").InnerText);
                }

                count = CopMvcUtil.GetInt(lTmplXML.DocumentElement.GetAttributeNode("OCCURS").InnerText);
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
                                int len_lChild = CopMvcUtil.GetInt(lChildNode.Attributes.GetNamedItem("LENGTH").InnerText);
                                sTemp = oXML.DocumentElement.GetElementsByTagName(sSection).Item(j).ChildNodes.Item(k).InnerText.Trim().ToUpper();
                                if (lChildNode.Attributes.GetNamedItem("TYPE").InnerText == "N")
                                {
                                    sData = sData + new string('0', len_lChild - VB.len(sTemp)) + sTemp;
                                }
                                else if (lChildNode.Attributes.GetNamedItem("TYPE").InnerText == "C")
                                {
                                    sTemp = sTemp.Replace(".", "");
                                    sTemp = sTemp.Replace(",", "");
                                    sTemp = sTemp.Replace("$", "");

                                    sData = sData + new string('0', len_lChild - VB.len(sTemp)) + sTemp;
                                }
                                else if (lChildNode.Attributes.GetNamedItem("TYPE").InnerText == "D")
                                {
                                    if (VB.IsDate(sTemp))
                                    {
                                        DateTime Tempdate;
                                        DateTime.TryParse(sTemp, out Tempdate);
                                        lYear = CopMvcUtil.GetString(Tempdate.Year);
                                        lMonth = CopMvcUtil.GetString(Tempdate.Month);
                                        lDay = CopMvcUtil.GetString(Tempdate.Day);

                                        if (VB.len(lYear) < 4)
                                        {
                                            if (CopMvcUtil.GetInt(lYear) < 20)
                                            {
                                                lYear = "20" + lYear;
                                            }
                                            else
                                            {
                                                lYear = "19" + lYear;
                                            }
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
                                    sData = sData + sTemp + VB.space(len_lChild - VB.len(sTemp));
                                }
                                else
                                {
                                    sData = sData + sTemp + VB.space(len_lChild - VB.len(sTemp));
                                }
                            }
                        }

                        WriteDebugFile("VALUE_IF_J.txt", j.ToString());

                        string[] varray = new string[j+1];

                        if (vData != null && vData.Length > 0)
                        {
                            if (vData.Length > varray.Length)
                            {
                                for (int i = 0; i < varray.Length; i++)
                                {
                                    varray[i] = vData[i];
                                }
                            }
                            else
                            {
                                vData.CopyTo(varray, 0);
                            }
                        }
                        varray[j] = sData;
                        vData = varray;
                    }
                }
            }
        }

        //'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        public void PopulateBuffer(XmlDocument oXML, string sSection, object vData, ref string gsDebugUp) //Overloaded
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

                                    sData = sData + new string('0', dataLength - VB.len(sTemp)) + sTemp;
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
                                    sData = sData + new string('0', dataLength - VB.len(sTemp)) + sTemp;
                                    sData = sData + sTemp + VB.space(dataLength - VB.len(sTemp));
                                }
                                else if (lChildNode.Attributes.GetNamedItem("TYPE").InnerText == "D")
                                {
                                    if (VB.IsDate(sTemp))
                                    {
                                        DateTime Tempdate;
                                        DateTime.TryParse(sTemp, out Tempdate);
                                        lYear = Util.GetString(Tempdate.Year);
                                        lMonth = Util.GetString(Tempdate.Month);
                                        lDay = Util.GetString(Tempdate.Day);

                                        if (VB.len(lYear) < 4)
                                        {
                                            if (Util.GetInt(lYear) < 20)
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

        //'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        public void PopulateXML(string sSection, object vData, XmlDocument oTmplXML, ref XmlDocument oDataXML)
        {
            string[] lData = null;
            int iCounter = 0;
            int lStrLen = 0, lTotalStrLen = 0, lStrLenSum = 0;
            XmlNode lChildNode = null;
            int lPercision = 0;
            XmlDocument lobjXML = new XmlDocument();
            lobjXML.LoadXml(xUtil.ispXmlGetRecordXml(oTmplXML, sSection, 0));
            if (VB.IsArray(vData))
            {

                string[] tempData = (string[])vData;
                lData = new string[tempData.Length];
                for (int i = 0; i < tempData.Length; i++)
                {
                    lData[i] = tempData[i];
                }
            }
            else
            {
                lData = new string[1];
                lData[0] = vData.ToString();
            }

            iCounter = lData.Length;

            for (int i = 0; i < iCounter; i++)
            {
                lStrLenSum = 1;
                lTotalStrLen = VB.len(lData[i]);
                lData[i] = lData[i] + VB.space(Util.GetInt(lobjXML.DocumentElement.Attributes.GetNamedItem("LENGTH").InnerText) - VB.len(lData[i]));
                for (int j = 0; j < lobjXML.DocumentElement.ChildNodes.Count; j++)
                {
                    lChildNode = lobjXML.DocumentElement.ChildNodes.Item(j);
                    lChildNode.InnerText = string.Empty;
                }
                if (lTotalStrLen > 0)
                {
                    for (int j = 0; j < lobjXML.DocumentElement.ChildNodes.Count; j++)
                    {
                        lChildNode = lobjXML.DocumentElement.ChildNodes.Item(j);
                        lStrLen = Util.GetInt(lChildNode.Attributes.GetNamedItem("LENGTH").InnerText);
                        lChildNode.InnerText = VB.mid(lData[i], lStrLenSum, lStrLen).Trim();
                        if (lChildNode.Attributes.GetNamedItem("TYPE").InnerText == "N" && VB.IsNumeric(lChildNode.InnerText))
                        {
                            if (lChildNode.Attributes.GetNamedItem("PERCISION") != null)
                            {
                                lPercision = Util.GetInt(lChildNode.Attributes.GetNamedItem("PERCISION").InnerText);
                                lChildNode.InnerText = Util.GetString(VB.CDbl(VB.Left(lChildNode.InnerText, lStrLen - lPercision) + "." + VB.Right(lChildNode.InnerText, lPercision)));
                            }
                            else
                            {
                                lChildNode.InnerText = Util.GetString(VB.CDbl(lChildNode.InnerText));
                            }
                        }
                        else if (lChildNode.Attributes.GetNamedItem("TYPE").InnerText == "D")
                        {
                            if (VB.CSng(lChildNode.InnerText) == 0)
                            {
                                lChildNode.InnerText = string.Empty;
                            }
                            else
                            {
                                lChildNode.InnerText = VB.FormatDate(lChildNode.InnerText);
                            }
                        }
                        else if (lChildNode.Attributes.GetNamedItem("TYPE").InnerText == "C")
                        {

                            if (VB.instr(1, lChildNode.InnerText, "-") != 0)
                            {
                                lChildNode.InnerText = lChildNode.InnerText.Replace("-", "");
                                lChildNode.InnerText = "-" + lChildNode.InnerText;
                            }
                            if (VB.CSng(lChildNode.InnerText) == 0)
                            {
                                lChildNode.InnerText = string.Empty;
                            }
                            else
                            {
                                if (VB.instr(1, lChildNode.InnerText, "-") != 0)
                                {
                                    lChildNode.InnerText = VB.Left(lChildNode.InnerText, lStrLen - 2) + "." + VB.Right(lChildNode.InnerText, 2);
                                }
                                lChildNode.InnerText = VB.FormatCurrency(lChildNode.InnerText, 2);
                            }

                        }
                        else if (lChildNode.Attributes.GetNamedItem("TYPE").InnerText == "P" && VB.IsNumeric(lChildNode.InnerText))
                        {
                            if (VB.CSng(lChildNode.InnerText) == 0)
                            {
                                lChildNode.InnerText = string.Empty;
                            }
                            else
                            {
                                lChildNode.InnerText = CopMvcUtil.GetString(VB.Clng(lChildNode.InnerText));
                            }
                        }
                        lStrLenSum = lStrLenSum + lStrLen;

                    }

                }
                if ((lTotalStrLen == 0 && i == 0) || lTotalStrLen != 0)
                {
                    if (i == 0)
                    {
                        xUtil.ispXmlReplaceNode(ref oDataXML, sSection, i, lobjXML, sSection, i);

                    }
                    else
                    {
                        xUtil.ispAppendNodeXml(ref oDataXML, "*", 0, lobjXML, sSection, 0);
                    }
                }
            }

        }
        //'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        public void DoError(string sProgram, string sErrorNo, string sLine, string sMessage, XmlDocument xmlObj, string sApp)
        {
            string inAcctNo = string.Empty;
            string[] temp = null;
            string sTemp = string.Empty;
            string sErrorHeader = string.Empty;
            if (!string.IsNullOrEmpty(inAcctNo))
            {
                inAcctNo = "9999999";
            }
            xUtil.ispXmlSetFieldVal(xmlObj, sProgram, "ERROR_INFO/PROGRAM", "", 0);
            xUtil.ispXmlSetFieldVal(xmlObj, sErrorNo, "ERROR_INFO/ERROR", "", 0);
            xUtil.ispXmlSetFieldVal(xmlObj, sLine, "ERROR_INFO/LINE", "", 0);
            xUtil.ispXmlSetFieldVal(xmlObj, sMessage, "ERROR_INFO/MESSAGE", "", 0);
            LogInformation(xmlObj, sApp, "Error");

            Service.Persits_MailSender objEmail = new Service.Persits_MailSender();
            if (objEmail == null)
            {
                xUtil.ispXmlSetFieldVal(xmlObj, sProgram, "ERROR_INFO/PROGRAM", "", 0);
                xUtil.ispXmlSetFieldVal(xmlObj, "5010002", "ERROR_INFO/ERROR", "", 0);
                xUtil.ispXmlSetFieldVal(xmlObj, sLine, "ERROR_INFO/LINE", "", 0);
                xUtil.ispXmlSetFieldVal(xmlObj, "Object not loaded: 'Persits.MailSender'", "ERROR_INFO/MESSAGE", "", 0);

                LogInformation(xmlObj, sApp, "Error");

            }
            else
            {
                objEmail.Host = CopRevenueGov2.Helpers.CopMvcUtil.GetSession("EMAIL_IP_ADDR");
                objEmail.From = CopRevenueGov2.Helpers.CopMvcUtil.GetSession("EMAIL_FROM");
                temp = CopRevenueGov2.Helpers.CopMvcUtil.GetSession("EMAIL_ERROR_TO").Split(',');
                foreach (string add in temp)
                {
                    objEmail.AddAddress(add);

                }
                temp = CopRevenueGov2.Helpers.CopMvcUtil.GetSession("EMAIL_ERROR_CC").Split(',');
                foreach (string add in temp)
                {
                    objEmail.AddCC(add);

                }
                objEmail.Subject = "Revenue Web Error - " + CopRevenueGov2.Helpers.CopMvcUtil.GetSession("ENVIRONMENT");
                sErrorHeader = sErrorHeader
                          + "Program: " + xUtil.ispXmlGetFieldVal(xmlObj, "ERROR_INFO/PROGRAM", "", 0) + "\r\n"
                           + "Error: " + xUtil.ispXmlGetFieldVal(xmlObj, "ERROR_INFO/ERROR", "", 0) + "\r\n"
                           + "Line: " + xUtil.ispXmlGetFieldVal(xmlObj, "ERROR_INFO/LINE", "", 0) + "\r\n"
                           + "Message: " + xUtil.ispXmlGetFieldVal(xmlObj, "ERROR_INFO/MESSAGE", "", 0);
                objEmail.Body = sErrorHeader;
                sTemp = WriteEmailFile("Error.txt", sErrorHeader);
                objEmail.Send();
            }

            /* // Commented for the time being as it is not clear where to declare the objects   xmlReqDoc , xmlObj ,gsDebugUp and gsDebug 
             
            WriteDebugFile(inAcctNo + "." + sApp + ".ERROR.req.xml", xmlReqDoc.InnerXml.ToString());
            WriteDebugFile(inAcctNo + "." + sApp + ".ERROR.resp.xml", xmlObj.InnerXml.ToString());
            WriteDebugFile(inAcctNo + "." + sApp + ".ERROR.raw.req.txt", gsDebugUp);
            WriteDebugFile(inAcctNo + "." + sApp + ".ERROR.raw.resp.txt", gsDebug);
            */


            // "System is busy... Please try again, if continues please try later.", _


            xUtil.ispXmlSetFieldVal(xmlObj, "System is busy... Please try again, If still not successful, please try later.", "ERROR_INFO/MESSAGE", "", 0);
            HttpContext.Current.Response.Write(xmlObj.InnerXml.ToString());

        }
    }
}