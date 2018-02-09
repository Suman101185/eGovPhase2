﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>

<script id="clientEventHandlersJS" language="javascript">

    var arrNumWage08Err = new Array();
    var arrWage08Err = new Array();
    var txtHeader = 'Taxpayer Information';
    var dResTax_A, dResTax_B, dNonResTax_A, dNonResTax_B;
    var gUserAddr = '<%Response.Write(Request.ServerVariables["REMOTE_ADDR"]);%>'

    function AdjustNameDisplay(incName) {
        var sEntityName = incName;
        var lName = "",
            fName = "",
            mName = "",
            newName = "";

        if (sEntityName.indexOf("*") != -1) { //If name contains *'s
            sEntityName = sEntityName.split("*");
            lName = (sEntityName[0].substr(0, 1)) + (sEntityName[0].substr(1).toLowerCase());
            if (sEntityName[1]) {
                fName = (sEntityName[1].substr(0, 1)) + (sEntityName[1].substr(1).toLowerCase());
            } //if
            if (sEntityName[2]) {
                mName = sEntityName[2].substr(0, 1).toUpperCase();
            }
            sEntityName = fName + " " + mName + " " + lName;
        } //if
        return sEntityName;
    } //AdjustNameDisplay

    function DisplayWage08Return() {
        alert("hii");
        if (parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, 'TAX_ACCT[ACCOUNT = "1"]', '', 0)) {
            parent.ispHighlightMenu(parent.mnuWageYear13);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 'INQ', 'WAGE_INFO RETURN_STATUS', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ENTITY_ID', '', 0), 'WAGE_INFO ENTITY_ID', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ACCOUNT_ID', '', 0), 'WAGE_INFO ACCOUNT_ID', '', 0);
           
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, '12/31/2013', 'WAGE_INFO PERIOD', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, '', 'DEBUG', '', 0);
            ispCallXMLForm(parent.$g.xmlWage, parent.$g.xmlWage, "WageReturn", "");
          
            ispHideProgress();
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'ERROR_INFO ERROR', "", 0) != 0) {
             //   parent.RightFrame.rows = '*,0';
                WageReturn_08.style.display = 'block'
                AppHeader.innerHTML = txtHeader + '<Font class=hdrMedium>|wage tax reconciliation return</Font>';
                PopulateWage08Header();
                FieldLock_08(true);
                AppError.innerText = parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'ERROR_INFO MESSAGE', '', 0)
                btnWage08Submit.disabled = true;
                chkAmended_08.disabled = true;
                return
            } //if
            if ($(parent.document).find('#divAcctInfo').first().css('display') == 'none') {
                $(parent.document).find('#divAcctInfo').first().css('display', 'block');
                $(parent.document).find('#divAccount').first().css('display', 'none');
            } //if
        } else {
            parent.ispMenu_onclick($(parent.document).find('#mnuAcctInfo').first().get(0))
        } //if
       // $(parent.RightFrame).attr("rows", "*,0");
        $('#WageReturn').css('display', 'block');


        $('#AppHeader').html(txtHeader + '<Font class=hdrMedium>|wage tax reconciliation return for 2013</Font>');
        parent.gsInstructionItem = '#WageReturn';
        $('#AppMessage').html(parent.gsInstructionText + '<BR>The Reconciliation of Wage Tax for 2013 is due February 28, 2014.');
        $('#InstructionText').html(' for Instructions on filing this return');

        LoadWage08Error()
        RightAlignText()
        CheckWage08XML()
        SetWage08Fields()
        PopulateWage08Header()
        PopulateWage08Data()
        $('#AppError').text('');
    }


    function SetWage08Fields() {
        FieldLock_08(false)
        $('#chkAmended_08').attr('disabled', 'disable');
        chkTaxpayer.checked = false
        chkAmended_08.checked = false

        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO VERSION', '', 0) != '') {
            $('#chkAmended_08').removeAttr('disabled');
            FieldLock_08(true)
        }
    }

    function RightAlignText() {
        $('#txtWageNoA_08').css('textAlign', 'right');
        $('#txtWageNoB_08').css('textAlign', 'right');
        $('#txtWageNoC_08').css('textAlign', 'right');
        $('#txtWageNoD_08').css('textAlign', 'right');
        $('#txtWageNo1_08').css('textAlign', 'right');
        $('#txtWageNo2_08').css('textAlign', 'right');
        $('#txtWageNo4_08').css('textAlign', 'right');
        $('#txtWageNo6_08').css('textAlign', 'right');
        $('#txtWageNo8_08').css('textAlign', 'right');
        $('#txtWageNo10_08').css('textAlign', 'right');

        $('#lblWageNo3_08').parent().css("text-align", "right");
        $('#lblWageNo5_08').parent().css("text-align", "right");
        $('#lblWageNo7_08').parent().css("text-align", "right");
        $('#lblWageNo9_08').parent().css("text-align", "right");
        $('#lblWageNo11_08').parent().css("text-align", "right");
        $('#lblWageNo12_08').parent().css("text-align", "right");
        $('#lblWageNo13_08').parent().css("text-align", "right");
        $('#lblWageNo14_08').parent().css("text-align", "right");
        $('#lblWageNo15_08').parent().css("text-align", "right");
    }


    function FieldLock_08(bDisabled) {
        if (bDisabled == true) {
            $('#txtWageNoA_08').attr('disabled', 'disable');
            $('#txtWageNoB_08').attr('disabled', 'disable');
            $('#txtWageNoC_08').attr('disabled', 'disable');
            $('#txtWageNoD_08').attr('disabled', 'disable');
            $('#txtWageNo1_08').attr('disabled', 'disable');
            $('#txtWageNo2_08').attr('disabled', 'disable');
            $('#lblWageNo3_08').attr('disabled', 'disable');
            $('#txtWageNo4_08').attr('disabled', 'disable');
            $('#lblWageNo5_08').attr('disabled', 'disable');
            $('#txtWageNo6_08').attr('disabled', 'disable');
            $('#lblWageNo7_08').attr('disabled', 'disable');
            $('#txtWageNo8_08').attr('disabled', 'disable');
            $('#lblWageNo9_08').attr('disabled', 'disable');
            $('#txtWageNo10_08').attr('disabled', 'disable');
            $('#lblWageNo11_08').attr('disabled', 'disable');
            $('#lblWageNo12_08').attr('disabled', 'disable');
            $('#lblWageNo13_08').attr('disabled', 'disable');
            $('#lblWageNo14_08').attr('disabled', 'disable');
            $('#lblWageNo15_08').attr('disabled', 'disable');
        } else {
            $('#txtWageNoA_08').removeAttr('disabled');
            $('#txtWageNoB_08').removeAttr('disabled');
            $('#txtWageNoC_08').removeAttr('disabled');
            $('#txtWageNoD_08').removeAttr('disabled');
            $('#txtWageNo1_08').removeAttr('disabled');
            $('#txtWageNo2_08').removeAttr('disabled');
            $('#lblWageNo3_08').removeAttr('disabled');
            $('#txtWageNo4_08').removeAttr('disabled');
            $('#lblWageNo5_08').removeAttr('disabled');
            $('#txtWageNo6_08').removeAttr('disabled');
            $('#lblWageNo7_08').removeAttr('disabled');
            $('#txtWageNo8_08').removeAttr('disabled');
            $('#lblWageNo9_08').removeAttr('disabled');
            $('#txtWageNo10_08').removeAttr('disabled');
            $('#lblWageNo11_08').removeAttr('disabled');
            $('#lblWageNo12_08').removeAttr('disabled');
            $('#lblWageNo13_08').removeAttr('disabled');
            $('#lblWageNo14_08').removeAttr('disabled');
            $('#lblWageNo15_08').removeAttr('disabled');
        }
        DisablePreparer(bDisabled)
    }


    function CheckWage08XML() {
        var bPeriodExist = true
        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO PERIOD', '', 0) != '' && new Date(parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO PERIOD', '', 0)) < new Date('01/01/2013')) {
            bPeriodExist = false
        }

        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO PERIOD', '', 0) == '') {
            bPeriodExist = false
        }

        if (bPeriodExist == false) {
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, '', 'ERROR_INFO PROGRAM', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, '', 'ERROR_INFO ERROR', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, '', 'ERROR_INFO LINE', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, '', 'ERROR_INFO MESSAGE', '', 0)

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, '12/31/2013', 'WAGE_INFO PERIOD', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, '', 'WAGE_INFO VERSION', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, '', 'WAGE_INFO DOCUMENT_CONTROL', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, '', 'WAGE_INFO SEQUENCE', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, '', 'WAGE_INFO LAST_UPD_DATE', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, '', 'WAGE_INFO RETURN_STATUS', '', 0)

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 0, 'WAGE_INFO NO_OF_RESIDENTS', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 0, 'WAGE_INFO NO_OF_NONRESIDENTS', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 0, 'WAGE_INFO TOTAL_EMPLOYEES', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 0, 'WAGE_INFO PHILA_EMPLOYEES', '', 0)
            ClearPreparerXML(parent.$g.xmlWage, 'WAGE_INFO')

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 0, 'AMT_INFO GROSS_COMP', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 0, 'AMT_INFO NON_TAXABLE_COMP', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 0, 'AMT_INFO NET_COMP', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 0, 'AMT_INFO RESIDENT_PAYROLL_A', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 0, 'AMT_INFO RESIDENT_TAX_DUE_A', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 0, 'AMT_INFO RESIDENT_PAYROLL_B', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 0, 'AMT_INFO RESIDENT_TAX_DUE_B', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 0, 'AMT_INFO NON_RES_PAYROLL_A', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 0, 'AMT_INFO NON_RES_TAX_DUE_A', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 0, 'AMT_INFO NON_RES_PAYROLL_B', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 0, 'AMT_INFO NON_RES_TAX_DUE_B', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 0, 'AMT_INFO TOTAL_GROSS_TAX_DUE', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 0, 'AMT_INFO TAX_PAID', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 0, 'AMT_INFO TAX_DUE', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 0, 'AMT_INFO TAX_OVERPAID', '', 0)
        }
    }


    function PopulateWage08Header() {
        var addrIdx, i
        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ENTITY_ID', '', 0) != '') {
            $('#lblAcctId_08').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO ACCOUNT_ID', '', 0));
            $('#lblEntityId_08').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ENTITY_ID', '', 0))
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO TYPE', '', 0) == 1) {
                $('#lblEntityType_08').text('EIN:');
                $('#lblEntityId_08').text(' ' + $('#lblEntityId_08').text().substr(0, 2) + '-' + $('#lblEntityId_08').text().substr(2));
            } else {
                $('#lblEntityType_08').text('SSN:');
                $('#lblEntityId_08').text(' ' + $('#lblEntityId_08').text().substr(0, 3) + '-' + $('#lblEntityId_08').text().substr(3, 2) + '-' + $('#lblEntityId_08').text().substr(5));
            } //if
            addrIdx = LocatePrimaryAddr()
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS TRADE_NAME', '', addrIdx) != '') {
                $('#lblName_08').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS TRADE_NAME', '', addrIdx));
            } else {
                $('#lblName_08').text(AdjustNameDisplay(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS NAME', '', addrIdx)));
            }
            $('#lblAddress_08').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS1', '', addrIdx) + ' ' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS CITY', '', addrIdx) + ' ' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS STATE', '', addrIdx) + ' ' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ZIP', '', addrIdx));
        }
    }


    function PopulateWage08Data() {

        dResTax_A = parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO RESTAX_A', '', 0)
        dResTax_B = parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO RESTAX_B', '', 0)
        dNonResTax_A = parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO NONRESTAX_A', '', 0)
        dNonResTax_B = parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO NONRESTAX_B', '', 0)

        txtWageNoA_08.value = parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO NO_OF_RESIDENTS', '', 0)
        txtWageNoB_08.value = parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO NO_OF_NONRESIDENTS', '', 0)
        txtWageNoC_08.value = parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO TOTAL_EMPLOYEES', '', 0)
        txtWageNoD_08.value = parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO PHILA_EMPLOYEES', '', 0)
        txtWageNo1_08.value = ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO GROSS_COMP', '', 0), 0)
        txtWageNo2_08.value = ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO NON_TAXABLE_COMP', '', 0), 0)
        $('#lblWageNo3_08').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO NET_COMP', '', 0), 0));
        txtWageNo4_08.value = ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO RESIDENT_PAYROLL_A', '', 0), 0)
        $('#lblWageNo5_08').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO RESIDENT_TAX_DUE_A', '', 0), 0));
        txtWageNo6_08.value = ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO RESIDENT_PAYROLL_B', '', 0), 0)
        $('#lblWageNo7_08').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO RESIDENT_TAX_DUE_B', '', 0), 0));
        txtWageNo8_08.value = ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO NON_RES_PAYROLL_A', '', 0), 0)
        $('#lblWageNo9_08').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO NON_RES_TAX_DUE_A', '', 0), 0));
        txtWageNo10_08.value = ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO NON_RES_PAYROLL_B', '', 0), 0)
        $('#lblWageNo11_08').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO NON_RES_TAX_DUE_B', '', 0), 0));
        $('#lblWageNo12_08').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO TOTAL_GROSS_TAX_DUE', '', 0), 0));
        $('#lblWageNo13_08').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO TAX_PAID', '', 0), 0));
        $('#lblWageNo14_08').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO TAX_DUE', '', 0), 0))
        $('#lblWageNo15_08').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO TAX_OVERPAID', '', 0), 0));

        PopulatePreparer(parent.$g.xmlWage, 'WAGE_INFO')
    } //PopulateWage08Data

    function PopulateWage08XML() {
        var d = new Date()
        var lYear = String(d.getFullYear())
        var lMonth = String(d.getMonth() + 1)
        lMonth = lMonth.length == 1 ? '0' + lMonth : lMonth
        var lDate = String(d.getDate())
        lDate = lDate.length == 1 ? '0' + lDate : lDate

        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, '', 'AMT_INFO POSTING_DATE', '', 0)
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, lMonth + '/' + lDate + '/' + lYear, 'AMT_INFO FILING_DATE', '', 0)

        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, txtWageNoA_08.value, 'WAGE_INFO NO_OF_RESIDENTS', '', 0)
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, txtWageNoB_08.value, 'WAGE_INFO NO_OF_NONRESIDENTS', '', 0)
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, txtWageNoC_08.value, 'WAGE_INFO TOTAL_EMPLOYEES', '', 0)
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, txtWageNoD_08.value, 'WAGE_INFO PHILA_EMPLOYEES', '', 0)

        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, stripCurrency(txtWageNo1_08.value), 'AMT_INFO GROSS_COMP', '', 0)
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, stripCurrency(txtWageNo2_08.value), 'AMT_INFO NON_TAXABLE_COMP', '', 0)
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, stripCurrency($('#lblWageNo3_08').text()), 'AMT_INFO NET_COMP', '', 0)
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, stripCurrency(txtWageNo4_08.value), 'AMT_INFO RESIDENT_PAYROLL_A', '', 0)
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, stripCurrency($('#lblWageNo5_08').text()), 'AMT_INFO RESIDENT_TAX_DUE_A', '', 0)
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, stripCurrency(txtWageNo6_08.value), 'AMT_INFO RESIDENT_PAYROLL_B', '', 0)
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, stripCurrency($('#lblWageNo7_08').text()), 'AMT_INFO RESIDENT_TAX_DUE_B', '', 0)
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, stripCurrency(txtWageNo8_08.value), 'AMT_INFO NON_RES_PAYROLL_A', '', 0)
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, stripCurrency($('#lblWageNo9_08').text()), 'AMT_INFO NON_RES_TAX_DUE_A', '', 0)
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, stripCurrency(txtWageNo10_08.value), 'AMT_INFO NON_RES_PAYROLL_B', '', 0)
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, stripCurrency($('#lblWageNo11_08').text()), 'AMT_INFO NON_RES_TAX_DUE_B', '', 0)
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, stripCurrency($('#lblWageNo12_08').text()), 'AMT_INFO TOTAL_GROSS_TAX_DUE', '', 0)
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, stripCurrency($('#lblWageNo13_08').text()), 'AMT_INFO TAX_PAID', '', 0)
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, stripCurrency($('#lblWageNo14_08').text()), 'AMT_INFO TAX_DUE', '', 0)
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, stripCurrency($('#lblWageNo15_08').text()), 'AMT_INFO TAX_OVERPAID', '', 0)

        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, '', 'DEBUG', '', 0)
        PopulatePreparerXML(parent.$g.xmlWage, 'WAGE_INFO')
    }


    function LoadWage08Error() {

        var i = 0


        arrWage08Err[i++] = [txtWageNo1_08, 'txtWageNo1_08.value == ""', 'Answer Question 1']
        arrWage08Err[i++] = [txtWageNo1_08, 'ispValue(txtWageNo1_08.value) == false', 'Value for Question 1 Number must be numeric']
        arrWage08Err[i++] = [txtWageNo1_08, 'ispNegativeNumber(txtWageNo1_08.value) == false', 'Value for Question 1 must NOT be negative']

        arrWage08Err[i++] = [txtWageNo2_08, 'txtWageNo2_08.value == ""', 'Answer Question 2']
        arrWage08Err[i++] = [txtWageNo2_08, 'ispValue(txtWageNo2_08.value) == false', 'Value for Question 2 Number must be numeric']
        arrWage08Err[i++] = [txtWageNo2_08, 'ispNegativeNumber(txtWageNo2_08.value) == false', 'Value for Question 2 must NOT be negative']

        arrWage08Err[i++] = [txtWageNo4_08, 'txtWageNo4_08.value == ""', 'Answer Question 4']
        arrWage08Err[i++] = [txtWageNo4_08, 'ispValue(txtWageNo4_08.value) == false', 'Value for Question 4 Number must be numeric']
        arrWage08Err[i++] = [txtWageNo4_08, 'ispNegativeNumber(txtWageNo4_08.value) == false', 'Value for Question 4 must NOT be negative']

        arrWage08Err[i++] = [txtWageNo6_08, 'txtWageNo6_08.value == ""', 'Answer Question 6']

        arrWage08Err[i++] = [txtWageNo6_08, 'ispValue(txtWageNo6_08.value) == false', 'Value for Question 6 Number must be numeric']

        arrWage08Err[i++] = [txtWageNo6_08, 'ispNegativeNumber(txtWageNo6_08.value) == false', 'Value for Question 6 must NOT be negative']

        arrWage08Err[i++] = [txtWageNo8_08, 'txtWageNo8_08.value == ""', 'Answer Question 8']
        arrWage08Err[i++] = [txtWageNo8_08, 'ispValue(txtWageNo8_08.value) == false', 'Value for Question 8 Number must be numeric']
        arrWage08Err[i++] = [txtWageNo8_08, 'ispNegativeNumber(txtWageNo8_08.value) == false', 'Value for Question 8 must NOT be negative']

        arrWage08Err[i++] = [txtWageNo10_08, 'txtWageNo10_08.value == ""', 'Answer Question 10']
        arrWage08Err[i++] = [txtWageNo10_08, 'ispValue(txtWageNo10_08.value) == false', 'Value for Question 10 Number must be numeric']
        arrWage08Err[i++] = [txtWageNo10_08, 'ispNegativeNumber(txtWageNo10_08.value) == false', 'Value for Question 10 must NOT be negative']

        i = 0 //Reset
        arrNumWage08Err[i++] = [txtWageNoA_08, 'ispValue(txtWageNoA_08.value) == false', 'Value for Question A Number must be numeric']
        arrNumWage08Err[i++] = [txtWageNoB_08, 'ispValue(txtWageNoB_08.value) == false', 'Value for Question B Number must be numeric']
        arrNumWage08Err[i++] = [txtWageNoC_08, 'ispValue(txtWageNoC_08.value) == false', 'Value for Question C Number must be numeric']
        arrNumWage08Err[i++] = [txtWageNoD_08, 'ispValue(txtWageNoD_08.value) == false', 'Value for Question D Number must be numeric']

        arrNumWage08Err[i++] = [txtWageNoA_08, 'ispNegativeNumber(txtWageNoA_08.value) == false', 'Value for Question A must NOT be negative']
        arrNumWage08Err[i++] = [txtWageNoB_08, 'ispNegativeNumber(txtWageNoB_08.value) == false', 'Value for Question B must NOT be negative']
        arrNumWage08Err[i++] = [txtWageNoC_08, 'ispNegativeNumber(txtWageNoC_08.value) == false', 'Value for Question C must NOT be negative']
        arrNumWage08Err[i++] = [txtWageNoD_08, 'ispNegativeNumber(txtWageNoD_08.value) == false', 'Value for Question D must NOT be negative']
    } //LoadWage08Error

    function ValidateWage08Number() {
        var evt = window.event || arguments.callee.caller.arguments[0];
        var source = parent.getEventSource(evt);

        $('#AppError').text('');
        if (source != null && source.type != 'button') {
            if (source.value == '') {
                source.value = 0;
            }
        }

        $('#AppError').text(ispSetInputErr(arrNumWage08Err));

        if ($('#AppError').text() != '') {
            AppError.scrollIntoView(true);
        }

    }

    function ValidateWage08Prelim() {
        var evt = window.event || arguments.callee.caller.arguments[0];
        var source = parent.getEventSource(evt);
        var ObjSelected = source;

        $('#AppError').text('');

        $('#txtWageNo1_8').attr('class', 'inpNormal');
        if (ObjSelected) {
            if (ObjSelected.type != 'button') {
                ObjSelected.value = ispFormatMoney(ObjSelected.value, 0);
            }
        }

        $('#AppError').text(ispSetInputErr(arrWage08Err));

        if ($('#AppError').text() == '') {
            Calc1Minus2();
            TaxDueLine5(dResTax_A);
            TaxDueLine7(dResTax_B);
            TaxDueLine9(dNonResTax_A);
            TaxDueLine11(dNonResTax_B);
            TaxDueLine12();
            TaxDueLine14_15();
        } else {
            AppError.scrollIntoView(true);
        }
    }


    function ValidateWage08Return() {
        var evt = window.event || arguments.callee.caller.arguments[0];
        var source = parent.getEventSource(evt);

        var ObjSelected = source;

        if ($('#AppError').text() == '') {
            $('#txtWageNo1_8').attr('class', 'inpNormal');
            if (ObjSelected) {
                if (ObjSelected.type != 'button') {
                    ObjSelected.value = ispFormatMoney(ObjSelected.value, 0);
                }
            }

            $('#AppError').text(ispSetInputErr(arrWage08Err));

            if ($('#AppError').text() == '') {
                Calc1Minus2()
                TaxDueLine5(dResTax_A);
                TaxDueLine7(dResTax_B);
                TaxDueLine9(dNonResTax_A);
                TaxDueLine11(dNonResTax_B);
                TaxDueLine12();
                TaxDueLine14_15();
                if ($('#AppError').text() == '') {
                    CalcGrossComp();
                }

            } else {
                AppError.scrollIntoView(true);
            }
        }
    }




    function btnWage08Print_onclick() {
        $('#btnWage08Print').css('visibility', 'hidden');
        $('#btnWage08Submit').css('visibility', 'hidden');
        $('#AppError').text('');

        if ($('#txtWageNo1_08').is(':disabled') == true) {
            FieldLock(false);
            window.print();
            FieldLock(true);
        } else {
            window.print();
        } //if
        $('#btnWage08Print').css('visibility', 'visible');
        $('#btnWage08Submit').css('visibility', 'visible');
    }



    var tempXML = parent.$g.getXmlDocObj();

    function btnWageValidate() {
        ValidateWage08Number();
        if ($('#AppError').text() == '') {
            ValidateWage08Return();
        }
        if ($('#AppError').text() == '') {
            $('#AppError').text(ValidatePreparer());
        }
    }


    function btnWage08Submit_onclick() {
        if ($('#AppError').text() == "") {
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, '', 'WAGE_INFO RETURN_STATUS', '', 0);
            PopulateWage08XML();
            parent.DocWin.ispCallXMLForm(parent.$g.xmlWage, tempXML, "WageReturn", "");
            ispHideProgress();

            parent.$g.xmlWage.loadXML(tempXML.xml);
            if (parent.$x.ispXmlGetFieldVal(tempXML, 'ERROR_INFO PROGRAM', '', 0) == '') {
                parent.$g.xmlWage.loadXML(tempXML.xml);
                $('#WageReturn_08').css('display', 'none');
                DisplayWageThankYou();
            } else {
                $('#AppError').text(parent.$x.ispXmlGetFieldVal(tempXML, 'ERROR_INFO MESSAGE', '', 0));
            }
        } else {
            ispHideProgress();
        }
    }




    function chkAmended_08_onclick() {
        if (chkAmended_08.checked == true) {
            $('#btnWage08Submit').removeAttr('disabled');
            FieldLock_08(false);
            ClearPreparer();
        } else {
            $('#btnWage08Submit').attr('disabled', 'disable');
            chkAgreement.checked = false;
            FieldLock_08(true);
            PopulatePreparer(parent.$g.xmlWage, 'WAGE_INFO');
        }
    }


    function ReadOnlySetFocus() {

        var evt = window.event || arguments.callee.caller.arguments[0];
        var source = parent.getEventSource(evt);

        var sId = source.id;

        switch (sId) {

            case 'txtWageNo10_08':
                txtWageNo10_08.select()
                break
            case 'lblWageNo13_08':
                txtWageNo1_08.select()
            default:

        }
    }


    function LocatePrimaryAddr() {
        var iMaxIdx = parent.$x.ispXmlGetRecCount(parent.$g.xmlAccount, 'NAME_ADDRESS', '')

        for (idx = 0; idx < iMaxIdx; i++) {
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS_TYPE', '', idx) == '60') {
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS RELATIONSHIP_CODE', '', idx) == '0') {
                    return idx;
                }
            } else {
                return 0;
            }
        }
    }


    function PreviousPaid() {
        showModalDialog('HelpPreviousPaidTax.htm', 0, 'dialogWidth:420px;dialogHeight:325px;dialogLeft:550px;')
    }

    function parseCurrency(value) {
        return ispRemoveMoney(value);
    }

    function CheckABCD() {

        if ((txtWageNoA_08.value == "") || (txtWageNoA_08.value < 0)) {
            txtWageNoA_08.value = 0

        } else {
            txtWageNoA_08.value = txtWageNoA_08.value
        }

        if ((txtWageNoB_08.value == "") || (txtWageNoB_08.value < 0)) {
            txtWageNoB_08.value = 0;
        } else {
            txtWageNoB_08.value = txtWageNoB_08.value;
        }
        if ((txtWageNoC_08.value == "") || (txtWageNoC_08.value < 0)) {
            txtWageNoC_08.value = 0
        } else {
            txtWageNoC_08.value = txtWageNoC_08.value;
        }

        if ((txtWageNoD_08.value == "") || (txtWageNoD_08.value < 0)) {
            txtWageNoD_08.value = 0;
        } else {
            txtWageNoD_08.value = txtWageNoD_08.value;
        }
    }

    function CheckGrossComp() {
        if ((parseCurrency($('#lblWageNo5_08').text()) != 0) || (parseCurrency($('#lblWageNo7_08').text()) != 0) || (parseCurrency($('#lblWageNo9_08').text()) != 0) || (parseCurrency($('#lblWageNo11_08').text()) != 0) || (parseCurrency($('#lblWageNo12_08').text()) != 0) || (parseCurrency($('#lblWageNo13_08').text()) != 0)) {

            if ($('#AppError').text() == '') {
                $('#txtWageNo4_08').attr('class', 'inpNormal');
                $('#txtWageNo6_08').attr('class', 'inpNormal');
                $('#txtWageNo8_08').attr('class', 'inpNormal');
                $('#txtWageNo10_08').attr('class', 'inpNormal');
                if (parseCurrency(txtWageNo4_08.value) == 0 && parseCurrency(txtWageNo6_08.value) == 0 && parseCurrency(txtWageNo8_08.value) == 0 && parseCurrency(txtWageNo10_08.value) == 0) {
                    $('#AppError').text('Lines 4, 6, 8 & 10 can not all equal 0');
                    $('#txtWageNo4_08').attr('class', 'inpNormal');
                    $('#txtWageNo6_08').attr('class', 'inpError');
                    $('#txtWageNo8_08').attr('class', 'inpError');
                    $('#txtWageNo10_08').attr('class', 'inpError');
                }
            }
        }
    }

    function Calc1Minus2() {
        if (txtWageNo1_08.value != "" && txtWageNo2_08.value != "") {
            $('#lblWageNo3_08').text(
            ispFormatMoney(parseCurrency(txtWageNo1_08.value) - parseCurrency(txtWageNo2_08.value), 0));
        }
    }

    function CalcGrossComp() {

        if (parseCurrency(txtWageNo1_08.value) != (parseCurrency(txtWageNo2_08.value) + parseCurrency(txtWageNo4_08.value) + parseCurrency(txtWageNo6_08.value) + parseCurrency(txtWageNo8_08.value) + parseCurrency(txtWageNo10_08.value))) {
            $('#txtWageNo1_08').attr('class', 'inpError');
            $('#AppError').text('Line 1 is not equal to the sum of lines 2, 4, 6, 8 & 10');
            AppError.scrollIntoView(true);
        } else {
            $('#txtWageNo1_08').attr('class', 'inpNormal');
            $('#AppError').text('');
        }
    }

    function TaxDueLine5(dTax) {
        if (txtWageNo4_08.value != "") {
            $('#lblWageNo5_08').text(ispFormatMoney(parseCurrency(parseCurrency(txtWageNo4_08.value) * parseCurrency(dTax)), 0));
        }
    }

    function TaxDueLine7(dTax) {
        if (txtWageNo6_08.value != "") {
            $('#lblWageNo7_08').text(ispFormatMoney(parseCurrency(parseCurrency(txtWageNo6_08.value) * parseCurrency(dTax)), 0));
        }
    }

    function TaxDueLine9(dTax) {

        if (txtWageNo8_08.value != "") {
            $('#lblWageNo9_08').text(ispFormatMoney(parseCurrency(parseCurrency(txtWageNo8_08.value) * parseCurrency(dTax)), 0))
        }
    }

    function TaxDueLine11(dTax) {

        if (txtWageNo10_08.value != "") {
            $('#lblWageNo11_08').text(ispFormatMoney(parseCurrency(parseCurrency(txtWageNo10_08.value) * parseCurrency(dTax)), 0))
        }
    }

    function TaxDueLine12() {

        if ($('#lblWageNo5_08').text() != "" && $('#lblWageNo7_08').text != "" && $('#lblWageNo9_08').text() != "" && $('#lblWageNo11_08').text() != "") {
            $('#lblWageNo12_08').text(
            ispFormatMoney((parseCurrency($('#lblWageNo5_08').text()) + parseCurrency($('#lblWageNo7_08').text()) + parseCurrency($('#lblWageNo9_08').text()) + parseCurrency($('#lblWageNo11_08').text())), 0));
        }
    }

    function TaxDueLine14_15() {

        if ($('#lblWageNo12_08').text() != "" && $('#lblWageNo13_08').text() != "") {
            if (parseCurrency($('#lblWageNo12_08').text()) > parseCurrency($('#lblWageNo13_08').text())) {
                $('#lblWageNo14_08').text(
                ispFormatMoney(
                parseCurrency($('#lblWageNo12_08').text()) - parseCurrency($('#lblWageNo13_08').text()), 0));
                $('#lblWageNo15_08').text(ispFormatMoney(0, 0));
            } else {
                $('#lblWageNo14_08').text(ispFormatMoney(0, 0));
                $('#lblWageNo15_08').text(
                ispFormatMoney((parseCurrency($('#lblWageNo13_08').text()) - parseCurrency($('#lblWageNo12_08').text())), 0));
            }
        }
    }

