using CopRevenueGov2.Helpers;
using CopRevenueGov2.Models.Web.Returns;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CopRevenueGov2.Controllers
{
    public class ReturnsController : COPBaseController
    {
        //
        // GET: /Returns/

        public ActionResult _12BIRTWrkShtN()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/12BIRTWrkShtN.htm");
        }
        public ActionResult _13BIRTWrkShtN()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/13BIRTWrkShtN.htm");
        }
        public ActionResult _14BIRTWrkShtN()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/14BIRTWrkShtN.htm");
        }//binoy
        public ActionResult _12BIRT_19_3800Message()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/12BIRT_19_3800Message.htm");
        }
        public ActionResult _13BIRT_19_3800Message()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/13BIRT_19_3800Message.htm");
        }
        public ActionResult _14BIRT_19_3800Message()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/14BIRT_19_3800Message.htm");
        }//binoy
        public ActionResult BPTez2003()
        {
            return View("~/Views/Web/Returns/BPTez2003.aspx");
        }

        public ActionResult BPTez2006()
        {
            return View("~/Views/Web/Returns/BPTez2006.aspx");
        }

        public ActionResult BPTez2007()
        {
            return View("~/Views/Web/Returns/BPTez2007.aspx");
        }

        public ActionResult BPTez2008()
        {
            return View("~/Views/Web/Returns/BPTez2008.aspx");
        }

        public ActionResult BPTez2009()
        {
            return View("~/Views/Web/Returns/BPTez2009.aspx");
        }

        public ActionResult BPTez2010()
        {
            //return View("~/Views/Web/Returns/BPTez2010.aspx");
            return View("~/Views/Web/Returns/BPTez2010New.aspx");
        }

        public ActionResult BPTez2011()
        {
            //return View("~/Views/Web/Returns/BPTez2011.aspx");
            return View("~/Views/Web/Returns/BPTez2011New.aspx");

        }

        public ActionResult BPTez2012()
        {
            //return View("~/Views/Web/Returns/BPTez2012.aspx");
            return View("~/Views/Web/Returns/BPTez2012New.aspx");
        }
        public ActionResult BPTez2013()
        {
            //return View("~/Views/Web/Returns/BPTez2013.aspx");
            return View("~/Views/Web/Returns/BPTez2013New.aspx");
        }
        public ActionResult BPTez2014()
        {
            //return View("~/Views/Web/Returns/BPTez2013.aspx");
            return View("~/Views/Web/Returns/BPTez2014.aspx");
        }
        public ActionResult BPTez2015()
        {
            //return View("~/Views/Web/Returns/BPTez2013.aspx");
            return View("~/Views/Web/Returns/BPTez2015New.aspx");
        }
        public ActionResult BPTez_WorkSheetSEZ_2015()
        {
            //return View("~/Views/Web/Returns/BPTez2013.aspx");
            return View("~/Views/Web/Returns/BPTez_WorkSheetSEZ_2015.aspx");
        }
        public ActionResult BPTez_WorkSheetSEZ_2014()
        {
            //return View("~/Views/Web/Returns/BPTez2013.aspx");
            return View("~/Views/Web/Returns/BPTez_WorkSheetSEZ_2014.aspx");
        }

        public ActionResult NPTThankYou(string id)
        {
            BPTezThankYouModel m = new BPTezThankYouModel() { sCurrentYear = id };
            return View("~/Views/Web/Returns/NPT/NPTThankYouNew.aspx", m);
        }

        public ActionResult BPTezThankYou(string id)
        {

            BPTezThankYouModel m = new BPTezThankYouModel() { sCurrentYear = id };
            //return View("~/Views/Web/Returns/BPTezThankYou.aspx",m);
            return View("~/Views/Web/Returns/BPTezThankYouNew.aspx", m);
        }

        public ActionResult BPTlf2009()
        {
            return View("~/Views/Web/Returns/BPTlf2009.aspx");
        }

        public ActionResult BPTlfThankYou()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/BPTlfThankYou.htm");
        }

        public ActionResult HelpPreviousPaidTax()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/HelpPreviousPaidTax.htm");
        }

        public ActionResult LossCarryForward()
        {
            return View("~/Views/Web/Returns/LossCarryForward_dsNew.aspx");
        }

        public ActionResult School()
        {
            return View("~/Views/Web/Returns/School.aspx");
        }

        public ActionResult School2002()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/School2002.htm");
        }

        public ActionResult School2003()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/School2003.htm");
        }

        public ActionResult School2004()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/School2004.htm");
        }

        public ActionResult School2005()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/School2005.htm");
        }

        public ActionResult School2006()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/School2006.htm");
        }

        public ActionResult School2007()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/School2007.htm");
        }

        public ActionResult School2008()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/School2008.htm");
        }

        public ActionResult School2009()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/School2009.htm");
        }

        public ActionResult School2010()
        {
            //  return View("~/Views/Web/Returns/School2010.aspx");
            return View("~/Views/Web/Returns/School2010New.aspx");
        }

        public ActionResult School2011()
        {
            // return View("~/Views/Web/Returns/School2011.aspx");
            return View("~/Views/Web/Returns/School2011New.aspx");
        }

        public ActionResult School2012()
        {
            //return View("~/Views/Web/Returns/School2012.aspx");
            return View("~/Views/Web/Returns/School2012New.aspx");
        }

        public ActionResult School2013()
        {
            //return GetHtmlContentFromFile("~/Views/Web/Returns/School2013.htm");
            // return View("~/Views/Web/Returns/School2013.aspx");
            return View("~/Views/Web/Returns/School2013New.aspx");
        }
        public ActionResult School2014()
        {
            //return GetHtmlContentFromFile("~/Views/Web/Returns/School2013.htm");
            // return View("~/Views/Web/Returns/School2013.aspx");
            return View("~/Views/Web/Returns/School2014New.aspx");
        }

        public ActionResult School2015()
        {
            return View("~/Views/Web/Returns/School2015New.aspx");
        }

        public ActionResult Liquor2013()
        {
            //return GetHtmlContentFromFile("~/Views/Web/Returns/School2013.htm");
            // return View("~/Views/Web/Returns/School2013.aspx");
            return View("~/Views/Web/Returns/Liquor2013.aspx");
        }

        public ActionResult SchoolThankYou(string id)
        {
            SchoolThankYouModel m = new SchoolThankYouModel() { sCurrentYear = id };
            //  return View("~/Views/Web/Returns/SchoolThankYou.aspx", m);
            return View("~/Views/Web/Returns/SchoolThankYouNew.aspx", m);
        }

        public ActionResult Tobacco2010()
        {
            //return View("~/Views/Web/Returns/Tobacco2010.aspx");
            return View("~/Views/Web/Returns/Tobacco2010New.aspx");
        }

        public ActionResult Tobacco2011()
        {
            //return View("~/Views/Web/Returns/Tobacco2011.aspx");
            return View("~/Views/Web/Returns/Tobacco2011New.aspx");

        }

        public ActionResult Tobacco2012()
        {
            // return View("~/Views/Web/Returns/Tobacco2012.aspx");
            return View("~/Views/Web/Returns/Tobacco2012New.aspx");
        }
        public ActionResult Tobacco2013()
        {
            //return View("~/Views/Web/Returns/Tobacco2013.aspx");
            return View("~/Views/Web/Returns/Tobacco2013New.aspx");
        }
        public ActionResult Tobacco2014()
        {
            //return View("~/Views/Web/Returns/Tobacco2013.aspx");
            return View("~/Views/Web/Returns/Tobacco2014New.aspx");
        }
        public ActionResult Tobacco2015()
        {
            //return View("~/Views/Web/Returns/Tobacco2013.aspx");
            return View("~/Views/Web/Returns/Tobacco2015New.aspx");
        }
        public ActionResult TobaccoThankYou(string id)
        {
            TobaccoThankYouModel m = new TobaccoThankYouModel() { sCurrentYear = id };
            //return View("~/Views/Web/Returns/TobaccoThankYou.aspx", m);
            return View("~/Views/Web/Returns/TobaccoThankYouNew.aspx", m);
        }

        public ActionResult Wage2002()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/Wage2002.htm");
        }

        public ActionResult Wage2003()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/Wage2003.htm");
        }

        public ActionResult Wage2004()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/Wage2004.htm");
        }

        public ActionResult Wage2005()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/Wage2005.htm");
        }

        public ActionResult Wage2006()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/Wage2006.htm");
        }

        public ActionResult Wage2007()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/Wage2007.htm");
        }

        public ActionResult Wage2008()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/Wage2008.htm");
        }

        public ActionResult Wage2009()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/Wage2009.htm");
        }

        public ActionResult Wage2010()
        {
            //return View("~/Views/Web/Returns/Wage2010.aspx");
            return View("~/Views/Web/Returns/Wage2010New.aspx");
        }

        public ActionResult Wage2011()
        {
            //return View("~/Views/Web/Returns/Wage2011.aspx");
            return View("~/Views/Web/Returns/Wage2011New.aspx");
        }

        public ActionResult Wage2012()
        {
            //return View("~/Views/Web/Returns/Wage2012.aspx");
            return View("~/Views/Web/Returns/Wage2012New.aspx");
        }

        public ActionResult Wage2013()
        {
            //return GetHtmlContentFromFile("~/Views/Web/Returns/Wage2013.htm");
            //  return View("~/Views/Web/Returns/Wage2013.aspx");
            return View("~/Views/Web/Returns/Wage2013New.aspx");
        }

        public ActionResult Wage2014()
        {
            //return GetHtmlContentFromFile("~/Views/Web/Returns/Wage2013.htm");
            //  return View("~/Views/Web/Returns/Wage2013.aspx");
            return View("~/Views/Web/Returns/Wage2014New.aspx");
        } //binoy
        public ActionResult Wage2015()
        {
           return View("~/Views/Web/Returns/Wage2015.aspx");
        }

        public ActionResult wagetax()
        {
            return GetHtmlContentFromFile("~/Views/Web/Returns/wagetax.htm");
        }

        public ActionResult WageThankYou(string id)
        {
            WageThankYouModel m = new WageThankYouModel() { sCurrentYear = id };

            // return View("~/Views/Web/Returns/WageThankYouNew.aspx", m);
            return View("~/Views/Web/Returns/WageThankYouNew.aspx", m);
        }

        public ActionResult BPTez()
        {
            return View("~/Views/Web/Returns/BPTez.aspx");
        }

        public ActionResult LossCarryForwardAsp()
        {
            return View("~/Views/Web/Returns/LossCarryForward.aspx");
        }

        public ActionResult LossCarryForwardReturn()
        {
            return View("~/Views/Web/Returns/LossCarryForwardReturn.aspx");
        }

        public ActionResult Returns()
        {
            return View("~/Views/Web/Returns/Returns.aspx");
        }

        public ActionResult SchoolAsp()
        {
            return View("~/Views/Web/Returns/School.aspx");
        }

        public ActionResult Tobacco()
        {
            return View("~/Views/Web/Returns/Tobacco.aspx");
        }

        public ActionResult Wage()
        {
            return View("~/Views/Web/Returns/Wage.aspx");
        }



    }
}
