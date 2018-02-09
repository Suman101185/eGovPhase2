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
       
        public static void Init()
        {
            
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

            UOList_RTTIE034_SrvRef.RT01E034_EREQ _EREQ = new UOList_RTTIE034_SrvRef.RT01E034_EREQ();
            UOList_RTTIE034_SrvRef.RT01E034 serv_req = new UOList_RTTIE034_SrvRef.RT01E034();
            UOList_RTTIE034_SrvRef.RT01E034Response_SMA _SMAResponse = new UOList_RTTIE034_SrvRef.RT01E034Response_SMA();
            UOList_RTTIE034_SrvRef.RT01E034Response_EREQ _EREQResponse = new UOList_RTTIE034_SrvRef.RT01E034Response_EREQ();
            UOList_RTTIE034_SrvRef.RT01E034Response_ELIST _ELISTResponse = new UOList_RTTIE034_SrvRef.RT01E034Response_ELIST();


            _EREQ.ACCOUNTID = e.UO_INFO.ACCOUNT_ID;
            _EREQ.ENTITYID = e.UO_INFO.ENTITY_ID;

            _SMAResponse = serv_req.CallRT01E034
                                                ( _EREQ,
                                                  new UOList_RTTIE034_SrvRef.RT01E034_ELIST(),
                                                  out _EREQResponse,
                                                  out _ELISTResponse
                                                );





            e = __Fill(_SMAResponse, _EREQResponse, _ELISTResponse);
            return e;
        }
        private static COPXmlFactory.RTTIE034.UOLIST __Fill(UOList_RTTIE034_SrvRef.RT01E034Response_SMA _SMA, UOList_RTTIE034_SrvRef.RT01E034Response_EREQ _EREQ, UOList_RTTIE034_SrvRef.RT01E034Response_ELIST _ELIST)
        {
           
            COPXmlFactory.RTTIE034.UOLIST fobj = RevenueGovXMLFactory.GetUOLISTReturn();
            if (fobj.ERROR_INFO.LENGTH != null)
            {
                fobj.ERROR_INFO.PROGRAM = _SMA._PROGRAM;
                fobj.ERROR_INFO.LINE = _SMA.ERRORLINE.ToString();
                fobj.ERROR_INFO.MESSAGE = _SMA.MESSAGE;
                fobj.ERROR_INFO.ERROR = _SMA.SYSTEMERROR.ToString();
            }
            //LOAD UO_INFO 
           
            fobj.UO_INFO.ENTITY_ID = _EREQ.ENTITYID;
            fobj.UO_INFO.ACCOUNT_ID = _EREQ.ACCOUNTID;

            //LOAD UO_ACCT 
            fobj.UO_ACCT = new List<UO_ACCT>();
            for (int i = 0; i < _ELIST._UOLACCOUNTSs.Length; i++)
            {
                fobj.UO_ACCT.Add(COPXmlFactory.RevenueGovXMLFactory.GetUOLISTReturn_UO_ACCT());
                UOList_RTTIE034_SrvRef.RT01E034Response_ELIST_UOLACCOUNTSACCOUNTIDX obj = _ELIST._UOLACCOUNTSs[i].ACCOUNTIDX;

                fobj.UO_ACCT[i].ACCOUNT_ID = obj.ACCOUNTID;
                fobj.UO_ACCT[i].BRT_NUMBER =_ELIST._UOLACCOUNTSs[i].BRTNUMBER;
                fobj.UO_ACCT[i].LOCATION = _ELIST._UOLACCOUNTSs[i].LOCATION;
                fobj.UO_ACCT[i].START_DATE = _ELIST._UOLACCOUNTSs[i].STARTDATE;
                fobj.UO_ACCT[i].END_DATE =_ELIST._UOLACCOUNTSs[i].ENDDATE;
                fobj.UO_ACCT[i].FREQ_YEAR0 = _ELIST._UOLACCOUNTSs[i].FREQTABLE.FREQs[0].FREQCODE;
                fobj.UO_ACCT[i].FREQ_YEAR1 = _ELIST._UOLACCOUNTSs[i].FREQTABLE.FREQs[1].FREQCODE;
                fobj.UO_ACCT[i].FREQ_YEAR2 = _ELIST._UOLACCOUNTSs[i].FREQTABLE.FREQs[2].FREQCODE;
                fobj.UO_ACCT[i].FREQ_YEAR3 = _ELIST._UOLACCOUNTSs[i].FREQTABLE.FREQs[3].FREQCODE;
                fobj.UO_ACCT[i].FREQ_YEAR4 = _ELIST._UOLACCOUNTSs[i].FREQTABLE.FREQs[4].FREQCODE;
                fobj.UO_ACCT[i].FREQ_YEAR5 = _ELIST._UOLACCOUNTSs[i].FREQTABLE.FREQs[5].FREQCODE;
                fobj.UO_ACCT[i].FREQ_YEAR6 = _ELIST._UOLACCOUNTSs[i].FREQTABLE.FREQs[6].FREQCODE;
                fobj.UO_ACCT[i].FREQ_YEAR7 = _ELIST._UOLACCOUNTSs[i].FREQTABLE.FREQs[7].FREQCODE;
                fobj.UO_ACCT[i].FREQ_YEAR8 = _ELIST._UOLACCOUNTSs[i].FREQTABLE.FREQs[8].FREQCODE;
                fobj.UO_ACCT[i].FREQ_YEAR9 = _ELIST._UOLACCOUNTSs[i].FREQTABLE.FREQs[9].FREQCODE;
            }

            return fobj;

        }
    }
}
