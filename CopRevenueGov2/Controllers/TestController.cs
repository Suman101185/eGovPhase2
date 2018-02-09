using CopRevenueGov2.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CopRevenueGov2.Controllers
{
    public class TestController : COPBaseController
    {
        //
        // GET: /Test/

        public ActionResult Index()
        {
            return View("~/views/web/testpages/SessionMutiUserTest.aspx");
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult File(CopRevenueGov2.Models.SessionMutiuserTestModel model)
        {
            RevFuncSrv r = new RevFuncSrv();
            r.WriteDebugFile("ABCD_TEST.txt", "THIS IS FILE CREATE TEST ... ");
            return View("~/views/web/testpages/SessionMutiUserTest.aspx", model);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Submit(CopRevenueGov2.Models.SessionMutiuserTestModel model)
        {
            COPSession.UserID =  model.txt_user_id;
            return View("~/views/web/testpages/SessionMutiUserTest.aspx", model);
        }


        public ActionResult TableDesignTest()
        {
            return View("~/views/web/testpages/table_design_test.aspx");
        }
    }
}
