<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
    <title></title>

    <script type="text/javascript" language="javascript" src="../Content/Scripts/JqueryMin.js"></script>
    <script type="text/javascript" language="javascript" src="../Content/Scripts/ispFunctions.js"></script>
    <script type="text/javascript" language="javascript" src="../Content/Scripts/ispXmlProc.js"></script> 
    <script src="../Content/js/IDAutomation_PDF417.js" type="text/javascript"></script> 
    	<script src="../Content/js/bcmath-min.js" type="text/javascript"></script>
    <script src="../Content/js/pdf417-min.js" type="text/javascript"></script>
    <link type="text/css" rel="Stylesheet" href="../Content/Styles/framestyle.css" />
 
     <link href="../Content/Styles/bootstrap.css" rel="stylesheet">
    <script type="text/javascript" src="../Content/js/barcode.js"></script>
    <!-- Custom CSS -->
    <link href="../Content/Styles/copegov.css" rel="stylesheet">
    <link href="../Content/Styles/style.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../Content/Styles/jPushMenu.css">
    
  
   
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
        var arrCoupPINErr = new Array();
        var curInd = '';
        var link;
        var strForm;
        var strFormId;
        var linkScan='';
        //var strForm = '';

        function generate(data) {          
           
            PDF417.init(data);

            var barcode = PDF417.getBarcodeArray();

            // block sizes (width and height) in pixels
            var bw = 1;
            var bh = 2;

            // create canvas element based on number of columns and rows in barcode
            var canvas = document.createElement('canvas');
            canvas.width = bw * barcode['num_cols'];
            canvas.height = bh * barcode['num_rows'];
           // parent.document.getElementById('imagedata').appendChild(canvas);

            var ctx = canvas.getContext('2d');

            // graph barcode elements
            var y = 0;
            // for each row
            for (var r = 0; r < barcode['num_rows']; ++r) {
                var x = 0;
                // for each column
                for (var c = 0; c < barcode['num_cols']; ++c) {
                    if (barcode['bcode'][r][c] == 1) {
                        ctx.fillRect(x, y, bw, bh);
                    }
                    x += bw;
                }
                y += bh;
            }

            link = canvas.toDataURL();
            //var image = document.getElementById("myCanvas").toDataURL("image/png");
            link = link.replace('data:image/png;base64,', '');
                      
                $.ajax({
                type: 'POST',
                url: '../Returns/Upload',
                data: '{ "imageData" : "' + link + '","AccountId":"' + strAcctID + '","Form":"' + strForm + '" }',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (msg) {
                    //alert('Image saved successfully !');
                }
            });
            
           

        }    








        function DisplayPrntCoupon() {       
            debugger;
            var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
           
           
            for (var i = 0; i < url.length; i++) {
                var urlparam = url[i].split('=');

                if (urlparam[0] == 'el_payc_ind') {
                    curInd = urlparam[1];
                    break;
                }
            }
         
            if (curInd == 1) {
                $('#btnNTL_print').css("display", "none");
                $('#btnSubmit_print').css("display", "none");
                //
                $('#tdSubmit').css("display", "block");
                $('#btnElec_payment').css("display", "block");
                $('#divElec_pay_amt').css("display", "block");
                $('#txtElec_pay_amt').css('text-align', 'right');

                $('#AppHeader').html('Make Electronic Payment');


                var dobj = parent.$g.getXmlDocObj();
                //parent.$g.loadXmls();

                var acct = localStorage.getItem("AccountNumber");
                debugger;
                var pin = localStorage.getItem("Pin");
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, "I", "ENTITY_INFO FUNCTION_CODE", '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, acct, "ENTITY_INFO ENTITY_ID", '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, pin, "ENTITY_INFO PIN", '', 0);
                ispCallXMLForm(parent.$g.xmlAccount, dobj, "AccountInfo");
                if (parent.$x.ispXmlGetFieldVal(dobj, 'ERROR_INFO MESSAGE', "", 0) == "") {

                    parent.$g.xmlAccount.loadXML(dobj.xml);

                    if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ACCOUNT_ID', '', 0) != "") {


                        var uName = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME', '', 0);
                        debugger;
                        if (uName.indexOf("*") >= 0) {
                            uName = uName.replace(/\*/g, " ");                           
                        }
                        localStorage.setItem("AccountName", uName);

                       // parent.fillUserAfterLogin(true, uName);
                    }
                }
              

            }
            else {
                $('#btnSubmit_print').css("display", "block");

                $('#btnElec_payment').css("display", "none");
                $('#divElec_pay_amt').css("display", "none");
                $('#tdSubmit').css("display", "none");
                $('#AppHeader').html('Payment Coupon');
            }
            parent.sNew = false;
            $('#LogPrntCoupon').css("display", "block");
           

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
           
            $(parent.$g.xmlPayCoupon).find("TAX_ACCT ACCOUNT_ID").each(function () {
                if ($(this).text() != null && $(this).text() != '' && $(this).text() == entid) {                  
                    account = $(this).parent().find("ACCOUNT").text();
                    count = count + 1;
                }


            });


          
            if (count == 1) {
                for (var i = 0; i < ddPCAcctType.options.length; i++) {
                  
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
           
           
            if ((curInd == '2' ||curInd == '') && parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, 'LOGIN_FROM NTL_ONLY', '', 0) == 'TRUE') { //Sudipta

                    SetDDList(ddPCAcctType, '', '1');
                    
                    if (ddPCAcctType.selectedIndex != '0') {
                        AppHeader.innerHTML = 'Select No Tax Liability Coupon';
                        LoadPCAccountID();                   
                     
                        $('#ddPCAcctType').prop('disabled', true);
                        ddPCAcctID.focus();
                    } else {
                        ddPCAcctType.selectedIndex = '0';
                    } 	//if
                } 	//if
         
        } 	//DisplayPrntCoupon

        function GetSingleNodeCount(oXML, sElement, val)//Chayan
        {
            var count = 0;
            $(oXML.xml).find(sElement).each(function () {

                count = count + 1;

            });
            return count;
        }




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
           
            $('#AppError').text("");
            var ddPCAcctType = document.getElementById('ddPCAcctType');
            if ($(ddPCAcctType.options[ddPCAcctType.selectedIndex]).text() == "Select") {
                $('#AppError').text("Select Account Type");
            }
            else if ($(ddPCAcctID.options[ddPCAcctID.selectedIndex]).text() == "Select") {
                $('#AppError').text("Select Account ID");
            }
                  
        }   //LoadPrntCouponError


        function ValidatePrntCoupon() {            
            LoadPrntCouponError();            

                        
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
            debugger;


            for (i = 0; i < icount; i++) {
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "TAX_ACCT ACCOUNT", "", i) == '84' && curInd=='2') {//Code changed by SumanG
                    //Do not load UO - Tenant (84)
                }
                else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "TAX_ACCT ACCOUNT", "", i) == '27' && (curInd == '2'||curInd=='')) {//Code changed by SumanG
                    //Do not load Tobacco (27)
                }
                else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "TAX_ACCT ACCOUNT", "", i) == lastUniqueCode) {
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
            debugger;
            $('#AppError').text('');
            $('#AppError_Payment').text("");
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
          
            if (strSelectType == '1' && curInd!= '1' ) { //Sudipta               
                $('#btnNTL_print').css("display", "block");
                $('#trNtlMessage').css("display", "block");
                $('#trNtlMessage').css("visiblity", "visible");
                $('#trNtlMessage td').css("width", "100%");               
                $('#tdPaNTL').css("display", "block");
                $('#tdPaNTL').removeAttr("style");
                $('#trNtlMessage').removeAttr("style");
            } else {               
                $('#btnNTL_print').css("display", "none");
                $('#trNtlMessage').css("display", "none");               
                $('#tdPaNTL').css("display", "none");
            } 	//if
        }   //loadPCAccountID

        function LoadPCTaxYear() {
            debugger;
            var icount = 100;
            var strInnerText = 'DESC';
            var iTaxYear;
            var iStartYear;
            var iEndYear;

            //ValidatePrntCoupon();


            $('#ddPCTaxYear').html('');
            $('#ddPCTaxPeriod').html('');


            ddPCTaxYear.options.length = icount;
           
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
        
            for (i = 0; i < icount; i++) {

                $(ddPCTaxYear.options[i]).text(iTaxYear);
                $(ddPCTaxYear.options[i]).attr("CODE", iTaxYear);
                iTaxYear = iTaxYear - 1
                if (iTaxYear < iStartYear) {
                    ddPCTaxYear.options.length = i + 1;
                    break
                } //if		
            }  //for
            //$('select[name^="ddPCTaxYear"]').eq(1).focus();
            if ($('select option[code="2014"]') != [] && $(ddPCAcctType.options[ddPCAcctType.selectedIndex]).text() == "Business Income and Receipts Tax") {
                $('select option[code="2014"]').prop('selected', true);
            }
            else if ($('select option[code="2014"]') != [] && $(ddPCAcctType.options[ddPCAcctType.selectedIndex]).text() == "Net Profits Tax") {
                $('select option[code="2014"]').prop('selected', true);
            }
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
            debugger;
           
            ($("#ddPCTaxYear option[code='2010']").length > 0)
            {
                $("#ddPCTaxYear option[code='2010']").remove();
            }
            ($("#ddPCTaxYear option[code='2011']").length > 0)
            {
                $("#ddPCTaxYear option[code='2011']").remove();
            }
            ($("#ddPCTaxYear option[code='2009']").length > 0)
            {
                $("#ddPCTaxYear option[code='2009']").remove();
            }
            ($("#ddPCTaxYear option[code='2008']").length > 0)
            {
                $("#ddPCTaxYear option[code='2008']").remove();
            }
            ($("#ddPCTaxYear option[code='2007']").length > 0)
            {
                $("#ddPCTaxYear option[code='2007']").remove();
            }
            ($("#ddPCTaxYear option[code='2006']").length > 0)
            {
                $("#ddPCTaxYear option[code='2006']").remove();
            }
            ($("#ddPCTaxYear option[code='2005']").length > 0)
            {
                $("#ddPCTaxYear option[code='2005']").remove();
            }
            ($("#ddPCTaxYear option[code='2004']").length > 0)
            {
                $("#ddPCTaxYear option[code='2004']").remove();
            }
            ($("#ddPCTaxYear option[code='2003']").length > 0)
            {
                $("#ddPCTaxYear option[code='2003']").remove();
            }
            ($("#ddPCTaxYear option[code='2002']").length > 0)
            {
                $("#ddPCTaxYear option[code='2002']").remove();
            }
            ($("#ddPCTaxYear option[code='2001']").length > 0)
            {
                $("#ddPCTaxYear option[code='2001']").remove();
            }
            ($("#ddPCTaxYear option[code='2000']").length > 0)
            {
                $("#ddPCTaxYear option[code='2000']").remove();
            }
        }   //LoadPCTaxYear

        function LoadTaxPeriods() {
            ifreq = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "TAX_ACCT FREQUENCY_CODE", "", iSelectIdx);

            //ValidatePrntCoupon();

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
                    if (strSelectType == '24' && parseInt(strTaxYear) > 2013) {
                        //EHD - 01122009 - Task EHD100 - Remove estimate from the BPT tax 
                        ddPCTaxPeriod.options.length = 2	//2                       
                        $(ddPCTaxPeriod.options[0]).text('December 31');
                        $(ddPCTaxPeriod.options[0]).attr("CODE", '12');
                        $(ddPCTaxPeriod.options[1]).text('Extension');
                        $(ddPCTaxPeriod.options[1]).attr("CODE", '13');
                    } //if
                    if (strSelectType == '3' && parseInt(strTaxYear) > 2013) {
                        if (parseInt(strTaxYear) == 2014) {
                            ddPCTaxPeriod.options.length = 2
                            $(ddPCTaxPeriod.options[0]).text('December 31');
                            $(ddPCTaxPeriod.options[0]).attr("CODE", '12');
                            $(ddPCTaxPeriod.options[1]).text('Extension');
                            $(ddPCTaxPeriod.options[1]).attr("CODE", '13');
                        } else if (parseInt(strTaxYear) > 2016) {
                            ddPCTaxPeriod.options.length = 2
                            if (parseInt(strTaxYear) == 2017) {
                                $(ddPCTaxPeriod.options[0]).text('1st Estimate');	
                                $(ddPCTaxPeriod.options[0]).attr("CODE", '01');
                            }		//if
                            $(ddPCTaxPeriod.options[1]).text('2nd Estimate');		
                            $(ddPCTaxPeriod.options[1]).attr("CODE", '02');
                        }
                        else {
                            ddPCTaxPeriod.options.length = 2	                      
                            $(ddPCTaxPeriod.options[0]).text('December 31');
                            $(ddPCTaxPeriod.options[0]).attr("CODE", '12');
                            $(ddPCTaxPeriod.options[1]).text('Extension');
                            $(ddPCTaxPeriod.options[1]).attr("CODE", '13');
                        }
                    }
                    
                    if (ddPCTaxPeriod.options.length == 0) {
                        ddPCTaxPeriod.options.length = 1;
                        $(ddPCTaxPeriod.options[0]).text('December 31');
                        $(ddPCTaxPeriod.options[0]).attr("CODE", '12');
                        btnPrint.focus();
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
                        //$(ddPCTaxPeriod.options[0]).text('March 31');
                        $(ddPCTaxPeriod.options[0]).text('March 30');
                        $(ddPCTaxPeriod.options[0]).attr("CODE", "92");
                        $(ddPCTaxPeriod.options[1]).text('June 30');
                        $(ddPCTaxPeriod.options[1]).attr("CODE", "93");
                        $(ddPCTaxPeriod.options[2]).text('September 30');
                        $(ddPCTaxPeriod.options[2]).attr("CODE", "94");
                       
                        $(ddPCTaxPeriod.options[3]).text('December 31');
                        $(ddPCTaxPeriod.options[3]).attr("CODE", "95");
                        $(ddPCTaxPeriod.options[4]).text('Reconcile');
                        $(ddPCTaxPeriod.options[4]).attr("CODE", "96");
                    } //if
                    if (strSelectType == '2') {
                        ddPCTaxPeriod.options.length = 5;
                        //$(ddPCTaxPeriod.options[0]).text('March 31');
                        $(ddPCTaxPeriod.options[0]).text('March 30');
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
                        //$(ddPCTaxPeriod.options[0]).text('March 31');
                        $(ddPCTaxPeriod.options[0]).text('March 30');
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
                    //if (isLeap) {
                    //    $(ddPCTaxPeriod.options[1]).text('February 29');
                    //} else {
                        $(ddPCTaxPeriod.options[1]).text('February 28');
                    //} 	//if
                    $(ddPCTaxPeriod.options[1]).attr("CODE", "2");
                    //$(ddPCTaxPeriod.options[2]).text('March 31');
                    $(ddPCTaxPeriod.options[2]).text('March 30');
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
                    //if (isLeap) {
                    //    $(ddPCTaxPeriod.options[3]).text('February 29');
                    //} else {

                        $(ddPCTaxPeriod.options[3]).text('February 28');
                    //} 	//if
                    $(ddPCTaxPeriod.options[3]).attr("CODE", "57");
                    $(ddPCTaxPeriod.options[4]).text('March 15');
                    $(ddPCTaxPeriod.options[4]).attr("CODE", "58");
                    //$(ddPCTaxPeriod.options[5]).text('March 31');
                    $(ddPCTaxPeriod.options[5]).text('March 30');
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
                  
                    $(ddPCTaxPeriod.options[23]).text('December 31');
                    $(ddPCTaxPeriod.options[23]).attr("CODE", "77");
                   
                    $(ddPCTaxPeriod.options[24]).text('Reconcile');
                    $(ddPCTaxPeriod.options[24]).attr("CODE", "78");
                    break
                case 'W':
                    var DayToBeDisplayed = 6; //1 = Monday
                    var i = 0;
                    var j = 0;
                  
                    var WagDate = new Date(strTaxYear, 0, 1);

                    var DayCalc = WagDate.getDay();
                    DayCalc = WagDate.getDate() + (-1 * (DayCalc - DayToBeDisplayed));
                    var WagDate = new Date(WagDate.getFullYear(), WagDate.getMonth(), DayCalc);

                    ddPCTaxPeriod.options.length = 0;
                   
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
            //generate();

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
                strScanLine = '333' + strSelectType + HoldDate + '00' + '00000' + strScanID + '000000000000000000'
				+ strPayPeriod + twoyear + '0000000000000000'
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
            debugger;
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
            } 	//if

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, $(ddPCAcctID.options[ddPCAcctID.selectedIndex]).text(), "WAGE_NTL ACCOUNT_ID", "");
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, lsPeriod, "WAGE_NTL PERIOD", "");
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, ifreq, "WAGE_NTL FREQUENCY_CODE", "");
            
            parent.setFrameUrl('PayCoupon/NTL_Initial')
        } 	//NTLPrntCoupon

        function CnclPrntCoupon() {
            debugger;
            if ((curInd == '2' || curInd == '') && parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, 'LOGIN_FROM NTL_ONLY', '', 0) == 'TRUE') {
                $('#AppError').text("");
                parent.bLoadCoupon = false;
                parent.NTL = true;
                
                parent.setFrameUrl('Login/MainAsp');
            }
            else {
                parent.Cancelform = true;
                $('#AppError').text("");
                parent.setFrameUrl('Login/MainAsp');
            }

        }  // CnclPrntCoupon

        function SubmitPrntCoupon() {

            //if (ddPCAcctType.selectedIndex < 0) {
            //    ddPCAcctType.selectedIndex = 0;
            //} // if

            //if (ddPCAcctID.selectedIndex < 0) {
            //    ddPCAcctID.options.length = 1;
            //    $(ddPCAcctID.options[0]).text('');
            //    ddPCAcctID.selectedIndex = 0;
            //} // if

            ValidatePrntCoupon();
            if ($('#AppError').text() != '') {
                return;
            }

            SetupPassFields();

            AdjustNameDisplay();
            debugger;

            var strAcctType = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_ACCOUNT_TYPE", "");
           
            var strAccountAddr = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_ADDR", "");
            var strAccountAddr2 = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_ADDR2", "");
            var strAccountAddr3 = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_ADDR3", "");
            var strAccountCity = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_CITY", "");
            var strAccountState = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_STATE", "");
            var strAccountZip = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_ZIP_CODE", "");
            switch (strSelectType) {
                case "01":		//'"WAG"
                    PopulateAccount("Wage", "204");
                    break;
                case "02":		//'"ERN"
                    PopulateAccount("Earnings","201");
                    break;
                case "03":		//'"NPT"
                    PopulateAccount("Net Profits","203");
                    break;
                case "06":		//'"AMU"
                    PopulateAccount("Amusement", "205");
                    break;
                case "08":		//'"PRK"
                    PopulateAccount("Parking", "206");
                    break;
                case "09":		//'"COI"
                    PopulateAccount("Coin Operated","2099");
                    break;
                case "11":		//'"POL"
                    PopulateAccount("Police","2099");
                    break;
                case "14":		//'"VRT"
                    PopulateAccount("Vehicle Rental","208");
                    break;
                case "18":		//'"RTT"
                    PopulateAccount("Realty Transfer", "2099");
                    break;
                case "23":		//'"HOT"
                    PopulateAccount("Hotel","211");
                    break;
                case "24":		//'"BPT"
                    PopulateAccount("Business Income and Receipts","202");
                    break;
                case "27":		//'"TOB"
                    PopulateAccount("Tobacco", "2099");
                    break;
                case "28":		//'"LIQ"
                    PopulateAccount("Liquor","212");
                    break;
                case "29":		//'"SIT"
                    PopulateAccount("School Income Tax","210");
                    break;
                case "58":		//'"VPT"
                    PopulateAccount("Valet Parking","207");
                    break;
                case "60":		//'"REA"
                    PopulateAccount("Real Estate", "213");
                    break;
                case "76":		//'"OAT"
                    PopulateAccount("Outdoor Advertizing","209");
                    break;
                case "84":		//'"UOL"
                    PopulateAccount("U&O - Landlord","2099");
                    break;
                case "85":		//'"UOL"
                    PopulateAccount("U&O - Tenant","2099");
                    break;
                case "90":		//'"ASM"
                    PopulateAccount("Assessment Screen", "2099");
                    break;
                case "91":		//'"GNP"
                    PopulateAccount("Police BRI", "2099");
                    break;
                case "97":		//'"GEN"
                    PopulateAccount("Entity Level Charges", "2099");
                    break;
                case "98":		//'"GN2"
                    PopulateAccount("General", "2099");
                    break;
                case "99":		//'"GN3"
                    PopulateAccount("Entity Level Charges","2099");
                    break;

                default:
                    break;
            }
            
            generate(strFormId + strScanLine);
                        
            var tempParameters = 'a=' + strAcctID + '&b=' + strAccountName + '&c=' + strCouponAddr + '&d=' +strScanLine + '&e=' + strPeriod + '&f=' + strSelectType + '&h=' + '../Uploads/' + strForm + "_" + strAcctID + '.png' + '&i=' + 'T' + '&g=' + strAccountAddr + '|' + strAccountAddr2 + '|' + strAccountAddr3 + '|' + strAccountCity + '|' + strAccountState + '|' + strAccountZip;
            tempParameters = tempParameters.replace(/#/g, '~LBSIGN~');
            
           
            if (navigator.userAgent.indexOf("Firefox") > 0) {
                parent.setFrameUrl('PayCoupon/PDFCouponCreate_Firefox?y=' + tempParameters);
            }
            else {
                parent.setFrameUrl('PayCoupon/PDFCouponCreate?y=' + tempParameters);
            }
            return;

            parent.DocWin.location.href = 'CouponImageAsp?' + tempParameters; 	//a=' + strAcctID + '&b=' + strAccountName + '&c=' + strCouponAddr + '&d=' + strScanLine + '&e=' + strPeriod + '&f' + strAcctType + ''

        } 	//SubmitPrntCoupon

        function PopulateAccount(formname,id) {
            strForm = formname;
            strFormId = id;
        }

        //EGOVWEB-61
        function DisplayNTLbutton() {            
            //btnPaNTL.disabled = false;
            if ($(ddPCTaxPeriod.options[ddPCTaxPeriod.selectedIndex]).text().toUpperCase() == 'RECONCILE' && $(ddPCAcctType.options[ddPCAcctType.selectedIndex]).text().toUpperCase() == 'WAGE TAX') {
                $('#btnNTL_print').css("display", "none");
                $('#trNtlMessage').css("display", "none");
                $('#tdPaNTL').css("display", "none");
            } 	//if
            else if ($(ddPCTaxPeriod.options[ddPCTaxPeriod.selectedIndex]).text().toUpperCase() != 'RECONCILE' && $(ddPCAcctType.options[ddPCAcctType.selectedIndex]).text().toUpperCase() == 'WAGE TAX') {
                $('#btnNTL_print').css("display", "block");
                $('#trNtlMessage').css("display", "block");
                $('#trNtlMessage').css("visiblity", "visible");
                $('#trNtlMessage td').css("width", "100%");
                $('#tdPaNTL').css("display", "block");
                $('#tdPaNTL').removeAttr("style");
                $('#trNtlMessage').removeAttr("style");
            }
        } 	//DisplayNTLbutton

        function DoPayment() {
            ValidateCoupPIN();
            var sPaymentAmount;
           
            sPaymentAmount = $("#txtElec_pay_amt").val();

           
                	//if
            //$('#txtPaymentAmount').attr('class', 'inpNormal');
            DoCreditCardCall();
        } 	//DoPaymen

      

        function DoCreditCardCall() {
            //
            if ($('#AppError_Payment').text() != "") {
                return;
            }

            var sAmount;
            var sToday, sMonth, sDate;
            sToday = new Date();
            sMonth = sToday.getMonth() + 1;
            sDate = sToday.getDate();

            if (sMonth <= 9) {
                sMonth = '0' + sMonth;
            } //if

            if (sDate <= 9) {
                sDate = '0' + sDate;
            } //if


            var sAcctNumberCode = $(ddPCAcctID.options[ddPCAcctID.selectedIndex]).attr("CODE")
            var sAcctTypeCode = $(ddPCAcctType.options[ddPCAcctType.selectedIndex]).attr("CODE")
            var sAcctPeriodCode = $(ddPCTaxPeriod.options[ddPCTaxPeriod.selectedIndex]).attr("CODE")
            var sAcctYearCode = $(ddPCTaxYear.options[ddPCTaxYear.selectedIndex]).attr("CODE")
            //
           
            var sAddress1 = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "ENTITY_INFO ADDRESS1", "");
            
            
            var sAddress2 = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, 'ENTITY_INFO ADDRESS2', '', 0)
            var sAddress3 = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, 'ENTITY_INFO ADDRESS3', '', 0)
            if (sAddress2 !== '') {
                sAddress1 = sAddress1 + ', ' + sAddress2
            }
            if (sAddress3 !== '') {
                sAddress1 = sAddress1 + ', ' + sAddress3
            }
           
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sAcctNumberCode, 'AccountNumber', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sAcctNumberCode, 'BillNumber', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '', 'StatementNumber', '', 0);

            

            var aPeriodDateParts;
            var sPeriodMonth;
            var sPeriodDate;
          
            if (ifreq == 'W') {
                aPeriodDateParts = $(ddPCTaxPeriod.options[ddPCTaxPeriod.selectedIndex]).text().split('/');
                sPeriodMonth = aPeriodDateParts[0].length == 1 ? '0' + aPeriodDateParts[0] : aPeriodDateParts[0];
                sPeriodDate = aPeriodDateParts[1].length == 1 ? '0' + aPeriodDateParts[1] : aPeriodDateParts[1];               
            } else {
                var arrMonthValues = new Array();
                arrMonthValues['January'] = '01';
                arrMonthValues['February'] = '02';
                arrMonthValues['March'] = '03';
                arrMonthValues['April'] = '04';
                arrMonthValues['May'] = '05';
                arrMonthValues['June'] = '06';
                arrMonthValues['July'] = '07';
                arrMonthValues['August'] = '08';
                arrMonthValues['September'] = '09';
                arrMonthValues['October'] = '10';
                arrMonthValues['November'] = '11';
                arrMonthValues['December'] = '12';

                sTaxPeriodText = $(ddPCTaxPeriod.options[ddPCTaxPeriod.selectedIndex]).text();
                sTaxPeriodText = sTaxPeriodText.replace('1st Estimated - ', '');
                sTaxPeriodText = sTaxPeriodText.replace('2nd Estimated - ', '');
                sTaxPeriodText = sTaxPeriodText.replace('Extension - ', '');
                sTaxPeriodText = sTaxPeriodText.replace('Reconcile', 'December 31');
                if (sTaxPeriodText.indexOf(' to June 30 ') > -1) {
                    sTaxPeriodText = 'June 30';
                    strTaxYear = parseInt(strTaxYear) + 1;
                } 	//if

                aPeriodDateParts = sTaxPeriodText.split(' ');
                sPeriodMonth = arrMonthValues[aPeriodDateParts[0]];
                sPeriodDate = aPeriodDateParts[1].length == 1 ? '0' + aPeriodDateParts[1] : aPeriodDateParts[1];
               
            }
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, strTaxYear + '-' + sPeriodMonth + '-' + sPeriodDate, 'BillingDate', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, strTaxYear + '-' + sPeriodMonth + '-' + sPeriodDate, 'DueDate', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '123', 'DepartMentId', '', 0);	//DOR
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sToday.getFullYear() + '-' + sMonth + '-' + sDate, 'PaymentDate', '', 0);
           

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '<![CDATA[' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, 'ENTITY_INFO NAME', '', 0) + ']]>', 'Customers Customer FirstName', '', 0)
           
           
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sAddress1, 'Customers Customer BillingAddress Address AddressLine1', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, 'ENTITY_INFO CITY', '', 0), 'Customers Customer BillingAddress Address City', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, 'ENTITY_INFO STATE', '', 0), 'Customers Customer BillingAddress Address State', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, 'ENTITY_INFO ZIP_CODE', '', 0), 'Customers Customer BillingAddress Address PostalCode', '', 0);

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '', 'Customers Customer PhoneNumber', '', 0)           
            debugger;
            var arrEpayValues = new Array();
            //'<%= COPSession.CC_Wage_ePay_ID %>'
            arrEpayValues['1'] = '<%= COPSession.CC_Wage_ePay_ID %>';
            arrEpayValues['3'] = '<%= COPSession.CC_NPT_ePay_ID %>';
            arrEpayValues['24'] = '<%= COPSession.CC_BPT_ePay_ID %>';
            arrEpayValues['27'] = '<%= COPSession.CC_TOBACCO_ePay_ID %>';
            arrEpayValues['29'] = '<%= COPSession.CC_School_ePay_ID %>';
            arrEpayValues['84'] = '<%= COPSession.CC_UO_ePay_ID %>';

            arrEpayValues['23'] = '<%= COPSession.CC_Hotel_ePay_ID %>';//Added by SumanG for Hotel tax type
            arrEpayValues['2'] = '<%= COPSession.CC_Earnings_ePay_ID %>'; //Added by SumanG for Earnings tax type
            arrEpayValues['6'] = '<%= COPSession.CC_Amusement_ePay_ID %>'; //Added by SumanG for Amusement tax type
            arrEpayValues['8'] = '<%= COPSession.CC_Parking_ePay_ID %>'; //Added by SumanG for Parking tax type
            arrEpayValues['14'] = '<%= COPSession.CC_Rental_ePay_ID %>'; //Added by SumanG for Vehical Rental tax type
            arrEpayValues['28'] = '<%= COPSession.CC_Liquor_ePay_ID %>'; //Added by SumanG for Liquor tax type
            arrEpayValues['58'] = '<%= COPSession.CC_Valet_ePay_ID %>'; //Added by SumanG for Valet Parking tax type
            arrEpayValues['76'] = '<%= COPSession.CC_Outdoor_ePay_ID %>';//Added by SumanG for Outdoor Advertising tax type 

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, arrEpayValues[sAcctTypeCode], 'ApplicationID', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, strSelectType.length == 1 ? '0' + strSelectType : strSelectType, 'OtherAttributes Attribute Value', '', 0) //TaxType
            var sPeriodCode = $(ddPCTaxPeriod.options[ddPCTaxPeriod.selectedIndex]).attr("CODE")
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sPeriodCode.length == 1 ? '0' + sPeriodCode : sPeriodCode, 'OtherAttributes Attribute Value', '', 1)	//TaxPeriod
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, $(ddPCTaxYear.options[ddPCTaxYear.selectedIndex]).attr("CODE").substr(2, 2), 'OtherAttributes Attribute Value', '', 2)	//TaxYear

                     
            var sAmount = $("#txtElec_pay_amt").val();
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sAmount, 'ItemAmount', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sAmount, 'TotalDue', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sAmount, 'TotalAmountdue', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '<![CDATA[' + GetCreditCardDescription(strSelectType) + ']]>', 'Details BillingStatementDetail ItemDescription', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sAmount, 'Details BillingStatementDetail Charges', '', 0)

          
            var encodeCCXML = parent.$g.xmlCC.toString();
            var ReqXML = encodeCCXML;
            encodeCCXML = encodeCCXML.replace(/</g, '&lt;')
            encodeCCXML = encodeCCXML.replace(/>/g, '&gt;')
            encodeCCXML = encodeCCXML.replace(/"/g, '&quot;')
            encodeCCXML = encodeCCXML.replace(/\t/g, '')
            encodeCCXML = encodeCCXML.replace(/\r\n/g, '')
            debugger;
            
            $.ajax({
                type: 'POST',
                url: '../Returns/Log',
                data: '{ "OriginationFom" : "ElectronicPayment","ServiceName" : "RTTIE016","RequestXML" : "' + btoa(ReqXML) + '"}',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (msg) {

                }
            });
           
            if (parent.gEnvironment == 'U') {
                clipboardData.setData('Text', xmlCC.xml);
            }		//if

          
          frmePay.action = '<%= COPSession.CC_SiteName %>';
          frmePay.BillStmt.value = encodeCCXML;
		  frmePay.submit();
		  
          

        } 	//DoCreditCardCall

        function GetCreditCardDescription(sTaxType) {
            var sDescription = '';
            var sTaxYear = strTaxYear			//(ddPCTaxYear.options[ddPCTaxYear.selectedIndex]).attr("CODE");
            var sTaxType = $(ddPCAcctType.options[ddPCAcctType.selectedIndex]).text() + ' for ';
            if (strSelectType == '1') {
                sDescription = sTaxType + sTaxYear;
            } else {
                sDescription = sTaxType + sTaxYear;
            } 	//if

            return sDescription
        } 	//GetCreditCardDescription

        function LoadPymtError() {
            //var i = 0;
            $('#AppError_Payment').text("");
            var txtElec_pay_amt = document.getElementById('txtElec_pay_amt');
            if ($("#ddPCAcctType :selected").text() == "Select") {
                $('#AppError_Payment').text("Select Account Type");
            }
            else if ($('#txtElec_pay_amt').val() == "") {
                $('#AppError_Payment').text("'Enter Payment Amount");
            }
            //arrCoupPINErr[i++] = [ddPCAcctType, '$("#ddPCAcctType :selected").text()=="Select"', 'Select Account Type'];
            //arrCoupPINErr[i++] = [txtElec_pay_amt, '$(\'#txtElec_pay_amt\').val() == ""', 'Enter Payment Amount'];
        }

        function ValidateCoupPIN() {
            LoadPymtError();
            debugger;
            //var pinerror = ispSetInputErr(arrCoupPINErr);
           
            //$('#AppError_Payment').text(pinerror);
            
            resolvedIframeheight();
            parent.ScrollTop(1);
        } 	//ValidateCoupPIN 

        function resolvedIframeheight() {
            //iframe height issue resolved
            var iframe = window.parent.document.getElementById('ifrmDocwin');
            var container = $('#tab1').css("height");
            iframe.style.height = container;
        }
    </script>
