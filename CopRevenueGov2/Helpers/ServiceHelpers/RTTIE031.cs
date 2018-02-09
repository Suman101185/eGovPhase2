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

        public static void Init()
        {
            
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

            LCF_RTTIE031_SrvRef.RTTIE031_ELCF _ELCF = new LCF_RTTIE031_SrvRef.RTTIE031_ELCF();
            LCF_RTTIE031_SrvRef.RTTIE031 serv_req = new LCF_RTTIE031_SrvRef.RTTIE031();
            LCF_RTTIE031_SrvRef.RTTIE031Response_SMA _SMAResponse = new LCF_RTTIE031_SrvRef.RTTIE031Response_SMA();
            LCF_RTTIE031_SrvRef.RTTIE031Response_ELCF _ELCFResponse = new LCF_RTTIE031_SrvRef.RTTIE031Response_ELCF();            

            _ELCF.ACCOUNTID = e.LCF_INFO.ACCOUNT_ID;
            _ELCF.YEARX = e.LCF_INFO.YEAR_X;

            _SMAResponse = serv_req.CallRTTIE031
                                                ( new LCF_RTTIE031_SrvRef.RTTIE031_SMA(), _ELCF,
                                                  out _ELCFResponse
                                                );

            e = __Fill(_SMAResponse, _ELCFResponse);
            return e;
        }
        private static COPXmlFactory.RTTIE031.LossCarryForward __Fill(LCF_RTTIE031_SrvRef.RTTIE031Response_SMA _SMA,LCF_RTTIE031_SrvRef.RTTIE031Response_ELCF _ELCF)
        {
            COPXmlFactory.RTTIE031.LossCarryForward fobj = new LossCarryForward();

            //LOAD ERRORS INTO OBJECT
            fobj.ERROR_INFO = new ERROR_INFO();
            if (_SMA != null)
            {
                fobj.ERROR_INFO.PROGRAM = _SMA._PROGRAM;
                fobj.ERROR_INFO.LINE = _SMA.ERRORLINE.ToString();
                fobj.ERROR_INFO.MESSAGE = _SMA.MESSAGE;
                fobj.ERROR_INFO.ERROR = _SMA.SYSTEMERROR.ToString();
            }
            //LOAD LCF_INFO 
            fobj.LCF_INFO = new LCF_INFO();
           
                fobj.LCF_INFO.ACCOUNT_ID = _ELCF.ACCOUNTID;
                fobj.LCF_INFO.YEAR_X = _ELCF.YEARX;
                fobj.LCF_INFO.EST_PAID_X = CopMvcUtil.ConvDigitToCurrency(_ELCF.ESTPAIDX);
                fobj.LCF_INFO.YEAR = _ELCF.YEAR;
                fobj.LCF_INFO.AMOUNT = CopMvcUtil.ConvDigitToCurrency(_ELCF.AMOUNT);
                fobj.LCF_INFO.COMMENT = _ELCF.COMMENT;
                fobj.LCF_INFO.YEAR_1 = _ELCF.YEAR1;
                fobj.LCF_INFO.INCOME_1 = CopMvcUtil.ConvDigitToCurrency(_ELCF.INCOME1);
                fobj.LCF_INFO.COMMENT_1 = _ELCF.COMMENT1;
                fobj.LCF_INFO.YEAR_2 = _ELCF.YEAR2;
                fobj.LCF_INFO.INCOME_2 = CopMvcUtil.ConvDigitToCurrency(_ELCF.INCOME2);
                fobj.LCF_INFO.COMMENT_2 = _ELCF.COMMENT2;
                fobj.LCF_INFO.YEAR_3 = _ELCF.YEAR3;
                fobj.LCF_INFO.INCOME_3 = CopMvcUtil.ConvDigitToCurrency(_ELCF.INCOME3);
                fobj.LCF_INFO.COMMENT_3 = _ELCF.COMMENT3;
            
           
            return fobj;

        }
    }

}
