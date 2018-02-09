using CopRevenueGov2.Service;
using COPXmlFactory;
using COPXmlFactory.RTTIE034;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Xml;

namespace CopRevenueGov2.Helpers
{
    public class RTTIE034 : CopRestServiceBase, ICopSoapService
    {

        static RTTIE034_SrvRef.RTTIE234WS_PortType _client = null;

        public static void Init()
        {
            _client = COPServiceURLHelper.GetServiceClient_RTTIE034();
        }

        public static string CallService(string Request)
        {
            COPXmlFactory.RTTIE034.UOLIST xo;

            try
            {
                xo = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE034.UOLIST>(Request);

                xo = __Call(xo);

            }
            catch (Exception ex)
            {
                xo =
                    RevenueGovXMLFactory.GetUOLISTReturn();

                xo.ERROR_INFO = new ERROR_INFO();
                xo.ERROR_INFO.ERROR = 11.ToString();
                xo.ERROR_INFO.MESSAGE = ex.Message;
            }

            return RevenueGovXMLFactory.GetXmlString(xo);

        }

        public static XmlDocument CallService(XmlDocument Request)
        {
            COPXmlFactory.RTTIE034.UOLIST acct;

            try
            {
                string InnerXML = Request.InnerXml;
                acct = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE034.UOLIST>(InnerXML);

                acct = __Call(acct);

            }
            catch (Exception ex)
            {
                acct = RevenueGovXMLFactory.GetUOLISTReturn();

                acct.ERROR_INFO = new ERROR_INFO();
                acct.ERROR_INFO.ERROR = 11.ToString();
                acct.ERROR_INFO.MESSAGE = ex.Message;
            }

            return RevenueGovXMLFactory.GetXmlDocument(acct);
        }
        private static UOLIST __Call(UOLIST e)
        {
            e = __RTTIE034_F_I(e);
            return e;

        }
        private static COPXmlFactory.RTTIE034.UOLIST __RTTIE034_F_I(COPXmlFactory.RTTIE034.UOLIST e)
        {
            RTTIE034_SrvRef.RTTIE234Request serv_req = new RTTIE034_SrvRef.RTTIE234Request();

            serv_req.RTTIE234 = new RTTIE034_SrvRef.RTTIE234();
            serv_req.RTTIE234._EREQ = new RTTIE034_SrvRef._EREQ();

            serv_req.RTTIE234._EREQ.ACCOUNTID = e.UO_INFO.ACCOUNT_ID;
            serv_req.RTTIE234._EREQ.ENTITYID = e.UO_INFO.ENTITY_ID;
            

            RTTIE034_SrvRef.RTTIE234Response1 response = _client.RTTIE234(serv_req);

            e = __Fill(response);

            return e;
        }
        private static COPXmlFactory.RTTIE034.UOLIST __Fill(RTTIE034_SrvRef.RTTIE234Response1 e)
        {
           // COPXmlFactory.RTTIE034.UOLIST fobj = new UOLIST();
            COPXmlFactory.RTTIE034.UOLIST fobj = RevenueGovXMLFactory.GetUOLISTReturn();


            //LOAD ERRORS INTO OBJECT
           // fobj.ERROR_INFO = new ERROR_INFO();

            fobj.ERROR_INFO.PROGRAM = e.RTTIE234Response._SMA._PROGRAM;
            fobj.ERROR_INFO.LINE = e.RTTIE234Response._SMA.ERRORLINE.ToString();
            fobj.ERROR_INFO.MESSAGE = e.RTTIE234Response._SMA.MESSAGE;
            fobj.ERROR_INFO.ERROR = e.RTTIE234Response._SMA.SYSTEMERROR.ToString();

            //LOAD UO_INFO 
            fobj.UO_INFO= new UO_INFO();
            fobj.UO_INFO.ENTITY_ID = e.RTTIE234Response._EREQ.ENTITYID;
            fobj.UO_INFO.ACCOUNT_ID = e.RTTIE234Response._EREQ.ACCOUNTID;

            //LOAD UO_ACCT 
            fobj.UO_ACCT = new List<UO_ACCT>();
            for (int i = 0; i < e.RTTIE234Response._ELIST._UOLACCOUNTSs.Length; i++)
            {
                fobj.UO_ACCT.Add(COPXmlFactory.RevenueGovXMLFactory.GetUOLISTReturn_UO_ACCT());

                fobj.UO_ACCT[i].ACCOUNT_ID = e.RTTIE234Response._ELIST._UOLACCOUNTSs[i].ACCOUNTID;
                fobj.UO_ACCT[i].BRT_NUMBER = e.RTTIE234Response._ELIST._UOLACCOUNTSs[i].BRTNUMBER;
                fobj.UO_ACCT[i].LOCATION = e.RTTIE234Response._ELIST._UOLACCOUNTSs[i].LOCATION;
                fobj.UO_ACCT[i].START_DATE = e.RTTIE234Response._ELIST._UOLACCOUNTSs[i].STARTDATE;
                fobj.UO_ACCT[i].END_DATE = e.RTTIE234Response._ELIST._UOLACCOUNTSs[i].ENDDATE;
                fobj.UO_ACCT[i].FREQ_YEAR0 = e.RTTIE234Response._ELIST._UOLACCOUNTSs[i].FREQTABLE.FREQs[0].FREQCODE;
                fobj.UO_ACCT[i].FREQ_YEAR1 = e.RTTIE234Response._ELIST._UOLACCOUNTSs[i].FREQTABLE.FREQs[1].FREQCODE;
                fobj.UO_ACCT[i].FREQ_YEAR2 = e.RTTIE234Response._ELIST._UOLACCOUNTSs[i].FREQTABLE.FREQs[2].FREQCODE;
                fobj.UO_ACCT[i].FREQ_YEAR3 = e.RTTIE234Response._ELIST._UOLACCOUNTSs[i].FREQTABLE.FREQs[3].FREQCODE;
                fobj.UO_ACCT[i].FREQ_YEAR4 = e.RTTIE234Response._ELIST._UOLACCOUNTSs[i].FREQTABLE.FREQs[4].FREQCODE;
                fobj.UO_ACCT[i].FREQ_YEAR5 = e.RTTIE234Response._ELIST._UOLACCOUNTSs[i].FREQTABLE.FREQs[5].FREQCODE;
                fobj.UO_ACCT[i].FREQ_YEAR6 = e.RTTIE234Response._ELIST._UOLACCOUNTSs[i].FREQTABLE.FREQs[6].FREQCODE;
                fobj.UO_ACCT[i].FREQ_YEAR7 = e.RTTIE234Response._ELIST._UOLACCOUNTSs[i].FREQTABLE.FREQs[7].FREQCODE;
                fobj.UO_ACCT[i].FREQ_YEAR8 = e.RTTIE234Response._ELIST._UOLACCOUNTSs[i].FREQTABLE.FREQs[8].FREQCODE;
                fobj.UO_ACCT[i].FREQ_YEAR9 = e.RTTIE234Response._ELIST._UOLACCOUNTSs[i].FREQTABLE.FREQs[9].FREQCODE;
            }

            return fobj;

        }
    }
}
