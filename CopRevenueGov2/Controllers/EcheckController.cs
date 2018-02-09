using CopRevenueGov2.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CopRevenueGov2.Controllers
{
    public class EcheckController : COPBaseController
    {
        //
        // GET: /Echeck/

        public ActionResult Balances()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return View("~/views/web/E-check/Balances.aspx");
            }
            else
            {
                return View("~/views/web/E-check/Balances.aspx");
            }
        }

        public ActionResult BalancesOld()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return View("~/views/web/E-check/BalancesOld.aspx");
            }
            else
            {
                return View("~/views/web/E-check/BalancesOld.aspx");
            }
        }

        public ActionResult Parameters()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetHtmlContentFromFile("~/views/web/E-check/Parameters.htm");
            }
            else
            {
                return GetHtmlContentFromFile("~/views/web/E-check/Parameters.htm");
            }
        }

        public ActionResult Payment()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return View("~/views/web/E-check/Payment.aspx");
            }
            else
            {
                return View("~/views/web/E-check/Payment.aspx");
            }
        }

        public ActionResult Payments()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return View("~/views/web/E-check/Payments.aspx");
            }
            else
            {
                return View("~/views/web/E-check/Payments.aspx");
            }
        }

        public ActionResult PaymentsOld()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return View("~/views/web/E-check/PaymentsOld.aspx");
            }
            else
            {
                return View("~/views/web/E-check/PaymentsOld.aspx");
            }
        }

        public ActionResult Status()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetHtmlContentFromFile("~/views/web/E-check/Status.htm");
            }
            else
            {
                return GetHtmlContentFromFile("~/views/web/E-check/Status.htm");
            }
        }

        public ActionResult Zip_Apply01()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetHtmlContentFromFile("~/views/web/E-check/Zip_Apply01.htm");
            }
            else
            {
                return GetHtmlContentFromFile("~/views/web/E-check/Zip_Apply01.htm");
            }
        }
    }
}
