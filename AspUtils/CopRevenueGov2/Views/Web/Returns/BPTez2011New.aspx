﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>

<html>
<head>
    <!-- Bootstrap Core CSS -->
    <link href="../Content/Styles/bootstrap.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="../Content/Styles/copegov.css" rel="stylesheet">
    <link href="../Content/Styles/style.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../Content/Styles/jPushMenu.css">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <title></title>
    <script id="clientEventHandlersJS" language="javascript" type="text/javascript">

        var arrBPTezErr = new Array();
        var txtHeader = 'Taxpayer Information';
        var dBPTezNetRate, dBPTezGrossRate;
        var sYear = '11';
        var mbFirstTime = false;
        var gUserAddr = '<%# Request.ServerVariables["REMOTE_ADDR"] %>';
        $(document).ready(function () {
            DisplayBPTezReturn();
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
                $('#lblBPTez1_7').text(ispFormatMoney(bval, 0));
                if (bval != 0) {
                    $(parent.AppError).text('Lines 10a, 10b and 10c must equal Line 7 in Page 1');
                }
            }
        }

        function DisplayBPTezReturn() {
            //refresh bptez form
            parent.$g.loadXmlSync('XML/BPTezReturn', parent.parseXml_xmlBPTez);
            parent.$g.loadXmlSync('XML/BPTezReturn', parent.parseXml_xmlBPTezTemplate);

            if ($(parent.$g.xmlAccount).find("TAX_ACCT").find("ACCOUNT:contains('24')")) {
                // parent.MenuWin.ispHighlightMenu(parent.MenuWin.mnuBPTezYear11); 	//.mnuBPTezYear10Page2
                $('#BPTez').css("display", "block");
                $('#BPTez_pg2').css("display", "block");

                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 'INQ', 'BPT_INFO RETURN_STATUS', '', 0)
                var entityInfo_ACCOUNT_ID = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ACCOUNT_ID', "", 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, entityInfo_ACCOUNT_ID, 'BPT_INFO ACCOUNT_ID', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, '12/31/2011', 'BPT_INFO PERIOD', '', 0);

                $('#AppHeader').html(txtHeader + '<Font class=hdrMedium>|Business Income & Receipts Tax-EZ for 2011</Font>');
                parent.gsInstructionItem = '#BptEz';
                $('#AppMessage').html(parent.gsInstructionText
                                      + '<BR>The Business Income & Receipts Tax for 2011 is due April 15, 2012.');
                $('#InstructionText').html(' for Instructions on filing this return');
                //suman set last parameter true will cause xml copy to browser clipboard
                ispCallXMLForm(parent.$g.xmlBPTez, parent.$g.xmlBPTez, "BPTezReturn", "");
                ispHideProgress();

                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'ERROR_INFO ERROR', "", 0) != 0) {
                    $(parent.RightFrame).attr("rows", "*,0");
                    $('#BPTez').css("display", "block");
                    PopulateBPTezHeader();
                    FieldLock(true);
                    $(parent.AppError).text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'ERROR_INFO MESSAGE', "", 0));
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

            if (parent.GetInnerNodeText(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', 'START_DATE', '24').slice(-4) == '2012') {
                alert('If you are a New Business that has or plans to meet the employment requirement to use the zero tax rate then you must file a paper return until programming for the website is complete.')
            }
            //if
            $(parent.RightFrame).attr("rows", "*,0");
            LoadBPTezError();
            RightAlignText();
            CheckBPTezXML();
            PopulateBPTezHeader();
            PopulateBPTezData();
            SetBPTezFields();
            $(parent.AppError).text("");
            $('#txtBPTez2_3').attr("disabled", "disabled");
            ShowPage(2);
            GoToPage1Button();
        }//DisplayBPTez05Return


        function SetBPTezFields() {
            var chkAmended = document.getElementById("chkAmended");
            chkAmended.checked = false

            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_INFO VERSION', '', 0) == '') {
                mbFirstTime = true;
                FieldLock(false);
                chkAmended.disabled = true;
                chkTaxpayer.checked = false;
            } else {
                chkAmended.disabled = false;
                FieldLock(true);
            }		//if
        }		//SetBPTezFields


        function FieldLock(bDisabled) {
            $('#lblBPTez1_1').attr("disabled", bDisabled);
            $('#lblBPTez1_2').attr("disabled", bDisabled);
            $('#lblBPTez1_3').attr("disabled", bDisabled);
            $('#txtBPTez1_4').attr("disabled", bDisabled);
            $('#lblBPTez1_5').attr("disabled", bDisabled);
            $('#txtBPTez1_6a').attr("disabled", bDisabled);
            $('#txtBPTez1_6b').attr("disabled", bDisabled);
            $('#lblBPTez1_6c').attr("disabled", bDisabled);
            $('#lblBPTez1_7').attr("disabled", bDisabled);
            $('#txtBPTez1_8').attr("disabled", bDisabled);
            $('#lblBPTez1_9').attr("disabled", bDisabled);
            $('#txtBPTez1_10a').attr("disabled", bDisabled);
            $('#txtBPTez1_10b').attr("disabled", bDisabled);
            $('#txtBPTez1_10c').attr("disabled", bDisabled);
            $('#radBPTez2_1_2_m1').attr("disabled", bDisabled);
            $('#radBPTez2_1_2_m2').attr("disabled", bDisabled);
            $('#txtBPTez2_1').attr("disabled", bDisabled);
            $('#txtBPTez2_2').attr("disabled", bDisabled);
            //$('#txtBPTez2_3').attr("disabled", bDisabled);
            $('#lblBPTez2_4').attr("disabled", bDisabled);
            $('#lblBPTez2_5').attr("disabled", bDisabled);
            $('#txtBPTez2_6a').attr("disabled", bDisabled);
            $('#txtBPTez2_6b').attr("disabled", bDisabled);
            $('#txtBPTez2_6c').attr("disabled", bDisabled);
            $('#txtBPTez2_6d').attr("disabled", bDisabled);
            $('#txtBPTez2_6e').attr("disabled", bDisabled);
            $('#txtBPTez2_6f').attr("disabled", bDisabled);
            $('#txtBPTez2_6g').attr("disabled", bDisabled);
            $('#txtBPTez2_6h').attr("disabled", bDisabled);
            $('#txtBPTez2_6i').attr("disabled", bDisabled);
            $('#lblBPTez2_7').attr("disabled", bDisabled);
            $('#lblBPTez2_8').attr("disabled", bDisabled);
            DisablePreparer(bDisabled);
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

                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, '12/31/2011', 'BPT_INFO PERIOD', '', 0);
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
            $('#txtBPTez2_3').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 LOSS_CARRY_FORWARD', '', 0), 0));
            $('#lblBPTez2_4').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 TAXABLE_INCOME', '', 0), 0));
            $('#lblBPTez2_5').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 TAX_DUE_NET', '', 0), 0));
            $('#txtBPTez2_6a').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 SALES_RENTAL', '', 0), 0));
            $('#txtBPTez2_6b').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 SERVICES', '', 0), 0));
            $('#txtBPTez2_6c').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 RENTAL_PROPERTY', '', 0), 0));
            $('#txtBPTez2_6d').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 ROYALTIES', '', 0), 0));
            $('#txtBPTez2_6e').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 CAPITAL_GAINS', '', 0), 0));
            $('#txtBPTez2_6f').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 STOCK_GAINS', '', 0), 0));
            $('#txtBPTez2_6g').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 DIVIDENDS', '', 0), 0));
            $('#txtBPTez2_6h').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 INTEREST', '', 0), 0));
            $('#txtBPTez2_6i').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 OTHER', '', 0), 0));
            $('#lblBPTez2_7').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 TAXABLE_GROSS_RCPTS', '', 0), 0));
            $('#lblBPTez2_8').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 TAX_DUE_GROSS', '', 0), 0));

            CalcPage1Line7();
            CalcPage1Line9_10();
        }//PopulateBPTezData


        function DisplayNetIncome() {
            var curzero = ispFormatMoney(0, 0).toString();
            if ($('#radBPTez2_1_2_m1').is(":disabled") == true) {
                return;
            }

            if (radBPTez2_1_2_m1.checked == true) {
                $('#txtBPTez2_1').attr("disabled", 'disable');
                $('#txtBPTez2_2').removeAttr("disabled");
                ispSetFocus($('#txtBPTez2_2'));
                return;
            }

            if (radBPTez2_1_2_m2.checked == true) {
                $('#txtBPTez2_2').attr("disabled", 'disable');
                $('#txtBPTez2_1').removeAttr("disabled");
                ispSetFocus($('#txtBPTez2_1'));
                return;
            }

            if ($('#txtBPTez2_1').val() == curzero && $('#txtBPTez2_2').val() == curzero) {
                radBPTez2_1_2_m2.checked = true;
                $('#txtBPTez2_2').attr("disabled", "disable");
                ispSetFocus($('#txtBPTez2_1'));
            }
            else if ($('#txtBPTez2_1').val() != curzero) {
                radBPTez2_1_2_m2.checked = true;
                $('#txtBPTez2_2').attr("disabled", "disable");
                ispSetFocus($('#txtBPTez2_1'));
            }
            else if ($('#txtBPTez2_2').val() != curzero) {
                radBPTez2_1_2_m1.checked = true;
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
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#txtBPTez2_3').val()), 'BPT_PG2 LOSS_CARRY_FORWARD', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#lblBPTez2_4').text()), 'BPT_PG2 TAXABLE_INCOME', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#lblBPTez2_5').text()), 'BPT_PG2 TAX_DUE_NET', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#txtBPTez2_6a').val()), 'BPT_PG2 SALES_RENTAL', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#txtBPTez2_6b').val()), 'BPT_PG2 SERVICES', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#txtBPTez2_6c').val()), 'BPT_PG2 RENTAL_PROPERTY', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#txtBPTez2_6d').val()), 'BPT_PG2 ROYALTIES', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#txtBPTez2_6e').val()), 'BPT_PG2 CAPITAL_GAINS', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#txtBPTez2_6f').val()), 'BPT_PG2 STOCK_GAINS', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#txtBPTez2_6g').val()), 'BPT_PG2 DIVIDENDS', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#txtBPTez2_6h').val()), 'BPT_PG2 INTEREST', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#txtBPTez2_6i').val()), 'BPT_PG2 OTHER', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#lblBPTez2_7').text()), 'BPT_PG2 TAXABLE_GROSS_RCPTS', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#lblBPTez2_8').text()), 'BPT_PG2 TAX_DUE_GROSS', '', 0);

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
            $('#txtBPTez2_3').css("text-align", "right");
            $('#lblBPTez2_4').css("text-align", "right");
            $('#lblBPTez2_5').css("text-align", "right");
            $('#txtBPTez2_6a').css("text-align", "right");
            $('#txtBPTez2_6b').css("text-align", "right");
            $('#txtBPTez2_6c').css("text-align", "right");
            $('#txtBPTez2_6d').css("text-align", "right");
            $('#txtBPTez2_6e').css("text-align", "right");
            $('#txtBPTez2_6f').css("text-align", "right");
            $('#txtBPTez2_6g').css("text-align", "right");
            $('#txtBPTez2_6h').css("text-align", "right");
            $('#txtBPTez2_6i').css("text-align", "right");
            $('#lblBPTez2_7').css("text-align", "right");
            $('#lblBPTez2_8').css("text-align", "right");
        }//RightAlignText


        function LoadBPTezError() {
            var txtBPTez1_4 = document.getElementById("txtBPTez1_4");
            var txtBPTez1_6a = document.getElementById("txtBPTez1_6a");
            var txtBPTez1_6b = document.getElementById("txtBPTez1_6b");
            var txtBPTez1_8 = document.getElementById("txtBPTez1_8");
            var txtBPTez1_10a = document.getElementById("txtBPTez1_10a");
            var txtBPTez1_10b = document.getElementById("txtBPTez1_10b");
            var txtBPTez1_10c = document.getElementById("txtBPTez1_10c");
            var txtBPTez2_1 = document.getElementById("txtBPTez2_1");
            var txtBPTez2_2 = document.getElementById("txtBPTez2_2");
            var txtBPTez2_3 = document.getElementById("txtBPTez2_3");
            var txtBPTez2_6a = document.getElementById("txtBPTez2_6a");
            var txtBPTez2_6b = document.getElementById("txtBPTez2_6b");

            var txtBPTez2_6c = document.getElementById("txtBPTez2_6c");
            var txtBPTez2_6d = document.getElementById("txtBPTez2_6d");
            var txtBPTez2_6e = document.getElementById("txtBPTez2_6e");
            var txtBPTez2_6f = document.getElementById("txtBPTez2_6f");
            var txtBPTez2_6g = document.getElementById("txtBPTez2_6g");
            var txtBPTez2_6h = document.getElementById("txtBPTez2_6h");
            var txtBPTez2_6i = document.getElementById("txtBPTez2_6i");

            var i = 0;

            //Page1
            arrBPTezErr[i++] = [txtBPTez1_4, 'ispValue(txtBPTez1_4.value) == false', 'Value for Question 4 must be numeric'];


            arrBPTezErr[i++] = [txtBPTez1_6a, ' $(\'#txtBPTez1_6a\').val() == ""', 'Answer Question 6a'];
            arrBPTezErr[i++] = [txtBPTez1_6a, 'ispValue($(\'#txtBPTez1_6a\').val()) == false', 'Value for Question 6a must be numeric'];
            arrBPTezErr[i++] = [txtBPTez1_6a, 'ispNegativeNumber($(\'#txtBPTez1_6a\').val()) == false', 'Value for Question 6a must NOT be negative'];

            arrBPTezErr[i++] = [txtBPTez1_6b, '$(\'#txtBPTez1_6b\').val() == ""', 'Answer Question 6b'];
            arrBPTezErr[i++] = [txtBPTez1_6b, 'ispValue($(\'#txtBPTez1_6b\').val()) == false', 'Value for Question 6b must be numeric'];
            arrBPTezErr[i++] = [txtBPTez1_6b, 'ispNegativeNumber($(\'#txtBPTez1_6b\').val()) == false', 'Value for Question 6b must NOT be negative'];

            arrBPTezErr[i++] = [txtBPTez1_8, ' $(\'#txtBPTez1_8\').val() == ""', 'Answer Question 8'];
            arrBPTezErr[i++] = [txtBPTez1_8, 'ispValue($(\'#txtBPTez1_8\').val()) == false', 'Value for Question 8 must be numeric'];
            arrBPTezErr[i++] = [txtBPTez1_8, 'ispNegativeNumber($(\'#txtBPTez1_8\').val()) == false', 'Value for Question 8 must NOT be negative'];

            arrBPTezErr[i++] = [txtBPTez1_10a, 'ispValue($(\'#txtBPTez1_10a\').val()) == false', 'Value for Question 10a must be numeric'];
            arrBPTezErr[i++] = [txtBPTez1_10a, 'ispNegativeNumber($(\'#txtBPTez1_10a\').val()) == false', 'Value for Question 10a must NOT be negative'];


            arrBPTezErr[i++] = [txtBPTez1_10b, 'ispValue($(\'#txtBPTez1_10b\').val()) == false', 'Value for Question 10b must be numeric'];
            arrBPTezErr[i++] = [txtBPTez1_10b, 'ispNegativeNumber($(\'#txtBPTez1_10b\').val()) == false', 'Value for Question 10b must NOT be negative'];

            arrBPTezErr[i++] = [txtBPTez1_10c, 'ispValue($(\'#txtBPTez1_10c\').val()) == false', 'Value for Question 10c must be numeric'];
            arrBPTezErr[i++] = [txtBPTez1_10c, 'ispNegativeNumber($(\'#txtBPTez1_10c\').val()) == false', 'Value for Question 10c must NOT be negative'];

            //Page2
            arrBPTezErr[i++] = [txtBPTez2_1, '$(\'#txtBPTez2_1\').val() == ""', 'Answer Question 1'];
            arrBPTezErr[i++] = [txtBPTez2_1, 'ispValue($(\'#txtBPTez2_1\').val()) == false', 'Value for Question 1 must be numeric'];


            arrBPTezErr[i++] = [txtBPTez2_2, ' $(\'#txtBPTez2_2\').val() == ""', 'Answer Question 2'];
            arrBPTezErr[i++] = [txtBPTez2_2, 'ispValue(txtBPTez2_2.value) == false', 'Value for Question 2 must be numeric'];

            arrBPTezErr[i++] = [txtBPTez2_3, ' $(\'#txtBPTez2_3\').val() == ""', 'Answer Question 3'];
            arrBPTezErr[i++] = [txtBPTez2_3, 'ispValue($(\'#txtBPTez2_3\').val()) == false', 'Value for Question 3 must be numeric'];
            arrBPTezErr[i++] = [txtBPTez2_3, 'ispNegativeNumber($(\'#txtBPTez2_3\').val()) == false', 'Value for Question 3 must NOT be negative'];

            arrBPTezErr[i++] = [txtBPTez2_6a, '$(\'#txtBPTez2_6a\').val() == ""', 'Answer Question 6a'];
            arrBPTezErr[i++] = [txtBPTez2_6a, 'ispValue($(\'#txtBPTez2_6a\').val()) == false', 'Value for Question 6a must be numeric'];
            arrBPTezErr[i++] = [txtBPTez2_6a, 'ispNegativeNumber($(\'#txtBPTez2_6a\').val()) == false', 'Value for Question 6a must NOT be negative'];

            arrBPTezErr[i++] = [txtBPTez2_6b, '$(\'#txtBPTez2_6b\').val() == ""', 'Answer Question 6b'];
            arrBPTezErr[i++] = [txtBPTez2_6b, 'ispValue($(\'#txtBPTez2_6b\').val()) == false', 'Value for Question 6b must be numeric'];
            arrBPTezErr[i++] = [txtBPTez2_6b, 'ispNegativeNumber($(\'#txtBPTez2_6b\').val()) == false', 'Value for Question 6b must NOT be negative'];

            arrBPTezErr[i++] = [txtBPTez2_6c, '$(\'#txtBPTez2_6c\').val() == ""', 'Answer Question 6c'];
            arrBPTezErr[i++] = [txtBPTez2_6c, 'ispValue($(\'#txtBPTez2_6c\').val()) == false', 'Value for Question 6c must be numeric'];
            arrBPTezErr[i++] = [txtBPTez2_6c, 'ispNegativeNumber($(\'#txtBPTez2_6c\').val()) == false', 'Value for Question 6c must NOT be negative'];

            arrBPTezErr[i++] = [txtBPTez2_6d, '$(\'#txtBPTez2_6d\').val() == ""', 'Answer Question 6d'];
            arrBPTezErr[i++] = [txtBPTez2_6d, 'ispValue($(\'#txtBPTez2_6d\').val()) == false', 'Value for Question 6d must be numeric'];
            arrBPTezErr[i++] = [txtBPTez2_6d, 'ispNegativeNumber($(\'#txtBPTez2_6d\').val()) == false', 'Value for Question 6d must NOT be negative'];

            arrBPTezErr[i++] = [txtBPTez2_6e, '$(\'#txtBPTez2_6e\').val() == ""', 'Answer Question 6e'];
            arrBPTezErr[i++] = [txtBPTez2_6e, 'ispValue($(\'#txtBPTez2_6e\').val()) == false', 'Value for Question 6e must be numeric'];
            arrBPTezErr[i++] = [txtBPTez2_6e, 'ispNegativeNumber($(\'#txtBPTez2_6e\').val()) == false', 'Value for Question 6e must NOT be negative'];

            arrBPTezErr[i++] = [txtBPTez2_6f, '$(\'#txtBPTez2_6f\').val() == ""', 'Answer Question 6f'];
            arrBPTezErr[i++] = [txtBPTez2_6f, 'ispValue($(\'#txtBPTez2_6f\').val()) == false', 'Value for Question 6f must be numeric'];
            arrBPTezErr[i++] = [txtBPTez2_6f, 'ispNegativeNumber($(\'#txtBPTez2_6f\').val()) == false', 'Value for Question 6f must NOT be negative'];

            arrBPTezErr[i++] = [txtBPTez2_6g, '$(\'#txtBPTez2_6g\').val() == ""', 'Answer Question 6g'];
            arrBPTezErr[i++] = [txtBPTez2_6g, 'ispValue($(\'#txtBPTez2_6g\').val()) == false', 'Value for Question 6g must be numeric'];
            arrBPTezErr[i++] = [txtBPTez2_6g, 'ispNegativeNumber($(\'#txtBPTez2_6g\').val()) == false', 'Value for Question 6g must NOT be negative'];

            arrBPTezErr[i++] = [txtBPTez2_6h, '$(\'#txtBPTez2_6h\').val() == ""', 'Answer Question 6h'];
            arrBPTezErr[i++] = [txtBPTez2_6h, 'ispValue($(\'#txtBPTez2_6h\').val()) == false', 'Value for Question 6h must be numeric'];
            arrBPTezErr[i++] = [txtBPTez2_6h, 'ispNegativeNumber($(\'#txtBPTez2_6h\').val()) == false', 'Value for Question 6h must NOT be negative'];

            arrBPTezErr[i++] = [txtBPTez2_6i, '$(\'#txtBPTez2_6i\').val() == ""', 'Answer Question 6i'];
            arrBPTezErr[i++] = [txtBPTez2_6i, 'ispValue($(\'#txtBPTez2_6i\').val()) == false', 'Value for Question 6i must be numeric'];
            arrBPTezErr[i++] = [txtBPTez2_6i, 'ispNegativeNumber($(\'#txtBPTez2_6i\').val()) == false', 'Value for Question 6i must NOT be negative'];
            //	arrBPTezErr[i++] = [lblBPTez1_7, 'PrepForMath(lblBPTez1_7.innerText) > 0', 'Line 7 must be greater than 0']

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
            }
            else {
                currDisplayedObjId = 'BPTez_pg2';
                $('#BPTez_pg1').css("display", "block");
            }

            $(parent.AppError).text('');
            $('#BPTez_pg2').prepend($('#BPTezHeader').html() + '<BR>');
            if ($('#txtBPTez2_1').is(":disabled") == true) {
                FieldLock(false);
                window.print();
                // BLOCK 1.1
                //SUMAN JQUERY html() METHOD CAN NOT COPY TEXT AREA VALUES WHEN IT TRY TO COPY INNERHTML FOR A DIV. 
                //SO VARIABLE lBPTez_pg2 IS A HTML WITHOUT TEXTBOX VALUES FROM PAGE2.
                //THIS CREATING PROBLEM AFTER PRINT BUTTON HIT AND IT TRIES TO RE INSERT ALL HTML TO PAGE 2
                //PRINT BUTTON USED IN OTHER RETURN FORMS DONT HAVE THIS LOGIC AND I FOUND NO HARM REMOVING IT FOR NOW. SO I AM DISABLING THIS LINE TO SOLVE PRINT ISSUE
                //HOWEVER ACTUAL SOLUTION IS POSSIBLE BUT WAY MORE COMPLEX. I WILL DO IF THIS CAUSE PROBLEM IN COME CASE AFTER TESTING.
                //$('#BPTez_pg2').html(lBPTez_pg2);
                //----------------------------------------------------------------------------------------------------
                FieldLock(true);
            }
            else {
                window.print();
                //REF. BLOCK 1.1
                //$('#BPTez_pg2').html(lBPTez_pg2);
                //-------------------------------------
            }

            $('#btnBPTezPrint').css("visibility", "visible");
            $('#btnBPTezSubmit').css("visibility", "visible");

            if (currDisplayedObjId == 'BPTez_pg1') {
                $('#BPTez_pg2').css("display", "none");
            }
            else {
                $('#BPTez_pg1').css("display", "none");
            }
        }//btnBPTezPrint_onclick


        function btnBPTezSubmit_onclick() {
            $(parent.AppError).text("");
            ValidateBPTezReturn();

            if ($(parent.AppError).text() == "") {
                $(parent.AppError).text(ValidatePreparer());
            }

            if ($(parent.AppError).text() == "") {
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, '', 'BPT_INFO RETURN_STATUS', '', 0);
                PopulateBPTezXML();

                ispCallXMLForm(parent.$g.xmlBPTez, parent.$g.xmlBPTez, "BPTezReturn", "");

                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'ERROR_INFO PROGRAM', '', 0) == '') {
                    $('#BPTez').css("display", "none");
                    DisplayBPTezThankYou();
                }
                else {
                    $(parent.AppError).text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'ERROR_INFO MESSAGE', '', 0));
                }
            }
        }//btnBPTezSubmit_onclick


        function ShowPage(iPage) {
            if (iPage == 2) {
                //		parent.MenuWin.ispHighlightMenu(parent.MenuWin.mnuBPTezYear10Page2)
                $('#BPTez_pg1').css("display", "none");
                $('#BPTez_pg2').css("display", "block");
                $('#btnBPTezSubmit').removeAttr("disabled");
                //		FieldLock(false)
                DisplayNetIncome();
            }
            else {
                //		parent.MenuWin.ispHighlightMenu(parent.MenuWin.mnuBPTezYear10Page1)
                $('#BPTez_pg1').css("display", "block");
                $('#BPTez_pg2').css("display", "none");
            }
            loadpage();
        }//ShowPage


        function loadpage() {


            try {
                var iFrameID = parent.window.frames['ifrmDocwin'];

                $(iFrameID).height($(iFrameID).contents().find("html").height() + 70);
            }
            catch (ee) {
                var iFrameID1 = parent.document.getElementById('ifrmDocwin');

                iFrameID1.height = (iFrameID1.contentWindow.document.body.scrollHeight + 70) + "px";

            }
        } // binoy

        function chkAmended_onclick() {

            if ($('#chkAmended').is(':checked')) {
                $('#btnBPTezSubmit').removeAttr("disabled");
                FieldLock(false);
                ClearPreparer();
                if ($('#BPTez_pg1').css('display') == 'block') {
                    txtBPTez1_6a;
                }
                else {
                    DisplayNetIncome();
                }
            }
            else {
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

        /*
        jQuery.extend(jQuery.expr[':'], {
            focus: function (element) {
                var evt = window.event|| arguments.callee.caller.arguments[0];
                if(evt){
                    var source = parent.MenuWin.getEventSource(evt);
                    return element == source;
                }
            }
        });
        
        */

        function getActiveElement() {
            var obj = document.activeElement;
            /*if (obj)
            {
                alert('active element' + obj.type);
                return obj;
            }*/

            var evt = window.event || arguments.callee.caller.caller.arguments[0];
            var source = parent.getEventSource(evt);
            //alert('event');
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
                    $('#txtBPTez2_1').val(ispFormatMoney(0, 0));
                    $('#txtBPTez2_2').attr("disabled", "disable");
                    $('#txtBPTez2_1').removeAttr("disabled");
                    $('#txtBPTez2_1').focus();
                }

                ValidateBPTezReturn();
            }
        }//ValidateBPTezMethod

        function ValidateBPTezReturn() {
            var ObjSelected = getActiveElement();
            //if (ObjSelected == undefined || ObjSelected == null) {


            //		return;
            //	}

            $(parent.AppError).text(ispSetInputErr(arrBPTezErr));

            if ($(parent.AppError).text() == "") {
                //this validation should not run for buttons as because it will try to change button text then
                if (ObjSelected != undefined || ObjSelected != null) {
                    if (ObjSelected.type != 'button') {

                        ObjSelected.value = ispFormatMoney(ObjSelected.value, 0);

                    }
                }

                //	    ObjSelected.value = ispFormatMoney(ObjSelected.value, 0);
                CheckPage2Line3();
                CalcPage2Line4();
                CalcPage2Line5(dBPTezNetRate);
                CalcPage2Line7();
                CalcPage2Line8(dBPTezGrossRate);
                CalcPage1Line3();
                CalcPage1Line5();
                CalcPage1Line6c();
                CalcPage1Line7();
                CalcPage1Line9_10();
                nFlowCalc();

                //Sanghamitra
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

                //SAnghamitra
            }
            else {
                //Sanghamitra
                $('#lbl1forpage2').attr('onclick', '').unbind('click');
                $('#lbl1forpage2').css('cursor', 'default');
                $('#lbl1forpage2').css('color', 'gray');

                $('#lbl2forpage2').attr('onclick', '').unbind('click');
                $('#lbl2forpage2').css('cursor', 'default');
                $('#lbl2forpage2').css('color', 'gray');
                //Sanghamitra



                $('#lblBPTez2_7').text(ispFormatMoney(0, 0));//("$0");
            }

            GoToPage1Button();
        }//ValidateBPTezReturn

        //EHD 01152008 Task: Enable/Disable 'Go to Page 1' Button per Tom Wisner
        function GoToPage1Button() {
            var iIncomeTaxDue = ispRemoveMoney($('#lblBPTez2_4').text());//.replace('$', '');
            var iReceiptTaxDue = ispRemoveMoney($('#lblBPTez2_7').text());//.replace('$', '');
            //var iIncomeTaxDue = iIncomeTaxDue.replace(',','')
            //var iReceiptTaxDue = iReceiptTaxDue.replace(',','')
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_INFO PREPARER_NAME ', "", 0) == 0 && iReceiptTaxDue == 0)//Sanghamitra:added this if block to disable the "go to page1" button in case of fresh form and it wont get activated untill there is value in Page1, line 7 
            {

                $('#btnGoToPage1').attr("disabled", "disable");
                $('#lblPage1Disabled').text('Gross Receipts Portions needs to be filled out before going to Page 1');
            }
            else {
                if (iIncomeTaxDue > 0 && iReceiptTaxDue == 0) {
                    $('#mnuBPTezYear06Page1', parent).attr("disabled", "disable");
                    $('#btnGoToPage1').attr("disabled", "disable");
                    $('#lblPage1Disabled').text('Gross Receipts Portions needs to be filled out before going to Page 1');
                }
                else {
                    $('#mnuBPTezYear06Page1', parent).removeAttr("disabled");
                    $('#btnGoToPage1').removeAttr("disabled");
                    $('#lblPage1Disabled').text('');
                }
            }
        }//GoToPage1Button

        function CheckPage2Line3() {
            var BPTStartDate;
            iCount = parent.$x.ispXmlGetRecCount(parent.$g.xmlAccount, 'TAX_ACCT', '');
            if ($('#txtBPTez2_3').val() != ispFormatMoney(0, 0).toString()) {
                for (i = 0; i < iCount; i++) {
                    if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '', i) == '24') {
                        BPTStartDate = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'TAX_ACCT START_DATE', '', i)
                        if (new Date(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'TAX_ACCT START_DATE', '', i)) >= new Date("01/01/2011")) {
                            $('#txtBPTez2_3').val(ispFormatMoney(0, 0));//'$0';
                            alert('This return is not eligible for Loss Carry Forward, because your BPT Start Date '
                                 + BPTStartDate
                                 + ' is on or after 01/01/2011. Loss Carry Forward (Page 2, Question #3) has been set to zero.');
                        }
                    }
                }
            }
        }

        function cCur(value) {
            return ispRemoveMoney(value);
        }

        function CalcPage2Line4() {
            if ($('#radBPTez2_1_2_m2').is(":checked") == true) {
                var BPTez2_1 = cCur($('#txtBPTez2_1').val());
                var BPTez2_3 = cCur($('#txtBPTez2_3').val());
                $('#lblBPTez2_4').text(ispFormatMoney(BPTez2_1 - BPTez2_3, 0));
            }

            if ($('#radBPTez2_1_2_m1').is(":checked") == true) {
                var BPTez2_2 = cCur($('#txtBPTez2_2').val());
                var BPTez2_3 = cCur($('#txtBPTez2_3').val());
                $('#lblBPTez2_4').text(ispFormatMoney(BPTez2_2 - BPTez2_3, 0));
            }
        }

        function CalcPage2Line5(dTax) {
            if (isNaN(dTax)) {
                dTax = 0.065;
            }

            if ($('#lblBPTez2_4').text() != "") {
                if (cCur($('#lblBPTez2_4').text()) < 0) {
                    $('#lblBPTez2_5').text(ispFormatMoney(0, 0));
                }
                else {
                    var BPTez2_4 = cCur($('#lblBPTez2_4').text());
                    $('#lblBPTez2_5').text(ispFormatMoney(BPTez2_4 * dTax, 0));
                }
                $('#lblBPTez1_1').text($('#lblBPTez2_5').text());
            }
        }



        function CalcPage2Line7() {
            if ($('#txtBPTez2_6a').val() != "" && $('#txtBPTez2_6b').val() != "" && $('#txtBPTez2_6c').val() != "" &&
             $('#txtBPTez2_6d').val() != "" && $('#txtBPTez2_6e').val() != "" && $('#txtBPTez2_6f').val() != "" &&
             $('#txtBPTez2_6g').val() != "" && $('#txtBPTez2_6h').val() != "" && $('#txtBPTez2_6i').val() != "") {
                /*
                Suman : What is this ? calculation or string concat ???...
                var totalAmtBPTez2_6 = txtBPTez2_6a.value + txtBPTez2_6b.value + txtBPTez2_6c.value
                                     + txtBPTez2_6d.value + txtBPTez2_6e.value + txtBPTez2_6f.value
                                     + txtBPTez2_6g.value + txtBPTez2_6h.value + txtBPTez2_6i.value;
        
                */

                var totalAmtBPTez2_6 =
                cCur($('#txtBPTez2_6a').val()) +
                cCur($('#txtBPTez2_6b').val()) +
                cCur($('#txtBPTez2_6c').val()) +
                cCur($('#txtBPTez2_6d').val()) +
                            cCur($('#txtBPTez2_6e').val()) +
                            cCur($('#txtBPTez2_6f').val()) +
                            cCur($('#txtBPTez2_6g').val()) +
                            cCur($('#txtBPTez2_6h').val()) +
                            cCur($('#txtBPTez2_6i').val());

                $('#lblBPTez2_7').text(ispFormatMoney(totalAmtBPTez2_6, 0));
            }
            if (cCur($('#lblBPTez2_7').text()) == 0) {
                $(parent.AppError).text("Page 2, Line 7 can not be zero."); //SUMAN
            }
        }

        function CalcPage2Line8(dTax) {
            if (isNaN(dTax)) {
                dTax = 0.0023;
            }

            if ($('#lblBPTez2_7').text() != "") {
                $('#lblBPTez2_8').text(ispFormatMoney(
                cCur($('#lblBPTez2_7').text()) * dTax, 0));
                $('#lblBPTez1_2').text($('#lblBPTez2_8').text());
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

            if (cCur($('#lblBPTez1_3').text()) != 0 && cCur(txtBPTez1_4.value) == 0) {
                $(parent.AppError).text("The line 4 can not be 0 if line 3 has a value.");
                $('#txtBPTez1_4').attr("class", "inpError");
                $('#txtBPTez1_4').focus();
            }
            else {
                $('#txtBPTez1_4').attr("class", "inpNormal");
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
            //alert("Line 8 disable value:  " + $('#txtBPTez1_8').attr("disabled"));
            //Added for the enable/disable of Page1 Line 8
            if (mbFirstTime) {
                $('#txtBPTez1_8').removeAttr("disabled");
            } else {
                $('#txtBPTez1_8').attr("disabled", "disabled");
            }


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
                        $(parent.AppError).text("Lines 10a, 10b and 10c must equal Line 7.");
                    }
                }

                $('#lblBPTez1_9').text(ispFormatMoney(0, 0));
            }
            else {
                $('#txtBPTez1_10a').val(ispFormatMoney(0, 0));
                $('#txtBPTez1_10b').val(ispFormatMoney(0, 0));
                $('#txtBPTez1_10c').val(ispFormatMoney(0, 0));
            }
        }
