

 
 

 var tempParameters

 function SetupPassFields() {
   
	var strPayPeriod = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon,'COUPON_FORM CPN_PERIOD', '')
  var strAcctType = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon,'COUPON_FORM CPN_ACCOUNT_TYPE', '')
	var strAcctID = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon,'COUPON_FORM CPN_ACCOUNT', '')
	var strAccountName = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon,'COUPON_FORM CPN_NAME', '')
	var strAccountAddr = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon,'COUPON_FORM CPN_ADDR', '')  
	var strAccountAddr2 = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon,'COUPON_FORM CPN_ADDR2', '')
	var strAccountAddr3 = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon,'COUPON_FORM CPN_ADDR3', '')
	var strAccountCity = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon,'COUPON_FORM CPN_CITY', '')
	var strAccountState = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon,'COUPON_FORM CPN_STATE', '')
	var strAccountZip = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon,'COUPON_FORM CPN_ZIP_CODE', '')

//  var strEntityID = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon,'COUPON_FORM/CPN_ENTITY_ID', '')
	var i = 0
	var iTotal = 0
	var iDigit = 0
	var strScanID

	
	if (strAcctType == '60') {
	  strCouponAddr = strBRTAddr
		strAcctID = strBRTAcct
	} else {		 
//		strCouponAddr = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon,"ENTITY_INFO/ADDRESS1", "")  
	}  //if

//	strPeriod = ddPCTaxPeriod.options(ddPCTaxPeriod.selectedIndex).innerText
	strPeriod = new Date(strPayPeriod)
	strPeriod = strPeriod.getMonth() + 1 + '/' + strPeriod.getDate() + '/' + strPeriod.getFullYear()
	strPayPeriod = strPayPeriod.substr(0,2)
//	strAcctType = strAcctType
/*  if (ifreq == 'W') {
     strPeriod = strPeriod
     } else {
     strPeriod = strPeriod + ', ' + ddPCTaxYear.options(ddPCTaxYear.selectedIndex).CODE
  } //if */
    
//        make type 2 digits	
	if (new Number(strAcctType) < 10) {
		strAcctType = '0' + strAcctType
	} //if		

//		  add sufffix for UOL, UOT	
	if (strAcctID.length == 7) {
		if (strAcctType == '84' || strAcctType == '85') {
			if (strAcctID.substr(7,8) == '  ') {
				strAcctID.substr(7,8) = '00' 
			} //if
		} // if
	} // if

//		  make Account Id 12 bytes long	
	if (strAcctID.length == 12) {
		strScanID = strAcctID
	} //if
	if (strAcctID.length == 11) {
		strScanID = strAcctID + '0'
	} //if
	if (strAcctID.length == 10) {
		strScanID = strAcctID + '00'
	} //	if
	if (strAcctID.length == 9) {
		strScanID = strAcctID + '000'
	} //	if
	if (strAcctID.length == 8) {
		strScanID = strAcctID + '0000'
	} //	if
	if (strAcctID.length == 7) {
		strScanID = strAcctID + '00000'
	} //	if
	if (strAcctID.length == 6) {
		strScanID = strAcctID + '000000'
	} //	if
	if (strAcctID.length == 5) {
		strScanID = strAcctID + '0000000'
	} //	if
	if (strAcctID.length == 4) {
		strScanID = strAcctID + '00000000'
	} //	if
	if (strAcctID.length == 3) {
		strScanID = strAcctID + '000000000'
	} //	if
	if (strAcctID.length == 2) {
		strScanID = strAcctID + '0000000000'
	} //	if
	if (strAcctID.length == 1) {
	   strScanID = strAcctID + '00000000000'
	} //	if
	if (strAcctType == '98') {
		strScanID = strAcctID
	}		//if

//		  Make pay period 2 digits
	if (strPayPeriod < 10) {
		strPayPeriod = '0' + strPayPeriod
	} //if
	
//		  Get today's date for due date
	HoldDate = new Date()
	holdmonth = HoldDate.getMonth()
	holdmonth = holdmonth + 1
	if (holdmonth < 10) {
		holdmonth = '0' + holdmonth
	} // if
	
	holdday = HoldDate.getDate()
	if (holdday < 10) {
		holdday = '0' + holdday
	} // if
		
	holdyear = HoldDate.getFullYear()
	twoyear = holdyear
//		  find 2 digit year
	if (twoyear > 2000) {
		while (twoyear > 999) {
			twoyear = twoyear - 1000
		}  //while
		while (twoyear > 99) {
			twoyear = twoyear - 100
		}  //while
		if (twoyear < 10) {
			twoyear = '0' + twoyear
		} //if
	} //if

//		create dates for scan lines
	HoldDate = new String(holdmonth) + new String(holdday) + new String(twoyear)
	
