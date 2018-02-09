using CopRevenueGov2.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CopRevenueGov2.Controllers
{
    public class ERNController : COPBaseController
    {
        //
        // GET: /ERN/

        public ActionResult ERNAsp()
        {
            return View("~/Views/Web/Returns/ERN/ERN.aspx");
        }

        public ActionResult ERNReturn()
        {
            return View("~/Views/Web/Returns/ERN/ERNReturn.aspx");
        }

        public ActionResult ERN()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/ERN/ERN.htm");
        }

        public ActionResult ERN2006()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/ERN/ERN2006.htm");
        }

        public ActionResult ERNThankYou()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/ERN/ERNThankYou.htm");
        }

    }
}