</script>
</head>
    <body>
<div class="container-fluid no-padding">
        <div class="block3">
            <div class="container-fluid">
             <div class="row">
            <div class="col-lg-12 col-md-12" id="BPTez" style="DISPLAY: none;">
            <div style="display: block;" id="tab1" class="blue_base_box">
               <h2><span id="AppHeader">&nbsp;</span>  </h2>

                <div class="inner_white-panel">
                   <div class="contentsection">
                    <h4 id="AppMessage">&nbsp;</h4>
                        <div class="clearfix"></div>
                      <br>
                    <div class="row">

                        <div class="col-lg-12">                          
                           
                             <%-- Address Start--%>
                             <div class="well" id="BPTezHeader">

                                                <div class="row">
                                                    <form>
                                                        <div class="col-lg-4">
                                                            <p><strong>Name :</strong>
                                                                <label id="lblName" class="lblTextBlack"></label>
                                                            </p>
                                                        </div>

                                                        <div class="col-lg-4">
                                                            <p><strong><font id="lblAccountType">Account No.:</font></strong>
                                                                <label id="lblAccountId" class="lblTextBlack"></label>
                                                            </p>
                                                        </div>

                                                    </form>
                                                </div>

                                                <div class="row">
                                                    <div class="col-lg-4">
                                                        <p><strong>Address :</strong>
                                                            <label id="lblAddress_08" class="lblTextBlack"></label>
                                                        </p>
                                                    </div>
                                                     <div class="col-lg-4">
                                                            <p><strong><font id="lblEntityType">EIN :</font></strong>
                                                                <label id="lblEntityId" class="lblTextBlack"></label>
                                                            </p>
                                                        </div>
                                                </div>
                                                <div class="clearfix"></div>

                                            </div>                        

                          <%--  Adress End--%>
                           <div class="row">
                            <div class="col-lg-12 templateclass">                           
                                  <form class="form-horizontal school_form">
                                                          
                                                      <div class="row form-group topsmallform">

                                                            <div class="col-sm-3 newtop_padding">
                                                                <label class="radio" style="font-weight: bold;">
                                                                    <input id=chkAmended type=checkbox onclick="chkAmended_onclick()"  />
                                                                    Check if amended return.</label>
                                                            </div>                                                        
                                                                
                                                          </div>
                                                    </form>
                            <div style="DISPLAY:none" Id="BPTez_pg1" Name="BPTez_pg1">

                            <div class="row table-responsive">
                             <div class="col-lg-12" >

                                <table summary="Employee Pay Sheet" class="table table-condensed table-striped custom_table03">

                                    <tbody>

                                        <tr class="odd">
                                            <td width="70%" class="text-left"><span><strong>1.</strong></span> &nbsp; Net Income Portion Of Tax - 
                                            <label id="lbl1forpage2" class="lblLink label_NoLeft" style="" onclick=ShowPage(2)>Click here for Page 2</label>
			                                <label id="lblLnkSchdN1" style="display:none"></label></td>
                                            <td  width="25%" class="text-left">                                              
                                                <div class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                              <label id=lblBPTez1_1 style="WIDTH: 100%"></label>
                                                            </div>
                                                          </div>
                                            
                                            		</div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-left"><span><strong>2.</strong></span> &nbsp; Gross Receipts Portion Of Tax -
                                                <label id="lbl2forpage2" class="lblLink label_NoLeft" style="" onclick=ShowPage(2)>Click here for Page 2</label>
			                                    <label id="lblLnkSchdN2" style="display:none"></label>
                                            </td>
                                            <td  width="25%" class="text-left">
                                              	
                                                 <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                             <label id=lblBPTez1_2 style="WIDTH: 100%"></label>
                                                            </div>
                                                          </div>
                                            
                                            		</div>
                                            </td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%" class="text-left"><span><strong>3.</strong></span> &nbsp; Tax Due for the 2011 Business Income & Receipts Tax [Calculated - add lines 1 and 2]</td>
                                            <td  width="25%" class="text-left">                                             
                                                 <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                             <label id=lblBPTez1_3 style="WIDTH: 100%"></label>
                                                            </div>
                                                          </div>
                                            
                                            		</div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-left"><span><strong>4.</strong></span> <B><U>MANDATORY</U> 2012 BIRT Estimated Payment <u>(repeat line 3)</u></B></td>
                                            <td  width="25%" class="text-left">                                               
                                                <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                            	<input class="form-control input-sm table_custom_input" id=txtBPTez1_4 onchange="ValidateBPTezReturn()"	onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%">
                                                            </div>
                                                          </div>
                                            
                                            		</div>
                                            </td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%" class="text-left"><span><strong>5.</strong></span> &nbsp; Total Due by <B>4/17/2012</B>[Calculated - add lines 3 and 4]</td>
                                            <td width="25%" class="text-left">                                             
                                                 <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                            	 <label id=lblBPTez1_5 style="WIDTH: 100%"></label>
                                                            </div>
                                                          </div>
                                            
                                            		</div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><u><b>ESTIMATED PAYMENTS AND OTHER CREDITS</b></u></td>
                                            <td align="center" class="no_border_right">
                                               </td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%" class="text-left"><span><strong>6a.</strong></span> &nbsp; Credit from overpayment of 2010 or 2011 Net Profit Tax </td>
                                            <td width="25%" class="text-left">                                             
                                                <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                            	 <input class="form-control input-sm table_custom_input" id=txtBPTez1_6a onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength=10 >
                                                            </div>
                                                          </div>                                            
                                            		</div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-left"><span><strong>6b.</strong></span> &nbsp; Include any estimated and/or extension payments of 2011 BIRT previously
			  made,<br>and any credit from overpayment of the 2010 BPT return</td>
                                            <td width="25%" class="text-left">                                               	
                                                 <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                            	 <input class="form-control input-sm table_custom_input" id=txtBPTez1_6b onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength=10 >
                                                            </div>
                                                          </div>                                            
                                            		</div>
                                            </td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%" class="text-left"><span><strong>6c.</strong></span> &nbsp; Total Payments and Credits [Calculated - add lines 6a and 6b] </td>
                                            <td width="25%" class="text-left">                                             
                                                 <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                            	 <label id=lblBPTez1_6c style="WIDTH: 100%"></label>
                                                            </div>
                                                          </div>                                            
                                            		</div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-left"><span><strong>7.</strong></span> &nbsp; Net Tax Due[Calculated - line 5 minus 6c]</td>
                                            <td width="25%" class="text-left">                                               
                                                <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                            	 <label id=lblBPTez1_7 style="WIDTH: 100%"></label>
                                                            </div>
                                                          </div>                                            
                                            		</div>
                                            </td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%" class="text-left"><span><strong>8.</strong></span> &nbsp; Interest and Penalty (see instruction Sheet II)</td>
                                            <td width="25%" class="text-left">                                              
                                                 <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                            	<input class="form-control input-sm table_custom_input" id=txtBPTez1_8 onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength=10 >
                                                            </div>
                                                          </div>                                            
                                            		</div>
                                            </td>
                                        </tr>
                                        <tr >
                                            <td width="70%" class="text-left"> <label id=lblSchoolRate style="width:70%">9.  <u><b>TOTAL DUE</b></u> including Interest and Penalty<br>
					<b>Use payment coupon. Make check payable to: "City of Philadelphia"[Calculated - add line 7 and 8]</td>
                                            <td width="25%" class="text-left">                                               
                                                 <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                            	<label id=lblBPTez1_9 style="WIDTH: 100%"></label>
                                                            </div>
                                                          </div>                                            
                                            		</div>
                                            </td>
                                        </tr>
                                        <tr class="odd">
                                            <td><u><b>OVERPAYMENT OPTIONS</b></u></td>
                                            <td width="25%" class="text-left">
                                              </td>
                                        </tr>
                                        <tr >
                                            <td width="70%" class="text-left"><span><strong>10a.</strong></span> &nbsp; Refunded. <b>Do not file separate Refund Petition</b></td>
                                            <td width="25%" class="text-left">                                              
                                                <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                            	 <input class="form-control input-sm table_custom_input" id=txtBPTez1_10a onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%">
                                                            </div>
                                                          </div>                                            
                                            		</div>
                                            </td>
                                        </tr>
                                        <tr class="odd">
                                            <td class="text-left"><span><strong>10b.</strong></span> &nbsp; Applied, up to the tax due,	to the 2011 Net Profits Tax Return<</td>
                                            <td width="25%" class="text-left">                                                
                                                <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                            	 <input class="form-control input-sm table_custom_input" id=txtBPTez1_10b onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%">
                                                            </div>
                                                          </div>                                            
                                            		</div>
                                                </td>
                                        </tr>
                                        <tr>
                                            <td width="70%" class="text-left"><span><strong>10c.</strong></span> &nbsp; Applied to the 2012	Business Income & Receipts Tax</td>
                                            <td width="25%" class="text-left">
                                              
                                                <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                            	  <input class="form-control input-sm table_custom_input" id=txtBPTez1_10c onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%">
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


                           <div>
                                <%Html.RenderAction("PreparerSection", "INC");%>

                           </div>
                            <div class="form-group">
                             <div class="col-sm-offset-3 col-sm-9  text-right">
                                <input type="button" value="Print" class="btn btn-default submit_button_light" onclick="return btnBPTezPrint_onclick()" id="btnBPTezPrint"/>
                                <input type="button" value="Submit" class="btn btn-default submit_button" id="btnBPTezSubmit" onclick="return btnBPTezSubmit_onclick()" />
                            </div>
                            </div>
                          </div>

                            <div style="DISPLAY:none" Id="BPTez_pg2" Name="BPTez_pg2">

                            <div class="row table-responsive">
                             <div class="col-lg-12" >

                                <table summary="Employee Pay Sheet" class="table table-condensed table-striped custom_table03">

                                    <tbody>

                                        <tr class="odd">
                                            <td width="70%" class="text-left"><span><strong>1.</strong></span> &nbsp; <INPUT type="radio" id=radBPTez2_1_2_m2 name=radBPTez2_1_2 onclick="ValidateBPTezMethod()">
		METHOD II. Net Income (or loss) as properly reported to 
					the Federal Government</td>
                                           
                                            <td class="text-left">                                            
                                                 <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                            	 <input class="form-control input-sm" id=txtBPTez2_1 onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength=10 >
                                                            </div>
                                                          </div>                                            
                                            		</div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>OR
                                            </td>
                                            <td class="text-left">
                                              	<label style="WIDTH: 100%"></label>

                                            </td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%" class="text-left"><span><strong>2.</strong></span> &nbsp; <INPUT type="radio" id=radBPTez2_1_2_m1 name=radBPTez2_1_2 onclick="ValidateBPTezMethod()">
			METHOD I. Net Income (or loss) in accordance with Accounting
					System</td>
                                            <td class="text-left">                                            
                                                <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                            	 <input class="form-control input-sm" id=txtBPTez2_2 onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength=10 >
                                                            </div>
                                                          </div>                                            
                                            		</div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-left"><span><strong>3.</strong></span> &nbsp; Loss Carry Foward, if any. (<u><font style="cursor:pointer;" onclick="parent.InstructionLinks()">See Instruction Sheet IV</font></u>)</td>
                                            <td class="text-left">                                               	
                                                 <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                            	<input class="form-control input-sm" id=txtBPTez2_3 onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength=10 >
                                                            </div>
                                                          </div>                                            
                                            		</div>
                                            </td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%" class="text-left"><span><strong>4.</strong></span> &nbsp; Taxable Income or Less [Calculated - line 1 OR 2 minus line 3] </td>
                                            <td class="text-left">                                            
                                                <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                            	<label id=lblBPTez2_4 style="WIDTH: 100%"></label>
                                                            </div>
                                                          </div>                                            
                                            		</div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-left"><span><strong>5.</strong></span> &nbsp; TAX DUE <label class="" id=msgBPTez2_5 style="width:100%">[Calculated - line 4 * ###]&nbsp;</label></td>
                                            <td class="text-left">                                              
                                                <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                            	 <label id=lblBPTez2_5 style="WIDTH: 100%"></label>
                                                            </div>
                                                          </div>                                            
                                            		</div>
                                            </td>
		                                   <td colspan=3 class="">
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%"><u>GROSS RECEIPTS PORTION</u> </td>
                                            <td class="text-left">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>TAXABLE GROSS RECEIPTS from:</td>
                                            <td class="text-left">
                                              </td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%" class="text-left"><span><strong>6a.</strong></span> &nbsp; Sales and/or Rentals of Tangible Personal Property </td>
                                            <td class="text-left">                                            
                                                 <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                            	 <input class="form-control input-sm" id=txtBPTez2_6a onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%">
                                                            </div>
                                                          </div>                                            
                                            		</div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-left"><span><strong>6b.</strong></span> &nbsp; Net Tax Due[Calculated - line 5 minus 6c]</td>
                                            <td class="text-left">                                               
                                                 <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                            	 <input class="form-control input-sm" id=txtBPTez2_6b onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength=10 >
                                                            </div>
                                                          </div>                                            
                                            		</div>
                                            </td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%" class="text-left"><span><strong>6c.</strong></span> &nbsp; Rentals of Real Property</td>
                                            <td class="text-left">                                           
                                                 <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                            	 <input class="form-control input-sm" id=txtBPTez2_6c onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength=10 >
                                                            </div>
                                                          </div>                                            
                                            		</div>
                                            </td>
                                        </tr>

                                         <tr>
                                            <td class="text-left"><span><strong>6d.</strong></span> &nbsp; Royalties</td>
                                            <td class="text-left">                                              	
                                                 <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                            	<input class="form-control input-sm" id=txtBPTez2_6d onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%">
                                                            </div>
                                                          </div>                                            
                                            		</div>
                                            </td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%" class ="text-left"><span><strong>6e.</strong></span> &nbsp;  Gains on Sales of Business Capital Assets</td>
                                            <td class="text-left">                                          
                                                 <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                            	 <input class="form-control input-sm" id=txtBPTez2_6e onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength=10 >
                                                            </div>
                                                          </div>                                            
                                            		</div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="70%" class="text-left"><span><strong>6f.</strong></span> &nbsp; Gains on Sales of Stocks, Bonds, etc. (not applicable to individuals)</td>
                                            <td class="text-left">                                          	
                                                <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                            	<input class="form-control input-sm" id=txtBPTez2_6f onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength=10 >
                                                            </div>
                                                          </div>                                            
                                            		</div>
                                            </td>
                                        </tr>
                                           <tr class="odd">
                                            <td width="70%" class="text-left"><span><strong>6g.</strong></span> &nbsp; Dividends (not applicable to individuals)</td>
                                            <td class="text-left">                                          
                                                 <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                            	 <input class="form-control input-sm" id=txtBPTez2_6g onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength=10 >
                                                            </div>
                                                          </div>                                            
                                            		</div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-left"><span><strong>6h.</strong></span> &nbsp; Interest (not applicable to individuals)</td>
                                            <td class="text-left">                                            	
                                                 <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                            	<input class="form-control input-sm" id=txtBPTez2_6h onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength=10 >
                                                            </div>
                                                          </div>                                            
                                            		</div>
                                            </td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%" class="text-left"><span><strong>6i.</strong></span> &nbsp; Other (Describe)</td>
                                            <td class="text-left">                                           
                                                 <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                            	 <input class="form-control input-sm" id=txtBPTez2_6i onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength=10 >
                                                            </div>
                                                          </div>                                            
                                            		</div>
                                            </td>
                                        </tr>

                                         <tr >
                                            <td class="text-left"><span><strong>7.</strong></span> &nbsp; TOTAL TAXABLE GROSS RECEIPTS[Calculated - add lines 6a through 6i]</td>
                                            <td class="text-left">                                             
                                                 <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                            	 <label id=lblBPTez2_7 style="WIDTH: 100%"></label>
                                                            </div>
                                                          </div>                                            
                                            		</div>
                                            </td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%" class="text-left"><span><strong>8.</strong></span> &nbsp; TAX DUE<label class="" style="width:100%" id=msgBPTez2_8>[Calculated - line 7 * ###]&nbsp;</label></td>
                                            <td class="text-left">                                              
                                                 <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                            	<label id=lblBPTez2_8 style="WIDTH: 100%"></label>
                                                            </div>
                                                          </div>                                            
                                            		</div>
                                            </td>
                                        </tr>
                                        <tr >
                                            <td></td>
                                            <td width="25%" class="text-right">
                                               <input type="button" value="Go to Page 1" class="btn btn-default submit_button" id="btnGoToPage1" onclick="ShowPage(1)" /></td>
                                        </tr>
                                     
                                       
                                    </tbody>
                                </table>
                                <div class="clear"></div>
                                 </div>
                            </div>

</div>
                           </div>
                          </div>                    
                        </div>

                         <div class="clearfix"></div>
                    </div>
                   </div>

                </div>
               <%-- <div class="quicklink_btm_gen"></div>--%>
            </div>
                 <div class="clearfix"></div>
        </div>
            </div>
          </div>
        </div>        
    </div>
</body>
</html>
