<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

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
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<script id="clientEventHandlersJS" language="javascript" type="text/javascript">

    var arrBPTezErr = new Array();
    var txtHeader = 'Taxpayer Information';
    var dBPTezNetRate, dBPTezGrossRate;
    var b3800val = false;
    var sYear = '12';
    var mbFirstTime = false;
    var gUserAddr = '<%#  Request.ServerVariables["REMOTE_ADDR"] %>';
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
        $(parent.AppError).text('');
        //refresh bptez form
        //parent.$g.loadXmlSync('XML/BPTezReturn_2014', parent.parseXml_xmlBPTez);
        //parent.$g.loadXmlSync('XML/BPTezReturn_2014', parent.parseXml_xmlBPTezTemplate);
        parent.$g.loadXmlSync('XML/BPTezReturn_2015', parent.parseXml_xmlBPTez);
        parent.$g.loadXmlSync('XML/BPTezReturn_2015', parent.parseXml_xmlBPTezTemplate);

        if ($(parent.$g.xmlAccount).find("TAX_ACCT").find("ACCOUNT:contains('24')")) {

            //  parent.MenuWin.ispHighlightMenu(parent.mnuBPTezYear13); 	//.mnuBPTezYear10Page2

            $('#BPTez').css("display", "block");
            $('#BPTez_pg2').css("display", "block"); //binoy

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, 'INQ', 'BPT_INFO RETURN_STATUS', '', 0)
            var entityInfo_ACCOUNT_ID = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ACCOUNT_ID', "", 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, entityInfo_ACCOUNT_ID, 'BPT_INFO ACCOUNT_ID', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, '12/31/2015', 'BPT_INFO PERIOD', '', 0);

            $('#AppHeader').html(txtHeader + '<Font class=hdrMedium>|Business Income & Receipts Tax-EZ for 2015</Font>');
            //parent.MenuWin.gsInstructionItem = '#BptEz';// ? SUMAN Questionable mod for L & C
            parent.gsInstructionItem = '#BIR';
            $('#AppMessage').html(parent.gsInstructionText
                                  + '<BR>The Business Income & Receipts Tax for 205 is due April 18, 2016.');
            $('#InstructionText').html(' for Loss Carry Forward and Estimated Payments');
            //suman set last parameter true will cause xml copy to browser clipboard
            ispCallXMLForm(parent.$g.xmlBPTez_2015, parent.$g.xmlBPTez_2015, "BPTezReturn_2015", "");
            ispHideProgress();

            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'ERROR_INFO ERROR', "", 0) != 0) {
                $(parent.RightFrame).attr("rows", "*,0");
                $('#BPTez').css("display", "block");
                PopulateBPTezHeader();
                FieldLock(true);
                $(parent.AppError).text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'ERROR_INFO MESSAGE', "", 0));
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
            parent.$g.xmlBPTez_2015 = parent.$g.xmlBPTezTemplate_2015;
            parent.ispMenu_onclick(parent.mnuAcctInfo);
        }

        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_PG1 ACTUAL_TAX', '', 0) == '') {
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, 0, 'BPT_PG1 ACTUAL_TAX', '', 0);
        }

        //	if (parent.MenuWin.GetInnerNodeText(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', 'START_DATE', '24').slice(-4) == '2013') {
        //		alert('If you are a New Business that has or plans to meet the employment requirement to use the zero tax rate then you must file a paper return until programming for the website is complete.')
        //	}
        //if
        $(parent.RightFrame).attr("rows", "*,0");
        LoadBPTezError();

        RightAlignText();
        CheckBPTezXML();
        PopulateBPTezHeader();
        PopulateBPTezData();
        SetBPTezFields();
        $('#txtBPTez2_3').attr("disabled", "disabled");
        $(parent.AppError).text("");
        //    ShowPage(2);
        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_INFO RETURN_STATUS', '', 0) == 'A1' || parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_INFO RETURN_STATUS', '', 0) == 'A2') {
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_INFO VERSION', '', 0) == '') {

                $('#BPTez_pg2').css("visibility", "hidden");
                $('#BPTez_pg2').css("display", "none");
                $('#BPT_19_3800').css('display', 'block');
            } else {
                btn3800YN_onclick(null);
                ShowPage(2);
                //$('#BPTez_pg2').css("display", "block");
            } 	//if
        } else {
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_INFO PREPARER_NAME ', "", 0) != 0) {//:added this if block to solve the problem of  error message in fresh form.untill there is value in line 7 user wont be able to go to page1.
                ShowPage(2);
            }
            else {
                DisplayNetIncome();//Added for the radio box to check
                //ShowPage(2);
                $('#lblBPTez2_7').text(ispFormatMoney(0, 0));//("$0");
            }
            //$('#BPTez_pg2').css("display", "block");
        } 	//if
        GoToPage1Button();
    }//DisplayBPTez05Return


    function SetBPTezFields() {
        var chkAmended = document.getElementById("chkAmended");
        chkAmended.checked = false;

        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_INFO VERSION', '', 0) == '') {
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
            $('#txtBPTez2_3').attr("disabled", "disabled");
            $('#lblBPTez2_4').attr("disabled", "disabled");
            $('#lblBPTez2_5').attr("disabled", "disabled");
            $('#txtBPTez2_6a').attr("disabled", "disabled");
            $('#txtBPTez2_6b').attr("disabled", "disabled");
            $('#txtBPTez2_6c').attr("disabled", "disabled");
            $('#txtBPTez2_6d').attr("disabled", "disabled");
            $('#txtBPTez2_6e').attr("disabled", "disabled");
            $('#txtBPTez2_6f').attr("disabled", "disabled");
            $('#txtBPTez2_6g').attr("disabled", "disabled");
            $('#txtBPTez2_6h').attr("disabled", "disabled");
            $('#txtBPTez2_6i').attr("disabled", "disabled");
            $('#lblBPTez2_7').attr("disabled", "disabled");
            $('#lblBPTez2_8').attr("disabled", "disabled");
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

            //$('#txtBPTez2_3').removeAttr("disabled");
            $('#lblBPTez2_4').removeAttr("disabled");
            $('#lblBPTez2_5').removeAttr("disabled");
            $('#txtBPTez2_6a').removeAttr("disabled");
            $('#txtBPTez2_6b').removeAttr("disabled");
            $('#txtBPTez2_6c').removeAttr("disabled");
            $('#txtBPTez2_6d').removeAttr("disabled");
            $('#txtBPTez2_6e').removeAttr("disabled");
            $('#txtBPTez2_6f').removeAttr("disabled");
            $('#txtBPTez2_6g').removeAttr("disabled");
            $('#txtBPTez2_6h').removeAttr("disabled");
            $('#txtBPTez2_6i').removeAttr("disabled");
            $('#lblBPTez2_7').removeAttr("disabled");
            $('#lblBPTez2_8').removeAttr("disabled");

            DisablePreparer(bDisabled);
        }

    }//FieldLock


    function CheckBPTezXML() {
        var bPeriodExist = true;

        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_PG1 TOTAL_TAX', '', 0) == '$0') {
            bPeriodExist = false;
        }

        if (bPeriodExist == false) {
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, '', 'ERROR_INFO PROGRAM', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, '', 'ERROR_INFO ERROR', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, '', 'ERROR_INFO LINE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, '', 'ERROR_INFO MESSAGE', '', 0);

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, '12/31/2015', 'BPT_INFO PERIOD', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, '', 'BPT_INFO VERSION', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, '', 'BPT_INFO RETURN_STATUS', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, '', 'BPT_INFO LAST_UPD_DATE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, '', 'BPT_INFO RECORDING_DATE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, '', 'BPT_INFO EXTENSION_DATE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, '', 'BPT_INFO SEQUENCE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, '', 'BPT_INFO ADJUSTMENT_REF_NO', '', 0);

            ClearPreparerXML(parent.$g.xmlBPTez_2015, 'BPT_INFO');

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, 0, 'BPT_PG1 NET_TAX', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, 0, 'BPT_PG1 GROSS_TAX', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, 0, 'BPT_PG1 ACTUAL_TAX', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, 0, 'BPT_PG1 ESTIMATED_TAX', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, 0, 'BPT_PG1 TOTAL_TAX', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, 0, 'BPT_PG1 NPT_TAX_CREDIT', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, 0, 'BPT_PG1 BPT_TAX_CREDIT', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, 0, 'BPT_PG1 TOTAL_PAY_CREDIT', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, 0, 'BPT_PG1 TAX_DUE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, 0, 'BPT_PG1 INTEREST_PENALTY', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, 0, 'BPT_PG1 AMOUNT_OWED', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, 0, 'BPT_PG1 REFUND', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, 0, 'BPT_PG1 NPT_OVERPAY', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, 0, 'BPT_PG1 BPT_OVERPAY', '', 0);

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, 0, 'BPT_PG2 NET_INCOME_LOSS_1', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, 0, 'BPT_PG2 NET_INCOME_LOSS_2', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, 0, 'BPT_PG2 LOSS_CARRY_FORWARD', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, 0, 'BPT_PG2 TAXABLE_INCOME', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, 0, 'BPT_PG2 TAX_DUE_NET', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, 0, 'BPT_PG2 SALES_RENTAL', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, 0, 'BPT_PG2 SERVICES', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, 0, 'BPT_PG2 RENTAL_PROPERTY', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, 0, 'BPT_PG2 ROYALTIES', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, 0, 'BPT_PG2 CAPITAL_GAINS', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, 0, 'BPT_PG2 STOCK_GAINS', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, 0, 'BPT_PG2 DIVIDENDS', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, 0, 'BPT_PG2 INTEREST', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, 0, 'BPT_PG2 OTHER', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, 0, 'BPT_PG2 TAXABLE_GROSS_RCPTS', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, 0, 'BPT_PG2 TAX_DUE_GROSS', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, 0, 'BPT_PG2 STAT_NET_DEDUCTION_1_X', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, 0, 'BPT_PG2 TAXABLE_SUBTOTAL_EZ_X', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, 0, 'BPT_PG2 STAT_EXCLUSION_EZ_X', '', 0);
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

        dBPTezNetRate = parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_INFO NET_RATE', '', 0);
        dBPTezGrossRate = parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_INFO GROSS_RATE', '', 0);
        // alert(dBPTezGrossRate);
        $('#msgBPTez2_5').text($('#msgBPTez2_5').text().replace('###', dBPTezNetRate));
        $('#msgBPTez2_8').text($('#msgBPTez2_8').text().replace('###', dBPTezGrossRate));
        //Page1
        $('#lblBPTez1_1').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_PG1 NET_TAX', '', 0), 0));
        $('#lblBPTez1_2').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_PG1 GROSS_TAX', '', 0), 0));
        $('#lblBPTez1_3').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_PG1 ACTUAL_TAX', '', 0), 0));
        $('#txtBPTez1_4').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_PG1 ESTIMATED_TAX', '', 0), 0));
        $('#lblBPTez1_5').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_PG1 TOTAL_TAX', '', 0), 0));
        $('#txtBPTez1_6a').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_PG1 NPT_TAX_CREDIT', '', 0), 0));
        $('#txtBPTez1_6b').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_PG1 BPT_TAX_CREDIT', '', 0), 0));
        $('#lblBPTez1_6c').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_PG1 TOTAL_PAY_CREDITS', '', 0), 0));
        $('#lblBPTez1_7').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_PG1 TAX_DUE', '', 0), 0));
        $('#txtBPTez1_8').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_PG1 INTEREST_PENALTY', '', 0), 0));
        $('#lblBPTez1_9').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_PG1 AMOUNT_OWED', '', 0), 0));
        $('#txtBPTez1_10a').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_PG1 REFUND', '', 0), 0));
        $('#txtBPTez1_10b').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_PG1 NPT_OVERPAY', '', 0), 0));
        $('#txtBPTez1_10c').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_PG1 BPT_OVERPAY', '', 0), 0));

        PopulatePreparer(parent.$g.xmlBPTez_2015, 'BPT_INFO');

        //Page2
        $('#txtBPTez2_2').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_PG2 NET_INCOME_LOSS_1', '', 0), 0));
        $('#txtBPTez2_1').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_PG2 NET_INCOME_LOSS_2', '', 0), 0));
        $('#lbl_BPTez2_3').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_PG2 STAT_NET_DEDUCTION_1_X', '', 0), 0));
        $('#txtBPTez2_4').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_PG2 LOSS_CARRY_FORWARD', '', 0), 0));
        $('#lblBPTez2_5').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_PG2 TAXABLE_INCOME', '', 0), 0));
        $('#lblBPTez2_6').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_PG2 TAX_DUE_NET', '', 0), 0));
        $('#txtBPTez2_7a').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_PG2 SALES_RENTAL', '', 0), 0));
        $('#txtBPTez2_7b').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_PG2 SERVICES', '', 0), 0));
        $('#txtBPTez2_7c').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_PG2 RENTAL_PROPERTY', '', 0), 0));
        $('#txtBPTez2_7d').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_PG2 ROYALTIES', '', 0), 0));
        $('#txtBPTez2_7e').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_PG2 CAPITAL_GAINS', '', 0), 0));
        $('#txtBPTez2_7f').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_PG2 STOCK_GAINS', '', 0), 0));
        $('#txtBPTez2_7g').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_PG2 DIVIDENDS', '', 0), 0));
        $('#txtBPTez2_7h').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_PG2 INTEREST', '', 0), 0));
        $('#txtBPTez2_7i').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_PG2 OTHER', '', 0), 0));
        $('#lblBPTez2_8').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_PG2 TAXABLE_SUBTOTAL_EZ_X', '', 0), 0));
        $('#txtBPTez2_9').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_PG2 STAT_EXCLUSION_EZ_X', '', 0), 0));
        $('#lblBPTez2_10').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_PG2 TAXABLE_GROSS_RCPTS', '', 0), 0));
        $('#lblBPTez2_11').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_PG2 TAX_DUE_GROSS', '', 0), 0));

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

        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, lMonth + '/' + lDate + '/' + lYear, 'BPT_INFO RECORDING_DATE', '', 0);
        //Page1
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, stripCurrency($('#lblBPTez1_1').text()), 'BPT_PG1 NET_TAX', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, stripCurrency($('#lblBPTez1_2').text()), 'BPT_PG1 GROSS_TAX', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, stripCurrency($('#lblBPTez1_3').text()), 'BPT_PG1 ACTUAL_TAX', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, stripCurrency($('#txtBPTez1_4').val()), 'BPT_PG1 ESTIMATED_TAX', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, stripCurrency($('#lblBPTez1_5').text()), 'BPT_PG1 TOTAL_TAX', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, stripCurrency($('#txtBPTez1_6a').val()), 'BPT_PG1 NPT_TAX_CREDIT', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, stripCurrency($('#txtBPTez1_6b').val()), 'BPT_PG1 BPT_TAX_CREDIT', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, stripCurrency($('#lblBPTez1_6c').text()), 'BPT_PG1 TOTAL_PAY_CREDITS', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, stripCurrency($('#lblBPTez1_7').text()), 'BPT_PG1 TAX_DUE', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, stripCurrency($('#txtBPTez1_8').val()), 'BPT_PG1 INTEREST_PENALTY', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, stripCurrency($('#lblBPTez1_9').text()), 'BPT_PG1 AMOUNT_OWED', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, stripCurrency($('#txtBPTez1_10a').val()), 'BPT_PG1 REFUND', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, stripCurrency($('#txtBPTez1_10b').val()), 'BPT_PG1 NPT_OVERPAY', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, stripCurrency($('#txtBPTez1_10c').val()), 'BPT_PG1 BPT_OVERPAY', '', 0);
        PopulatePreparerXML(parent.$g.xmlBPTez_2015, 'BPT_INFO');

        //Page2
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, stripCurrency($('#txtBPTez2_2').val()), 'BPT_PG2 NET_INCOME_LOSS_1', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, stripCurrency($('#txtBPTez2_1').val()), 'BPT_PG2 NET_INCOME_LOSS_2', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, stripCurrency($('#lbl_BPTez2_3').text()), 'BPT_PG2 STAT_NET_DEDUCTION_1_X', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, stripCurrency($('#txtBPTez2_4').val()), 'BPT_PG2 LOSS_CARRY_FORWARD', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, stripCurrency($('#lblBPTez2_5').text()), 'BPT_PG2 TAXABLE_INCOME', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, stripCurrency($('#lblBPTez2_6').text()), 'BPT_PG2 TAX_DUE_NET', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, stripCurrency($('#txtBPTez2_7a').val()), 'BPT_PG2 SALES_RENTAL', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, stripCurrency($('#txtBPTez2_7b').val()), 'BPT_PG2 SERVICES', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, stripCurrency($('#txtBPTez2_7c').val()), 'BPT_PG2 RENTAL_PROPERTY', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, stripCurrency($('#txtBPTez2_7d').val()), 'BPT_PG2 ROYALTIES', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, stripCurrency($('#txtBPTez2_7e').val()), 'BPT_PG2 CAPITAL_GAINS', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, stripCurrency($('#txtBPTez2_7f').val()), 'BPT_PG2 STOCK_GAINS', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, stripCurrency($('#txtBPTez2_7g').val()), 'BPT_PG2 DIVIDENDS', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, stripCurrency($('#txtBPTez2_7h').val()), 'BPT_PG2 INTEREST', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, stripCurrency($('#txtBPTez2_7i').val()), 'BPT_PG2 OTHER', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, stripCurrency($('#lblBPTez2_8').text()), 'BPT_PG2 TAXABLE_SUBTOTAL_EZ_X', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, stripCurrency($('#txtBPTez2_9').val()), 'BPT_PG2 STAT_EXCLUSION_EZ_X', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, stripCurrency($('#lblBPTez2_10').text()), 'BPT_PG2 TAXABLE_GROSS_RCPTS', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, stripCurrency($('#lblBPTez2_11').text()), 'BPT_PG2 TAX_DUE_GROSS', '', 0);

        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, '', 'DEBUG', '', 0);

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
        $('#txtBPTez2_9').css("text-align", "right");
        $('#lblBPTez2_10').css("text-align", "right");
        $('#lblBPTez2_11').css("text-align", "right");
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
        var txtBPTez2_9 = document.getElementById("txtBPTez2_9");
        var txt_BPT_WSEZ1 = document.getElementById("txt_BPT_WSEZ1");
        var txt_BPT_WSEZ4 = document.getElementById("txt_BPT_WSEZ4");
        
        var i = 0;

        //Page1
        arrBPTezErr[i++] = [txtTermDate, '$(\'#txtTermDate\').val() != "" & ispValidateDate($(\'#txtTermDate\').val()) == false', 'Invalid to termination date'];

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

        arrBPTezErr[i++] = [txtBPTez2_4, '$(\'#txtBPTez2_4\').val() == ""', 'Answer Question 4'];
        arrBPTezErr[i++] = [txtBPTez2_4, 'ispValue($(\'#txtBPTez2_4\').val()) == false', 'Value for Question 4 must be numeric'];
        arrBPTezErr[i++] = [txtBPTez2_4, 'ispNegativeNumber($(\'#txtBPTez2_4\').val()) == false', 'Value for Question 4 must NOT be negative'];
       
        arrBPTezErr[i++] = [txtBPTez2_7a, '$(\'#txtBPTez2_7a\').val() == ""', 'Answer Question 7a'];
        arrBPTezErr[i++] = [txtBPTez2_7a, 'ispValue($(\'#txtBPTez2_7a\').val()) == false', 'Value for Question 7a must be numeric'];
        arrBPTezErr[i++] = [txtBPTez2_7a, 'ispNegativeNumber($(\'#txtBPTez2_7a\').val()) == false', 'Value for Question 7a must NOT be negative'];

        arrBPTezErr[i++] = [txtBPTez2_7b, '$(\'#txtBPTez2_7b\').val() == ""', 'Answer Question 7b'];
        arrBPTezErr[i++] = [txtBPTez2_7b, 'ispValue($(\'#txtBPTez2_7b\').val()) == false', 'Value for Question 7b must be numeric'];
        arrBPTezErr[i++] = [txtBPTez2_7b, 'ispNegativeNumber($(\'#txtBPTez2_7b\').val()) == false', 'Value for Question 7b must NOT be negative'];
      
        arrBPTezErr[i++] = [txtBPTez2_7c, '$(\'#txtBPTez2_7c\').val() == ""', 'Answer Question 7c'];
        arrBPTezErr[i++] = [txtBPTez2_7c, 'ispValue($(\'#txtBPTez2_7c\').val()) == false', 'Value for Question 7c must be numeric'];
        arrBPTezErr[i++] = [txtBPTez2_7c, 'ispNegativeNumber($(\'#txtBPTez2_7c\').val()) == false', 'Value for Question 7c must NOT be negative'];

        arrBPTezErr[i++] = [txtBPTez2_7d, '$(\'#txtBPTez2_7d\').val() == ""', 'Answer Question 7d'];
        arrBPTezErr[i++] = [txtBPTez2_7d, 'ispValue($(\'#txtBPTez2_7d\').val()) == false', 'Value for Question 7d must be numeric'];
        arrBPTezErr[i++] = [txtBPTez2_7d, 'ispNegativeNumber($(\'#txtBPTez2_7d\').val()) == false', 'Value for Question 7d must NOT be negative'];
      
        arrBPTezErr[i++] = [txtBPTez2_7e, '$(\'#txtBPTez2_7e\').val() == ""', 'Answer Question 7e'];
        arrBPTezErr[i++] = [txtBPTez2_7e, 'ispValue($(\'#txtBPTez2_7e\').val()) == false', 'Value for Question 7e must be numeric'];
        arrBPTezErr[i++] = [txtBPTez2_7e, 'ispNegativeNumber($(\'#txtBPTez2_7e\').val()) == false', 'Value for Question 7e must NOT be negative'];

        arrBPTezErr[i++] = [txtBPTez2_7f, '$(\'#txtBPTez2_7f\').val() == ""', 'Answer Question 7f'];
        arrBPTezErr[i++] = [txtBPTez2_7f, 'ispValue($(\'#txtBPTez2_7f\').val()) == false', 'Value for Question 7f must be numeric'];
        arrBPTezErr[i++] = [txtBPTez2_7f, 'ispNegativeNumber($(\'#txtBPTez2_7f\').val()) == false', 'Value for Question 7f must NOT be negative'];
      
        arrBPTezErr[i++] = [txtBPTez2_7g, '$(\'#txtBPTez2_7g\').val() == ""', 'Answer Question 7g'];
        arrBPTezErr[i++] = [txtBPTez2_7g, 'ispValue($(\'#txtBPTez2_7g\').val()) == false', 'Value for Question 7g must be numeric'];
        arrBPTezErr[i++] = [txtBPTez2_7g, 'ispNegativeNumber($(\'#txtBPTez2_7g\').val()) == false', 'Value for Question 7g must NOT be negative'];

        arrBPTezErr[i++] = [txtBPTez2_7h, '$(\'#txtBPTez2_7h\').val() == ""', 'Answer Question 7h'];
        arrBPTezErr[i++] = [txtBPTez2_7h, 'ispValue($(\'#txtBPTez2_7h\').val()) == false', 'Value for Question 7h must be numeric'];
        arrBPTezErr[i++] = [txtBPTez2_7h, 'ispNegativeNumber($(\'#txtBPTez2_7h\').val()) == false', 'Value for Question 7h must NOT be negative'];

        arrBPTezErr[i++] = [txtBPTez2_7i, ' $(\'#txtBPTez2_7i\').val() == ""', 'Answer Question 7i'];
        arrBPTezErr[i++] = [txtBPTez2_7i, 'ispValue($(\'#txtBPTez2_7i\').val()) == false', 'Value for Question 7i must be numeric'];
        arrBPTezErr[i++] = [txtBPTez2_7i, 'ispNegativeNumber($(\'#txtBPTez2_7i\').val()) == false', 'Value for Question 7i must NOT be negative'];

        arrBPTezErr[i++] = [txtBPTez2_9, ' $(\'#txtBPTez2_9\').val() == ""', 'Answer Question 9'];
        arrBPTezErr[i++] = [txtBPTez2_9, 'ispValue($(\'#txtBPTez2_9\').val()) == false', 'Value for Question 9 must be numeric'];
        arrBPTezErr[i++] = [txtBPTez2_9, 'ispNegativeNumber($(\'#txtBPTez2_9\').val()) == false', 'Value for Question 9 must NOT be negative'];

        arrBPTezErr[i++] = [txt_BPT_WSEZ1, ' $(\'#txt_BPT_WSEZ1\').val() == ""', 'Answer Question S1'];
        arrBPTezErr[i++] = [txt_BPT_WSEZ1, 'ispValue($(\'#txt_BPT_WSEZ1\').val()) == false', 'Value for Question S1 must be numeric'];
        arrBPTezErr[i++] = [txt_BPT_WSEZ1, 'ispNegativeNumber($(\'#txt_BPT_WSEZ1\').val()) == false', 'Value for Question S1 must NOT be negative'];

        arrBPTezErr[i++] = [txt_BPT_WSEZ4, ' $(\'#txt_BPT_WSEZ4\').val() == ""', 'Answer Question S4'];
        arrBPTezErr[i++] = [txt_BPT_WSEZ4, 'ispValue($(\'#txt_BPT_WSEZ4\').val()) == false', 'Value for Question S4 must be numeric'];
        arrBPTezErr[i++] = [txt_BPT_WSEZ4, 'ispNegativeNumber($(\'#txt_BPT_WSEZ4\').val()) == false', 'Value for Question S4 must NOT be negative'];
        

    }//LoadBPTezError

    function btnBPTezPrint_onclick() {
        var currDisplayedObjId, lBPTez_pg2, objCurrDisplayed, lBPTez_WrkShtN;

        //	lBPTez_pg2 = $('#BPTez_pg2').html();
        //	lBPTez_WrkShtN = $('#BPTez_WrkShtNE').html();
        $('#btnBPTezPrint').css("visibility", "hidden");
        $('#btnBPTezSubmit').css("visibility", "hidden");
        $('#BPTez_pg2').css("page-break-before", "always");
        $('#BPTez_WrkShtNE').css('pageBreakBefore', 'always');

        /*	if ($('#BPTez_pg1').css("display", "block")) {
                currDisplayedObjId = 'BPTez_pg1';
                $('#BPTez_pg2').css("display", "block");
            } 
            else {
                currDisplayedObjId = 'BPTez_pg2';
                $('#BPTez_pg1').css("display", "block");
            }	*/

        $(parent.AppError).text('');
        $('#BPTez_pg1').css('display', 'block');
        $('#BPTez_pg2').css('display', 'block');
        $('#BPTez_WrkShtNE').css('display', 'block');

        //	$('#BPTez_pg2').prepend($('#BPTezHeader').html() + '<BR>');
        //	$('#BPTez_WrkShtNE').prepend($('#BPTezHeader').html() + '<BR>');
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
            //$('#BPTez_WrkShtNE').html(lBPTez_WrkShtN);
            //----------------------------------------------------------------------------------------------------
            FieldLock(true);
        }
        else {
            window.print();
            //REF. BLOCK 1.1
            //$('#BPTez_pg2').html(lBPTez_pg2);
            //$('#BPTez_WrkShtNE').html(lBPTez_WrkShtN);
            //-------------------------------------
        }

        //	$('#BPTez_pg2').html(lBPTez_pg2);
        //	$('#BPTez_WrkShtNE').html(lBPTez_WrkShtN);
        $('#btnBPTezPrint').css("visibility", "visible");
        $('#btnBPTezSubmit').css("visibility", "visible");
        $('#BPTez_pg1').css('display', 'block');
        $('#BPTez_pg2').css('display', 'none');
        $('#BPTez_WrkShtNE').css('display', 'none');

        /*	if (currDisplayedObjId == 'BPTez_pg1') {
                $('#BPTez_pg2').css("display", "none");
            } 
            else {
                $('#BPTez_pg1').css("display", "none");
            }
            return false;	*/
    }//btnBPTezPrint_onclick

    function btnBPTezSubmit_onclick() {

        $(parent.AppError).text("");
        ValidateBPTezReturn();
        txtTermDate_onblur();
        if (cCur($('#txt_BPT_WSEZ1').val()) > cCur($("#lblBPTez2_8").text())) {
            if (cCur($('#txt_BPT_WSEZ1').val()) != 50000) {
                $(parent.AppError).text('S1 value must be lower of Line 8 of Page 2 or $50,000');
            }

        }

        if ($(parent.AppError).text() == "") {
            $(parent.AppError).text(ValidatePreparer());
        }

        if ($(parent.AppError).text() == "") {
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, '', 'BPT_INFO RETURN_STATUS', '', 0);
            PopulateBPTezXML();

            ispCallXMLForm(parent.$g.xmlBPTez_2015, parent.$g.xmlBPTez_2015, "BPTezReturn_2015", "");

            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'ERROR_INFO PROGRAM', '', 0) == '') {
                $('#BPTez').css("display", "none");
                DisplayBPTezThankYou();
            }
            else {
                $(parent.AppError).text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'ERROR_INFO MESSAGE', '', 0));
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
        //alert(sPrevWrkShtLine8);


        $(parent.AppError).text('');
        var FocusItem
        //Added for making the Line 8 disable, as when going from page 2 to page 1, this was called and the line8 gets enabled

        ValidateBPTezReturn();

        if (iPage == 2) {

            sCurrWrkSht = '2'
            $('#BPTez_pg2').css("visibility", "visible");
            $('#BPTez_pg2').css("display", "block");
            $('#btnBPTezSubmit').removeAttr("disabled");
            //Sangha
            //CheckPage2Line4();
            //CalcPage2Line5();
            //CalcPage2Line6(dBPTezNetRate);
            //CalcPage2Line7();
            //CalcPage2Line8(dBPTezGrossRate);
            //$('#btnGoToPage1').removeAttr("disabled");

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
        } else {
            sCurrWrkSht = '1'

            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_INFO RETURN_STATUS', '', 0) == 'A1' || parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_INFO RETURN_STATUS', '', 0) == 'A2') {
                //SUMAN : AS PER REQUIREMENT DICUSSED ON 29TH JAN 2014, CLIENT DONT WANT SCHEDULE N LINK IF USER CHOSE YES OPTION
                if ($("#btnYes").is(":checked") == false) {
                    $('#lblLnkSchdN1').html('<label class="lblInstrNormal"> or </label>' +
                            '<label class="lblLink" style="FONT-SIZE: 7pt" onclick=ShowPage("WrkShtN")> Worksheet N, Line 2</label>');
                    $('#lblLnkSchdN2').html('<label class="lblInstrNormal"> or </label>' +
                            '<label class="lblLink" style="FONT-SIZE: 7pt" onclick=ShowPage("WrkShtN")> Worksheet N, Line 4</label>');
                }
            } 	//if
            if (sPrevWrkSht == '2') {

                if ($('#btnYes').is(':checked') == true) {
                    $('#lblBPTez1_1').text(ispFormatMoney(0, 0));
                    $('#lblBPTez1_2').text(ispFormatMoney(0, 0));
                } else {
                    $('#lblBPTez1_1').text($('#lblBPTez2_6').text());
                    $('#lblBPTez1_2').text($('#lblBPTez2_11').text());
                } //if

            } else if (sPrevWrkSht == 'WrkShtN') {
                DisplayWrkShtN();
                //$('#lblBPTez1_1').text(ispFormatMoney($('#lblWrkShtN_2').text(), 0));
                //$('#lblBPTez1_2').text(ispFormatMoney($('#lblWrkShtN_4').text(), 0));
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

        loadpage();
        //if
    }//ShowPage
    //Termination Date
    function txtTermDate_onblur() {
        if ($(parent.AppError).text() == "" && $('#txtTermDate').val() != '') {

            var strBD = ispValidateDate($('#txtTermDate').val());

            if (strBD == false) {
                $(parent.AppError).text('Invalid termination date');
                $('#txtTermDate').addClass("inpError");
                blnErr = true;
            }
            else {

                $('#txtTermDate').addClass("form-control input-sm");
                $('#txtTermDate').val(strBD);
            }
        }
        else {
            $('#txtTermDate').addClass("form-control input-sm");
        }
    }

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
            //parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, "A1", 'BPT_INFO RETURN_STATUS', '', 0); //temporarily

            $('#btnYes').attr('checked', false);
            $('#btnNo').attr('checked', false);
            //alert(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_INFO RETURN_STATUS', '', 0));
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_INFO RETURN_STATUS', '', 0) == 'A1' || parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_INFO RETURN_STATUS', '', 0) == 'A2') {
                //alert('1');
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
                if ($('#BPTez_pg1').css('display') == 'block')
                {
                   // txtBPTez1_6a;
                }
                else {
                    DisplayNetIncome();
                }
            }
        }
        else {
            //sangha
            // $('#BPTez_pg2').css("visibility", "visible");
            // $('#BPTez_pg2').css("display", "block");
            //sangha
            $('#BPT_19_3800').css('display', 'none');
            PopulateBPTezData();
            $('#btnBPTezSubmit').attr("disabled", "disable");
            FieldLock(true);
            PopulatePreparer(parent.$g.xmlBPTez_2015, 'BPT_INFO');
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
                $('#txtBPTez2_2').val(ispFormatMoney(0, 0));
                $('#txtBPTez2_2').attr("disabled", "disable");
                $('#txtBPTez2_1').removeAttr("disabled");
                $('#txtBPTez2_1').focus();
            }

            ValidateBPTezReturn();
        }
    }//ValidateBPTezMethod

    function ValidateBPTezReturn() {       
        var ObjSelected = getActiveElement();
        //	if(ObjSelected == undefined || ObjSelected == null ){
        //		return;
        //	}

        $(parent.AppError).text(ispSetInputErr(arrBPTezErr));



        if ($(parent.AppError).text() == "") //Sanghamitra
        {
            //this validation should not run for buttons as because it will try to change button text then
            if (ObjSelected != undefined || ObjSelected != null) {
                if (ObjSelected.type != 'button') {

                    ObjSelected.value = ispFormatMoney(ObjSelected.value, 0);

                }
            }          
            //	    ObjSelected.value = ispFormatMoney(ObjSelected.value, 0);
            CheckPage2Line4();
            CalcPage2Line5();
            CalcPage2Line6(dBPTezNetRate);
            CalcPage2Line8();
            CalcPage2Line9();
            CalcPage2Line10();
            CalcPage2Line11(dBPTezGrossRate);
            //    if (b3800val == false ||
            //				b3800val == true && ($('#btnNo').is(':checked') == true)) {
            CalcPage1Line3();
            CalcPage1Line5();
            CalcPage1Line6c();
            CalcPage1Line7();
            CalcPage1Line9_10();
            //    }		//if
            PerformCalcsBPTezWrkShtN();
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
        }

        GoToPage1Button();
    }//ValidateBPTezReturn

    function GoToPage1Button() {
        var iIncomeTaxDue = cCur($('#lblBPTez2_5').text());//.replace('$', '');
        var iReceiptTaxDue = cCur($('#lblBPTez2_8').text());//.replace('$', '');
        //var iIncomeTaxDue = iIncomeTaxDue.replace(',','')
        //var iReceiptTaxDue = iReceiptTaxDue.replace(',','')
        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, 'BPT_INFO PREPARER_NAME ', "", 0) == 0 && iReceiptTaxDue == 0)//added this if block to disable the "go to page1" button in case of fresh form and it wont get activated untill there is value in Page1, line 7 
        {
            $('#btnGoToPage1').attr("disabled", "disable");
            $(parent.AppError).text('Gross Receipts Portions needs to be filled out before going to Page 1');
        }
        else {
            if (iIncomeTaxDue > 0 && iReceiptTaxDue == 0) {
                $('#mnuBPTezYear06Page1', parent).attr("disabled", "disable");


                $('#btnGoToPage1').attr("disabled", "disable");
                //$('#AppError').text("Page 2, Line 7 can not be zero"); SUMAN
                $(parent.AppError).text('Gross Receipts Portions needs to be filled out before going to Page 1');

            }
            else {

                $('#mnuBPTezYear06Page1', parent).removeAttr("disabled");
                $('#btnGoToPage1').removeAttr("disabled");
                // $('#AppError').text("");
                //$(parent.AppError).text('');//comment by manoranjan
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
                    if (new Date(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'TAX_ACCT START_DATE', '', i)) >= new Date("01/01/2015"))
                    {
                        $('#txtBPTez2_4').val(ispFormatMoney(0, 0));//'$0';
                        alert('This return is not eligible for Loss Carry Forward, because your BPT Start Date '
                             + BPTStartDate
                             + ' is on or after 01/01/2015. Loss Carry Forward (Page 2, Question #4) has been set to zero.');
                    }
                }
            }
        }
    }

    function BirtEz_3800(btnClicked) {
        if ($('#div19_3800Msg').html() != '') {
            tmpHtml = $('#div19_3800Msg').html();
            //$('#div19_3800Msg').html('');
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
            //EGOVWEB-131 EHD 03/26/2013 Schedule N issue populating Page1Line1
            $('#lblBPTez1_1').text($('#lblBPTez2_6').text()); //temporarily uncommented
        }
    }

    function CalcPage2Line8() {
      
        if ($('#txtBPTez2_7a').val() != "" && $('#txtBPTez2_7b').val() != "" && $('#txtBPTez2_7c').val() != "" &&
             $('#txtBPTez2_7d').val() != "" && $('#txtBPTez2_7e').val() != "" && $('#txtBPTez2_7f').val() != "" &&
             $('#txtBPTez2_7g').val() != "" && $('#txtBPTez2_7h').val() != "" && $('#txtBPTez2_7i').val() != "") {
            /*
            Suman : What is this ? calculation or string concat ???...
            var totalAmtBPTez2_6 = txtBPTez2_6a.value + txtBPTez2_6b.value + txtBPTez2_6c.value
                                 + txtBPTez2_6d.value + txtBPTez2_6e.value + txtBPTez2_6f.value
                                 + txtBPTez2_6g.value + txtBPTez2_6h.value + txtBPTez2_6i.value;
    
            */

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
        }
        if (cCur($('#lblBPTez2_8').text()) == 0) {
            $(parent.AppError).text("Page 2, Line 8 can not be zero."); //SUMAN
        }
    }
    function CalcPage2Line9() {

        if (cCur($('#txtBPTez2_9').val()) > cCur($("#lblBPTez2_8").text())) {
            if (cCur($('#txtBPTez2_9').val()) != 50000) {
                $(parent.AppError).text('Line 9 value must be lower of Line 8 or $50,000');
            }

        }
    }
    function CalcPage2Line10() {
        if ($('#txtBPTez2_9').val() != '' && $("#lblBPTez2_8").text() != '') {
            var subtemp = cCur($("#lblBPTez2_8").text()) - cCur($('#txtBPTez2_9').val());
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
            //EGOVWEB-131 EHD 03/26/2013 Schedule N issue populating Page1Line1
            $('#lblBPTez1_2').text($('#lblBPTez2_11').text());  //temporarily uncommented
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

        var bptPage1_Actual_Tax = parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez_2015, "BPT_PG1 ACTUAL_TAX", "", 0);
        if ($('#lblBPTez1_3').text() != bptPage1_Actual_Tax) {
            $('#txtBPTez1_4').val(ispFormatMoney(cCur($('#lblBPTez1_3').text()), 0));
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez_2015, $('#lblBPTez1_3').text(), "BPT_PG1 ACTUAL_TAX", "", 0);
        }

        if (cCur($('#lblBPTez1_3').text()) != 0 && cCur($('#txtBPTez1_4').val()) == 0) {
            $(parent.AppError).text("The line 4 can not be 0 if line 3 has a value.");
            $('#txtBPTez1_4').attr("class", "inpError");
            $('#txtBPTez1_4').focus();
        }
        else {
            //$('#txtBPTez1_4').attr("class", "form-control input-sm");
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
    <div class="container-fluid no-padding" >

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
                                                <div class="row">
                                                    <div class="col-lg-8">
                                                        <p><strong>Taxpayer E-mail Address :</strong>
                                                            <label id="lblEmaillAddress" class="lblTextBlack"></label>
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

                                                            <div class="col-sm-4 newtop_padding">
                                                                <label class="radio" style="font-weight: bold;">
                                                                    <input id=chkChangeAddress type="checkbox"> &nbsp;If this is a change of address, check this box</label>
                                                            </div>
                                                         
                                                          </div>
                                                        <div class="row">
                                                        <div class="col-sm-9">
                                                                <label class="control-label text-custom-left2" for="inputEmail3">
                                                                    <span class="pull-left">If your business terminated in 2015, enter the termination date AND file a CHANGE FORM</span>
                                                                   
                                                                </label>
                                                            </div>
                                                            <div class="col-sm-3"> 
                                                                <input class="form-control input-sm" id="txtTermDate" onchange="ValidateBPTezReturn()" maxlength="10" onfocus="SetFocus()" onblur="return txtTermDate_onblur()">
                                                                
                                                            </div>
                                                        </div>
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
                                    <thead>
                                        	<tr>
                                            	<th colspan="3" width="100%">COMPUTATION OF TAX DUE OR OVERPAYMENT</th>
                                       
                                            </tr>

                                        </thead>
                                    <tbody>

                                        <tr>
                                            <td class="text-left"><span><strong>1.</strong></span> &nbsp; Net Income Portion Of Tax ( 
                                            <label id="lbl1forpage2" class="lblLink label_NoLeft" style="" onclick=ShowPage(2)> from Page 2, Line 6 </label>). If there is no tax due, enter "0"
			                                <label id="lblLnkSchdN1" style="display:none"></label></td>                                          
                                            <td width="25%">
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
                                            <td class="text-left"><span><strong>2.</strong></span> &nbsp; Gross Receipts Portion Of Tax (
                                                <label id="lbl2forpage2" class="lblLink label_NoLeft" style="" onclick=ShowPage(2)> from Page 2, Line 11 </label>). If there is no tax due, enter "0"
			                                    <label id="lblLnkSchdN2" style="display:none"></label>
                                            </td>
                                            <td width="25%">
                                                 <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                        <label id=lblBPTez1_2 style="WIDTH: 100%"></label>
                                                    </div>
                                                </div>
                                            </div>                                             	

                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-left"><span><strong>3.</strong></span> &nbsp; Tax Due for the 2015 Business Income & Receipts Tax (Line 1 plus Line 2) </td>
                                            <td  width="25%">
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
                                            <td class="text-left"><span><strong>4.</strong></span> &nbsp; <B><U>MANDATORY</U> 2016 BIRT Estimated Payment (See Instructions)</B></td>
                                            <td width="25%">                                               
                                                 <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                        	<input class="form-control input-sm table_custom_input" id=txtBPTez1_4 onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength=10 />
                                                    </div>
                                                </div>
                                            </div>  
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-left"><span><strong>5.</strong></span> &nbsp; Total Due by 4/18/2016 (Line 3 plus Line 4) </td>
                                            <td width="25%">                                             
                                                 <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                        	 <label id=lblBPTez1_5 style="WIDTH: 100%"></label>
                                                    </div>
                                                </div>
                                            </div>  
                                            </td>
                                        </tr>
                                        </tbody>
                                        
                                       <thead>
                                        	<tr>
                                            	<th colspan="3" width="100%">ESTIMATED PAYMENTS AND OTHER CREDITS</th>
                                       
                                            </tr>

                                        </thead>
                                        
                                        <tbody>
                                       <%-- <tr>
                                            <td><u><b>ESTIMATED PAYMENTS AND OTHER CREDITS</b></u></td>
                                            <td width="25%">
                                               </td>
                                        </tr>--%>
                                        <tr>
                                            <td class="text-left"><span><strong>6a.</strong></span> &nbsp; <B>Include any estimated and/or extension payments of 2015 BIRT previously made, <br/>and any credit from overpayment of the 2014 BIRT and/or 2015 NPT return</B>  </td>
                                            <td width="25%">                                             
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                        <input class="form-control input-sm table_custom_input" id=txtBPTez1_6a onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength=10 />
                                                    </div>
                                                </div>
                                            </div>  
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-left"><span><strong>6b.</strong></span> &nbsp; Credit from Special Credit Schedule (SC). (Cannot exceed amount on Line 3)</td>
                                            <td width="25%">                                               	
                                                 <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                    <input class="form-control input-sm table_custom_input" id=txtBPTez1_6b onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength=10 />
                                                    </div>
                                                </div>
                                            </div>  
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-left"><span><strong>6c.</strong></span> &nbsp; Total payments and credits. (Line 6a plus Line 6b) </td>
                                            <td width="25%">                                            
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
                                            <td class="text-left"><span><strong>7.</strong></span> &nbsp;Net Tax Due (Line 5 less Line 6c). If Line 6c is greater than Line 5, enter "0"</td>
                                            <td width="25%">                                                
                                                 <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                   <label id=lblBPTez1_7 style="WIDTH: 100%"></label>
                                                    </div>
                                                </div>
                                            </div>  
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-left"><span><strong>8.</strong></span> &nbsp; Interest and Penalty Refer to web site for current percentage</td>
                                            <td width="25%">                                            
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
                                            <td class="text-left"><span><strong>9.</strong></span> &nbsp;<B><u>TOTAL DUE</u></B> including Interest and Penalty (Line 7 plus Line 8). <br/><B>Use payment coupon. Make check payable to: "City of Philadelphia"</B></td>
                                            <td width="25%">                                              
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                    <label id=lblBPTez1_9 style="WIDTH: 100%" ></label>
                                                    </div>
                                                </div>
                                            </div>  
                                            </td>
                                        </tr>
                                        <%--<tr>
                                            <td><u><b>OVERPAYMENT OPTIONS</b></u></td>
                                            <td width="25%">
                                              </td>
                                        </tr>--%>
                                             </tbody>
                                        
                                        <thead>
                                        	<tr>
                                            	<th colspan="3" width="100%">OVERPAYMENT OPTIONS</th>
                                       
                                            </tr>

                                        </thead>
                                        
                                        <tbody>
                                        <tr >
                                            <td class="text-left"><span><strong>10a.</strong></span> &nbsp; Refunded.<B> Do not file a separate Refund Petition</B></td>
                                            <td width="25%">                                              
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                    <input class="form-control input-sm table_custom_input" id=txtBPTez1_10a onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength=10 />
                                                    </div>
                                                </div>
                                            </div>  
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-left"><span><strong>10b.</strong></span> &nbsp; Applied to the 2015 Net Profits Tax Return</td>
                                            <td width="25%">                                               
                                                 <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                    <input class="form-control input-sm table_custom_input" id=txtBPTez1_10b onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength=10 />
                                                    </div>
                                                </div>
                                            </div>  
                                                </td>
                                        </tr>
                                        <tr>
                                            <td class="text-left"><span><strong>10c.</strong></span> &nbsp; Applied to the 2016 Business Income & Receipts Tax</td>
                                            <td width="25%">                                              
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                     <input class="form-control input-sm table_custom_input" id=txtBPTez1_10c onchange="ValidateBPTezReturn()"	onfocus="SetFocus()" maxlength=10 >
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


                           <div > 
                               <%Html.RenderAction("PreparerSection", "INC");%>

                           </div>
                            <div class="form-group">
                              <div class="col-sm-offset-3 col-sm-9  text-right">
                                  
                                <input type="button" value="Print" class="btn btn-default submit_button_light" onclick="return btnBPTezPrint_onclick()" id="btnBPTezPrint"/>
                                <input type="button" value="Submit" class="btn btn-default submit_button" id="btnBPTezSubmit" onclick="return btnBPTezSubmit_onclick()" />
                            </div>
                            </div>
                          </div>

                         <%--  Page 2--%>
                         <div style="DISPLAY:none" Id="BPTez_pg2" Name="BPTez_pg2">

                             <div class="row table-responsive">
                             <div class="col-lg-12" >

                                <table summary="Employee Pay Sheet" class="table table-condensed table-striped custom_table03">
                                    <thead>
                                        	<tr>
                                            	<th colspan="3" width="100%">NET INCOME PORTION</th>
                                       
                                            </tr>

                                        </thead>
                                    <tbody>

                                        <tr>
                                            <td class="text-left"><span><strong>1.</strong></span> &nbsp;<INPUT type="radio" id=radBPTez2_1_2_m2 name=radBPTez2_1_2 onclick="ValidateBPTezMethod()"/> 
		                                        METHOD II. Net Income (or loss) as properly reported to 
					                                        the Federal Government</td>                                     
                                            
                                            <td  width="25%">
                                            <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                        
                                                       <input  id=txtBPTez2_1 class="form-control input-sm" onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength=10 >
                                                    </div>
                                                </div>
                                            </div>

                                            </td>
                                        </tr>
                                        <tr>
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
                                            <td class="text-left"><span><strong>2.</strong></span> &nbsp;  <INPUT type="radio" id=radBPTez2_1_2_m1 name=radBPTez2_1_2 onclick="ValidateBPTezMethod()" />
			                                    METHOD I. Net Income (or loss) in accordance with Accounting
					                                    System</td>
                                            <td width="25%">                                           
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
                                            <td class="text-left"><span><strong>3.</strong></span> &nbsp; Statutory Net Income Deduction from <label class="lblLink label_NoLeft"  onclick=ShowPage('WrkShtN')> Worksheet S-EZ, Line S5 </label></td>
                                            <td width="25%">                                              	
                                                 <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                     <label id="lbl_BPTez2_3" style="WIDTH: 100%"></label>
                                                    </div>
                                                </div>
                                            </div>
                                            </td>
                                        </tr>
                                        <tr >
                                            <td class="text-left"><span><strong>4.</strong></span> &nbsp; Loss Carry Foward, if any. </td>
                                            <td width="25%">                                               	
                                                 <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                     <input class="form-control input-sm" id=txtBPTez2_4 onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength=10 >
                                                    </div>
                                                </div>
                                            </div>
                                            </td>
                                        </tr>
                                        <tr >
                                            <td class="text-left"><span><strong>5.</strong></span> &nbsp;  Taxable Income or Less [Calculated - line 1 OR 2 minus line 3 minus line 4] </td>
                                            <td width="25%">                                           
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                     <label id=lblBPTez2_5 style="WIDTH: 100%"></label>
                                                    </div>
                                                </div>
                                            </div>
                                            </td>
                                        </tr>
                                        <tr >
                                            <td class="text-left"><span><strong>6.</strong></span> &nbsp; TAX DUE (Line 5 X .0641). If Line 5 is a loss, enter zero here and on Page 1, Line 1. </td>
                                            <td width="25%">                                              
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                      <label id=lblBPTez2_6 style="WIDTH: 100%"></label>
                                                    </div>
                                                </div>
                                            </div>
                                            </td>
		                                <td colspan=3 class="">
                                        </tr>
                                       <%-- <tr >
                                            <td class="text-left"><u>GROSS RECEIPTS PORTION</u> </td>
                                            <td width="25%"> 
                                            </td>
                                        </tr>--%>
                                         </tbody>
                                        
                                       <thead>
                                        	<tr>
                                            	<th colspan="3" width="100%">GROSS RECEIPTS PORTION</th>
                                       
                                            </tr>

                                        </thead>
                                        
                                        <tbody>
                                        <tr >
                                            <td class="text-left">TAXABLE GROSS RECEIPTS from:</td>
                                            <td width="25%"> 
                                              </td>
                                        </tr>
                                        <tr >
                                            <td class="text-left"><span><strong>7a.</strong></span> &nbsp; Sales and/or Rentals of Tangible Personal Property </td>
                                            <td width="25%">                                            
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                      <input  id=txtBPTez2_7a class="form-control input-sm" onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength=10 >
                                                    </div>
                                                </div>
                                            </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-left"><span><strong>7b.</strong></span> &nbsp; Services</td>
                                            <td width="25%">                                               
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                      <input  id=txtBPTez2_7b class="form-control input-sm" onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength=10 >
                                                    </div>
                                                </div>
                                            </div>
                                            </td>
                                        </tr>
                                        <tr >
                                            <td class="text-left"><span><strong>7c.</strong></span> &nbsp; Rentals of Real Property</td>
                                            <td width="25%">                                            
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                      <input id=txtBPTez2_7c class="form-control input-sm" onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength=10 >
                                                    </div>
                                                </div>
                                            </div>
                                            </td>
                                        </tr>

                                         <tr >
                                            <td class="text-left"><span><strong>7d.</strong></span> &nbsp; Royalties</td>
                                            <td width="25%">                                              	
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                      <input  id=txtBPTez2_7d class="form-control input-sm" onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength=10 >
                                                    </div>
                                                </div>
                                            </div>
                                            </td>
                                        </tr>
                                        <tr >
                                            <td class="text-left"><span><strong>7e.</strong></span> &nbsp; Gains on Sales of Business Capital Assets</td>
                                            <td width="25%">                                           
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                      <input  id=txtBPTez2_7e class="form-control input-sm" onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength=10 >
                                                    </div>
                                                </div>
                                            </div>
                                            </td>
                                        </tr>
                                        <tr >
                                            <td class="text-left"><span><strong>7f.</strong></span> &nbsp; Gains on Sales of Stocks, Bonds, etc. (not applicable to individuals)</td>
                                            <td width="25%">                                          	
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                      <input  id=txtBPTez2_7f class="form-control input-sm" onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength=10 >
                                                    </div>
                                                </div>
                                            </div>
                                            </td>
                                        </tr>
                                           <tr >
                                            <td class="text-left"><span><strong>7g.</strong></span> &nbsp; Dividends (not applicable to individuals)</td>
                                            <td width="25%">                                           
                                                 <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                      <input  id=txtBPTez2_7g class="form-control input-sm" onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength=10 >
                                                    </div>
                                                </div>
                                            </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-left"><span><strong>7h.</strong></span> &nbsp; Interest (not applicable to individuals)</td>
                                            <td width="25%">                                            	
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                     <input  id=txtBPTez2_7h class="form-control input-sm" onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength=10 >
                                                    </div>
                                                </div>
                                            </div>
                                            </td>
                                        </tr>
                                        <tr >
                                            <td class="text-left"><span><strong>7i.</strong></span> &nbsp; Other (Describe)</td>
                                            <td width="25%">                                            
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                     <input  id=txtBPTez2_7i class="form-control input-sm" onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength=10 >
                                                    </div>
                                                </div>
                                            </div>
                                            </td>
                                        </tr>

                                         <tr>
                                            <td class="text-left"><span><strong>8.</strong></span> &nbsp; TAXABLE GROSS RECEIPTS before Statutory Exclusion.[Calculated - add lines 7a through 7i]</td>
                                            <td width="25%">                                             
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
                                            <td class="text-left"><span><strong>9.</strong></span> &nbsp; <b>Statutory Exclusion (Lower of Line 8 or $75,000.00)</b></td>
                                            <td width="25%">                                
                                                
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                      <input  id=txtBPTez2_9 class="form-control input-sm" onchange="ValidateBPTezReturn()" onfocus="SetFocus()" maxlength=10 >
                                                          
                                                    </div>
                                                </div>
                                            </div>
                                            </td>
                                        </tr>
                                        <tr >
                                            <td class="text-left"><span><strong>10.</strong></span> &nbsp;  Net taxable Gross Receipts (Line 8 minus Line 9)</td>
                                            <td width="25%">                                             
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                      <label id=lblBPTez2_10 style="WIDTH: 100%"></label>
                                                    </div>
                                                </div>
                                            </div>
                                            </td>
                                        </tr>
                                        <tr >
                                            <td class="text-left"><span><strong>11.</strong></span> &nbsp; TAX DUE. (Line 10 X .001415). Enter here and on Page 1, Line 2.</td>
                                            <td width="25%">                                              
                                                <div class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                    <label id=lblBPTez2_11 style="WIDTH: 100%"></label>
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
                    <% 
                        
                        Html.RenderAction("BPTez_WorkSheetSEZ_2015", "Returns");
                         %>
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