</script>
   
<title></title>
</head>
<body onload="ispDisplayProgress('DisplayWage08Return()','Retrieving 2013 wage tax information')">
<DIV style="DISPLAY: block; VISIBILITY: visible" Id="WageReturn_08" Name="WageReturn_08">
 
<table class=tblShowBorder width="90%" bgcolor="whitesmoke" style="MARGIN-LEFT: 4%" border=0
		 cellSpacing=0 cellPadding=0 id=TABLE1>
  <tr>
    <td WIDTH="2%"></td>
    <td WIDTH="8%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td></tr>
  <tr id=rowAcctId_081>
		<td >&nbsp;</td>
		<td colspan=2>
			<label class="lblInstrNormal">Account Id:&nbsp;</label>
		</td>
		<td colspan=4>
			<label id=lblAcctId_08 class="lblTextBlack"></label></td>
		<td colspan=2 align=right>
			<label id=lblEntityType_08 class="lblInstrNormal">EIN:&nbsp;</label></td>
		<td colspan=5>
			<label id=lblEntityId_08 class="lblTextBlack"></label></td>
	</tr>
  <tr>
		<td >&nbsp;</td>
		<td colspan=2>
			<label class="lblInstrNormal">Name:&nbsp;</label>
		</td>
		<td colspan=20>
			<label id=lblName_08 class="lblTextBlack"></label></td>
	</tr>
  <tr>
		<td >&nbsp;</td>
		<td colspan=2>
			<label class="lblInstrNormal">Address:&nbsp;</label>
		</td>
		<td colspan=17>
			<label id=lblAddress_08 class="lblTextBlack"></label></td>
	</tr>
