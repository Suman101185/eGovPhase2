using CopRevenueGov2.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WinSCP;

namespace CopRevenueGov2.Controllers
{
    public class LoginController : COPBaseController
    {
        //
        // GET: /Login/

        public ActionResult ApplyFirst()
        {
           
            return View("~/views/web/Login/ApplyFirstNew.aspx");
        
        }

        public ActionResult ChangePin()
        {
          
            return View("~/views/web/Login/ChangePinNew.aspx");
        }

        public ActionResult UploadFile()
        {
           
            return View("~/views/web/Login/FileUpload.aspx");

        }

        public ActionResult CapchaFile_W2()
        {
           
            return View("~/views/web/Login/Capcha_W2.aspx");

        }


        public ActionResult CapchaFile_1099()
        {
           
            return View("~/views/web/Login/Capcha_1099.aspx");

        }

        public ActionResult UploadFile_1099()
        {
            
            return View("~/views/web/Login/FileUpload1099.aspx");

        }
        public ActionResult Email()
        {
            return GetHtmlContentFromFile("~/views/web/Login/Email.htm");
        }

        public ActionResult ForgotPin()
        {
          
            return View("~/views/web/Login/ForgotPinNew.aspx");
        }

        public ActionResult Login()
        {
         
            return View("~/views/web/Login/LoginNew.aspx");
        }

        public ActionResult Main()
        {
          
            return View("~/views/web/Login/MainNew.aspx");
        }

        public ActionResult MainAsp()
        {
            return View("~/Views/web/Login/Main.aspx");
        }

        public ActionResult paycoupon()
        {
           
            return View("~/views/web/Login/paycouponNew.aspx");
        }

        public ActionResult PinApply()
        {
           
            return View("~/views/web/Login/PinApplyNew.aspx");
        }

        public ActionResult ThankYou()
        {

            return View("~/views/web/login/ThankYouNew.aspx");
        }
        
            public ActionResult Image()
        {

            return GetHtmlContentFromFile("~/views/web/PayCoupon/PDFCouponImageTemplate.htm");
        }
        [HttpPost]
        public ActionResult Upload()
        {
            if (Request.Files.Count > 0)
            {
                string fname = string.Empty;
                try
                {

                    HttpFileCollectionBase files = Request.Files;
                    for (int i = 0; i < files.Count; i++)
                    {
                       

                        HttpPostedFileBase file = files[i];


                        // Checking for Internet Explorer  
                        if (Request.Browser.Browser.ToUpper() == "IE" || Request.Browser.Browser.ToUpper() == "INTERNETEXPLORER")
                        {
                            string[] testfiles = file.FileName.Split(new char[] { '\\' });
                            fname = testfiles[testfiles.Length - 1];
                        }
                        else
                        {
                            fname = file.FileName;
                        }

                        
                        fname = System.IO.Path.Combine(Server.MapPath("~/Content/Uploads/"), fname);
                        file.SaveAs(fname);
                    }

                    SessionOptions sessionOptions = new SessionOptions
                    {
                        Protocol = Protocol.Sftp,
                        HostName = "secure-ftp.phila.gov", //hostname e.g. IP: 192.54.23.32, or mysftpsite.com
                        UserName = "W2.REVENUE",
                        Password = "W2r3v3NvEP@ssw0rd",
                        PortNumber = 22,
                       
                        SshHostKeyFingerprint = "ssh-dss 1024 a3:f3:6d:0c:25:ae:0b:8b:48:a9:eb:0f:99:81:71:f8"
                       
                    };
                    using (WinSCP.Session session = new Session())
                    {

                       
                        session.DisableVersionCheck = true;
                        session.ExecutablePath = @"C:\Program Files (x86)\WinSCP\WinSCP.exe";
                        session.Open(sessionOptions);
                        TransferOptions transferOptions = new TransferOptions();
                        transferOptions.TransferMode = TransferMode.Binary;
                        transferOptions.FilePermissions = null;
                        transferOptions.PreserveTimestamp = false;
                        transferOptions.ResumeSupport.State = TransferResumeSupportState.Off;
                        TransferOperationResult transferResult;

                        transferResult = session.PutFiles(fname, "/", false, transferOptions);


                        transferResult.Check();
                        return Json("File Uploaded Successfully!\n Click OK then Upload to submit another file or Close to exit.");

                    }

                }

                catch (Exception ex)
                {

                    return Json("Error occurred. Error details: " + ex.Message);
                }

            }
            else
            {
                return Json("No files selected.");
            }

        }

        [HttpPost]
        public ActionResult Upload_1099()
        {
            if (Request.Files.Count > 0)
            {
                string fname = string.Empty;
                try
                {

                    HttpFileCollectionBase files = Request.Files;
                    for (int i = 0; i < files.Count; i++)
                    {
                       

                        HttpPostedFileBase file = files[i];


                        // Checking for Internet Explorer  
                        if (Request.Browser.Browser.ToUpper() == "IE" || Request.Browser.Browser.ToUpper() == "INTERNETEXPLORER")
                        {
                            string[] testfiles = file.FileName.Split(new char[] { '\\' });
                            fname = testfiles[testfiles.Length - 1];
                        }
                        else
                        {
                            fname = file.FileName;
                        }

                       
                        fname = System.IO.Path.Combine(Server.MapPath("~/Content/Uploads/"),  fname);
                        file.SaveAs(fname);
                    }

                    SessionOptions sessionOptions = new SessionOptions
                    {
                        Protocol = Protocol.Sftp,
                        HostName = "secure-ftp.phila.gov", //hostname e.g. IP: 192.54.23.32, or mysftpsite.com
                        UserName = "1099.REVENUE",
                        Password = "IO99r3v3NvEP@ssw0rd",
                        PortNumber = 22,
                        
                        SshHostKeyFingerprint = "ssh-dss 1024 a3:f3:6d:0c:25:ae:0b:8b:48:a9:eb:0f:99:81:71:f8"
                        
                    };
                    using (WinSCP.Session session = new Session())
                    {

                       
                        session.DisableVersionCheck = true;
                        session.ExecutablePath = @"C:\Program Files (x86)\WinSCP\WinSCP.exe";
                        session.Open(sessionOptions);
                        TransferOptions transferOptions = new TransferOptions();
                        transferOptions.TransferMode = TransferMode.Binary;
                        transferOptions.FilePermissions = null;
                        transferOptions.PreserveTimestamp = false;
                        transferOptions.ResumeSupport.State = TransferResumeSupportState.Off;
                        TransferOperationResult transferResult;

                        transferResult = session.PutFiles(fname, "/", false, transferOptions);


                        transferResult.Check();
                        return Json("File Uploaded Successfully!\n Click OK then Upload to submit another file or Close to exit.");

                    }

                }

                catch (Exception ex)
                {

                    return Json("Error occurred. Error details: " + ex.Message);
                }

            }
            else
            {
                return Json("No files selected.");
            }

        }
    }
}
