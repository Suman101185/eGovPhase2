using CopRevenueGov2.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CopRevenueGov2.Controllers
{
    public class IncController : COPBaseController
    {
        //
        // GET: /Inc/

        public ActionResult AppHeader()
        {
            return GetHtmlContentFromFile("~/Views/Web/Inc/AppHeader.htm");
        }

        public ActionResult HeaderInfo()
        {
            return GetHtmlContentFromFile("~/Views/Web/Inc/HeaderInfo.htm");
        }

        public ActionResult Progress()
        {
            return View("~/Views/Web/Inc/Progress.aspx");
        }

        public ActionResult PreparerSection()
        {           
            return View("~/Views/Web/Inc/PreparerSectionNew.aspx");
        }
        

    }
}
