using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace AspUtils
{
    public class ControllerBaseUtil:Controller
    {
        static string __1_TempDataKey = "COCKSHA_112234_";

        protected static string GeyTempDataKey()
        {
            if (string.IsNullOrEmpty(__1_TempDataKey))
            {
                __1_TempDataKey = Guid.NewGuid().ToString();
            }
            return __1_TempDataKey;
        }


        protected new RedirectToRouteResult RedirectToAction(string actionName, string controllerName, object InterRouteTempData)
        {
            SetInterRouteValue(InterRouteTempData);
            return base.RedirectToAction(actionName, controllerName);
        }

        protected new RedirectToRouteResult RedirectToAction(string actionName, object InterRouteTempData)
        {
            SetInterRouteValue(InterRouteTempData);
            return base.RedirectToAction(actionName);
        }

        protected object GetInterRouteValue()
        {
            object o = TempData[GeyTempDataKey()];
            if (o == null)
            {
                return null;
            }
            return o;
        }

        protected void SetInterRouteValue(object Value)
        {
            TempData[GeyTempDataKey()] =  Value;
        }
    }

    [AttributeUsage(AttributeTargets.Method, AllowMultiple = false, Inherited = true)]
    public class MultiButtonAttribute : ActionNameSelectorAttribute
    {
        public string MatchFormKey { get; set; }
        public string MatchFormValue { get; set; }

        public override bool IsValidName(ControllerContext controllerContext, string actionName, MethodInfo methodInfo)
        {
            return controllerContext.HttpContext.Request[MatchFormKey] != null &&
                controllerContext.HttpContext.Request[MatchFormKey] == MatchFormValue;
        }
    }
}