</head>
<body onload="DisplayPrntCoupon()">
    <div class="container-fluid no-padding">
        <div class="block3">

            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12 col-md-12">
                        <div style="display: block;" id="tab2" class="blue_base_box">
                            <h2><span id="AppHeader">&nbsp;</span>  </h2>
                            <div class="inner_white-panel">
                                <div class="row">
                                   <div class="col-lg-12 ">
                                       <div id="AppError" class="errormsg no-padding"  style="display:block;"></div>
                                       <div id="Div1" class=""  style="display:block;font-family:'Conv_OCRAStd',Sans-Serif"></div>
                                     
                                 <div id="AppError_Payment" class="errormsg no-padding"  style="display:block;"></div>
                                       </div></div>
                                <div class="contentsection" style="display: block;" id="LogPrntCoupon">

                                    <div class="clearfix"></div>
                                    <br>
                                    <div class="row">


                                        <div class="login_form">


                                            <div class="form_segment">

                                                <label>Account Type:<span  style="color:red"> *</span> </label>
                                                

                                                <div class="here_input">
                                                    <select id="ddPCAcctType" style="width: 253px" name="ddPCAcctType"
                                                        onchange="LoadPCAccountID()" datafld="" class="form-control input-sm">
                                                        <option selected></option>
                                                    </select>
                                                    <div class="clear"></div>
                                                </div>

                                                <div class="clear"></div>

                                            </div>


                                            <div class="form_segment">

                                                <label>Account ID:<span  style="color:red"> *</span> </label>

                                                <div class="here_input">

                                                    <select id="ddPCAcctID"
                                                        style="width: 253px" name="ddPCAcctID" onchange="LoadPCTaxYear()" class="form-control input-sm">
                                                        <option
                                                            selected></option>
                                                    </select>
                                                    <div class="clear"></div>
                                                </div>



                                                <div class="clear"></div>

                                            </div>
                                            <div class="form_segment">

                                                <label>Tax Year:<span  style="color:red"> *</span> </label>

                                                <div class="here_input">

                                                    <select id="ddPCTaxYear"
                                                        style="width: 95px" name="ddPCTaxYear" onchange="LoadTaxPeriods()" class="form-control input-sm">
                                                        <option
                                                            selected></option>
                                                    </select>
                                                    <div class="clear"></div>
                                                </div>



                                                <div class="clear"></div>

                                            </div>
                                            <div class="form_segment">

                                                <label>Period:<span  style="color:red"> *</span> </label>

                                                <div class="here_input">

                                                    <select id="ddPCTaxPeriod"
                                                        style="width: 253px" name="ddPCTaxPeriod" onchange="DisplayNTLbutton()" class="form-control input-sm">
                                                        <option selected></option>
                                                    </select>
                                                    <div class="clear"></div>
                                                </div>
                                                </div>
                                             <div class="clear"></div>
                                                <div id ="divElec_pay_amt" class="form_segment" style="display:none">

                                                <label style="width:44%;">Electronic Payment Amount:<span  style="color:red"> *</span> </label>

                                                <div class="here_input">

                                                   <INPUT type="text" id="txtElec_pay_amt" class="form-control input-sm pull-left" value="0"  />
                                                 
                                                    <div class="clear"></div>
                                                </div>
                                                   


                                                <div class="clear"></div>

                                            </div>
                                            <div class="form_segment">



                                                <div class="here_input">

                                                    <select id="ddAccountAddr"
                                                        style="visibility: hidden">
                                                        <option selected></option>
                                                    </select>
                                                    <div class="clear"></div>
                                                </div>



                                                <div class="clear"></div>

                                            </div>
                                            <div class="text-center" id="trNtlMessage" style="display: none; visibility: visible">
                                                <p>
                                                    If you have no tax liability for the selected period, click the NTL Coupon Button
				to Process a NTL payment.
                                                </p>
                                                <p>&nbsp;</p>
                                            </div>
                                            <div class="col-md-12">
                                            <div class="center-block text-center centered" style="margin-left:240px;">

                                                 <input class="btn btn-default submit_button" id="btnNTL_print" style="width:170px; float:left;display:none" onclick="NTLPrntCoupon()" type="button" value="NTL Coupon"
                                                            name="btnPaNTL">
                                                 <input class="btn btn-default submit_button" id="btnSubmit_print" style="width:190px; float:left;display:none" onclick="SubmitPrntCoupon()" type="button" value="Create Coupon"
                                                            name="btnPaPrint">
                                                 <input class="btn btn-default submit_button" id="btnElec_payment" style="width:170px; float:left;display:none" onclick="DoPayment()" type="button" value="Make Payment"
                                                            name="Elec_payment">
                                                <input class="btn btn-default submit_button" id="btnCncl_print" style="width:128px; float:left;" onclick="CnclPrntCoupon()" type="button" value="Cancel"
                                                            name="btnPaCncl">
                                            </div>
                                                </div>

                                          


                                            <div class="clear"></div>
                                        </div>
                                    </div>
                                </div>
                               
                            </div>


                        </div>

                    </div>

                </div>
            </div>
        </div>
     
        <form id='frmePay' method="post" target="_blank" style="display:none">
<input type="hidden" name='BillStmt' />
  
   
 <h5>Credit Card / e-Check</h5>


<p>You can pay by American Express, Discover, MasterCard, VISA or eCheck. <label id="ccFeeText1">A 2.49% user fee will be added to the amount due when paying by credit card or a flat fee of $1.50 when paying by E-Check up to $100,000.</label></p>
            <div class="clear"></div>
       <p class="text-center card-padding-top"> <a id="btnCreditCard" style="cursor:pointer;" name="btnCreditCard" onclick="DoCreditCard()" class="btn btn-default submit_button_light">Pay by Credit Card or e Check  (e Pay) </a>
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
