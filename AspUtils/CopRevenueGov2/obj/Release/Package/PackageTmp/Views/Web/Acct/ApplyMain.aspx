<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>



<html>
<head>

<link type="text/css" rel="Stylesheet" href="../Content/Styles/Font.css" />
<link type="text/css" rel="Stylesheet" href="../Content/Styles/Object.css" />
<script type="text/javascript" language="javascript" src="../Content/Scripts/JqueryMin.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/ispXmlProc.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/ispFunctions.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/Accounting.js"></script>  


<script id="clientEventHandlersJS" language="javascript" type="text/javascript">

    //EHD - 20100609 - EGOVWEB-28

    var oAcctInfo = parent.MenuWin.getXmlDocObj();
    var oEmail = parent.MenuWin.getXmlDocObj();

    var txtHeader = 'Taxpayer Information';
    var CurrentDiv = 'divTax01';
    var lbProfileChanged = false;
    var lbAcctChanged = false;
    var lbAddressesChanged = false;
    var lbPartnerChanged = false, lbECheckChanged = false, CurrentLayer;
    var mToday = '<%= DateTime.Now.Date.ToString("m/d/y") %>';
    var mTime = '<%= DateTime.Now.Date.ToString("h:m") %>';
    //EGOVWEB-28 Changed sMailingAdd
    var sMailingAdd = -1; 	//false

    function isLoaded() {
        if (parent.MenuWin.document.readyState != 'complete' &&
			parent.HeaderWin.document.readyState != 'complete' &&
			parent.DocWin.document.readyState != 'complete' &&
			parent.NavWin.document.readyState != 'complete') {
            setTimeout('isLoaded()', 100);
        } 	//if
    } 	//isLoaded

    function window_onload() {
        loadXmlFiles();
        setTimeout('isLoaded()', 100);
        InitNavButtons();
        ClearXmlFunctionVals();
        ShowForm('AcctProfile');
    } 	//window_onload


    function loadXmlFiles() {
        parent.MenuWin.loadXmlAsync('../xml/email', load_oEmail);
        parent.MenuWin.loadXmlAsync('../xml/AcctTemplate', load_oAcctInfo);

    }

    function load_oAcctInfo(xml) {
        oAcctInfo.xml = xml;
    }

    function load_oEmail(xml) {
        oEmail.xml = xml;
    }

    function sendDemoMail() {
        alert('email xml content : ' + XMLToString(parent.MenuWin.xmlEmail));
        ispXmlSetFieldVal(parent.MenuWin.xmlEmail, 'NEWREG', 'FUNCTION', '', 0);
        ispXmlSetFieldVal(parent.MenuWin.xmlEmail, 'Hello sUMAN this is a mail test demo', 'DATA', '', 0);
        ispXmlSetFieldVal(parent.MenuWin.xmlEmail, 'sknath25@gmail.com', 'ADDRESS', '', 0);
        alert('DEmo mail content : ' + XMLToString(parent.MenuWin.xmlEmail));
        ispCallXMLForm(oEmail, oEmail, '../MailPIN', '');
    }

    function ClearXmlFunctionVals() {
        var i;

        for (i = 0; i < ispXmlGetRecCount(parent.MenuWin.xmlAccount, "FUNCTION_CODE", "n") ; i++) {
            ispXmlSetFieldVal(parent.MenuWin.xmlAccount, "", "FUNCTION_CODE", "", i);
        } 	//for
    } 	//ClearXmlFunctionVals

    function ShowForm(id) {
        $('#AppError').text('');
        var is_disabled = $(this.parent.NavWin.document).find('#tblNavMenu').first().is(':disabled');
        //var obj = parent.NavWin.document.getElementById('tblNavMenu');
        if (is_disabled == true) {
            return;
        } 	//if

        $('#AcctProfile').css('display', 'none');
        $('#divAcctTaxes').css('display', 'none');
        $('#AcctAddresses').css('display', 'none');
        $('#AcctPartners').css('display', 'none');
        $('#AcctECheck').css('display', 'none');
        $('#AcctThankYou').css('display', 'none');
        $('#AcctExistThankYou').css('display', 'none');
        //var menu_acctprof =  $(parent.MenuWin.document).find('#mnuAcctProfile').first();
        var menu_acctprof = parent.MenuWin.document.getElementById('mnuAcctProfile');

        parent.MenuWin.ispMenu_onclick(menu_acctprof);

        //parent.MenuWin.ispMenu_onclick(parent.MenuWin.mnuAcctProfile);

        if (id == 'AcctProfile') {
            DisplayProfile();
            SetNavButtons();
        }
        else if (id == 'AcctTaxes') {
            DisplayTaxes();
            SetNavButtons();
        }
        else if (id == 'AcctAddresses') {
            DisplayAddresses();
            SetNavButtons();
        }
        else if (id == 'AcctPartners') {
            DisplayPartners();
            SetNavButtons();
        }
        else if (id == 'AcctECheck') {
            DisplayECheck();
            SetNavButtons();
        }
        else if (id == 'AcctThankYou') {
            parent.NavWin.ClearImages();
            DisplayThankYou();
        } 		//if
    } 	//ShowForm

    function SetNavButtons() {
        var lError = false;

        if (CurrentLayer == '') {
            return;
        } 	//if

        if (lbProfileChanged == true) {
            //parent.NavWin.document.imgProfile.src = '../Images/profile_done.gif';
            $(parent.NavWin.document).find('#imgProfile').first().attr('src', '../Content/Images/profile_done.gif');
            $(parent.NavWin.document).find('#imgProfile').first().attr('title', '');
        } 	//if
        if (lbAcctChanged == true) {
            //parent.NavWin.document.imgAccount.src = '../Images/taxtype_done.gif';
            //parent.NavWin.document.imgAccount.title = '';
            $(parent.NavWin.document).find('#imgAccount').first().attr('src', '../Content/Images/taxtype_done.gif');
            $(parent.NavWin.document).find('#imgAccount').first().attr('title', '');
        } 	//if
        if (lbECheckChanged == true) {
            //parent.NavWin.document.imgECheck.src = '../Images/e-check_done.gif';
            //parent.NavWin.document.imgECheck.title = '';
            $(parent.NavWin.document).find('#imgECheck').first().attr('src', '../Content/Content/Images/e-check_done.gif');
            $(parent.NavWin.document).find('#imgECheck').first().attr('title', '');
        } 	//if

        if (errProfile != '') {
            lError = true;
            //parent.NavWin.document.imgProfile.src = '../Images/profile_tbd.gif';
            //parent.NavWin.document.imgProfile.title = 'Error';

            $(parent.NavWin.document).find('#imgProfile').first().attr('src', '../Content/Images/profile_tbd.gif');
            $(parent.NavWin.document).find('#imgProfile').first().attr('title', '');
        } 	//if
        if (errTaxes != '') {
            lError = true;
            //parent.NavWin.document.imgAccount.src = '../Images/taxtype_tbd.gif';
            //parent.NavWin.document.imgAccount.title = 'Error';

            $(parent.NavWin.document).find('#imgAccount').first().attr('src', '../Content/Images/taxtype_tbd.gif');
            $(parent.NavWin.document).find('#imgAccount').first().attr('title', '');
        } 	//if

        if (bAddrRequired == true) {
            //parent.NavWin.document.imgAddresses.src = '../Images/address_tbd.gif';
            $(parent.NavWin.document).find('#imgAddresses').first().attr('src', '../Content/Images/address_tbd.gif');
            if (errAddresses != '') {
            } else {	//No Error
                if (lbAddressesChanged == true) {
                    //parent.NavWin.document.imgAddresses.src = '../Images/address_done.gif';
                    //parent.NavWin.document.imgAddresses.title = '';
                    $(parent.NavWin.document).find('#imgAddresses').first().attr('src', '../Content/Images/address_done.gif');
                    $(parent.NavWin.document).find('#imgAddresses').first().attr('title', '');
                } 	//if
            } //if
        } else {
            //parent.NavWin.document.imgAddresses.src = '../Images/address_opt.gif';
            $(parent.NavWin.document).find('#imgAddresses').first().attr('src', '../Content/Images/address_opt.gif');
            if (errAddresses != '') {
            } else {	//No Error
                if (lbAddressesChanged == true) {
                    //parent.NavWin.document.imgAddresses.src = '../Images/address_done.gif';
                    //parent.NavWin.document.imgAddresses.title = '';
                    $(parent.NavWin.document).find('#imgAddresses').first().attr('src', '../Content/Images/address_done.gif');
                    $(parent.NavWin.document).find('#imgAddresses').first().attr('title', '');
                } 	//if
            } //if
        } 	//if
        //EHD - 20100528 - EGOVWEB-24 - Changed Started
        if (bOfficersRequired == true) {
            //parent.NavWin.document.imgPartners.src = '../Images/officer_tbd.gif';
            $(parent.NavWin.document).find('#imgPartners').first().attr('src', '../Content/Images/officer_tbd.gif');
            if (errPartners != '') {
            } else {	//No Error
                if (lbPartnerChanged == true) {
                    //parent.NavWin.document.imgPartners.src = '../Images/officer_done.gif';
                    //parent.NavWin.document.imgPartners.title = '';
                    $(parent.NavWin.document).find('#imgPartners').first().attr('src', '../Content/Images/officer_done.gif');
                    $(parent.NavWin.document).find('#imgPartners').first().attr('title', '');
                } 	//if
            } //if
        } else {
            //parent.NavWin.imgPartners.src = '../Images/officer_opt.gif';
            $(parent.NavWin.document).find('#imgPartners').first().attr('src', '../Content/Images/officer_opt.gif');
            if (errPartners != '') {
            } else {	//No Error
                if (lbPartnerChanged == true) {
                    //parent.NavWin.document.imgPartners.src = '../Images/officer_done.gif';
                    //parent.NavWin.document.imgPartners.title = '';
                    $(parent.NavWin.document).find('#imgPartners').first().attr('src', '../Content/Images/officer_done.gif');
                    $(parent.NavWin.document).find('#imgPartners').first().attr('title', '');
                } 	//if
            } //if
        } 	//if

        //		lError = true
        //		parent.NavWin.imgPartners.title = 'Error'}		//if
        //EHD - 20100528 - EGOVWEB-24 - Changed Ended
        if (errECheck != '') {
            lError = true;
            //parent.NavWin.document.imgECheck.src = '../Images/e-check_tbd.gif';
            //parent.NavWin.document.imgECheck.title = 'Error';
            $(parent.NavWin.document).find('#imgECheck').first().attr('src', '../Content/Images/e-check_tbd.gif');
            $(parent.NavWin.document).find('#imgECheck').first().attr('title', 'Error');
        } 	//if



        //	if (lError != true) {
        //	    var lsTbdGif = '_tbd.gif';
        //		if (parent.NavWin.document.imgProfile.src.search(lsTbdGif) != '-1' ||
        //				parent.NavWin.document.imgAccount.src.search(lsTbdGif) != '-1' ||
        //				parent.NavWin.document.imgAddresses.src.search(lsTbdGif) != '-1' ||
        //				parent.NavWin.document.imgPartners.src.search(lsTbdGif) != '-1') {


        //SUMAN THIS LINE CREATING ERROR IN G CHROME........

        var imgProfile_src = $(parent.NavWin.document).find('#imgProfile').first().attr('src');
        //		...........
        var imgAccount_src = $(parent.NavWin.document).find('#imgAccount').first().attr('src');
        var imgAddresses_src = $(parent.NavWin.document).find('#imgAddresses').first().attr('src');
        var imgPartners_src = $(parent.NavWin.document).find('#imgPartners').first().attr('src');


        if (lError != true) {
            var lsTbdGif = '_tbd.gif';

            if (imgProfile_src.indexOf(lsTbdGif) != '-1' ||
				imgAccount_src.indexOf(lsTbdGif) != '-1' ||
				imgAddresses_src.indexOf(lsTbdGif) != '-1' ||
				imgPartners_src.indexOf(lsTbdGif) != '-1') {

                //parent.NavWin.document.imgSubmit.src = '../Images/submit_tbd.gif';
                //parent.NavWin.document.imgSubmit.disabled = true;
                //parent.NavWin.document.imgSubmit.style.cursor = '';

                var btn_submit = $(parent.NavWin.document).find('#imgSubmit').first();

                $(btn_submit).attr('src', '../Content/Images/submit_tbd.gif');
                if (window.ActiveXObject) {
                    $(btn_submit).attr('disabled', 'true');
                }
                else {
                    $(btn_submit).prop("onclick", false);
                }
                $(btn_submit).css('cursor', '');

            } else {
                //parent.NavWin.document.imgSubmit.src = '../Images/submit_done.gif';
                //parent.NavWin.document.imgSubmit.disabled = false;
                //parent.NavWin.document.imgSubmit.style.cursor = 'hand';

                var btn_submit = $(parent.NavWin.document).find('#imgSubmit').first();

                $(btn_submit).attr('src', '../Content/Images/submit_done.gif');
                if (window.ActiveXObject) {
                    $(btn_submit).removeAttr('disabled');
                }
                else {
                    $(btn_submit).attr('onclick', 'parent.DocWin.ispDisplayProgress(parent.DocWin.DoSubmit,"Submitting account information")');
                }

                $(btn_submit).css('cursor', 'hand');
                //$(btn_submit).css('cursor', 'pointer');
            } 	//if
        } else {
            //parent.NavWin.document.imgSubmit.src = '../Images/submit_tbd.gif';
            //parent.NavWin.document.imgSubmit.disabled = true;
            //parent.NavWin.document.imgSubmit.style.cursor = '';

            var btn_submit = $(parent.NavWin.document).find('#imgSubmit').first();
            $(btn_submit).attr('src', '../Content/Images/submit_tbd.gif');
            if (window.ActiveXObject) {
                $(btn_submit).attr('disabled', 'true');
            }
            else {
                $(btn_submit).prop("onclick", false);
            }
            $(btn_submit).css('cursor', '');
        } 	//if
    } 	//SetNavButtons

    function InitNavButtons() {
        var lBackColor, imgProfile, imgAccount, imgAddresses, imgPartners, imgECheck, imgSubmit, btnPrint;

        parent.NavWin.ClearButtons();
        parent.NavWin.ClearImages();

        if (parent.MenuWin.sNew == true) {
            imgProfile = '<img id="imgProfile" style="CURSOR: hand" src="../Content/Images/profile_tbd.gif" ' +
				'onclick="parent.DocWin.ShowForm(\'AcctProfile\')" title="Required"></img>';
            imgAccount = '<img id="imgAccount" style="CURSOR: hand" src="../Content/Images/taxtype_tbd.gif" ' +
				'onclick="parent.DocWin.ShowForm(\'AcctTaxes\')" title="Required"></img>';
            imgAddresses = '<img id="imgAddresses" style="CURSOR: hand" src="../Content/Images/address_opt.gif" ' +
				'onclick="parent.DocWin.ShowForm(\'AcctAddresses\')"></img>';
            imgPartners = '<img id="imgPartners" style="CURSOR: hand" src="../Content/Images/officer_opt.gif" ' +
				'onclick="parent.DocWin.ShowForm(\'AcctPartners\')"></img>';
            imgECheck = '<img id="imgECheck" src="../Content/Images/e-check_opt.gif" ' +
				'onclick="parent.DocWin.ShowForm(\'AcctECheck\')"';
            //ECHECK - ehd 3/16/03
            if (parent.window.gEnvironment == 'U') {
                imgECheck = imgECheck + ' style="CURSOR: hand;"></img>';
            } else {
                imgECheck = imgECheck + ' style="display:none;VISIBILITY: visible;CURSOR: hand;"></img>';
            } 	//if
            //ECHECK - ehd 3/16/03
            imgSubmit = '<img id="imgSubmit" style="CURSOR: hand" src="../Content/Images/submit_tbd.gif" ' +
				'onclick="parent.DocWin.ispDisplayProgress(parent.DocWin.DoSubmit,\'Submitting&nbsp;account&nbsp;information\')"></img>';
        } else {
            imgProfile = '<img id="imgProfile" style="CURSOR: hand" src="../Content/Images/profile_opt.gif" ' +
				'onclick="parent.DocWin.ShowForm(\'AcctProfile\')" title=""></img>';
            imgAccount = '<img id="imgAccount" style="CURSOR: hand" src="../Content/Images/taxtype_opt.gif" ' +
				'onclick="parent.DocWin.ShowForm(\'AcctTaxes\')" title=""></img>';
            imgAddresses = '<img id="imgAddresses" style="CURSOR: hand" src="../Content/Images/address_opt.gif" ' +
				'onclick="parent.DocWin.ShowForm(\'AcctAddresses\')" title=""></img>';
            imgPartners = '<img id="imgPartners" style="CURSOR: hand" src="../Content/Images/officer_opt.gif" ' +
				'onclick="parent.DocWin.ShowForm(\'AcctPartners\')" title=""></img>';
            imgECheck = '<img id="imgECheck" src="../Content/Images/e-check_opt.gif" ' +
				'onclick="parent.DocWin.ShowForm(\'AcctECheck\')" title=""';
            //ECHECK - ehd 3/16/03

            if (parent.window.gEnvironment == 'U') {
                imgECheck = imgECheck + ' style="CURSOR: hand;"></img>';
            } else {
                imgECheck = imgECheck + ' style="display:none;VISIBILITY: visible;CURSOR: hand;"></img>';
            } 	//if
            //ECHECK - ehd 3/16/03
            imgSubmit = '<img id="imgSubmit" style="CURSOR: hand" src="../Content/Images/submit_tbd.gif" ' +
				'onclick="parent.DocWin.ispDisplayProgress(parent.DocWin.DoSubmit,\'Submitting&nbsp;account&nbsp;information\')"></img>';
        } 	//if
        //Suman 28/12/2012 , add style position:absolute; otherwise it will not appear correctly on other browsers
        btnPrint = '<button id="btnPrint" style="position:absolute;height:28; width:122; margin-bottom:6px; margin-left:60px;" ' + 'onclick="parent.DocWin.PrintApplication()">Print Application</button>';

        $(parent.NavWin.document).find('#btn7').first().html(imgProfile + imgAccount + imgAddresses + imgPartners +
			imgECheck + imgSubmit + btnPrint);

        try {
            $(parent.NavWin.document).find('#mnuImages').first().css('display', 'block');
        }
        catch (expression) {
            alert('Initnav button : ' + expression);
        }

        //x.style.display = 'block';
    } 	//InitNavButtons

    function navBtnEdit() {

        if ($('#AppError').text() == "") {
            $(parent.NavWin.document).find('#btnApp').fisrt().css('background', 'green');
        } 	//if
    } 	//navBtnEdit

    function PrintApplication() {
        var CurrentDisplayed;
        if ($('#AcctProfile').css('display') == 'block') {
            CurrentDisplayed = $('#AcctProfile').get(0);
        } else if ($('#divAcctTaxes').css('display') == 'block') {
            CurrentDisplayed = $('#divAcctTaxes').get(0);
        } else if ($('#AcctAddresses').css('display') == 'block') {
            CurrentDisplayed = $('#AcctAddresses').get(0);
        } else if ($('#AcctPartners').css('display') == 'block') {
            CurrentDisplayed = $('#AcctPartners').get(0);
        } 	//if

        //	AppHeader.style.display = 'none'
        $('#AppMessage').css('display', 'none');
        var oldHeader = $('#AppHeader').html().replace(txtHeader, '')
        $('#AppHeader').html(txtHeader);
        Profile_Print(true);
        Taxes_Print(true);
        Address_Print(true);
        Partners_Print(true);
        //	alert('Printing... ' + CurrentDisplayed.id.replace('div', ''))
        parent.DocWin.focus();
        parent.DocWin.print();

        //	AppHeader.style.display = 'block'
        $('#AppMessage').css('display', 'block');
        $('#AppHeader').html(txtHeader + oldHeader);
        Profile_Print(false);
        Taxes_Print(false);
        Address_Print(false);
        Partners_Print(false);

        ShowForm(CurrentDisplayed.id.replace('div', ''));
    } 	//PrintApplication

    function DoSubmit() {

        //Suman ----------------------------------------------
        //no required, jquery parse will handle xml transforms 
        /*if (window.XMLHttpRequest) {
            req = new XMLHttpRequest();
        }
        else if (window.ActiveXObject) {
            req = new ActiveXObject("MSXML.DOMDocument");
        }*/
        //original code
        //var xmlTemp = new ActiveXObject("MSXML.DOMDocument");
        //-----------------------------------------------------
        var xmlTemp = parent.MenuWin.getXmlDocObj();
        //-----------------------------------------------------

        //	var xmlCode1 = new ActiveXObject("MSXML.DOMDocument")

        //EHD - 2008.11.24 - Added for the Code1 Addition
        /*if(isDisabled == 'true'){
			return;
		}*/


        //	ispHideProgress()


        /*
        alert('If address change : ' + bAcctAddressChanged);
        ispHideProgress();
        return;
        */


        if (bAcctAddressChanged == true) {
            ad_CorrectBLAddress();
            AC_Form = 'PROFILE';
            ispHideProgress();
            ShowForm('AcctProfile');
            if (ac_CheckAddress() == false) {
                return;
            }
        }

        if (UpdateProfileXml() == false) {
            ispHideProgress();
            ShowForm("AcctProfile");
            return;
        } 	//if

        if (UpdateAccounts() == false) {
            ispHideProgress();
            ShowForm("AcctTaxes");
            return;
        } 	//if

        //clipboardData.setData ('Text', parent.MenuWin.xmlAccount.xml.xml);


        //return;
        var hmm = parent.MenuWin.xmlAccount;
        ispCallXMLForm(parent.MenuWin.xmlAccount, xmlTemp, '../AccountInfo', '');

        var err = xmlTemp;

        if (ispXmlGetFieldVal(xmlTemp, 'ERROR_INFO MESSAGE', '', 0) == '') {
            ispHideProgress();
            lbProfileChanged = false;
            initProfile = false;
            lbAcctChanged = false;
            initTaxes = false;
            lbAddressesChanged = false;
            initAddresses = false;
            lbPartnerChanged = false;
            initPartners = false;
            lbECheckChanged = false;
            initEcheck = false;

            //parent.MenuWin.xmlAccount.loadXML(xmlTemp.xml)
            parent.MenuWin.xmlAccount = xmlTemp;
            ClearXmlFunctionVals();
            if (parent.MenuWin.sNew == true) {		//&& // SUMAN: ENABLE EMAIL FOR EDIT to test //parent.MenuWin.sNew == true
                parent.NavWin.ClearButtons();
                stemp = CreateAcctNewEmail();

                ispXmlSetFieldVal(parent.MenuWin.xmlEmail, 'NEWREG', 'FUNCTION', '', 0);
                ispXmlSetFieldVal(parent.MenuWin.xmlEmail, stemp, 'DATA', '', 0);
                ispXmlSetFieldVal(parent.MenuWin.xmlEmail, txtEmail.value, 'ADDRESS', '', 0);
                ispCallXMLForm(parent.MenuWin.xmlEmail, oEmail, '../MailPIN', '');
                ShowForm('AcctThankYou');
            }
            else {
                ShowForm('AcctThankYou');
            } 	//if
        }
        else {
            ispHideProgress();
            ShowForm('AcctProfile');
            $('#AppError').text(ispXmlGetFieldVal(xmlTemp, 'ERROR_INFO MESSAGE', '', 0));
        } 	//if

        $(parent.NavWin.document).find('#btn7').first().css('visibility', 'visible');
    } 	//DoSubmit

    function FormatSsnEin(sType, iVal) {

        if (iVal.length == 9) {
            if (sType.toUpperCase() == 'SSN') {
                return iVal.substr(0, 3) + '-' + iVal.substr(3, 2) + '-' + iVal.substr(5);
            } else if (sType.toUpperCase() == 'EIN') {
                return iVal.substr(0, 2) + '-' + iVal.substr(2);
            } else {
                return iVal;
            } 	//if
        } else {
            return iVal;
        } 	//if
    } 	//FormatSsnEin

    function CheckClass() {
        var evt = window.event || arguments.callee.caller.arguments[0];
        var source = parent.MenuWin.getEventSource(evt);
        if ($('#source').attr('class') == 'inpError') {
            $('#source').attr('class', 'inpNormal');
        } 	//if
    } 	//CheckClass


    //-->
</script>


<title></title>
</head>
<% Html.RenderAction("AppHeader", "INC"); %>

<body onload="window_onload()">

<span onactivate="return CheckClass()">

<%
    
    Html.RenderAction("Profile", "Acct");
    Html.RenderAction("Taxes", "Acct");
    Html.RenderAction("Addresses", "Acct");
    Html.RenderAction("Partners_Officers", "Acct");
    Html.RenderAction("Echeck", "Acct");
    Html.RenderAction("ThankYou", "Acct");
    Html.RenderAction("NewEmail", "Acct");
    Html.RenderAction("AddressCorrection", "Acct");
    Html.RenderAction("Progress", "INC");
   
        
%>

<!-- 
Includes 
----------------------------------------

file="Profile.htm"
file="Taxes.htm"
file="Addresses.htm"
file="Partners-Officers.htm"
file="Echeck.htm"
file="ThankYou.htm"
file="NewEmail.htm"
file="AddressCorrection.htm"
file="../Inc/Progress.htm"
        
 -->

</span>

<!-- <input onclick="sendDemoMail()" value="send demo email" type="button"/> -->
</body>
</html>

