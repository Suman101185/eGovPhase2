using CopRevenueGov2.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CopRevenueGov2.Controllers
{
    public class HomeController : COPBaseController
    {
        //
        // GET: /Home/

        public ActionResult Index()
        {
            var url = Request.Url.PathAndQuery;
            return View("~/Views/Web/Default.aspx");
        }

        public ActionResult AccountInfo()
        {
            return View("~/Views/Web/AccountInfo.aspx");
        }

        public ActionResult AddressCheck()
        {
            return View("~/Views/Web/AddressCheck.aspx");
        }

        public ActionResult Default()
        {
            return View("~/Views/Web/Default.aspx");
        }

        public ActionResult Header()
        {
            return GetHtmlContentFromFile("~/Views/Web/Header.htm");
        }

        public ActionResult HeaderNew()
        {
            return GetHtmlContentFromFile("~/Content/DemoDocWinHtmls/Header.html");
        }

        public ActionResult Is_Partner()
        {
            return GetHtmlContentFromFile("~/Views/Web/Is-Partner.htm");
        }

        public ActionResult ev()
        {
            return View("~/Views/Web/ev.aspx");
        }

        public ActionResult Browser()
        {
            return GetHtmlContentFromFile("~/Views/Web/Browser.htm");
        }

        public ActionResult MailPIN()
        {
            return View("~/Views/Web/MailPIN.aspx");
        }

        public ActionResult postinfo()
        {
            return GetHtmlContentFromFile("~/Views/Web/postinfo.htm");
        }

        public ActionResult Maintenance()
        {
            return GetHtmlContentFromFile("~/Views/Web/Maintenance.htm");
        }


        public ActionResult PageMaintenance()
        {
            return GetHtmlContentFromFile("~/Views/Web/PageMaintenance.htm");
        }


        public ActionResult WageReturn()
        {
            return View("~/Views/Web/ReturnServices/WageReturn.aspx");
        }

        public ActionResult TobaccoReturn()
        {
            return View("~/Views/Web/ReturnServices/TobaccoReturn.aspx");
        }

        public ActionResult ReadTaxForm()
        {
            return View("~/views/web/ReadTaxForm.aspx");
        }

        public ActionResult ThankYou()
        {            
            return View("~/Views/Web/ThankYouNew.aspx");
        }

        public ActionResult SchoolReturn()
        {
            return View("~/Views/Web/ReturnServices/SchoolReturn.aspx");
        }
        public ActionResult BPTezReturn()
        {
            return View("~/Views/Web/ReturnServices/BPTezReturn.aspx");
        }
        public ActionResult BPTezReturn_2014()
        {
            return View("~/Views/Web/ReturnServices/BPTezReturn_2014.aspx");
        }
        public ActionResult BPTezReturn_2015()
        {
            return View("~/Views/Web/ReturnServices/BPTezReturn_2015.aspx");
        }  
        public ActionResult LiquorReturn()
        {
            return View("~/Views/Web/ReturnServices/LiquorReturn.aspx");
        }
    }
}