//  Format Period year
	twoyear = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon,'COUPON_FORM CPN_YEAR', '')	
//		  find 2 digit year
	if (twoyear > 2000) {
		while (twoyear > 999) {
			twoyear = twoyear - 1000
		}  //while
		while (twoyear > 99) {
			twoyear = twoyear - 100
		}  //while
		if (twoyear < 10) {
			twoyear = '0' + twoyear
		} //if
	} //if

//		create century code for SIT accounts (in CCYY year, century code is 2nd C)\
	centurySIT = '0'
	if (holdyear < 1999) {
		centurySIT = '9'
	} //if

	if (strAcctType == '11') {
		strScanLine = '333' + strAcctType + HoldDate + '0000' + strScanID + '0000000000000000000000000000000000000000'
	} else if (strAcctType == '29') {
	    //strScanLine = '333' + strAcctType + HoldDate + '00' + '00000' + strScanID + '0000000000000000000' + centurySIT + twoyear + '000000000000000'//Commented by SumanG
	    strScanLine = '333' + strAcctType + HoldDate + '00' + '00000' + strScanID + '0000000000000000000' + strPayPeriod + twoyear + '000000000000000'//Newly added for change request 
	} else if (strAcctType == '84' || strAcctType == '85') {
		strScanLine = '333' + strAcctType + HoldDate + '00' + '00000000' + strScanID + '0000000000' + twoyear + strPayPeriod + '0000000000000000000000'
//20100301 EHD Real Estate needs to have the 2 year code in the scan line
	} else if (strAcctType == '60') {
		strScanLine = '333' + strAcctType + HoldDate + '0000' + '0000'+ strScanID + '0000000000000000000' + twoyear + '0' + strPayPeriod + '00000000000000'
	} else if (strAcctType == '98') {
		strScanLine = '333' + strAcctType + HoldDate + '0000' + strScanID + '000000000000000000000000000000000000000'
	} else {
		strScanLine = '333' + strAcctType + HoldDate + '00'+ '000000' + strScanID + '000000000000000000' + strPayPeriod + twoyear + '000' + '00000000000000000000'
	} //if

	//TODO Fix Check Digit Routine
	//Check digit routine
	//Even numbers added together for a running total
	if (strAcctType == '98') {
	    for (i = 1; i < 59; i = i + 2) {
	        iTotal = iTotal + parseInt(strScanLine.substr(i, 1))
	    }  //for
	    //Odd numbers Multiplied by 2 then the 2 digit answer is added together then added to the running total
	    // 3 * 2 = 6 add 6 (0 + 6) ; 6 * 2 = 12 add 3 (1 + 2)
	    for (i = 0; i < 59; i = i + 2) {
	        iDigit = parseInt(strScanLine.substr(i, 1)) * 2
	        if (iDigit.toString().length == 2) {
	            iDigit = parseInt(iDigit.toString().substr(0, 1)) + parseInt(iDigit.toString().substr(1, 1))
	        } 	//if
	        iTotal = iDigit + iTotal
	    }
	}
	else {
	    for (i = 1; i < 66; i = i + 2) {
	        iTotal = iTotal + parseInt(strScanLine.substr(i, 1))
	    }  //for
	    //Odd numbers Multiplied by 2 then the 2 digit answer is added together then added to the running total
	    // 3 * 2 = 6 add 6 (0 + 6) ; 6 * 2 = 12 add 3 (1 + 2)
	    for (i = 0; i < 66; i = i + 2) {
	        iDigit = parseInt(strScanLine.substr(i, 1)) * 2
	        if (iDigit.toString().length == 2) {
	            iDigit = parseInt(iDigit.toString().substr(0, 1)) + parseInt(iDigit.toString().substr(1, 1))
	        } 	//if
	        iTotal = iDigit + iTotal
	    }
	}  //for
	//Take the ones position and subtract from 10
	if (parseInt(iTotal.toString().substr(parseInt(iTotal.toString().length) - 1, 1)) == 0) {
		iTotal = 0
	} else {
		iTotal = 10 - parseInt(iTotal.toString().substr(parseInt(iTotal.toString().length) - 1, 1))
	} 	//if

	if (strAcctType == '98') {
	    strScanLine = strScanLine.substr(0, 58) + iTotal
	}
	else
	    strScanLine = strScanLine.substr(0, 67) + iTotal

	tempParameters = 'a=' + strAcctID + '&b=' + strAccountName + '&c=' + strAccountAddr + '&d=' + strScanLine + '&e=' + strPeriod + '&f=' + strAcctType + '&g=' + strAccountAddr + '|' + strAccountAddr2 + '|' + strAccountAddr3 + '|' + strAccountCity + '|' + strAccountState + '|' + strAccountZip
	tempParameters = tempParameters.replace(/#/g, '~LBSIGN~')


}		//SetupPassFields