</table>

<table style="LEFT: 43px; MARGIN-LEFT: 4%; TOP: 205px" border=0 width="90%">
  <tr>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td></tr>
  <tr>
		<td align=left colspan=10 nowrap>
			<INPUT id=chkAmended_08 type=checkbox onclick="chkAmended_08_onclick()">
				<label class="lblTextBlacksmall">Check if amended return.</label></td>
	</tr>
</table>

<table class=tblShowBorder cellSpacing=0 cellPadding=0 border=0 style="MARGIN-LEFT: 4%" id=TABLE2 width="90%">
  <tr>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td>
    <td WIDTH="5%"></td></tr>
  <tr class=rowDataEven>
		<td>
			<label class="lblInstrNormal">A.</label></td>
		<td colspan=16>
			<label class="lblInstrNormal">Enter the number of Philadelphia Residents for whom 
				wage tax was remitted for the pay period including March 12, 2013.</label></td>
		<td colspan=3>
			<input class=inpNormal id=txtWageNoA_08 onchange="ValidateWage08Number()"
				 onfocus="ReadOnlySetFocus()" maxlength=10 style="WIDTH: 100%"></td></tr>
  <tr class=rowDataOdd>
		<td>
			<label class="lblInstrNormal">B.</label></td>
		<td colspan=16>
			<label class="lblInstrNormal">Enter the number of <strong>nonresidents</strong> (employees living 
				outside Philadelphia city limits) for whom wage tax was remitted for the pay period
				including March 12, 2013.</label>
		</td>
		<td colspan=3>
			<input class=inpNormal id=txtWageNoB_08 onchange="ValidateWage08Number()"
				 onfocus="ReadOnlySetFocus()" maxlength=10 style="WIDTH: 100%"></td></tr>
  <tr class=rowDataEven>
		<td>
			<label class="lblInstrNormal">C.</label></td>
		<td colspan=16>
			<label class="lblInstrNormal">Total number of employees <strong>for all company locations</strong> 
				reported on the Employer's Federal Quarterly Tax Return for the first 
				quarter of 2012 (for the pay period including March 12, 2013).</label></td>
		<td colspan=3>
			<input class=inpNormal id=txtWageNoC_08 onchange="ValidateWage08Number()" 
				onfocus="ReadOnlySetFocus()" maxlength=10 style="WIDTH: 100%"></td></tr>
  <tr class=rowDataOdd>
		<td>
			<label class="lblInstrNormal">D.</label></td>
		<td colspan=16>
			<label class="lblInstrNormal">Number of employees working <strong>at company locations within
				Philadelphia city limits</strong>, for the pay period including March 12, 2013.</label></td>
		<td colspan=3>
			<input class=inpNormal id=txtWageNoD_08 onchange="ValidateWage08Number()"
				 onfocus="ReadOnlySetFocus()" maxlength=10 style="WIDTH: 100%"></td></tr>
  <tr class=rowDataEven>
		<td>
			<label class="lblInstrNormal">1.</label></td>
		<td colspan=16>
			<label class="lblInstrNormal">Gross Compensation per W-2 forms for all employees</label></td>
		<td colspan=3>
			<input class=inpNormal id=txtWageNo1_08 onchange="ValidateWage08Prelim()" 
				onfocus="ReadOnlySetFocus()" maxlength=20 style="WIDTH: 100%"></td></tr>
  <tr class=rowDataOdd>
		<td>
			<label class="lblInstrNormal">2.</label></td>
		<td colspan=16>
			<label class="lblInstrNormal">Non-Taxable Gross Compensation include in line 1
				(Paid to non-residents working outside of Philadelphia)</label></td>
		<td colspan=3>
			<input class=inpNormal id=txtWageNo2_08 onchange="ValidateWage08Prelim()"
				 onfocus="ReadOnlySetFocus()" maxlength=20 style="WIDTH: 100%"></td></tr>
  <tr class=rowDataEven>
		<td>
			<label class="lblInstrNormal">3.</label></td>
		<td colspan=10>
			<label class="lblInstrNormal">Gross Compensation per W-2 forms on 
				which Philadelphia Wage Tax was withheld or due</label></td>
		<td colspan=6 align=right>
			<label class="lblInstrNormal">[Calculated - line 1 less line 2]</label></td>
		<td colspan=3 class=inpReadOnlyRtTD><div>
			<label id=lblWageNo3_08 style="WIDTH: 100%"></label></div></td></tr>
  <tr class=rowDataOdd>
		<td>
			<label class="lblInstrNormal">4.</label></td>
		<td colspan=16>
			<label class="lblInstrNormal">Taxable Gross Compensation paid to <U>residents</U>      of 
				Philadelphia (1/1/2013 to 06/30/2013)</label></td>
		<td colspan=3>
			<input class=inpNormal id=txtWageNo4_08 onchange="ValidateWage08Prelim()"
				 onfocus="ReadOnlySetFocus()" maxlength=20 style="WIDTH: 100%"></td></tr>
  <tr class=rowDataEven>
		<td>
			<label class="lblInstrNormal">5.</label></td>
		<td colspan=8>
			<label class="lblInstrNormal">Tax Due</label></td>
		<td colspan=8 align=right>
			<label class="lblInstrNormal">[Calculated - line 4 X .039280]</label></td>
		<td colspan=3 class=inpReadOnlyRtTD><div>
			<label id=lblWageNo5_08 style="WIDTH: 100%"></label></div></td></tr>
  <tr class=rowDataOdd>
		<td>
			<label class="lblInstrNormal">6.</label></td>
		<td colspan=16>
			<label class="lblInstrNormal">Taxable Gross Compensation paid to <U>residents</U>      of 
				Philadelphia (7/1/2013 to 12/31/2013)</label></td>
		<td colspan=3>
			<input class=inpNormal id=txtWageNo6_08 onchange="ValidateWage08Prelim()"
				 onfocus="ReadOnlySetFocus()" maxlength=20 style="WIDTH: 100%"></td></tr>
  <tr class=rowDataEven>
		<td>
			<label class="lblInstrNormal">7.</label></td>
		<td colspan=8>
			<label class="lblInstrNormal">Tax Due</label></td>
		<td colspan=8 align=right>
			<label class="lblInstrNormal">[Calculated - line 6 X .039240]</label></td>
		<td colspan=3 class=inpReadOnlyRtTD><div>
			<label id=lblWageNo7_08 style="WIDTH: 100%"></label></div></td></tr>
  <tr class=rowDataOdd>
		<td>
			<label class="lblInstrNormal">8.</label></td>
		<td colspan=16>
			<label class="lblInstrNormal">Taxable Gross Compensation paid to 
      <U>non-residents</U>      of 
				Philadelphia (1/1/2013 to 06/30/2013)</label></td>
		<td colspan=3 >
			<input class=inpNormal id=txtWageNo8_08 onchange="ValidateWage08Prelim()"
				 onfocus="ReadOnlySetFocus()" maxlength=20 style="WIDTH: 100%"></td></tr>
  <tr class=rowDataEven>
		<td>
			<label class="lblInstrNormal">9.</label></td>
		<td colspan=8>
			<label class="lblInstrNormal">Tax Due</label></td>
		<td colspan=8 align=right>
			<label class="lblInstrNormal">[Calculated - line&nbsp;8 X .034985]</label></td>
		<td colspan=3 class=inpReadOnlyRtTD><div>
			<label id=lblWageNo9_08 style="WIDTH: 100%"></label></div></td></tr>
  <tr class=rowDataOdd>
		<td>
			<label class="lblInstrNormal">10.</label></td>
		<td colspan=16>
			<label class="lblInstrNormal">Taxable Gross Compensation paid to 
      <U>non-residents</U>      of 
				Philadelphia (7/1/2013 to 12/31/2013)</label></td>
		<td colspan=3>
			<input class=inpNormal id=txtWageNo10_08 onchange="ValidateWage08Prelim()"
				 onfocus="ReadOnlySetFocus()" maxlength=20 style="WIDTH: 100%"></td></tr>
  <tr class=rowDataEven>
		<td>
			<label class="lblInstrNormal">11.</label></td>
		<td colspan=8>
			<label class="lblInstrNormal">Tax Due</label></td>
		<td colspan=8 align=right>
			<label class="lblInstrNormal">[Calculated - line 10 X .034950]</label></td>
		<td colspan=3 class=inpReadOnlyRtTD><div>
			<label  id=lblWageNo11_08 style="WIDTH: 100%"></label></div></td></tr>
  <tr class=rowDataOdd>
		<td>
			<label class="lblInstrNormal">12.</label></td>
		<td colspan=8>
			<label class="lblInstrNormal">Total Tax Due</label></td>
		<td colspan=8 align=right>
			<label class="lblInstrNormal">[Calculated - lines 5, 7, 9 and 11]</label></td>
		<td colspan=3 class=inpReadOnlyRtTD><div>
			<label id=lblWageNo12_08 style="WIDTH: 100%"></label></div></td></tr>
  <tr class=rowDataEven>
		<td>
			<label class="lblInstrNormal">13.</label></td>
		<td colspan=16>
			<label class="lblInstrNormal" onclick=PreviousPaid() style="CURSOR: hand">
				Tax 
      previously paid for 2013 - <label style="FONT-WEIGHT: normal; COLOR: red">
						This amount may not yet include	your most recent payment.
						<br>Click on link for more information.</label></label></td>
		<td colspan=3 class=inpReadOnlyRtTD><div>
			<label id=lblWageNo13_08 style="WIDTH: 100%"></label>
			</div></td></tr>
  <tr class=rowDataOdd>
		<td>
			<label class="lblInstrNormal">14.</label></td>
		<td colspan=16>
			<label class="lblInstrNormal">ADDITIONAL TAX DUE If line 12 is greater than line 13,
				enter the amount here.</label></td>
		<td colspan=3 class=inpReadOnlyRtTD><div>
			<label id=lblWageNo14_08 style="WIDTH: 100%"></label>
			</div></td></tr>
  <tr class=rowDataEven>
		<td>
			<label class="lblInstrNormal">15.</label></td>
		<td colspan=16>
			<label class="lblInstrNormal">TAX OVERPAID If line 12 is less than line 13,
				enter the amount here. See instructions for filing a Refund Petition.</label></td>
		<td colspan=3 class=inpReadOnlyRtTD><div>
			<label id=lblWageNo15_08 style="WIDTH: 100%"></label></div></td></tr>
</table>

<table style="MARGIN-LEFT: 4%" border=0  width="90%">
	<tr>
		<td width ="80%">	
			  <%
                Html.RenderAction("PreparerSection", "INC");   
            %>
		</td>
		<td valign=bottom align=right>
			<p style="MARGIN-BOTTOM: 10px">
			<input id="btnWage08Print" type="button" value="Print" onclick="btnWage08Print_onclick()">&nbsp;&nbsp;
			<input id="btnWage08Submit" type="button" value="Submit" 
					onclick="btnWageValidate(); ispDisplayProgress('btnWage08Submit_onclick()',
					'Submitting 2012 wage tax information')">&nbsp;&nbsp;</p></td></tr>
  
	<TR>
		<td colspan=2><label class="lblTextBlack">
				Note: <b>DO NOT FILE THIS RETURN if you have no taxable activity. If you registered for this tax 
				and you no longer have taxable activity, complete a 
				<a href="http://www.phila.gov/revenue/Change_Form.pdf" target=_blank
				>Change Form<a> to cancel your account.</b></label></A></td>
	</TR>
</table>
</DIV>
</body>
</html>
