using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CopRevenueGov2.Controllers
{
    public class PayCouponController : COPBaseController
    {
        //
        // GET: /PayCoupon/


        public ActionResult CouponImageAsp()
        {
            return View("~/Views/Web/PayCoupon/PayCouponImage.aspx");
        }

        public ActionResult CouponImage()
        {
            return base.GetHtmlContentFromFile("~/Views/Web/PayCoupon/PayCouponImage.htm");
        }

        public ActionResult CouponImageForm()
        {
            return base.GetHtmlContentFromFile("~/Views/Web/PayCoupon/CouponImageForm.htm");
        }

        public ActionResult CouponImageInclude()
        {
            return base.GetHtmlContentFromFile("~/Views/Web/PayCoupon/CouponImageInclude.htm");
        }  

        public ActionResult NTL_Initial()
        {
            //return View("~/Views/Web/PayCoupon/NTL_Initial.aspx");
            return View("~/Views/Web/PayCoupon/NTL_InitialNew.aspx");
        }

        public ActionResult NTL_ThankYou()
        {
           // return base.GetHtmlContentFromFile("~/Views/Web/PayCoupon/NTL_ThankYou.htm");
            return View("~/Views/Web/PayCoupon/NTL_ThankYouNew.aspx");
        } 

        public ActionResult PayCoupon()
        {
            //return View("~/Views/Web/PayCoupon/PayCoupon.aspx");
            return View("~/Views/Web/PayCoupon/PayCouponNew.aspx");
        }

        public ActionResult PayCouponRecv()
        {
            return View("~/Views/Web/PayCoupon/PayCouponRecv.aspx");
        }

        public ActionResult PDFCouponCreate()
        {
            return View("~/Views/Web/PayCoupon/PDFCouponCreate.aspx");
        }

        public ActionResult PDFCouponDisplay()
        {
            return base.GetHtmlContentFromFile("~/Views/Web/PayCoupon/PDFCouponDisplay.htm");
        } 

        public ActionResult PDFCouponImageNewAsp()
        {
            return View("~/Views/Web/PayCoupon/PDFCouponImageNew.aspx");
        }

        public ActionResult PDFCouponImageNew()
        {
            return base.GetHtmlContentFromFile("~/Views/Web/PayCoupon/PDFCouponImageNew.htm");
        }

        public ActionResult PDFCouponImageTemplate()
        {
            return base.GetHtmlContentFromFile("~/Views/Web/PayCoupon/PDFCouponImageTemplate.htm");
        } 

    }
}
