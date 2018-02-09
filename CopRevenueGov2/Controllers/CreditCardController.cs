using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CopRevenueGov2.Controllers
{
    public class CreditCardController : COPBaseController
    {
        //
        // GET: /CreditCard/

        public ActionResult CCPage()
        {          
            return View("~/Views/Web/CreditCard/CCPageNew.aspx");
        }       

        public ActionResult GetPage()
        {
            return View("~/Views/Web/CreditCard/GetPage.htm");
        }

        public ActionResult Initialize()
        {
            return View("~/Views/Web/CreditCard/Initialize.htm");
        }

    }
}
