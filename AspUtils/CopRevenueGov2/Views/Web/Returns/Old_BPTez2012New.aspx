<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
    <head>
        <script id="clientEventHandlersJS" language="javascript" type="text/javascript">

            var arrBPTezErr = new Array();
            var txtHeader = 'Taxpayer Information';
            var dBPTezNetRate, dBPTezGrossRate;
            var b3800val = false;
            var sYear = '12';
            var mbFirstTime = false;
            var gUserAddr = '<%#  Request.ServerVariables["REMOTE_ADDR"] %>';
            var isScheduleN = false;
            $(document).ready(function () {
                DisplayBPTezReturn();
            });
    function nFlowCalc() {
        var l5val = cCur($('#lblBPTez1_5').text());
        var l6cval = cCur($('#lblBPTez1_6c').text());

        var l10a_val, l10b_val, l10c_val;
        l10a_val = cCur(txtBPTez1_10a.value);
        l10b_val = cCur(txtBPTez1_10b.value);
        l10c_val = cCur(txtBPTez1_10c.value);

        var nval = l5val - l6cval;

        var bval = 0;
        if (nval < 0) {
            bval = nval + l10a_val + l10b_val + l10c_val;
            $('#lblBPTez1_7').text(ispFormatMoney(bval, 0));
            if (bval != 0) {
                $(parent.AppError).text('Lines 10a, 10b and 10c must equal Line 7');
            }
        }
    }

    function DisplayBPTezReturn() {
        //refresh bptez form
        parent.$g.loadXmlSync('XML/BPTezReturn', parent.parseXml_xmlBPTez);
        parent.$g.loadXmlSync('XML/BPTezReturn', parent.parseXml_xmlBPTezTemplate);

        if ($(parent.$g.xmlAccount).find("TAX_ACCT").find("ACCOUNT:contains('24')")) {
            isScheduleN = false;

            // parent.MenuWin.ispHighlightMenu(parent.MenuWin.mnuBPTezYear12); 	//.mnuBPTezYear10Page2

            $('#BPTez').css("display", "block");
            $('#BPTez_pg2').css("display", "block");

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 'INQ', 'BPT_INFO RETURN_STATUS', '', 0)
            var entityInfo_ACCOUNT_ID = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ACCOUNT_ID', "", 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, entityInfo_ACCOUNT_ID, 'BPT_INFO ACCOUNT_ID', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, '12/31/2012', 'BPT_INFO PERIOD', '', 0);

            $('#AppHeader').html(txtHeader + '<Font class=hdrMedium>|Business Income & Receipts Tax-EZ for 2012</Font>');
            //parent.MenuWin.gsInstructionItem = '#BptEz';// ? SUMAN Questionable mod for L & C
            parent.gsInstructionItem = '#BIR';
            $('#AppMessage').html(parent.gsInstructionText
                                  + '<BR>The Business Income & Receipts Tax for 2012 is due April 15, 2013.');
            $('#InstructionText').html(' for Loss Carry Forward and Estimated Payments');
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
        // ShowPage(2);
        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_INFO RETURN_STATUS', '', 0) == 'A1') {
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_INFO VERSION', '', 0) == '') {
                $('#BPTez_pg2').css("display", "none");
                $('#BPT_19_3800').css('display', 'block');
            } else {
                btn3800YN_onclick(btnYes)
                $('#BPTez_pg2').css("display", "block");
                ShowPage(2);
            } 	//if
        } else {
            // $('#BPTez_pg2').css("display", "block");
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_INFO PREPARER_NAME ', "", 0) != 0) {//Sanghamitra:added this if block to solve the problem of  error message in fresh form.

                ShowPage(2);
            }
            else {
                // ShowPage(2);
                DisplayNetIncome();//Added for the radio box to check
                $('#lblBPTez2_7').text(ispFormatMoney(0, 0));//("$0");//Sanghamitra
            }
        } 	//if
        GoToPage1Button();
    }//DisplayBPTez05Return


    function SetBPTezFields() {
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
        if (bDisabled == true) {
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

        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 TOTAL_TAX', '', 0) == '$0') {
            bPeriodExist = false;
        }

        if (bPeriodExist == false) {
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, '', 'ERROR_INFO PROGRAM', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, '', 'ERROR_INFO ERROR', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, '', 'ERROR_INFO LINE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, '', 'ERROR_INFO MESSAGE', '', 0);

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, '12/31/2012', 'BPT_INFO PERIOD', '', 0);
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
        txtBPTez1_4.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 ESTIMATED_TAX', '', 0), 0);
        $('#lblBPTez1_5').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 TOTAL_TAX', '', 0), 0));
        txtBPTez1_6a.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 NPT_TAX_CREDIT', '', 0), 0);
        txtBPTez1_6b.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 BPT_TAX_CREDIT', '', 0), 0);
        $('#lblBPTez1_6c').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 TOTAL_PAY_CREDITS', '', 0), 0));
        $('#lblBPTez1_7').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 TAX_DUE', '', 0), 0));
        txtBPTez1_8.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 INTEREST_PENALTY', '', 0), 0);
        $('#lblBPTez1_9').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 AMOUNT_OWED', '', 0), 0));
        txtBPTez1_10a.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 REFUND', '', 0), 0);
        txtBPTez1_10b.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 NPT_OVERPAY', '', 0), 0);
        txtBPTez1_10c.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 BPT_OVERPAY', '', 0), 0);

        PopulatePreparer(parent.$g.xmlBPTez, 'BPT_INFO');

        //Page2
        txtBPTez2_2.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 NET_INCOME_LOSS_1', '', 0), 0);
        txtBPTez2_1.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 NET_INCOME_LOSS_2', '', 0), 0);
        txtBPTez2_3.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 LOSS_CARRY_FORWARD', '', 0), 0);
        $('#lblBPTez2_4').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 TAXABLE_INCOME', '', 0), 0));
        $('#lblBPTez2_5').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 TAX_DUE_NET', '', 0), 0));
        txtBPTez2_6a.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 SALES_RENTAL', '', 0), 0);
        txtBPTez2_6b.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 SERVICES', '', 0), 0);
        txtBPTez2_6c.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 RENTAL_PROPERTY', '', 0), 0);
        txtBPTez2_6d.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 ROYALTIES', '', 0), 0);
        txtBPTez2_6e.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 CAPITAL_GAINS', '', 0), 0);
        txtBPTez2_6f.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 STOCK_GAINS', '', 0), 0);
        txtBPTez2_6g.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 DIVIDENDS', '', 0), 0);
        txtBPTez2_6h.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 INTEREST', '', 0), 0);
        txtBPTez2_6i.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG2 OTHER', '', 0), 0);
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
            ispSetFocus(txtBPTez2_2);
            return;
        }

        if (radBPTez2_1_2_m2.checked == true) {
            $('#txtBPTez2_2').attr("disabled", 'disable');
            $('#txtBPTez2_1').removeAttr("disabled");
            ispSetFocus(txtBPTez2_1);
            return;
        }

        if (txtBPTez2_1.value == curzero && txtBPTez2_2.value == curzero) {
            radBPTez2_1_2_m2.checked = true;
            $('#txtBPTez2_2').attr("disabled", "disable");
            ispSetFocus(txtBPTez2_1);
        }
        else if (txtBPTez2_1.value != curzero) {
            radBPTez2_1_2_m2.checked = true;
            $('#txtBPTez2_2').attr("disabled", "disable");
            ispSetFocus(txtBPTez2_1);
        }
        else if (txtBPTez2_2.value != curzero) {
            radBPTez2_1_2_m1.checked = true;
            $('#txtBPTez2_1').attr("disabled", "disable");
            ispSetFocus(txtBPTez2_2);
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
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency(txtBPTez1_4.value), 'BPT_PG1 ESTIMATED_TAX', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#lblBPTez1_5').text()), 'BPT_PG1 TOTAL_TAX', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency(txtBPTez1_6a.value), 'BPT_PG1 NPT_TAX_CREDIT', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency(txtBPTez1_6b.value), 'BPT_PG1 BPT_TAX_CREDIT', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#lblBPTez1_6c').text()), 'BPT_PG1 TOTAL_PAY_CREDITS', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#lblBPTez1_7').text()), 'BPT_PG1 TAX_DUE', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency(txtBPTez1_8.value), 'BPT_PG1 INTEREST_PENALTY', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#lblBPTez1_9').text()), 'BPT_PG1 AMOUNT_OWED', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency(txtBPTez1_10a.value), 'BPT_PG1 REFUND', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency(txtBPTez1_10b.value), 'BPT_PG1 NPT_OVERPAY', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency(txtBPTez1_10c.value), 'BPT_PG1 BPT_OVERPAY', '', 0);
        PopulatePreparerXML(parent.$g.xmlBPTez, 'BPT_INFO');

        //Page2
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency(txtBPTez2_2.value), 'BPT_PG2 NET_INCOME_LOSS_1', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency(txtBPTez2_1.value), 'BPT_PG2 NET_INCOME_LOSS_2', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency(txtBPTez2_3.value), 'BPT_PG2 LOSS_CARRY_FORWARD', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#lblBPTez2_4').text()), 'BPT_PG2 TAXABLE_INCOME', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency($('#lblBPTez2_5').text()), 'BPT_PG2 TAX_DUE_NET', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency(txtBPTez2_6a.value), 'BPT_PG2 SALES_RENTAL', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency(txtBPTez2_6b.value), 'BPT_PG2 SERVICES', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency(txtBPTez2_6c.value), 'BPT_PG2 RENTAL_PROPERTY', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency(txtBPTez2_6d.value), 'BPT_PG2 ROYALTIES', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency(txtBPTez2_6e.value), 'BPT_PG2 CAPITAL_GAINS', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency(txtBPTez2_6f.value), 'BPT_PG2 STOCK_GAINS', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency(txtBPTez2_6g.value), 'BPT_PG2 DIVIDENDS', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency(txtBPTez2_6h.value), 'BPT_PG2 INTEREST', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, stripCurrency(txtBPTez2_6i.value), 'BPT_PG2 OTHER', '', 0);
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
        var i = 0;

        //Page1
        arrBPTezErr[i++] = [txtBPTez1_6a, 'txtBPTez1_6a.value == ""', 'Answer Question 6a'];
        arrBPTezErr[i++] = [txtBPTez1_6a, 'ispValue(txtBPTez1_6a.value) == false', 'Value for Question 6a must be numeric'];
        arrBPTezErr[i++] = [txtBPTez1_6a, 'ispNegativeNumber(txtBPTez1_6a.value) == false', 'Value for Question 6a must NOT be negative'];

        arrBPTezErr[i++] = [txtBPTez1_6b, 'txtBPTez1_6b.value == ""', 'Answer Question 6b'];
        arrBPTezErr[i++] = [txtBPTez1_6b, 'ispValue(txtBPTez1_6b.value) == false', 'Value for Question 6b must be numeric'];
        arrBPTezErr[i++] = [txtBPTez1_6b, 'ispNegativeNumber(txtBPTez1_6b.value) == false', 'Value for Question 6b must NOT be negative'];

        arrBPTezErr[i++] = [txtBPTez1_8, 'txtBPTez1_8.value == ""', 'Answer Question 8'];
        arrBPTezErr[i++] = [txtBPTez1_8, 'ispValue(txtBPTez1_8.value) == false', 'Value for Question 8 must be numeric'];
        arrBPTezErr[i++] = [txtBPTez1_8, 'ispNegativeNumber(txtBPTez1_8.value) == false', 'Value for Question 8 must NOT be negative'];

        arrBPTezErr[i++] = [txtBPTez1_10a, 'ispValue(txtBPTez1_10a.value) == false', 'Value for Question 10a must be numeric'];
        arrBPTezErr[i++] = [txtBPTez1_10a, 'ispNegativeNumber(txtBPTez1_10a.value) == false', 'Value for Question 10a must NOT be negative'];

        arrBPTezErr[i++] = [txtBPTez1_10b, 'ispValue(txtBPTez1_10b.value) == false', 'Value for Question 10b must be numeric'];
        arrBPTezErr[i++] = [txtBPTez1_10b, 'ispNegativeNumber(txtBPTez1_10b.value) == false', 'Value for Question 10b must NOT be negative'];

        arrBPTezErr[i++] = [txtBPTez1_10c, 'ispValue(txtBPTez1_10c.value) == false', 'Value for Question 10c must be numeric'];
        arrBPTezErr[i++] = [txtBPTez1_10c, 'ispNegativeNumber(txtBPTez1_10c.value) == false', 'Value for Question 10c must NOT be negative'];

        //Page2
        arrBPTezErr[i++] = [txtBPTez2_1, 'txtBPTez2_1.value == ""', 'Answer Question 1'];
        arrBPTezErr[i++] = [txtBPTez2_1, 'ispValue(txtBPTez2_1.value) == false', 'Value for Question 1 must be numeric'];

        arrBPTezErr[i++] = [txtBPTez2_2, 'txtBPTez2_2.value == ""', 'Answer Question 2'];
        arrBPTezErr[i++] = [txtBPTez2_2, 'ispValue(txtBPTez2_2.value) == false', 'Value for Question 2 must be numeric'];

        arrBPTezErr[i++] = [txtBPTez2_3, 'txtBPTez2_3.value == ""', 'Answer Question 3'];
        arrBPTezErr[i++] = [txtBPTez2_3, 'ispValue(txtBPTez2_3.value) == false', 'Value for Question 3 must be numeric'];
        arrBPTezErr[i++] = [txtBPTez2_3, 'ispNegativeNumber(txtBPTez2_3.value) == false', 'Value for Question 3 must NOT be negative'];

        arrBPTezErr[i++] = [txtBPTez2_6a, 'txtBPTez2_6a.value == ""', 'Answer Question 6a'];
        arrBPTezErr[i++] = [txtBPTez2_6a, 'ispValue(txtBPTez2_6a.value) == false', 'Value for Question 6a must be numeric'];
        arrBPTezErr[i++] = [txtBPTez2_6a, 'ispNegativeNumber(txtBPTez2_6a.value) == false', 'Value for Question 6a must NOT be negative'];

        arrBPTezErr[i++] = [txtBPTez2_6b, 'txtBPTez2_6b.value == ""', 'Answer Question 6b'];
        arrBPTezErr[i++] = [txtBPTez2_6b, 'ispValue(txtBPTez2_6b.value) == false', 'Value for Question 6b must be numeric'];
        arrBPTezErr[i++] = [txtBPTez2_6b, 'ispNegativeNumber(txtBPTez2_6b.value) == false', 'Value for Question 6b must NOT be negative'];

        arrBPTezErr[i++] = [txtBPTez2_6c, 'txtBPTez2_6c.value == ""', 'Answer Question 6c'];
        arrBPTezErr[i++] = [txtBPTez2_6c, 'ispValue(txtBPTez2_6c.value) == false', 'Value for Question 6c must be numeric'];
        arrBPTezErr[i++] = [txtBPTez2_6c, 'ispNegativeNumber(txtBPTez2_6c.value) == false', 'Value for Question 6c must NOT be negative'];

        arrBPTezErr[i++] = [txtBPTez2_6d, 'txtBPTez2_6d.value == ""', 'Answer Question 6d'];
        arrBPTezErr[i++] = [txtBPTez2_6d, 'ispValue(txtBPTez2_6d.value) == false', 'Value for Question 6d must be numeric'];
        arrBPTezErr[i++] = [txtBPTez2_6d, 'ispNegativeNumber(txtBPTez2_6d.value) == false', 'Value for Question 6d must NOT be negative'];

        arrBPTezErr[i++] = [txtBPTez2_6e, 'txtBPTez2_6e.value == ""', 'Answer Question 6e'];
        arrBPTezErr[i++] = [txtBPTez2_6e, 'ispValue(txtBPTez2_6e.value) == false', 'Value for Question 6e must be numeric'];
        arrBPTezErr[i++] = [txtBPTez2_6e, 'ispNegativeNumber(txtBPTez2_6e.value) == false', 'Value for Question 6e must NOT be negative'];

        arrBPTezErr[i++] = [txtBPTez2_6f, 'txtBPTez2_6f.value == ""', 'Answer Question 6f'];
        arrBPTezErr[i++] = [txtBPTez2_6f, 'ispValue(txtBPTez2_6f.value) == false', 'Value for Question 6f must be numeric'];
        arrBPTezErr[i++] = [txtBPTez2_6f, 'ispNegativeNumber(txtBPTez2_6f.value) == false', 'Value for Question 6f must NOT be negative'];

        arrBPTezErr[i++] = [txtBPTez2_6g, 'txtBPTez2_6g.value == ""', 'Answer Question 6g'];
        arrBPTezErr[i++] = [txtBPTez2_6g, 'ispValue(txtBPTez2_6g.value) == false', 'Value for Question 6g must be numeric'];
        arrBPTezErr[i++] = [txtBPTez2_6g, 'ispNegativeNumber(txtBPTez2_6g.value) == false', 'Value for Question 6g must NOT be negative'];

        arrBPTezErr[i++] = [txtBPTez2_6h, 'txtBPTez2_6h.value == ""', 'Answer Question 6h'];
        arrBPTezErr[i++] = [txtBPTez2_6h, 'ispValue(txtBPTez2_6h.value) == false', 'Value for Question 6h must be numeric'];
        arrBPTezErr[i++] = [txtBPTez2_6h, 'ispNegativeNumber(txtBPTez2_6h.value) == false', 'Value for Question 6h must NOT be negative'];

        arrBPTezErr[i++] = [txtBPTez2_6i, 'txtBPTez2_6i.value == ""', 'Answer Question 6i'];
        arrBPTezErr[i++] = [txtBPTez2_6i, 'ispValue(txtBPTez2_6i.value) == false', 'Value for Question 6i must be numeric'];
        arrBPTezErr[i++] = [txtBPTez2_6i, 'ispNegativeNumber(txtBPTez2_6i.value) == false', 'Value for Question 6i must NOT be negative'];
        //	arrBPTezErr[i++] = [lblBPTez1_7, 'PrepForMath(lblBPTez1_7.innerText) > 0', 'Line 7 must be greater than 0']

    }//LoadBPTezError

    function btnBPTezPrint_onclick() {
        var currDisplayedObjId, lBPTez_pg2, objCurrDisplayed, lBPTez_WrkShtN;

        //	lBPTez_pg2 = $('#BPTez_pg2').html();
        //	lBPTez_WrkShtN = $('#BPTez_WrkShtN').html();
        $('#btnBPTezPrint').css("visibility", "hidden");
        $('#btnBPTezSubmit').css("visibility", "hidden");
        $('#BPTez_pg2').css("page-break-before", "always");
        $('#BPTez_WrkShtN').css('pageBreakBefore', 'always');

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
        $('#BPTez_WrkShtN').css('display', 'block');

        //	$('#BPTez_pg2').prepend($('#BPTezHeader').html() + '<BR>');
        //	$('#BPTez_WrkShtN').prepend($('#BPTezHeader').html() + '<BR>');
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
            //$('#BPTez_WrkShtN').html(lBPTez_WrkShtN);
            //----------------------------------------------------------------------------------------------------
            FieldLock(true);
        }
        else {
            window.print();
            //REF. BLOCK 1.1
            //$('#BPTez_pg2').html(lBPTez_pg2);
            //$('#BPTez_WrkShtN').html(lBPTez_WrkShtN);
            //-------------------------------------
        }

        //	$('#BPTez_pg2').html(lBPTez_pg2);
        //	$('#BPTez_WrkShtN').html(lBPTez_WrkShtN);
        $('#btnBPTezPrint').css("visibility", "visible");
        $('#btnBPTezSubmit').css("visibility", "visible");
        $('#BPTez_pg1').css('display', 'block');
        $('#BPTez_pg2').css('display', 'none');
        $('#BPTez_WrkShtN').css('display', 'none');

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

        if ($(parent.AppError).text() == "") {
            $(parent.AppError).text(ValidatePreparer());
        }

        if ($(parent.AppError).text() == "") {
            if (isScheduleN == true) {
                alert('n');
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 'A1', 'BPT_INFO RETURN_STATUS', '', 0);
            }
            else {
                //alert('nn');
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, '', 'BPT_INFO RETURN_STATUS', '', 0);
            }

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
        $('#BPTez_pg1').css('display', 'none');
        $('#BPTez_pg2').css('display', 'none');
        $('#BPTez_WrkShtN').css('display', 'none');
        $('#lblLnkSchdN1').text('');
        $('#lblLnkSchdN2').text('');
        $('#BPT_19_3800').css('display', 'none');

        sPrevWrkSht = sCurrWrkSht
        $(parent.AppError).text('');
        var FocusItem
        ValidateBPTezReturn()

        if (iPage == 2) {
            sCurrWrkSht = '2'
            $('#BPTez_pg2').css("display", "block");
            $('#btnBPTezSubmit').removeAttr("disabled");
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
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_INFO RETURN_STATUS', '', 0) == 'A1') {
                $('#lblLnkSchdN1').html('<label class="lblInstrNormal"> or </label>' +
                        '<label class="lblLink" style="FONT-SIZE: 7pt" onclick=ShowPage("WrkShtN")> Worksheet N, Line 2</label>');
                $('#lblLnkSchdN2').html('<label class="lblInstrNormal"> or </label>' +
                        '<label class="lblLink" style="FONT-SIZE: 7pt" onclick=ShowPage("WrkShtN")> Worksheet N, Line 4</label>');
                isScheduleN = true
            } 	//if
            if (sPrevWrkSht == '2') {

                if ($('#btnYes').is(':checked') == true) {
                    $('#lblBPTez1_1').text(ispFormatMoney(0, 0));
                    $('#lblBPTez1_2').text(ispFormatMoney(0, 0));
                } else {
                    $('#lblBPTez1_1').text($('#lblBPTez2_5').text());
                    $('#lblBPTez1_2').text($('#lblBPTez2_8').text());
                } //if

            } else if (sPrevWrkSht == 'WrkShtN') {

                $('#lblBPTez1_1').text(ispFormatMoney($('#lblWrkShtN_2').text(), 0));
                $('#lblBPTez1_2').text(ispFormatMoney($('#lblWrkShtN_4').text(), 0));
            } 	//if	
            // Added to solve Schedule N issue by chayan on 19/03/2013		
            CalcPage1Line3();
            CalcPage1Line5();
            CalcPage1Line6c();
            CalcPage1Line7();
            CalcPage1Line9_10();
            //-------------------------------------------
            $('#BPTez_pg1').css("display", "block");
        }
        loadpage();//if
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
                txtBPTez2_1.value = ispFormatMoney(0, 0);
                $('#txtBPTez2_1').attr("disabled", "disable");
                $('#txtBPTez2_2').removeAttr("disabled");
                $('#txtBPTez2_2').focus();
            }
            else {
                $('#txtBPTez2_2').removeAttr("disabled");
                txtBPTez2_2.value = ispFormatMoney(0, 0);
                $('#txtBPTez2_2').attr("disabled", "disable");
                $('#txtBPTez2_1').removeAttr("disabled");
                $('#txtBPTez2_1').focus();
            }

            ValidateBPTezReturn();
        }
    }//ValidateBPTezMethod

    function ValidateBPTezReturn() {

        var ObjSelected = getActiveElement();
        //if (ObjSelected == undefined || ObjSelected == null)
        //{


        //	return;
        //}


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
                // $('#AppError').text("Page 2, Line 7 can not be zero");//Sangha
                $('#lblPage1Disabled').text('Gross Receipts Portions needs to be filled out before going to Page 1');
            }
            else {
                $('#mnuBPTezYear06Page1', parent).removeAttr("disabled");
                $('#btnGoToPage1').removeAttr("disabled");
                // $('#AppError').text("");
                $('#lblPage1Disabled').text('');
            }
        }
    }//GoToPage1Button

    function CheckPage2Line3() {
        var BPTStartDate;
        iCount = parent.$x.ispXmlGetRecCount(parent.$g.xmlAccount, 'TAX_ACCT', '');
        if (txtBPTez2_3.value != ispFormatMoney(0, 0).toString()) {
            for (i = 0; i < iCount; i++) {
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '', i) == '24') {
                    BPTStartDate = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'TAX_ACCT START_DATE', '', i)
                    if (new Date(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'TAX_ACCT START_DATE', '', i)) >= new Date("01/01/2012")) {
                        txtBPTez2_3.value = ispFormatMoney(0, 0);//'$0';
                        alert('This return is not eligible for Loss Carry Forward, because your BPT Start Date '
                             + BPTStartDate
                             + ' is on or after 01/01/2012. Loss Carry Forward (Page 2, Question #3) has been set to zero.');
                    }
                }
            }
        }
    }

    function BirtEz_3800(btnClicked) {
        if ($('#div19_3800Msg').html() != '') {
            tmpHtml = $('#div19_3800Msg').html();
            $('#div19_3800Msg').html('');
            $('#divMsg19_3800').html(tmpHtml);
        } 	//if

        if (btnClicked.id == $('#btnYes').attr('id')) {
            b3800val = true;
            $('#btnYes').attr('checked', true);
            $('#btnNo').attr('checked', false);
        } else {
            b3800val = false;
            $('#btnNo').attr('checked', true);
            $('#btnYes').attr('checked', false);
        } 	//if

        if ($('#BPTez_WrkShtN').css('display') == 'none') {
            ShowPage('2')
        } else {
            if (btnClicked.id == $('#btnYes').attr('id')) {		//Yes Radio Clicked
                b3800val = true;
                $('#btnYes').attr('checked', true);
                $('#btnNo').attr('checked', false);
            } else {		//No Radio Clicked
                b3800val = false;
                $('#btnNo').attr('checked', true);
                $('#btnYes').attr('checked', false);
            } 	//if
            PerformCalcsBPTezWrkShtN()
        } 	//if
    } 	//12BirtLf_3800


    function cCur(value) {
        return ispRemoveMoney(value);
    }

    function CalcPage2Line4() {
        if ($('#radBPTez2_1_2_m2').is(":checked") == true) {
            var BPTez2_1 = cCur(txtBPTez2_1.value);
            var BPTez2_3 = cCur(txtBPTez2_3.value);
            $('#lblBPTez2_4').text(ispFormatMoney(BPTez2_1 - BPTez2_3, 0));
        }

        if ($('#radBPTez2_1_2_m1').is(":checked") == true) {
            var BPTez2_2 = cCur(txtBPTez2_2.value);
            var BPTez2_3 = cCur(txtBPTez2_3.value);
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
            $('#lblBPTez1_1').text($('#lblBPTez2_5').text()); //temporarily uncommented
        }
    }

    function CalcPage2Line7() {
        if (txtBPTez2_6a.value != "" && txtBPTez2_6b.value != "" && txtBPTez2_6c.value != "" &&
             txtBPTez2_6d.value != "" && txtBPTez2_6e.value != "" && txtBPTez2_6f.value != "" &&
             txtBPTez2_6g.value != "" && txtBPTez2_6h.value != "" && txtBPTez2_6i.value != "") {
            /*
            Suman : What is this ? calculation or string concat ???...
            var totalAmtBPTez2_6 = txtBPTez2_6a.value + txtBPTez2_6b.value + txtBPTez2_6c.value
                                 + txtBPTez2_6d.value + txtBPTez2_6e.value + txtBPTez2_6f.value
                                 + txtBPTez2_6g.value + txtBPTez2_6h.value + txtBPTez2_6i.value;
    
            */

            var totalAmtBPTez2_6 =
            cCur(txtBPTez2_6a.value) +
            cCur(txtBPTez2_6b.value) +
            cCur(txtBPTez2_6c.value) +
            cCur(txtBPTez2_6d.value) +
                        cCur(txtBPTez2_6e.value) +
                        cCur(txtBPTez2_6f.value) +
                        cCur(txtBPTez2_6g.value) +
                        cCur(txtBPTez2_6h.value) +
                        cCur(txtBPTez2_6i.value);

            $('#lblBPTez2_7').text(ispFormatMoney(totalAmtBPTez2_6, 0));

        }

        if (cCur($('#lblBPTez2_7').text()) == 0) {
            $(parent.AppError).text("Page 2, Line 7 can not be zero.");
        }
    }

    function CalcPage2Line8(dTax) {
        if (isNaN(dTax)) {
            dTax = 0.0023;
        }

        if ($('#lblBPTez2_7').text() != "") {
            $('#lblBPTez2_8').text(ispFormatMoney(cCur($('#lblBPTez2_7').text()) * dTax, 0));
            $('#lblBPTez1_2').text($('#lblBPTez2_8').text());  //temporarily uncommented
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
            txtBPTez1_4.value = ispFormatMoney(cCur($('#lblBPTez1_3').text()), 0);
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
        if ($('#lblBPTez1_3').text() != "" && txtBPTez1_4.value != "") {
            $('#lblBPTez1_5').text(ispFormatMoney(
            cCur($('#lblBPTez1_3').text()) +
            cCur(txtBPTez1_4.value), 0));
        }
    }

    function CalcPage1Line6c() {
        if (txtBPTez1_6a.value != "" && txtBPTez1_6b.value != "") {
            $('#lblBPTez1_6c').text(ispFormatMoney(
            cCur(txtBPTez1_6a.value) + cCur(txtBPTez1_6b.value), 0));
        }
    }

    function CalcPage1Line7() {
        if ($('#lblBPTez1_5').text() != "" && $('#lblBPTez1_6c').text() != "") {
            $('#lblBPTez1_7').text(ispFormatMoney(cCur($('#lblBPTez1_5').text()) - cCur($('#lblBPTez1_6c').text()), 0));
        }
    }

    function CalcPage1Line9_10() {
        if ($('#lblBPTez1_7').text() != "" && txtBPTez1_8.value != "") {
            $('#lblBPTez1_9').text(ispFormatMoney(cCur($('#lblBPTez1_7').text()) + cCur(txtBPTez1_8.value), 0));
        }
        //Added for the enable/disable of Page1 Line 8
        if (mbFirstTime) {
            $('#txtBPTez1_8').removeAttr("disabled");
        } else {
            $('#txtBPTez1_8').attr("disabled", "disabled");
        }

        if (cCur($('#lblBPTez1_9').text()) < 0) {
            $('#txtBPTez1_8').attr("disabled", "disabled");
            if (txtBPTez1_10a.value == "") {
                txtBPTez1_10a.value = ispFormatMoney(0, 0);
            }

            if (txtBPTez1_10b.value == "") {
                txtBPTez1_10b.value = ispFormatMoney(0, 0);
            }

            if (txtBPTez1_10c.value == "") {
                txtBPTez1_10c.value = ispFormatMoney(0, 0);
            }
            var totalBPTez1_10Amount = cCur(txtBPTez1_10a.value) + cCur(txtBPTez1_10b.value) + cCur(txtBPTez1_10c.value);
            if (totalBPTez1_10Amount != Math.abs(cCur($('#lblBPTez1_7').text()))) {
                if ($('#BPTez_pg1').css('display') == 'block') {
                    $(parent.AppError).text("Lines 10a, 10b and 10c must equal Line 7.");
                }
            }

            $('#lblBPTez1_9').text(ispFormatMoney(0, 0));
        }
        else {
            txtBPTez1_10a.value = ispFormatMoney(0, 0);
            txtBPTez1_10b.value = ispFormatMoney(0, 0);
            txtBPTez1_10c.value = ispFormatMoney(0, 0);
        }
    }
</script>

    </head>
    <body>
<%--<body onload="ispDisplayProgress('DisplayBPTezReturn()', 'Retrieving 2012 business income & receipts tax information')">--%>
    <div class="tab_Tcontainer" id="">
        <div class="tab_container" id="BPTez" style="DISPLAY: none;">
            <div style="display: block;" id="tab1" class="tab_content">
               <h2><span id="AppHeader">&nbsp;</span>  </h2>

                <div class="thankyou">
                    <h4 id="AppMessage">&nbsp;</h4>

                    <div class="school_form">


                        <div class="school_page_form">

                            <!--<div class="greytopbox">
                    	<div class="bluetxt">Name :</div>
                        <div class="bluetxt">SSN :</div>
                        <div class="bluetxt">Address :</div>
                        
                        <div class="clear"></div>
                    </div>-->



                            <div class="account_greybox" id="BPTezHeader">

                                <p><strong>Name :</strong> <label id=lblName class="lblTextBlack" nowrap></label> </p>
                                 <p><strong><font id="lblAccountType">Account No.:</font></strong> <label id=lblAccountId class=""></label> </p>

                                 <div class="clear"></div>
                                   <p><strong>Address :</strong> <label id=lblAddress_08 class=""></label> </p>

                                <p><strong><font id=lblEntityType>EIN :</font></strong> <label id=lblEntityId class=""></label> </p>
                              

                                <div class="clear"></div>

                            </div>


                            <div class="form_segment">


                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabularform">
                                    <tr>
                                        <th width="22%" scope="col" valign="middle" align="left" class="here_input_table">
                                            <input id=chkAmended type=checkbox onclick="chkAmended_onclick()" type="checkbox" />
                                            Check if amended return. </th>
                                        </tr>
                                  
                                </table>


                            </div>
                            <div style="DISPLAY:none" Id="BPTez_pg1" Name="BPTez_pg1">

                            <div class="form_segment">

                                <table summary="Employee Pay Sheet" class="hor-zebra">

                                    <tbody>

                                        <tr class="odd">
                                            <td width="70%">1.  Net Income Portion Of Tax - 
                                            <label id="lbl1forpage2" class="lblLink label_NoLeft" style="" onclick=ShowPage(2)>Click here for Page 2</label>
			                                <label id="lblLnkSchdN1" style="display:none;"></label></td>
                                            <td align="center" class="no_border_right">
                                               <label id=lblBPTez1_1 style="WIDTH: 100%"></label></td>
                                        </tr>
                                        <tr>
                                            <td>2.  Gross Receipts Portion Of Tax -
                                                <label id="lbl2forpage2" class="lblLink label_NoLeft" style="" onclick=ShowPage(2)>Click here for Page 2</label>
			                                    <label id="lblLnkSchdN2"  style="display:none;"></label>
                                            </td>
                                            <td align="center" class="no_border_right">
                                              	<label id=lblBPTez1_2 style="WIDTH: 100%"></label></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">3.  Tax Due for the 2012 Business Income & Receipts Tax [Calculated - add lines 1 and 2] </td>
                                            <td align="center" class="no_border_right">
                                              <label id=lblBPTez1_3 style="WIDTH: 100%"></label></td>
                                        </tr>
                                        <tr>
                                            <td>4.  <B><U>MANDATORY</U> 2013 BIRT Estimated Payment <u>(repeat line 3)</u></B></td>
                                            <td align="center" class="no_border_right">
                                               	<input class="" id=txtBPTez1_4 onchange="ValidateBPTezReturn()"
			 onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%"></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">5.  Total Due by <B>4/15/2013</B>[Calculated - add lines 3 and 4] </td>
                                            <td align="center" class="no_border_right">
                                              <label id=lblBPTez1_5 style="WIDTH: 100%"></label></td>
                                        </tr>
                                        <tr>
                                            <td><u><b>ESTIMATED PAYMENTS AND OTHER CREDITS</b></u></td>
                                            <td align="center" class="no_border_right">
                                               </td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">6a.  Credit from overpayment of 2011 or 2012 Net Profit Tax </td>
                                            <td align="center" class="no_border_right">
                                              <input class="" id=txtBPTez1_6a onchange="ValidateBPTezReturn()"
			 onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%"></td>
                                        </tr>
                                        <tr>
                                            <td>6b.  Include any estimated and/or extension payments of 2012 BIRT previously
			  made,<br>and any credit from overpayment of the 2011 BPT return</td>
                                            <td align="center" class="no_border_right">
                                               	<input class="" id=txtBPTez1_6b onchange="ValidateBPTezReturn()"
			 onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%"></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">6c.  Total Payments and Credits [Calculated - add lines 6a and 6b] </td>
                                            <td align="center" class="no_border_right">
                                              <label id=lblBPTez1_6c style="WIDTH: 100%"></label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>7.  Net Tax Due[Calculated - line 5 minus 6c]</td>
                                            <td align="center" class="no_border_right">
                                                <label id=lblBPTez1_7 style="WIDTH: 100%"></label></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">8.  Interest and Penalty (see instruction Sheet II)</td>
                                            <td align="center" class="no_border_right">
                                              <input class="" id=txtBPTez1_8 onchange="ValidateBPTezReturn()"
			 onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%">
                                            </td>
                                        </tr>
                                        <tr >
                                            <td width="70%"> <label id=lblSchoolRate style="width:70%">9.  <u><b>TOTAL DUE</b></u> including Interest and Penalty<br>
					<b>Use payment coupon. Make check payable to: "City of Philadelphia"[Calculated - add line 7 and 8]</td>
                                            <td align="center" class="no_border_right">
                                               <label id=lblBPTez1_9 style="WIDTH: 100%"></label>
                                            </td>
                                        </tr>
                                        <tr class="odd">
                                            <td><u><b>OVERPAYMENT OPTIONS</b></u></td>
                                            <td align="center" class="no_border_right">
                                              </td>
                                        </tr>
                                        <tr >
                                            <td width="70%">10a.  Refunded. <b>Do not file separate Refund Petition</b></td>
                                            <td align="center" class="no_border_right">
                                               <input class="" id=txtBPTez1_10a onchange="ValidateBPTezReturn()"
					onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%">
                                            </td>
                                        </tr>
                                        <tr class="odd">
                                            <td>10b. Applied, up to the tax due,	to the 2012 Net Profits Tax Return<</td>
                                            <td align="center" class="no_border_right">
                                                <input class="" id=txtBPTez1_10b onchange="ValidateBPTezReturn()"
					onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%">
                                                </td>
                                        </tr>
                                        <tr>
                                            <td width="70%">10c. Applied to the 2013	Business Income & Receipts Tax </td>
                                            <td align="center" class="no_border_right">
                                               <input class="" id=txtBPTez1_10c onchange="ValidateBPTezReturn()"
					onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%"></td>
                                        </tr>
                                       
                                    </tbody>
                                </table>
                                <div class="clear"></div>

                            </div>


                           <div> <%
                Html.RenderAction("PreparerSection", "INC");   
            %></div>
                             <div class="form_segment here_input_table" align="right">
                                <input type="button" value="Print" class="submit_button_light" onclick="return btnBPTezPrint_onclick()" id="btnBPTezPrint"/>
                                <input type="button" value="Submit" class="submit_button" id="btnBPTezSubmit" onclick="return btnBPTezSubmit_onclick()" />
                            </div>
                          </div>

                            <div style="DISPLAY:none" Id="BPTez_pg2" Name="BPTez_pg2">

                            <div class="form_segment">

                                <table summary="Employee Pay Sheet" class="hor-zebra">

                                    <tbody>

                                        <tr class="odd">
                                            <td width="70%">1.  <INPUT type="radio" id=radBPTez2_1_2_m2 name=radBPTez2_1_2 onclick="ValidateBPTezMethod()">
			METHOD II. Net Income (or loss) as properly reported to 
					the Federal Government</td>
                                           
                                            <td align="center" class="no_border_right">
                                             <input class="" id=txtBPTez2_1 onchange="ValidateBPTezReturn()" 
			onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%"></td>
                                        </tr>
                                        <tr>
                                            <td>OR
                                            </td>
                                            <td align="center" class="no_border_right">
                                              	<label style="WIDTH: 100%"></label></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">2.  <INPUT type="radio" id=radBPTez2_1_2_m1 name=radBPTez2_1_2 onclick="ValidateBPTezMethod()">
			METHOD I. Net Income (or loss) in accordance with Accounting
					System</td>
                                            <td align="center" class="no_border_right">
                                             <input class="" id=txtBPTez2_2 onchange="ValidateBPTezReturn()" 
			onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%"></td>
                                        </tr>
                                        <tr>
                                            <td>3.  Loss Carry Foward, if any. (<u><font style="cursor:pointer;" onclick="parent.InstructionLinks()">See Instruction Sheet IV</font></u>)</td>
                                            <td align="center" class="no_border_right">
                                               	<input class="" id=txtBPTez2_3 onchange="ValidateBPTezReturn()" 
			onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%"></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">4.  Taxable Income or Less [Calculated - line 1 OR 2 minus line 3] </td>
                                            <td align="center" class="no_border_right">
                                            <label id=lblBPTez2_4 style="WIDTH: 100%"></label></td>
                                        </tr>
                                        <tr>
                                            <td>5.  TAX DUE <label class="" id=msgBPTez2_5 style="width:100%">[Calculated - line 4 * ###]&nbsp;</label></td>
                                            <td align="center" class="no_border_right">
                                               <label id=lblBPTez2_5 style="WIDTH: 100%"></label></td>
		<td colspan=3 class="">
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%"><u>GROSS RECEIPTS PORTION</u> </td>
                                            <td align="center" class="no_border_right">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>TAXABLE GROSS RECEIPTS from:</td>
                                            <td align="center" class="no_border_right">
                                              </td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">6a.  Sales and/or Rentals of Tangible Personal Property </td>
                                            <td align="center" class="no_border_right">
                                            <input class="" id=txtBPTez2_6a onchange="ValidateBPTezReturn()" 
			onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>6b.  Net Tax Due[Calculated - line 5 minus 6c]</td>
                                            <td align="center" class="no_border_right">
                                               <input class="" id=txtBPTez2_6b onchange="ValidateBPTezReturn()" 
			onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%"></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">6c.  Rentals of Real Property</td>
                                            <td align="center" class="no_border_right">
                                            <input class="" id=txtBPTez2_6c onchange="ValidateBPTezReturn()" 
			onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%">
                                            </td>
                                        </tr>

                                         <tr>
                                            <td>6d.  Royalties</td>
                                            <td align="center" class="no_border_right">
                                              	<input class="" id=txtBPTez2_6d onchange="ValidateBPTezReturn()" 
			onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%"></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">6e.  Gains on Sales of Business Capital Assets</td>
                                            <td align="center" class="no_border_right">
                                           <input class="" id=txtBPTez2_6e onchange="ValidateBPTezReturn()" 
			onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="70%">6f.  Gains on Sales of Stocks, Bonds, etc. (not applicable to individuals)</td>
                                            <td align="center" class="no_border_right">
                                          	<input class="" id=txtBPTez2_6f onchange="ValidateBPTezReturn()" 
			onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%">
                                            </td>
                                        </tr>
                                           <tr class="odd">
                                            <td width="70%">6g.  Dividends (not applicable to individuals)</td>
                                            <td align="center" class="no_border_right">
                                           <input class="" id=txtBPTez2_6g onchange="ValidateBPTezReturn()" 
			onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>6h.  Interest (not applicable to individuals)</td>
                                            <td align="center" class="no_border_right">
                                            	<input class="" id=txtBPTez2_6h onchange="ValidateBPTezReturn()" 
			onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%"></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">6i.  Other (Describe)</td>
                                            <td align="center" class="no_border_right">
                                            <input class="" id=txtBPTez2_6i onchange="ValidateBPTezReturn()" 
			onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%">
                                            </td>
                                        </tr>

                                         <tr >
                                            <td>7.  TOTAL TAXABLE GROSS RECEIPTS[Calculated - add lines 6a through 6i]</td>
                                            <td align="center" class="no_border_right">
                                              <label id=lblBPTez2_7 style="WIDTH: 100%"></label></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%"> 8.  TAX DUE<label class="" style="width:100%" id=msgBPTez2_8>[Calculated - line 7 * ###]&nbsp;</label></td>
                                            <td align="center" class="no_border_right">
                                              <label id=lblBPTez2_8 style="WIDTH: 100%"></label>
                                            </td>
                                        </tr>
                                        <tr >
                                            <td></td>
                                            <td align="center" class="no_border_right">
                                               <input type="button" value="Go to Page 1" class="submit_button2" id="btnGoToPage1" onclick="ShowPage(1)" /></td>
                                        </tr>
                                     
                                       
                                    </tbody>
                                </table>
                                <div class="clear"></div>

                            </div>

</div>
                    
                        </div>


                    </div>

                </div>
                <div class="quicklink_btm_gen"></div>
            </div>

        </div>

        
    </div>
</body>
</html>
