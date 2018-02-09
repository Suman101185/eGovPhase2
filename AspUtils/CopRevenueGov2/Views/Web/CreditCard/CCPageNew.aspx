<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head >
  <script type="text/javascript" language="javascript" >
      //EGOVWEB-34 - 2010-07-19 - Changed Waged to go to the Philly ePay System
      //EGOVWEB-41 20100917 EHD Add Tax code, year and period to ePay buffer
      var ispCCWin;

      function DoCreditCard() {
          //parent.MenuFrameSet.cols = '158,*'	
        //  $(parent.MenuFrameSet).attr("cols", "158,*");//Sangha
          //0,*
          var sAmount;
          var sToday, sMonth, sDate;
          sToday = new Date();
          sMonth = sToday.getMonth() + 1;
          sDate = sToday.getDate();
          //EGOVWEB-34 - 2010-09-15 - Changed < 9 to <=9 for both Month and Date - 9 was not getting padded with a 0
          if (sMonth <= 9) {
              sMonth = '0' + sMonth;
          }	//if

          if (sDate <= 9) {
              sDate = '0' + sDate;
          }	//if

          parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ACCOUNT_ID', '', 0), 'AccountNumber', '', 0);
          parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ACCOUNT_ID', '', 0), 'BillNumber', '', 0);
          parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ACCOUNT_ID', '', 0), 'StatementNumber', '', 0);
          parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '123', 'DepartMentId', '', 0);	//DOR
          parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sToday.getFullYear() + '-' + sMonth + '-' + sDate, 'PaymentDate', '', 0);

          var addrIdx;
          addrIdx = LocatePrimaryAddr()
          if (addrIdx == -1) { addrIdx = 0 }	//if
          //EGOVWEB-56 - EDD - Changed for Ampersand
          if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS TRADE_NAME', '', addrIdx) != '') {
              parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '<![CDATA[' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS TRADE_NAME', '', addrIdx) + ']]>', 'Customers Customer FirstName', '', 0)
          } else {
              if (window.AdjustNameDisplay) {
                  parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '<![CDATA[' + AdjustNameDisplay(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS NAME', '', addrIdx)) + ']]>', 'Customers Customer FirstName', '', 0)
              } else {
                  parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '<![CDATA[' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS NAME', '', addrIdx) + ']]>', 'Customers Customer FirstName', '', 0)
              }		//if
          }		//if

          parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS1', '', addrIdx), 'Customers Customer BillingAddress Address AddressLine1', '', 0)
          parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS CITY', '', addrIdx), 'Customers Customer BillingAddress Address City', '', 0)
          parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS STATE', '', addrIdx), 'Customers Customer BillingAddress Address State', '', 0)
          //EGOVWEB-37 Added work phone number to buffer
          if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS WORK_PHONE', '', addrIdx) != '') {
              parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS WORK_PHONE', '', addrIdx), 'Customers Customer PhoneNumber', '', 0)
          } else {
              parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS OTHER_PHONE', '', addrIdx), 'Customers Customer PhoneNumber', '', 0)
          }		//if	

          //BP License Fee Payment Section
          //EGOVWEB-36 Not used anymore goes thru L&I's website
          if (typeof (AcctThankYou) !== 'undefined') {
              parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '<%= COPSession.CC_BP_Lic_ePay_ID %>', 'ApplicationID', '', 0)
            //		parent.$x.ispXmlSetFieldVal(xmlCC, parent.gBPT_SourceCodeIndex, 'account_number', '', 0)
            //		parent.$x.ispXmlSetFieldVal(xmlCC, 
            //				parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ACCOUNT_ID', '', 0)
            //				, 'source_code_index', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, 'BP' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ACCOUNT_ID', '', 0), 'StatementNumber', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sToday.getFullYear() + '-' + sMonth + '-' + sDate, 'BillingDate', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sToday.getFullYear() + '-' + sMonth + '-' + sDate, 'DueDate', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.gBPT_LicenseFee, 'ItemAmount', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.gBPT_LicenseFee, 'TotalDue', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.gBPT_LicenseFee, 'TotalAmountdue', '', 0)
            //		parent.$x.ispXmlSetFieldVal(xmlCC, '0', 'partial_payment_flag', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.gBPT_LicenseFee, 'Details BillingStatementDetail Charges', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, 'Commercial Activity License Fee', 'Details BillingStatementDetail ItemDescription', '', 0)
        }	//AcctThankYou 

            //School Tax Payment Section
        else if (typeof (divSchoolThankYou) !== 'undefined') {
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '<%= COPSession.CC_School_ePay_ID %>', 'ApplicationID', '', 0)
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_ID', '', 0), 'AccountNumber', '', 0)
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_ID', '', 0), 'BillNumber', '', 0)
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO ADJUSTMENT_REF_NO', '', 0), 'StatementNumber', '', 0)
	    a = parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO PERIOD', '', 0);

	    //EGOVWEB-41
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '29', 'OtherAttributes Attribute Value', '', 0)	//TaxType
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '12', 'OtherAttributes Attribute Value', '', 1)	//TaxPeriod
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, a.substr(8, 2), 'OtherAttributes Attribute Value', '', 2)	//TaxYear

	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, a.substr(6, 4) + '-' + a.substr(0, 2) + '-' + a.substr(3, 2), 'BillingDate', '', 0)
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, (Number(a.substr(6, 4)) + 1) + '-' + '04' + '-' + '15', 'DueDate', '', 0)
	    sAmount = ispStripCurrency(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'AMT_INFO TAX_DUE', '', 0), 0)).replace('$', '')
	    if (sAmount == "") { sAmount = '0' }
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sAmount, 'ItemAmount', '', 0)
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sAmount, 'TotalDue', '', 0)
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sAmount, 'TotalAmountdue', '', 0)
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sAmount, 'Details BillingStatementDetail Charges', '', 0)
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, 'School Income Tax for ' + a.substr(6, 4), 'Details BillingStatementDetail ItemDescription', '', 0)
	}//divSchoolThankYou 

	    //Tobacco Tax Payment Section
	else if (typeof (divTobaccoThankYou) !== 'undefined') {
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '<%= COPSession.CC_TOBACCO_ePay_ID %>', 'ApplicationID', '', 0)
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'TOBACCO_INFO ACCOUNT_ID', '', 0), 'AccountNumber', '', 0)
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'TOBACCO_INFO ACCOUNT_ID', '', 0), 'BillNumber', '', 0)
	    //		parent.$x.ispXmlSetFieldVal(xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'TOBACCO_INFO/ADJUSTMENT_REF_NO', '', 0), 'StatementNumber', '', 0)
	    if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'TOBACCO_INFO ADJUSTMENT_REF_NO', '', 0) != '') {
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'TOBACCO_INFO ADJUSTMENT_REF_NO', '', 0), 'StatementNumber', '', 0)
	    } else {
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ACCOUNT_ID', '', 0), 'StatementNumber', '', 0)
	    }		//if Adjustment reference number
	    a = parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'TOBACCO_INFO PERIOD', '', 0)
	    //EGOVWEB-41
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '27', 'OtherAttributes Attribute Value', '', 0)	//TaxType
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '12', 'OtherAttributes Attribute Value', '', 1)	//TaxPeriod
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, a.substr(8, 2), 'OtherAttributes Attribute Value', '', 2)	//TaxYear

	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, a.substr(6, 4) + '-' + a.substr(0, 2) + '-' + a.substr(3, 2), 'BillingDate', '', 0)
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, (Number(a.substr(6, 4)) + 1) + '-' + '01' + '-' + '31', 'DueDate', '', 0)

	    sAmount = ispStripCurrency(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'AMT_INFO TOTAL_AMOUNT_DUE', '', 0), 0)).replace('$', '')
	    if (sAmount == "") { sAmount = '0' }
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sAmount, 'ItemAmount', '', 0)
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sAmount, 'TotalDue', '', 0)
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sAmount, 'TotalAmountdue', '', 0)
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sAmount, 'Details BillingStatementDetail Charges', '', 0)
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, 'Tobacco Tax for ' + a.substr(6, 4), 'Details BillingStatementDetail ItemDescription', '', 0)
	}//divTobaccoThankYou 

	    //Wage Tax Payment Section
	else if (typeof (divWageThankYou) !== 'undefined') {
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '<%= COPSession.CC_Wage_ePay_ID %>', 'ApplicationID', '', 0);
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO ACCOUNT_ID', '', 0), 'AccountNumber', '', 0);
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO ACCOUNT_ID', '', 0), 'BillNumber', '', 0);
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO ADJ_REFNO_CONTROL', '', 0), 'StatementNumber', '', 0);
	    var lFreq = parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO FREQUENCY', '', 0);
	    if (lFreq == 'W') {
	        lFreq = '53';
	    } else if (lFreq == 'S') {
	        lFreq = '78';
	    } else if (lFreq == 'M') {
	        lFreq = '91';
	    } else if (lFreq == 'Q') {
	        lFreq = '96';
	    } else {
	        lFreq = '97';
	    }		//if
	    a = parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO PERIOD', '', 0);
	    //EGOVWEB-41
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '01', 'OtherAttributes Attribute Value', '', 0);	//TaxType
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, lFreq, 'OtherAttributes Attribute Value', '', 1);	//TaxPeriod
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, a.substr(8, 2), 'OtherAttributes Attribute Value', '', 2);	//TaxYear

	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, a.substr(6, 4) + '-' + a.substr(0, 2) + '-' + a.substr(3, 2), 'BillingDate', '', 0);
	    var sDueDate;
	    sDueDate = parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO DUE_DATE', '', 0);
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sDueDate.substr(6, 4) + '-' + sDueDate.substr(0, 2) + '-' + sDueDate.substr(3, 2), 'DueDate', '', 0)
	    sAmount = stripCurrency(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO TAX_DUE', '', 0), 0)).replace('$', '')
	    if (sAmount == "") {
	        sAmount = '0'
	    };
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sAmount, 'ItemAmount', '', 0);
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sAmount, 'TotalDue', '', 0);
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sAmount, 'TotalAmountdue', '', 0);
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, 'Wage Tax for ' + a.substr(6, 4), 'Details BillingStatementDetail ItemDescription', '', 0);
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sAmount, 'Details BillingStatementDetail Charges', '', 0);
	}//divWageThankYou

	    //Net Profits Tax Payment Section
	else if (typeof (divNPTThankYou) !== 'undefined') {
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '<%= COPSession.CC_NPT_ePay_ID %>', 'ApplicationID', '', 0)
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.xmlNPT, 'NPT_INFO ACCOUNT_ID', '', 0), 'AccountNumber', '', 0)
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.xmlNPT, 'NPT_INFO ACCOUNT_ID', '', 0), 'BillNumber', '', 0)
	    if (parent.$x.ispXmlGetFieldVal(parent.xmlNPT, 'NPT_INFO ADJUSTMENT_REF_NO', '', 0) != '') {
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.xmlNPT, 'NPT_INFO ADJUSTMENT_REF_NO', '', 0), 'StatementNumber', '', 0)
	    } else {
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ACCOUNT_ID', '', 0), 'StatementNumber', '', 0)
	    }		//if Adjustment reference number
	    a = parent.$x.ispXmlGetFieldVal(parent.xmlNPT, 'NPT_INFO PERIOD', '', 0)
	    //EGOVWEB-41
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '03', 'OtherAttributes Attribute Value', '', 0)	//TaxType
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '12', 'OtherAttributes Attribute Value', '', 1)	//TaxPeriod
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, a.substr(8, 2), 'OtherAttributes Attribute Value', '', 2)	//TaxYear

	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, a.substr(6, 4) + '-' + a.substr(0, 2) + '-' + a.substr(3, 2), 'BillingDate', '', 0)
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, (Number(a.substr(6, 4)) + 1) + '-' + '04' + '-' + '15', 'DueDate', '', 0)
	    sAmount = ispStripCurrency(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.xmlNPT, 'NPT_PG1 TOTAL_DUE', '', 0), 0)).replace('$', '')
	    if (sAmount == "") { sAmount = '0' }
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sAmount, 'ItemAmount', '', 0)
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sAmount, 'TotalDue', '', 0)
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sAmount, 'TotalAmountdue', '', 0)
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sAmount, 'Details BillingStatementDetail Charges', '', 0)
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, 'Net Profits Tax for ' + a.substr(6, 4), 'Details BillingStatementDetail ItemDescription', '', 0)
	}//divNPTThankYou

	    //Business Income and Receipts Tax EZ Payment Section
	else if (typeof (divBPTThankYou) !== 'undefined') {
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '<%= COPSession.CC_BPT_ePay_ID %>', 'ApplicationID', '', 0)
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_INFO ACCOUNT_ID', '', 0), 'AccountNumber', '', 0)
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_INFO ACCOUNT_ID', '', 0), 'BillNumber', '', 0)
	    if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_INFO ADJUSTMENT_REF_NO', '', 0) != '') {
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_INFO ADJUSTMENT_REF_NO', '', 0), 'StatementNumber', '', 0)
	    } else {
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ACCOUNT_ID', '', 0), 'StatementNumber', '', 0)
	    }		//if Adjustment reference number
	    a = parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_INFO PERIOD', '', 0)
	    //EGOVWEB-41
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '24', 'OtherAttributes Attribute Value', '', 0)	//TaxType
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '12', 'OtherAttributes Attribute Value', '', 1)	//TaxPeriod
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, a.substr(8, 2), 'OtherAttributes Attribute Value', '', 2)	//TaxYear

	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, a.substr(6, 4) + '-' + a.substr(0, 2) + '-' + a.substr(3, 2), 'BillingDate', '', 0)
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, (Number(a.substr(6, 4)) + 1) + '-' + '04' + '-' + '15', 'DueDate', '', 0)
	    //EGOVWEB-39 Changed field from TAX_DUE to AMOUNT_OWED
	    sAmount = ispStripCurrency(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 AMOUNT_OWED', '', 0), 0)).replace('$', '')
	    if (sAmount == "") { sAmount = '0' }
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sAmount, 'ItemAmount', '', 0)
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sAmount, 'TotalDue', '', 0)
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sAmount, 'TotalAmountdue', '', 0)
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sAmount, 'Details BillingStatementDetail Charges', '', 0)
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, 'Business Income and Receipts Tax for ' + a.substr(6, 4), 'Details BillingStatementDetail ItemDescription', '', 0)
	}//divBPTThankYou

	    //Business Income and Receipts Tax Long Form Payment Section
	else if (typeof (divBPTlfThankYou) !== 'undefined') {
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '<%= COPSession.CC_BPT_ePay_ID %>', 'ApplicationID', '', 0)
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, 'BPT_INFO ACCOUNT_ID', '', 0), 'AccountNumber', '', 0)
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, 'BPT_INFO ACCOUNT_ID', '', 0), 'BillNumber', '', 0)
	    if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, 'BPT_INFO ADJUSTMENT_REF_NO', '', 0) != '') {
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, 'BPT_INFO ADJUSTMENT_REF_NO', '', 0), 'StatementNumber', '', 0)
	    } else {
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ACCOUNT_ID', '', 0), 'StatementNumber', '', 0)
	    }		//if Adjustment reference number
	    a = parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, 'BPT_INFO PERIOD', '', 0)
	    //EGOVWEB-41
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '24', 'OtherAttributes Attribute Value', '', 0)	//TaxType
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '12', 'OtherAttributes Attribute Value', '', 1)	//TaxPeriod
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, a.substr(8, 2), 'OtherAttributes Attribute Value', '', 2)	//TaxYear

	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, a.substr(6, 4) + '-' + a.substr(0, 2) + '-' + a.substr(3, 2), 'BillingDate', '', 0)
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, (Number(a.substr(6, 4)) + 1) + '-' + '04' + '-' + '15', 'DueDate', '', 0)
	    sAmount = ispStripCurrency(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, 'BPT_PG1 AMOUNT_OWED', '', 0), 0)).replace('$', '')
	    if (sAmount == "") { sAmount = '0' }
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sAmount, 'ItemAmount', '', 0)
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sAmount, 'TotalDue', '', 0)
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sAmount, 'TotalAmountdue', '', 0)
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sAmount, 'Details BillingStatementDetail Charges', '', 0)
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, 'Business Income and Receipts Tax for ' + a.substr(6, 4), 'Details BillingStatementDetail ItemDescription', '', 0)
	}//divBPTlfThankYou

	    //Use and Occupancy Tax Form Payment Section
	else if (typeof (divUOThankYou) !== 'undefined') {
	    parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '<%= Session["CC_UO_ePay_ID"]%>', 'ApplicationID', '', 0)
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.oUOForm, 'UO_ACCT ACCOUNT_ID', '', 0), 'AccountNumber', '', 0)
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.oUOForm, 'UO_ACCT ACCOUNT_ID', '', 0), 'BillNumber', '', 0)
	        if (parent.$x.ispXmlGetFieldVal(parent.oUOForm, 'UO_ACCT ADJUSTMENT_REF_NO', '', 0) != '') {
	            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.oUOForm, 'UO_ACCT ADJUSTMENT_REF_NO', '', 0), 'StatementNumber', '', 0)
	        } else {
	            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.oUOForm, 'UO_ACCT ACCOUNT_ID', '', 0), 'StatementNumber', '', 0)
	        } 	//if Adjustment reference number
	        a = parent.$x.ispXmlGetFieldVal(parent.oUOForm, 'UO_ACCT PERIOD', '', 0)
	    //EGOVWEB-41
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '84', 'OtherAttributes Attribute Value', '', 0)	//TaxType
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '12', 'OtherAttributes Attribute Value', '', 1)	//TaxPeriod
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.oUOForm, 'UO_ACCT PERIOD_YY', '', 0), 'OtherAttributes Attribute Value', '', 2)	//TaxYear


	        a = parent.$x.ispXmlGetFieldVal(parent.oUOForm, 'UO_ACCT RECORDING_DATE', '', 0)
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, a.substr(6, 4) + '-' + a.substr(0, 2) + '-' + a.substr(3, 2), 'BillingDate', '', 0)
	    //		parent.$x.ispXmlSetFieldVal(xmlCC, parent.$x.ispXmlGetFieldVal(oUOForm, 'UO_ACCT/RECORDING_DATE', '', 0), 'BillingDate', '', 0)
	        a = parent.$x.ispXmlGetFieldVal(parent.oUOForm, 'UO_ACCT DUE_DATE', '', 0)
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, a.substr(6, 4) + '-' + a.substr(0, 2) + '-' + a.substr(3, 2), 'DueDate', '', 0)
	    //		parent.$x.ispXmlSetFieldVal(xmlCC, parent.$x.ispXmlGetFieldVal(oUOForm, 'UO_ACCT/DUE_DATE', '', 0), 'DueDate', '', 0)

	        sAmount = ispStripCurrency(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.oUOForm, 'UO_AMTS TOTAL_DUE', '', 0), 0)).replace('$', '')
	        if (sAmount == "") { sAmount = '0' }
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sAmount, 'ItemAmount', '', 0)
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sAmount, 'TotalDue', '', 0)
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sAmount, 'TotalAmountdue', '', 0)
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sAmount, 'Details BillingStatementDetail Charges', '', 0)
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, 'Use and Occupancy Tax for ' + a, 'Details BillingStatementDetail ItemDescription', '', 0)
	    } //divUOThankYou

	    //Earnings Tax Payment Section (Currently not used)
	    else if (typeof (divERNThankYou) !== 'undefined') {
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC,
                    parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ACCOUNT_ID', '', 0)
                    , 'account_number', '', 0)
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC,
                    parent.$x.ispXmlGetFieldVal(parent.xmlERN, 'ERN_INFO ADJUSTMENT_REF_NO', '', 0)
                    , 'bill_number', '', 0)
	        a = parent.$x.ispXmlGetFieldVal(parent.xmlERN, 'ERN_INFO PERIOD', '', 0)
	        //EGOVWEB-41
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '02', 'OtherAttributes Attribute Value', '', 0)	//TaxType
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '12', 'OtherAttributes Attribute Value', '', 1)	//TaxPeriod
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, a.substr(8, 2), 'OtherAttributes Attribute Value', '', 2)	//TaxYear

	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '12' + a.substr(8, 2), 'bill_date', '', 0)
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, (Number(a.substr(6, 4)) + 1) + '04' + '15', 'due_date', '', 0)

	        if (parent.$x.ispXmlGetFieldVal(parent.xmlERN, 'ERN_PG1 ADD_TAX_DUE', '', 0) != 0) {
	            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, ispStripCurrency(
                        parent.$x.ispXmlGetFieldVal(parent.xmlERN, 'ERN_PG1 ADD_TAX_DUE', '', 0)).replace('$', '')
                        , 'item_amount', '', 0)
	            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, ispStripCurrency(
                        parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'ERN_PG1 ADD_TAX_DUE', '', 0)).replace('$', '')
                        , 'total_amount_due', '', 0)
	        }
	        else {//ADD_TAX_DUE = 0
	            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, ispStripCurrency(
                        parent.$x.ispXmlGetFieldVal(parent.xmlERN, 'ERN_PG1 NET_TAX_DUE', '', 0)).replace('$', '')
                        , 'item_amount', '', 0)
	            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, ispStripCurrency(
                        parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'ERN_PG1 NET_TAX_DUE', '', 0)).replace('$', '')
                        , 'total_amount_due', '', 0)
	        }//if		
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, 'Employee Earnings Tax for ' + a.substr(6, 4), 'additional_reference_5', '', 0)
	    }//divERNThankYou	//if

        //var encodeCCXML = xmlCC.xml
    var encodeCCXML = XMLToString(parent.$g.xmlCC);
    encodeCCXML = encodeCCXML.replace(/</g, '&lt;');
    encodeCCXML = encodeCCXML.replace(/>/g, '&gt;');
    encodeCCXML = encodeCCXML.replace(/"/g, '&quot;');
    encodeCCXML = encodeCCXML.replace(/\t/g, '');
    encodeCCXML = encodeCCXML.replace(/\r\n/g, '');

    if (parent.gEnvironment == 'U') {
        clipboardData.setData('Text', xmlCC.xml);
    }		//if
    frmePay.action = '<%= COPSession.CC_SiteName %>';
    frmePay.BillStmt.value = encodeCCXML;
    frmePay.submit();

}		//DoCreditCard

