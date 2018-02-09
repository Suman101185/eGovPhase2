﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
<meta http-equiv='cache-control' content='no-cache'>

<meta http-equiv='expires' content='-1'>

<meta http-equiv='pragma' content='no-cache'>

    <script type="text/javascript" language="javascript" src="../../js/JqueryMin.js"></script>
    <script>
        function parseCurrency(value) {
            return ispRemoveMoney(value);
        }
    </script>
    <script id="clientEventHandlersJS" language="javascript" type="text/javascript">



        var arrUOErr = new Array();
        var arrUO3Err = new Array();
        var txtHeader = 'Taxpayer Information';
        var dUONetRate, dUOGrossRate;
        var sYear = '11';
        var mbFirstTime = false;
        var gUserAddr = '<% Response.Write(Request.ServerVariables["REMOTE_ADDR"]); %>';


        function ReloadUONew() {

          //  parent.$g.loadXmlAsync('../../xml/UOFormNew', parent.MenuWin.parseXml_xmlUOFormNew);
            parent.$g.loadXmlSync("XML/UOFormNew", parent.$g.parseXml_xmlUOFormNew);
           
          
        }
        function DisplayUOReturn() {
            ReloadUONew();
            //alert(sFreq);
            if (parent.GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '84') == 1) { //Chayan//

                //parent.$g.oUOFormNew = .loadXML('<%= Session["EOLFORMXML"]%>')
               // parent.$g.oUOFormNew = $.parseXML('<%= Session["EOLFORMXML"]%>');
                LoadGenericDD(parent.$g.xmlEntityType, ddUO3_EinSsn, "DDOWN", false);

               // parent.MenuWin.ispHighlightMenu(parent.MenuWin.mnuUO);
                $('#divUO').css("display", "block");
                $('#divUO1_pg1').css("display", "block");
                $('#AppHeader').html(txtHeader + '<Font class=hdrMedium>|Business Use & Occupancy Tax Return</Font>');
                parent.gsInstructionItem = ''; 	//'#BptEz'
               // $('#AppMessage').html(parent.MenuWin.gsInstructionText);
                $('#InstructionText').html(' for Instructions on filing this return');


                if (parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'ERROR_INFO ERROR', "", 0) != 0 && parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'ERROR_INFO ERROR', "", 0) != undefined) {

                    $(parent.RightFrame).attr("rows", "*,0");
                    $('#divUO').css("display", "block");

                    PopulateUOHeader();
                    FieldLock(true);
                    $(parent.AppError).text(parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'ERROR_INFO MESSAGE', "", 0));
                    $('#btnUOSubmit').attr("disabled", "disabled");
                    $('#chkAmended').attr("disabled", "disabled");
                    //btnUOSubmit.disabled = true;
                    //chkAmended.disabled = true;

                    return;
                }

                if ($(parent.divAcctInfo).css("display") == "none") {
                    $(parent.divAcctInfo).css("display", "block");
                    $(parent.divAccount).css("display", "none");
                }

            } else {
                parent.ispMenu_onclick(parent.mnuAcctInfo);
                return;
            }

            if (parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO_AMTS MAX_TAX', '', 0) == '') {
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, 0, 'UO_AMTS MAX_TAX', '', 0);
            }

            $(parent.RightFrame).attr("rows", "*,0");

            LoadUOError();

            LoadUO3Error();

            RightAlignText();

            CheckUOXML();

            PopulateUOHeader();

            PopulateUOData();
            //CalcPage1Line11();
            PopulateUO3Data();

            SetUOFields();

            //CalculateFields();

            //ValidateLinesonLoad();

            $(parent.AppError).text('');



        } //DisplayUOReturn


        function SetUOFields() {
            chkAmended.checked = false;
            $('#chkAmended').removeAttr("checked");
            ////alert(parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO_ACCT VERSION', '', 0));
            if (parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO_ACCT VERSION', '', 0) == '') {


                mbFirstTime = true;
                FieldLock(false);
                $('#chkAmended').attr("disabled", "disabled");
                chkAmended.checked = false;
            } else {

                $('#chkAmended').removeAttr("disabled");
                FieldLock(true);
            }
        } //SetUOFields


        function FieldLock(bDisabled) {
            if (bDisabled == true) {
                $('#txtUO1_2').attr("disabled", "disabled");
                $('#txtUO1_3').attr("disabled", "disabled");
                $('#txtUO1_4').attr("disabled", "disabled");
                $('#txtUO1_5').attr("disabled", "disabled");
                $('#txtUO1_7').attr("disabled", "disabled");
                $('#txtUO1_8').attr("disabled", "disabled");
                $('#txtUO1_9').attr("disabled", "disabled");
                $('#lblUO1_10').attr("disabled", "disabled");
                $('#txtUO1_11').attr("disabled", "disabled");
                $('#txtUO1_13').attr("disabled", "disabled");
                $('#btnUOSubmit').attr("disabled", "disabled");

                //UO3
                $('#txtUO3_TenantName').attr("disabled", "disabled");
                $('#ddUO3_EinSsn').attr("disabled", "disabled");
                $('#txtUO3_EinSsn').attr("disabled", "disabled");
                $('#txtUO3_UnpaidTax').attr("disabled", "disabled");
                $('#btnUO3_Add').attr("disabled", "disabled");
                DisablePreparer(bDisabled);
            }
            else {
                $('#txtUO1_2').removeAttr("disabled");
                $('#txtUO1_3').removeAttr("disabled");
                $('#txtUO1_4').removeAttr("disabled");
                $('#txtUO1_5').removeAttr("disabled");
                $('#txtUO1_7').removeAttr("disabled");
                $('#txtUO1_8').removeAttr("disabled");
                $('#txtUO1_9').removeAttr("disabled");
                $('#txtUO1_11').removeAttr("disabled");
                $('#txtUO1_13').removeAttr("disabled");
                $('#btnUOSubmit').removeAttr("disabled");
                DisablePreparer(bDisabled);
                //UO3
                $('#txtUO3_TenantName').removeAttr("disabled");
                $('#ddUO3_EinSsn').removeAttr("disabled");
                $('#txtUO3_EinSsn').removeAttr("disabled");
                $('#txtUO3_UnpaidTax').removeAttr("disabled");
                $('#btnUO3_Add').removeAttr("disabled");


            }
        } //FieldLock


        function CheckUOXML() {
            var bPeriodExist = true;

            if (parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO1_AMTS TOTAL_DUE', '', 0) == '$0') {
                bPeriodExist = false;
            }

            if (bPeriodExist == false) {
                parent.$x.parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, '', 'ERROR_INFO PROGRAM', '', 0);
                parent.$x.parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, '', 'ERROR_INFO ERROR', '', 0);
                parent.$x.parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, '', 'ERROR_INFO LINE', '', 0);
                parent.$x.parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, '', 'ERROR_INFO MESSAGE', '', 0);

                parent.$x.parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, '12/31/2011', 'UO_ACCT PERIOD', '', 0);
                parent.$x.parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, '', 'UO_ACCT VERSION', '', 0);
                parent.$x.parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, '', 'UO_ACCT RETURN_STATUS', '', 0);
                parent.$x.parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, '', 'UO_ACCT LAST_UPD_DATE', '', 0);
                parent.$x.parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, '', 'UO_ACCT RECORDING_DATE', '', 0);
                parent.$x.parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, '', 'UO_ACCT EXTENSION_DATE', '', 0);
                parent.$x.parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, '', 'UO_ACCT SEQUENCE', '', 0);
                parent.$x.parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, '', 'UO_ACCT ADJUSTMENT_REF_NO', '', 0);
                ClearPreparerXML(parent.$g.oUOFormNew, 'UO_ACCT');

                parent.$x.parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, 0, 'UO_AMTS MAX_TAX', '', 0);
                parent.$x.parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, 0, 'UO_AMTS GROSS_TAX', '', 0);
                parent.$x.parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, 0, 'UO_AMTS ACTUAL_TAX', '', 0);
                parent.$x.parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, 0, 'UO_AMTS ESTIMATED_TAX', '', 0);
                parent.$x.parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, 0, 'UO_AMTS TOTAL_TAX', '', 0);
                parent.$x.parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, 0, 'UO_AMTS NPT_TAX_CREDIT', '', 0);
                parent.$x.parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, 0, 'UO_AMTS BPT_TAX_CREDIT', '', 0);
                parent.$x.parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, 0, 'UO_AMTS TOTAL_PAY_CREDIT', '', 0);
                parent.$x.parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, 0, 'UO_AMTS TAX_DUE', '', 0);
                parent.$x.parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, 0, 'UO_AMTS INTEREST_PENALTY', '', 0);
                parent.$x.parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, 0, 'UO_AMTS AMOUNT_OWED', '', 0);
                parent.$x.parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, 0, 'UO_AMTS REFUND', '', 0);
                parent.$x.parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, 0, 'UO_AMTS NPT_OVERPAY', '', 0);
                parent.$x.parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, 0, 'UO_AMTS BPT_OVERPAY', '', 0);
            }
        } //CheckUOXML


        function PopulateUOHeader() {
            var addrIdx, sFirstName, sMIName, sLastName;
            sFirstName = '';
            sMIName = '';
            sLastName = '';

            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ENTITY_ID', '', 0) != '') {
                $('#lblEntityId').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ENTITY_ID', '', 0));
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO TYPE', '', 0) == 1) {
                    $('#lblEntityType').text('EIN:');
                    $('#lblEntityId').text(' ' + $('#lblEntityId').text().substr(0, 2) + '-' + $('#lblEntityId').text().substr(2));
                    $('#lblName').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS NAME', '', addrIdx));
                } else {
                    $('#lblEntityType').text('SSN:');
                    $('#lblEntityId').text(' ' + $('#lblEntityId').text().substr(0, 3) +
                                   '-' + $('#lblEntityId').text().substr(3, 2) +
                                   '-' + $('#lblEntityId').text().substr(5));

                    sEntityName = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS NAME', '', addrIdx).split('*');
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

            $('#lblAccountId').text(parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO_ACCT ACCOUNT_ID', '', 0));
            $('#lblPropertyAddress').html(parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO_ACCT LOCATION', '', 0));
            $('#lblPropertyNumber').html(parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO_ACCT BRT_NUMBER', '', 0));
            $('#lblTaxPeriod').html(parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO_ACCT PERIOD', '', 0));

            var lPeriodCode = parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO_ACCT PERIOD_CODE', '', 0);
            if (lPeriodCode != null) {
                if (lPeriodCode.length == 1) {
                    lPeriodCode = '0' + lPeriodCode;
                }
            }
            $('#lblPeriod_Code').html(lPeriodCode + '' + parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO_ACCT PERIOD_YY', '', 0));
            $('#lblAccessedValue').html(parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO_ACCT ASSESSED_VALUE', '', 0));
            $('#lblDueDate').html(parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO_ACCT DUE_DATE', '', 0));

        } //PopulateUOHeader


        function PopulateUOData() {
            //Page1
            $('#lblUO1_1').html(parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO_AMTS MAX_TAX', '', 0));
            $('#lblUO1_1').html(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO_AMTS MAX_TAX', '', 0), 0));
            txtUO1_2.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO_AMTS VACANCY', '', 0), 0)
            txtUO1_3.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO_AMTS EXEMPT', '', 0), 0)
            txtUO1_4.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO_AMTS RESIDENTIAL', '', 0), 0)
            txtUO1_5.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO_AMTS KOZ_CREDIT', '', 0), 0)
            $('#lblUO1_6').html(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO_AMTS TOTAL_DEDUCTIONS', '', 0), 0));
            $('#lblUO1_7').html(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO_AMTS PERIOD_TAX', '', 0), 0));
            $('#lblUO1_8').html(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO_AMTS FIXED_EXEMPTN', '', 0), 0));
            txtUO1_9.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO_AMTS DELINQUENT', '', 0), 0)
            $('#lblUO1_10').html(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO_AMTS ADJUSTED_TAX', '', 0), 0));
            $('#txtUO1_11').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO_AMTS DISCOUNT', '', 0), 0));
            $('#lblUO1_12').html(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO_AMTS TAX_DUE', '', 0), 0));
            txtUO1_13.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO_AMTS INTEREST_PENALTY', '', 0), 0)
            $('#lblUO1_14').html(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO_AMTS TOTAL_DUE', '', 0), 0));
            PopulatePreparer(parent.$g.oUOFormNew, 'UO_ACCT');
            //UO3
        } //PopulateUOData

        function PopulateUOXML() {
            var d = new Date();
            var lYear = String(d.getFullYear());

            var lMonth = String(d.getMonth() + 1);
            lMonth = lMonth.length == 1 ? '0' + lMonth : lMonth;
            var lDate = String(d.getDate());
            lDate = lDate.length == 1 ? '0' + lDate : lDate;

            parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, lMonth + '/' + lDate + '/' + lYear, 'UO_ACCT RECORDING_DATE', '', 0);
            //Page1
            parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, stripCurrency($('#lblUO1_1').text()), 'UO_AMTS MAX_TAX', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, stripCurrency(txtUO1_2.value), 'UO_AMTS VACANCY', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, stripCurrency(txtUO1_3.value), 'UO_AMTS EXEMPT', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, stripCurrency(txtUO1_4.value), 'UO_AMTS RESIDENTIAL', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, stripCurrency(txtUO1_9.value), 'UO_AMTS DELINQUENT', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, stripCurrency(txtUO1_5.value), 'UO_AMTS KOZ_CREDIT', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, stripCurrency($('#lblUO1_6').text()), 'UO_AMTS TOTAL_DEDUCTIONS', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, stripCurrency($('#lblUO1_7').text()), 'UO_AMTS PERIOD_TAX', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, stripCurrency($('#txtUO1_11').val()), 'UO_AMTS DISCOUNT', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, stripCurrency($('#lblUO1_12').text()), 'UO_AMTS TAX_DUE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, stripCurrency(txtUO1_13.value), 'UO_AMTS INTEREST_PENALTY', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, stripCurrency($('#lblUO1_14').text()), 'UO_AMTS TOTAL_DUE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, stripCurrency($('#lblUO1_8').text()), 'UO_AMTS FIXED_EXEMPTN', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, stripCurrency($('#lblUO1_10').text()), 'UO_AMTS ADJUSTED_TAX', '', 0);




            PopulatePreparerXML(parent.$g.oUOFormNew, 'UO_ACCT');

            //Page2
            PopulateUO3XML();

            parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, '', 'DEBUG', '', 0);
        } //PopulateUOXML

        function RightAlignText() {
            //Page1
            $('#lblUO1_1').parent().css("text-align", "right");
            $('#txtUO1_2').css("text-align", "right");
            $('#txtUO1_3').css("text-align", "right");
            $('#txtUO1_4').css("text-align", "right");
            $('#txtUO1_5').css("text-align", "right");
            $('#lblUO1_6').parent().css("text-align", "right");
            $('#lblUO1_7').parent().css("text-align", "right");
            $('#lblUO1_8').parent().css("text-align", "right");
            $('#txtUO1_9').css("text-align", "right");
            $('#lblUO1_10').parent().css("text-align", "right");
            $('#txtUO1_11').css("text-align", "right");
            $('#lblUO1_12').parent().css("text-align", "right");
            $('#txtUO1_13').css("text-align", "right");
            $('#lblUO1_14').parent().css("text-align", "right");
        } //RightAlignText


        function LoadUOError() {
            var i = 0;
            //Page1
            arrUOErr[i++] = [txtUO1_2, 'txtUO1_2.value == ""', 'Answer Question 2'];
            arrUOErr[i++] = [txtUO1_2, 'ispValue(txtUO1_2.value) == false', 'Value for Question 2 must be numeric'];
            arrUOErr[i++] = [txtUO1_2, 'ispNegativeNumber(txtUO1_2.value) == false', 'Value for Question 2 must NOT be negative'];

            arrUOErr[i++] = [txtUO1_3, 'txtUO1_3.value == ""', 'Answer Question 3'];
            arrUOErr[i++] = [txtUO1_3, 'ispValue(txtUO1_3.value) == false', 'Value for Question 3 must be numeric'];
            arrUOErr[i++] = [txtUO1_3, 'ispNegativeNumber(txtUO1_3.value) == false', 'Value for Question 3 must NOT be negative'];

            arrUOErr[i++] = [txtUO1_4, 'txtUO1_4.value == ""', 'Answer Question 4'];
            arrUOErr[i++] = [txtUO1_4, 'ispValue(txtUO1_4.value) == false', 'Value for Question 4 must be numeric'];
            arrUOErr[i++] = [txtUO1_4, 'ispNegativeNumber(txtUO1_4.value) == false', 'Value for Question 4 must NOT be negative'];

            arrUOErr[i++] = [txtUO1_5, 'ispValue(txtUO1_5.value) == false', 'Value for Question 5 must be numeric'];
            arrUOErr[i++] = [txtUO1_5, 'ispNegativeNumber(txtUO1_5.value) == false', 'Value for Question 5 must NOT be negative'];

            arrUOErr[i++] = [txtUO1_9, 'ispValue(txtUO1_9.value) == false', 'Value for Question 9 must be numeric'];
            arrUOErr[i++] = [txtUO1_9, 'ispNegativeNumber(txtUO1_9.value) == false', 'Value for Question 9 must NOT be negative'];

            //arrUOErr[i++] = [lblUO1_10, 'ispValue($("#lblUO1_10").text()) == false', 'Value for Question 10 must be numeric'];
            //arrUOErr[i++] = [lblUO1_10, 'ispNegativeNumber($("#lblUO1_10").text()) == false', 'Value for Question 10 must NOT be negative'];

            arrUOErr[i++] = [txtUO1_13, 'ispValue(txtUO1_13.value) == false', 'Value for Question 13 must be numeric'];
            arrUOErr[i++] = [txtUO1_13, 'ispNegativeNumber(txtUO1_13.value) == false', 'Value for Question 13 must NOT be negative'];
        } //LoadUOError

        function LoadUO3Error() {
            var i = 0;
            //UO3
            arrUO3Err[i++] = [txtUO3_TenantName, 'txtUO3_TenantName.value == ""', 'Tenant Name is Required'];

            arrUO3Err[i++] = [txtUO3_UOAccountNumber, 'txtUO3_UOAccountNumber.value != "" && isNaN(txtUO3_UOAccountNumber.value)', 'U&O Account Number must be numeric'];
            arrUO3Err[i++] = [txtUO3_UOAccountNumber, 'txtUO3_UOAccountNumber.value != "" && ispNegativeNumber(txtUO3_UOAccountNumber.value) == false', 'U&O Account Number must NOT be negative'];

            arrUO3Err[i++] = [txtUO3_EinSsn, 'txtUO3_EinSsn.value == ""', 'SSN/EIN is Required'];
            arrUO3Err[i++] = [txtUO3_EinSsn, 'isNaN(txtUO3_EinSsn.value)', 'SSN/EIN must be numeric'];
            arrUO3Err[i++] = [txtUO3_EinSsn, 'ispNegativeNumber(txtUO3_EinSsn.value) == false', 'SSN/EIN must NOT be negative'];

            arrUO3Err[i++] = [txtUO3_UnpaidTax, 'txtUO3_UnpaidTax.value == ""', 'Unpaid Tax is Required'];
            arrUO3Err[i++] = [txtUO3_UnpaidTax, 'ispValue(txtUO3_UnpaidTax.value) == false', 'Unpaid Tax must be numeric'];
            arrUO3Err[i++] = [txtUO3_UnpaidTax, 'ispNegativeNumber(txtUO3_UnpaidTax.value) == false', 'Unpaid Tax must NOT be negative'];
        } //LoadUO3Error

        function btnUOPrint_onclick() {
            var objCurrDisplayed, lUO3_pg2;

            $('#btnUOPrint').css("visibility", "hidden");
            $('#btnUOSubmit').css("visibility", "hidden");
            $('#btnUO3_Add').css("visibility", "hidden");
            $('#btnUO3_Cancel').css("visibility", "hidden");
            $('#tblTenant').css("display", "none");
            $('#btnUO1Pg1').css("visibility", "hidden");
            $('#btnSelectPg').css("visibility", "hidden");

            lUO3_pg2 = $('#divUO3_pg2').html();
            $("#divUO3_pg2").css("page-break-before", "always");

            if ($("#divUO1_pg1").css("display") == 'block') {
                objCurrDisplayed = divUO1_pg1;
                $("#divUO3_pg2").css("display", "block");
            } else {
                objCurrDisplayed = divUO3_pg2;
                $("#divUO1_pg1").css("display", "block");
            }

            $(parent.AppError).text("");
            $("#divUO3_pg2").prepend($("#divUOHeader").html() + '<BR>');
            if ($('#txtUO1_2').is(":disabled") == true) {
                FieldLock(false);
                window.print();
                $("#divUO3_pg2").html(lUO3_pg2);
                FieldLock(true);
            } else {
                window.print();
                $("#divUO3_pg2").html(lUO3_pg2);
            }

            $("#btnUOPrint").css("visibility", "visible");
            $("#btnUOSubmit").css("visibility", "visible");
            $("#btnUO3_Add").css("visibility", "visible");
            $("#btnUO3_Cancel").css("visibility", "visible");
            $("#tblTenant").css("display", "block");
            $("#btnUO1Pg1").css("visibility", "visible");
            $("#btnSelectPg").css("visibility", "visible");

            if (objCurrDisplayed == divUO1_pg1) {
                $("#divUO3_pg2").css("display", "none");
            } else {
                $("#divUO1_pg1").css("display", "none");
            }
        } //btnUOPrint_onclick


        function btnUOSubmit_onclick() {

            $(parent.AppError).text("");
            ValidateUOReturn();

            if ($(parent.AppError).text() == "") {
                $(parent.AppError).text(ValidatePreparer());
            }

            if ($(parent.AppError).text() == "") {

                parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, '', 'UO_ACCT RETURN_STATUS', '', 0);

                PopulateUOXML();

                parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, '', 'ERROR_INFO MESSAGE', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, 'UPD', 'UO_ACCT RETURN_STATUS', '', 0);

                var tempXML = parent.$g.getXmlDocObj(); //new ActiveXObject("MSXML.DOMDocument")
                //clipboardData.setData ('Text', parent.$g.oUOFormNew.xml.xml);
                //alert('before submit xml loaded');

                ispCallXMLForm(parent.$g.oUOFormNew, tempXML, "UO/UOFormCallNew", "");

                //clipboardData.setData ('Text', tempXML.xml.xml);
                //alert('xml returned after submission');
                if (parent.$x.ispXmlGetFieldVal(tempXML, 'ERROR_INFO PROGRAM', '', 0) == '') {
                    parent.$g.oUOFormNew.loadXML(tempXML);
                    //	alert('after submit');
                    $("#divUO").css("display", "none");
                    UOThankYouDisplayNew();
                } else {
                    $(parent.AppError).text(parent.$x.ispXmlGetFieldVal(tempXML, 'ERROR_INFO MESSAGE', '', 0));
                }
            }
        } //btnUOSubmit_onclick


        function ShowPage(iPage) { //load
            if (iPage == 2) {
                $("#divUO1_pg1").css("display", "none");
                $("#divUO3_pg2").css("display", "block");
                if ($("#tblUO3TenantGrid tr").length > 10) {
                    alert('Online UO3 application can only handle 10 Tenants');
                } else {
                    $("#txtUO3_TenantName").focus();
                }
            } else {
                UO3ClearTenantFrame();
                UO3PopulateUO1Line5();

                ValidateUOReturn();

                $("#divUO3_pg2").css("display", "none");
                $("#divUO1_pg1").css("display", "block");
                $("#txtUO1_2").focus();
            }
        } //ShowPage


        function chkAmended_onclick() {

            if ($("#chkAmended").is(":checked") == true) {
                $("#btnUOSubmit").removeAttr("disabled");
                FieldLock(false);
                ClearPreparer();
                if ($("#divUO1_pg1").css("display") == 'block') {
                    //          ShowPage(1)
                    $("#txtUO1_2").focus();
                } else {
                    //			ShowPage(2)
                    if ($("#tblUO3TenantGrid tr").length > 10) {
                        alert('Online UO3 application can only handle 10 Tenants');
                        $("#txtUO3_TenantName").attr("disabled", "disabled");
                        $("#ddUO3_EinSsn").attr("disabled", "disabled");
                        $("#txtUO3_EinSsn").attr("disabled", "disabled");
                        $("#txtUO3_UnpaidTax").attr("disabled", "disabled");
                    } else {
                        $("#txtUO3_TenantName").select();
                    }
                } 	//if
            } else {
                UO3ClearTenantFrame();
                UO3RemoveRows();
                PopulateUOData();

                $("#btnUOSubmit").attr("disabled", "disabled");
                FieldLock(true);
                PopulatePreparer(parent.$g.oUOFormNew, 'UO_ACCT');
            }
        } //chkAmended_onclick


        function LocatePrimaryAddr() {
            var iMaxIdx = parent.$x.ispXmlGetRecCount(parent.$g.xmlAccount, 'NAME_ADDRESS', '');
            for (idx = 0; idx < iMaxIdx; i++) {
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS_TYPE', '', idx) == '60') {
                    if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS RELATIONSHIP_CODE', '', idx) == '0') {
                        return idx;
                    }
                } else {
                    return 0;
                }
            }
        } //locatePrimaryAddr
        /*
        jQuery.extend(jQuery.expr[':'], {
        focus: function (element) {
        return element == document.activeElement;
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

        function ValidateUOReturn() {

            var evt = window.event || arguments.callee.caller.arguments[0];
            var source = parent.getEventSource(evt);
            var ObjSelected
            $(parent.AppError).text('');



            if (source != null) {
                var sId = source.id;
                ObjSelected = document.getElementById(sId)

                if (ObjSelected != null) {
                    if (sId == "txtUO3_TenantName" || source.type == 'button') {
                    } else {
                        ObjSelected.value = ispFormatMoney(ObjSelected.value, 0)
                    }		//if
                }
            }

            $(parent.AppError).text(ispSetInputErr(arrUOErr));

            if ($(parent.AppError).text() == '') {

                CalculateFields(sId);

            }
        } //ValidateUOReturn

        function CalculateFields(sId) {
            CalcPage1Line6();
            CalcPage1Line7();
            //CalcPage1Line8();
            CalcPage1Line10();
            CalcPage1Line11(sId);
            CalcPage1Line12();
            CalcPage1Line14();


        }

        function ValidateLinesonLoad() {

            if ($('#lblUO1_6').text() == "$0") {
                CalcPage1Line6();
            }

            if ($('#lblUO1_7').text() == "$0") {

                CalcPage1Line7();
            }

            CalcPage1Line8();

            //if ($('#lblUO1_10').text() == "$0") {
            CalcPage1Line10();
            //}
            if ($('#txtUO1_11').val() == "$0") {
                //alert('12');
                CalcPage1Line11();
            }
            if ($('#lblUO1_12').text() == "$0") {
                CalcPage1Line12();
            }
            if ($('#lblUO1_14').text() == "$0") {
                CalcPage1Line14();
            }
        }

        function CalcPage1Line6() {
            $('#lblUO1_6').html(ispFormatMoney(parseCurrency(txtUO1_2.value.replace(',', '').replace('$', '')) + parseCurrency(txtUO1_3.value.replace(',', '').replace('$', '')) + parseCurrency(txtUO1_4.value.replace(',', '').replace('$', '')) + parseCurrency(txtUO1_5.value.replace(',', '').replace('$', '')), 0));

            if (parseCurrency($('#lblUO1_6').html().replace(',', '').replace('$', '')) > parseCurrency($('#lblUO1_1').html().replace(',', '').replace('$', ''))) {
                $(parent.AppError).text("Line 6 can not be greater than Line 1");
            }

        }
        function CalcPage1Line7() {

            $('#lblUO1_7').html(parseCurrency($('#lblUO1_1').html().replace(',', '').replace('$', '')) - parseCurrency($('#lblUO1_6').html().replace(',', '').replace('$', '')));
            if (parseCurrency($('#lblUO1_7').html().replace(',', '').replace('$', '')) < 0) {
                $('#lblUO1_7').html(ispFormatMoney(0, 0));
            }
            else {

                $('#lblUO1_7').html(ispFormatMoney($('#lblUO1_7').html(), 0));
            }


        }
        function CalcPage1Line8() {


            if (sFreq != 'undefined') {
                if (sFreq == 'M') {
                    $('#lblUO1_8').html('$167');
                }
                else if (sFreq == 'Q') {
                    $('#lblUO1_8').html('$500');
                }
            }


        }
        function CalcPage1Line10() {
            var Line8Line9;
            Line8Line9 = parseCurrency($('#lblUO1_8').html().replace(',', '').replace('$', '')) + parseCurrency(txtUO1_9.value.replace(',', '').replace('$', ''));

            $('#lblUO1_10').html(ispFormatMoney(parseCurrency($('#lblUO1_7').html().replace(',', '').replace('$', '')) - Line8Line9, 0));
            var diff = parseCurrency($('#lblUO1_7').html().replace(',', '').replace('$', '')) - Line8Line9;
            if (diff < 0) {
                $('#lblUO1_10').html(ispFormatMoney(0, 0));
            }
        }
        function CalcPage1Line11(sid) {

            var disC = parseCurrency($('#lblUO1_10').html()) * .01;
            var enteredAmt = parseCurrency($('#txtUO1_11').val());

            if (enteredAmt > disC) {

                if (sid != null) {
                    if (sid == "txtUO1_11" || sid == "btnUOSubmit") {
                        if (confirm("Discount (Line 11) can not be greater than 1% of pre- discount amount (Line 10)")) {
                            $('#txtUO1_11').val(ispFormatMoney(0, 0));

                        }
                        else {
                            $(parent.AppError).text("Discount (Line 11) can not be greater than 1% of pre- discount amount (Line 10)");
                        }
                    }


                }
            }

        }
        function CalcPage1Line12() {

            $('#lblUO1_12').html(ispFormatMoney(parseCurrency($('#lblUO1_10').html().replace(',', '').replace('$', '')) - parseCurrency($('#txtUO1_11').val().replace(',', '').replace('$', '')), 0));
        }

        function CalcPage1Line14() {
            $('#lblUO1_14').html(ispFormatMoney(parseCurrency($('#lblUO1_12').html().replace(',', '').replace('$', '')) + parseCurrency(txtUO1_13.value.replace(',', '').replace('$', '')), 0));

        }
        function ValidateUO3Return() {
            $(parent.AppError).text(ispSetInputErr(arrUO3Err));
            if ($(parent.AppError).text() == "") {
                $("#btnUO3_Add").attr("disabled", false);
            } else {
                $("#btnUO3_Add").attr("disabled", true);
            }
        } //ValidateUO3Return

        function UO3ClearTenantFrame() {
            UO3LockEditDeleteButtons(false);
            $(parent.AppError).text("");
            $("#txtUO3_TenantName").val("");
            $("#txtUO3_UOAccountNumber").val('');
            $("#ddUO3_EinSsn").attr("selectedIndex", 0);
            $("#txtUO3_EinSsn").val('');
            $("#txtUO3_UnpaidTax").val("");
            $("#txtUO3_TenantName").select();
            if ($("#btnUO3_Add").val().toUpperCase() == 'UPDATE') {
                $("#btnUO3_Add").val("Add");
            }
        } //UO3ClearTenantFrame

        function UO3UpdateTenantList() { //CHayan
            if ($("#btnUO3_Add").val().toUpperCase() == 'ADD') {
                UO3AddRow(false);
            } else {
                $(parent.AppError).text(ispSetInputErr(arrUO3Err));
                if ($(parent.AppError).text() != "") {
                    return;
                }
                UO3LockEditDeleteButtons(false);
                $('#' + txtUO3RowId.value).find('td').eq(0).text(txtUO3_TenantName.value);
                $('#' + txtUO3RowId.value).find('td').eq(1).text(txtUO3_UOAccountNumber.value);
                $('#' + txtUO3RowId.value).find('td').eq(2).text(txtUO3_EinSsn.value);
                $('#' + txtUO3RowId.value).find('td').eq(3).text(ispFormatMoney(txtUO3_UnpaidTax.value, 0));

                txtUO3RowId.value = '';
            } 	//if
            if ($(parent.AppError).text() == '') {
                UO3ClearTenantFrame();

            } 	//if
        } 	//UO3UpdateTenantList

        function UO3AddRow(isExisting) { //Chayan
            $('#lblMoreThen10').css("display", "block");
            if (tblUO3TenantGrid.rows.length == 11) {
                $('#lblMoreThen10').css("display", "block");
                alert('Online UO3 application can only handle 10 Tenants');
                return;
            } 	//if
            if (isExisting == false) {
                $(parent.AppError).text(ispSetInputErr(arrUO3Err));
                if ($(parent.AppError).text() != "") {
                    return;
                } 	//if
            } 	//if

            var row = tblUO3TenantGrid.insertRow(1);

            lDate = new Date();
            if (isExisting == false) {
                row.id = 'ROW' + lDate.getSeconds() + '' + lDate.getMilliseconds();
                $(row).attr("id", "ROW" + lDate.getSeconds() + "" + lDate.getMilliseconds());
            } 	//if
            if (tblUO3TenantGrid.rows.length % 2 == 0) {
                $(row).addClass('rowDataEven');
            } else {
                $(row).addClass('rowDataOdd');
            } 	//if
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            var cell5 = row.insertCell(4);


            $(cell1).text(txtUO3_TenantName.value);

            $(cell2).addClass('celLeft');
            $(cell2).css("marginLeft", "5px");
            if (txtUO3_UOAccountNumber.value != '') {
                $(cell2).text(txtUO3_UOAccountNumber.value);
            } else {
                $(cell2).html('&nbsp;');
            }

            $(cell3).addClass('celLeft');
            $(cell3).css("marginLeft", "5px");
            $(cell3).text(txtUO3_EinSsn.value);

            $(cell4).addClass('celLeft');
            $(cell4).attr("align", "right");
            $(cell4).css("marginLeft", "5px");
            $(cell4).text(ispFormatMoney(txtUO3_UnpaidTax.value, 0));

            $(cell5).addClass('celLeft');
            $(cell5).attr("align", "right");
            if (isExisting == false) {
                $(cell5).html('<input id="EDIT' + lDate.getSeconds() + '' + lDate.getMilliseconds() + '" type="button" value="Edit" style="margin-right:10px" class=btnSmall onclick="UO3EditTenant(this)" /><input id="DEL' + lDate.getSeconds() + '' + lDate.getMilliseconds() + '" type="button" value="Delete" class=btnSmall onclick="UO3DeleteTenant(this)"/>');
            } else {
                $(cell5).html('&nbsp;');
            }
        } 	//UO3AddRow

        function UO3EditTenant(caller) {
            UO3LockEditDeleteButtons(true);
            var RowId = 'ROW' + caller.id.replace('EDIT', '');
            txtUO3RowId.value = RowId;
            txtUO3_TenantName.value = $('#' + RowId).find('td').eq(0).text();
            txtUO3_UOAccountNumber.value = $('#' + RowId).find('td').eq(1).text();
            txtUO3_EinSsn.value = $('#' + RowId).find('td').eq(2).text();
            txtUO3_UnpaidTax.value = $('#' + RowId).find('td').eq(3).text();
            btnUO3_Add.value = 'Update';
            txtUO3_TenantName.select();

        } 	//UO3EditTenant

        function UO3DeleteTenant(caller) {
            var RowId = 'ROW' + caller.id.replace('DEL', '')
            $('#' + RowId).remove();
            for (var i = 1; i < tblUO3TenantGrid.rows.length; i++) {
                if (i % 2 == 0) {
                    $('#tblUO3TenantGrid').find('tr').eq(i).addClass("rowDataEven");
                } else {
                    $('#tblUO3TenantGrid').find('tr').eq(i).addClass("rowDataOdd");
                } 	//if
            } 		//for
        } 	//UO3DeleteTenant

        function UO3RemoveRows() {
            for (var i = tblUO3TenantGrid.rows.length - 1; i > 0; i--) {

                if ($('#tblUO3TenantGrid').find('tr').eq(i).attr('id') != '') {
                    $('#tblUO3TenantGrid').find('tr').eq(i).remove();
                }
            } 	//for
        } 	//UO3RemoveRows

        function UO3PopulateUO1Line5() { // 
            var iTotalUnpaidTax = 0;
            if ($('#txtUO3_TenantName').attr("disabled") != "disabled") {
                for (var i = 1; i < tblUO3TenantGrid.rows.length; i++) {
                    var unpaid = $('#tblUO3TenantGrid tr').eq(i).find('td').eq(3).text();
                    iTotalUnpaidTax = parseCurrency(iTotalUnpaidTax) + parseCurrency(stripCurrency(unpaid).replace('$', ''));
                } 	//for
                txtUO1_9.value = ispFormatMoney(iTotalUnpaidTax, 0);
            } 	//if
        } 	//UO3PopulateUO1Line5()

        function PopulateUO3Data() {
            var iRecCount = parent.$x.ispXmlGetRecCount(parent.$g.oUOFormNew, 'UO3_PAGE', '');
            if (iRecCount > 0 && parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO3_PAGE PROCESS_CODE', '', '0') != '') {
                for (var i = 0; i < iRecCount; i++) {
                    txtUO3_TenantName.value = parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO3_PAGE TENANT_NAME', '', i);
                    txtUO3_UOAccountNumber.value = parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO3_PAGE ACCOUNT_ID', '', i);
                    txtUO3_EinSsn.value = parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO3_PAGE TENANT_ID', '', i);
                    txtUO3_UnpaidTax.value = parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO3_PAGE AMOUNT', '', i);
                    UO3AddRow(true)
                    UO3ClearTenantFrame()
                } 		//for
            } 	//if
        } 	//PopulateUO3Data()

        function PopulateUO3XML() {
            var iRecCount = parent.$x.ispXmlGetRecCount(parent.$g.oUOFormNew, 'UO3_PAGE', '');
            if (tblUO3TenantGrid.rows.length - 1 != iRecCount) {
               // ispXmlAddBlankRecsUO(parent.$g.oUOFormNew, 'UO3_PAGE', tblUO3TenantGrid.rows.length - 1 - iRecCount);
                parent.$x.ispXmlAddBlankRecs(parent.$g.oUOFormNew, 'UO3_PAGE', tblUO3TenantGrid.rows.length - 1 - iRecCount);
            } 	//if
            for (var i = 1; i < tblUO3TenantGrid.rows.length; i++) {
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, '', 'UO3_PAGE PROCESS_CODE', '', i - 1);
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, $('#tblUO3TenantGrid tr').eq(i).find('td').eq(0).text(), 'UO3_PAGE TENANT_NAME', '', i - 1);
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, $('#tblUO3TenantGrid tr').eq(i).find('td').eq(1).text(), 'UO3_PAGE ACCOUNT_ID', '', i - 1);
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, $('#tblUO3TenantGrid tr').eq(i).find('td').eq(2).text(), 'UO3_PAGE TENANT_ID', '', i - 1);
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, stripCurrency($('#tblUO3TenantGrid tr').eq(i).find('td').eq(3).text()), 'UO3_PAGE AMOUNT', '', i - 1);

            }  	//for
        } 	//PopulateUO3XML
        function ispXmlAddBlankRecsUO(oXML, sElement, iRecNos) {

            sElement = parent.$x.removeRoot(oXML, sElement);

            if (sElement == '') {
                return;
            }

            var olXML, iLength, i;

            olXML = parent.$x.ispXmlGetRecordXml(oXML, sElement, 0);
            iLength = parent.$x.ispXmlGetRecCount(oXML, sElement);

            for (i = 0; i <= iRecNos; i++) {
                //oXML.documentElement.selectNodes("//*/" + sElement).item((iLength + i) //-1).parentNode.appendChild(olXML.documentElement.cloneNode(true));

                $(oXML.xml).find(sElement).eq((iLength + i) - 1).parent().append(olXML);

            }
        }
        function UO3LockEditDeleteButtons(bLock) {
            for (var i = 0; i < tblUO3TenantGrid.rows.length; i++) {
                if (tblUO3TenantGrid.rows[i].id != '') {
                    var sSuffixID = tblUO3TenantGrid.rows[i].id.replace('ROW', '');
                    if (bLock == true) {
                        $('DEL' + sSuffixID).attr("disabled", "disabled");
                        $('EDIT' + sSuffixID).attr("disabled", "disabled");
                    }
                    else {
                        $('DEL' + sSuffixID).removeAttr("disabled");
                        $('EDIT' + sSuffixID).removeAttr("disabled");
                    }
                } 	//if		
            } 	//for
        } 	//UO3LockEditDeleteButtons
    </script>
    <title></title>
</head>
<body onload="DisplayUOReturn()">
    <div style="display: block; visibility: visible" id="divUO" name="divUO">
        <div id="divUOHeader">
            <table class="tblShowBorder" width="90%" bgcolor="whitesmoke" style="margin-left: 4%"
                border="0" cellspacing="0" cellpadding="0" id="tblHeader">
                <tr>
                    <td width="2%">
                    </td>
                    <td width="8%">
                    </td>
                    <td width="5%">
                    </td>
                    <td width="5%">
                    </td>
                    <td width="5%">
                    </td>
                    <td width="5%">
                    </td>
                    <td width="5%">
                    </td>
                    <td width="5%">
                    </td>
                    <td width="5%">
                    </td>
                    <td width="5%">
                    </td>
                    <td width="5%">
                    </td>
                    <td width="5%">
                    </td>
                    <td width="5%">
                    </td>
                    <td width="5%">
                    </td>
                    <td width="5%">
                    </td>
                    <td width="5%">
                    </td>
                    <td width="5%">
                    </td>
                    <td width="5%">
                    </td>
                    <td width="5%">
                    </td>
                    <td width="5%">
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td colspan="1" align="right">
                        <label class="lblInstrNormal">
                            Name:&nbsp;</label>
                    </td>
                    <td colspan="11" align="left">
                        <label id="lblName" class="lblTextBlack">
                        </label>
                    </td>
                    <td colspan="3" align="right">
                        <label id="lblAccountType" class="lblInstrNormal">
                            Account No.:&nbsp;</label>
                    </td>
                    <td colspan="4">
                        <label id="lblAccountId" class="lblTextBlack">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td colspan="1" align="right">
                        <label class="lblInstrNormal">
                            Address:&nbsp;</label>
                    </td>
                    <td colspan="11" align="left">
                        <label id="lblAddress" class="lblTextBlack">
                        </label>
                    </td>
                    <td colspan="3" align="right">
                        <label id="lblEntityType" class="lblInstrNormal">
                            EIN:&nbsp;</label>
                    </td>
                    <td colspan="4">
                        <label id="lblEntityId" class="lblTextBlack">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td colspan="20">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="3" align="right">
                        <label class="lblInstrNormal">
                            Property Address:&nbsp;</label>
                    </td>
                    <td colspan="10">
                        <label id="lblPropertyAddress" class="lblTextBlack">
                        </label>
                    </td>
                    <td colspan="3" align="right">
                        <label class="lblInstrNormal">
                            Property Account No.:&nbsp;</label>
                    </td>
                    <td colspan="4">
                        <label id="lblPropertyNumber" class="lblTextBlack">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td colspan="10" align="right">
                        <label class="lblInstrNormal">
                            Tax Period Covering:&nbsp;</label>
                    </td>
                    <td colspan="2">
                        <label id="lblTaxPeriod" class="lblTextBlack">
                        </label>
                    </td>
                    <td colspan="4" align="right">
                        <label class="lblInstrNormal">
                            Tax Period/Year Code:&nbsp;</label>
                    </td>
                    <td colspan="4">
                        <label id="lblPeriod_Code" class="lblTextBlack">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td colspan="10" align="right">
                        <label class="lblInstrNormal">
                            Assessed Value:&nbsp;</label>
                    </td>
                    <td colspan="2">
                        <label id="lblAccessedValue" class="lblTextBlack">
                        </label>
                    </td>
                    <td colspan="4" align="right" class="lblInstrNormal">
                        <label class="lblInstrNormal">
                            Due Date:&nbsp;</label>
                    </td>
                    <td colspan="4">
                        <label id="lblDueDate" class="lblTextBlack">
                        </label>
                    </td>
                </tr>
            </table>
        </div>
        <table style="left: 43px; margin-left: 4%; top: 205px" border="0" width="90%">
            <tr>
                <td width="5%">
                </td>
                <td width="5%">
                </td>
                <td width="5%">
                </td>
                <td width="5%">
                </td>
                <td width="5%">
                </td>
                <td width="5%">
                </td>
                <td width="5%">
                </td>
                <td width="5%">
                </td>
                <td width="5%">
                </td>
                <td width="5%">
                </td>
                <td width="5%">
                </td>
                <td width="5%">
                </td>
                <td width="5%">
                </td>
                <td width="5%">
                </td>
                <td width="5%">
                </td>
                <td width="5%">
                </td>
                <td width="5%">
                </td>
                <td width="5%">
                </td>
                <td width="5%">
                </td>
                <td width="5%">
                </td>
            </tr>
            <tr>
                <td align="left" colspan="12" nowrap>
                    <input id="chkAmended" type="checkbox" onclick="chkAmended_onclick()" />
                    <label class="lblTextBlacksmall">
                        Check if amended return.</label>
                </td>
            </tr>
        </table>
        <div style="display: block; visibility: visible" id="divUO1_pg1">
            <table class="tblShowBorder" cellspacing="0" cellpadding="0" border="0" style="margin-left: 4%"
                id="tblBody" width="90%">
                <tr height="0">
                    <td width="5%">
                    </td>
                    <td width="5%">
                    </td>
                    <td width="5%">
                    </td>
                    <td width="5%">
                    </td>
                    <td width="5%">
                    </td>
                    <td width="5%">
                    </td>
                    <td width="5%">
                    </td>
                    <td width="5%">
                    </td>
                    <td width="5%">
                    </td>
                    <td width="5%">
                    </td>
                    <td width="5%">
                    </td>
                    <td width="5%">
                    </td>
                    <td width="5%">
                    </td>
                    <td width="5%">
                    </td>
                    <td width="5%">
                    </td>
                    <td width="5%">
                    </td>
                    <td width="5%">
                    </td>
                    <td width="5%">
                    </td>
                    <td width="5%">
                    </td>
                    <td width="5%">
                    </td>
                </tr>
                <tr class="rowDataEven">
                    <td>
                        <label class="lblInstrNormal">
                            1.</label>
                    </td>
                    <td colspan="16">
                        <label class="lblInstrNormal">
                            Maximum Tax for Period</label>
                    </td>
                    <td colspan="3">
                        <label class="inpReadOnlyRt" id="lblUO1_1" style="width: 100%">
                        </label>
                    </td>
                </tr>
                <tr class="rowDataOdd">
                    <td>
                        <label class="lblInstrNormal">
                            2.</label>
                    </td>
                    <td colspan="16">
                        <label class="lblInstrNormal">
                            Vacant Amount</label>
                    </td>
                    <td colspan="3">
                        <input class="inpNormal" id="txtUO1_2" onchange="ValidateUOReturn()" onfocus="SetFocus()"
                            maxlength="10" style="width: 100%" />
                    </td>
                </tr>
                <tr class="rowDataEven">
                    <td>
                        <label class="lblInstrNormal">
                            3.</label>
                    </td>
                    <td colspan="16">
                        <label class="lblInstrNormal">
                            Non-taxable exempt Amount</label>
                    </td>
                    <td colspan="3">
                        <input class="inpNormal" id="txtUO1_3" onchange="ValidateUOReturn()" onfocus="SetFocus()"
                            maxlength="10" style="width: 100%" />
                    </td>
                </tr>
                <tr class="rowDataOdd">
                    <td>
                        <label class="lblInstrNormal">
                            4.</label>
                    </td>
                    <td colspan="16">
                        <label class="lblInstrNormal">
                            Non-taxable residential Amount</label>
                    </td>
                    <td colspan="3">
                        <input class="inpNormal" id="txtUO1_4" onchange="ValidateUOReturn()" onfocus="SetFocus()"
                            maxlength="10" style="width: 100%" />
                    </td>
                </tr>
                <tr class="rowDataEven">
                    <td>
                        <label class="lblInstrNormal">
                            5.</label>
                    </td>
                    <td colspan="16">
                        <label class="lblInstrNormal">
                            Keystone Opportunity Zone (KOZ) Amount</label>
                    </td>
                    <td colspan="3">
                        <input class="inpNormal" id="txtUO1_5" onchange="ValidateUOReturn()" onfocus="SetFocus()"
                            maxlength="10" style="width: 100%" />
                    </td>
                </tr>
                <tr class="rowDataOdd">
                    <td style="vertical-align: top">
                        <label class="lblInstrNormal">
                            6.</label>
                    </td>
                    <td colspan="16">
                        <label class="lblInstrNormal">
                            <b>Total of Lines 2, 3, 4, 5 </b>
                        </label>
                    </td>
                    <td colspan="3">
                        <label class="inpReadOnlyRt" id="lblUO1_6" style="width: 100%">
                        </label>
                    </td>
                </tr>
                <tr class="rowDataEven">
                    <td>
                        <label class="lblInstrNormal">
                            7.</label>
                    </td>
                    <td colspan="8">
                        <label class="lblInstrNormal">
                            Tax Due</label>
                    </td>
                    <td colspan="8" align="right">
                        <label class="lblInstrNormal">
                            [Calculated - Line 1 minus Line 6]&nbsp;</label>
                    </td>
                    <td colspan="3">
                        <label class="inpReadOnlyRt" id="lblUO1_7" style="width: 100%">
                        </label>
                    </td>
                </tr>
                <tr class="rowDataOdd">
                    <td>
                        <label class="lblInstrNormal">
                            8.</label>
                    </td>
                    <td colspan="10">
                        <label class="lblInstrNormal">
                            $2,000.00 Annual Exemption ($167 per month or $500 per quarter)</label>
                    </td>
                    <td colspan="6" align="right">
                    </td>
                    <td colspan="3">
                        <label class="inpReadOnlyRt" id="lblUO1_8" style="width: 100%">
                        </label>
                    </td>
                </tr>
                <tr class="rowDataEven">
                    <td>
                        <label class="lblInstrNormal">
                            9.</label>
                    </td>
                    <td colspan="16">
                        <label class="lblInstrNormal">
                            Delinquent Tenant Amount</label>
                        <label class="lblLink" style="font-size: 7pt" onclick="ShowPage(2)">
                            (Click here to complete UO3)</label>
                    </td>
                    <td colspan="3">
                        <input class="inpNormal" id="txtUO1_9" onchange="ValidateUOReturn()" onfocus="SetFocus()"
                            maxlength="10" style="width: 100%" />
                    </td>
                </tr>
                <tr class="rowDataOdd">
                    <td>
                        <label class="lblInstrNormal">
                            10.</label>
                    </td>
                    <td colspan="6">
                        <label class="lblInstrNormal">
                            Amount due prior to discount.</label>
                    </td>
                    <td colspan="10" align="right">
                        <label class="lblInstrNormal">
                            [Calculated - Add Lines 8 and 9 then subtract the sum from Line 7]&nbsp;</label>
                    </td>
                    <td colspan="3">
                        <label class="inpReadOnlyRt" id="lblUO1_10" style="width: 100%">
                        </label>
                    </td>
                </tr>
                <tr class="rowDataEven">
                    <td>
                        <label class="lblInstrNormal">
                            11.</label>
                    </td>
                    <td colspan="8">
                        <label class="lblInstrNormal">
                            Discount for Landlords <u>ONLY</u></label>
                    </td>
                    <td colspan="8" align="right">
                        <label class="lblInstrNormal">
                            [Calculated - Line 10 multiply by 1%]&nbsp;</label>
                    </td>
                    <td colspan="3">
                        <!--			<label class=inpReadOnlyRt id=lblUO1_9 style="WIDTH: 100%"></label></td>-->
                       
							 <!--<label class="inpReadOnlyRt" id="lblUO1_11" style="width: 100%">-->
							 <input class=inpNormal id="txtUO1_11" onchange="ValidateUOReturn()" onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%" />
                    </td>
                </tr>
                <tr class="rowDataOdd">
                    <td>
                        <label class="lblInstrNormal">
                            12.</label>
                    </td>
                    <td colspan="8">
                        <label class="lblInstrNormal">
                            <b>Net tax Due</b></label>
                    </td>
                    <td colspan="8" align="right">
                        <label class="lblInstrNormal">
                            [Calculated - line 10 minus 11]&nbsp;</label>
                    </td>
                    <td colspan="3">
                        <label class="inpReadOnlyRt" id="lblUO1_12" style="width: 100%">
                        </label>
                    </td>
                </tr>
                <tr class="rowDataEven">
                    <td valign="top">
                        <label class="lblInstrNormal">
                            13.</label>
                    </td>
                    <td colspan="16">
                        <label class="lblInstrNormal">
                            Interest & Penalty(See Instructions)</label>
                    </td>
                    <td colspan="3" valign="bottom">
                        <input class="inpNormal" id="txtUO1_13" onchange="ValidateUOReturn()" onfocus="SetFocus()"
                            maxlength="10" style="width: 100%">
                    </td>
                </tr>
                <tr class="rowDataOdd">
                    <td>
                        <label class="lblInstrNormal">
                            14.</label>
                    </td>
                    <td colspan="8">
                        <label class="lblInstrNormal">
                            <b>Total Due</b></label>
                    </td>
                    <td colspan="8" align="right">
                        <label class="lblInstrNormal">
                            [Calculated - line 12 plus 13]&nbsp;</label>
                    </td>
                    <td colspan="3">
                        <label class="inpReadOnlyRt" id="lblUO1_14" style="width: 100%">
                        </label>
                    </td>
                </tr>
            </table>
            <table style="margin-left: 4%" border="0" width="90%">
                <tr>
                    <td width="80%">
                      
                         <% Html.RenderAction("PreparerSection", "Inc"); %>
                    </td>
                    <td valign="bottom" align="right">
                        <p style="margin-bottom: 10px">
                            <input id="btnUOPrint" type="button" value="Print" language="javascript" onclick="return btnUOPrint_onclick()" />&nbsp;&nbsp;
                            <input id="btnUOSubmit" type="button" value="Submit" language="javascript" onclick="return btnUOSubmit_onclick()" />&nbsp;&nbsp;</p>
                    </td>
                </tr>
            </table>
        </div>
        <!-- UO3 Form -->
        <div style="display: none" id="divUO3_pg2">
            <table id="tblUO3" border="0" cellspacing="0" cellpadding="0" width="95%" style="margin-top: 10px;
                margin-left: 4%">
                <tr>
                    <td width="50%">
                        <table class="tblShowBorder" bgcolor="whitesmoke" cellspacing="0" cellpadding="0"
                            width="95%" border="0" id="tblTenant">
                            <tr style="height: 5px">
                                <td width="40px">
                                    <input id="txtUO3RowId" type="hidden" />
                                </td>
                                <td width="5px">
                                </td>
                                <td width="400px">
                                </td>
                            </tr>
                            <tr>
                                <td align="left" class="lblInstrNormal">
                                    &nbsp;Tenant Name:&nbsp;
                                </td>
                                <td valign="middle" class="lblInstrRequired">
                                    *
                                </td>
                                <td align="left">
                                    <input class="inpNormal" id="txtUO3_TenantName" maxlength="60" size="70" onchange="ValidateUO3Return()" />
                                </td>
                            </tr>
                            <tr>
                                <td align="left" class="lblInstrNormal">
                                    &nbsp;U&O Acct. Number:&nbsp;
                                </td>
                                <td valign="middle" class="lblInstrRequired">
                                </td>
                                <td align="left">
                                    <input class="inpNormal" id="txtUO3_UOAccountNumber" maxlength="20" size="9" onchange="ValidateUO3Return()" />
                                </td>
                            </tr>
                            <tr>
                                <td align="left" class="lblInstrNormal">
                                    &nbsp;EIN/SSN:&nbsp;
                                </td>
                                <td valign="middle" class="lblInstrRequired">
                                    *
                                </td>
                                <td align="left">
                                    <select id="ddUO3_EinSsn" style="width: 112px">
                                        <option></option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" class="lblInstrNormal">
                                    &nbsp;EIN/Social Security Number:&nbsp;
                                </td>
                                <td valign="middle" class="lblInstrRequired">
                                    *
                                </td>
                                <td align="left">
                                    <input class='inpNormal' id="txtUO3_EinSsn" size="20" onchange="ValidateUO3Return()"
                                        maxlength="9" />
                                </td>
                            </tr>
                            <tr>
                                <td align="left" class="lblInstrNormal">
                                    &nbsp;Amount of Unpaid Tax:&nbsp;
                                </td>
                                <td valign="middle" class="lblInstrRequired">
                                    *
                                </td>
                                <td align="left">
                                    <input class='inpNormal' id="txtUO3_UnpaidTax" maxlength="6" size="20" onchange="ValidateUO3Return()" />
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="25%" valign="bottom">
                        <table style="margin-left: 20px">
                            <tr>
                                <td align="center" height="20">
                                    &nbsp;&nbsp;<input id="btnUO3_Add" type="button" style="width: 70px" value="Add"
                                        onclick="UO3UpdateTenantList()" />
                                </td>
                            </tr>
                            <tr>
                                <td align="center" height="20">
                                    &nbsp;&nbsp;
                                    <input id="btnUO3_Cancel" type="button" style="width: 70px" value="Cancel" onclick="UO3ClearTenantFrame()" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <label id="lblMoreThen10" class="lblInstrNormal" style="display: block; color: Red">
                            NOTE: If you are reporting more then 10 delinquent tenants you must file a paper
                            return.</label>
                    </td>
                </tr>
            </table>
            <div id="divUO3Grid" style="display: block; margin-left: 4%">
                <br />
                <table id="tblUO3TenantGrid" class="tblShowBorder1" bgcolor="whitesmoke" cellspacing="0"
                    cellpadding="0" width="90%" border="0">
                    <tr class="rowHeader">
                        <td align="center" class="celLeft1" style="width: 30%">
                            Tenant Name
                        </td>
                        <td align="center" class="celLeft" style="width: 18%">
                            U&O Tax Account Number
                        </td>
                        <td align="center" class="celLeft" style="width: 18%">
                            EIN / Social Security #
                        </td>
                        <td align="center" class="celLeft" style="width: 18%">
                            Amount of Unpaid Tax
                        </td>
                        <td align="center" class="celLeft" style="width: 16%">
                            &nbsp;
                            <!--<input type="button" value="Edit" onclick="" />
					<input type="button" value="Delete" />-->
                        </td>
                    </tr>
                </table>
                <br />
                <input type="button" id="btnUO1Pg1" value="Return to Page 1" onclick="ShowPage(1)" />&nbsp;&nbsp;
                <input type="button" id="btnSelectPg" value="Return to Selection Page" onclick="parent.DocWin.location.href = 'UOList'" />
            </div>
        </div>
    </div>
</body>
</html>
