<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
<title></title>
 <script src="../Content/Scripts/JqueryMin.js" type="text/javascript"></script>
    <!-- Bootstrap Core CSS -->
    <link href="../Content/Styles/bootstrap.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="../Content/Styles/copegov.css" rel="stylesheet">
    <link href="../Content/Styles/style.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../Content/Styles/jPushMenu.css">
 
<script id="clientEventHandlersJS" language="javascript" type="text/javascript">

    var arrBPTezErr = new Array();
    var arrBPTezDateErr = new Array();
    var txtHeader = 'Taxpayer Information';
    var dBPTezNetRate, dBPTezGrossRate;
    var b3800val = false;
    var sYear = '12';
    var mbFirstTime = false;
    var gUserAddr = '<%#  Request.ServerVariables["REMOTE_ADDR"] %>';
    $(document).ready(function () {

        $('input').keyup(function (e) {

            var key = e.charCode ? e.charCode : e.keyCode ? e.keyCode : 0;
            if (key == 13) {
                e.preventDefault();
                return false;
            }

        });

        $('input').keydown(function (e) {

            var key = e.charCode ? e.charCode : e.keyCode ? e.keyCode : 0;
            if (key == 13) {

                e.preventDefault();
                return false;
            }

        });
        DisplayBPTezReturn();
        $('input[type=text]').bind('keypress', function (event) {

            if (event.charCode > 31 && event.charCode != 45 && (event.charCode < 48 || event.charCode > 57)) {
                return false;
            }

        });
    });
    function nFlowCalc() {

        var l5val = cCur($('#lblBPTez1_5').text());
        var l6cval = cCur($('#lblBPTez1_6c').text());

        var l10a_val, l10b_val, l10c_val;
        l10a_val = cCur($('#txtBPTez1_10a').val());
        l10b_val = cCur($('#txtBPTez1_10b').val());
        l10c_val = cCur($('#txtBPTez1_10c').val());

        var nval = l5val - l6cval;

        var bval = 0;
        if (nval < 0) {
            bval = nval + l10a_val + l10b_val + l10c_val;
           
            if (bval != 0) {
                $("#AppError").text('Lines 10a, 10b and 10c must equal Line 7 in Page 1');
                resolvedIframeheight();
                parent.ScrollTop(1);
            }
        }
    }

    function DisplayBPTezReturn() {

        $("#AppError").text('');
       
        parent.$g.loadXmlSync('XML/BPTezReturn_2014', parent.parseXml_xmlBPTez);
        parent.$g.loadXmlSync('XML/BPTezReturn_2014', parent.parseXml_xmlBPTezTemplate);

        if ($(parent.$g.xmlAccount).find("TAX_ACCT").find("ACCOUNT:contains('24')")) {          

            $('#BPTez').css("display", "block");
            $('#BPTez_pg2').css("display", "block"); //binoy

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 'INQ', 'BPT_INFO RETURN_STATUS', '', 0)
            var entityInfo_ACCOUNT_ID = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ACCOUNT_ID', "", 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, entityInfo_ACCOUNT_ID, 'BPT_INFO ACCOUNT_ID', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, '12/31/2014', 'BPT_INFO PERIOD', '', 0);

            $('#AppHeader').html('Business Income & Receipts Tax-EZ for 2014');
            
            parent.gsInstructionItem = '#BIR';
            $('#AppMessage').html('The Business Income & Receipts Tax for 2014 is due April 18, 2015.');

            var ReqXML = parent.$g.xmlBPTez;
            $.ajax({
                type: 'POST',
                url: '../Returns/Log',
                data: '{ "OriginationFom" : "EZ-2014","ServiceName" : "RTTIE037","RequestXML" : "' + btoa(ReqXML.toString()) + '"}',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (msg) {

                }
            });
            setTimeout(function () { }, 3000);
            ispCallXMLForm(parent.$g.xmlBPTez, parent.$g.xmlBPTez, "BPTezReturn_2014", "");

            var ResXML = parent.$g.xmlBPTez;
            $.ajax({
                type: 'POST',
                url: '../Returns/Log',
                data: '{ "OriginationFom" : "EZ-2014","ServiceName" : "RTTIE037","ResponseXML" : "' + btoa(ResXML.toString()) + '"}',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (msg) {

                }
            });
            ispHideProgress();

            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'ERROR_INFO ERROR', "", 0) != 0) {
                $(parent.RightFrame).attr("rows", "*,0");
                $('#BPTez').css("display", "block");
                PopulateBPTezHeader();
                FieldLock(true);
                $("#AppError").text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'ERROR_INFO MESSAGE', "", 0));
                $('#btnBPTezSubmit').attr("disabled", true);
                $('chkAmended').attr("disabled", true);
                return;
            }

            if ($(parent.divAcctInfo).css("display") == 'none') {
                $(parent.divAcctInfo).css("display", "block");
                $(parent.divAccount).css("display", "none");
            }

        }
        else {
            parent.$g.xmlBPTez = parent.$g.xmlBPTezTemplate;
            parent.ispMenu_onclick(parent.mnuAcctInfo);
        }

        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 ACTUAL_TAX', '', 0) == '') {
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 0, 'BPT_PG1 ACTUAL_TAX', '', 0);
        }

        
        //if
        $(parent.RightFrame).attr("rows", "*,0");
        LoadBPTezError();

        RightAlignText();
        CheckBPTezXML();
        PopulateBPTezHeader();
       
        PopulateBPTezData();
        SetBPTezFields();
     
        $('#txtBPTez2_3').attr("disabled", "disabled");
        $("#AppError").text('');
        //    ShowPage(2);
        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_INFO RETURN_STATUS', '', 0) == 'A1' || parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_INFO RETURN_STATUS', '', 0) == 'A2') {
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_INFO VERSION', '', 0) == '') {

                $('#BPTez_pg2').css("visibility", "hidden");
                $('#BPTez_pg2').css("display", "none");
                $('#BPT_19_3800').css('display', 'block');
            } else {
                btn3800YN_onclick(null);
                ShowPage(2);
               
            } 	//if
        } else {
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_INFO PREPARER_NAME ', "", 0) != 0) {//:added this if block to solve the problem of  error message in fresh form.untill there is value in line 7 user wont be able to go to page1.
                ShowPage(2);
            }
            else {
                DisplayNetIncome();//Added for the radio box to check
              
                $('#lblBPTez2_7').text(ispFormatMoney(0, 0));//("$0");
            }

        } 	//if
        GoToPage1Button();     


    }//DisplayBPTez05Return

    function resolvedIframeheight() {
        //iframe height issue resolved
        var iframe = window.parent.document.getElementById('ifrmDocwin');
        var container = $('#tab1').css("height");
        iframe.style.height = container;
    }
    function SetBPTezFields() {
        var chkAmended = document.getElementById("chkAmended");
        var chkAgreement = document.getElementById('chkAgreement');
        var chkTaxpayer = document.getElementById('chkTaxpayer');
        chkAmended.checked = false;       
        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_INFO VERSION', '', 0) == '') {
            mbFirstTime = true;
            FieldLock(false);
            chkAmended.disabled = true;
            chkTaxpayer.checked = false;
            chkAgreement.checked = false;
            
        }
        else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_INFO VERSION', '', 0) != '' && parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_INFO PREPARER_NAME', '', 0) == '' && parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_INFO PREPARER_PHONE', '', 0) == '') {
            FieldLock(false);
        }
        else {
            chkAmended.disabled = false;
            chkAgreement.checked = true;
            FieldLock(true);            
        }		//if
    }		//SetBPTezFields


    function FieldLock(bDisabled) {
        if (bDisabled == true) {
            $('#txtTermDate').attr("disabled", "disabled");
            $('#lblBPTez1_1').attr("disabled", "disabled");
            $('#lblBPTez1_2').attr("disabled", "disabled");
            $('#lblBPTez1_3').attr("disabled", "disabled");
            $('#txtBPTez1_4').attr("disabled", "disabled");
            $('#lblBPTez1_5').attr("disabled", "disabled");
            $('#txtBPTez1_6a').attr("disabled", "disabled");
            $('#txtBPTez1_6b').attr("disabled", "disabled");
            $('#lblBPTez1_6c').attr("disabled", "disabled");
            $('#lblBPTez1_7').attr("disabled", "disabled");
            $('#txtBPTez1_8').attr("disabled", "disabled");
            $('#lblBPTez1_9').attr("disabled", "disabled");
            $('#txtBPTez1_10a').attr("disabled", "disabled");
            $('#txtBPTez1_10b').attr("disabled", "disabled");
            $('#txtBPTez1_10c').attr("disabled", "disabled");
            $('#radBPTez2_1_2_m1').attr("disabled", "disabled");
            $('#radBPTez2_1_2_m2').attr("disabled", "disabled");
            $('#txtBPTez2_1').attr("disabled", "disabled");
            $('#txtBPTez2_2').attr("disabled", "disabled");

            $('#lbl_BPTez2_3').attr("disabled", "disabled");
            $('#txtBPTez2_4').attr("disabled", "disabled");
            $('#lblBPTez2_5').attr("disabled", "disabled");
            $('#lblBPTez2_6').attr("disabled", "disabled");
            $('#txtBPTez2_7a').attr("disabled", "disabled");
            $('#txtBPTez2_7b').attr("disabled", "disabled");
            $('#txtBPTez2_7c').attr("disabled", "disabled");
            $('#txtBPTez2_7d').attr("disabled", "disabled");
            $('#txtBPTez2_7e').attr("disabled", "disabled");
            $('#txtBPTez2_7f').attr("disabled", "disabled");
            $('#txtBPTez2_7g').attr("disabled", "disabled");
            $('#txtBPTez2_7h').attr("disabled", "disabled");
            $('#txtBPTez2_7i').attr("disabled", "disabled");
            $('#lblBPTez2_8').attr("disabled", "disabled");
            $('#lblBPTez2_9').attr("disabled", "disabled");
            $('#lblBPTez2_10').attr("disabled", "disabled");
            $('#lblBPTez2_11').attr("disabled", "disabled");

            $('#txt_BPT_WSEZ1').attr("disabled", "disabled");
            $('#lbl_BPT_WSEZ2').attr("disabled", "disabled");
            $('#lbl_BPT_WSEZ3').attr("disabled", "disabled");
            $('#lbl_BPT_WSEZ4').attr("disabled", "disabled");
            $('#lbl_BPT_WSEZ5').attr("disabled", "disabled");
            $('#btnBPTezSubmit').attr("disabled", "disabled");            
            DisablePreparer(bDisabled);
        }
        else {
            $('#txtTermDate').removeAttr("disabled");
            $('#lblBPTez1_1').removeAttr("disabled");
            $('#lblBPTez1_2').removeAttr("disabled");
            $('#lblBPTez1_3').removeAttr("disabled");
            $('#txtBPTez1_4').removeAttr("disabled");
            $('#lblBPTez1_5').removeAttr("disabled");
            $('#txtBPTez1_6a').removeAttr("disabled");
            $('#txtBPTez1_6b').removeAttr("disabled");
            $('#lblBPTez1_6c').removeAttr("disabled");
            $('#lblBPTez1_7').removeAttr("disabled");
            $('#txtBPTez1_8').removeAttr("disabled");
            $('#lblBPTez1_9').removeAttr("disabled");
            $('#txtBPTez1_10a').removeAttr("disabled");
            $('#txtBPTez1_10b').removeAttr("disabled");
            $('#txtBPTez1_10c').removeAttr("disabled");
            $('#radBPTez2_1_2_m1').removeAttr("disabled");
            $('#radBPTez2_1_2_m2').removeAttr("disabled");
            $('#txtBPTez2_1').removeAttr("disabled");
            $('#txtBPTez2_2').removeAttr("disabled");

            $('#lbl_BPTez2_3').removeAttr("disabled");
            $('#txtBPTez2_4').removeAttr("disabled");
            $('#lblBPTez2_5').removeAttr("disabled");
            $('#lblBPTez2_6').removeAttr("disabled");
            $('#txtBPTez2_7a').removeAttr("disabled");
            $('#txtBPTez2_7b').removeAttr("disabled");
            $('#txtBPTez2_7c').removeAttr("disabled");
            $('#txtBPTez2_7d').removeAttr("disabled");
            $('#txtBPTez2_7e').removeAttr("disabled");
            $('#txtBPTez2_7f').removeAttr("disabled");
            $('#txtBPTez2_7g').removeAttr("disabled");
            $('#txtBPTez2_7h').removeAttr("disabled");
            $('#txtBPTez2_7i').removeAttr("disabled");
            $('#lblBPTez2_8').removeAttr("disabled");
            $('#lblBPTez2_9').removeAttr("disabled");
            $('#lblBPTez2_10').removeAttr("disabled");
            $('#lblBPTez2_11').removeAttr("disabled");

            $('#txt_BPT_WSEZ1').removeAttr("disabled");
            $('#lbl_BPT_WSEZ2').removeAttr("disabled");
            $('#lbl_BPT_WSEZ3').removeAttr("disabled");
            $('#lbl_BPT_WSEZ4').removeAttr("disabled");
            $('#lbl_BPT_WSEZ5').removeAttr("disabled");
            $('#btnBPTezSubmit').removeAttr("disabled");
            DisablePreparer(bDisabled);
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 NET_INCOME_LOSS_1', '', 0) != '$00.00') {
                $('#radBPTez2_1_2_m2').attr("disabled", "disabled");
                $('#txtBPTez2_1').attr("disabled", "disabled");
            }
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 NET_INCOME_LOSS_2', '', 0) != '$00.00') {
                $('#radBPTez2_1_2_m1').attr("disabled", "disabled");
                $('#txtBPTez2_2').attr("disabled", "disabled");

            }
        }

    }//FieldLock


    function CheckBPTezXML() {
        var bPeriodExist = true;

        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 TOTAL_TAX', '', 0) == '$0') {
            bPeriodExist = false;
        }

        if (bPeriodExist == false) {
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, '', 'ERROR_INFO PROGRAM', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, '', 'ERROR_INFO ERROR', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, '', 'ERROR_INFO LINE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, '', 'ERROR_INFO MESSAGE', '', 0);

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, '12/31/2014', 'BPT_INFO PERIOD', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, '', 'BPT_INFO VERSION', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, '', 'BPT_INFO RETURN_STATUS', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, '', 'BPT_INFO LAST_UPD_DATE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, '', 'BPT_INFO RECORDING_DATE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, '', 'BPT_INFO EXTENSION_DATE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, '', 'BPT_INFO SEQUENCE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, '', 'BPT_INFO ADJUSTMENT_REF_NO', '', 0);

            ClearPreparerXML(parent.$g.xmlBPTez, 'BPT_INFO');

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 0, 'BPT_PG1 NET_TAX', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 0, 'BPT_PG1 GROSS_TAX', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 0, 'BPT_PG1 ACTUAL_TAX', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 0, 'BPT_PG1 ESTIMATED_TAX', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 0, 'BPT_PG1 TOTAL_TAX', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 0, 'BPT_PG1 NPT_TAX_CREDIT', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 0, 'BPT_PG1 BPT_TAX_CREDIT', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 0, 'BPT_PG1 TOTAL_PAY_CREDIT', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 0, 'BPT_PG1 TAX_DUE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 0, 'BPT_PG1 INTEREST_PENALTY', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 0, 'BPT_PG1 AMOUNT_OWED', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 0, 'BPT_PG1 REFUND', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 0, 'BPT_PG1 NPT_OVERPAY', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 0, 'BPT_PG1 BPT_OVERPAY', '', 0);

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 0, 'BPT_PG2 NET_INCOME_LOSS_1', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 0, 'BPT_PG2 NET_INCOME_LOSS_2', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 0, 'BPT_PG2 LOSS_CARRY_FORWARD', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 0, 'BPT_PG2 TAXABLE_INCOME', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 0, 'BPT_PG2 TAX_DUE_NET', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 0, 'BPT_PG2 SALES_RENTAL', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 0, 'BPT_PG2 SERVICES', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 0, 'BPT_PG2 RENTAL_PROPERTY', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 0, 'BPT_PG2 ROYALTIES', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 0, 'BPT_PG2 CAPITAL_GAINS', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 0, 'BPT_PG2 STOCK_GAINS', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 0, 'BPT_PG2 DIVIDENDS', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 0, 'BPT_PG2 INTEREST', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 0, 'BPT_PG2 OTHER', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 0, 'BPT_PG2 TAXABLE_GROSS_RCPTS', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 0, 'BPT_PG2 TAX_DUE_GROSS', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 0, 'BPT_PG2 STAT_NET_DEDUCTION_1_X', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 0, 'BPT_PG2 TAXABLE_SUBTOTAL_EZ_X', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 0, 'BPT_PG2 STAT_EXCLUSION_EZ_X', '', 0);
        }
    }//CheckBPTezXML


    function PopulateBPTezHeader() {
        var addrIdx, sFirstName, sMIName, sLastName;
        sFirstName = '';
        sMIName = '';
        sLastName = '';

        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ENTITY_ID', '', 0) != '') {
            $('#lblAccountId').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ACCOUNT_ID', '', 0));
            $('#lblEntityId').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ENTITY_ID', '', 0));

            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO TYPE', '', 0) == 1) {
                $('#lblEntityType').text('EIN:');
                $('#lblEntityId').text(' ' + $('#lblEntityId').text().substr(0, 2) +
                                       '-' + $('#lblEntityId').text().substr(2));
                $('#lblName').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS NAME', '', addrIdx));
            }
            else {
                $('#lblEntityType').text('SSN:');
                $('#lblEntityId').text(' ' + $('#lblEntityId').text().substr(0, 3) +
                                       '-' + $('#lblEntityId').text().substr(3, 2) +
                                       '-' + $('#lblEntityId').text().substr(5));
                sEntityName = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS NAME', '', addrIdx).split('*')
                sLastName = sEntityName[0];
                if (sEntityName[1]) {
                    sFirstName = sEntityName[1] + ' ';
                }
                if (sEntityName[2]) {
                    sMIName = sEntityName[2].substr(0, 1) + ' ';
                }
                $('#lblName').text(sFirstName + sMIName + sLastName);
            }

            addrIdx = LocatePrimaryAddr();

            $('#lblAddress').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS1', '', addrIdx) + ' ' +
                                  parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS CITY', '', addrIdx) + ' ' +
                                  parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS STATE', '', addrIdx) + ' ' +
                                  parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ZIP', '', addrIdx));
        }
    }//PopulateBPTezHeader

    function PopulateBPTezData() {       
        dBPTezNetRate = parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_INFO NET_RATE', '', 0);
        dBPTezGrossRate = parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_INFO GROSS_RATE', '', 0);
       
        $('#msgBPTez2_5').text($('#msgBPTez2_5').text().replace('###', dBPTezNetRate));
        $('#msgBPTez2_8').text($('#msgBPTez2_8').text().replace('###', dBPTezGrossRate));
        //Page1
        $('#lblBPTez1_1').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 NET_TAX', '', 0), 0));
        $('#lblBPTez1_2').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 GROSS_TAX', '', 0), 0));
        $('#lblBPTez1_3').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 ACTUAL_TAX', '', 0), 0));
        $('#txtBPTez1_4').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 ESTIMATED_TAX', '', 0), 0));
        $('#lblBPTez1_5').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 TOTAL_TAX', '', 0), 0));
        $('#txtBPTez1_6a').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 NPT_TAX_CREDIT', '', 0), 0));
        $('#txtBPTez1_6b').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 BPT_TAX_CREDIT', '', 0), 0));
        $('#lblBPTez1_6c').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 TOTAL_PAY_CREDITS', '', 0), 0));
        $('#lblBPTez1_7').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 TAX_DUE', '', 0), 0));
        $('#txtBPTez1_8').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 INTEREST_PENALTY', '', 0), 0));
        $('#lblBPTez1_9').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 AMOUNT_OWED', '', 0), 0));
        $('#txtBPTez1_10a').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 REFUND', '', 0), 0));
        $('#txtBPTez1_10b').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 NPT_OVERPAY', '', 0), 0));
        $('#txtBPTez1_10c').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 BPT_OVERPAY', '', 0), 0));

        PopulatePreparer(parent.$g.xmlBPTez, 'BPT_INFO');

        //Page2
        $('#txtBPTez2_2').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 NET_INCOME_LOSS_1', '', 0), 0));
        $('#txtBPTez2_1').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 NET_INCOME_LOSS_2', '', 0), 0));
        $('#lbl_BPTez2_3').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 STAT_NET_DEDUCTION_1_X', '', 0), 0));
        $('#txtBPTez2_4').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 LOSS_CARRY_FORWARD', '', 0), 0));
        $('#lblBPTez2_5').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 TAXABLE_INCOME', '', 0), 0));
        $('#lblBPTez2_6').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 TAX_DUE_NET', '', 0), 0));
        $('#txtBPTez2_7a').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 SALES_RENTAL', '', 0), 0));
        $('#txtBPTez2_7b').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 SERVICES', '', 0), 0));
        $('#txtBPTez2_7c').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 RENTAL_PROPERTY', '', 0), 0));
        $('#txtBPTez2_7d').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 ROYALTIES', '', 0), 0));
        $('#txtBPTez2_7e').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 CAPITAL_GAINS', '', 0), 0));
        $('#txtBPTez2_7f').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 STOCK_GAINS', '', 0), 0));
        $('#txtBPTez2_7g').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 DIVIDENDS', '', 0), 0));
        $('#txtBPTez2_7h').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 INTEREST', '', 0), 0));
        $('#txtBPTez2_7i').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 OTHER', '', 0), 0));
        $('#lblBPTez2_8').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 TAXABLE_SUBTOTAL_EZ_X', '', 0), 0));
        $('#lblBPTez2_9').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 STAT_EXCLUSION_EZ_X', '', 0), 0));
        $('#lblBPTez2_10').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 TAXABLE_GROSS_RCPTS', '', 0), 0));
        $('#lblBPTez2_11').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 TAX_DUE_GROSS', '', 0), 0));

        $('#txt_BPT_WSEZ1').val(ispFormatMoney(0, 0));
        $('#lbl_BPT_WSEZ4').text(ispFormatMoney(0, 0));
        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 NET_INCOME_LOSS_1', '', 0) == '$00.00') {
            document.getElementById('radBPTez2_1_2_m2').checked = true;

        }
        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 NET_INCOME_LOSS_2', '', 0) == '$00.00') {
            document.getElementById('radBPTez2_1_2_m1').checked = true;

        }
        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 NET_INCOME_LOSS_1', '', 0) == '$00.00' && parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 NET_INCOME_LOSS_2', '', 0) == '$00.00') {
            document.getElementById('radBPTez2_1_2_m2').checked = true;

        }
        CalcPage1Line7();
        CalcPage1Line9_10();
    }//PopulateBPTezData

    function DisplayNetIncome() {
        var curzero = ispFormatMoney(0, 0).toString();
        if ($('#radBPTez2_1_2_m1').is(":disabled") == true) {
            return;
        }

        if ($('#radBPTez2_1_2_m1').checked == true) {
            $('#txtBPTez2_1').attr("disabled", 'disable');
            $('#txtBPTez2_2').removeAttr("disabled");
            ispSetFocus($('#txtBPTez2_2'));
            return;
        }

        if ($('#radBPTez2_1_2_m2').checked == true) {
            $('#txtBPTez2_2').attr("disabled", 'disable');
            $('#txtBPTez2_1').removeAttr("disabled");
            ispSetFocus($('#txtBPTez2_1'));
            return;
        }

        if ($('#txtBPTez2_1').val() == curzero && $('#txtBPTez2_2').val() == curzero) {
            $('#radBPTez2_1_2_m2').checked = true;
            $('#txtBPTez2_2').attr("disabled", "disable");
            ispSetFocus($('#txtBPTez2_1'));
        }
        else if ($('#txtBPTez2_1').val() != curzero) {
            $('#radBPTez2_1_2_m2').checked = true;
            $('#txtBPTez2_2').attr("disabled", "disable");
            ispSetFocus($('#txtBPTez2_1'));
        }
        else if ($('#txtBPTez2_2').val() != curzero) {
            $('#radBPTez2_1_2_m1').checked = true;
            $('#txtBPTez2_1').attr("disabled", "disable");
            ispSetFocus($('#txtBPTez2_2'));
        }
    }//DisplayNetIncome

    function PopulateBPTezXML() {
        var d = new Date();
        var lYear = String(d.getFullYear());
        var lMonth = String(d.getMonth() + 1);
        lMonth = lMonth.length == 1 ? '0' + lMonth : lMonth;
        var lDate = String(d.getDate());
        lDate = lDate.length == 1 ? '0' + lDate : lDate;

        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, lMonth + '/' + lDate + '/' + lYear, 'BPT_INFO RECORDING_DATE', '', 0);
        //Page1
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#lblBPTez1_1').text()), 'BPT_PG1 NET_TAX', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#lblBPTez1_2').text()), 'BPT_PG1 GROSS_TAX', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#lblBPTez1_3').text()), 'BPT_PG1 ACTUAL_TAX', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#txtBPTez1_4').val()), 'BPT_PG1 ESTIMATED_TAX', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#lblBPTez1_5').text()), 'BPT_PG1 TOTAL_TAX', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#txtBPTez1_6a').val()), 'BPT_PG1 NPT_TAX_CREDIT', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#txtBPTez1_6b').val()), 'BPT_PG1 BPT_TAX_CREDIT', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#lblBPTez1_6c').text()), 'BPT_PG1 TOTAL_PAY_CREDITS', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#lblBPTez1_7').text()), 'BPT_PG1 TAX_DUE', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#txtBPTez1_8').val()), 'BPT_PG1 INTEREST_PENALTY', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#lblBPTez1_9').text()), 'BPT_PG1 AMOUNT_OWED', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#txtBPTez1_10a').val()), 'BPT_PG1 REFUND', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#txtBPTez1_10b').val()), 'BPT_PG1 NPT_OVERPAY', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#txtBPTez1_10c').val()), 'BPT_PG1 BPT_OVERPAY', '', 0);
        PopulatePreparerXML(parent.$g.xmlBPTez, 'BPT_INFO');

        //Page2
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#txtBPTez2_2').val()), 'BPT_PG2 NET_INCOME_LOSS_1', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#txtBPTez2_1').val()), 'BPT_PG2 NET_INCOME_LOSS_2', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#lbl_BPTez2_3').text()), 'BPT_PG2 STAT_NET_DEDUCTION_1_X', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#txtBPTez2_4').val()), 'BPT_PG2 LOSS_CARRY_FORWARD', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#lblBPTez2_5').text()), 'BPT_PG2 TAXABLE_INCOME', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#lblBPTez2_6').text()), 'BPT_PG2 TAX_DUE_NET', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#txtBPTez2_7a').val()), 'BPT_PG2 SALES_RENTAL', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#txtBPTez2_7b').val()), 'BPT_PG2 SERVICES', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#txtBPTez2_7c').val()), 'BPT_PG2 RENTAL_PROPERTY', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#txtBPTez2_7d').val()), 'BPT_PG2 ROYALTIES', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#txtBPTez2_7e').val()), 'BPT_PG2 CAPITAL_GAINS', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#txtBPTez2_7f').val()), 'BPT_PG2 STOCK_GAINS', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#txtBPTez2_7g').val()), 'BPT_PG2 DIVIDENDS', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#txtBPTez2_7h').val()), 'BPT_PG2 INTEREST', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#txtBPTez2_7i').val()), 'BPT_PG2 OTHER', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#lblBPTez2_8').text()), 'BPT_PG2 TAXABLE_SUBTOTAL_EZ_X', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#lblBPTez2_9').text()), 'BPT_PG2 STAT_EXCLUSION_EZ_X', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#lblBPTez2_10').text()), 'BPT_PG2 TAXABLE_GROSS_RCPTS', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#lblBPTez2_11').text()), 'BPT_PG2 TAX_DUE_GROSS', '', 0);

        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, '', 'DEBUG', '', 0);

    }//PopulateBPTezXML

    function RightAlignText() {
        //Page1
        $('#lblBPTez1_1').css("text-align", "right");
        $('#lblBPTez1_2').css("text-align", "right");
        $('#lblBPTez1_3').css("text-align", "right");
        $('#txtBPTez1_4').css("text-align", "right");
        $('#lblBPTez1_5').css("text-align", "right");
        $('#txtBPTez1_6a').css("text-align", "right");
        $('#txtBPTez1_6b').css("text-align", "right");
        $('#lblBPTez1_6c').css("text-align", "right");
        $('#lblBPTez1_7').css("text-align", "right");
        $('#txtBPTez1_8').css("text-align", "right");
        $('#lblBPTez1_9').css("text-align", "right");
        $('#txtBPTez1_10a').css("text-align", "right");
        $('#txtBPTez1_10b').css("text-align", "right");
        $('#txtBPTez1_10c').css("text-align", "right");
        //Page2
        $('#txtBPTez2_1').css("text-align", "right");
        $('#txtBPTez2_2').css("text-align", "right");
        $('#lbl_BPTez2_3').css("text-align", "right");
        $('#txtBPTez2_4').css("text-align", "right");
        $('#lblBPTez2_5').css("text-align", "right");
        $('#lblBPTez2_6').css("text-align", "right");
        $('#txtBPTez2_7a').css("text-align", "right");
        $('#txtBPTez2_7b').css("text-align", "right");
        $('#txtBPTez2_7c').css("text-align", "right");
        $('#txtBPTez2_7d').css("text-align", "right");
        $('#txtBPTez2_7e').css("text-align", "right");
        $('#txtBPTez2_7f').css("text-align", "right");
        $('#txtBPTez2_7g').css("text-align", "right");
        $('#txtBPTez2_7h').css("text-align", "right");
        $('#txtBPTez2_7i').css("text-align", "right");
        $('#lblBPTez2_8').css("text-align", "right");
        $('#lblBPTez2_9').css("text-align", "right");
        $('#lblBPTez2_10').css("text-align", "right");
        $('#lblBPTez2_11').css("text-align", "right");

        $('#txt_BPT_WSEZ1').css("text-align", "right");
        $('#lbl_BPT_WSEZ2').css("text-align", "right");
        $('#lbl_BPT_WSEZ3').css("text-align", "right");
        $('#lbl_BPT_WSEZ4').css("text-align", "right");
        $('#lbl_BPT_WSEZ4').css("text-align", "right");
        $('#lbl_BPT_WSEZ5').css("text-align", "right");
    }//RightAlignText

    function LoadBPTezError() {

        var txtTermDate = document.getElementById("txtTermDate");

        var txtBPTez1_4 = document.getElementById("txtBPTez1_4");
        var txtBPTez1_6a = document.getElementById("txtBPTez1_6a");
        var txtBPTez1_6b = document.getElementById("txtBPTez1_6b");
        var txtBPTez1_8 = document.getElementById("txtBPTez1_8");
        var txtBPTez1_10a = document.getElementById("txtBPTez1_10a");
        var txtBPTez1_10b = document.getElementById("txtBPTez1_10b");
        var txtBPTez1_10c = document.getElementById("txtBPTez1_10c");
        var txtBPTez2_1 = document.getElementById("txtBPTez2_1");
        var txtBPTez2_2 = document.getElementById("txtBPTez2_2");
        var txtBPTez2_4 = document.getElementById("txtBPTez2_4");
        var txtBPTez2_7a = document.getElementById("txtBPTez2_7a");
        var txtBPTez2_7b = document.getElementById("txtBPTez2_7b");

        var txtBPTez2_7c = document.getElementById("txtBPTez2_7c");
        var txtBPTez2_7d = document.getElementById("txtBPTez2_7d");
        var txtBPTez2_7e = document.getElementById("txtBPTez2_7e");
        var txtBPTez2_7f = document.getElementById("txtBPTez2_7f");
        var txtBPTez2_7g = document.getElementById("txtBPTez2_7g");
        var txtBPTez2_7h = document.getElementById("txtBPTez2_7h");
        var txtBPTez2_7i = document.getElementById("txtBPTez2_7i");
        var lblBPTez2_9 = document.getElementById("lblBPTez2_9");
        var txt_BPT_WSEZ1 = document.getElementById("txt_BPT_WSEZ1");       

        var i = 0;

        //Page1  Manoranjan
        arrBPTezErr[i++] = [txtBPTez1_4, 'ispNegativeNumber($(\'#txtBPTez1_4\').val()) == false', 'Value for question 4 must not be negative'];

        arrBPTezErr[i++] = [txtBPTez1_6a, ' $(\'#txtBPTez1_6a\').val() == ""', 'Answer question 6a'];
        arrBPTezErr[i++] = [txtBPTez1_6a, 'ispNegativeNumber($(\'#txtBPTez1_6a\').val()) == false', 'Value for question 6a must not be negative'];
        arrBPTezErr[i++] = [txtBPTez1_6b, '$(\'#txtBPTez1_6b\').val() == ""', 'Answer question 6b'];
        arrBPTezErr[i++] = [txtBPTez1_6b, 'ispNegativeNumber($(\'#txtBPTez1_6b\').val()) == false', 'Value for question 6b must not be negative'];
       
        arrBPTezErr[i++] = [txtBPTez1_10a, 'ispNegativeNumber($(\'#txtBPTez1_10a\').val()) == false', 'Value for question 10a must not be negative'];
        arrBPTezErr[i++] = [txtBPTez1_10b, 'ispNegativeNumber($(\'#txtBPTez1_10b\').val()) == false', 'Value for question 10b must not be negative'];
        arrBPTezErr[i++] = [txtBPTez1_10c, 'ispNegativeNumber($(\'#txtBPTez1_10c\').val()) == false', 'Value for question 10c must not be negative'];

        //Page2
        arrBPTezErr[i++] = [txtBPTez2_1, '$(\'#txtBPTez2_1\').val() == ""', 'Answer question 1'];
       
        arrBPTezErr[i++] = [txtBPTez2_2, ' $(\'#txtBPTez2_2\').val() == ""', 'Answer question 2'];
       
        arrBPTezErr[i++] = [txtBPTez2_4, '$(\'#txtBPTez2_4\').val() == ""', 'Answer question 4'];
        arrBPTezErr[i++] = [txtBPTez2_4, 'ispNegativeNumber($(\'#txtBPTez2_4\').val()) == false', 'Value for question 4 must not be negative'];
        arrBPTezErr[i++] = [txtBPTez2_7a, '$(\'#txtBPTez2_7a\').val() == ""', 'Answer question 7a'];
        arrBPTezErr[i++] = [txtBPTez2_7a, 'ispNegativeNumber($(\'#txtBPTez2_7a\').val()) == false', 'Value for question 7a must not be negative'];
        arrBPTezErr[i++] = [txtBPTez2_7b, '$(\'#txtBPTez2_7b\').val() == ""', 'Answer question 7b'];
        arrBPTezErr[i++] = [txtBPTez2_7b, 'ispNegativeNumber($(\'#txtBPTez2_7b\').val()) == false', 'Value for question 7b must not be negative'];
        arrBPTezErr[i++] = [txtBPTez2_7c, '$(\'#txtBPTez2_7c\').val() == ""', 'Answer question 7c'];
        arrBPTezErr[i++] = [txtBPTez2_7c, 'ispNegativeNumber($(\'#txtBPTez2_7c\').val()) == false', 'Value for question 7c must not be negative'];
        arrBPTezErr[i++] = [txtBPTez2_7d, '$(\'#txtBPTez2_7d\').val() == ""', 'Answer question 7d'];
        arrBPTezErr[i++] = [txtBPTez2_7d, 'ispNegativeNumber($(\'#txtBPTez2_7d\').val()) == false', 'Value for question 7d must not be negative'];
        arrBPTezErr[i++] = [txtBPTez2_7e, '$(\'#txtBPTez2_7e\').val() == ""', 'Answer question 7e'];
        arrBPTezErr[i++] = [txtBPTez2_7e, 'ispNegativeNumber($(\'#txtBPTez2_7e\').val()) == false', 'Value for question 7e must not be negative'];
        arrBPTezErr[i++] = [txtBPTez2_7f, '$(\'#txtBPTez2_7f\').val() == ""', 'Answer question 7f'];
        arrBPTezErr[i++] = [txtBPTez2_7f, 'ispNegativeNumber($(\'#txtBPTez2_7f\').val()) == false', 'Value for question 7f must not be negative'];
        arrBPTezErr[i++] = [txtBPTez2_7g, '$(\'#txtBPTez2_7g\').val() == ""', 'Answer question 7g'];
        arrBPTezErr[i++] = [txtBPTez2_7g, 'ispNegativeNumber($(\'#txtBPTez2_7g\').val()) == false', 'Value for question 7g must not be negative'];
        arrBPTezErr[i++] = [txtBPTez2_7h, '$(\'#txtBPTez2_7h\').val() == ""', 'Answer question 7h'];
        arrBPTezErr[i++] = [txtBPTez2_7h, 'ispNegativeNumber($(\'#txtBPTez2_7h\').val()) == false', 'Value for question 7h must not be negative'];
        arrBPTezErr[i++] = [txtBPTez2_7i, ' $(\'#txtBPTez2_7i\').val() == ""', 'Answer question 7i'];
        arrBPTezErr[i++] = [txtBPTez2_7i, 'ispNegativeNumber($(\'#txtBPTez2_7i\').val()) == false', 'Value for question 7i must not be negative'];
        arrBPTezErr[i++] = [lblBPTez2_9, ' $(\'#lblBPTez2_9\').text() == ""', 'Answer question 9'];
        arrBPTezErr[i++] = [lblBPTez2_9, 'ispNegativeNumber($(\'#lblBPTez2_9\').text()) == false', 'Value for question 9 must not be negative'];
        arrBPTezErr[i++] = [txt_BPT_WSEZ1, ' $(\'#txt_BPT_WSEZ1\').val() == ""', 'Answer question S1'];
        arrBPTezErr[i++] = [txt_BPT_WSEZ1, 'ispNegativeNumber($(\'#txt_BPT_WSEZ1\').val()) == false', 'Value for question S1 must not be negative'];
       

        i = 0;

        arrBPTezDateErr[i++] = [txtTermDate, '$(\'#txtTermDate\').val() != "" & ispValidateDate($(\'#txtTermDate\').val()) == false', 'Invalid termination date'];
    }//LoadBPTezError

    function btnBPTezPrint_onclick() {
        var currDisplayedObjId, lBPTez_pg2;

        lBPTez_pg2 = $('#BPTez_pg2').html();
        $('#btnBPTezPrint').css("visibility", "hidden");
        $('#btnBPTezSubmit').css("visibility", "hidden");
        $('#BPTez_pg2').css("page-break-before", "always");

        if ($('#BPTez_pg1').css("display", "block")) {
            currDisplayedObjId = 'BPTez_pg1';
            $('#BPTez_pg2').css("display", "block");
            $('#BPTez_WrkShtNE').css("display", "block");
        }
        else {
            currDisplayedObjId = 'BPTez_pg2';
            $('#BPTez_pg1').css("display", "block");
            $('#BPTez_WrkShtNE').css("display", "block");
        }

        $('#AppError').text('');
       // $('#BPTez_pg2').prepend($('#BPTezHeader').html() + '<BR>');

        if ($('#txtBPTez2_1').is(":disabled") == true) {
            //alert('True');
            //FieldLock(false);
            window.print();
            // BLOCK 1.1
            //SUMAN JQUERY html() METHOD CAN NOT COPY TEXT AREA VALUES WHEN IT TRY TO COPY INNERHTML FOR A DIV. 
            //SO VARIABLE lBPTez_pg2 IS A HTML WITHOUT TEXTBOX VALUES FROM PAGE2.
            //THIS CREATING PROBLEM AFTER PRINT BUTTON HIT AND IT TRIES TO RE INSERT ALL HTML TO PAGE 2
            //PRINT BUTTON USED IN OTHER RETURN FORMS DONT HAVE THIS LOGIC AND I FOUND NO HARM REMOVING IT FOR NOW. SO I AM DISABLING THIS LINE TO SOLVE PRINT ISSUE
            //HOWEVER ACTUAL SOLUTION IS POSSIBLE BUT WAY MORE COMPLEX. I WILL DO IF THIS CAUSE PROBLEM IN COME CASE AFTER TESTING.
            //$('#BPTez_pg2').html(lBPTez_pg2);
            //$('#BPTez_WrkShtN').html(lBPTez_WrkShtN);
            //----------------------------------------------------------------------------------------------------
           // FieldLock(true);
        }
        else {
           
            window.print();
           
        }

        $('#btnBPTezPrint').css("visibility", "visible");
        $('#btnBPTezSubmit').css("visibility", "visible");
       // $('#btnBPTezSubmit').removeAttr("disabled");
        if (currDisplayedObjId == 'BPTez_pg1') {
            $('#BPTez_pg2').css("display", "none");
            $('#BPTez_WrkShtNE').css("display", "none");
        }
        else {
            $('#BPTez_pg1').css("display", "none");
            $('#BPTez_WrkShtNE').css("display", "none");
        }
        return false;
       
    }   

    ///btnBPTezPrint_onclick

    function btnBPTezSubmit_onclick() {

        $("#AppError").text('');
        ValidateBPTezReturn();       
        if (cCur($('#txt_BPT_WSEZ1').val()) > cCur($("#lblBPTez2_8").text())) {
            if (cCur($('#txt_BPT_WSEZ1').val()) != 50000) {
                $("#AppError").text('S1 value must be lower of Line 8 of Page 2 or $50,000');
                resolvedIframeheight();
                parent.ScrollTop(1);
            }

        }

        if ($("#AppError").text() == "") {
            $("#AppError").text(ValidatePreparer());
            if (ValidatePreparer != '') {
                resolvedIframeheight();
                parent.ScrollTop(ValidatePreparer);
            }
        }

        if ($("#AppError").text() == "") {
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, '', 'BPT_INFO RETURN_STATUS', '', 0);
            PopulateBPTezXML();

            var ReqXML = parent.$g.xmlBPTez;
            $.ajax({
                type: 'POST',
                url: '../Returns/Log',
                data: '{ "OriginationFom" : "EZ-2014","ServiceName" : "RTTIE037","RequestXML" : "' + btoa(ReqXML.toString()) + '"}',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (msg) {

                }
            });
            var tempXML = parent.$g.getXmlDocObj();
            setTimeout(function () { }, 3000);
            ispCallXMLForm(parent.$g.xmlBPTez, tempXML, "BPTezReturn_2014", "");

            parent.$g.xmlBPTez = tempXML;
            var ResXML = parent.$g.xmlBPTez;
            $.ajax({
                type: 'POST',
                url: '../Returns/Log',
                data: '{ "OriginationFom" : "EZ-2014","ServiceName" : "RTTIE037","ResponseXML" : "' + btoa(ResXML.toString()) + '"}',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (msg) {

                }
            });


            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'ERROR_INFO PROGRAM', '', 0) == '') {
                $('#BPTez').css("display", "none");
                DisplayBPTezThankYou();
            }
            else {
                $("#AppError").text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'ERROR_INFO MESSAGE', '', 0));
            }
        }
    }//btnBPTezSubmit_onclick

    function ShowPage(iPage) {

        $('#BPTez_pg1').css('display', 'none');
        $('#BPTez_pg2').css('display', 'none');
        $('#BPTez_WrkShtNE').css('display', 'none');
        $('#lblLnkSchdN1').text('');
        $('#lblLnkSchdN2').text('');
        $('#BPT_19_3800').css('display', 'none');

        sPrevWrkSht = sCurrWrkSht

        if (iPage == 1) { sPrevWrkShtLine8 = '1'; } else { sPrevWrkShtLine8 = '0'; }      


        $("#AppError").text('');
        var FocusItem
        //Added for making the Line 8 disable, as when going from page 2 to page 1, this was called and the line8 gets enabled

        ValidateBPTezReturn();

        if (iPage == 2) {

            sCurrWrkSht = '2'
            $('#BPTez_pg2').css("visibility", "visible");
            $('#BPTez_pg2').css("display", "block");
            resolvedIframeheight();
            //$('#btnBPTezSubmit').removeAttr("disabled");           

            //Sangha
            if (sPrevWrkSht == 'WrkShtN') {
                $('#btn2GoTo').val('Return to Worksheet N');
                $('#btn2GoTo').click(Function('ShowPage("WrkShtN");'));
            } else {

                $('#btn2GoTo').val('Return to Page 1');

                $('#btn2GoTo').click(Function('ShowPage("Pg1");'));
            } 	//if

            DisplayNetIncome();
        } else if (iPage == '3800') {
            sCurrWrkSht = '3800'
            $('#BPT_19_3800').css('display', 'block');
        } else if (iPage == 'WrkShtN') {
            sCurrWrkSht = 'WrkShtN'
            DisplayWrkShtN()
            resolvedIframeheight();
        } else {
            sCurrWrkSht = '1'

            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_INFO RETURN_STATUS', '', 0) == 'A1' || parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_INFO RETURN_STATUS', '', 0) == 'A2') {
                //SUMAN : AS PER REQUIREMENT DICUSSED ON 29TH JAN 2014, CLIENT DONT WANT SCHEDULE N LINK IF USER CHOSE YES OPTION
                if ($("#btnYes").is(":checked") == false) {
                    $('#lblLnkSchdN1').html('<label class="lblInstrNormal"> or </label>' +
                            '<label class="lblLink" style="FONT-SIZE: 7pt" onclick=ShowPage("WrkShtN")> Worksheet N, Line 2</label>');
                    $('#lblLnkSchdN2').html('<label class="lblInstrNormal"> or </label>' +
                            '<label class="lblLink" style="FONT-SIZE: 7pt" onclick=ShowPage("WrkShtN")> Worksheet N, Line 4</label>');
                }
            } 	//if
            if (sPrevWrkSht == '2') {
                debugger;
                if ($('#btnYes').is(':checked') == true) {
                    $('#lblBPTez1_1').text(ispFormatMoney(0, 0));
                    $('#lblBPTez1_2').text(ispFormatMoney(0, 0));
                } else {
                    $('#lblBPTez1_1').text($('#lblBPTez2_6').text());
                    $('#lblBPTez1_2').text($('#lblBPTez2_11').text());
                } //if

            } else if (sPrevWrkSht == 'WrkShtN') {
                DisplayWrkShtN();
              
            } 	//if	
            // Added to solve Schedule N issue by chayan on 19/03/2013		
            CalcPage1Line3();
            CalcPage1Line5();
            CalcPage1Line6c();
            CalcPage1Line7();
            //Added for making the Line 8 disable, as when going from page 2 to page 1, this was called and the line8 gets enabled

            CalcPage1Line9_10();

            //-------------------------------------------
            $('#BPTez_pg1').css("display", "block");
            $('#BPTez_pg1').css("visibility", "visible");          
        }
        resolvedIframeheight();
        //if
    }//ShowPage
    //Termination Date
    function txtTermDate_onblur() {
        if ($("#AppError").text() == "" && $('#txtTermDate').val() != '') {

            var strBD = ispValidateDate($('#txtTermDate').val());

            if (strBD == false) {
                $("#AppError").text('Invalid termination date');               
                blnErr = true;
            }
            else {
               
                $('#txtTermDate').val(strBD);
            }
        }
       
    }

    function chkAmended_onclick() {

        if ($('#chkAmended').is(':checked')) {           

            $('#btnYes').attr('checked', false);
            $('#btnNo').attr('checked', false);
            
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_INFO RETURN_STATUS', '', 0) == 'A1' || parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_INFO RETURN_STATUS', '', 0) == 'A2') {
             
                $('#BPTez_pg2').css("visibility", "hidden");
                $('#BPTez_pg2').css("display", "none");
                $('#BPT_19_3800').css('display', 'block');
                FieldLock(false);
                ClearPreparer();
                //if
            } else {

                $('#btnBPTezSubmit').removeAttr("disabled");
                FieldLock(false);
                ClearPreparer();
                if ($('#BPTez_pg1').css('display') == 'block') {
                  
                }
                else {
                    DisplayNetIncome();
                }
            }
        }
        else {
           
            $('#BPT_19_3800').css('display', 'none');
            PopulateBPTezData();
            $('#btnBPTezSubmit').attr("disabled", "disable");
            FieldLock(true);
            PopulatePreparer(parent.$g.xmlBPTez, 'BPT_INFO');
        }
    }//chkAmended_onclick

    function LocatePrimaryAddr() {
        var iMaxIdx = parent.$x.ispXmlGetRecCount(parent.$g.xmlAccount, 'NAME_ADDRESS', '');
        for (idx = 0; idx < iMaxIdx; i++) {
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS_TYPE', '', idx) == '60') {
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS RELATIONSHIP_CODE', '', idx) == '0') {
                    return idx;
                }
            }
            else {
                return 0;
            }
        }
    }//locatePrimaryAddr

    

    function getActiveElement() {
        var obj = document.activeElement;
       
        var evt = window.event || arguments.callee.caller.caller.arguments[0];
        var source = parent.getEventSource(evt);
       
        return source;
    }

    function SetFocus() {
        $(getActiveElement()).select();
    }

    function ValidateBPTezMethod() {
        var sRadioName = 'radBPTez2_1_2';
        var sRadioId = getActiveElement().id;


        if ($(getActiveElement()).attr("name") == sRadioName) {
            if (sRadioId == sRadioName + '_m1') {
                $('#txtBPTez2_1').removeAttr("disabled");
                $('#txtBPTez2_1').val(ispFormatMoney(0, 0));
                $('#txtBPTez2_1').attr("disabled", "disable");
                $('#txtBPTez2_2').removeAttr("disabled");
                $('#txtBPTez2_2').focus();
            }
            else {
                $('#txtBPTez2_2').removeAttr("disabled");
                $('#txtBPTez2_2').val(ispFormatMoney(0, 0));
                $('#txtBPTez2_2').attr("disabled", "disable");
                $('#txtBPTez2_1').removeAttr("disabled");
                $('#txtBPTez2_1').focus();
            }

            ValidateBPTezReturn();
        }
    }//ValidateBPTezMethod
    function ValidateBPTezDate() {
        $("#AppError").text('');
        $("#AppError").text(ispSetInputErr1(arrBPTezDateErr));
        if ($("#AppError").text() != '') {
            resolvedIframeheight();
            parent.ScrollTop(arrBPTezDateErr);
        }
    }
    function ValidateBPTezReturn() {
       
        var ObjSelected = getActiveElement();

        $("#AppError").text(ispSetInputErr_Form(arrBPTezErr));
        if ($("#AppError").text() == "") {
            //this validation should not run for buttons as because it will try to change button text then
            if (ObjSelected != undefined || ObjSelected != null) {
                if (ObjSelected.type != 'button') {

                    ObjSelected.value = ispFormatMoney(ObjSelected.value, 0);

                }
            }

            CheckPage2Line4();
            CalcPage2Line5();
            CalcPage2Line6(dBPTezNetRate);
            CalcPage2Line8();
            CalcPage2Line9();
            CalcPage2Line10();
            CalcPage2Line11(dBPTezGrossRate);
            CalcPage1Line3();
            CalcPage1Line5();
            CalcPage1Line6c();
            CalcPage1Line7();
            CalcPage1Line9_10();
            PerformCalcsBPTezWrkShtN();
           
            $('#lbl1forpage2').css('cursor', 'hand');
            $('#lbl1forpage2').css('color', '#de0000');
            $('#lbl1forpage2').click(function () {
                ShowPage(2);
            });


            $('#lbl2forpage2').css('cursor', 'hand');
            $('#lbl2forpage2').css('color', '#de0000');
            $('#lbl2forpage2').click(function () {
                ShowPage(2);
            });
        }
        else {
            //
            $('#lbl1forpage2').attr('onclick', '').unbind('click');
            $('#lbl1forpage2').css('cursor', 'default');
            $('#lbl1forpage2').css('color', 'gray');

            $('#lbl2forpage2').attr('onclick', '').unbind('click');
            $('#lbl2forpage2').css('cursor', 'default');
            $('#lbl2forpage2').css('color', 'gray');
            //Sanghamitra

            $('#lblBPTez2_7').text(ispFormatMoney(0, 0));//("$0");
            resolvedIframeheight();
            parent.ScrollTop(1);
        }

        GoToPage1Button();
    }//ValidateBPTezReturn
    function PerformCalcs() {
        CheckPage2Line4();
        CalcPage2Line5();
        CalcPage2Line6(dBPTezNetRate);
        CalcPage2Line8();
        CalcPage2Line9();
        CalcPage2Line10();
        CalcPage2Line11(dBPTezGrossRate);
        CalcPage1Line3();
        CalcPage1Line5();
        CalcPage1Line6c();
        CalcPage1Line7();
        CalcPage1Line9_10();
        PerformCalcsBPTezWrkShtN();      
        $('#lbl1forpage2').css('cursor', 'hand');
        $('#lbl1forpage2').css('color', '#de0000');
        $('#lbl1forpage2').click(function () {
            ShowPage(2);
        });


        $('#lbl2forpage2').css('cursor', 'hand');
        $('#lbl2forpage2').css('color', '#de0000');
        $('#lbl2forpage2').click(function () {
            ShowPage(2);
        });
    }
    function GoToPage1Button() {
       
        var iIncomeTaxDue = cCur($('#lblBPTez2_5').text());//.replace('$', '');
        var iReceiptTaxDue = cCur($('#lblBPTez2_8').text());//.replace('$', '');     
        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_INFO PREPARER_NAME ', "", 0) == 0 && iReceiptTaxDue == 0)//added this if block to disable the "go to page1" button in case of fresh form and it wont get activated untill there is value in Page1, line 7 
        {
           
        }
        else {
            if (iIncomeTaxDue > 0 && iReceiptTaxDue == 0) {              

            }
            else {

                $('#mnuBPTezYear06Page1', parent).removeAttr("disabled");
                $('#btnGoToPage1').removeAttr("disabled");                
                $('#lblPage1Disabled').text('');
            }
        }
    }//GoToPage1Button

    function CheckPage2Line4() {
        var BPTStartDate;
        iCount = parent.$x.ispXmlGetRecCount(parent.$g.xmlAccount, 'TAX_ACCT', '');
        if ($('#txtBPTez2_4').val() != ispFormatMoney(0, 0).toString()) {
            for (i = 0; i < iCount; i++) {
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '', i) == '24') {
                    BPTStartDate = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'TAX_ACCT START_DATE', '', i)
                    if (new Date(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'TAX_ACCT START_DATE', '', i)) >= new Date("01/01/2014")) {
                        $('#txtBPTez2_4').val(ispFormatMoney(0, 0));//'$0';
                        alert('This return is not eligible for Loss Carry Forward, because your BPT Start Date '
                             + BPTStartDate
                             + ' is on or after 01/01/2014. Loss Carry Forward (Page 2, question #4) has been set to zero.');
                    }
                }
            }
        }
    }

    function BirtEz_3800(btnClicked) {
        if ($('#div19_3800Msg').html() != '') {
            tmpHtml = $('#div19_3800Msg').html();
          
            $('#divMsg19_3800').html(tmpHtml);
        } 	//if

        if (btnClicked == null) {
            //loading time, do nothing
        }
        else if (btnClicked.id == $('#btnYes').attr('id')) {
            b3800val = true;
            $('#btnYes').attr('checked', true);
            $('#btnNo').attr('checked', false);
        } else {
            b3800val = false;
            $('#btnNo').attr('checked', true);
            $('#btnYes').attr('checked', false);
        } 	//if

        if ($('#BPTez_WrkShtNE').css('display') == 'none') {
            ShowPage('2');
        } else {
            if (btnClicked == null) {
                //loading time, do nothing
            }
            else if (btnClicked.id == $('#btnYes').attr('id')) {		//Yes Radio Clicked
                b3800val = true;
                $('#btnYes').attr('checked', 'checked');
                $('#btnYes').attr('checked', true);
                $('#btnNo').attr('checked', false);
            } else {		//No Radio Clicked
                b3800val = false;
                $('#btnNo').attr('checked', 'checked');
                $('#btnNo').attr('checked', true);
                $('#btnYes').attr('checked', false);
            } 	//if
            PerformCalcsBPTezWrkShtN()
        } 	//if
    } 	//12BirtLf_3800


    function cCur(value) {
        return ispRemoveMoney(value);
    }

    function CalcPage2Line5() {
        if ($('#radBPTez2_1_2_m2').is(":checked") == true) {
            var BPTez2_1 = cCur($('#txtBPTez2_1').val());
            var BPTez2_3 = cCur($('#lbl_BPTez2_3').text());
            var BPTez2_4 = cCur($('#txtBPTez2_4').val());
            $('#lblBPTez2_5').text(ispFormatMoney(BPTez2_1 - BPTez2_3 - BPTez2_4, 0));
        }

        if ($('#radBPTez2_1_2_m1').is(":checked") == true) {
            var BPTez2_2 = cCur($('#txtBPTez2_2').val());
            var BPTez2_3 = cCur($('#lbl_BPTez2_3').text());
            var BPTez2_4 = cCur($('#txtBPTez2_4').val());
            $('#lblBPTez2_5').text(ispFormatMoney(BPTez2_2 - BPTez2_3 - BPTez2_4, 0));
        }
        var dvalue = ispRemoveMoney($('#lblBPTez2_5').text());
      
    }

    function CalcPage2Line6(dTax) {
        if (isNaN(dTax)) {
            dTax = 0.0643;
        }

        if ($('#lblBPTez2_5').text() != "") {
            if (cCur($('#lblBPTez2_5').text()) < 0) {
                $('#lblBPTez2_6').text(ispFormatMoney(0, 0));
            }
            else {
                var BPTez2_4 = cCur($('#lblBPTez2_5').text());
                $('#lblBPTez2_6').text(ispFormatMoney(BPTez2_4 * dTax, 0));
            }
           
            $('#lblBPTez1_1').text($('#lblBPTez2_6').text());
        }
    }

    function CalcPage2Line8() {

        if ($('#txtBPTez2_7a').val() != "" && $('#txtBPTez2_7b').val() != "" && $('#txtBPTez2_7c').val() != "" &&
             $('#txtBPTez2_7d').val() != "" && $('#txtBPTez2_7e').val() != "" && $('#txtBPTez2_7f').val() != "" &&
             $('#txtBPTez2_7g').val() != "" && $('#txtBPTez2_7h').val() != "" && $('#txtBPTez2_7i').val() != "") {
           

            var totalAmtBPTez2_6 =
            cCur($('#txtBPTez2_7a').val()) +
            cCur($('#txtBPTez2_7b').val()) +
            cCur($('#txtBPTez2_7c').val()) +
            cCur($('#txtBPTez2_7d').val()) +
                        cCur($('#txtBPTez2_7e').val()) +
                        cCur($('#txtBPTez2_7f').val()) +
                        cCur($('#txtBPTez2_7g').val()) +
                        cCur($('#txtBPTez2_7h').val()) +
                        cCur($('#txtBPTez2_7i').val());

            $('#lblBPTez2_8').text(ispFormatMoney(totalAmtBPTez2_6, 0));
            $('#lblBPTez2_9').text(ispFormatMoney(totalAmtBPTez2_6, 0));
            if (cCur($('#lblBPTez2_9').text()) > 50000) {
                $('#lblBPTez2_9').text(ispFormatMoney(50000, 0));

            }
            debugger;
            CalcPage2Line5();
            CalcPage2Line6(dBPTezNetRate);
        }
        if (cCur($('#lblBPTez2_5').text()) > 0 && cCur($('#lblBPTez2_8').text()) == 0) {
            $("#AppError").text("Page 2, Line 8 can not be zero, if Line 5 is greater than zero."); //SUMAN
        }
        else {
            $("#AppError").text("");
        }
    }
    function CalcPage2Line9() {

        if (cCur($('#lblBPTez2_9').text()) > cCur($("#lblBPTez2_8").text())) {
            if (cCur($('#lblBPTez2_9').text()) != 50000) {
                $("#AppError").text('Line 9 value must be lower of Line 8 or $50,000');
                resolvedIframeheight();
                parent.ScrollTop(1);
            }

        }
    }
    function CalcPage2Line10() {
        if ($('#lblBPTez2_9').text() != '' && $("#lblBPTez2_8").text() != '') {
            var subtemp = cCur($("#lblBPTez2_8").text()) - cCur($('#lblBPTez2_9').text());
            $('#lblBPTez2_10').text(ispFormatMoney(subtemp, 0));
        }
        else {
            $('#lblBPTez2_10').text(ispFormatMoney(0, 0));
        }
    }
    function CalcPage2Line11(dTax) {
        if (isNaN(dTax)) {
            dTax = 0.001415;
        }

        if ($('#lblBPTez2_10').text() != "") {
            $('#lblBPTez2_11').text(ispFormatMoney(cCur($('#lblBPTez2_10').text()) * dTax, 0));
          
            $('#lblBPTez1_2').text($('#lblBPTez2_11').text());  
        }
    }

    function CalcPage1Line3() {
        if ($('#lblBPTez1_1').text() != "" && $('#lblBPTez1_2').text() != "") {
            $('#lblBPTez1_3').text(
            ispFormatMoney(
            cCur($('#lblBPTez1_1').text()) + cCur($('#lblBPTez1_2').text()),
            0)
            );
        }

        var bptPage1_Actual_Tax = parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, "BPT_PG1 ACTUAL_TAX", "", 0);
        if ($('#lblBPTez1_3').text() != bptPage1_Actual_Tax) {
            $('#txtBPTez1_4').val(ispFormatMoney(cCur($('#lblBPTez1_3').text()), 0));
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, $('#lblBPTez1_3').text(), "BPT_PG1 ACTUAL_TAX", "", 0);
        }

        if (cCur($('#lblBPTez1_3').text()) != 0 && cCur($('#txtBPTez1_4').val()) == 0) {
            $("#AppError").text("The line 4 can not be 0 if line 3 has a value.");
            $('#txtBPTez1_4').attr("class", "inpError");
            $('#txtBPTez1_4').focus();
        }
       
    }

    function CalcPage1Line5() {
        if ($('#lblBPTez1_3').text() != "" && $('#txtBPTez1_4').val() != "") {
            $('#lblBPTez1_5').text(ispFormatMoney(
            cCur($('#lblBPTez1_3').text()) +
            cCur($('#txtBPTez1_4').val()), 0));
        }
    }

    function CalcPage1Line6c() {
        if ($('#txtBPTez1_6a').val() != "" && $('#txtBPTez1_6b').val() != "") {
            $('#lblBPTez1_6c').text(ispFormatMoney(
            cCur($('#txtBPTez1_6a').val()) + cCur($('#txtBPTez1_6b').val()), 0));
        }
    }

    function CalcPage1Line7() {
        if ($('#lblBPTez1_5').text() != "" && $('#lblBPTez1_6c').text() != "") {
            $('#lblBPTez1_7').text(ispFormatMoney(cCur($('#lblBPTez1_5').text()) - cCur($('#lblBPTez1_6c').text()), 0));
        }
    }

    function CalcPage1Line9_10() {

        if ($('#lblBPTez1_7').text() != "" && $('#txtBPTez1_8').val() != "") {
            $('#lblBPTez1_9').text(ispFormatMoney(cCur($('#lblBPTez1_7').text()) + cCur($('#txtBPTez1_8').val()), 0));
        }
     
        //if (mbFirstTime) {
        //    $('#txtBPTez1_8').removeAttr("disabled");
        //} else {
        //    $('#txtBPTez1_8').attr("disabled", "disabled");
        //}


        if (cCur($('#lblBPTez1_9').text()) < 0) {
            $('#txtBPTez1_8').attr("disabled", "disabled");
            if ($('#txtBPTez1_10a').val() == "") {
                $('#txtBPTez1_10a').val(ispFormatMoney(0, 0));
            }

            if ($('#txtBPTez1_10b').val() == "") {
                $('#txtBPTez1_10b').val(ispFormatMoney(0, 0));
            }

            if ($('#txtBPTez1_10c').val() == "") {
                $('#txtBPTez1_10c').val(ispFormatMoney(0, 0));
            }
            var totalBPTez1_10Amount = cCur($('#txtBPTez1_10a').val()) + cCur($('#txtBPTez1_10b').val()) + cCur($('#txtBPTez1_10c').val());
            if (totalBPTez1_10Amount != Math.abs(cCur($('#lblBPTez1_7').text()))) {
                if ($('#BPTez_pg1').css('display') == 'block') {
                    $("#AppError").text("Lines 10a, 10b and 10c must equal Line 7.");
                    $('#txtBPTez1_10a').attr('class', 'inpError form-control input-sm pull-right');
                    $('#txtBPTez1_10b').attr('class', 'inpError form-control input-sm pull-right');
                    $('#txtBPTez1_10c').attr('class', 'inpError form-control input-sm pull-right');
                    resolvedIframeheight();
                    parent.ScrollTop(1);
                }
                else {
                    $('#txtBPTez1_10a').attr('class', 'inpNormal form-control input-sm pull-right');
                    $('#txtBPTez1_10b').attr('class', 'inpNormal form-control input-sm pull-right');
                    $('#txtBPTez1_10c').attr('class', 'inpNormal form-control input-sm pull-right');
                }
            }
            else {
                $('#txtBPTez1_10a').attr('class', 'inpNormal form-control input-sm pull-right');
                $('#txtBPTez1_10b').attr('class', 'inpNormal form-control input-sm pull-right');
                $('#txtBPTez1_10c').attr('class', 'inpNormal form-control input-sm pull-right');
            }

            $('#lblBPTez1_9').text(ispFormatMoney(0, 0));
        }
        else {
            $('#txtBPTez1_10a').attr('class', 'inpNormal form-control input-sm pull-right');
            $('#txtBPTez1_10b').attr('class', 'inpNormal form-control input-sm pull-right');
            $('#txtBPTez1_10c').attr('class', 'inpNormal form-control input-sm pull-right');
            $('#txtBPTez1_10a').val(ispFormatMoney(0, 0));
            $('#txtBPTez1_10b').val(ispFormatMoney(0, 0));
            $('#txtBPTez1_10c').val(ispFormatMoney(0, 0));
        }
    }
