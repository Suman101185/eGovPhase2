using CopRevenueGov2.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CopRevenueGov2
{
    public class COPBaseController:Controller
    {
        CopMvcUtil utl = new CopMvcUtil();

        protected ContentResult GetHtmlContentFromFile(string ServerRelativePath)
        {
            try
            {
                string htms = utl.GetHTMLString(Server.MapPath(ServerRelativePath));
                HtmlString hts = new HtmlString(htms);
                return this.Content(hts.ToHtmlString(), "text/html");
                //return this.Content(htms, "text/html");
            }
            catch (Exception ex)
            {
                return this.Content(ex.StackTrace.ToString(), "text/html");
            }
        }

        protected ContentResult GetXMLContentFromFile(string ServerRelativePath)
        {
            try
            {
                string xstr = utl.GetXMLString(Server.MapPath(ServerRelativePath));
                return this.Content(xstr, "text/xml");
            }
            catch (Exception ex)
            {
                return this.Content(ex.StackTrace.ToString(), "text/html");
            }
        }

    }
}