function DoIspCreditCard() {
    txaComments.innerText = ""
   // parent.MenuFrameSet.cols = '158,*'	//Sangha		//0,*
    var lWidth = screen.width - 100
    var lHeight = screen.height - 100
    var a = "<DATA><ITEM1>Hello</ITEM1><ITEM2>World</ITEM2></DATA>"
    if (typeof (divNPTThankYou) !== 'undefined') {
        ispCCWin = open('../../CreditCard/IspInitialize?a=   ' + a, 'CCWin', 'top=50,left=50,width=600,height=500')
    } else {
        ispCCWin = open('../CreditCard/IspInitialize?a=   ' + a, 'CCWin', 'top=50,left=50,width=600,height=500')

    }		//if
}

var bReturnFromMLG = false;

function ReturnFromMLG(lReturnVal) {
    if (bReturnFromMLG == true) {
        bReturnFromMLG = false;
        return;
    }

    if (lReturnVal != '') {
       // parent.MenuFrameSet.cols = '158,*';//Sangha
        txaComments.innerText = lReturnVal
    } else {
        txaComments.innerText = "Credit Card Canceled by user...";
    }		//if
    bReturnFromMLG = true;
    ispCCWin.close();

}

</script>
    <title></title>
</head>
<body>
   <form id='frmePay' method="post" target="_blank">
<input type="hidden" name='BillStmt' />
  
   
 <h5>Credit Card / e-Check</h5>


<p>You can pay by American Express, Discover, MasterCard, VISA or eCheck. <label id="ccFeeText1">A 2.49% user fee will be added to the amount due when paying by credit card or a flat fee of $1.50 when paying by E-Check up to $100,000.</label></p>
            <div class="clear"></div>
       <p class="p_space"> <a id="btnCreditCard" name="btnCreditCard" onclick="DoCreditCard()" class="submit_button_light">Pay by Credit Card or e Check  (e Pay) </a>
         <img id="imgCards" alt="American Express, Discover, MasterCard, VISA or eCheck excepted" height="30" src="../Content/Images/ePay.gif" width="175" />  </p>
	
  
    <label id="ccFeeText" style="display:none"></label>
	<br />
        <h5>Note: </h5>
            
            <p>Pop-up Blockers may prevent access to the 
	Credit Card Processing Center. If the Credit Card Processing Center screen does not appear when 
	the "Pay By Credit Card" button is selected, consult your Pop-up Blocker software for 
	instructions on adding <b>https://revenue.phila.gov</b> to the Pop-up allowed list.</p>
            
    
</form>
</body>
</html>
