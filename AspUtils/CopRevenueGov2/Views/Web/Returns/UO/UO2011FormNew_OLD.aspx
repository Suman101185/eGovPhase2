<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
    <script id="clientEventHandlersJS" language="javascript" type="text/javascript">

        var arrUOErr = new Array();
        var arrUO3Err = new Array();
        var txtHeader = 'Taxpayer Information';
        var dUONetRate, dUOGrossRate;
        var sYear = '11';
        var mbFirstTime = false;
        var gUserAddr = '<% Response.Write(Request.ServerVariables["REMOTE_ADDR"]); %>';

        //$(document).ready(function () {
        //    // parent.$g.loadXmlAsync('XML/UOList', parent.$g.parseXml_xmlUOList);
        //    parent.$g.loadXmlAsync('XML/UOForm', parent.$g.parseXml_xmlUOForm);
        //});
        $(document).ready(function () {
            DisplayUOReturn();
        });
        function ReloadXml() {

            //  parent.$g.loadXmlAsync('../../xml/UOFormNew', parent.MenuWin.parseXml_xmlUOFormNew);
            parent.$g.loadXmlAsync('XML/UOForm', parent.$g.parseXml_xmlUOForm);


        }
        function parseCurrency(value) {
            return ispRemoveMoney(value);
        }
        function DisplayUOReturn() {

            ReloadXml();
            // if ($(parent.$g.xmlAccount).find('TAX_ACCT').find("ACCOUNT:contains('84')")) {
            if (parent.GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '84') == 1) { //Chayan



                LoadGenericDD(parent.$g.xmlEntityType, ddUO3_EinSsn, "DDOWN", false);

                // parent.MenuWin.ispHighlightMenu(parent.MenuWin.mnuUO);

                $('#divUO').css("display", "block");
                $('#divUO1_pg1').css("display", "block");
                $('#AppHeaderUOForm').html(txtHeader + '<Font class=hdrMedium>|Business Use & Occupancy Tax Return</Font>');
                parent.gsInstructionItem = ''; 	//'#BptEz'
                $('#AppMessageUOForm').html(parent.gsInstructionText);
                $('#InstructionText').html(' for Instructions on filing this return');


                if (parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'ERROR_INFO ERROR', "", 0) != 0) {

                    $(parent.RightFrame).attr("rows", "*,0");
                    $('#divUO').css("display", "block");

                    PopulateUOHeader();
                    FieldLock(true);
                    $(parent.AppError).text(parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'ERROR_INFO MESSAGE', "", 0));
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

            if (parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO_AMTS MAX_TAX', '', 0) == '') {
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, 0, 'UO_AMTS MAX_TAX', '', 0);
            }

            $(parent.RightFrame).attr("rows", "*,0");

            LoadUOError();
            LoadUO3Error();
            RightAlignText();
            CheckUOXML();

            PopulateUOHeader();

            PopulateUOData();

            PopulateUO3Data();

            SetUOFields();
            $(parent.AppError).text('');

        }//DisplayUOReturn


        function SetUOFields() {
            chkAmended.checked = false;
            $('#chkAmended').removeAttr("checked");

            if (parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO_ACCT VERSION', '', 0) == '') {
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
                $('#lblUO1_1').attr("disabled", "disabled");
                $('#txtUO1_2').attr("disabled", "disabled");
                $('#txtUO1_3').attr("disabled", "disabled");
                $('#txtUO1_4').attr("disabled", "disabled");
                $('#txtUO1_5').attr("disabled", "disabled");
                $('#txtUO1_6').attr("disabled", "disabled");
                $('#txtUO1_7').attr("disabled", "disabled");
                $('#lblUO1_8').attr("disabled", "disabled");//Sangha
                $('#txtUO1_9').attr("disabled", "disabled");
                $('#txtUO1_10').attr("disabled", "disabled");
                $('#txtUO1_11').attr("disabled", "disabled");
                $('#lblUO1_12').attr("disabled", "disabled");

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
                $('#lblUO1_1').removeAttr("disabled");
                $('#txtUO1_2').removeAttr("disabled");
                $('#txtUO1_3').removeAttr("disabled");
                $('#txtUO1_4').removeAttr("disabled");
                $('#txtUO1_5').removeAttr("disabled");
                $('#txtUO1_6').removeAttr("disabled");
                $('#txtUO1_7').removeAttr("disabled");
                $('#lblUO1_8').removeAttr("disabled");//Sangha
                $('#txtUO1_9').removeAttr("disabled");
                $('#txtUO1_10').removeAttr("disabled");
                $('#txtUO1_11').removeAttr("disabled");
                $('#lblUO1_12').removeAttr("disabled");

                $('#btnUOSubmit').removeAttr("disabled");
                DisablePreparer(bDisabled);
                //UO3
                $('#txtUO3_TenantName').removeAttr("disabled");
                $('#ddUO3_EinSsn').removeAttr("disabled");
                $('#txtUO3_EinSsn').removeAttr("disabled");
                $('#txtUO3_UnpaidTax').removeAttr("disabled");
                $('#btnUO3_Add').removeAttr("disabled");


            }
        }//FieldLock


        function CheckUOXML() {
            var bPeriodExist = true;

            if (parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO1_AMTS TOTAL_DUE', '', 0) == '$0') {
                bPeriodExist = false;
            }

            if (bPeriodExist == false) {
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, '', 'ERROR_INFO PROGRAM', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, '', 'ERROR_INFO ERROR', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, '', 'ERROR_INFO LINE', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, '', 'ERROR_INFO MESSAGE', '', 0);

                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, '12/31/2011', 'UO_ACCT PERIOD', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, '', 'UO_ACCT VERSION', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, '', 'UO_ACCT RETURN_STATUS', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, '', 'UO_ACCT LAST_UPD_DATE', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, '', 'UO_ACCT RECORDING_DATE', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, '', 'UO_ACCT EXTENSION_DATE', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, '', 'UO_ACCT SEQUENCE', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, '', 'UO_ACCT ADJUSTMENT_REF_NO', '', 0);
                ClearPreparerXML(parent.$g.oUOForm, 'UO_ACCT');

                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, 0, 'UO_AMTS MAX_TAX', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, 0, 'UO_AMTS GROSS_TAX', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, 0, 'UO_AMTS ACTUAL_TAX', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, 0, 'UO_AMTS ESTIMATED_TAX', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, 0, 'UO_AMTS TOTAL_TAX', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, 0, 'UO_AMTS NPT_TAX_CREDIT', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, 0, 'UO_AMTS BPT_TAX_CREDIT', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, 0, 'UO_AMTS TOTAL_PAY_CREDIT', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, 0, 'UO_AMTS TAX_DUE', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, 0, 'UO_AMTS INTEREST_PENALTY', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, 0, 'UO_AMTS AMOUNT_OWED', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, 0, 'UO_AMTS REFUND', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, 0, 'UO_AMTS NPT_OVERPAY', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, 0, 'UO_AMTS BPT_OVERPAY', '', 0);
            }
        }//CheckUOXML


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

            $('#lblAccountId').text(parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO_ACCT ACCOUNT_ID', '', 0));
            $('#lblPropertyAddress').html(parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO_ACCT LOCATION', '', 0));
            $('#lblPropertyNumber').html(parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO_ACCT BRT_NUMBER', '', 0));
            $('#lblTaxPeriod').html(parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO_ACCT PERIOD', '', 0));

            var lPeriodCode = parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO_ACCT PERIOD_CODE', '', 0);
            if (lPeriodCode.length == 1) {
                lPeriodCode = '0' + lPeriodCode;
            }
            $('#lblPeriod_Code').html(lPeriodCode + '' + parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO_ACCT PERIOD_YY', '', 0));
            $('#lblAccessedValue').html(parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO_ACCT ASSESSED_VALUE', '', 0));
            $('#lblDueDate').html(parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO_ACCT DUE_DATE', '', 0));
        }//PopulateUOHeader


        function PopulateUOData() {
            //Page1
            $('#lblUO1_1').html(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO_AMTS MAX_TAX', '', 0), 0));
            txtUO1_2.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO_AMTS VACANCY', '', 0), 0)
            txtUO1_3.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO_AMTS EXEMPT', '', 0), 0)
            txtUO1_4.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO_AMTS RESIDENTIAL', '', 0), 0)
            txtUO1_5.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO_AMTS DELINQUENT', '', 0), 0)
            txtUO1_6.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO_AMTS KOZ_CREDIT', '', 0), 0)
            $('#lblUO1_7').html(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO_AMTS TOTAL_DEDUCTIONS', '', 0), 0));
            $('#lblUO1_8').html(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO_AMTS PERIOD_TAX', '', 0), 0));
            txtUO1_9.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO_AMTS DISCOUNT', '', 0), 0)
            $('#lblUO1_10').html(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO_AMTS TAX_DUE', '', 0), 0));
            txtUO1_11.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO_AMTS INTEREST_PENALTY', '', 0), 0)
            $('#lblUO1_12').html(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO_AMTS TOTAL_DUE', '', 0), 0));
            PopulatePreparer(parent.$g.oUOForm, 'UO_ACCT');
            //UO3
        }//PopulateUOData

        function PopulateUOXML() {
            var d = new Date();
            var lYear = String(d.getFullYear());
            var lMonth = String(d.getMonth() + 1);
            lMonth = lMonth.length == 1 ? '0' + lMonth : lMonth;
            var lDate = String(d.getDate());
            lDate = lDate.length == 1 ? '0' + lDate : lDate;

            parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, lMonth + '/' + lDate + '/' + lYear, 'UO_ACCT RECORDING_DATE', '', 0);
            //Page1
            parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, stripCurrency($('#lblUO1_1').text()), 'UO_AMTS MAX_TAX', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, stripCurrency(txtUO1_2.value), 'UO_AMTS VACANCY', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, stripCurrency(txtUO1_3.value), 'UO_AMTS EXEMPT', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, stripCurrency(txtUO1_4.value), 'UO_AMTS RESIDENTIAL', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, stripCurrency(txtUO1_5.value), 'UO_AMTS DELINQUENT', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, stripCurrency(txtUO1_6.value), 'UO_AMTS KOZ_CREDIT', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, stripCurrency($('#lblUO1_7').text()), 'UO_AMTS TOTAL_DEDUCTIONS', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, stripCurrency($('#lblUO1_8').text()), 'UO_AMTS PERIOD_TAX', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, stripCurrency(txtUO1_9.value), 'UO_AMTS DISCOUNT', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, stripCurrency($('#lblUO1_10').text()), 'UO_AMTS TAX_DUE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, stripCurrency(txtUO1_11.value), 'UO_AMTS INTEREST_PENALTY', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, stripCurrency($('#lblUO1_12').text()), 'UO_AMTS TOTAL_DUE', '', 0);
            PopulatePreparerXML(parent.$g.oUOForm, 'UO_ACCT');
            //Page2
            PopulateUO3XML();
            parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, '', 'DEBUG', '', 0);
        }//PopulateUOXML

        function RightAlignText() {
            //Page1
            $('#lblUO1_1').parent().css("text-align", "right");
            $('#txtUO1_2').css("text-align", "right");
            $('#txtUO1_3').css("text-align", "right");
            $('#txtUO1_4').css("text-align", "right");
            $('#txtUO1_5').css("text-align", "right");
            $('#txtUO1_6').css("text-align", "right");
            $('#lblUO1_7').parent().css("text-align", "right");
            $('#lblUO1_8').parent().css("text-align", "right");
            $('#txtUO1_9').css("text-align", "right");
            $('#lblUO1_10').parent().css("text-align", "right");
            $('#txtUO1_11').css("text-align", "right");
            $('#lblUO1_12').parent().css("text-align", "right");
        }//RightAlignText


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

            arrUOErr[i++] = [txtUO1_6, 'ispValue(txtUO1_6.value) == false', 'Value for Question 6 must be numeric'];
            arrUOErr[i++] = [txtUO1_6, 'ispNegativeNumber(txtUO1_6.value) == false', 'Value for Question 6 must NOT be negative'];

            arrUOErr[i++] = [txtUO1_11, 'ispValue(txtUO1_11.value) == false', 'Value for Question 11 must be numeric'];
            arrUOErr[i++] = [txtUO1_11, 'ispNegativeNumber(txtUO1_11.value) == false', 'Value for Question 11 must NOT be negative'];
        }//LoadUOError

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
        }//LoadUO3Error

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
        }//btnUOPrint_onclick


        function btnUOSubmit_onclick() {

            $(parent.AppError).text("");
            ValidateUOReturn();

            if ($(parent.AppError).text() == "") {
                $(parent.AppError).text(ValidatePreparer());
            }

            if ($(parent.AppError).text() == "") {
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, '', 'UO_ACCT RETURN_STATUS', '', 0);
                PopulateUOXML();
                //alert('pass');
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, '', 'ERROR_INFO MESSAGE', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, 'UPD', 'UO_ACCT RETURN_STATUS', '', 0);

                var tempXML = parent.$g.getXmlDocObj(); //new ActiveXObject("MSXML.DOMDocument")
                // ispCallXMLForm(parent.$g.oUOForm, parent.$g.oUOForm, "UOFormCall.asp", "");
                ispCallXMLForm(parent.$g.oUOForm, tempXML, "UO/UOFormCall", "");


                //if (parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'ERROR_INFO PROGRAM', '', 0) == '') {
                if (parent.$x.ispXmlGetFieldVal(tempXML, 'ERROR_INFO PROGRAM', '', 0) == '') {
                    parent.$g.oUOForm.loadXML(tempXML.xml);

                    $("#divUO").css("display", "none");
                    UOThankYouDisplay();
                } else {
                    $(parent.AppError).text(parent.$x.ispXmlGetFieldVal(tempXML, 'ERROR_INFO MESSAGE', '', 0));
                }
            }
        }//btnUOSubmit_onclick


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
        }//ShowPage


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
                }		//if
            } else {
                UO3ClearTenantFrame();
                UO3RemoveRows();
                PopulateUOData();

                $("#btnUOSubmit").attr("disabled", "disabled");
                FieldLock(true);
                PopulatePreparer(parent.$g.oUOForm, 'UO_ACCT');
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
                return element == document.activeElement;
            }
        });
        */
        function SetFocus() {
            document.activeElement.select();
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
                if (ObjSelected != null) {
                    if (ObjSelected.id != 'txtUO3_TenantName' && ObjSelected.id != 'btnUOSubmit') {

                        ObjSelected.value = ispFormatMoney(ObjSelected.value, 0);
                    }
                }


                $('#lblUO1_7').html(ispFormatMoney(parseCurrency(txtUO1_2.value.replace(',', '').replace('$', '')) + parseCurrency(txtUO1_3.value.replace(',', '').replace('$', '')) + parseCurrency(txtUO1_4.value.replace(',', '').replace('$', '')) + parseCurrency(txtUO1_5.value.replace(',', '').replace('$', '')) + parseCurrency(txtUO1_6.value.replace(',', '').replace('$', '')), 0));

                if (parseCurrency($('#lblUO1_7').html().replace(',', '').replace('$', '')) > parseCurrency($('#lblUO1_1').html().replace(',', '').replace('$', ''))) {
                    $(parent.AppError).text("Line 7 can not be greater than Line 1");
                }



                $('#lblUO1_8').html(parseCurrency($('#lblUO1_1').html().replace(',', '').replace('$', '')) - parseCurrency($('#lblUO1_7').html().replace(',', '').replace('$', '')));
                if (parseCurrency($('#lblUO1_8').html().replace(',', '').replace('$', '')) < 0) {
                    $('#lblUO1_8').html(ispFormatMoney(0, 0));
                }
                else {
                    $('#lblUO1_8').html(ispFormatMoney($('#lblUO1_8').html(), 0));
                }

                var disC = parseCurrency($('#lblUO1_8').html()) * .01;
                var enteredAmt = parseCurrency($('#txtUO1_9').val());

                if (enteredAmt > disC) {

                    if (sId != null) {
                        if (sId == "txtUO1_9" || sId == "btnUOSubmit") {
                            if (confirm("Discount (Line 9) can not be greater than 1% of pre- discount amount (Line 8)")) {
                                $('#txtUO1_9').val(ispFormatMoney(0, 0));

                            }
                            else {
                                $(parent.AppError).text("Discount (Line 9) can not be greater than 1% of pre- discount amount (Line 8)");
                            }
                        }


                    }
                }


                $('#lblUO1_10').html(ispFormatMoney(parseCurrency($('#lblUO1_8').html().replace(',', '').replace('$', '')) - parseCurrency(txtUO1_9.value.replace(',', '').replace('$', '')), 0));
                $('#lblUO1_12').html(ispFormatMoney(parseCurrency($('#lblUO1_10').html().replace(',', '').replace('$', '')) + parseCurrency(txtUO1_11.value.replace(',', '').replace('$', '')), 0));
            }
        }//ValidateUOReturn
        function ValidateUO3Return() {
            //var sId = $(":").attr("id");
            //var ObjSelected;

            $(parent.AppError).text(ispSetInputErr(arrUO3Err));
            if ($(parent.AppError).text() == "") {
                $("#btnUO3_Add").attr("disabled", false);
            } else {
                $("#btnUO3_Add").attr("disabled", true);
            }
        }//ValidateUO3Return

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
        }//UO3ClearTenantFrame

        function UO3UpdateTenantList() { //CHayan
            if ($("#btnUO3_Add").val().toUpperCase() == 'ADD') {
                UO3AddRow(false);
            } else {
                $(parent.AppError).text(ispSetInputErr(arrUO3Err));
                if ($(parent.AppError).text() != "") {
                    return;
                }
                UO3LockEditDeleteButtons(false);
                /*document.getElementById(txtUO3RowId.value).cells[0].innerText = txtUO3_TenantName.value;
                document.getElementById(txtUO3RowId.value).cells[1].innerText = txtUO3_UOAccountNumber.value;
                document.getElementById(txtUO3RowId.value).cells[2].innerText = txtUO3_EinSsn.value;
                document.getElementById(txtUO3RowId.value).cells[3].innerText = ispFormatMoney(txtUO3_UnpaidTax.value, 0);
                */

                $('#' + txtUO3RowId.value).find('td').eq(0).text(txtUO3_TenantName.value);
                $('#' + txtUO3RowId.value).find('td').eq(1).text(txtUO3_UOAccountNumber.value);
                $('#' + txtUO3RowId.value).find('td').eq(2).text(txtUO3_EinSsn.value);
                $('#' + txtUO3RowId.value).find('td').eq(3).text(ispFormatMoney(txtUO3_UnpaidTax.value, 0));

                txtUO3RowId.value = '';
            }		//if
            if ($(parent.AppError).text() == '') {
                UO3ClearTenantFrame();

            }		//if
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
                }		//if
            } 	//if

            var row = tblUO3TenantGrid.insertRow(1);

            lDate = new Date();
            if (isExisting == false) {
                row.id = 'ROW' + lDate.getSeconds() + '' + lDate.getMilliseconds();
                $(row).attr("id", "ROW" + lDate.getSeconds() + "" + lDate.getMilliseconds());
            }		//if
            if (tblUO3TenantGrid.rows.length % 2 == 0) {
                //row.className = 'rowDataEven';
                $(row).addClass('rowDataEven');
            } else {
                //row.className = 'rowDataOdd';
                $(row).addClass('rowDataOdd');
            } 	//if
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            var cell5 = row.insertCell(4);

            /*cell1.innerText = txtUO3_TenantName.value;
            cell1.style.marginLeft = '5'
            */
            $(cell1).text(txtUO3_TenantName.value);
            /*cell2.className = 'celLeft'
            cell2.style.marginLeft = '5px'
            if (txtUO3_UOAccountNumber.value != '') {
                cell2.innerText = txtUO3_UOAccountNumber.value
            } else {
                cell2.innerHTML = '&nbsp;'
            }		//if
            */

            $(cell2).addClass('celLeft');
            $(cell2).css("marginLeft", "5px");
            if (txtUO3_UOAccountNumber.value != '') {
                $(cell2).text(txtUO3_UOAccountNumber.value);
            } else {
                $(cell2).html('&nbsp;');
            }

            /*cell3.className = 'celLeft'
            cell3.style.marginLeft = '5px'
            cell3.innerText = txtUO3_EinSsn.value
            */
            $(cell3).addClass('celLeft');
            $(cell3).css("marginLeft", "5px");
            $(cell3).text(txtUO3_EinSsn.value);

            /*cell4.className = 'celLeft'
            cell4.align = 'right'
            cell4.style.marginLeft = '5px'
            cell4.innerText = ispFormatMoney(txtUO3_UnpaidTax.value, 0)*/
            $(cell4).addClass('celLeft');
            $(cell4).attr("align", "right");
            $(cell4).css("marginLeft", "5px");
            $(cell4).text(ispFormatMoney(txtUO3_UnpaidTax.value, 0));

            /*cell5.className = 'celLeft'
            cell5.align = 'center'
            if (isExisting == false) {
                cell5.innerHTML = '<input id="EDIT' + lDate.getSeconds() + '' + lDate.getMilliseconds() + '" type="button" value="Edit" style="margin-right:10px" class=btnSmall onclick="UO3EditTenant(this)" /><input id="DEL' + lDate.getSeconds() + '' + lDate.getMilliseconds() + '" type="button" value="Delete" class=btnSmall onclick="UO3DeleteTenant(this)"/>'
            } else
            {
                cell5.innerHTML = '&nbsp;'
            }		//if
            */

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

            /*	txtUO3_TenantName.value = $(document.getElementById(RowId).cells(0)).innerText
                txtUO3_UOAccountNumber.value = document.getElementById(RowId).cells(1).innerText
                txtUO3_EinSsn.value = document.getElementById(RowId).cells(2).innerText
                txtUO3_UnpaidTax.value = document.getElementById(RowId).cells(3).innerText*/

            txtUO3_TenantName.value = $('#' + RowId).find('td').eq(0).text();
            txtUO3_UOAccountNumber.value = $('#' + RowId).find('td').eq(1).text();
            txtUO3_EinSsn.value = $('#' + RowId).find('td').eq(2).text();
            txtUO3_UnpaidTax.value = $('#' + RowId).find('td').eq(3).text();
            btnUO3_Add.value = 'Update';
            txtUO3_TenantName.select();

        }		//UO3EditTenant

        function UO3DeleteTenant(caller) {
            var RowId = 'ROW' + caller.id.replace('DEL', '')
            //alert($('#' + RowId).rowIndex);
            $('#' + RowId).remove();
            //tblUO3TenantGrid.deleteRow(document.getElementById[RowId].rowIndex)
            for (var i = 1; i < tblUO3TenantGrid.rows.length; i++) {
                if (i % 2 == 0) {
                    //tblUO3TenantGrid.rows[i].className = 'rowDataEven'
                    $('#tblUO3TenantGrid').find('tr').eq(i).addClass("rowDataEven");
                } else {
                    //tblUO3TenantGrid.rows[i].className = 'rowDataOdd'
                    $('#tblUO3TenantGrid').find('tr').eq(i).addClass("rowDataOdd");
                } 	//if
            } 		//for
        }		//UO3DeleteTenant

        function UO3RemoveRows() {
            //	alert('UO3RemoveRows' + tblUO3TenantGrid.rows.length);
            for (var i = tblUO3TenantGrid.rows.length - 1; i > 0; i--) {


                /*if (tblUO3TenantGrid.rows[i].id != "") {
                    tblUO3TenantGrid.deleteRow[i];
                    alert('removed');
        
                }		//if
        */
                //alert($('#tblUO3TenantGrid').find('tr').eq(i).attr('id'));
                if ($('#tblUO3TenantGrid').find('tr').eq(i).attr('id') != '') {
                    $('#tblUO3TenantGrid').find('tr').eq(i).remove();
                    //alert('removed');

                }

            }		//for
        } 	//UO3RemoveRows

        function UO3PopulateUO1Line5() { // 
            var iTotalUnpaidTax = 0;
            if ($('#txtUO3_TenantName').attr("disabled") != "disabled") {
                for (var i = 1; i < tblUO3TenantGrid.rows.length; i++) {
                    //iTotalUnpaidTax = parseCurrency(iTotalUnpaidTax) + parseCurrency(stripCurrency(tblUO3TenantGrid.rows[i].cells[3].innerText).replace('$', ''));
                    var unpaid = $('#tblUO3TenantGrid tr').eq(i).find('td').eq(3).text();

                    iTotalUnpaidTax = parseCurrency(iTotalUnpaidTax) + parseCurrency(stripCurrency(unpaid).replace('$', ''));

                } 	//for
                //alert(iTotalUnpaidTax);
                txtUO1_5.value = ispFormatMoney(iTotalUnpaidTax, 0);


            }		//if
        } 	//UO3PopulateUO1Line5()

        function PopulateUO3Data() {
            var iRecCount = parent.$x.ispXmlGetRecCount(parent.$g.oUOForm, 'UO3_PAGE', '');
            if (iRecCount > 0 && parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO3_PAGE PROCESS_CODE', '', '0') != '') {
                for (var i = 0; i < iRecCount; i++) {
                    txtUO3_TenantName.value = parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO3_PAGE TENANT_NAME', '', i);
                    txtUO3_UOAccountNumber.value = parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO3_PAGE ACCOUNT_ID', '', i);
                    txtUO3_EinSsn.value = parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO3_PAGE TENANT_ID', '', i);
                    txtUO3_UnpaidTax.value = parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO3_PAGE AMOUNT', '', i);
                    UO3AddRow(true)
                    UO3ClearTenantFrame()
                } 		//for
            }		//if
        } 	//PopulateUO3Data()

        function PopulateUO3XML() {
            var iRecCount = parent.$x.ispXmlGetRecCount(parent.$g.oUOForm, 'UO3_PAGE', '');

            if (tblUO3TenantGrid.rows.length - 1 != iRecCount) {
                parent.$x.ispXmlAddBlankRecs(parent.$g.oUOForm, 'UO3_PAGE', tblUO3TenantGrid.rows.length - 1 - iRecCount);

            }		//if
            for (var i = 1; i < tblUO3TenantGrid.rows.length; i++) {
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, '', 'UO3_PAGE PROCESS_CODE', '', i - 1);
                /*parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, tblUO3TenantGrid.rows[i].cells[0].innerText, 'UO3_PAGE TENANT_NAME', '', i-1)
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, tblUO3TenantGrid.rows[i].cells[1].innerText, 'UO3_PAGE ACCOUNT_ID', '', i-1)
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, tblUO3TenantGrid.rows[i].cells[2].innerText, 'UO3_PAGE TENANT_ID', '', i-1)
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, stripCurrency(tblUO3TenantGrid.rows[i].cells(3).innerText), 'UO3_PAGE AMOUNT', '', i-1)
                */

                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, $('#tblUO3TenantGrid tr').eq(i).find('td').eq(0).text(), 'UO3_PAGE TENANT_NAME', '', i - 1);
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, $('#tblUO3TenantGrid tr').eq(i).find('td').eq(1).text(), 'UO3_PAGE ACCOUNT_ID', '', i - 1);
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, $('#tblUO3TenantGrid tr').eq(i).find('td').eq(2).text(), 'UO3_PAGE TENANT_ID', '', i - 1);
                parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, stripCurrency($('#tblUO3TenantGrid tr').eq(i).find('td').eq(0).text()), 'UO3_PAGE AMOUNT', '', i - 1);

            }  	//for
        } 	//PopulateUO3XML

        function UO3LockEditDeleteButtons(bLock) {
            for (var i = 0; i < tblUO3TenantGrid.rows.length; i++) {
                if (tblUO3TenantGrid.rows[i].id != '') {
                    //var RowId = 'ROW' + caller.id.replace('DEL', '')
                    var sSuffixID = tblUO3TenantGrid.rows[i].id.replace('ROW', '');
                    /*eval('DEL' + sSuffixID).disabled = bLock
                    eval('EDIT' + sSuffixID).disabled = bLock*/

                    if (bLock == true) {
                        $('DEL' + sSuffixID).attr("disabled", "disabled");
                        $('EDIT' + sSuffixID).attr("disabled", "disabled");
                    }
                    else {
                        $('DEL' + sSuffixID).removeAttr("disabled");
                        $('EDIT' + sSuffixID).removeAttr("disabled");
                    }
                }		//if		
            }		//for
        } 	//UO3LockEditDeleteButtons
