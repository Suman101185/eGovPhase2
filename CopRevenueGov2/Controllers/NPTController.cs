using CopRevenueGov2.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CopRevenueGov2.Controllers
{
    public class NPTController : COPBaseController
    {
        //
        // GET: /NPT/

        /* ----------------- Script files ---------------------- */
        #region Js_Files
        public ActionResult NPTjs()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/NPT/NPT.js.htm");
        }
        public ActionResult NPTjs07()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/NPT.js07.htm");
        }
        public ActionResult NPTjs08()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/NPT.js08.htm");
        }
        public ActionResult _09NPTjs()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/NPT/09NPT.js.htm");
        }
        public ActionResult _10NPTjs()
        {            
            return View("~/Views/Web/Returns/NPT/10NPT_js.aspx");
        }
        public ActionResult _11NPTjs()
        {           
            return View("~/Views/Web/Returns/NPT/11NPT_js.aspx");
        }
        public ActionResult _12NPTjs()
        {           
            return View("~/Views/Web/Returns/NPT/12NPT_js.aspx");
        }
        public ActionResult _13NPT_js()
        {
            return View("~/Views/Web/Returns/NPT/13NPT_js.aspx");
        }
        public ActionResult _14NPT_js()
        {
            return View("~/Views/Web/Returns/NPT/14NPT_js.aspx");
        }
        public ActionResult _15NPT_js()
        {
            return View("~/Views/Web/Returns/NPT/15NPT_js.aspx");
        }
        /* ----------------------------------------------------- */
        #endregion

        #region 2009_Worksheets
        /* ----------------- 09 files -------------------------- */
        public ActionResult _09Page4()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/NPT/09Page4.htm");
        }
        public ActionResult _09WrkA()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/NPT/09WrkA.htm");
        }
        public ActionResult _09WrkB()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/NPT/09WrkB.htm");
        }
        public ActionResult _09WrkC()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/NPT/09WrkC.htm");
        }
        public ActionResult _09WrkD()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/NPT/09WrkD.htm");
        }
        public ActionResult _09WrkE()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/NPT/09WrkE.htm");
        }
        public ActionResult _09WrkK()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/NPT/09WrkK.htm");
        }
        /* --------------------------------------------------------*/
        #endregion

        #region 2010_Worksheets
        /* ----------------- 10 files -------------------------- */
        public ActionResult _10Page4()
        {
            return View("~/Views/Web/Returns/NPT/10WrkNR_3.aspx");           
        }
        public ActionResult _10WrkA()
        {          
            return View("~/Views/Web/Returns/NPT/10WrkANew.aspx");
        }
        public ActionResult _10WrkB()
        {          
            return View("~/Views/Web/Returns/NPT/10WrkBNew.aspx");
        }
        public ActionResult _10WrkC()
        {           
            return View("~/Views/Web/Returns/NPT/10WrkCNew.aspx");
        }
        public ActionResult _10WrkD()
        {           
            return View("~/Views/Web/Returns/NPT/10WrkDNew.aspx");
        }
        public ActionResult _10WrkE()
        {          
            return View("~/Views/Web/Returns/NPT/10WrkENew.aspx");
        }
        public ActionResult _10WrkK()
        {          
            return View("~/Views/Web/Returns/NPT/10WrkKNew.aspx");
        }
        /* --------------------------------------------------------*/
        #endregion

        #region 2011_Worksheets
        /* ----------------- 11 files -------------------------- */
        public ActionResult _11Page4()
        {           
            return View("~/Views/Web/Returns/NPT/11WrkNR_3.aspx");
        }
        public ActionResult _11WrkA()
        {
            return View("~/Views/Web/Returns/NPT/11WrkANew.aspx");
        }
        public ActionResult _11WrkB()
        {          
            return View("~/Views/Web/Returns/NPT/11WrkBNew.aspx");
        }
        public ActionResult _11WrkC()
        {          
            return View("~/Views/Web/Returns/NPT/11WrkCNew.aspx");
        }
        public ActionResult _11WrkD()
        {           
            return View("~/Views/Web/Returns/NPT/11WrkDNew.aspx");
        }
        public ActionResult _11WrkE()
        {          
            return View("~/Views/Web/Returns/NPT/11WrkENew.aspx");
        }
        public ActionResult _11WrkK()
        {         
            return View("~/Views/Web/Returns/NPT/11WrkKNew.aspx");
        }
        /* --------------------------------------------------------*/
        #endregion

        #region 2012_Worksheets
        /* ----------------- 12 files -------------------------- */
        public ActionResult _12WrkExtension()
        {
            return View("~/Views/Web/Returns/NPT/12WrkExtension.aspx");
        }
        public ActionResult _12Page4()
        {            
            return View("~/Views/Web/Returns/NPT/12WrkNR_3.aspx");
        }
        public ActionResult _12WrkA()
        {          
            return View("~/Views/Web/Returns/NPT/12WrkANew.aspx");
        }
        public ActionResult _12WrkB()
        {           
            return View("~/Views/Web/Returns/NPT/12WrkBNew.aspx");
        }
        public ActionResult _12WrkC()
        {           
            return View("~/Views/Web/Returns/NPT/12WrkCNew.aspx");
        }
        public ActionResult _12WrkD()
        {          
            return View("~/Views/Web/Returns/NPT/12WrkDNew.aspx");
        }
        public ActionResult _12WrkE()
        {
            return View("~/Views/Web/Returns/NPT/12WrkENew.aspx");
        }
        public ActionResult _12WrkK()
        {          
            return View("~/Views/Web/Returns/NPT/12WrkKNew.aspx");
        }
        #endregion

        #region 2013_Worksheets
        /* ----------------- 13 files -------------------------- */
        public ActionResult _13WrkExtension()
        {
            return View("~/Views/Web/Returns/NPT/13WrkExtension.aspx");
        }
        public ActionResult _13Page4()
        {
            return View("~/Views/Web/Returns/NPT/13WrkNR_3.aspx");           
        }
        public ActionResult _13WrkA()
        {         
            return View("~/Views/Web/Returns/NPT/13WrkANew.aspx");
        }
        public ActionResult _13WrkB()
        {           
            return View("~/Views/Web/Returns/NPT/13WrkBNew.aspx");
        }
        public ActionResult _13WrkC()
        {           
            return View("~/Views/Web/Returns/NPT/13WrkCNew.aspx");
        }
        public ActionResult _13WrkD()
        {          
            return View("~/Views/Web/Returns/NPT/13WrkDNew.aspx");
        }
        public ActionResult _13WrkE()
        {           
            return View("~/Views/Web/Returns/NPT/13WrkENew.aspx");
        }
        public ActionResult _13WrkK()
        {          
            return View("~/Views/Web/Returns/NPT/13WrkKNew.aspx");
        }
        public ActionResult _NPT_ExemptedMsg()
        {          
            return View("~/Views/Web/Returns/NPT/NPT_ExemptedMsg.aspx");
        }
        #endregion

        #region 2014_Worksheets
        /* ----------------- 14 files -------------------------- */ 
        public ActionResult _14Page4()
        {
            return View("~/Views/Web/Returns/NPT/14WrkNR_3.aspx");
        }
        public ActionResult _14WrkExtension()
        {
            return View("~/Views/Web/Returns/NPT/14WrkExtension.aspx");
        }
        public ActionResult _14WrkA()
        {
            return View("~/Views/Web/Returns/NPT/14WrkA.aspx");
        }
        public ActionResult _14WrkB()
        {
            return View("~/Views/Web/Returns/NPT/14WrkB.aspx");
        }
        public ActionResult _14WrkC()
        {
            return View("~/Views/Web/Returns/NPT/14WrkC.aspx");
        }
        public ActionResult _14WrkD()
        {
            return View("~/Views/Web/Returns/NPT/14WrkD.aspx");
        }
        public ActionResult _14WrkE()
        {
            return View("~/Views/Web/Returns/NPT/14WrkE.aspx");
        }
        public ActionResult _14WrkK()
        {
            return View("~/Views/Web/Returns/NPT/14WrkK.aspx");
        }
        #endregion

        #region 2015_Worksheets
        /* ----------------- 15 files -------------------------- */
        public ActionResult _15WrkExtension()
        {
            return View("~/Views/Web/Returns/NPT/15WrkExtension.aspx");
        }
        public ActionResult _15Page4()
        {
            return View("~/Views/Web/Returns/NPT/15WrkNR_3.aspx");

        }
        public ActionResult _15WrkA()
        {           
            return View("~/Views/Web/Returns/NPT/15WrkANew.aspx");
        }
        public ActionResult _15WrkB()
        {          
            return View("~/Views/Web/Returns/NPT/15WrkBNew.aspx");
        }
        public ActionResult _15WrkC()
        {           
            return View("~/Views/Web/Returns/NPT/15WrkCNew.aspx");
        }
        public ActionResult _15WrkD()
        {           
            return View("~/Views/Web/Returns/NPT/15WrkDNew.aspx");
        }
        public ActionResult _15WrkE()
        {           
            return View("~/Views/Web/Returns/NPT/15WrkENew.aspx");
        }
        public ActionResult _15WrkK()
        {           
            return View("~/Views/Web/Returns/NPT/15WrkKNew.aspx");
        }
        #endregion

        #region 2016_Worksheets
        /* ----------------- 16 files -------------------------- */
        public ActionResult _16WrkExtension()
        {
            return View("~/Views/Web/Returns/NPT/2016/16WrkExtension.aspx");
        }
        public ActionResult _16Page4()
        {
            return View("~/Views/Web/Returns/NPT/2016/16WrkNR_3.aspx");

        }
        public ActionResult _16WrkA()
        {
            return View("~/Views/Web/Returns/NPT/2016/16WrkANew.aspx");
        }
        public ActionResult _16WrkB()
        {
            return View("~/Views/Web/Returns/NPT/2016/16WrkBNew.aspx");
        }
        public ActionResult _16WrkC()
        {
            return View("~/Views/Web/Returns/NPT/2016/16WrkCNew.aspx");
        }
        public ActionResult _16WrkD()
        {
            return View("~/Views/Web/Returns/NPT/2016/16WrkDNew.aspx");
        }
        public ActionResult _16WrkE()
        {
            return View("~/Views/Web/Returns/NPT/2016/16WrkENew.aspx");
        }
        public ActionResult _16WrkK()
        {
            return View("~/Views/Web/Returns/NPT/2016/16WrkKNew.aspx");
        }

        public ActionResult _2016NPT()
        {
            return View("~/Views/Web/Returns/NPT/2016/2016NPT.aspx");
        }

        public ActionResult _16NPT_js()
        {
            return View("~/Views/Web/Returns/NPT/2016/16NPT_js.aspx");
        }


        #endregion
        #region 2017_Worksheets
        /* ----------------- 17 files -------------------------- */
        public ActionResult _17WrkExtension()
        {
            return View("~/Views/Web/Returns/NPT/2017/17WrkExtension.aspx");
        }
        public ActionResult _17Page4()
        {
            return View("~/Views/Web/Returns/NPT/2017/17WrkNR_3.aspx");

        }
        public ActionResult _17WrkA()
        {
            return View("~/Views/Web/Returns/NPT/2017/17WrkANew.aspx");
        }
        public ActionResult _17WrkB()
        {
            return View("~/Views/Web/Returns/NPT/2017/17WrkBNew.aspx");
        }
        public ActionResult _17WrkC()
        {
            return View("~/Views/Web/Returns/NPT/2017/17WrkCNew.aspx");
        }
        public ActionResult _17WrkD()
        {
            return View("~/Views/Web/Returns/NPT/2017/17WrkDNew.aspx");
        }
        public ActionResult _17WrkE()
        {
            return View("~/Views/Web/Returns/NPT/2017/17WrkENew.aspx");
        }
        public ActionResult _17WrkK()
        {
            return View("~/Views/Web/Returns/NPT/2017/17WrkKNew.aspx");
        }

        public ActionResult _2017NPT()
        {
            return View("~/Views/Web/Returns/NPT/2017/2017NPT.aspx");
        }

        public ActionResult _17NPT_js()
        {
            return View("~/Views/Web/Returns/NPT/2017/17NPT_js.aspx");
        }


        #endregion
        /* ----------------- NPT year files ---------------------- */
        #region Year_form
        public ActionResult _2006NPT()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/NPT/2006NPT.htm");
        }
        public ActionResult _2007NPT()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/NPT/2007NPT.htm");
        }
        public ActionResult _2008NPT()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/NPT/2008NPT.htm");
        }
        public ActionResult _2009NPT()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/NPT/2009NPT.htm");
        }
        public ActionResult _2010NPT()
        {
            return View("~/Views/Web/Returns/NPT/2010NPTNew.aspx");
        }
        public ActionResult _2011NPT()
        {
            return View("~/Views/Web/Returns/NPT/2011NPTNew.aspx");
        }
        public ActionResult _2012NPT()
        {           
            return View("~/Views/Web/Returns/NPT/2012NPTNew.aspx");
        }
        public ActionResult _2013NPT()
        {          
            return View("~/Views/Web/Returns/NPT/2013NPTNew.aspx");
        }
        public ActionResult _2014NPT()
        {          
            return View("~/Views/Web/Returns/NPT/2014NPT.aspx");
        }
        public ActionResult _2015NPT()
        {          
            return View("~/Views/Web/Returns/NPT/2015NPT.aspx");
        }
        /* --------------------------------------------------------*/
        #endregion

        /* ----------------- WrkA year files --------------------- */
        public ActionResult WrkA06()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/NPT/WrkA06.htm");
        }
        public ActionResult WrkA07()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/NPT/WrkA07.htm");
        }
        public ActionResult WrkA08()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/NPT/WrkA08.htm");
        }
        /* --------------------------------------------------------*/

        /* ----------------- WrkB year files --------------------- */
        public ActionResult WrkB06()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/NPT/WrkB06.htm");
        }
        public ActionResult WrkB07()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/NPT/WrkBA07.htm");
        }
        public ActionResult WrkB08()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/NPT/WrkB08.htm");
        }
        /* --------------------------------------------------------*/

        /* ----------------- WrkC year files --------------------- */
        public ActionResult WrkC06()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/NPT/WrkC06.htm");
        }
        public ActionResult WrkC07()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/NPT/WrkCA07.htm");
        }
        public ActionResult WrkC08()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/NPT/WrkC08.htm");
        }
        /* --------------------------------------------------------*/

        /* ----------------- WrkD year files --------------------- */
        public ActionResult WrkD06()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/NPT/WrkD06.htm");
        }
        public ActionResult WrkD07()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/NPT/WrkDA07.htm");
        }
        public ActionResult WrkD08()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/NPT/WrkD08.htm");
        }
        /* --------------------------------------------------------*/

        /* ----------------- WrkE year files --------------------- */
        public ActionResult WrkE06()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/NPT/WrkE06.htm");
        }
        public ActionResult WrkE07()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/NPT/WrkE07.htm");
        }
        public ActionResult WrkE08()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/NPT/WrkE08.htm");
        }
        /* --------------------------------------------------------*/

        /* ----------------- WrkK year files --------------------- */
        public ActionResult WrkK06()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/NPT/WrkK06.htm");
        }
        public ActionResult WrkK07()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/NPT/WrkK07.htm");
        }
        public ActionResult WrkK08()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/NPT/WrkK08.htm");
        }
        /* --------------------------------------------------------*/

        /* ----------------- Thank you files --------------------- */
        public ActionResult NPTThankYou()
        {          
            return View("~/Views/Web/Returns/NPT/NPTThankYouNew.aspx");
        }
        /* --------------------------------------------------------*/

        /* ------------------- Page files ------------------------ */
        public ActionResult Page406()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/NPT/Page406.htm");
        }
        public ActionResult Page407()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/NPT/Page407.htm");
        }
        public ActionResult Page408()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/NPT/Page408.htm");
        }
        /* --------------------------------------------------------*/

        /* ------------------- Server files -----------------------*/
        public ActionResult NPT()
        {
            return View("~/Views/Web/Returns/NPT/NPT.aspx");
        }
        public ActionResult NPTReturn()
        {
            return View("~/Views/Web/ReturnServices/NPTReturn.aspx");
        }
        /* --------------------------------------------------------*/

        public ActionResult NPTReturn_2015()
        {
            return View("~/Views/Web/ReturnServices/NPTReturn_2015.aspx");
        }

        public ActionResult NPT_PDF()
        {
            return View("~/Views/Web/PDF_report/NPT/PDF_NPT_create.aspx");
        }


        public ActionResult _10WrkExtension()
        {
            return View("~/Views/Web/Returns/NPT/10WrkExtension.aspx");
        }
        public ActionResult _11WrkExtension()
        {
            return View("~/Views/Web/Returns/NPT/11WrkExtension.aspx");
        }
       
    }
}