</script>
</head>
<body>
    <div class="container-fluid no-padding" id="BPTez" style="DISPLAY: none;">

        <div class="block3">

            <div class="container-fluid">

                <div class="row">               
                 <div class="col-lg-12 col-md-12" id="tab1" style="display: block;">
            <div class="blue_base_box">
           
                 <h2>Taxpayer Information  |   <span id="AppHeader"></span>  </h2>
                <div class="inner_white-panel">
                      <div class="col-lg-12 col-lg-offset-0 no-padding-left">
                                                  <div id="AppError" class="errormsg no-padding" style="display:block; margin-bottom:0 !important;">
                                                   </div>
                                                     </div>  
                     <div class="clearfix"></div>   
                <div class="contentsection">
                    <h4 id="AppMessage">&nbsp;</h4>
                    <div class="clearfix"></div>
                    
                    <div class="row">

                        <div class="col-lg-12">
                         <%-- Address Start--%>
                              <div class="well" style="padding:7px !important; margin-bottom:2px !important;">
                                                <div class="row">
                                                    <form>
                                                        <div class="col-lg-9 col-md-9 col-sm-9 col-xs-8">
                                                            <p style="margin-bottom:0 !important;">
                                                                <span>Name:</span>
                                                                <span id="lblName" class=""></span>
                                                            </p>
                                                        </div>

                                                        <div class="col-lg-3 col-md-3 col-sm-3 col-xs-4">
                                                            <p style="margin-bottom:0 !important;">
                                                                <span id="lblAccountType">Account No.:</span>
                                                                <span id="lblAccountId" class=""></span>
                                                            </p>
                                                        </div>

                                                    </form>
                                                </div>

                                                <div class="row">
                                                    <div class="col-lg-9 col-md-9 col-sm-9 col-xs-8">
                                                        <p style="margin-bottom:0 !important;">
                                                            <span>Address:</span>
                                                            <span id="lblAddress" class=""></span>
                                                        </p>
                                                    </div>
                                                    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-4">
                                                        <p style="margin-bottom:0 !important;">
                                                            <span id="lblEntityType">EIN:</span>
                                                            <span id="lblEntityId" class=""></span>
                                                        </p>
                                                    </div>
                                                </div>
                                                <div class="clearfix"></div>

                                            </div>  
                              <%--  Adress End--%>     
                                             
                             <div class="row">
                                  <div class="col-lg-12 templateclass">

                               <form class="form-horizontal school_form">

                               
                                          <div class="row">
                            <div class="col-lg-12 no-padding">
                       <%-- <div class="col-lg-4 newtop_padding col-sm-12">
                            <label class="no-padding" style="font-weight: bold;">
                               <input id=chkChangeAddress type="checkbox"> &nbsp;If this is a change of address, check this box.</label>
                        </div> --%>                     
                       
                         </div>
                        </div>
                             
                        <div class="row">
                            <div class="col-lg-12 no-padding">
                        <div class="col-lg-3 newtop_padding col-sm-12">
                            <label class="no-padding" style="font-weight: normal;">
                                <input id=chkAmended type=checkbox onclick="chkAmended_onclick()"  />
                                        Check if amended return.</label>
                        </div>
                        <div class="col-lg-7 col-sm-12" style="display:none">
                            <label class="control-label text-custom-left2 no-padding" for="inputEmail3">
                                <span class="custom_padding_span"> If your business terminated in 2014, enter the termination date AND file a CHANGE FORM. 
                                    
                                 </span>
                                </label>
                        </div>
                        <div class="col-lg-2 col-sm-12" style="display:none">
                             <input class="inpNormal_custom date-input date-field-design" placeholder="MM/DD/YYYY" style="WIDTH: 70%;" id="txtTermDate" onchange="ValidateBPTezDate()" maxlength="10" onfocus="SetFocus()" onblur="return txtTermDate_onblur()">
                           
                        </div>
                                </div>
                          
                        </div>
                                                     
                              </form>

                            <div style="DISPLAY:none" Id="BPTez_pg1" Name="BPTez_pg1">

                            <div class="row">
                             <div class="col-lg-12" >

                                <table summary="Employee Pay Sheet" class="table table-condensed table-striped custom_table03 wage-table-print">
                                    <thead>
                                        	<tr>
                                            	<th colspan="3" width="100%" style="font-size:12px !important;">COMPUTATION OF TAX DUE OR OVERPAYMENT</th>
                                       
                                            </tr>

                                        </thead>
                                    <tbody>

                                        <tr>
                                             <td width="5%">1.</td>
                                            <td width="70%" class="text-left"> Net Income Portion Of Tax- 
                                            <label id="lbl1forpage2" class="lblLink label_NoLeft" style="" onclick=ShowPage(2)>Click here for Page 2 </label>
			                                <label id="lblLnkSchdN1" style="display:none"></label></td>                                          
                                            <td width="25%" class="text-left">
                                            <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class=""> 
                                                        <label id="lblBPTez1_1" class="form-control input-sm pull-right" style="WIDTH: 90%"></label>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                        </tr>
                                        <tr>
                                              <td width="5%">2.</td>
                                            <td width="70%" class="text-left"> Gross Receipts Portion Of Tax- 
                                                <label id="lbl2forpage2" class="lblLink label_NoLeft" style="" onclick=ShowPage(2)>Click here for Page 2 </label>
			                                    <label id="lblLnkSchdN2" style="display:none"></label>
                                            </td>
                                            <td width="25%" class="text-left">
                                                 <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                        <label id="lblBPTez1_2" class="form-control input-sm pull-right" style="WIDTH: 90%"></label>
                                                    </div>
                                                </div>
                                            </div>                                             	

                                            </td>
                                        </tr>
                                        <tr>
                                             <td width="5%">3.</td>
                                            <td width="70%" class="text-left"> Tax Due for the 2014 Business Income & Receipts Tax [Calculated - add lines 1 and 2]  </td>
                                            <td  width="25%" class="text-left">
                                                 <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                        <label id="lblBPTez1_3" class="form-control input-sm pull-right" style="WIDTH: 90%"></label>
                                                    </div>
                                                </div>
                                            </div>  
                                             
                                            </td>
                                        </tr>
                                        <tr>
                                             <td width="5%">4.</td>
                                            <td width="70%" class="text-left"> <B><U>MANDATORY</U> 2015 BIRT Estimated Payment <u>(repeat line 3)</u></B></td>
                                            <td width="25%" class="text-left">                                               
                                                 <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                        	<input type="text" class="form-control input-sm pull-right" id="txtBPTez1_4" style="WIDTH: 90%" onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength="10" />
                                                    </div>
                                                </div>
                                            </div>  
                                            </td>
                                        </tr>
                                        <tr>
                                             <td width="5%">5.</td>
                                            <td width="70%" class="text-left"> Total Due by <B>4/15/2015</B>[Calculated - add lines 3 and 4] </td>
                                            <td width="25%" class="text-left">                                             
                                                 <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                        	 <label id="lblBPTez1_5" class="form-control input-sm pull-right" style="WIDTH: 90%"></label>
                                                    </div>
                                                </div>
                                            </div>  
                                            </td>
                                        </tr>
                                        </tbody>
                                        
                                       <thead>
                                        	<tr>
                                            	<th colspan="3" width="100%" style="font-size:12px !important;">ESTIMATED PAYMENTS AND OTHER CREDITS</th>
                                       
                                            </tr>

                                        </thead>
                                        
                                        <tbody>
                                      
                                        <tr>
                                             <td width="5%">6a.</td>
                                            <td width="70%" class="text-left"> Credit from overpayment of 2013 or 2014 Net Profit Tax </td>
                                            <td width="25%" class="text-left">                                             
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                        <input type="text" class="form-control input-sm pull-right" style="WIDTH: 90%" id="txtBPTez1_6a" onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength="10" />
                                                    </div>
                                                </div>
                                            </div>  
                                            </td>
                                        </tr>
                                        <tr>
                                             <td width="5%">6b.</td>
                                            <td width="70%" class="text-left"> Include any estimated and/or extension payments of 2014 BIRT previously
			  made,<br>and any credit from overpayment of the 2013 BPT return </td>
                                            <td width="25%" class="text-left">                                               	
                                                 <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                    <input type="text" class="form-control input-sm pull-right" id="txtBPTez1_6b" style="WIDTH: 90%" onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength="10" />
                                                    </div>
                                                </div>
                                            </div>  
                                            </td>
                                        </tr>
                                        <tr>
                                             <td width="5%">6c.</td>
                                            <td width="70%" class="text-left"> Total Payments and Credits [Calculated - add lines 6a and 6b] </td>
                                            <td width="25%" class="text-left">                                            
                                                 <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                    <label id="lblBPTez1_6c" class="form-control input-sm pull-right" style="WIDTH: 90%"></label>
                                                    </div>
                                                </div>
                                            </div>  
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="5%">7.</td>
                                            <td width="70%" class="text-left"> Net Tax Due[Calculated - line 5 minus 6c]</td>
                                            <td width="25%" class="text-left">                                                
                                                 <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                   <label id="lblBPTez1_7" class="form-control input-sm pull-right" style="WIDTH: 90%"></label>
                                                    </div>
                                                </div>
                                            </div>  
                                            </td>
                                        </tr>
                                        <tr>
                                             <td width="5%">8.</td>
                                            <td width="70%" class="text-left"> Interest and Penalty <a href="https://beta.phila.gov/services/payments-assistance-taxes/paying-city-taxes/interest-penalties-and-fees/" target="_blank" style="color:red">(see Instruction)</a></td>
                                            <td width="25%" class="text-left">                                            
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                   <input class="form-control input-sm pull-right" style="WIDTH: 90%" id="txtBPTez1_8" />
                                                    </div>
                                                </div>
                                            </div>  
                                            </td>
                                        </tr>
                                        <tr >
                                            <td width="5%">9.</td>
                                            <td width="70%" class="text-left"> <B><u>TOTAL DUE</u></B> including Interest and Penalty (Line 7 plus Line 8). <br/><B>Use payment coupon. Make check payable to: "City of Philadelphia"</B></td>
                                            <td width="25%" class="text-left">                                              
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                    <label id="lblBPTez1_9" class="form-control input-sm pull-right" style="WIDTH: 90%" ></label>
                                                    </div>
                                                </div>
                                            </div>  
                                            </td>
                                        </tr>
                                      
                                             </tbody>
                                        
                                        <thead>
                                        	<tr>
                                            	<th colspan="3" width="100%" style="font-size:12px !important;">OVERPAYMENT OPTIONS</th>
                                       
                                            </tr>

                                        </thead>
                                        
                                        <tbody>
                                        <tr >
                                             <td width="5%">10a.</td>
                                            <td width="70%" class="text-left"> Refunded. <b>Do not file separate Refund Petition</b></td>
                                            <td width="25%" class="text-left">                                              
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                    <input type="text" class="form-control input-sm pull-right" style="WIDTH: 90%" id="txtBPTez1_10a" onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength="10" />
                                                    </div>
                                                </div>
                                            </div>  
                                            </td>
                                        </tr>
                                        <tr>
                                             <td width="5%">10b.</td>
                                            <td width="70%" class="text-left">Applied, up to the tax due,	to the 2014 Net Profits Tax Return</td>
                                            <td width="25%" class="text-left">                                               
                                                 <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                    <input type="text" class="form-control input-sm pull-right" style="WIDTH: 90%" id="txtBPTez1_10b" onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength="10" />
                                                    </div>
                                                </div>
                                            </div>  
                                                </td>
                                        </tr>
                                        <tr>
                                             <td width="5%">10c.</td>
                                            <td width="70%" class="text-left"> &nbsp; Applied to the 2015	Business Income & Receipts Tax</td>
                                            <td width="25%" class="text-left">                                              
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                     <input type="text" class="form-control input-sm pull-right" style="WIDTH: 90%" id="txtBPTez1_10c" onchange="ValidateBPTezReturn()"	onfocus="SetFocus()" maxlength="10"/>
                                                    </div>
                                                </div>
                                            </div>  
                                            </td>
                                        </tr>                                            
                                       
                                    </tbody>
                                    
                                </table>
                                <div class="clear"></div>
                               </div>

                            </div>

                           <form class="form-horizontal form-year-background" style="padding:5px !important;">
                           <div > 
                               <%Html.RenderAction("PreparerSection", "INC");%>

                           </div>
                            <div class="form-group page-print-wage-section">
                              <div class="col-sm-offset-3 col-sm-9  text-right">
                                  
                                <input type="button" value="Print" class="btn btn-default submit_button_light" onclick="return btnBPTezPrint_onclick()" id="btnBPTezPrint"/>
                                <input type="button" value="Submit" class="btn btn-default submit_button" id="btnBPTezSubmit" onclick="return btnBPTezSubmit_onclick()" />
                            </div>
                            </div>

                                                                                <div class="clearfix"></div>     
                                                 <div class="col-md-12">
                                                    <div style="margin-left: 5px; font-size: 12px; font-family:opensans-regular;" class="here_input_table sit_here_input_table">
                                                        <label>
                                                            Note: DO NOT FILE THIS RETURN if you have no taxable activity. If you registered for 
				this tax and you no longer have taxable activity, complete a <a href="https://beta.phila.gov/media/20170207132309/Change-Form.pdf" target="_blank">Change Form</a>  to cancel your account.</label>
                                                    </div>
                                                     </div>

                            </form>   
                                <div class="clearfix"></div> 
                          </div>

                         <%--  Page 2--%>
                         <div style="DISPLAY:none" Id="BPTez_pg2" Name="BPTez_pg2">

                             <div class="row table-responsive">
                             <div class="col-lg-12" >

                                <table summary="Employee Pay Sheet" class="table table-condensed table-striped custom_table03 wage-table-print wage-table-print-for-ez">
                                    <thead>
                                        	<tr>
                                            	<th colspan="3" width="100%">NET INCOME PORTION</th>
                                       
                                            </tr>

                                        </thead>
                                    <tbody>

                                        <tr>
                                             <td width="5%">1.</td>
                                            <td width="70%" class="text-left"> <INPUT type="radio" id="radBPTez2_1_2_m2" name="radBPTez2_1_2" onclick="ValidateBPTezMethod()"/> 
		                                        METHOD II. Net Income (or loss) as properly reported to 
					                                        the Federal Government</td>                                     
                                            
                                            <td  width="25%" class="text-left">
                                            <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                        
                                                       <input type="text" id="txtBPTez2_1" class="form-control input-sm pull-right" style="WIDTH: 90%;" onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength="10" />
                                                    </div>
                                                </div>
                                            </div>

                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="5%"></td>
                                            <td>OR
                                            </td>
                                            <td width="25%">                                              	
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                      <label style="WIDTH: 100%"></label>
                                                    </div>
                                                </div>
                                            </div>
                                            </td>
                                        </tr>
                                        <tr>
                                             <td width="5%">2.</td>
                                            <td width="70%" class="text-left"> <INPUT type="radio" id=radBPTez2_1_2_m1 name=radBPTez2_1_2 onclick="ValidateBPTezMethod()" />
			                                    METHOD I. Net Income (or loss) in accordance with Accounting
					                                    System</td>
                                            <td width="25%" class="text-left">                                           
                                                 <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">                                                       
                                                      <input type="text" class="form-control input-sm pull-right" style="WIDTH: 90%;" id="txtBPTez2_2" onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength="10" />
                                                    </div>
                                                </div>
                                            </div>

                                            </td>
                                        </tr>
                                        <tr>
                                             <td width="5%">3.</td>
                                            <td width="70%" class="text-left"> Statutory Net Income Deduction from <label class="lblLink label_NoLeft"  onclick=ShowPage('WrkShtN')> Worksheet S-EZ, Line S5 </label></td>
                                            <td width="25%" class="text-left">                                              	
                                                 <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                     <label id="lbl_BPTez2_3" class="form-control input-sm pull-right" style="WIDTH: 90%"></label>
                                                    </div>
                                                </div>
                                            </div>
                                            </td>
                                        </tr>
                                        <tr >
                                             <td width="5%">4.</td>
                                            <td width="70%" class="text-left"> Loss Carry Foward, if any. </td>
                                            <td width="25%" class="text-left">                                               	
                                                 <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                     <input type="text" class="form-control input-sm pull-right" id="txtBPTez2_4" style="WIDTH: 90%;" onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength="10" />
                                                    </div>
                                                </div>
                                            </div>
                                            </td>
                                        </tr>
                                        <tr >
                                             <td width="5%">5.</td>
                                            <td width="70%" class="text-left"> Taxable Income or Loss [Calculated - line 1 OR 2 minus line 3 minus line 4] </td>
                                            <td width="25%" class="text-left">                                           
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                     <label id="lblBPTez2_5" class="form-control input-sm pull-right" style="WIDTH: 90%"></label>
                                                    </div>
                                                </div>
                                            </div>
                                            </td>
                                        </tr>
                                        <tr >
                                             <td width="5%">6.</td>
                                            <td width="70%" class="text-left"> TAX DUE (Line 5 X .0643). If Line 5 is a loss, enter zero here and on Page 1, Line 1. </td>
                                            <td width="25%" class="text-left">                                              
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                      <label id="lblBPTez2_6" class="form-control input-sm pull-right" style="WIDTH: 90%"></label>
                                                    </div>
                                                </div>
                                            </div>
                                            </td>
		                             
                                        </tr>
                                     
                                         </tbody>
                                        
                                       <thead>
                                        	<tr>
                                            	<th colspan="3" width="100%">GROSS RECEIPTS PORTION</th>
                                       
                                            </tr>

                                        </thead>
                                        
                                        <tbody>
                                        <tr >
                                            <td width="5%"></td>
                                            <td width="70%" class="text-left">TAXABLE GROSS RECEIPTS from:</td>
                                            <td width="25%"> 
                                              </td>
                                        </tr>
                                        <tr >
                                             <td width="5%">7a.</td>
                                            <td width="70%" class="text-left"> Sales and/or Rentals of Tangible Personal Property </td>
                                            <td width="25%" class="text-left">                                            
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                      <input type="text"  id="txtBPTez2_7a" class="form-control input-sm pull-right" style="WIDTH: 90%;" onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength="10" />
                                                    </div>
                                                </div>
                                            </div>
                                            </td>
                                        </tr>
                                        <tr>
                                             <td width="5%">7b.</td>
                                            <td width="70%" class="text-left"> Services</td>
                                            <td width="25%" class="text-left">                                               
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                      <input type="text"  id="txtBPTez2_7b" class="form-control input-sm pull-right" style="WIDTH: 90%;" onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength="10" />
                                                    </div>
                                                </div>
                                            </div>
                                            </td>
                                        </tr>
                                        <tr >
                                             <td width="5%">7c.</td>
                                            <td width="70%" class="text-left"> Rentals of Real Property</td>
                                            <td width="25%" class="text-left">                                            
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                      <input type="text" id="txtBPTez2_7c" class="form-control input-sm pull-right" style="WIDTH: 90%;" onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength="10" />
                                                    </div>
                                                </div>
                                            </div>
                                            </td>
                                        </tr>

                                         <tr >
                                              <td width="5%">7d.</td>
                                            <td width="70%" class="text-left"> Royalties</td>
                                            <td width="25%" class="text-left">                                              	
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                      <input type="text" id="txtBPTez2_7d" class="form-control input-sm pull-right" style="WIDTH: 90%;" onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength="10" />
                                                    </div>
                                                </div>
                                            </div>
                                            </td>
                                        </tr>
                                        <tr >
                                             <td width="5%">7e.</td>
                                            <td width="70%" class="text-left"> Gains on Sales of Business Capital Assets</td>
                                            <td width="25%" class="text-left">                                           
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                      <input type="text"  id="txtBPTez2_7e" class="form-control input-sm pull-right" style="WIDTH: 90%;" onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength="10" />
                                                    </div>
                                                </div>
                                            </div>
                                            </td>
                                        </tr>
                                        <tr >
                                             <td width="5%">7f.</td>
                                            <td width="70%" class="text-left"> Gains on Sales of Stocks, Bonds, etc. (not applicable to individuals)</td>
                                            <td width="25%" class="text-left">                                          	
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                      <input type="text" id="txtBPTez2_7f" class="form-control input-sm pull-right" style="WIDTH: 90%;" onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength="10" />
                                                    </div>
                                                </div>
                                            </div>
                                            </td>
                                        </tr>
                                           <tr >
                                                <td width="5%">7g.</td>
                                            <td width="70%" class="text-left"> Dividends (not applicable to individuals)</td>
                                            <td width="25%" class="text-left">                                           
                                                 <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                      <input type="text" id="txtBPTez2_7g" class="form-control input-sm pull-right" style="WIDTH: 90%;" onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength="10" />
                                                    </div>
                                                </div>
                                            </div>
                                            </td>
                                        </tr>
                                        <tr>
                                             <td width="5%">7h.</td>
                                            <td width="70%" class="text-left"> Interest (not applicable to individuals)</td>
                                            <td width="25%" class="text-left">                                            	
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                     <input type="text" id="txtBPTez2_7h" class="form-control input-sm pull-right" style="WIDTH: 90%;" onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength="10" />
                                                    </div>
                                                </div>
                                            </div>
                                            </td>
                                        </tr>
                                        <tr >
                                             <td width="5%">7i.</td>
                                            <td width="70%" class="text-left"> Other (Describe)</td>
                                            <td width="25%" class="text-left">                                            
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                     <input type="text" id="txtBPTez2_7i" class="form-control input-sm pull-right" style="WIDTH: 90%;" onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength="10" />
                                                    </div>
                                                </div>
                                            </div>
                                            </td>
                                        </tr>

                                         <tr>
                                              <td width="5%">8.</td>
                                            <td width="70%" class="text-left"> TOTAL TAXABLE GROSS RECEIPTS[Calculated - add lines 7a through 7i]</td>
                                            <td width="25%" class="text-left">                                             
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                      <label id="lblBPTez2_8" class="form-control input-sm pull-right"  style="WIDTH: 90%"></label>
                                                    </div>
                                                </div>
                                            </div>
                                            </td>
                                        </tr>
                                         <tr >
                                              <td width="5%">9.</td>
                                            <td width="70%" class="text-left"> <b>Statutory Exclusion (Lower of Line 8 or $50,000.00)</b></td>
                                            <td width="25%" class="text-left">                                
                                                
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                      <label type="text" id="lblBPTez2_9" style="WIDTH: 90%;" class="form-control input-sm pull-right"  />
                                                          
                                                    </div>
                                                </div>
                                            </div>
                                            </td>
                                        </tr>
                                        <tr >
                                             <td width="5%">10.</td>
                                            <td width="70%" class="text-left"> Net taxable Gross Receipts (Line 8 minus Line 9)</td>
                                            <td width="25%" class="text-left">                                             
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                      <label id="lblBPTez2_10" class="form-control input-sm pull-right" style="WIDTH: 90%"></label>
                                                    </div>
                                                </div>
                                            </div>
                                            </td>
                                        </tr>
                                        <tr >
                                             <td width="5%">11.</td>
                                            <td width="70%" class="text-left"> TAX DUE. (Line 10 X .001415). Enter here and on Page 1, Line 2.</td>
                                            <td width="25%" class="text-left">                                              
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                    <label id="lblBPTez2_11" class="form-control input-sm pull-right" style="WIDTH: 90%"></label>
                                                    </div>
                                                </div>
                                            </div>
                                            </td>
                                        </tr>
                                      
                                    </tbody>
                                </table>
                                <div class="clear"></div>
                                 </div>
                            </div>
                                 <form class="form-horizontal school_form">
                                <div class="form-group">
                                    <div class="col-sm-offset-3 col-sm-9  text-right">
                                       <input type="button" value="Go to Page 1" class="btn btn-default submit_button" id="btnGoToPage1" onclick="ShowPage(1)" />
                                    </div>
                                </div>

                            </form>      
                            </div>
                            <div>
                            <% Html.RenderAction("BPTez_WorkSheetSEZ_2014", "Returns"); %>
                            </div>
                       </div>
                       </div>
                        </div>
                        <div class="clearfix"></div>
                   
                    </div>

                </div>
               </div>
             
            </div>
             <div class="clearfix"></div>
            </div>    
             
           </div>
          </div>
         </div>
        </div>
</body>
</html>