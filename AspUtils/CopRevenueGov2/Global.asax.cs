using CopRevenueGov2.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Routing;

namespace CopRevenueGov2
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            CopQueryString.Initialize();
            COPSession.Initialize();
            COPAppSettings.Initialize();

            AreaRegistration.RegisterAllAreas();

            WebApiConfig.Register(GlobalConfiguration.Configuration);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
        }


        /*
        <!--==Visual InterDev Generated - startspan==-->
        <!--METADATA TYPE="TypeLib" NAME="Microsoft ADO Type Library" UUID="{00000200-0000-0010-8000-00AA006D2EA4}" VERSION="1.0"-->
        <!--METADATA TYPE="TypeLib" NAME="Microsoft XML" UUID="{D63E0CE2-A0A2-11D0-9C02-00C04FC99C8E}" VERSION="2.0"-->
        <!--METADATA TYPE="TypeLib" NAME="Microsoft Scripting Runtime" UUID="{420B2830-E718-11CF-893D-00A0C9054228}" VERSION="1.0"-->
        <!--==Visual InterDev Generated - endspan==-->
        <SCRIPT LANGUAGE=VBScript RUNAT=Server>
         * 
         * */

        /*
        'You can add special event handlers in this file that will get run automatically when
        'special Active Server Pages events occur. To create these handlers, just create a
        'subroutine with a name from the list below that corresponds to the event you want to
        'use. For example, to create an event handler for Session_OnStart, you would put the
        'following code into this file (without the comments):

        'EventName              Description

                */


        //Runs the first time a user runs any page in your application
        void Session_OnStart()
        {
            string ServerIP, AppPath;

            ServerIP = Request.ServerVariables["SERVER_NAME"].ToString().ToUpper();
            AppPath = Request.ServerVariables["URL"].ToString().ToUpper();

            //General Info
            COPSession.SERVERIP = ServerIP;
            COPSession.APPPATH = AppPath;
            //EGOVWEB-85 - EDD
            COPSession.TITLE = "City Of Philadelphia - Taxpayer Information (v5.6.6)";
            COPSession.DEBUG = false;
            

//            ''Email Info
//    Session("EMAIL_PATH") = EmailPath(ucase(Request.ServerVariables("PATH_TRANSLATED")))
//    Session("EMAIL_CITY_SEAL") = "http://is-partner.com/wage/images/cityseal.gif"
//    Session("EMAIL_SPACER") = "http://is-partner.com/wage/images/ispDot.gif"
//'EGOVWEB-32
//    Session("EMAIL_IP_ADDR") = "localhost"
//    Session("EMAIL_COMMENTS_TO") = "abhijit.chakraborty@datacoresystems.com"
//    Session("EMAIL_LOG_TO") = "abhijit.chakraborty@datacoresystems.com"
//    Session("EMAIL_ERROR_TO") = "abhijit.chakraborty@datacoresystems.com"
//    Session("EMAIL_FROM") = "revenue@phila.gov"


            //Email Info
           
            COPSession.EMAIL_CITY_SEAL = "http://is-partner.com/wage/images/cityseal.gif";
            COPSession.EMAIL_SPACER = "http://is-partner.com/wage/images/ispDot.gif";
            //EGOVWEB-32
          //  COPSession.EMAIL_IP_ADDR = "localhost";
            COPSession.EMAIL_IP_ADDR = "192.168.32.36";
            COPSession.EMAIL_COMMENTS_TO = "chayan.das@datacoresystems.com"; //"Charletta.Kidd@phila.gov";
            COPSession.EMAIL_LOG_TO = "chayan.das@datacoresystems.com";//"Charletta.Kidd@phila.gov";
            COPSession.EMAIL_ERROR_TO = "chayan.das@datacoresystems.com"; //"Charletta.Kidd@phila.gov";
            COPSession.EMAIL_ERROR_TO = "Revenue.Online.Services.Err.Msgs@phila.gov,Paul.Ricchiuti@phila.gov,Gerard.Grover@phila.gov";
            COPSession.EMAIL_FROM = "revenue@phila.gov";

            //Credit Card Info
            COPSession.CC_SiteName = "https://mylocalgov.com/cityofphiladelphiapa/pubbizinq5tst.asp";
            COPSession.CC_Rev_MerchantID = "8001342800";
            COPSession.CC_CF_MerchantID = "8001346298";		//Convience Fee
            COPSession.CC_BPT_SourceCodeIndex = "370201263601";
            COPSession.CC_BPT_LicenseFee = "300.00";
            COPSession.CC_TestCardNumber = "";
            COPSession.CC_TestCardExpireDate = "";
            //EGOVWEB-34 - Added
            COPSession.CC_SiteName = "https://secure.phila.gov/PaymentCenter/Gateway1/InitiatePurchase.aspx";
            COPSession.CC_BP_Lic_ePay_ID = "8832f318-2c18-47d5-9b9b-7a81b20cd7dd";
            COPSession.CC_School_ePay_ID = "c9621ef3-5d94-4b96-864c-bb3645540b34";
            COPSession.CC_Wage_ePay_ID = "21913e19-f7f7-4ab0-9210-450b292b5f51";
            COPSession.CC_NPT_ePay_ID = "7e1417da-5079-4014-a222-be1d8dd43f47";
            COPSession.CC_BPT_ePay_ID = "f90b7a7a-a131-4364-b00e-15773bbf44e0";
            COPSession.CC_TOBACCO_ePay_ID = "a7c3ecc3-9378-42f4-a8b4-b5235969ced8";
            COPSession.CC_UO_ePay_ID = "b50d87e8-f202-4d6b-8c2e-a0c13a85c125";
            COPSession.CC_DB_ePay_ID = "48b8c15c-1b07-4b94-b9d3-bf97290a44e5";

            COPSession.EOLFORMXML = "";
            COPSession.WsAddress = "http://170.115.99.91/code1.service/Service1.asmx";

            if (COPSession.UserID == "")
            {
                COPSession.UserID = ParseLogon(Request.ServerVariables["LOGON_USER"]).ToUpper();
            }

            //For Development Environment
            if (COPAppSettings.ENVIRONMENT == "DEV")
            {
                COPSession.ENVIRONMENT = "S";
                //COPSession.SagAddress"] = "ETB135:18024@RPC/SRV4/CALLNAT";
                COPSession.SagAddress = "http://isdev:5555/rest/";
                /*******************/
                COPSession.CC_SiteName = "https://test-secure.phila.gov/PaymentCenter/Gateway1/InitiatePurchase.aspx";
                COPSession.EMAIL_COMMENTS_TO = "chayan.das@datacoresystems.com"; //"edd@is-partner.com"
                COPSession.EMAIL_LOG_TO = "chayan.das@datacoresystems.com"; // "edd@is-partner.com"
                COPSession.EMAIL_ERROR_TO = "chayan.das@datacoresystems.com"; //"edd@is-partner.com"
                //For City Development Environment

                    COPSession.TITLE = COPSession.TITLE + " (DEVELOPMENT CITY)";
                    COPSession.EMAIL_COMMENTS_CC = "chayan.das@datacoresystems.com"; //"toni.curtis-ford@phila.gov"
                    COPSession.EMAIL_ERROR_CC = "chayan.das@datacoresystems.com"; //"Michael.Pritchard@phila.gov"
                    COPSession.WsAddress = "http://dotapptest01.city.phila.local/code1.service/service1.asmx";
                    COPSession.EMAIL_FROM = "edd@is-partner.com";

                //SUMAN : ENVIRONMENT DETECTION SYSTEM HAS BEEN CHANGED AND CODE BELOW IS NO LONGER VALID
                //HOWEVER WE UNABLE TO UNDERSTAND WHAT THIS LINE DO IN REALLITY : EMAIL_IP_ADDR = "208.247.85.73";
                    //For ISP Development Environment
                    //COPSession.EMAIL_IP_ADDR = "208.247.85.73";
                    //COPSession.EMAIL_FROM = "edd@is-partner.com";
                    //COPSession.TITLE = COPSession.TITLE + " (DEVELOPMENT ISP)";
                
            }
            //For Test Environment
            else if (COPAppSettings.ENVIRONMENT == "TEST")
            {
                COPSession.ENVIRONMENT = "S";
                COPSession.SagAddress = "ETB135:18024@RPC/SRV4/CALLNAT";
                //EGOVWEB-34 - Changed
                COPSession.CC_SiteName = "https://test-secure.phila.gov/PaymentCenter/Gateway1/InitiatePurchase.aspx";
                COPSession.EMAIL_COMMENTS_TO = "chayan.das@datacoresystems.com"; //"edd@is-partner.com"
                COPSession.EMAIL_LOG_TO = "chayan.das@datacoresystems.com"; //"edd@is-partner.com"
                COPSession.EMAIL_ERROR_TO = "Revenue.Online.Services.Err.Msgs@phila.gov,Paul.Ricchiuti@phila.gov,Gerard.Grover@phila.gov";

                COPSession.ENVIRONMENT = "S";
                COPSession.TITLE = COPSession.TITLE + " (TEST CITY)";
                COPSession.EMAIL_COMMENTS_CC = "chayan.das@datacoresystems.com"; //"toni.curtis-ford@phila.gov"
                COPSession.EMAIL_ERROR_CC = "chayan.das@datacoresystems.com"; //"Michael.Pritchard@phila.gov"
                COPSession.WsAddress = "http://dotapptest01.city.phila.local/code1.service/service1.asmx";

                //SUMAN : ENVIRONMENT DETECTION SYSTEM HAS BEEN CHANGED AND CODE BELOW IS NO LONGER VALID
                //HOWEVER WE UNABLE TO UNDERSTAND WHAT THIS LINE DO IN REALLITY : EMAIL_IP_ADDR = "208.247.85.73";

                //For ISP Test Environment
                //COPSession.EMAIL_IP_ADDR = "208.247.85.73";
                //COPSession.EMAIL_FROM = "edd@is-partner.com";
                //COPSession.TITLE = COPSession.TITLE + " (TEST ISP)";                
            }
            //
            //Changed from SECURE.PHILA.GOV to EWORK.PHILA.GOV
            else if (COPAppSettings.ENVIRONMENT == "UNKNOWN")
            {
                COPSession.ENVIRONMENT = "P";
                COPSession.SagAddress = "ETB136:18024@RPC/SRV4/CALLNAT";
                COPSession.WsAddress = "http://moisappprd01.phila.gov/code1.service/service1.asmx";
                COPSession.EMAIL_COMMENTS_TO = "chayan.das@datacoresystems.com";
                COPSession.EMAIL_COMMENTS_CC = "chayan.das@datacoresystems.com";
                COPSession.EMAIL_LOG_TO = "chayan.das@datacoresystems.com";
                COPSession.EMAIL_LOG_CC = "chayan.das@datacoresystems.com";
                COPSession.EMAIL_ERROR_TO = "Revenue.Online.Services.Err.Msgs@phila.gov";
                //EGOVWEB-85 - EDD Added Paul
                COPSession.EMAIL_ERROR_CC = "Paul.Ricchiuti@phila.gov,Gerard.Grover@phila.gov";
            }
            else
            {
                Response.Redirect("http://www.Phila.Gov/Revenue");
            }

            if (COPAppSettings.DEBUG_PATH.ToString() != "")
            {
                COPSession.DEBUG = true;
            }

            COPServiceURLHelper.Initialize();
            InitServices();
        }

        void Session_OnEnd()
        {
            CopMvcUtil util = new CopMvcUtil();
            if (HttpContext.Current != null)
            {
                string path = CopMvcUtil.GetString(COPAppSettings.COUPON_PATH);
                path += HttpContext.Current.Session.SessionID + "*.*";
                util.DeleteFile(path);
            }
            COPSession.ClearAll();
        }

        public void Application_OnEnd()
        {


        }

        string ParseLogon(string strLogon)
        {
            int FirstMatch = 0;
            int SecondMatch = 0;

            FirstMatch = VB.instr(1,strLogon, @"\");
            do
            {
                SecondMatch = VB.instr(FirstMatch + 1,strLogon, @"\");
                if( SecondMatch >= 0 )
                {
                    FirstMatch = SecondMatch;
                }
                else
                {
                    break;
                }
            }while(SecondMatch >= 0);

            return VB.mid(strLogon, FirstMatch + 1);
        }

        void InitServices()
        {
            RTTIE010.Init();
            RTTIE016.Init();
            RTTIE037.Init();
            RTTIE031.Init();
            RTTIE034.Init();
            RTTIE028.Init();
            RTTIE036.Init();
            RTTIE027.Init();
            RTTIE022.Init();
            RTTIE030.Init();
            RTTIE016.Init();
            RTTIE039.Init();
            RTTIE035.Init();
            RTTIE035New.Init();
            RTTIE029.Init();
            Code1Service.Init();
            RTTIE030_2014.Init();
            RTTIE030_2015.Init();
            RTTIE037_2014.Init();
            RTTIE039_2015.Init();
            RTTIE037_2015.Init();
           
        }

    }
}