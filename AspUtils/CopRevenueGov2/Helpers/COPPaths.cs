using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CopRevenueGov2.Helpers
{
    public class COPPaths
    {
        public static string COUPON_PATH
        {
            get
            {
                return HttpContext.Current.Server.MapPath(COPAppSettings.COUPON_PATH) + @"\";
            }
        }
    }
}