<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<html>
<head>
 <title></title>

<script type="text/javascript" language="javascript" src="../Content/Scripts/JqueryMin.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/ispFunctions.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/ispXmlProc.js"></script>

<link rel="Stylesheet" href="../Content/Styles/Font.css" />
<link rel="Stylesheet" href="../Content/Styles/Object.css" />


   
    <script language="JavaScript" type="text/javascript">
        var arrCouponPrt = new Array();
        var strUniqueText = ' ';
        var strSelectType = ' ';
        var strAcctID = ' ';
        var strBRTAcct = ' ';
        var strBRTaddr = ' ';
        var iSelectIdx = 0;
        var iTaxYear = 0;
        var strScanLine;
        var strAccountName;
        var strAccountAddr;
        var strCouponAddr;
        var strAccountType;
        var strPeriod;
        var strAcctType;
        var ifreq;
        var iCurrYear;


        function DisplayPrntCoupon() {
            parent.sNew = false;
            $('#LogPrntCoupon').css("display", "block");
            $('#AppHeader').html('Select Payment Coupon');

            LoadPrntCouponError();
            ddPCAcctType.selectedIndex = 0;
            ddPCAcctID.selectedIndex = 0;
            ddPCTaxYear.selectedIndex = 0;
            ddPCTaxPeriod.selectedIndex = 0;
            ddAccountAddr.selectedIndex = 0;
            FixLeadingZeroForSSN();

            LoadPCAccountType();
            $('tdPaPrint').css("display", "block");
            ddPCAcctType.disabled = false;
            var count = 0;
            var entid = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, 'ENTITY_INFO ENTITY_ID', '', 0);
            var account;
            //  alert((new XMLSerializer()).serializeToString(parent.$g.xmlPayCoupon));
            $(parent.$g.xmlPayCoupon).find("TAX_ACCT ACCOUNT_ID").each(function () {
                if ($(this).text() != null && $(this).text() != '' && $(this).text() == entid) {

                    // alert($(this).parent().find("ACCOUNT").text());
                    account = $(this).parent().find("ACCOUNT").text();
                    count = count + 1;
                }


            });


            //  if (parent.$x.ispXmlGetRecCount(parent.$g.xmlPayCoupon, 'TAX_ACCT ACCOUNT_ID = ' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, 'ENTITY_INFO ENTITY_ID', '', 0) + ', 'n') == 1)
            if (count == 1) {

                //var olXML = new ActiveXObject("Microsoft.XMLDOM");
                // var olXML = getXmlDocObj();
                //alert('in');
                //alert(olXML);
                //            olXML.loadXML(parent.$x.ispXmlGetRecordXml(parent.$g.xmlPayCoupon, 'TAX_ACCT[ACCOUNT_ID = ' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, 'ENTITY_INFO ENTITY_ID', '', 0) + ']'))

                // var olXML = parent.$x.ispXmlGetRecordXml(parent.$g.xmlPayCoupon, 'TAX_ACCT[ACCOUNT_ID = ' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, 'ENTITY_INFO ENTITY_ID', '', 0) + ']')


                for (var i = 0; i < ddPCAcctType.options.length; i++) {

                    // if ($(ddPCAcctType.options[i]).attr("CODE") == parent.$x.ispXmlGetFieldVal(olXML, 'ACCOUNT', '', 0))
                    if ($(ddPCAcctType.options[i]).attr("CODE") == account) {

                        $(ddPCAcctType.options[i]).attr('selected', 'true');

                        LoadPCAccountID();
                        break;
                    } 	//if
                } 	//for
                for (var i = 0; i < ddPCAcctID.options.length; i++) {
                    if (ddPCAcctID.options[i].innerText == parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, 'ENTITY_INFO ENTITY_ID', '', 0)) {
                        ddPCAcctID.options[i].selected = true;
                        LoadPCTaxYear();
                        break;
                    } 	//if
                    ddPCTaxYear.focus();
                } 	//for
                ValidatePrntCoupon();
            }
            else {

                ddPCAcctType.focus();
            } 	//if

            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, 'LOGIN_FROM NTL_ONLY', '', 0) == 'TRUE') {

                SetDDList(ddPCAcctType, '', '1');
                if (ddPCAcctType.selectedIndex != '0') {
                    AppHeader.innerHTML = 'Select No Tax Liability Coupon';
                    LoadPCAccountID();
                    tdPaPrint.style.display = 'none';
                    ddPCAcctType.disabled = true;
                    ddPCAcctID.focus();
                } else {
                    ddPCAcctType.selectedIndex = '0';
                } 	//if
            } 	//if
        } 	//DisplayPrntCoupon


        function FixLeadingZeroForSSN() {

            var icount = parent.$x.ispXmlGetRecCount(parent.$g.xmlPayCoupon, "TAX_ACCT", "");

            var sAcctId = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "ENTITY_INFO ACCT_ID", "", 0);

            var sAccount_Id;

            for (i = 0; i < icount; i++) {
                sAccount_Id = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "TAX_ACCT ACCOUNT_ID", "", i);

                if (sAccount_Id == sAcctId.substr(1)) {
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, sAcctId, "TAX_ACCT ACCOUNT_ID", "", i);

                } 	//if
            } 	//for
        } 	//FixLeadingZeroForSSN


        function ClearPrntCouponScreen() {
            for (i = 0; i < document.all.length; i++) {
                if (document.all.item(i).id.search(/txt/i) != -1) {
                    document.all.item(i).value = '';
                    document.all.item(i).className = 'inpNormal';
                } 	//if
            } 	//for
        } 	//ClearPrntCouponScreen     


        function LoadPrntCouponError() {
            var i = 0;

            arrCouponPrt[i++] = [ddPCAcctType, '$(ddPCAcctType.options[ddPCAcctType.selectedIndex]).text()=="Select"', 'Select Account Type'];
            arrCouponPrt[i++] = [ddPCAcctID, '$(ddPCAcctID.options[ddPCAcctID.selectedIndex]).text()=="Select"', 'Select Account ID'];
            //	arrCouponPrt[i++] = [ddPCTaxYear, 'ddPCTaxYear.options(ddPCTaxYear.selectedIndex).innerText=="Select"', 'Select Tax Year']
            //	arrCouponPrt[i++] = [ddPCTaxPeriod, 'ddPCTaxPeriod.options(ddPCTaxPeriod.selectedIndex).innerText=="Select"', 'Select Tax Period']
        }   //LoadPrntCouponError


        function ValidatePrntCoupon() {
            // AppError.innerText = ispSetInputErr(arrCouponPrt);
            var couponerr = ispSetInputErr(arrCouponPrt);
            //alert(couponerr);
            $('#AppError').text(couponerr);
        } 	//ValidatePrntCoupon


        function LoadPCAccountType() {
            var icount = parent.$x.ispXmlGetRecCount(parent.$g.xmlPayCoupon, "TAX_ACCT", "");

            var strInnerText = '';
            var iunique = 0;
            var lastUnique = '';
            var lastUniqueCode = '';

            $('#ddPCAcctType').html('');
            $('#ddPCAcctID').html('');
            $('#ddPCTaxYear').html('');
            $('#ddPCTaxPeriod').html('');
            $('#ddAccountAddr').html('');


            //EGOVWEB-61
            ddPCAcctType.options.length = icount + 1;
            ddPCAcctID.options.length = 0;
            ddPCTaxYear.options.length = 0;
            ddPCTaxPeriod.options.length = 0;

            $(ddPCAcctType.options[0]).text("Select");
            $(ddPCAcctType.options[0]).attr("CODE", "Select");



            for (i = 0; i < icount; i++) {
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "TAX_ACCT ACCOUNT", "", i) == '85') {
                    //Do not load UO - Tenant (85)
                } else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "TAX_ACCT ACCOUNT", "", i) == lastUniqueCode) {
                    lastUniqueCode = lastUniqueCode;
                } else {
                    lastUniqueCode = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "TAX_ACCT ACCOUNT", "", i);

                    if (lastUniqueCode > 0) {
                        strUniqueText = lastUniqueCode;
                        TranslateAccountType();

                        if (lastUnique == strUniqueText) {
                            iunique = iunique;
                        } else {
                            iunique = iunique + 1

                            $(ddPCAcctType.options[iunique]).text(strUniqueText);

                            $(ddPCAcctType.options[iunique]).attr("CODE", parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "TAX_ACCT ACCOUNT", "", i));
                            lastUnique = strUniqueText;
                        }  //if unique type
                    } //if lastUniqueCode
                }  //if  else
            }  //for

            if (iunique == 1) {

                $(ddPCAcctType.options[0]).text($(ddPCAcctType.options[1]).text());
                $(ddPCAcctType.options[0]).attr("CODE", $(ddPCAcctType.options[1]).attr("CODE"));
                ddPCAcctType.options.length = 1;
                ddPCAcctType.selectedIndex = 0;
                LoadPCAccountID();
                ddPCAcctID.focus();
            } else {

                ddPCAcctType.options.length = iunique + 1;

                if (ddPCAcctType.selectedIndex < '') {

                    LoadPCAccountID();
                    ddPCAcctID.focus();
                } else {

                    ddPCAcctType.focus();
                } //if
            } //if
            //	if (parent.$x.ispXmlGetRecCount(parent.$g.xmlPayCoupon, 'TAX_ACCT[ACCOUNT_ID = ' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, 'ENTITY_INFO/ENTITY_ID', '', 0) + ']', 'n')) {
            //ddPCAcctType.selectedIndex
            //	}		//if
            //  alert(parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, 'ENTITY_INFO/ENTITY_ID', '', 0))
        }   //loadPCAccountType

        function TranslateAccountType() {
            switch (strUniqueText) {
                case '1':
                    strUniqueText = 'Wage Tax';  //Wage     WAG
                    break
                case '2':
                    strUniqueText = 'Earnings Tax';  //Earnings   ERN
                    break
                case '3':
                    strUniqueText = 'Net Profits Tax'; //Net Profits   NPT
                    break
                case '6':
                    strUniqueText = 'Amusement Tax'; //Amusement    AMU
                    break
                case '8':
                    strUniqueText = 'Parking Tax'; //Parking    PRK
                    break
                case '9':
                    strUniqueText = 'Coin Operated Tax';  //Coin Operated    COI
                    break
                case '11':
                    strUniqueText = 'Police Tax'; //Police    POL
                    break
                case '14':
                    strUniqueText = 'Vehicle Rental Tax';  //Vehicle Rental   VRT
                    break
                case '18':
                    strUniqueText = 'Realty Transfer Tax'; //Realty Transfer   RTT
                    break
                case '23':
                    strUniqueText = 'Hotel Tax'; //Hotel   HOT
                    break
                case '24':
                    strUniqueText = 'Business Income and Receipts Tax';  //Business Income and Receipts   BIR
                    break
                    //EGOVWEB-49 - Items 6-8
                case '27':
                    strUniqueText = 'Tobacco Tax';  //Tobacco   TOB
                    break
                case '28':
                    strUniqueText = 'Liquor Tax'; //Liquor   LIQ
                    break
                case '29':
                    strUniqueText = 'School Income Tax'; //School Income   SIT
                    break
                case '58':
                    strUniqueText = 'Valet Parking'; //Valet Parking   VPT
                    break
                case '60':
                    strUniqueText = 'Real Estate Tax';  //Real Estate   REA
                    break
                case '76':
                    strUniqueText = 'Outdoor Advertizing Tax';  //Outdoor Advertizing   OAT
                    break
                case '84':
                    strUniqueText = 'U&O - Landlord Tax'; //U&O - Landlord   UOL
                    break
                case '85':
                    strUniqueText = 'U&O - Tenant Tax'; //U&O - Tenant   ASM
                    break
                case '90':
                    strUniqueText = 'Assessment Tax'; //Assessment Screen   ASM
                    break
                case '91':
                    strUniqueText = 'Police BRI Tax'; //Police BRI   GNP
                    break
                case '97':
                    strUniqueText = 'Enitiy Level Charges Tax'; //Entity Level Charges   GEN
                    break
                case '98':
                    strUniqueText = 'General'; //General   GN2
                    break
                case '99':
                    strUniqueText = 'Enitiy Level Charges'; //Enitiy Level Charges   GN9
                    break
                    return
            } 	//switch
        }  //TranslateAccountType

        function LoadPCAccountID() {
            var icount = parent.$x.ispXmlGetRecCount(parent.$g.xmlPayCoupon, "TAX_ACCT", "");

            var strInnerText = 'DESC';
            var iunique = 0;
            var strAccountType;

            strUniqueText = '';
            iSelectIdx = '';
            strSelectType = $(ddPCAcctType.options[ddPCAcctType.selectedIndex]).attr("CODE");

            $('#ddPCAcctID').html('');
            $('#ddPCTaxYear').html('');
            $('#ddPCTaxPeriod').html('');

            ddPCAcctID.options.length = icount;
            ddAccountAddr.options.length = icount;

            $(ddPCAcctID.options[0]).text('Select');
            $(ddPCAcctID.options[0]).attr("CODE", "Select");


            for (i = 0; i < icount; i++) {
                strAccountType = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "TAX_ACCT ACCOUNT", "", i);

                if (strAccountType == strSelectType) {
                    strUniqueText = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "TAX_ACCT ACCOUNT_ID", "", i);
                    if ($(ddPCAcctID.options[iunique]).text() == strUniqueText) {
                        iunique = iunique;
                    }
                    else {
                        if ($(ddPCAcctID.options[iunique]).text() > "") {
                            iunique = iunique + 1;
                        } // if
                        $(ddPCAcctID.options[iunique]).text(strUniqueText);
                        $(ddPCAcctID.options[iunique]).attr("CODE", parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "TAX_ACCT ACCOUNT_ID", "", i));
                        if (strSelectType == '60') {
                            strBRTAcct = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "TAX_ACCT BRT_ACCOUNT", "", i);
                            $(ddPCAcctID.options[iunique]).text(strBRTAcct);
                            $(ddAccountAddr.options[iunique]).text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "TAX_ACCT BRT_ADDRESS1", "", i));
                        } // if

                        iSelectIdx = i;
                    }  //if
                }  //if
            }  //for

            if (iunique == 1) {
                $(ddPCAcctID.options[0]).text($(ddPCAcctID.options[1]).text());
                $(ddPCAcctID.options[0]).attr("CODE", $(ddPCAcctID.options[1]).attr("CODE"));
                ddPCAcctID.options.length = 1;
                $(ddAccountAddr.options[0]).text($(ddAccountAddr.options[1]).innerText);

                LoadPCTaxYear();
                ddPCTaxYear.focus();
            } else {
                ddPCAcctID.options.length = iunique + 1; //EGOVWEB-106
                if (ddPCAcctID.selectedIndex < '') {

                    LoadPCTaxYear();
                    ddPCTaxYear.focus();
                } else {
                    ddPCTaxYear.focus();
                } //if
            } //if

            //	ValidatePrntCoupon()
            //	ddPCAcctID.options.innerText = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, 'ENTITY_INFO/ENTITY_ID', '', 0)

            //	ddPCAcctID.options.length = iunique	//Removed EGOVWEB-105 + 1

            if ($(ddPCAcctType.options[ddPCAcctType.selectedIndex]).attr("CODE") == 1) {
                //trNtlMessage.style.display = 'block';
                $('#trNtlMessage').css("display", "block");
                $('#trNtlMessage').css("visiblity", "visible");
                $('#trNtlMessage td').css("width", "100%");
                //tdPaNTL.style.display = 'block';
                $('#tdPaNTL').css("display", "block");
                $('#tdPaNTL').removeAttr("style");
                $('#trNtlMessage').removeAttr("style");
            } else {
                //trNtlMessage.style.display = 'none';
                $('#trNtlMessage').css("display", "none");
                //tdPaNTL.style.display = 'none';
                $('#tdPaNTL').css("display", "none");
            } 	//if
        }   //loadPCAccountID

        function LoadPCTaxYear() {
            var icount = 100;
            var strInnerText = 'DESC';
            var iTaxYear;
            var iStartYear;
            var iEndYear;

            ValidatePrntCoupon();


            $('#ddPCTaxYear').html('');
            $('#ddPCTaxPeriod').html('');


            ddPCTaxYear.options.length = icount;
            //strAcctID = ddPCAcctID.options(ddPCAcctID.selectedIndex).CODE;
            strAcctID = $(ddPCAcctID.options[ddPCAcctID.selectedIndex]).attr("CODE");

            if (strSelectType == '60') {
                strBRTAcct = $(ddPCAcctID.options[ddPCAcctID.selectedIndex]).text();
                strBRTAddr = $(ddAccountAddr.options[ddPCAcctID.selectedIndex]).text();
            } // if

            HoldDate = new Date(parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "TAX_ACCT START_DATE", "", iSelectIdx));

            iStartYear = HoldDate.getFullYear();

            HoldDate = new Date(parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "TAX_ACCT END_DATE", "", iSelectIdx));
            iEndYear = HoldDate.getFullYear();  // end of current year

            HoldDate = new Date();
            //EHD - 01122009 - Task EHD100 - Remove estimate current year from the BPT tax
            if (strSelectType == '24') {		//BPT
                iCurrYear = HoldDate.getFullYear() - 1;
            } else {
                iCurrYear = HoldDate.getFullYear(); // end of current year
            } 	//if


            if (iEndYear == 0) {
                iEndYear = iCurrYear;  // end of current year
            } //if

            if (iEndYear == '') {
                iEndYear = iCurrYear; // end of current year
            } //if

            if (iEndYear == 9999) {
                iEndYear = iCurrYear;  // end of current year
            } //if

            if (iEndYear > 1939) {
                if (iEndYear < 2500) {
                    iTaxYear = iEndYear;
                } else {
                    iEndYear = iCurrYear;  // end of current year
                }  //  inner if
            } else {
                iEndYear = iCurrYear; // end of current year
            }  // if

            iTaxYear = iEndYear
            //alert('iTaxYear' + iTaxYear);
            for (i = 0; i < icount; i++) {
                $(ddPCTaxYear.options[i]).text(iTaxYear);
                $(ddPCTaxYear.options[i]).attr("CODE", iTaxYear);
                iTaxYear = iTaxYear - 1
                if (iTaxYear < iStartYear) {
                    ddPCTaxYear.options.length = i + 1;
                    break
                } //if		
            }  //for

            ddPCTaxPeriod.focus();

            LoadTaxPeriods();

            if (iStartYear == iEndYear) {
                ddPCTaxPeriod.focus();
                LoadTaxPeriods();
            }
            else {
                if (iEndYear == HoldDate.getFullYear()) {
                    ddPCTaxPeriod.focus();
                    LoadTaxPeriods();
                }
                else {
                    ddPCTaxYear.focus()
                } //if
            } //if	
        }   //LoadPCTaxYear

        function LoadTaxPeriods() {
            ifreq = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "TAX_ACCT FREQUENCY_CODE", "", iSelectIdx);
          
            ValidatePrntCoupon();

            ddPCTaxPeriod.selectedIndex = 0;
            strTaxYear = $(ddPCTaxYear.options[ddPCTaxYear.selectedIndex]).attr("CODE");
            var isLeap = new Date(strTaxYear, 1, 29).getDate() == 29;

            switch (ifreq) {
                case 'Y':
                    ddPCTaxPeriod.options.length = 0;
                    if (strSelectType == '97') {
                        ddPCTaxPeriod.options.length = 2;
                        $(ddPCTaxPeriod.options[0]).text('December 31');
                        $(ddPCTaxPeriod.options[0]).attr("CODE", '1');
                        $(ddPCTaxPeriod.options[1]).text('December 31');
                        $(ddPCTaxPeriod.options[1]).attr("CODE", '12');
                    } //if
                    if (strSelectType == '24') {
                        //EHD - 01122009 - Task EHD100 - Remove estimate from the BPT tax 
                        ddPCTaxPeriod.options.length = 1	//2
                        //				ddPCTaxPeriod.options(0).innerText = 'Estimate'
                        //				ddPCTaxPeriod.options(0).CODE = '4'
                        $(ddPCTaxPeriod.options[0]).text('December 31');
                        $(ddPCTaxPeriod.options[0]).attr("CODE", '12');
                    } //if
                    if (ddPCTaxPeriod.options.length == 0) {
                        ddPCTaxPeriod.options.length = 1;
                        $(ddPCTaxPeriod.options[0]).text('December 31');
                        $(ddPCTaxPeriod.options[0]).attr("CODE", '12');
                        btnPaPrint.focus();
                    } //if
                    break;
                case 'H':
                    ddPCTaxPeriod.options.length = 2

                    $(ddPCTaxPeriod.options[0]).text('June 30');
                    $(ddPCTaxPeriod.options[0]).attr("CODE", '31');
                    $(ddPCTaxPeriod.options[1]).text('December 31');
                    $(ddPCTaxPeriod.options[1]).attr("CODE", '32');
                    break;
                case 'Q':
                    if (strSelectType == '1') {
                        ddPCTaxPeriod.options.length = 5;
                        $(ddPCTaxPeriod.options[0]).text('March 31');
                        $(ddPCTaxPeriod.options[0]).attr("CODE", "92");
                        $(ddPCTaxPeriod.options[1]).text('June 30');
                        $(ddPCTaxPeriod.options[1]).attr("CODE", "93");
                        $(ddPCTaxPeriod.options[2]).text('September 30');
                        $(ddPCTaxPeriod.options[2]).attr("CODE", "94");
                        //EGOVWEB-61
                        //EGOVWEB-61 EDD 2011.02.04 Last week payment must be 12/31/ccyy per Nancy
                        $(ddPCTaxPeriod.options[3]).text('December 31');
                        $(ddPCTaxPeriod.options[3]).attr("CODE", "95");
                        $(ddPCTaxPeriod.options[4]).text('Reconcile');
                        $(ddPCTaxPeriod.options[4]).attr("CODE", "96");
                    } //if
                    if (strSelectType == '2') {
                        ddPCTaxPeriod.options.length = 5;
                        $(ddPCTaxPeriod.options[0]).text('March 31');
                        $(ddPCTaxPeriod.options[0]).attr("CODE", "1");
                        $(ddPCTaxPeriod.options[1]).text('June 30');
                        $(ddPCTaxPeriod.options[1]).attr("CODE", "2");
                        $(ddPCTaxPeriod.options[2]).text('September 30');;
                        $(ddPCTaxPeriod.options[2]).attr("CODE", "3");
                        $(ddPCTaxPeriod.options[3]).text('December 31');
                        $(ddPCTaxPeriod.options[3]).attr("CODE", "4");
                        $(ddPCTaxPeriod.options[4]).text('Reconcile');
                        $(ddPCTaxPeriod.options[4]).attr("CODE", "5");
                    } //if
                    if (strSelectType == '84' || strSelectType == '85') {
                        ddPCTaxPeriod.options.length = 4;
                        $(ddPCTaxPeriod.options[0]).text('March 31');
                        $(ddPCTaxPeriod.options[0]).attr("CODE", "21");
                        $(ddPCTaxPeriod.options[1]).text('June 30');
                        $(ddPCTaxPeriod.options[1]).attr("CODE", "22");
                        $(ddPCTaxPeriod.options[2]).text('September 30');
                        $(ddPCTaxPeriod.options[2]).attr("CODE", "23");
                        $(ddPCTaxPeriod.options[3]).text('December 31');
                        $(ddPCTaxPeriod.options[3]).attr("CODE", "24");
                    } //if
                    break
                case 'M':
                    ddPCTaxPeriod.options.length = 12;
                    $(ddPCTaxPeriod.options[0]).text('January 31');
                    $(ddPCTaxPeriod.options[0]).attr("CODE", "1");
                    if (isLeap) {
                        $(ddPCTaxPeriod.options[1]).text('February 29');
                    } else {
                        $(ddPCTaxPeriod.options[1]).text('February 28');
                    } 	//if
                    $(ddPCTaxPeriod.options[1]).attr("CODE", "2");
                    $(ddPCTaxPeriod.options[2]).text('March 31');
                    $(ddPCTaxPeriod.options[2]).attr("CODE", "3");
                    $(ddPCTaxPeriod.options[3]).text('April 30');
                    $(ddPCTaxPeriod.options[3]).attr("CODE", "4");
                    $(ddPCTaxPeriod.options[4]).text('May 31');
                    $(ddPCTaxPeriod.options[4]).attr("CODE", "5");
                    $(ddPCTaxPeriod.options[5]).text('June 30');
                    $(ddPCTaxPeriod.options[5]).attr("CODE", "6");
                    $(ddPCTaxPeriod.options[6]).text('July 31');
                    $(ddPCTaxPeriod.options[6]).attr("CODE", "7");
                    $(ddPCTaxPeriod.options[7]).text('August 31');
                    $(ddPCTaxPeriod.options[7]).attr("CODE", "8");
                    $(ddPCTaxPeriod.options[8]).text('September 30');
                    $(ddPCTaxPeriod.options[8]).attr("CODE", "9");
                    $(ddPCTaxPeriod.options[9]).text('October 31');
                    $(ddPCTaxPeriod.options[9]).attr("CODE", "10");
                    $(ddPCTaxPeriod.options[10]).text('November 30');
                    $(ddPCTaxPeriod.options[10]).attr("CODE", "11");
                    //EGOVWEB-61 EDD 2011.02.04 Last week payment must be 12/31/ccyy per Nancy
                    $(ddPCTaxPeriod.options[11]).text('December 31');
                    $(ddPCTaxPeriod.options[11]).attr("CODE", "12");
                    if (strSelectType == '1' || strSelectType == '6' || strSelectType == '8' ||
					strSelectType == '23' || strSelectType == '28' || strSelectType == '58' ||
					strSelectType == '76') {
                        ddPCTaxPeriod.options.length = 13;
                        $(ddPCTaxPeriod.options[12]).text('Reconcile');

                        $(ddPCTaxPeriod.options[12]).attr("CODE", "13");
                    } //if
                    if (strSelectType == '1' && strTaxYear > '1996') {
                        $(ddPCTaxPeriod.options[0]).attr("CODE", "79");
                        $(ddPCTaxPeriod.options[1]).attr("CODE", "80");
                        $(ddPCTaxPeriod.options[2]).attr("CODE", "81");
                        $(ddPCTaxPeriod.options[3]).attr("CODE", "82");
                        $(ddPCTaxPeriod.options[4]).attr("CODE", "83");
                        $(ddPCTaxPeriod.options[5]).attr("CODE", "84");
                        $(ddPCTaxPeriod.options[6]).attr("CODE", "85");
                        $(ddPCTaxPeriod.options[7]).attr("CODE", "86");
                        $(ddPCTaxPeriod.options[8]).attr("CODE", "87");
                        $(ddPCTaxPeriod.options[9]).attr("CODE", "88");
                        $(ddPCTaxPeriod.options[10]).attr("CODE", "89");
                        $(ddPCTaxPeriod.options[11]).attr("CODE", "90");
                        //EGOVWEB-61
                        ddPCTaxPeriod.options.length = 13;
                        $(ddPCTaxPeriod.options[12]).text('Reconcile');
                        $(ddPCTaxPeriod.options[12]).attr("CODE", "91");
                    } //if
                    break;
                case 'S':
                    ddPCTaxPeriod.options.length = 25
                    $(ddPCTaxPeriod.options[0]).text('January 15');
                    $(ddPCTaxPeriod.options[0]).attr("CODE", "54");
                    $(ddPCTaxPeriod.options[1]).text('January 31');
                    $(ddPCTaxPeriod.options[1]).attr("CODE", "55");
                    $(ddPCTaxPeriod.options[2]).text('February 15');
                    $(ddPCTaxPeriod.options[2]).attr("CODE", "56");
                    //EGOVWEB-61
                    if (isLeap) {
                        $(ddPCTaxPeriod.options[3]).text('February 29');
                    } else {

                        $(ddPCTaxPeriod.options[3]).text('February 28');
                    } 	//if
                    $(ddPCTaxPeriod.options[3]).attr("CODE", "57");
                    $(ddPCTaxPeriod.options[4]).text('March 15');
                    $(ddPCTaxPeriod.options[4]).attr("CODE", "58");
                    $(ddPCTaxPeriod.options[5]).text('March 31');
                    $(ddPCTaxPeriod.options[5]).attr("CODE", "59");
                    $(ddPCTaxPeriod.options[6]).text('April 15');
                    $(ddPCTaxPeriod.options[6]).attr("CODE", "60");
                    $(ddPCTaxPeriod.options[7]).text('April 30');
                    $(ddPCTaxPeriod.options[7]).attr("CODE", "61");
                    $(ddPCTaxPeriod.options[8]).text('May 15');
                    $(ddPCTaxPeriod.options[8]).attr("CODE", "62");
                    $(ddPCTaxPeriod.options[9]).text('May 31');
                    $(ddPCTaxPeriod.options[9]).attr("CODE", "63");
                    $(ddPCTaxPeriod.options[10]).text('June 15');
                    $(ddPCTaxPeriod.options[10]).attr("CODE", "64");
                    $(ddPCTaxPeriod.options[11]).text('June 30');
                    $(ddPCTaxPeriod.options[11]).attr("CODE", "65");
                    $(ddPCTaxPeriod.options[12]).text('July 15');
                    $(ddPCTaxPeriod.options[12]).attr("CODE", "66");
                    $(ddPCTaxPeriod.options[13]).text('July 31');
                    $(ddPCTaxPeriod.options[13]).attr("CODE", "67");
                    $(ddPCTaxPeriod.options[14]).text('August 15');
                    $(ddPCTaxPeriod.options[14]).attr("CODE", "68");
                    $(ddPCTaxPeriod.options[15]).text('August 31');
                    $(ddPCTaxPeriod.options[15]).attr("CODE", "69");
                    $(ddPCTaxPeriod.options[16]).text('September 15');
                    $(ddPCTaxPeriod.options[16]).attr("CODE", "70");
                    $(ddPCTaxPeriod.options[17]).text('September 30');
                    $(ddPCTaxPeriod.options[17]).attr("CODE", "71");
                    $(ddPCTaxPeriod.options[18]).text('October 15');
                    $(ddPCTaxPeriod.options[18]).attr("CODE", "72");
                    $(ddPCTaxPeriod.options[19]).text('October 31');
                    $(ddPCTaxPeriod.options[19]).attr("CODE", "73");
                    $(ddPCTaxPeriod.options[20]).text('November 15');
                    $(ddPCTaxPeriod.options[20]).attr("CODE") = '74';
                    $(ddPCTaxPeriod.options[21]).text('November 30');
                    $(ddPCTaxPeriod.options[21]).attr("CODE", "75");
                    $(ddPCTaxPeriod.options[22]).text('December	15');
                    $(ddPCTaxPeriod.options[22]).attr("CODE", "76");
                    //EGOVWEB-61 EDD 2011.02.04 Last week payment must be 12/31/ccyy per Nancy
                    $(ddPCTaxPeriod.options[23]).text('December 31');
                    $(ddPCTaxPeriod.options[23]).attr("CODE", "77");
                    //EGOVWEB-61
                    $(ddPCTaxPeriod.options[24]).text('Reconcile');
                    $(ddPCTaxPeriod.options[24]).attr("CODE", "78");
                    break
                case 'W':
                    var DayToBeDisplayed = 6; //1 = Monday
                    var i = 0;
                    var j = 0;
                    //			var strTaxYear = 2000
                    var WagDate = new Date(strTaxYear, 0, 1);

                    var DayCalc = WagDate.getDay();
                    DayCalc = WagDate.getDate() + (-1 * (DayCalc - DayToBeDisplayed));
                    var WagDate = new Date(WagDate.getFullYear(), WagDate.getMonth(), DayCalc);

                    ddPCTaxPeriod.options.length = 0;
                    //EGOVWEB-54 EDD First week payment for 2011 is 1/8/2011
                    if (WagDate.getFullYear() == '2011') {
                        WagDate = new Date('01/08/2011');
                        ddPCTaxPeriod.options.length = 53;
                    } else if (WagDate.getFullYear() == '2010') {
                        WagDate = new Date('01/09/2010');
                        ddPCTaxPeriod.options.length = 53;
                    } else {
                        ddPCTaxPeriod.options.length = 54;
                    } 	//if
                    $(ddPCTaxPeriod.options[0]).text('Select');
                    $(ddPCTaxPeriod.options[0]).attr("CODE", "Select");
                    j = j + 1;

                    if (WagDate.getFullYear() != strTaxYear) {
                        var WagDate = new Date(WagDate.getFullYear(), WagDate.getMonth(), WagDate.getDate() + 7);
                    } 	//if
                    if (WagDate.getDay() == 6) {  // was 1
                        var temp = new Date(WagDate.getFullYear(), WagDate.getMonth(), WagDate.getDate());

                        while (temp.getFullYear() == strTaxYear) {
                            $(ddPCTaxPeriod.options[j]).text((temp.getMonth() + 1) + '/' + temp.getDate() + '/' + temp.getFullYear());
                            $(ddPCTaxPeriod.options[j]).attr("CODE", j);
                            j = j + 1;
                            i = i + 7;
                            temp = new Date(WagDate.getFullYear(), WagDate.getMonth(), WagDate.getDate() + i);
                        } 	//While
                    } 	//if
                    //EGOVWEB-54 EDD Last week payment must be 12/30/ccyy
                    //EGOVWEB-61 EDD 2011.02.04 Last week payment must be 12/31/ccyy per Nancy
                    if (ddPCTaxPeriod.options.length == 54 && j == 53) {
                        $(ddPCTaxPeriod.options[53]).text('12/31/' + strTaxYear);
                    } else if (j == 53 || j == 52) {
                        $(ddPCTaxPeriod.options[52]).text('12/31/' + strTaxYear);
                    } 	//if
                    ddPCTaxPeriod.options.length = ddPCTaxPeriod.options.length + 1;
                    $(ddPCTaxPeriod.options[ddPCTaxPeriod.length - 1]).text('Reconcile');
                    $(ddPCTaxPeriod.options[ddPCTaxPeriod.length - 1]).attr("CODE", "53");
                    break;
            } 	//switch	

        } //LoadTaxPeriods


        function SetupPassFields() {
            var strPayPeriod = $(ddPCTaxPeriod.options[ddPCTaxPeriod.selectedIndex]).attr("CODE");
            strAccountName = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "ENTITY_INFO NAME", "");
            strAccountAddr = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "ENTITY_INFO ADDRESS1", "");
            var strAccountAddr2 = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "ENTITY_INFO ADDRESS2", "");
            var strAccountAddr3 = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "ENTITY_INFO ADDRESS3", "");
            var strAccountCity = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "ENTITY_INFO CITY", "");
            var strAccountState = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "ENTITY_INFO STATE", "");
            var strAccountZip = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "ENTITY_INFO ZIP_CODE", "");
            var strEntityID = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "ENTITY_INFO ENTITY_ID", "");

            var i = 0;
            var iTotal = 0;
            var iDigit = 0;
            var strScanID;

            if (strSelectType == '60') {
                strCouponAddr = strBRTAddr;
                strAcctID = strBRTAcct;
            } else {
                strCouponAddr = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "ENTITY_INFO ADDRESS1", "");
            }  //if

            strPeriod = $(ddPCTaxPeriod.options[ddPCTaxPeriod.selectedIndex]).text();
            strAcctType = $(ddPCAcctType.options[ddPCAcctType.selectedIndex]).text();
            strAcctType = strAcctType;
            if (ifreq == 'W') {
                strPeriod = strPeriod;
            } else {
                strPeriod = strPeriod + ', ' + $(ddPCTaxYear.options[ddPCTaxYear.selectedIndex]).attr("CODE");
            } //if

            //        make type 2 digits	
            if (new Number(strSelectType) < 10) {
                strSelectType = '0' + strSelectType;
            } //if		

            //		  add sufffix for UOL, UOT	
            if (strAcctID.length == 7) {
                if (strSelectType == '84' || strSelectType == '85') {
                    if (strAcctID.substr(7, 8) == '  ') {
                        strAcctID.substr(7, 8) = '00';
                    } //if
                } // if
            } // if

            //		  make Account Id 12 bytes long	
            if (strAcctID.length == 12) {
                strScanID = strAcctID;
            } //if
            if (strAcctID.length == 11) {
                strScanID = strAcctID + '0';
            } //if
            if (strAcctID.length == 10) {
                strScanID = strAcctID + '00';
            } //	if
            if (strAcctID.length == 9) {
                strScanID = strAcctID + '000';
            } //	if
            if (strAcctID.length == 8) {
                strScanID = strAcctID + '0000';
            } //	if
            if (strAcctID.length == 7) {
                strScanID = strAcctID + '00000';
            } //	if
            if (strAcctID.length == 6) {
                strScanID = strAcctID + '000000';
            } //	if
            if (strAcctID.length == 5) {
                strScanID = strAcctID + '0000000';
            } //	if
            if (strAcctID.length == 4) {
                strScanID = strAcctID + '00000000';
            } //	if
            if (strAcctID.length == 3) {
                strScanID = strAcctID + '000000000';
            } //	if
            if (strAcctID.length == 2) {
                strScanID = strAcctID + '0000000000';
            } //	if
            if (strAcctID.length == 1) {
                strScanID = strAcctID + '00000000000';
            } //	if

            //		  Make pay period 2 digits
            if (strPayPeriod < 10) {
                strPayPeriod = '0' + strPayPeriod;
            } //if

            //		  Get today's date for due date
            HoldDate = new Date();
            holdmonth = HoldDate.getMonth();
            holdmonth = holdmonth + 1;
            if (holdmonth < 10) {
                holdmonth = '0' + holdmonth;
            } // if

            holdday = HoldDate.getDate();
            if (holdday < 10) {
                holdday = '0' + holdday;
            } // if

            holdyear = HoldDate.getFullYear();
            twoyear = holdyear;
            //		  find 2 digit year
            if (twoyear > 2000) {
                while (twoyear > 999) {
                    twoyear = twoyear - 1000;
                }  //while
                while (twoyear > 99) {
                    twoyear = twoyear - 100;
                }  //while
                if (twoyear < 10) {
                    twoyear = '0' + twoyear;
                } //if
            } //if

            //		create dates for scan lines
            HoldDate = new String(holdmonth) + new String(holdday) + new String(twoyear);

            //  Format Period year
            twoyear = $(ddPCTaxYear.options[ddPCTaxYear.selectedIndex]).attr("CODE");
            //		  find 2 digit year
            if (twoyear > 2000) {
                while (twoyear > 999) {
                    twoyear = twoyear - 1000;
                }  //while
                while (twoyear > 99) {
                    twoyear = twoyear - 100;
                }  //while
                if (twoyear < 10) {
                    twoyear = '0' + twoyear;
                } //if
            } //if

            //		create century code for SIT accounts (in CCYY year, century code is 2nd C)\
            centurySIT = '00';
            if (holdyear < 1999) {
                centurySIT = '09';
            } //if

            if (strSelectType == '11') {
                strScanLine = '333' + strSelectType + HoldDate + '0000' + strScanID + '0000000000000000000000000000000000000000'
            } else if (strSelectType == '29') {
                strScanLine = '333' + strSelectType + HoldDate + '00' + '00000' + strScanID + '0000000000000000000'
				+ centurySIT + twoyear + '000000000000000'
            } else if (strSelectType == '84' || strSelectType == '85') {
                strScanLine = '333' + strSelectType/*2 bytes*/ + HoldDate/*6 bytes*/ + '00' + '000000' + strScanID/*12 bytes*/ + '0000000000000000000' + twoyear/*2 bytes*/ + strPayPeriod/*2 bytes*/ + '0000000000000'
                //20100301 EHD Real Estate needs to have the 2 year code in the scan line
            } else if (strSelectType == '60') {
                strScanLine = '333' + strSelectType + HoldDate + '0000' + '0000' + strScanID/*12 bytes*/
				+ '000000000000000000' + '0' + twoyear + '000000000000000'
            } else {
                strScanLine = '333' + strSelectType + HoldDate + '00' + '000000' + strScanID
			+ '000000000000000000' + strPayPeriod + twoyear + '000' + '00000000000000000000'
            } //if

            //TODO Fix Check Digit Routine
            //Check digit routine
            //Even numbers added together for a running total
            strScanLine = strScanLine.substr(0, 67)
            for (i = 1; i <= 66; i = i + 2) {
                iTotal = iTotal + parseInt(strScanLine.substr(i, 1));
            }  //for
            //Odd numbers Multiplied by 2 then the 2 digit answer is added together then added to the running total
            // 3 * 2 = 6 add 6 (0 + 6) ; 6 * 2 = 12 add 3 (1 + 2)
            for (i = 0; i <= 66; i = i + 2) {
                iDigit = parseInt(strScanLine.substr(i, 1)) * 2
                //		alert(parseInt(strScanLine.substr(i, 1)) + '   ' + iDigit)
                if (iDigit.toString().length == 2) {
                    iDigit = parseInt(iDigit.toString().substr(0, 1)) + parseInt(iDigit.toString().substr(1, 1));
                    //			alert('2 byte   ' + iDigit)
                } 	//if
                iTotal = iDigit + iTotal
            }  //for
            //Take the ones position and subtract from 10
            if (parseInt(iTotal.toString().substr(parseInt(iTotal.toString().length) - 1, 1)) == 0) {
                iTotal = 0;
            } else {
                iTotal = 10 - parseInt(iTotal.toString().substr(parseInt(iTotal.toString().length) - 1, 1));
            } 	//if

            strScanLine = strScanLine + iTotal;

            //	if (strSelectType == '60') {  // use entity for account in grid if Real Estate
            //	strAcctID = strBRTAcct     
            //	}  //if

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, strSelectType, "COUPON_FORM CPN_ACCOUNT_TYPE", "");
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, strAcctID, "COUPON_FORM CPN_ACCOUNT", "");
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, strAccountName, "COUPON_FORM CPN_NAME", "");
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, strAccountAddr, "COUPON_FORM CPN_ADDR", "");
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, strScanLine, "COUPON_FORM CPN_SCAN", "");
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, strAccountAddr2, "COUPON_FORM CPN_ADDR2", "");
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, strAccountAddr3, "COUPON_FORM CPN_ADDR3", "");
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, strAccountCity, "COUPON_FORM CPN_CITY", "");
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, strAccountState, "COUPON_FORM CPN_STATE", "");
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, strAccountZip, "COUPON_FORM CPN_ZIP_CODE", "");

            //	if (strSelectType == '60') {  // use entity for account in grid if Real Estate
            //	strAccountAddr = strBRTAddr 
            //	}  //if


        } 	//SetupPassFields

        function AdjustNameDisplay() {
            var sEntityName = strAccountName
            var lName = "", fName = "", mName = "", newName = ""

            if (sEntityName.indexOf("*") != -1) {    //If name contains *'s 
                sEntityName = sEntityName.split("*")
                lName = (sEntityName[0].substr(0, 1).toUpperCase()) + (sEntityName[0].substr(1).toLowerCase());
                if (sEntityName[1]) {
                    fName = (sEntityName[1].substr(0, 1).toUpperCase()) + (sEntityName[1].substr(1).toLowerCase());
                }  //if 
                if (sEntityName[2]) {
                    mName = sEntityName[2].substr(0, 1).toUpperCase();
                } //if</SPAN> 
                strAccountName = fName + " " + mName + " " + lName
            } //if return sEntityName 
        } //AdjustNameDisplay

        function NTLPrntCoupon() {
            var lsPeriod = $(ddPCTaxPeriod.options[ddPCTaxPeriod.selectedIndex]).text().toLowerCase();
            lsPeriod = lsPeriod.replace(' ', '');

            if (ifreq == 'W') {
                a = lsPeriod.split('/');
                if (a[0].length == 1) {
                    a[0] = '0' + a[0];
                } 	//if
                if (a[1].length == 1) {
                    a[1] = '0' + a[1];
                } 	//if
                lsPeriod = a[0] + '' + a[1];
            } else {
                if (lsPeriod.match('january') != null) {
                    lsPeriod = lsPeriod.replace('january', '01');
                } else if (lsPeriod.match('february') != null) {
                    lsPeriod = lsPeriod.replace('february', '02');
                } else if (lsPeriod.match('march') != null) {
                    lsPeriod = lsPeriod.replace('march', '03');
                } else if (lsPeriod.match('april') != null) {
                    lsPeriod = lsPeriod.replace('april', '04');
                } else if (lsPeriod.match('may') != null) {
                    lsPeriod = lsPeriod.replace('may', '05');
                } else if (lsPeriod.match('june') != null) {
                    lsPeriod = lsPeriod.replace('june', '06');
                } else if (lsPeriod.match('july') != null) {
                    lsPeriod = lsPeriod.replace('july', '07');
                } else if (lsPeriod.match('august') != null) {
                    lsPeriod = lsPeriod.replace('august', '08');
                } else if (lsPeriod.match('september') != null) {
                    lsPeriod = lsPeriod.replace('september', '09');
                } else if (lsPeriod.match('october') != null) {
                    lsPeriod = lsPeriod.replace('october', '10');
                } else if (lsPeriod.match('november') != null) {
                    lsPeriod = lsPeriod.replace('november', '11');
                } else if (lsPeriod.match('december') != null) {
                    lsPeriod = lsPeriod.replace('december', '12');
                } else if (lsPeriod.match('reconcile') != null) {
                    lsPeriod = '1231';
                } 	//if
            } 	//if
            lsPeriod = $(ddPCTaxYear.options[ddPCTaxYear.selectedIndex]).text() + lsPeriod;
            //EGOVWEB-61 EDD 2011.02.04 Last week payment must be 12/31/ccyy per Nancy Needs to go MF as 30
            if (lsPeriod.substr(4) == '1231' && strSelectType == '1') {
                lsPeriod = lsPeriod.replace('1231', '1230');
                //		alert(lsPeriod)
            } 	//if

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, $(ddPCAcctID.options[ddPCAcctID.selectedIndex]).text(), "WAGE_NTL ACCOUNT_ID", "");
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, lsPeriod, "WAGE_NTL PERIOD", "");
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, ifreq, "WAGE_NTL FREQUENCY_CODE", "");
            // parent.DocWin.location.href = 'NTL_Initial';
            parent.setFrameUrl('PayCoupon/NTL_Initial')
        } 	//NTLPrntCoupon

        function CnclPrntCoupon() {
            // parent.DocWin.location.href = '../login/Main';
            parent.setFrameUrl('login/Main')
        }  // CnclPrntCoupon

        function SubmitPrntCoupon() {

            if (ddPCAcctType.selectedIndex < 0) {
                ddPCAcctType.selectedIndex = 0;
            } // if

            if (ddPCAcctID.selectedIndex < 0) {
                ddPCAcctID.options.length = 1;
                $(ddPCAcctID.options[0]).text('');
                ddPCAcctID.selectedIndex = 0;
            } // if

            ValidatePrntCoupon()
            //if ($('#AppError').text() > '') {
            //  return;
            //} 	//if

            SetupPassFields();

            AdjustNameDisplay();

            //            parent.NavWin.lbl1.innerHTML = 'Creating Coupon Please Wait...';
            //            parent.NavWin.rowLabel.style.display = 'block';
           // $(parent.NavWin.lbl1).html('Creating Coupon Please Wait...');
           // $(parent.NavWin.rowLabel).css("display", "block");

            var strAcctType = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_ACCOUNT_TYPE", "");
            var strAccountAddr = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_ADDR", "");
            var strAccountAddr2 = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_ADDR2", "");
            var strAccountAddr3 = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_ADDR3", "");
            var strAccountCity = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_CITY", "");
            var strAccountState = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_STATE", "");
            var strAccountZip = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_ZIP_CODE", "");

            //EHD - v4.2.7 - # sign not allowed in URL Querystring 
            //		Change # to ~LBSIGN~ convert back in CouponImage.asp
            var tempParameters = 'a=' + strAcctID + '&b=' + strAccountName + '&c=' + strCouponAddr + '&d=' + strScanLine + '&e=' + strPeriod + '&f=' + strAcctType + '&g=' + strAccountAddr + '|' + strAccountAddr2 + '|' + strAccountAddr3 + '|' + strAccountCity + '|' + strAccountState + '|' + strAccountZip;
            tempParameters = tempParameters.replace(/#/g, '~LBSIGN~');

            //EGOVWEB-66
            //	var xmlTemp = new ActiveXObject("MSXML.DOMDocument")
            // parent.DocWin.location.href = 'PDFCouponCreate?' + tempParameters;//Sangha
            parent.setFrameUrl('PayCoupon/PDFCouponCreate?y=' + tempParameters);
            //	ispCallXMLForm(parent.$g.xmlPayCoupon, xmlTemp, 'PDFCouponCreate.asp?' + tempParameters, '')
            //	alert(xmlTemp)
            //  parent.DocWin.location.href = '../CouponImages/Temp.pdf'
            return;

            parent.DocWin.location.href = 'CouponImageAsp?' + tempParameters; 	//a=' + strAcctID + '&b=' + strAccountName + '&c=' + strCouponAddr + '&d=' + strScanLine + '&e=' + strPeriod + '&f' + strAcctType + ''

        } 	//SubmitPrntCoupon

        //EGOVWEB-61
        function DisplayNTLbutton() {
            btnPaNTL.disabled = false;
            if ($(ddPCTaxPeriod.options[ddPCTaxPeriod.selectedIndex]).text().toUpperCase() == 'RECONCILE' && $(ddPCAcctType.options[ddPCAcctType.selectedIndex]).text().toUpperCase() == 'WAGE TAX') {
                btnPaNTL.disabled = true;
            } 	//if
        } 	//DisplayNTLbutton
</script>
</head>
    <%
        Html.RenderAction("AppHeader", "INC");    
    %>

<body onload="DisplayPrntCoupon()">
	
<DIV style="DISPLAY: block; VISIBILITY: visible" Id="LogPrntCoupon" Name="LogPrntCoupon">

<table cellSpacing="0" cellPadding="0" width="586" border="0" style="MARGIN-LEFT: 4%; WIDTH: 586px; TOP: 50px; HEIGHT: 295px" id=TABLE1>
	<tr style="HEIGHT: 0px">
		<td width="5%"><p>&nbsp;</p></td>
		<td width="5%"><p>&nbsp;</p></td>
		<td width="5%"><p>&nbsp;</p></td>																																		
		<td width="5%"><p>&nbsp;</p></td>
		<td width="5%"><p>&nbsp;</p></td>
		<td width="5%"><p>&nbsp;</p></td>
		<td width="5%"><p>&nbsp;</p></td>
		<td width="5%"><p>&nbsp;</p></td>
		<td width="5%"><p>&nbsp;</p></td>
		<td width="5%"><p>&nbsp;</p></td>
		<td width="5%"><p>&nbsp;</p></td>
		<td width="5%"><p>&nbsp;</p></td>
		<td width="5%"><p>&nbsp;</p></td>
		<td width="5%"><p>&nbsp;</p></td>
		<td width="5%"><p>&nbsp;</p></td>
		<td width="5%"><p>&nbsp;</p></td>
		<td width="5%"><p>&nbsp;</p></td>
		<td width="5%"><p>&nbsp;</p></td>
		<td width="5%"><p>&nbsp;</p></td>
		<td width="5%"><p>&nbsp;</p></td>
	</tr>	
	<tr>
		<td nowrap colspan="4"><p class="lblInstrNormal">Account Type:</p></td>
		<td class=lblInstrRequired>*</td>
		<td colspan="8" align="left"><SELECT id=ddPCAcctType style="WIDTH: 253px" name=ddPCAcctType 
				onchange=LoadPCAccountID() dataFld="">
				<OPTION selected></OPTION></SELECT></td></tr>
	<tr>
		<td nowrap colspan="4"><p class="lblInstrNormal" id=txtPCAcctID>  Account ID:</p></td>
		<td class=lblInstrRequired>*</td>
		<td colspan="8" align="left"><SELECT id=ddPCAcctID 
      style="WIDTH: 253px" name=ddPCAcctID onchange=LoadPCTaxYear()> <OPTION 
  selected></OPTION></SELECT></td></tr>
	<tr >
		<td nowrap colspan="4"><p class="lblInstrNormal">Tax Year:</p></td>
		<td class=lblInstrRequired>*</td>
		<td colspan="8" align="left"><SELECT id=ddPCTaxYear 
      style="WIDTH: 95px" name=ddPCTaxYear onchange=LoadTaxPeriods() > <OPTION 
selected></OPTION></SELECT></td></tr>
<!--EGOVWEB-61 Within the Row below-->
	<tr>
		<td nowrap colspan="4"><p class="lblInstrNormal"> Period:</p></td>
		<td class=lblInstrRequired>*</td>
		<td colspan="8" align="left"><SELECT id=ddPCTaxPeriod 
      style="WIDTH: 253px" name=ddPCTaxPeriod onchange=DisplayNTLbutton()> <OPTION 
  selected></OPTION></SELECT></td></tr>
	<tr style="DISPLAY: none; visibility: visible" >
		<td nowrap colspan="4"><p class="lblInstrNormal">&nbsp;</p></td>
		<td class=lblInstrRequired></td>
		<td ></td>
		<td ></td>
		<td ></td>
		<td ><p class="lblInstrNormal" align="center">&nbsp;</p></td>
		<td ></td></tr>
	<tr><td colspan="20"><p><SELECT id=ddAccountAddr 
        style="VISIBILITY: hidden"> <OPTION selected></OPTION></SELECT></p></td></tr> 

	<tr class="lblInstrNormal" id=trNtlMessage style="DISPLAY: none; visibility: visible">
		<td colspan=20><p>If you have no tax liability for the selected period, click the NTL Coupon Button
				to Process a NTL payment.</p><p>&nbsp;</p></td><tr>
	
	<tr><td colspan="3"><p>&nbsp;</p></td>
		<td id=tdPaNTL colspan="5" style="DISPLAY: none; visibility: visible"><p>
			<INPUT class=btnNormal id=btnPaNTL onclick=NTLPrntCoupon() type=button size=59 value="NTL Coupon" 
					name=btnPaNTL style="WIDTH: 95px; HEIGHT: 24px"></p></td>
		<td id=tdPaPrint colspan="3"><p>
			<INPUT class=btnNormal id=btnPaPrint onclick=SubmitPrntCoupon() type=button value="Create Coupon" 
					name=btnPaPrint style="WIDTH: 106px; HEIGHT: 24px" size=87></p></td> 
		<td colspan="2"><p>&nbsp;</p></td>
		<td colspan="3"><p>
			<INPUT class=btnNormal id=btnPaCncl onclick=CnclPrntCoupon() type=button size=59 value="Cancel"
					name=btnPaCncl style="WIDTH: 75px; HEIGHT: 24px"></p></td></tr>
  <TR>
		<td colspan="8"><p>&nbsp;</p></td></TR>
</table>
</DIV>
</body>
</html>
