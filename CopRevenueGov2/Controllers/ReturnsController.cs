using CopRevenueGov2.Helpers;
using CopRevenueGov2.Models.Web.Returns;
using NLog;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Xml;

namespace CopRevenueGov2.Controllers
{
    public class ReturnsController : COPBaseController
    {
        //
        // GET: /Returns/

        public ActionResult _12BIRTWrkShtN()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/_12BIRTWrkShtN.htm");
        }
        public ActionResult _13BIRTWrkShtN()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/13BIRTWrkShtN.htm");
        }
        public ActionResult _14BIRTWrkShtN()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/14BIRTWrkShtN.htm");
        }//binoy
        public ActionResult _12BIRT_19_3800Message()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/_12BIRT_19_3800Message.htm");
        }
        public ActionResult _13BIRT_19_3800Message()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/13BIRT_19_3800Message.htm");
        }
        public ActionResult _14BIRT_19_3800Message()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/14BIRT_19_3800Message.htm");
        }//binoy
        public ActionResult BPTez2003()
        {
            return View("~/Views/Web/Returns/BPTez2003.aspx");
        }

        public ActionResult BPTez2006()
        {
            return View("~/Views/Web/Returns/BPTez2006.aspx");
        }

        public ActionResult BPTez2007()
        {
            return View("~/Views/Web/Returns/BPTez2007.aspx");
        }

        public ActionResult BPTez2008()
        {
            return View("~/Views/Web/Returns/BPTez2008.aspx");
        }

        public ActionResult BPTez2009()
        {
            return View("~/Views/Web/Returns/BPTez2009.aspx");
        }

        public ActionResult BPTez2010()
        {            
            return View("~/Views/Web/Returns/BPTez2010New.aspx");
        }

        public ActionResult BPTez2011()
        {           
            return View("~/Views/Web/Returns/BPTez2011New.aspx");

        }

        public ActionResult BPTez2012()
        {            
            return View("~/Views/Web/Returns/BPTez2012New.aspx");
        }
        public ActionResult BPTez2013()
        {           
            return View("~/Views/Web/Returns/BPTez2013New.aspx");
        }
        public ActionResult BPTez2014()
        {           
            return View("~/Views/Web/Returns/BPTez2014.aspx");
        }
        public ActionResult BPTez2015()
        {           
            return View("~/Views/Web/Returns/BPTez2015New.aspx");
        }
        public ActionResult BPTez_WorkSheetSEZ_2015()
        {          
            return View("~/Views/Web/Returns/BPTez_WorkSheetSEZ_2015.aspx");
        }
        public ActionResult BPTez_WorkSheetSEZ_2014()
        {           
            return View("~/Views/Web/Returns/BPTez_WorkSheetSEZ_2014.aspx");
        }

        public ActionResult BPTez2016()
        {            
            return View("~/Views/Web/Returns/BPTez2016New.aspx");
        }
        public ActionResult BPTez2017()
        {
            return View("~/Views/Web/Returns/BPTez2017New.aspx");
        }
        public ActionResult BPTez_WorkSheetSEZ_2016()
        {           
            return View("~/Views/Web/Returns/BPTez_WorkSheetSEZ_2016.aspx");
        }
        public ActionResult BPTez_WorkSheetSEZ_2017()
        {
            return View("~/Views/Web/Returns/BPTez_WorkSheetSEZ_2017.aspx");
        }
      
        public ActionResult NPTThankYou(string id)
        {
            BPTezThankYouModel m = new BPTezThankYouModel() { sCurrentYear = id };
            return View("~/Views/Web/Returns/NPT/NPTThankYouNew.aspx", m);
        }

        public ActionResult BPTezThankYou(string id)
        {

            BPTezThankYouModel m = new BPTezThankYouModel() { sCurrentYear = id };           
            return View("~/Views/Web/Returns/BPTezThankYouNew.aspx", m);
        }

        public ActionResult BPTlf2009()
        {
            return View("~/Views/Web/Returns/BPTlf2009.aspx");
        }

        public ActionResult BPTlfThankYou()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/BPTlfThankYou.htm");
        }

        public ActionResult HelpPreviousPaidTax()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/HelpPreviousPaidTax.htm");
        }

        public ActionResult LossCarryForward(string acct,string sch,string id)
        {
            LassCarryForwardModel m = new LassCarryForwardModel() { 
                sCurrentYear = id,
                Sch=sch,
                account = acct
        };

            return View("~/Views/Web/Returns/LossCarryForward_dsNew.aspx",m);
        }

        public ActionResult LossCarryForwardfromBPT()
        {
           return View("~/Views/Web/Returns/LossCarryForward_fromBPT.aspx");
        }


        [HttpPost]
        public ActionResult Upload(string imageData,string AccountId,string Form)
        {
            string fname = string.Empty;
            //if (Request.Files.Count > 0)
            //{
            //    string fname = string.Empty;
            //    try
            //    {

            //        HttpFileCollectionBase files = Request.Files;
            //        for (int i = 0; i < files.Count; i++)
            //        {


            //            HttpPostedFileBase file = files[i];


            //            // Checking for Internet Explorer  
            //            if (Request.Browser.Browser.ToUpper() == "IE" || Request.Browser.Browser.ToUpper() == "INTERNETEXPLORER")
            //            {
            //                string[] testfiles = file.FileName.Split(new char[] { '\\' });
            //                fname = testfiles[testfiles.Length - 1];
            //            }
            //            else
            //            {
            //                fname = file.FileName;
            //            }


            //            fname = System.IO.Path.Combine(Server.MapPath("~/Content/Uploads/"), fname);
            //            file.SaveAs(fname);
            //        }

            //        return Json("File Uploaded Successfully!\n Click OK then Upload to submit another file or Close to exit.");

            //    }

            //    catch (Exception ex)
            //    {

            //        return Json("Error occurred. Error details: " + ex.Message);
            //    }

            //}
            //else
            //{
            //    return Json("No files selected.");
            //}
            
            fname = Form+"_"+AccountId+".png";
            fname = System.IO.Path.Combine(Server.MapPath("~/Content/Uploads/"), fname);
            //fname = @"C:\eGOVBarcodeWrite\" + fname;
            
            if (System.IO.File.Exists(fname))
            {
                System.IO.File.Delete(fname);
            }
            //string fileNameWitPath = path + DateTime.Now.ToString().Replace("/", "-").Replace(" ", "- ").Replace(":", "") + ".png";
            using (FileStream fs = new FileStream(fname, FileMode.Create))
            {
                using (BinaryWriter bw = new BinaryWriter(fs))
                {
                    byte[] data = Convert.FromBase64String(imageData);
                    bw.Write(data);
                    bw.Close();

                }
            }
           
            return Json("File Uploaded Successfully!\n Click OK then Upload to submit another file or Close to exit.");
        }



        [HttpPost]
        public ActionResult UploadScanLine(string imageData, string AccountId, string Form)
        {
            string fname = string.Empty;      
           
            
            fname = Form+"_ScanLine_"+AccountId+".png";
            fname = System.IO.Path.Combine(Server.MapPath("~/Content/Uploads/"), fname);
           
            if (System.IO.File.Exists(fname))
            {
                System.IO.File.Delete(fname);
            }
           
            using (FileStream fs = new FileStream(fname, FileMode.Create))
            {
                using (BinaryWriter bw = new BinaryWriter(fs))
                {
                    byte[] data = Convert.FromBase64String(imageData);
                    bw.Write(data);
                    bw.Close();

                }
            }
            return Json("File Uploaded Successfully!\n Click OK then Upload to submit another file or Close to exit.");
        }

        

        public ActionResult School()
        {
            return View("~/Views/Web/Returns/School.aspx");
        }

        public ActionResult School2002()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/School2002.htm");
        }

        public ActionResult School2003()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/School2003.htm");
        }

        public ActionResult School2004()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/School2004.htm");
        }

        public ActionResult School2005()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/School2005.htm");
        }

        public ActionResult School2006()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/School2006.htm");
        }

        public ActionResult School2007()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/School2007.htm");
        }

        public ActionResult School2008()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/School2008.htm");
        }

        public ActionResult School2009()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/School2009.htm");
        }

        public ActionResult School2010()
        {            
            return View("~/Views/Web/Returns/School2010New.aspx");
        }

        public ActionResult School2011()
        {            
            return View("~/Views/Web/Returns/School2011New.aspx");
        }

        public ActionResult School2012()
        {           
            return View("~/Views/Web/Returns/School2012New.aspx");
        }

        public ActionResult School2013()
        {
            return View("~/Views/Web/Returns/School2013New.aspx");
        }
        public ActionResult School2014()
        {           
            return View("~/Views/Web/Returns/School2014New.aspx");
        }

        public ActionResult School2015()
        {
            return View("~/Views/Web/Returns/School2015New.aspx");
        }

        public ActionResult School2016()
        {
            return View("~/Views/Web/Returns/School2016New.aspx");
        }

        public ActionResult School2017()
        {
            return View("~/Views/Web/Returns/School2017New.aspx");
        }


        public ActionResult Liquor2013()
        {           
            return View("~/Views/Web/Returns/Liquor2013.aspx");
        }

        public ActionResult SchoolThankYou(string id)
        {
            SchoolThankYouModel m = new SchoolThankYouModel() { sCurrentYear = id };           
            return View("~/Views/Web/Returns/SchoolThankYouNew.aspx", m);
        }

        public ActionResult Tobacco2010()
        {            
            return View("~/Views/Web/Returns/Tobacco2010New.aspx");
        }

        public ActionResult Tobacco2011()
        {            
            return View("~/Views/Web/Returns/Tobacco2011New.aspx");

        }

        public ActionResult Tobacco2012()
        {           
            return View("~/Views/Web/Returns/Tobacco2012New.aspx");
        }
        public ActionResult Tobacco2013()
        {            
            return View("~/Views/Web/Returns/Tobacco2013New.aspx");
        }
        public ActionResult Tobacco2014()
        {            
            return View("~/Views/Web/Returns/Tobacco2014New.aspx");
        }
        public ActionResult Tobacco2015()
        {           
            return View("~/Views/Web/Returns/Tobacco2015New.aspx");
        }
        public ActionResult Tobacco2016()
        {            
            return View("~/Views/Web/Returns/Tobacco2016New.aspx");
        }
        public ActionResult Tobacco2017()
        {
            return View("~/Views/Web/Returns/Tobacco2017New.aspx");
        }
        public ActionResult TobaccoThankYou(string id)
        {
            TobaccoThankYouModel m = new TobaccoThankYouModel() { sCurrentYear = id };           
            return View("~/Views/Web/Returns/TobaccoThankYouNew.aspx", m);
        }

        public ActionResult Wage2002()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/Wage2002.htm");
        }

        public ActionResult Wage2003()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/Wage2003.htm");
        }

        public ActionResult Wage2004()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/Wage2004.htm");
        }

        public ActionResult Wage2005()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/Wage2005.htm");
        }

        public ActionResult Wage2006()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/Wage2006.htm");
        }

        public ActionResult Wage2007()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/Wage2007.htm");
        }

        public ActionResult Wage2008()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/Wage2008.htm");
        }

        public ActionResult Wage2009()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/Wage2009.htm");
        }

        public ActionResult Wage2010()
        {           
            return View("~/Views/Web/Returns/Wage2010New.aspx");
        }

        public ActionResult Wage2011()
        {           
            return View("~/Views/Web/Returns/Wage2011New.aspx");
        }

        public ActionResult Wage2012()
        {            
            return View("~/Views/Web/Returns/Wage2012New.aspx");
        }

        public ActionResult Wage2013()
        {           
            return View("~/Views/Web/Returns/Wage2013New.aspx");
        }

        public ActionResult Wage2014()
        {           
            return View("~/Views/Web/Returns/Wage2014New.aspx");
        } //binoy
        public ActionResult Wage2015()
        {
           return View("~/Views/Web/Returns/Wage2015.aspx");
        }
        public ActionResult Wage2016()
        {
            return View("~/Views/Web/Returns/Wage2016New.aspx");
        }
        public ActionResult Wage2017()
        {
            return View("~/Views/Web/Returns/Wage2017New.aspx");
        }

        public ActionResult wagetax()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/wagetax.htm");
        }

        public ActionResult WageThankYou(string id)
        {
            WageThankYouModel m = new WageThankYouModel() { sCurrentYear = id };
           
            return View("~/Views/Web/Returns/WageThankYouNew.aspx", m);
        }

        public ActionResult BPTez()
        {
            return View("~/Views/Web/Returns/BPTez.aspx");
        }

        public ActionResult LossCarryForwardAsp()
        {
            return View("~/Views/Web/Returns/LossCarryForward.aspx");
        }

        public ActionResult LossCarryForwardReturn()
        {
            return View("~/Views/Web/Returns/LossCarryForwardReturn.aspx");
        }

        public ActionResult Returns()
        {
            return View("~/Views/Web/Returns/Returns.aspx");
        }

        public ActionResult SchoolAsp()
        {
            return View("~/Views/Web/Returns/School.aspx");
        }

        public ActionResult Tobacco()
        {
            return View("~/Views/Web/Returns/Tobacco.aspx");
        }

        public ActionResult Wage()
        {
            return View("~/Views/Web/Returns/Wage.aspx");
        }


        public ActionResult PDFSIT_2015()
        {
            return View("~/Views/Web/PDF_report/SIT/PDF_SIT_create.aspx");
        }

        public ActionResult PDFWage()
        {
            return View("~/Views/Web/PDF_report/Wage/PDF_Wage_create.aspx");
        }

        public ActionResult PDFEZ()
        {
            return View("~/Views/Web/PDF_report/EZ/PDF_EZ_create.aspx");
        }

        public ActionResult PDFTobacco()
        {
            return View("~/Views/Web/PDF_report/Tobacco/PDF_Tobacco_create.aspx");
        }

        public ActionResult PDFLCF()
        {
            return View("~/Views/Web/PDF_report/LCF/PDF_LCF_create.aspx");
        }
        public ActionResult PDFUO()
        {
            return View("~/Views/Web/PDF_report/UO/PDF_UO_create.aspx");
        }

        public ActionResult AccountBalance()
        {
            return View("~/Views/Web/PDF_report/AcBalance/PDF_acBalance_create.aspx");
        }

        public ActionResult _10BIRT_19_3800Message()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/_10BIRT_19_3800Message.htm");
        }


        public ActionResult _10BIRTWrkShtN()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/_10BIRTWrkShtN.htm");
        }


        public ActionResult _11BIRT_19_3800Message()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/_11BIRT_19_3800Message.htm");
        }


        public ActionResult _11BIRTWrkShtN()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/_11BIRTWrkShtN.htm");
        }

        [HttpPost]
        public ActionResult Log(string OriginationFom, string ServiceName, string RequestXML="",string ResponseXML="")
        {
            //string[] values = logText.Split('&lt;');

            // Write the log :  TO DO
            Logger log = LogManager.GetCurrentClassLogger();
            LogEventInfo theEvent = new LogEventInfo(LogLevel.Info, "", "Info");            
            theEvent.Properties["DateTimeValue"] = DateTime.Now.ToString("HH:mm:ss tt");
            theEvent.Properties["Form"] = OriginationFom;
            //string LogFilePath = CopMvcUtil.GetLogFilePath();
            string MessageContents="";           
            byte[] data;
            string decodedString;
            if (RequestXML != "")
            {
                data = Convert.FromBase64String(RequestXML);
                decodedString = Encoding.UTF8.GetString(data);                
                //MessageContents = string.Format("OriginationFom:{0}, ServiceName:{1},RequestXML:{2}", OriginationFom, ServiceName, RequestXML);
                MessageContents = "OriginationForm   :" + OriginationFom + Environment.NewLine;
                MessageContents = MessageContents + "ServiceName    :" + ServiceName + Environment.NewLine;
                MessageContents = MessageContents + "RequestXML     :" + decodedString + Environment.NewLine;
                MessageContents = MessageContents + "-------------------------------------------------------------------------------------------";
            }
            else if (ResponseXML != "")
            {
                data = Convert.FromBase64String(ResponseXML);
                decodedString = Encoding.UTF8.GetString(data);
                MessageContents = "OriginationForm   :" + OriginationFom + Environment.NewLine;
                MessageContents = MessageContents + "ServiceName    :" + ServiceName + Environment.NewLine;
                MessageContents = MessageContents + "ResponseXML    :" + decodedString + Environment.NewLine;
                MessageContents = MessageContents + "-------------------------------------------------------------------------------------------";
            }
            else
            {
                MessageContents = "OriginationForm   :" + OriginationFom + Environment.NewLine;
                MessageContents = MessageContents + "ServiceName    :" + ServiceName + Environment.NewLine;
                MessageContents = MessageContents + "Message    :Service could not return Adjustment Reference (Confirmation Number) related to the tax return" + Environment.NewLine;
                MessageContents = MessageContents + "-------------------------------------------------------------------------------------------";

            }


            //CopMvcUtil.WriteInfoLog(LogFilePath,MesssageContents);
            theEvent.Properties["Value"] = MessageContents;
            log.Log(theEvent);
            return Json("LogWritten successfully");
        }



    }
}
