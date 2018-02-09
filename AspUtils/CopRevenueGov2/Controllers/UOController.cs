using CopRevenueGov2.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CopRevenueGov2.Controllers
{
    public class UOController : COPBaseController
    {
        //
        // GET: /UO/

        public ActionResult UO()
        {
            return View("~/Views/Web/Returns/UO/UO.aspx");
        }

        public ActionResult UO2011Form()
        {
            //return GetHtmlContentFromFile("~/Views/Web/Returns/UO/UO2011Form.htm");
            //return View("~/Views/Web/Returns/UO/UO2011Form.aspx");
            return View("~/Views/Web/Returns/UO/UO2011FormNew.aspx");
        }

        public ActionResult UO2013Form()
        {
            //return GetHtmlContentFromFile("~/Views/Web/Returns/UO/UO2011Form.htm");
           // return View("~/Views/Web/Returns/UO/UO2013Form.aspx");
            return View("~/Views/Web/Returns/UO/UO2013FormNew.aspx");
        }

        public ActionResult UOFormCall()
        {
            return View("~/Views/Web/Returns/UO/UOFormCall.aspx");
        }
        public ActionResult UOFormCallNew()
        {
            return View("~/Views/Web/Returns/UO/UOFormCallNew.aspx");
        }

        public ActionResult UOList()
        {
            //return View("~/Views/Web/Returns/UO/UOList.aspx");
            return View("~/Views/Web/Returns/UO/UOListNew.aspx");
        }

        public ActionResult UOListCall()
        {
            return View("~/Views/Web/Returns/UO/UOListCall.aspx");
        }

        public ActionResult UOThankYou(string id)
        {
            CopRevenueGov2.Models.Web.Returns.UOThankYouModel model =
               new Models.Web.Returns.UOThankYouModel();
            model.sCurrentYear = id;

            return View("~/Views/Web/Returns/UO/UOThankYou1.aspx", model);
        }

        public ActionResult UOThankYouNew(string id)
        {
            CopRevenueGov2.Models.Web.Returns.UOThankYouModelNew model =
               new Models.Web.Returns.UOThankYouModelNew();
            model.sCurrentYear = id;

            return View("~/Views/Web/Returns/UO/UOThankYouNew1.aspx", model);
        }

        public ActionResult _12BIRT_19_3800Message()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/UO/12BIRT_19_3800Message.htm");
        }

        public ActionResult _12BIRTWrkShtN()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/UO/12BIRTWrkShtN.htm");
        }

    }
}
