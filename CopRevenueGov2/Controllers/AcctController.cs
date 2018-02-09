using CopRevenueGov2.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CopRevenueGov2.Controllers
{
    public class AcctController : COPBaseController
    {
        //
        // GET: /Acct/

        public ActionResult ApplyMain()
        {
            if (Request.Browser.IsMobileDevice)
            {
                //return View(); by manoranjan
                return View("~/Views/Web/Acct/ApplyMain.aspx");
            }
            else
            {
                return View("~/Views/Web/Acct/ApplyMain.aspx");
                
            }            
        }

        public ActionResult Addresses()
        {
            if (Request.Browser.IsMobileDevice)
            {
              
                return View("~/views/web/Acct/AddressesNew.aspx");
            }
            else
            {
              
                return View("~/views/web/Acct/AddressesNew.aspx");
            }
        }

        public ActionResult AddressCorrection()
        {
            if (Request.Browser.IsMobileDevice)
            {
              
                return View("~/views/web/Acct/AddressCorrection.aspx");
            }
            else
            {
               
                return View("~/views/web/Acct/AddressCorrection.aspx");
            }
        }

        public ActionResult Echeck()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetHtmlContentFromFile("~/views/web/Acct/Echeck.htm");
            }
            else
            {
                return GetHtmlContentFromFile("~/views/web/Acct/Echeck.htm");
            }
        }

        public ActionResult NewEmail()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetHtmlContentFromFile("~/views/web/Acct/NewEmail.htm");
            }
            else
            {
                return GetHtmlContentFromFile("~/views/web/Acct/NewEmail.htm");
            }
        }

        public ActionResult Partners_Officers()
        {
            if (Request.Browser.IsMobileDevice)
            {
             
                return View("~/views/web/Acct/Partners-OfficersNew.aspx");
            }
            else
            {
              
                return View("~/views/web/Acct/Partners-OfficersNew.aspx");
            }
        }

        public new ActionResult Profile()
        {
            if (Request.Browser.IsMobileDevice)
            {
            
                return View("~/views/web/Acct/ProfileNew.aspx");
            }
            else
            {
              
                return View("~/views/web/Acct/ProfileNew.aspx");
            }
        }

        public ActionResult Taxes()
        {
            if (Request.Browser.IsMobileDevice)
            {
            
                   return View("~/views/web/Acct/TaxesNew.aspx");

            }
            else
            {
               
                return View("~/views/web/Acct/TaxesNew.aspx");

            }
        }

        public ActionResult ThankYou()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return View("~/views/web/Acct/ThankYouNew.aspx");
               

            }
            else
            {
               
                return View("~/views/web/Acct/ThankYouNew.aspx");
            }
        }

    }
}
