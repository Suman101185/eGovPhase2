using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace CopRevenueGov2
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");


            RouteTable.Routes.MapRoute("ReturnRouteUO", "Returns/UO/{action}", new { Controller = "UO" });
            RouteTable.Routes.MapRoute("ReturnRouteERN", "Returns/ERN/{action}", new { Controller = "ERN" });
            RouteTable.Routes.MapRoute("ReturnRouteNPT", "Returns/NPT/{action}", new { Controller = "NPT" });
            RouteTable.Routes.MapRoute("ReturnRouteBPT_LF", "Returns/BPT_LF/{action}/{id}", new { Controller = "BPT_LF", id = UrlParameter.Optional });

            /* RouteTable.Routes.MapRoute(name : "CustomDefault",
                url: "{action}", 
                defaults: new { Controller = "Home" },
                namespaces: new string[] { "CopRevenueGov2.Controllers" }); 


            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional },
                namespaces: new string[] { "CopRevenueGov2.Controllers" }

            ); */

            RouteTable.Routes.MapRoute(name: "CustomDefault",
                url: "{action}",
                defaults: new { Controller = "Home" });


            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );


        }
    }
}