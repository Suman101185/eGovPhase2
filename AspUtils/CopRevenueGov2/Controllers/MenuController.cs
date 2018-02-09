using CopRevenueGov2.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CopRevenueGov2.Controllers
{
    public class MenuController : COPBaseController
    {
        //
        // GET: /Menu/

        public ActionResult Navigation()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return View("~/views/web/menu/Navigation.aspx");
            }
            else
            {
                return View("~/views/web/menu/Navigation.aspx");
            }


        }

        public ActionResult Menu()
        {
            if (Request.Browser.IsMobileDevice)
            {
               // return GetHtmlContentFromFile("~/views/web/menu/Menu.htm");
                return View("~/views/web/menu/MenuNew1.aspx");
            }
            else
            {
               // return GetHtmlContentFromFile("~/views/web/menu/Menu.htm");
                 return View("~/views/web/menu/MenuNew1.aspx");
            }
            }
        }

    }

