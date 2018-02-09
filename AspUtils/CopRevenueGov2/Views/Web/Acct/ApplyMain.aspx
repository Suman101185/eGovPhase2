<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>



<html>
<head>
    <%--<link href="../Content/Styles/framestyle.css" rel="stylesheet" type="text/css" />--%>
    <link type="text/css" rel="Stylesheet" href="../Content/Styles/Font.css" />
    <link type="text/css" rel="Stylesheet" href="../Content/Styles/Object.css" />
    <script type="text/javascript" language="javascript" src="../Content/Scripts/jquerymin.js"></script>
    <script type="text/javascript" language="javascript" src="../Content/Scripts/ispFunctions.js"></script>
    <script type="text/javascript" language="javascript" src="../Content/Scripts/Accounting.js"></script>
    <script type="text/javascript" language="javascript" src="../Content/Scripts/jquery.browser.min.js"></script>

    <script id="clientEventHandlersJS" language="javascript" type="text/javascript">

        //EHD - 20100609 - EGOVWEB-28

        var oAcctInfo = parent.$g.getXmlDocObj();
        var oEmail = parent.$g.getXmlDocObj();

        var txtHeader = 'Taxpayer Information';
        var CurrentDiv = 'divTax01';
        var lbProfileChanged = false;
        var lbAcctChanged = false;
        var lbAddressesChanged = false;
        var lbPartnerChanged = false, lbECheckChanged = false, CurrentLayer;
        var mToday = '<%= DateTime.Now.Date.ToString("m/d/y") %>';
        var mTime = '<%= DateTime.Now.Date.ToString("h:m") %>';
        var IsAddrShown = false;
        var IsOfficerShown = false;
        //EGOVWEB-28 Changed sMailingAdd
        var sMailingAdd = -1; 	//false



        function isLoaded() {
            if (
                parent.document.readyState != 'complete'
            ) {
                setTimeout('isLoaded()', 100);
            } 	//if
        } 	//isLoaded


        function window_onload() {
            //alert("55");
            loadXmlFiles();
            setTimeout('isLoaded()', 100);

            // InitSubmitButton();

            ClearXmlFunctionVals();
            ShowForm('AcctProfile');

            //binoy
        } 	//window_onload

        function loadpage1(id) {
            //alert(" block");

            if ($.browser.mozilla || $.browser.firefox || $.browser.opera || $.browser.safari || $.browser.chrome) {
                try {
                    var iFrameID = parent.window.frames['ifrmDocwin'];

                    // $(iFrameID).height($(iFrameID).contents().find("html").height() + 70);
                }
                catch (ee) {
                    var iFrameID1 = parent.document.getElementById('ifrmDocwin');

                    // iFrameID1.height = (iFrameID1.contentWindow.document.body.scrollHeight + 70) + "px";

                }



            }
            else {

                var iFrameID1 = parent.document.getElementById('ifrmDocwin');

                //iFrameID1.height = (iFrameID1.contentWindow.document.body.scrollHeight + 70) + "px";



            }
        } //binoy

        function loadXmlFiles() {

            //parent.$g.loadXmlAsync('../xml/email', load_oEmail);//sangha
            //parent.$g.loadXmlAsync('../xml/AcctTemplate', load_oAcctInfo);//sangha
            parent.$g.loadXmlSync("XML/email", load_oEmail);//sangha
            parent.$g.loadXmlSync("XML/AcctTemplate", load_oAcctInfo);//sangha
        }

        function load_oAcctInfo(xml) {
            oAcctInfo.loadXML(xml);
        }

        function load_oEmail(xml) {
            oEmail.loadXML(xml);
        }

        function sendDemoMail() {
            alert('email xml content : ' + parent.$g.xmlEmail);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, 'NEWREG', 'FUNCTION', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, 'Hello sUMAN this is a mail test demo', 'DATA', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, 'sknath25@gmail.com', 'ADDRESS', '', 0);
            alert('DEmo mail content : ' + parent.$g.xmlEmail);
            ispCallXMLForm(oEmail, oEmail, 'MailPIN', '');
        }

        function ClearXmlFunctionVals() {
            var i;
            //alert(parent.$g.xmlAccount);
            for (i = 0; i < parent.$x.ispXmlGetRecCount(parent.$g.xmlAccount, "FUNCTION_CODE", "n") ; i++) {
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, "", "FUNCTION_CODE", "", i);
            } 	//for
        } 	//ClearXmlFunctionVals

        function ShowForm(id) {

            $(parent.AppError).text('');
            /*Sanghamitra
                  //var is_disabled = $(this.parent.NavWin.document).find('#tblNavMenu').first().is(':disabled');
                  ////var obj = parent.NavWin.document.getElementById('tblNavMenu');
                  //if (is_disabled == true) {
                  //    return;
                  //} 	//if
                    Sanghamitra*/


            $('#AcctProfile').css('display', 'none');
            //$('#divbtnSubmit').css('display', 'none');
            $('#divAcctTaxes').css('display', 'none');
            $('#AcctAddresses').css('display', 'none');
            $('#AcctPartners').css('display', 'none');
            $('#AcctECheck').css('display', 'none');
            $('#AcctThankYou').css('display', 'none');
            $('#AcctExistThankYou').css('display', 'none');
            //var menu_acctprof =  $(parent.MenuWin.document).find('#mnuAcctProfile').first();
            var menu_acctprof = parent.document.getElementById('mnuAcctProfile');     //sangha


            parent.ispMenu_onclick(menu_acctprof);  //sangha
            //var uName = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME', '', '');
            //parent.fillUserAfterLogin(true, uName);



            //parent.MenuWin.ispMenu_onclick(parent.MenuWin.mnuAcctProfile);

            if (id == 'AcctProfile') {
                // initProfile = false;//SAnghamitra
                DisplayProfile();

                //SetSubmitButton();
            }
            else if (id == 'AcctTaxes') {
                DisplayTaxes();

                //SetSubmitButton();
            }
            else if (id == 'AcctAddresses') {
                DisplayAddresses();

                //SetSubmitButton();
            }
            else if (id == 'AcctPartners') {
                DisplayPartners();

                //SetSubmitButton();
            }
            else if (id == 'AcctECheck') {
                DisplayECheck();


                //SetSubmitButton();
            }
            else if (id == 'AcctThankYou') {
                $('#divbtnSubmit').css('display', 'none');
                DisplayThankYou();
            }
            loadpage1(id);//binoy //if
        } 	//ShowForm



        function SetSubmitButton() {
            var lError = false;
            var chkProf = false, chktax = true, chkAddr = false, chkOfficer = false, chkEcheck = false;

            if (CurrentLayer == '') {
                return;
            } 	//if

            if (lbProfileChanged == true) {
                chkProf = true;
                //$(parent.NavWin.document).find('#imgProfile').first().attr('src', '../Content/Images/profile_done.gif');
                //$(parent.NavWin.document).find('#imgProfile').first().attr('title', '');
            } 	//if
            if (lbAcctChanged == true) {
                chktax = true;
                //$(parent.NavWin.document).find('#imgAccount').first().attr('src', '../Content/Images/taxtype_done.gif');
                //$(parent.NavWin.document).find('#imgAccount').first().attr('title', '');
            } 	//if
            if (lbECheckChanged == true) {
                chkEcheck = true;
                //$(parent.NavWin.document).find('#imgECheck').first().attr('src', '../Content/Content/Images/e-check_done.gif');
                //$(parent.NavWin.document).find('#imgECheck').first().attr('title', '');
            } 	//if

            if (errProfile != '') {
                lError = true;
                chkProf = false;

                //$(parent.NavWin.document).find('#imgProfile').first().attr('src', '../Content/Images/profile_tbd.gif');
                //$(parent.NavWin.document).find('#imgProfile').first().attr('title', '');
            } 	//if
            if (errTaxes != '') {
                lError = true;
                chkEcheck = false;
                //$(parent.NavWin.document).find('#imgAccount').first().attr('src', '../Content/Images/taxtype_tbd.gif');
                //$(parent.NavWin.document).find('#imgAccount').first().attr('title', '');
            } 	//if

            if (bAddrRequired == true) {
                chkAddr = false;
                //  $(parent.NavWin.document).find('#imgAddresses').first().attr('src', '../Content/Images/address_tbd.gif');
                if (errAddresses != '') {
                } else {	//No Error
                    if (lbAddressesChanged == true) {
                        chkAddr = true;
                        //$(parent.NavWin.document).find('#imgAddresses').first().attr('src', '../Content/Images/address_done.gif');
                        //$(parent.NavWin.document).find('#imgAddresses').first().attr('title', '');
                    } 	//if
                } //if
            } else {
                chkAddr = true;
                //parent.NavWin.document.imgAddresses.src = '../Images/address_opt.gif';
                // $(parent.NavWin.document).find('#imgAddresses').first().attr('src', '../Content/Images/address_opt.gif');
                if (errAddresses != '') {
                } else {	//No Error
                    if (lbAddressesChanged == true) {

                        chkAddr = true;
                        //$(parent.NavWin.document).find('#imgAddresses').first().attr('src', '../Content/Images/address_done.gif');
                        //$(parent.NavWin.document).find('#imgAddresses').first().attr('title', '');
                    } 	//if
                } //if
            } 	//if
            //EHD - 20100528 - EGOVWEB-24 - Changed Started
            if (bOfficersRequired == true) {
                chkOfficer = false;
                // $(parent.NavWin.document).find('#imgPartners').first().attr('src', '../Content/Images/officer_tbd.gif');
                if (errPartners != '') {
                } else {	//No Error
                    if (lbPartnerChanged == true) {
                        chkOfficer = true;
                        //$(parent.NavWin.document).find('#imgPartners').first().attr('src', '../Content/Images/officer_done.gif');
                        //$(parent.NavWin.document).find('#imgPartners').first().attr('title', '');
                    } 	//if
                } //if
            } else {
                chkOfficer = true;
                //  $(parent.NavWin.document).find('#imgPartners').first().attr('src', '../Content/Images/officer_opt.gif');
                if (errPartners != '') {
                } else {	//No Error
                    if (lbPartnerChanged == true) {
                        chkOfficer = true;
                        //$(parent.NavWin.document).find('#imgPartners').first().attr('src', '../Content/Images/officer_done.gif');
                        //$(parent.NavWin.document).find('#imgPartners').first().attr('title', '');
                    } 	//if
                } //if
            } 	//if


            if (errECheck != '') {
                lError = true;
                chkEcheck = false;
                //$(parent.NavWin.document).find('#imgECheck').first().attr('src', '../Content/Images/e-check_tbd.gif');
                //$(parent.NavWin.document).find('#imgECheck').first().attr('title', 'Error');
            } 	//if



            //var imgProfile_src = $(parent.NavWin.document).find('#imgProfile').first().attr('src');
            ////		...........
            //var imgAccount_src = $(parent.NavWin.document).find('#imgAccount').first().attr('src');
            //var imgAddresses_src = $(parent.NavWin.document).find('#imgAddresses').first().attr('src');
            //var imgPartners_src = $(parent.NavWin.document).find('#imgPartners').first().attr('src');


            if (lError != true) {
                //var lsTbdGif = '_tbd.gif';

                //if (imgProfile_src.indexOf(lsTbdGif) != '-1' ||
                //	imgAccount_src.indexOf(lsTbdGif) != '-1' ||
                //	imgAddresses_src.indexOf(lsTbdGif) != '-1' ||
                //	imgPartners_src.indexOf(lsTbdGif) != '-1')
                if (chkProf != true ||
                   chkAddr != true ||
                   chkOfficer != true ||
                   chktax != true) {

                    //parent.NavWin.document.imgSubmit.src = '../Images/submit_tbd.gif';
                    //parent.NavWin.document.imgSubmit.disabled = true;
                    //parent.NavWin.document.imgSubmit.style.cursor = '';

                    //var btn_submit = $(parent.NavWin.document).find('#imgSubmit').first();
                    //$(btn_submit).attr('src', '../Content/Images/submit_tbd.gif');
                    //if (window.ActiveXObject) {
                    //    $(btn_submit).attr('disabled', 'true');
                    //}
                    //else {
                    //    $(btn_submit).prop("onclick", false);
                    //}
                    //$(btn_submit).css('cursor', '');
                    $('#imgSubmit').removeClass('submit_button');
                    $('#imgSubmit').addClass('submit_buttonDeactivated')
                    $('#imgSubmit').attr('onclick', '').unbind('click');
                    $('#imgSubmit').css('cursor', 'default');

                } else {

                    //var btn_submit = $(parent.NavWin.document).find('#imgSubmit').first();

                    //$(btn_submit).attr('src', '../Content/Images/submit_done.gif');
                    //if (window.ActiveXObject) {
                    //    $(btn_submit).removeAttr('disabled');
                    //}
                    //else {
                    //    $(btn_submit).attr('onclick', 'parent.DocWin.ispDisplayProgress(parent.DocWin.DoSubmit,"Submitting account information")');
                    //}

                    //$(btn_submit).css('cursor', 'hand');
                    $('#imgSubmit').css('cursor', 'hand');
                    $('#imgSubmit').removeClass('submit_buttonDeactivated');
                    $('#imgSubmit').addClass('submit_button');

                    $('#imgSubmit').click(function () {
                        DoSubmit();
                    });

                } 	//if
            } else {
                $('#imgSubmit').attr('onclick', '').unbind('click');
                $('#imgSubmit').css('cursor', 'default');

                //var btn_submit = $(parent.NavWin.document).find('#imgSubmit').first();
                //$(btn_submit).attr('src', '../Content/Images/submit_tbd.gif');
                //if (window.ActiveXObject) {
                //    $(btn_submit).attr('disabled', 'true');
                //}
                //else {
                //    $(btn_submit).prop("onclick", false);
                //}
                //$(btn_submit).css('cursor', '');
            } 	//if
        } 	//SetNavButtons




        function InitSubmitButton() {
            if (parent.sNew == true) {

                $('#imgSubmit').attr('onclick', '').unbind('click');
                $('#imgSubmit').css('cursor', 'default');
                $('#imgSubmit').removeClass('submit_button');
                $('#imgSubmit').addClass('submit_buttonDeactivated')

            }
            else {

                $('#imgSubmit').css('cursor', 'hand');
                $('#imgSubmit').click(function () {

                    DoSubmit();
                });


            }
        }



        //function navBtnEdit() {

        //    if ($(parent.AppError).text() == "") {
        //        $(parent.NavWin.document).find('#btnApp').fisrt().css('background', 'green');
        //    } 	//if
        //} 	//navBtnEdit

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

            var xmlTemp = parent.$g.getXmlDocObj();
            //  alert("b4 address check      "+parent.$g.xmlAccount);

            if (bAcctAddressChanged == true) {
                ad_CorrectBLAddress();
                AC_Form = 'PROFILE';
                ispHideProgress();
                ShowForm('AcctProfile');
                if (ac_CheckAddress() == false) {
                    return;
                }
            }
            //   alert("after address check      " + parent.$g.xmlAccount);
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

            if (bAddrRequired == true) {
                ispHideProgress();
                ShowForm("AcctAddresses");
                return;
            } 	//if
            else {
                if (IsAddrShown == false) {
                    ispHideProgress();
                    ShowForm("AcctAddresses");
                    IsAddrShown = true;
                    return;
                }


            }

            if (bOfficersRequired == true) {
                ispHideProgress();
                ShowForm("AcctPartners");
                return;
            } 	//if
            else {
                if (IsOfficerShown == false) {

                    ispHideProgress();
                    ShowForm("AcctPartners");
                    IsOfficerShown = true;
                    return;
                }


            }
            //  alert("Request xml:       "+parent.$g.xmlAccount);
            ispCallXMLForm(parent.$g.xmlAccount, xmlTemp, 'AccountInfo', '');
            //  alert(xmlTemp);
            //  ispCallXMLForm(parent.$g.xmlAccount, parent.$g.xmlAccount, 'AccountInfo', '');

            var err = xmlTemp;

            if (parent.$x.ispXmlGetFieldVal(xmlTemp, 'ERROR_INFO MESSAGE', '', 0) == '') {
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

                parent.$g.xmlAccount.loadXML(xmlTemp.xml);
                ClearXmlFunctionVals();
                if (parent.sNew == true) {		//&& // SUMAN: ENABLE EMAIL FOR EDIT to test //parent.MenuWin.sNew == true
                    // parent.NavWin.ClearButtons();
                    stemp = CreateAcctNewEmail();

                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, 'NEWREG', 'FUNCTION', '', 0);
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, stemp, 'DATA', '', 0);
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, txtEmail.value, 'ADDRESS', '', 0);
                    // alert("this is the mail xml           " + parent.$g.xmlEmail);
                    ispCallXMLForm(parent.$g.xmlEmail, parent.$g.xmlEmail, 'MailPIN', '');
                    ShowForm('AcctThankYou');
                }
                else {
                    ShowForm('AcctThankYou');
                } 	//if
            }
            else {
                ispHideProgress();
                ShowForm('AcctProfile');
                $(parent.AppError).text(parent.$x.ispXmlGetFieldVal(xmlTemp, 'ERROR_INFO MESSAGE', '', 0));
            } 	//if

            //  $(parent.NavWin.document).find('#btn7').first().css('visibility', 'visible');//sangha
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
            var source = parent.getEventSource(evt);
            if ($('#source').attr('class') == 'inpError') {
                $('#source').attr('class', 'inpNormal');////SanG
            } 	//if
        } 	//CheckClass


        //-->
    </script>


    <title></title>
</head>
<%--<% Html.RenderAction("AppHeader", "INC"); %>--%> <%--sanghamitra--%>

<body onload="window_onload()">

    <span onactivate="return CheckClass()">

        <%
            Html.RenderAction("Profile", "Acct");
            Html.RenderAction("Echeck", "Acct");
            Html.RenderAction("ThankYou", "Acct");
            Html.RenderAction("NewEmail", "Acct");
            Html.RenderAction("AddressCorrection", "Acct");
            Html.RenderAction("Progress", "INC");
               
          
        %>



    </span>

</body>
</html>

