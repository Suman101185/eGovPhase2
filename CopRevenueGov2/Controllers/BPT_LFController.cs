using CopRevenueGov2.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CopRevenueGov2.Controllers
{
    public class BPT_LFController : COPBaseController
    {
        //
        // GET: /BPT_LF/

        public ActionResult BPTlf()
        {
            return View("~/Views/Web/Returns/BPT_LF/BPTlf.aspx");
        }
        public ActionResult BPTlfReturn()
        {
            return View("~/Views/Web/ReturnServices/BPTlfReturn.aspx");
        }
        public ActionResult BPTlfReturn_2014()
        {
            return View("~/Views/Web/ReturnServices/BPTlfReturn_2014.aspx");
        }
        public ActionResult BPTlfReturn_2015()
        {
            return View("~/Views/Web/ReturnServices/BPTlfReturn_2015.aspx");
        }
        public ActionResult BPTlfjs09()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/BPT_LF/BPTlf.js09.htm");
        }
        public ActionResult BPTlf2009()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/BPT_LF/BPTlf2009.htm");
        }
        public ActionResult SchdA09()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/BPT_LF/SchdA09.htm");
        }
        public ActionResult SchdB09()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/BPT_LF/SchdB09.htm");
        }
        public ActionResult SchdC109()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/BPT_LF/SchdC109.htm");
        }
        public ActionResult SchdD09()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/BPT_LF/SchdD09.htm");
        }
        public ActionResult SchdE09()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/BPT_LF/SchdE09.htm");
        }

        public ActionResult _10BPTlfjs()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/BPT_LF/10BIRTlf_js.aspx");
        }
        public ActionResult _10BPTlf()
        {            
            return View("~/Views/Web/Returns/BPT_LF/10BIRTlfNew.aspx");
        }
        public ActionResult _10SchdA()
        {           
            return View("~/Views/Web/Returns/BPT_LF/10SchdANew.aspx");
        }
        public ActionResult _10SchdB()
        {
            return View("~/Views/Web/Returns/BPT_LF/10SchdBNew.aspx");
        }
        public ActionResult _10SchdC1()
        {
            return View("~/Views/Web/Returns/BPT_LF/10SchdC1New.aspx");
        }
        public ActionResult _10SchdD()
        {           
            return View("~/Views/Web/Returns/BPT_LF/10SchdDNew.aspx");
        }
        public ActionResult _10SchdE()
        {           
            return View("~/Views/Web/Returns/BPT_LF/10SchdENew.aspx");
        }

        public ActionResult _11BPTlfjs()
        {

            return GetHtmlContentFromFile("~/Views/Web/Returns/BPT_LF/11BIRTlf_js.aspx");

        }
        public ActionResult _11BPTlf()
        {            
            return View("~/Views/Web/Returns/BPT_LF/11BIRTlfNew.aspx");
        }
        public ActionResult _11SchdA()
        {            
            return View("~/Views/Web/Returns/BPT_LF/11SchdANew.aspx");
        }
        public ActionResult _11SchdB()
        {            
            return View("~/Views/Web/Returns/BPT_LF/11SchdBNew.aspx");
        }
        public ActionResult _11SchdC1()
        {           
            return View("~/Views/Web/Returns/BPT_LF/11SchdC1New.aspx");
        }
        public ActionResult _11SchdD()
        {            
            return View("~/Views/Web/Returns/BPT_LF/11SchdDNew.aspx");
        }
        public ActionResult _11SchdE()
        {            
            return View("~/Views/Web/Returns/BPT_LF/11SchdENew.aspx");
        }

        public ActionResult _12BIRTlfjs()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/BPT_LF/12BIRTlf_js.aspx");
        }
        public ActionResult _12BIRTlf()
        {            
            return View("~/Views/Web/Returns/BPT_LF/12BIRTlfNew.aspx");
        }
        public ActionResult _12SchdA()
        {           
            return View("~/Views/Web/Returns/BPT_LF/12SchdANew.aspx");
        }
        public ActionResult _12SchdB()
        {           
            return View("~/Views/Web/Returns/BPT_LF/12SchdBNew.aspx");
        }
        public ActionResult _12SchdC1()
        {            
            return View("~/Views/Web/Returns/BPT_LF/12SchdC1New.aspx");
        }
        public ActionResult _12SchdD()
        {           
            return View("~/Views/Web/Returns/BPT_LF/12SchdDNew.aspx");
        }
        public ActionResult _12SchdE()
        {           
            return View("~/Views/Web/Returns/BPT_LF/12SchdENew.aspx");
        }
        public ActionResult _10BIRT_19_3800Message()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/BPT_LF/10BIRT_19_3800Message.htm");
        }
        public ActionResult _11BIRT_19_3800Message()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/BPT_LF/11BIRT_19_3800Message.htm");
        }
        public ActionResult _12BIRT_19_3800Message()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/BPT_LF/12BIRT_19_3800Message.htm");
        }
        //public ActionResult _11BIRT_19_3800Message()
        //{
        //    return GetHtmlContentFromFile("~/Views/Web/Returns/BPT_LF/11BIRT_19_3800Message.htm");
        //}
        public ActionResult _13BIRT_19_3800Message()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/BPT_LF/13BIRT_19_3800Message.htm");
        }
        //public ActionResult _12BIRT_19_3800Message()
        //{
        //    return GetHtmlContentFromFile("~/Views/Web/Returns/BPT_LF/12BIRT_19_3800Message.htm");
        //}
        public ActionResult _12WrkShtN()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/BPT_LF/13WrkShtN.htm");
        }
        public ActionResult _13WrkShtN()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/BPT_LF/12WrkShtN.htm");
        }
        public ActionResult _13BIRTlfjs()
        {
            return View("~/Views/Web/Returns/BPT_LF/13BIRTlf_js.aspx");
        }
        public ActionResult _13BIRTlf()
        {           
            return View("~/Views/Web/Returns/BPT_LF/13BIRTlfNew.aspx");

        }
        public ActionResult _13SchdA()
        {          
            return View("~/Views/Web/Returns/BPT_LF/13SchdANew.aspx");
        }
        public ActionResult _13SchdB()
        {           
            return View("~/Views/Web/Returns/BPT_LF/13SchdBNew.aspx");
        }
        public ActionResult _13SchdC1()
        {            
            return View("~/Views/Web/Returns/BPT_LF/13SchdC1New.aspx");
        }
        public ActionResult _13SchdD()
        {            
            return View("~/Views/Web/Returns/BPT_LF/13SchdDNew.aspx");
        }
        public ActionResult _13SchdE()
        {           
            return View("~/Views/Web/Returns/BPT_LF/13SchdENew.aspx");
        }


        public ActionResult _14BIRTlfjs()
        {
            return View("~/Views/Web/Returns/BPT_LF/14BIRTlf_js.aspx");
        }
        public ActionResult _14BIRTlf()
        {           
            return View("~/Views/Web/Returns/BPT_LF/14BIRTlf.aspx");

        }
        public ActionResult _14SchdA()
        {           
            return View("~/Views/Web/Returns/BPT_LF/14SchdA.aspx");
        }
        public ActionResult _14SchdB()
        {           
            return View("~/Views/Web/Returns/BPT_LF/14SchdB.aspx");
        }
        public ActionResult _14SchdC1()
        {           
            return View("~/Views/Web/Returns/BPT_LF/14SchdC1.aspx");
        }
        public ActionResult _14SchdD()
        {           
            return View("~/Views/Web/Returns/BPT_LF/14SchdD.aspx");
        }
        public ActionResult _14SchdE()
        {           
            return View("~/Views/Web/Returns/BPT_LF/14SchdE.aspx");
        }
        public ActionResult _14WorkSheet5()
        {            
            return View("~/Views/Web/Returns/BPT_LF/14WorkSheet5.aspx");
        }

        public ActionResult _14BIRTlf_js()
        {           
            return View("~/Views/Web/Returns/BPT_LF/14BIRTlf_js.aspx");
        }

        public ActionResult _15BIRTlfjs()
        {
            return View("~/Views/Web/Returns/BPT_LF/15BIRTlf_js.aspx");
        }
        public ActionResult _15BIRTlf()
        {          
            return View("~/Views/Web/Returns/BPT_LF/15BIRTlf.aspx");

        }
        public ActionResult _15SchdA()
        {           
            return View("~/Views/Web/Returns/BPT_LF/15SchdA.aspx");
        }
        public ActionResult _15SchdB()
        {           
            return View("~/Views/Web/Returns/BPT_LF/15SchdB.aspx");
        }
        public ActionResult _15SchdC1()
        {           
            return View("~/Views/Web/Returns/BPT_LF/15SchdC1.aspx");
        }
        public ActionResult _15SchdD()
        {           
            return View("~/Views/Web/Returns/BPT_LF/15SchdD.aspx");
        }
        public ActionResult _15SchdE()
        {          
            return View("~/Views/Web/Returns/BPT_LF/15SchdE.aspx");
        }
        public ActionResult _15WorkSheet5()
        {           
            return View("~/Views/Web/Returns/BPT_LF/15WorkSheet5.aspx");
        }
        #region 2016_BPTLF
        public ActionResult _16BIRTlfjs()
        {
            return View("~/Views/Web/Returns/BPT_LF/2016/16BIRTlf_js.aspx");
        }
        public ActionResult _16BIRTlf()
        {         
            return View("~/Views/Web/Returns/BPT_LF/2016/16BIRTlf.aspx");

        }
        public ActionResult _16SchdA()
        {           
            return View("~/Views/Web/Returns/BPT_LF/2016/16SchdA.aspx");
        }
        public ActionResult _16SchdB()
        {           
            return View("~/Views/Web/Returns/BPT_LF/2016/16SchdB.aspx");
        }
        public ActionResult _16SchdC1()
        {           
            return View("~/Views/Web/Returns/BPT_LF/2016/16SchdC1.aspx");
        }
        public ActionResult _16SchdD()
        {           
            return View("~/Views/Web/Returns/BPT_LF/2016/16SchdD.aspx");
        }
        public ActionResult _16SchdE()
        {           
            return View("~/Views/Web/Returns/BPT_LF/2016/16SchdE.aspx");
        }
        public ActionResult _16WorkSheet5()
        {            
            return View("~/Views/Web/Returns/BPT_LF/2016/16WorkSheet5.aspx");
        }
        #endregion

        #region 2017_BPTLF
        public ActionResult _17BIRTlfjs()
        {
            return View("~/Views/Web/Returns/BPT_LF/2017/17BIRTlf_js.aspx");
        }
        public ActionResult _17BIRTlf()
        {
            return View("~/Views/Web/Returns/BPT_LF/2017/17BIRTlf.aspx");

        }
        public ActionResult _17SchdA()
        {
            return View("~/Views/Web/Returns/BPT_LF/2017/17SchdA.aspx");
        }
        public ActionResult _17SchdB()
        {
            return View("~/Views/Web/Returns/BPT_LF/2017/17SchdB.aspx");
        }
        public ActionResult _17SchdC1()
        {
            return View("~/Views/Web/Returns/BPT_LF/2017/17SchdC1.aspx");
        }
        public ActionResult _17SchdD()
        {
            return View("~/Views/Web/Returns/BPT_LF/2017/17SchdD.aspx");
        }
        public ActionResult _17SchdE()
        {
            return View("~/Views/Web/Returns/BPT_LF/2017/17SchdE.aspx");
        }
        public ActionResult _17WorkSheet5()
        {
            return View("~/Views/Web/Returns/BPT_LF/2017/17WorkSheet5.aspx");
        }
        #endregion



        public ActionResult BPTlfThankYou(string id)
        {
            CopRevenueGov2.Models.Web.Returns.BPF_LF.BPTLFThankYouModel model =
                new Models.Web.Returns.BPF_LF.BPTLFThankYouModel();
            model.sCurrentYear = id;         
            return View("~/Views/Web/Returns/BPT_LF/BPTLFThankYou2New.aspx", model);
        }

        public ActionResult PDF_BPTLF()
        {
            return View("~/Views/Web/PDF_report/BPTLF/PDF_BPTLF_create.aspx");
        }


    }
}