</script>
    <title></title>
</head>
    <body>
<%--<body onload="DisplayUOReturn()">--%>
    <div class="tab_Tcontainer" id="divUO" >
        <div class="tab_container">
            <div style="display: block;" id="tab1" class="tab_content">
               <h2 id="AppHeaderUOForm"> </h2>

                <div class="thankyou">
                    <h4 id="AppMessageUOForm">&nbsp;</h4>

                    <div class="school_form">


                        <div class="school_page_form">

                         

                            <div class="account_greybox">
                                 <p><strong>Name:</strong>  <label id="lblName" class="">
                        </label> </p>
                                 <p><strong>Account No.:</strong> <label id="lblAccountId" class="">
                        </label></p>
                                 <div class="clear"></div>
                               
                               
                                <p><strong>Address :</strong> <label id="lblAddress" class="">
                        </label> </p>
                                 <p><strong> <label id="lblEntityType" class="">
                            EIN:&nbsp;</label></strong> <label id="lblEntityId" class="">
                        </label> </p>
                                <div class="clear"></div>

                                <p><strong>Property Address:</strong> <label id="lblPropertyAddress" class="">
                        </label> </p>
                                <p><strong>Property Account No.:</strong> <label id="lblPropertyNumber" class="">
                        </label> </p>
                                 <div class="clear"></div>
                                
                               
                                 <p><strong>Tax Period Covering:</strong> <label id="lblTaxPeriod" class="">
                        </label> </p>
                                 <p><strong>Tax Period/Year Code:</strong> <label id="lblPeriod_Code" class="">
                        </label> </p>
                                  <div class="clear"></div>
                                 <p><strong>Assessed Value:</strong> <label id="lblAccessedValue" class="">
                        </label> </p>
                                 <p><strong> Due Date:</strong> <label id="lblDueDate" class="">
                        </label> </p>
                            </div>


                            <div class="form_segment">


                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabularform">
                                    <tr>
                                        <th width="24%" scope="col" valign="middle" align="left" class="here_input_table">
                                            <input id=chkAmended type=checkbox onclick="chkAmended_onclick()" type="checkbox" />
                                            Check if amended return. </th>
                                        <th colspan=15 >
			</th>
                                        </tr>
                                   
                                </table>


                            </div>

                            <div id="divUO1_pg1">
                            <div class="form_segment">

                                <table summary="Employee Pay Sheet" class="hor-zebra">

                                    <tbody>

                                        <tr class="odd">
                                            <td width="70%">1. Maximum Tax for Period</td>
                                            <td align="center" class="no_border_right">
                                                <label class="label_NoLeft" id="lblUO1_1" style="width: 100%"></label>
                                               </td>
                                        </tr>
                                        <tr>
                                            <td>2.   Vacant Amount</td>
                                            <td align="center" class="no_border_right">
                                                <input class="inpNormal" id="txtUO1_2" onchange="ValidateUOReturn()" onfocus="SetFocus()"
                            maxlength="10" style="width: 100%" /></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">3.  Non-taxable exempt Amount </td>
                                            <td align="center" class="no_border_right">
                                              <input class="inpNormal" id="txtUO1_3" onchange="ValidateUOReturn()" onfocus="SetFocus()"
                            maxlength="10" style="width: 100%" /></td>
                                        </tr>
                                        <tr>
                                            <td>4.   Non-taxable residential Amount</td>
                                            <td align="center" class="no_border_right">
                                              <input class="inpNormal" id="txtUO1_4" onchange="ValidateUOReturn()" onfocus="SetFocus()"
                            maxlength="10" style="width: 100%" /></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">5.  Delinquent Tenant Amount
                                                <label class="lblLink label_NoLeft"  onclick="ShowPage(2)">
                            (Click here to complete UO3)</label>
                                            </td>
                                            <td align="center" class="no_border_right">
                                             <input class=inpNormal id=txtUO1_5 onchange="ValidateUOReturn()"
			 onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%"></td>
                                        </tr>
                                        <tr>
                                            <td>6.   Keystone Opportunity Zone (KOZ) Amount</td>
                                            <td align="center" class="no_border_right">
                                               <input class=inpNormal id=txtUO1_6 onchange="ValidateUOReturn()"
			 onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%">
                                               </td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">7.  Total of Lines 2, 3, 4, 5 and 6</td>
                                            <td align="center" class="no_border_right">
                                                <label class="label_NoLeft" id="lblUO1_7" style="width: 100%">
                                                   
                        </label></td>
                                        </tr>
                                        <tr>
                                            <td>8.  Tax Due [Calculated - line 1 minus 7]</td>
                                            <td align="center" class="no_border_right">
                                                <label class="label_NoLeft" id="lblUO1_8" style="width: 100%">
                                                  
                        </label></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">9.  Discount (available only for landlords)[Calculated - line 8 multiply by 1%]</td>
                                            <td align="center" class="no_border_right">
                                              <input class=inpNormal id=txtUO1_9 onchange="ValidateUOReturn()" onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>10.  <b>Net tax Due</b> [Calculated - line 8 minus 9]</td>
                                            <td align="center" class="no_border_right">
                                               <label class="label_NoLeft" id="lblUO1_10" style="width: 100%">
                                                  
                        </label></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">11.  Interest & Penalty</td>
                                            <td align="center" class="no_border_right">
                                                <input class=inpNormal id=txtUO1_11 onchange="ValidateUOReturn()"
			 onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%">
                                            </td>
                                        </tr>
                                        <tr >
                                            <td width="70%"> 12.  <b>Total Due</b>  [Calculated - line 10 plus 11]</td>
                                            <td align="center" class="no_border_right">
                                             <label class=label_NoLeft id=lblUO1_12 style="WIDTH: 100%"></label>
                   
                                            </td>
                                        </tr>
                                        
                                        
                                    </tbody>
                                </table>
                                <div class="clear"></div>

                            </div>


                           <div> <%
                Html.RenderAction("PreparerSection", "INC");   
            %></div>
                             <div class="form_segment here_input_table" align="right">
                                <input id="btnUOPrint" type="button" value="Print" class="submit_button_light" onclick="return btnUOPrint_onclick()" />
                                <input type="button" value="Submit" class="submit_button" id="btnUOSubmit" onclick="return btnUOSubmit_onclick()" />
                            </div>
                           </div>

 <!-- UO3 Form -->
        <div <%--style="display: none"--%> id="divUO3_pg2">
            <table id="tblUO3" class="table table-condensed table-striped custom_table03" width="95%">
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


                    </div>

                </div>
                <div class="quicklink_btm_gen"></div>
            </div>

        </div>
    </div>
</body>
</html>
