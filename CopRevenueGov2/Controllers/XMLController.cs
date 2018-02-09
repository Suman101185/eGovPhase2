using CopRevenueGov2.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CopRevenueGov2.Controllers
{
    public class XMLController : COPBaseController
    {
        //
        // GET: /XML/

        public ActionResult AccountInfo()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/AcctInfo.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/AcctInfo.xml");
            }
        }

        public ActionResult AcctTemplate()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/AcctTemplate.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/AcctTemplate.xml");
            }
        }

        public ActionResult AddressCheck()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/AddressCheck.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/AddressCheck.xml");
            }
        }
        public ActionResult Code1AddressCheck()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/Code1AddressCheck.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/Code1AddressCheck.xml");
            }
        }

        public ActionResult AddressType()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/AddressType.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/AddressType.xml");
            }
        }


        public ActionResult AddressType2()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/AddressType2.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/AddressType2.xml");
            }
        }

        public ActionResult BPTezReturn()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/BPTezReturn.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/BPTezReturn.xml");
            }
        }

        public ActionResult BPTlfReturn()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/BPTlfReturn.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/BPTlfReturn.xml");
            }
        }
        public ActionResult BPTlfReturn_2014()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/BPTlfReturn_2014.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/BPTlfReturn_2014.xml");
            }
        }
        public ActionResult BPTlfReturn_2015()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/BPTlfReturn_2015.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/BPTlfReturn_2015.xml");
            }
        }
        public ActionResult BPTezReturn_2014()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/BPTezReturn_2014.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/BPTezReturn_2014.xml");
            }
        }
        public ActionResult BPTezReturn_2015()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/BPTezReturn_2015.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/BPTezReturn_2015.xml");
            }
        }
        public ActionResult BPTezReturn_2016()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/BPTezReturn_2016.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/BPTezReturn_2016.xml");
            }
        }
        public ActionResult NPTReturn_2015()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/NPTReturn_2015.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/NPTReturn_2015.xml");
            }
        }
     
      
        public ActionResult CCBilling()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/CCBilling.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/CCBilling.xml");
            }
        }

        public ActionResult DelinquentForm()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/DelinquentForm.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/DelinquentForm.xml");
            }
        }

        public ActionResult EntityType()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/EntityType.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/EntityType.xml");
            }
        }

        public ActionResult Ethnicity()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/Ethnicity.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/Ethnicity.xml");
            }
        }

        public ActionResult EntityTypeCoupon()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/EntityTypeCoupon.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/EntityTypeCoupon.xml");
            }
        }

        public ActionResult ERNReturn()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/ERNReturn.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/ERNReturn.xml");
            }
        }

        public ActionResult email()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/email.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/email.xml");
            }
        }

        public ActionResult LossCarryForward()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/LossCarryForward.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/LossCarryForward.xml");
            }
        }

        public ActionResult NAIC()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/NAIC.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/NAIC.xml");
            }
        }

        public ActionResult NPTReturn()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/NPTReturn.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/NPTReturn.xml");
            }
        }

        public ActionResult OrgType()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/OrgType.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/OrgType.xml");
            }
        }

        public ActionResult Output()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/Output.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/Output.xml");
            }
        }

        public ActionResult Sex()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/Sex.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/Sex.xml");
            }
        }

        public ActionResult Statezip()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/Statezip.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/Statezip.xml");
            }
        }

        public ActionResult Relationship()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/Relationship.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/Relationship.xml");
            }
        }

        public ActionResult SchoolReturn()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/SchoolReturn.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/SchoolReturn.xml");
            }
        }

        public ActionResult TobaccoReturn()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/TobaccoReturn.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/TobaccoReturn.xml");
            }
        }

        public ActionResult UOForm()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/UOForm.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/UOForm.xml");
            }
        }
        public ActionResult UOFormNew()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/UOFormNew.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/UOFormNew.xml");
            }
        }

        public ActionResult UOList()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/UOList.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/UOList.xml");
            }
        }

        public ActionResult UOReturn()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/UOReturn.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/UOReturn.xml");
            }
        }

        public ActionResult WageReturn()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/WageReturn.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/WageReturn.xml");
            }
        }
        public ActionResult LiquorReturn()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/LiquorReturn.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/LiquorReturn.xml");
            }
        }

        public ActionResult PayCoupon()
        {
            if (Request.Browser.IsMobileDevice)
            {
                return GetXMLContentFromFile("~/views/web/xml/PayCoupon.xml");
            }
            else
            {
                return GetXMLContentFromFile("~/views/web/xml/PayCoupon.xml");
            }
        }

    }
}
