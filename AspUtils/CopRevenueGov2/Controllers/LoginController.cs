using CopRevenueGov2.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CopRevenueGov2.Controllers
{
    public class LoginController : COPBaseController
    {
        //
        // GET: /Login/

        public ActionResult ApplyFirst()
        {
           // return GetHtmlContentFromFile("~/views/web/Login/ApplyFirst.htm");
            return View("~/views/web/Login/ApplyFirstNew.aspx");
        
        }

        public ActionResult ChangePin()
        {
           // return GetHtmlContentFromFile("~/views/web/Login/ChangePin.htm");
            return View("~/views/web/Login/ChangePinNew.aspx");
        }

        public ActionResult Email()
        {
            return GetHtmlContentFromFile("~/views/web/Login/Email.htm");
        }

        public ActionResult ForgotPin()
        {
           // return GetHtmlContentFromFile("~/views/web/Login/ForgotPin.htm");
            return View("~/views/web/Login/ForgotPinNew.aspx");
        }

        public ActionResult Login()
        {
          //  return GetHtmlContentFromFile("~/views/web/Login/Login.htm");
            return View("~/views/web/Login/LoginNew.aspx");
        }

        public ActionResult Main()
        {
           // return GetHtmlContentFromFile("~/views/web/Login/Main.htm");
            return View("~/views/web/Login/MainNew.aspx");
        }

        public ActionResult MainAsp()
        {
            return View("~/Views/web/Login/Main.aspx");
        }

        public ActionResult paycoupon()
        {
            //return GetHtmlContentFromFile("~/views/web/Login/paycoupon.htm");
            return View("~/views/web/Login/paycouponNew.aspx");
        }

        public ActionResult PinApply()
        {
            //return GetHtmlContentFromFile("~/views/web/Login/PinApply.htm");
            return View("~/views/web/Login/PinApplyNew.aspx");
        }

        public ActionResult ThankYou()
        {
           // return GetHtmlContentFromFile("~/views/web/login/ThankYou.htm");
         return View("~/views/web/login/ThankYouNew.aspx");
        }

    }
}
