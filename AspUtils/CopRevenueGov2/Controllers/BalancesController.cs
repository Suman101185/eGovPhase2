using CopRevenueGov2.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CopRevenueGov2.Controllers
{
    public class BalancesController : COPBaseController
    {
        //
        // GET: /Balances/

        public ActionResult AccountBalanceCall1()
        {
            return View("~/Views/Web/Balances/AccountBalanceCall1.aspx");
        }

        public ActionResult AccountBalanceCall()
        {
            return View("~/Views/Web/Balances/AccountBalanceCall.aspx");
        }

        public ActionResult AccountBalances()
        {
           // return View("~/Views/Web/Balances/AccountBalances.aspx");
            return View("~/Views/Web/Balances/AccountBalancesNew.aspx");
        }

        public ActionResult Balances()
        {
            return View("~/Views/Web/Balances/Balances.aspx");
        }

        public ActionResult Parameters()
        {
            return GetHtmlContentFromFile("~/Views/Web/Balances/Parameters.htm");
        }

        public ActionResult Payment()
        {
            return View("~/Views/Web/Balances/Payment.aspx");
        }

        public ActionResult Payments()
        {
            return View("~/Views/Web/Balances/Payments.aspx");
        }

        public ActionResult Status()
        {
            return GetHtmlContentFromFile("~/Views/Web/Balances/Status.htm");
        }

        public ActionResult Zip_Apply01()
        {
            return GetHtmlContentFromFile("~/Views/Web/Balances/Zip_Apply01.htm");
        }
        
    }
}
