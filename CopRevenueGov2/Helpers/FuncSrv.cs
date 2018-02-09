using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CopRevenueGov2.Helpers
{
    public class FuncSrv
    {
        public string GetValue(string strVal, int intStart, int intLen)
        {
            string r = VB.mid(strVal, intStart, intLen).Trim();
            intStart = intStart + intLen;
            return r;
        }

        public string SetValue(string strVal, int intLen)
        {
            string r = string.Empty;
            if (strVal.Length > intLen)
            {
                r = strVal.Substring(0, intLen);
            }
            else
            {
                r = strVal.PadRight(intLen, ' ');   //&  space(intlen - strVal.Length);
            }
            return r;
        }

        public string SetNumValue(string strVal, int intLen)
        {
            string r = string.Empty;
            if (VB.len(strVal) > intLen)
            {
                r = VB.Left(strVal, intLen);
            }
            else
            {
                int ln = intLen - VB.len(strVal);
                r = new string('0', ln) + strVal;                
            }

            return r;

        }

        public string GetLOB(string strLob)
        {
            string r = string.Empty;
            switch (strLob)
            {
                case "10":
                    r = "Auto";
                    break;
                default:
                    r = "Unknown";
                    break;
            }
            return r;
        }

        public string FormatRefNo(string strVal)
        {
            CString strDate, strHour, strMin, strSec, sDate, strTime;

            if (string.IsNullOrEmpty(strVal))
            {
                return "";
            }
            else
            {
                sDate = (100000000 - CopMvcUtil.GetLong(strVal.Substring(0, 8))).ToString();
                strTime = (1000000 - CopMvcUtil.GetLong(strVal.Substring(8))).ToString(); //1000000 - mid(strVal,9)

                if (VB.len(strTime) == 5)
                { 
                    strTime = "0" + strTime;
                }

                strHour = VB.mid(strTime, 1, 2);
                if (VB.len(strHour) == 1)
                {
                    strHour = "0" + strHour;
                }

                strHour = strHour + ":";

                strMin = VB.mid(strTime, 3, 2);
                if (VB.len(strMin) == 1)
                {
                    strMin = "0" + strMin;
                }
                strMin = strMin + ".";

                strSec = VB.mid(strTime, 5, 2);
                if (VB.len(strSec) == 1)
                {
                    strSec = "0" + strSec;
                }

                strDate = VB.mid(sDate, 5, 2) + "/" + VB.mid(sDate, 7, 2) + "/" + VB.mid(sDate, 1, 4) + " ";

                string r = strDate + strHour + strMin + strSec;

                return r;

            }

        }

        public string FormatDate(string strVal)
        {
            string r;

            if (string.IsNullOrEmpty(strVal))
            {
                r = "";
            }
            else
            {
                r = VB.mid(strVal, 5, 2) + "/" + VB.mid(strVal, 7, 2) + "/" + VB.mid(strVal, 1, 4);
            }
            return r;
        }

        public string FormatCobolDate(string strVal, int intLen)
        {
            
            CString r = string.Empty;
           
                strVal = strVal.Replace("-", ""); 
                strVal = strVal.Replace("/", ""); 
                strVal = strVal.Replace(".", "");
                strVal = SetValue(strVal, 8);                

                r += VB.Right(strVal, 4); //gets year 
                r += VB.mid(strVal, 1, 2); //gets month 
                r += VB.mid(strVal, 3, 2); //gets date 

            
            return r.ToString();

        }

        public string ispCurrency(string strVal)
        {
            string r = string.Empty;
            if (string.IsNullOrEmpty(strVal))
            {
                r = "";
            }
            else
            {
                r = VB.FormatCurrency(strVal, 2);
            }
            return r;
        }

        public string ispDollarsOnly(string strVal)
        {
            string r = string.Empty;
            if (string.IsNullOrEmpty(strVal))
            {
                r = "";
            }
            else
            {
                r = VB.CDbl(strVal).ToString();
            }
            return r;
        }
    }
}