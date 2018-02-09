using CopRevenueGov2.Service;
using COPXmlFactory;
using COPXmlFactory.RTTIE031;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Xml;

namespace CopRevenueGov2.Helpers
{
    public class RTTIE031 : CopRestServiceBase, ICopSoapService
    {

        static RTTIE031_SrvRef.RTTIE231WS_PortType _client = null;

        public static void Init()
        {
            _client = COPServiceURLHelper.GetServiceClient_RTTIE031();
        }

        public static string CallService(string Request)
        {
            COPXmlFactory.RTTIE031.LossCarryForward xo;

            try
            {
                xo = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE031.LossCarryForward>(Request);

                xo = __Call(xo);

            }
            catch (Exception ex)
            {
                xo =
                    RevenueGovXMLFactory.GetLossCarryForwardReturn();

                xo.ERROR_INFO = new ERROR_INFO();
                xo.ERROR_INFO.ERROR = 11.ToString();
                xo.ERROR_INFO.MESSAGE = ex.Message;
            }

            return RevenueGovXMLFactory.GetXmlString(xo);

        }

        public static XmlDocument CallService(XmlDocument Request)
        {
            COPXmlFactory.RTTIE031.LossCarryForward acct;

            try
            {
                string InnerXML = Request.InnerXml;
                acct = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE031.LossCarryForward>(InnerXML);

                acct = __Call(acct);

            }
            catch (Exception ex)
            {
                acct =RevenueGovXMLFactory.GetLossCarryForwardReturn();

                acct.ERROR_INFO = new ERROR_INFO();
                acct.ERROR_INFO.ERROR = 11.ToString();
                acct.ERROR_INFO.MESSAGE = ex.Message;
            }

            return RevenueGovXMLFactory.GetXmlDocument(acct);
        }
        private static LossCarryForward __Call(LossCarryForward e)
        {
            e = __RTTIE031_F_I(e);
            return e;

        }
        private static COPXmlFactory.RTTIE031.LossCarryForward __RTTIE031_F_I(COPXmlFactory.RTTIE031.LossCarryForward e)
        {
         //   RTTIE031_SrvRef.RTTIE231 serv_req = new RTTIE031_SrvRef.RTTIE231();
            RTTIE031_SrvRef.RTTIE231Request serv_req = new RTTIE031_SrvRef.RTTIE231Request();

            serv_req.RTTIE231 = new RTTIE031_SrvRef.RTTIE231();
            serv_req.RTTIE231._ELCF = new RTTIE031_SrvRef._ELCF();

            serv_req.RTTIE231._ELCF.ACCOUNTID = e.LCF_INFO.ACCOUNT_ID;
            serv_req.RTTIE231._ELCF.YEARX = e.LCF_INFO.YEAR_X;

           


            RTTIE031_SrvRef.RTTIE231Response1 response = _client.RTTIE231(serv_req);

            e = __Fill(response);

            return e;
        }
        private static COPXmlFactory.RTTIE031.LossCarryForward __Fill(RTTIE031_SrvRef.RTTIE231Response1 e)
        {
            COPXmlFactory.RTTIE031.LossCarryForward fobj = new LossCarryForward();

            //LOAD ERRORS INTO OBJECT
            fobj.ERROR_INFO = new ERROR_INFO();

            fobj.ERROR_INFO.PROGRAM = e.RTTIE231Response._SMA._PROGRAM;
            fobj.ERROR_INFO.LINE = e.RTTIE231Response._SMA.ERRORLINE.ToString();
            fobj.ERROR_INFO.MESSAGE = e.RTTIE231Response._SMA.MESSAGE;
            fobj.ERROR_INFO.ERROR = e.RTTIE231Response._SMA.SYSTEMERROR.ToString();

            //LOAD LCF_INFO 
            fobj.LCF_INFO = new LCF_INFO();
            fobj.LCF_INFO.ACCOUNT_ID = e.RTTIE231Response._ELCF.ACCOUNTID;
            fobj.LCF_INFO.YEAR_X = e.RTTIE231Response._ELCF.YEARX;
            fobj.LCF_INFO.EST_PAID_X = e.RTTIE231Response._ELCF.ESTPAIDX;
            fobj.LCF_INFO.YEAR = e.RTTIE231Response._ELCF.YEAR;
            fobj.LCF_INFO.AMOUNT = CopMvcUtil.ConvDigitToCurrency(e.RTTIE231Response._ELCF.AMOUNT);
            fobj.LCF_INFO.COMMENT = e.RTTIE231Response._ELCF.COMMENT;
            fobj.LCF_INFO.YEAR_1 = e.RTTIE231Response._ELCF.YEAR1;
            fobj.LCF_INFO.INCOME_1 = CopMvcUtil.ConvDigitToCurrency(e.RTTIE231Response._ELCF.INCOME1);
            fobj.LCF_INFO.COMMENT_1 = e.RTTIE231Response._ELCF.COMMENT1;
            fobj.LCF_INFO.YEAR_2 = e.RTTIE231Response._ELCF.YEAR2;
            fobj.LCF_INFO.INCOME_2 = CopMvcUtil.ConvDigitToCurrency(e.RTTIE231Response._ELCF.INCOME2);
            fobj.LCF_INFO.COMMENT_2 = e.RTTIE231Response._ELCF.COMMENT2;
            fobj.LCF_INFO.YEAR_3 = e.RTTIE231Response._ELCF.YEAR3;
            fobj.LCF_INFO.INCOME_3 = CopMvcUtil.ConvDigitToCurrency(e.RTTIE231Response._ELCF.INCOME3);
            fobj.LCF_INFO.COMMENT_3 = e.RTTIE231Response._ELCF.COMMENT3;

           
            return fobj;

        }
    }

}
