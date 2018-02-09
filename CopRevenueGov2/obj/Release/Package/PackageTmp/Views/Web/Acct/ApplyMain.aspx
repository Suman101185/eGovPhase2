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
          
           
            loadXmlFiles();
            setTimeout('isLoaded()', 100);

           

            ClearXmlFunctionVals();
            ShowForm('AcctProfile');

            
        } 	//window_onload

        function ResolveIframeHeight()
        {
            //----------Manoranjan------------------------------
            var iframe = window.parent.document.getElementById('ifrmDocwin');
            var container = $('#tab1').css("height");
            iframe.style.height = container;
            //----------------------------------------
        }       

        function loadXmlFiles() {

           
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
            
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, 'NEWREG', 'FUNCTION', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, 'Hello sUMAN this is a mail test demo', 'DATA', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, 'sknath25@gmail.com', 'ADDRESS', '', 0);
            
            ispCallXMLForm(oEmail, oEmail, 'MailPIN', '');
        }

        function ClearXmlFunctionVals() {
            var i;
           
            for (i = 0; i < parent.$x.ispXmlGetRecCount(parent.$g.xmlAccount, "FUNCTION_CODE", "n") ; i++) {
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, "", "FUNCTION_CODE", "", i);
            } 	//for
        } 	//ClearXmlFunctionVals

        function ShowForm(id) {
          
          
            $(parent.AppError).text('');
            


            $('#AcctProfile').css('display', 'none');
         
            $('#divAcctTaxes').css('display', 'none');
            $('#AcctAddresses').css('display', 'none');
            $('#AcctPartners').css('display', 'none');
            $('#AcctECheck').css('display', 'none');
            $('#AcctThankYou').css('display', 'none');
            $('#AcctExistThankYou').css('display', 'none');
            
            var menu_acctprof = parent.document.getElementById('mnuAcctProfile');     //sangha


            parent.ispMenu_onclick(menu_acctprof);  //sangha
          



           

            if (id == 'AcctProfile') {
               
                DisplayProfile();
                ResolveIframeHeight();
                
            }
            else if (id == 'AcctTaxes') {               
                DisplayTaxes();
                ResolveIframeHeight();
              
            }
            else if (id == 'AcctAddresses') {
                DisplayAddresses();
                ResolveIframeHeight();
                
            }
            else if (id == 'AcctPartners') {
                DisplayPartners();
                ResolveIframeHeight();
               
            }
            else if (id == 'AcctECheck') {
                DisplayECheck();
                ResolveIframeHeight();
               
            }
            else if (id == 'AcctThankYou') {
                $('#divbtnSubmit').css('display', 'none');
                DisplayThankYou();
                ResolveIframeHeight();
            }
            
        } 	//ShowForm



        function SetSubmitButton() {
            var lError = false;
            var chkProf = false, chktax = true, chkAddr = false, chkOfficer = false, chkEcheck = false;

            if (CurrentLayer == '') {
                return;
            } 	//if

            if (lbProfileChanged == true) {
                chkProf = true;
               
            } 	//if
            if (lbAcctChanged == true) {
                chktax = true;
               
            } 	//if
            if (lbECheckChanged == true) {
                chkEcheck = true;
               
            } 	//if

            if (errProfile != '') {
                lError = true;
                chkProf = false;

               
            } 	//if
            if (errTaxes != '') {
                lError = true;
                chkEcheck = false;
               
            } 	//if

            if (bAddrRequired == true) {
                chkAddr = false;
               
                if (errAddresses != '') {
                } else {	//No Error
                    if (lbAddressesChanged == true) {
                        chkAddr = true;
                        
                    } 	//if
                } //if
            } else {
                chkAddr = true;
               
                if (errAddresses != '') {
                } else {	//No Error
                    if (lbAddressesChanged == true) {

                        chkAddr = true;
                        
                    } 	//if
                } //if
            } 	//if
            //EHD - 20100528 - EGOVWEB-24 - Changed Started
            if (bOfficersRequired == true) {
                chkOfficer = false;
                
                if (errPartners != '') {
                } else {	//No Error
                    if (lbPartnerChanged == true) {
                        chkOfficer = true;
                        
                    } 	//if
                } //if
            } else {
                chkOfficer = true;
                
                if (errPartners != '') {
                } else {	//No Error
                    if (lbPartnerChanged == true) {
                        chkOfficer = true;
                       
                    } 	//if
                } //if
            } 	//if


            if (errECheck != '') {
                lError = true;
                chkEcheck = false;
               
            } 	//if



           


            if (lError != true) {
               
                if (chkProf != true ||
                   chkAddr != true ||
                   chkOfficer != true ||
                   chktax != true) {

                    
                    $('#imgSubmit').removeClass('submit_button');
                    $('#imgSubmit').addClass('submit_buttonDeactivated')
                    $('#imgSubmit').attr('onclick', '').unbind('click');
                    $('#imgSubmit').css('cursor', 'default');

                } else {

                    
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
           
            parent.DocWin.focus();
            parent.DocWin.print();

           
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
        
            debugger;
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
           // debugger;
            // alert(parent.$g.xmlAccount);

            var ReqXML = parent.$g.xmlAccount; //changes


            // calling ajax to  write log 
            $.ajax({
                type: 'POST',
                url: '../Returns/Log',
                data: '{ "OriginationFom" : "Registration","ServiceName" : "RTTIE010","RequestXML" : "' + btoa(ReqXML.toString()) + '"}',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (msg) {

                }
            });
            
            ispCallXMLForm(parent.$g.xmlAccount, xmlTemp, 'AccountInfo', '');

            var ResXML = parent.$g.xmlAccount; //changes


            // calling ajax to  write log 
            $.ajax({
                type: 'POST',
                url: '../Returns/Log',
                data: '{ "OriginationFom" : "Registration","ServiceName" : "RTTIE010","ResponseXML" : "' + btoa(ResXML.toString()) + '"}',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (msg) {

                }
            });
           
           

            var err = xmlTemp;
            var txtEmail = document.getElementById('txtEmail');
            //alert(parent.$x.ispXmlGetFieldVal(xmlTemp, 'ERROR_INFO MESSAGE', '', 0));
            if (parent.$x.ispXmlGetFieldVal(xmlTemp, 'ERROR_INFO MESSAGE', '', 0) == '' || parent.$x.ispXmlGetFieldVal(xmlTemp, 'ERROR_INFO MESSAGE', '', 0) == 'NAME REQUIRED' ) { //changes
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
                   
                    stemp = CreateAcctNewEmail();

                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, 'NEWREG', 'FUNCTION', '', 0);
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, stemp, 'DATA', '', 0);
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, txtEmail.value, 'ADDRESS', '', 0);
                   
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
                
            } 	//if

           
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




        function HideMenuTaxYears() {

            //1 = Wage  29 = School  24 = BPT  3 = NPT  27 = Tobacco
            var iWageItems = 0, iSchoolItems = 0, iBPTezItems = 0, iBPTlfItems = 0, iNPTItems = 0, iTobaccoItems = 0;
            ReformatTaxesEndDate();
            var startDate;
            var prkId;
            a = parent.document.getElementsByTagName('li'); //removed menuwin Sangha

            for (i = 0; i < a.length; i++) {

                if (a[i].id.indexOf('mnuWageYear') != -1 && GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '1') == 1) {
                    startDate = GetInnerNodeText(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', 'START_DATE', '1').slice(-4);
                    prkId = GetInnerNodeText(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', 'PRK_ID', '1').slice(-4);

                    if (startDate != '' && '20' + a[i].id.slice(-2) < startDate) {
                        $(a[i]).css("display", "none");
                    } else if (prkId != '' && '20' + a[i].id.slice(-2) > prkId) {


                        $(a[i]).css("display", "none");
                    } else {
                        $(a[i]).css("display", "block");
                        iWageItems = iWageItems + 1;
                       

                    }		//if
                    //School Menu Items
                } else if (a[i].id.indexOf('mnuSchoolYear') != -1 && GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '29') == 1) {

                    startDate = GetInnerNodeText(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', 'START_DATE', '29').slice(-4);
                    prkId = GetInnerNodeText(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', 'PRK_ID', '29').slice(-4);

                    if (startDate != '' && '20' + a[i].id.slice(-2) < startDate) {

                        $(a[i]).css("display", "none");
                    } else if (prkId != '' && '20' + a[i].id.slice(-2) > prkId) {

                        $(a[i]).css("display", "none");
                    } else {
                        $(a[i]).css("display", "block");
                        iSchoolItems = iSchoolItems + 1;
                        
                    }		//if
                    //NPT Menu Items
                } else if (a[i].id.indexOf('mnuNPTYear') != -1 && GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '3') == 1) {

                    startDate = GetInnerNodeText(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', 'START_DATE', '3').slice(-4);
                    prkId = GetInnerNodeText(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', 'PRK_ID', '3').slice(-4);


                    if (startDate != '' && '20' + a[i].id.slice(-2) < startDate) {
                        $(a[i]).css("display", "none");
                    } else if (prkId != '' && '20' + a[i].id.slice(-2) > prkId) {

                        $(a[i]).css("display", "none");
                    } else {
                        $(a[i]).css("display", "block");
                        iNPTItems = iNPTItems + 1;
                    }		//if
                    //BPTez Menu Items
                } else if (a[i].id.indexOf('mnuBPTezYear') != -1 && GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '24') == 1) {


                    startDate = GetInnerNodeText(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', 'START_DATE', '24').slice(-4);
                    prkId = GetInnerNodeText(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', 'PRK_ID', '24').slice(-4);


                    if (startDate != '' && '20' + a[i].id.slice(-2) < startDate) {

                        $(a[i]).css("display", "none");
                    } else if (prkId != '' && '20' + a[i].id.slice(-2) > prkId) {

                        $(a[i]).css("display", "none");
                    } else {
                        $(a[i]).css("display", "block");
                        //alert(a[i].id);
                        iBPTezItems = iBPTezItems + 1;
                    }		//if
                    //BPTlf Menu Items
                } else if (a[i].id.indexOf('mnuBPTlfYear') != -1 && GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '24') == 1) {

                    startDate = GetInnerNodeText(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', 'START_DATE', '24').slice(-4);
                    prkId = GetInnerNodeText(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', 'PRK_ID', '24').slice(-4);


                    if (startDate != '' && '20' + a[i].id.slice(-2) < startDate) {

                        $(a[i]).css("display", "none");
                    } else if (prkId != '' && '20' + a[i].id.slice(-2) > prkId) {

                        $(a[i]).css("display", "none")
                    } else {
                        $(a[i]).css("display", "block");
                        iBPTlfItems = iBPTlfItems + 1;
                    }		//if
                    //Tobacco Menu Items
                } else if (a[i].id.indexOf('mnuTOBYear') != -1 && GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '27') == 1) {

                    startDate = GetInnerNodeText(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', 'START_DATE', '27').slice(-4);
                    prkId = GetInnerNodeText(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', 'PRK_ID', '27').slice(-4);


                    if (startDate != '' && '20' + a[i].id.slice(-2) < startDate) {

                        $(a[i]).css("display", "none");
                    } else if (prkId != '' && '20' + a[i].id.slice(-2) > prkId) {

                        $(a[i]).css("display", "none")
                    } else {
                        $(a[i]).css("display", "block");
                        iTobaccoItems = iTobaccoItems + 1;
                    }		//if
                }		//if
            }		//for

           

            if (iWageItems == 0) {
                $('#mnuReWage').css("display", "none");
               
            }		//if
            if (iSchoolItems == 0) {
                $('#mnuReSchool').css("display", "none");
              
            }		//if
            if (iNPTItems == 0) {
                $('#mnuReNPT').css("display", "none");
                
            }		//if
            if (iBPTezItems == 0) {
                $('#mnuReBPTez').css("display", "none");//Sangha
                
            }		//if
            if (iBPTlfItems == 0) {
                $('#mnuBPTlf').css("display", "none");
              
            }		//if
            if (iTobaccoItems == 0) {
                $('#mnuTOB').css("display", "none"); //by manoranjan
               

            }

          
        }


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

