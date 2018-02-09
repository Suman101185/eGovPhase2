<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
<script id="clientEventHandlersJS" language="javascript" type="text/javascript">

    var arrNumWage05Err = new Array();
    var arrWage05Err = new Array();
    var txtHeader = 'Taxpayer Information';
    var dResTax_A, dResTax_B, dNonResTax_A, dNonResTax_B;

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

    function DisplayWage05Return() {
        if (parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, 'TAX_ACCT[ACCOUNT = "1"]', '', 0)) {
            parent.MenuWin.ispHighlightMenu($(parent.MenuWin.document).find('#mnuWageYear11').first().get(0));
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 'INQ', 'WAGE_INFO RETURN_STATUS', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ENTITY_ID', "", 0), 'WAGE_INFO ENTITY_ID', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ACCOUNT_ID', '', 0), 'WAGE_INFO ACCOUNT_ID', '', 0);
           
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, '12/31/2011', 'WAGE_INFO PERIOD', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, '', 'DEBUG', '', 0);
            ispCallXMLForm(parent.$g.xmlWage, parent.$g.xmlWage, "WageReturn", "");

            ispHideProgress();
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'ERROR_INFO ERROR', "", 0) != 0) {
                $(parent.RightFrame).attr("rows", "*,0");
                $('#WageReturn').css('display', 'block');
                $('#AppHeader').html(txtHeader + '<Font class=hdrMedium>|wage tax reconciliation return</Font>');
                PopulateWage05Header();
                FieldLock(true);
                $('#AppError').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'ERROR_INFO MESSAGE', "", 0));
                $('#btnWage05Submit').attr('disabled', 'disable');
                $('#chkAmended').attr('disabled', 'disable');
                return;
            } //if
            if ($(parent.MenuWin.document).find('#divAcctInfo').first().css('display') == 'none') {
                $(parent.MenuWin.document).find('#divAcctInfo').first().css('display', 'block');
                $(parent.MenuWin.document).find('#divAccount').first().css('display', 'none');
            } //if
        } else {
            parent.MenuWin.ispMenu_onclick($(parent.MenuWin.document).find('#mnuAcctInfo').first().get(0))
        } //if

        $(parent.RightFrame).attr("rows", "*,0");
        $('#WageReturn').css('display', 'block');

        $('#AppHeader').html(txtHeader + '<Font class=hdrMedium>|wage tax reconciliation return for 2011</Font>');
        parent.MenuWin.gsInstructionItem = '#WageReturn';
        $('#AppMessage').html(parent.MenuWin.gsInstructionText + '<BR>The Reconciliation of Wage Tax for 2011 is due February 28, 2012.');
        $('#InstructionText').html(' for Instructions on filing this return');

        LoadWage05Error();
        RightAlignText();
        CheckWage05XML();
        SetWage05Fields();
        PopulateWage05Header();
        PopulateWage05Data();
        $('#AppError').text('');

    } //DisplayWage05Return

    function SetWage05Fields() {
        FieldLock(false);
        $('#chkAmended').attr('disabled', 'disable');
        chkAgreement.checked = false;
        chkAmended.checked = false;

        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO VERSION', '', 0) != '') {
            $('#chkAmended').removeAttr('disabled');
            FieldLock(true);
        } //if
    } //SetWage05Fields

    function FieldLock(bDisabled) {
        if (bDisabled == true) {
            $('#txtWageNoA').attr('disabled', 'disable');
            $('#txtWageNoB').attr('disabled', 'disable');
            $('#txtWageNoC').attr('disabled', 'disable');
            $('#txtWageNoD').attr('disabled', 'disable');
            $('#txtWageNo1').attr('disabled', 'disable');
            $('#txtWageNo2').attr('disabled', 'disable');
            $('#lblWageNo3').attr('disabled', 'disable');
            $('#txtWageNo4').attr('disabled', 'disable');
            $('#lblWageNo5').attr('disabled', 'disable');
            $('#txtWageNo6').attr('disabled', 'disable');
            $('#lblWageNo7').attr('disabled', 'disable');
            $('#lblWageNo8').attr('disabled', 'disable');
            $('#lblWageNo9').attr('disabled', 'disable');
            $('#lblWageNo10').attr('disabled', 'disable');
            $('#lblWageNo11').attr('disabled', 'disable');
            $('#chkAgreement').attr('disabled', 'disable');
        } else {
            $('#txtWageNoA').removeAttr('disabled');
            $('#txtWageNoB').removeAttr('disabled');
            $('#txtWageNoC').removeAttr('disabled');
            $('#txtWageNoD').removeAttr('disabled');
            $('#txtWageNo1').removeAttr('disabled');
            $('#txtWageNo2').removeAttr('disabled');
            $('#lblWageNo3').removeAttr('disabled');
            $('#txtWageNo4').removeAttr('disabled');
            $('#lblWageNo5').removeAttr('disabled');
            $('#txtWageNo6').removeAttr('disabled');
            $('#lblWageNo7').removeAttr('disabled');
            $('#lblWageNo8').removeAttr('disabled');
            $('#lblWageNo9').removeAttr('disabled');
            $('#lblWageNo10').removeAttr('disabled');
            $('#lblWageNo11').removeAttr('disabled');
            $('#chkAgreement').removeAttr('disabled');
        }
        DisablePreparer(bDisabled);
    } //FieldLock

    function CheckWage05XML() {
        var bPeriodExist = true;
        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO PERIOD', '', 0) != '' && new Date(parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO PERIOD', '', 0)) < new Date('01/01/2011')) {
            bPeriodExist = false;
        } //if
        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO PERIOD', '', 0) == '') {
            bPeriodExist = false;
        } //if
        if (bPeriodExist == false) {
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, '', 'ERROR_INFO PROGRAM', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, '', 'ERROR_INFO ERROR', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, '', 'ERROR_INFO LINE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, '', 'ERROR_INFO MESSAGE', '', 0);

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, '12/31/2011', 'WAGE_INFO PERIOD', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, '', 'WAGE_INFO VERSION', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, '', 'WAGE_INFO DOCUMENT_CONTROL', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, '', 'WAGE_INFO SEQUENCE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, '', 'WAGE_INFO LAST_UPD_DATE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, '', 'WAGE_INFO RETURN_STATUS', '', 0);

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 0, 'WAGE_INFO NO_OF_RESIDENTS', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 0, 'WAGE_INFO NO_OF_NONRESIDENTS', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 0, 'WAGE_INFO TOTAL_EMPLOYEES', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 0, 'WAGE_INFO PHILA_EMPLOYEES', '', 0);
            ClearPreparerXML(parent.$g.xmlWage, 'WAGE_INFO')

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 0, 'AMT_INFO GROSS_COMP', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 0, 'AMT_INFO NON_TAXABLE_COMP', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 0, 'AMT_INFO NET_COMP', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 0, 'AMT_INFO RESIDENT_PAYROLL_A', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 0, 'AMT_INFO RESIDENT_TAX_DUE_A', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 0, 'AMT_INFO NON_RES_PAYROLL_A', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 0, 'AMT_INFO NON_RES_TAX_DUE_A', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 0, 'AMT_INFO TOTAL_GROSS_TAX_DUE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 0, 'AMT_INFO TAX_PAID', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 0, 'AMT_INFO TAX_DUE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 0, 'AMT_INFO TAX_OVERPAID', '', 0);
        } //if
    } //CheckWage05XML

    function PopulateWage05Header() {
        var addrIdx;
        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ENTITY_ID', '', 0) != '') {
            $('#lblAcctId').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ACCOUNT_ID', '', 0));
            $('#lblEntityId').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ENTITY_ID', '', 0));
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO TYPE', '', 0) == 1) {
                $('#lblEntityType').text('EIN:');
                $('#lblEntityId').text(' ' + $('#lblEntityId').text().substr(0, 2) + '-' + $('#lblEntityId').text().substr(2));
            } else {
                $('#lblEntityType').text('SSN:');
                $('#lblEntityId').text(' ' + $('#lblEntityId').text().substr(0, 3) + '-' + $('#lblEntityId').text().substr(3, 2) + '-' + $('#lblEntityId').text().substr(5));
            } //if
            addrIdx = LocatePrimaryAddr();
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS TRADE_NAME', '', addrIdx) != '') {
                $('#lblEntityName').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS TRADE_NAME', '', addrIdx));
            } else {
                $('#lblEntityName').text(AdjustNameDisplay(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS NAME', '', addrIdx)));
            } //if
            $('#lblAddress').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS1', '', addrIdx) + ' ' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS2', '', addrIdx) + ' ' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS CITY', '', addrIdx) + ' ' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS STATE', '', addrIdx) + ' ' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ZIP', '', addrIdx));
        } //if
    } //PopulateWage05Header

    function PopulateWage05Data() {

        dResTax_A = parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO RESTAX_A', '', 0);
        dNonResTax_A = parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO NONRESTAX_A', '', 0);

        txtWageNoA.value = parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO NO_OF_RESIDENTS', '', 0);
        txtWageNoB.value = parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO NO_OF_NONRESIDENTS', '', 0);
        txtWageNoC.value = parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO TOTAL_EMPLOYEES', '', 0);
        txtWageNoD.value = parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO PHILA_EMPLOYEES', '', 0);
        txtWageNo1.value = ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO GROSS_COMP', '', 0), 0);


        txtWageNo2.value = ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO NON_TAXABLE_COMP', '', 0), 0);
        $('#lblWageNo3').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO NET_COMP', '', 0), 0));
        txtWageNo4.value = ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO RESIDENT_PAYROLL_A', '', 0), 0);
        $('#lblWageNo5').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO RESIDENT_TAX_DUE_A', '', 0), 0));
        txtWageNo6.value = ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO NON_RES_PAYROLL_A', '', 0), 0);
        $('#lblWageNo7').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO NON_RES_TAX_DUE_A', '', 0), 0));
        $('#lblWageNo8').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO TOTAL_GROSS_TAX_DUE', '', 0), 0));
        $('#lblWageNo9').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO TAX_PAID', '', 0), 0));
        $('#lblWageNo10').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO TAX_DUE', '', 0), 0));
        $('#lblWageNo11').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO TAX_OVERPAID', '', 0), 0));
        PopulatePreparer(parent.$g.xmlWage, 'WAGE_INFO');
    } //PopulateWage05Data

    function PopulateWage05XML() {
        var d = new Date();
        var lYear = String(d.getFullYear());
        var lMonth = String(d.getMonth() + 1);
        lMonth = lMonth.length == 1 ? '0' + lMonth : lMonth;
        var lDate = String(d.getDate());
        lDate = lDate.length == 1 ? '0' + lDate : lDate;

        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, '', 'AMT_INFO POSTING_DATE', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, lMonth + '/' + lDate + '/' + lYear, 'AMT_INFO FILING_DATE', '', 0);

        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, txtWageNoA.value, 'WAGE_INFO NO_OF_RESIDENTS', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, txtWageNoB.value, 'WAGE_INFO NO_OF_NONRESIDENTS', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, txtWageNoC.value, 'WAGE_INFO TOTAL_EMPLOYEES', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, txtWageNoD.value, 'WAGE_INFO PHILA_EMPLOYEES', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, stripCurrency(txtWageNo1.value), 'AMT_INFO GROSS_COMP', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, stripCurrency(txtWageNo2.value), 'AMT_INFO NON_TAXABLE_COMP', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, stripCurrency($('#lblWageNo3').text()), 'AMT_INFO NET_COMP', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, stripCurrency(txtWageNo4.value), 'AMT_INFO RESIDENT_PAYROLL_A', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, stripCurrency($('#lblWageNo5').text()), 'AMT_INFO RESIDENT_TAX_DUE_A', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, stripCurrency(txtWageNo6.value), 'AMT_INFO NON_RES_PAYROLL_A', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, stripCurrency($('#lblWageNo7').text()), 'AMT_INFO NON_RES_TAX_DUE_A', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, stripCurrency($('#lblWageNo8').text()), 'AMT_INFO TOTAL_GROSS_TAX_DUE', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, stripCurrency($('#lblWageNo9').text()), 'AMT_INFO TAX_PAID', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, stripCurrency($('#lblWageNo10').text()), 'AMT_INFO TAX_DUE', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, stripCurrency($('#lblWageNo11').text()), 'AMT_INFO TAX_OVERPAID', '', 0);

        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, '', 'DEBUG', '', 0);
        PopulatePreparerXML(parent.$g.xmlWage, 'WAGE_INFO');
    } //PopulateWage05XML

    function RightAlignText() {
        var ObjSelected;
        $('#txtWageNoA').css('text-align', 'right');
        $('#txtWageNoB').css('text-align', 'right');
        $('#txtWageNoC').css('text-align', 'right');
        $('#txtWageNoD').css('text-align', 'right');
        $('#txtWageNo1').css('text-align', 'right');
        $('#txtWageNo2').css('text-align', 'right');
        $('#txtWageNo4').css('text-align', 'right');
        $('#txtWageNo6').css('text-align', 'right');
    } //RightAlignText

    function LoadWage05Error() {
        var i = 0;

        arrWage05Err[i++] = [txtWageNo1, 'txtWageNo1.value == ""', 'Answer Question 1'];
        arrWage05Err[i++] = [txtWageNo1, 'ispValue(txtWageNo1.value) == false', 'Value for Question 1 Number must be numeric'];
        arrWage05Err[i++] = [txtWageNo1, 'ispNegativeNumber(txtWageNo1.value) == false', 'Value for Question 1 must NOT be negative'];

        arrWage05Err[i++] = [txtWageNo2, 'txtWageNo2.value == ""', 'Answer Question 2'];
        arrWage05Err[i++] = [txtWageNo2, 'ispValue(txtWageNo2.value) == false', 'Value for Question 2 Number must be numeric'];
        arrWage05Err[i++] = [txtWageNo2, 'ispNegativeNumber(txtWageNo2.value) == false', 'Value for Question 2 must NOT be negative'];

        arrWage05Err[i++] = [txtWageNo4, 'txtWageNo4.value == ""', 'Answer Question 4'];
        arrWage05Err[i++] = [txtWageNo4, 'ispValue(txtWageNo4.value) == false', 'Value for Question 4 Number must be numeric'];
        arrWage05Err[i++] = [txtWageNo4, 'ispNegativeNumber(txtWageNo4.value) == false', 'Value for Question 4 must NOT be negative'];

        arrWage05Err[i++] = [txtWageNo6, 'txtWageNo6.value == ""', 'Answer Question 6'];
        arrWage05Err[i++] = [txtWageNo6, 'ispValue(txtWageNo6.value) == false', 'Value for Question 6 Number must be numeric'];
        arrWage05Err[i++] = [txtWageNo6, 'ispNegativeNumber(txtWageNo6.value) == false', 'Value for Question 6 must NOT be negative'];

        arrWage05Err[i++] = [chkAgreement, '(chkAgreement.checked) == false', 'Signature box must be checked before submitting the Wage Tax Form'];

        i = 0; //Reset
        arrNumWage05Err[i++] = [txtWageNoA, 'ispValue(txtWageNoA.value) == false', 'Value for Question A Number must be numeric'];
        arrNumWage05Err[i++] = [txtWageNoB, 'ispValue(txtWageNoB.value) == false', 'Value for Question B Number must be numeric'];
        arrNumWage05Err[i++] = [txtWageNoC, 'ispValue(txtWageNoC.value) == false', 'Value for Question C Number must be numeric'];
        arrNumWage05Err[i++] = [txtWageNoD, 'ispValue(txtWageNoD.value) == false', 'Value for Question D Number must be numeric'];
    } //LoadWage05Error

    function ValidateWage05Number() {
        var evt = window.event || arguments.callee.caller.arguments[0];
        var source = parent.MenuWin.getEventSource(evt);

        $('#AppError').text('');
        if (source != null && source.type != 'button') {
            if (source.value == '') {
                source.value = 0;
            }
        }

        $('#AppError').text(ispSetInputErr(arrNumWage05Err));

        if ($('#AppError').text() != '') {
            AppError.scrollIntoView(true);
        } else {
            $('#AppError').text(ValidatePreparer());
        } //if	
    } //ValidateWage05Number

    function ValidateWage05Prelim() {
        var evt = window.event || arguments.callee.caller.arguments[0];
        var source = parent.MenuWin.getEventSource(evt);

        var sId = source.id;

        var ObjSelected = source;

        $('#AppError').text('');

        if ($('#AppError').text() == '') {
            $('#txtWageNo1').attr('class', 'inpNormal');
            if (ObjSelected) {
                if (ObjSelected.type != 'button') {
                    ObjSelected.value = ispFormatMoney(ObjSelected.value, 0);
                }
            } //if
            $('#AppError').text(ispSetInputErr(arrWage05Err));

            if ($('#AppError').text() == '') {
                Calc1Minus2();
                TaxDueLine5(dResTax_A);
                TaxDueLine7(dNonResTax_A);
                TaxDueLine8();
                TaxDueLine10_11();
            } else {
                AppError.scrollIntoView(true);
            } //if
        } //if
    } //ValidateWage05Number

    function ValidateWage05Return() {
        var evt = window.event || arguments.callee.caller.arguments[0];
        var source = parent.MenuWin.getEventSource(evt);

        var sId = source.id;

        var ObjSelected = source;
        if ($('#AppError').text() == '') {
            $('#txtWageNo1').attr('class', 'inpNormal');
            if (ObjSelected) {
                if (ObjSelected.type != 'button') {
                    ObjSelected.value = ispFormatMoney(ObjSelected.value, 0);
                }
            } //if
            $('#AppError').text(ispSetInputErr(arrWage05Err));

            if ($('#AppError').text() == '') {
                Calc1Minus2();
                TaxDueLine5(dResTax_A);
                TaxDueLine7(dNonResTax_A);
                TaxDueLine8();
                TaxDueLine10_11();
                if ($('#AppError').text() == '') {
                    CalcGrossComp();
                } //if
                CheckLine4_6();
            } else {
                AppError.scrollIntoView(true);
            } //if
        } //if
    } //ValidateWage05Number

    function btnWage05Print_onclick() {

        $('#btnWage05Print').css('visibility', 'hidden');
        $('#btnWage05Submit').css('visibility', 'hidden');
        $('#AppError').text('');

        if ($('#txtWageNo1').is(':disabled') == true) {
            FieldLock(false);
            window.print();
            FieldLock(true);
        } else {
            window.print();
        } //if
        $('#btnWage05Print').css('visibility', 'visible');
        $('#btnWage05Submit').css('visibility', 'visible');
    } //btnWage05Print_onclick

    function test1() {
        $('#WageReturn').css('display', 'none');
        $('#divProcessing').css('display', 'block');
    }

    var tempXML = parent.$g.getXmlDocObj();

    function btnWage05Submit_onclick() {
        if ($('#AppError').text() == "") {
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, '', 'WAGE_INFO RETURN_STATUS', '', 0);
            PopulateWage05XML();
            ispCallXMLForm(parent.$g.xmlWage, tempXML, "WageReturn", "");
            ispHideProgress();
            if (parent.$x.ispXmlGetFieldVal(tempXML, 'ERROR_INFO PROGRAM', '', 0) == '') {
                parent.$g.xmlWage.loadXML(tempXML.xml);
                $('#WageReturn').css('display', 'none');
                DisplayWageThankYou();
            } else {
                $('#AppError').text(parent.$x.ispXmlGetFieldVal(tempXML, 'ERROR_INFO MESSAGE', '', 0));
            } //if
        } else {
            ispHideProgress();
        } //if
    } //btnWage05Submit_onclick

    function chkAgreement_onclick() {

        ValidateWage05Number();

        if ($('#AppError').text() == '') {
            ValidateWage05Return();
        } //if
    } //chkAgreement

    function chkAmended_onclick() {

        if (chkAmended.checked == true) {
            $('#btnWage05Submit').removeAttr('disabled');
            FieldLock(false);
            ClearPreparer();
        } else {
            $('#btnWage05Submit').attr('disabled', 'disable');
            chkAgreement.checked = false;
            FieldLock(true);
            PopulatePreparer(parent.$g.xmlWage, 'WAGE_INFO');
        } //if
    } //chkAmended_onclick

    function ReadOnlySetFocus() {
        var evt = window.event || arguments.callee.caller.arguments[0];
        var source = parent.MenuWin.getEventSource(evt);

        var sId = source.id;

        switch (sId) {
            case 'lblWageNo13':
                txtWageNo1.select();
            default:
        } //switch
    } //ReadOnlySetFocus

    function LocatePrimaryAddr() {
        var iMaxIdx = parent.$x.ispXmlGetRecCount(parent.$g.xmlAccount, 'NAME_ADDRESS', '');

        for (idx = 0; idx < iMaxIdx; i++) {
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS_TYPE', '', idx) == '60') {
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS RELATIONSHIP_CODE', '', idx) == '0') {
                    return idx;
                } //if
            } else {
                return 0;
            } //if
        } //for
    } //locatePrimaryAddr

    function PreviousPaid() {
        showModalDialog('HelpPreviousPaidTax.htm', 0, 'dialogWidth:420px;dialogHeight:325px;dialogLeft:550px;');
    }

    function CheckLine4_6() {
        if (parseCurrency($('#lblWageNo7').text()) != 0 || parseCurrency($('#lblWageNo8').text()) != 0 || parseCurrency($('#lblWageNo9').text()) != 0) {

            if ($('#AppError').text() == "") {
                $('#txtWageNo4').attr('class', 'inpNormal');
                $('txtWageNo6').attr('class', 'inpNormal');
                if (parseCurrency(txtWageNo4.value) == 0 && parseCurrency(txtWageNo6.value) == 0) {
                    $('#AppError').text("Line 4 or 6 can not equal 0");
                    $('#txtWageNo4').attr('class', 'inpError');
                    $('#txtWageNo6').attr('class', 'inpError');
                }
            }
        }
    }

    function Calc1Minus2() {
        if (txtWageNo1.value != "" && txtWageNo2.value != "") {
            $('#lblWageNo3').text(
            ispFormatMoney(parseCurrency(txtWageNo1.value) - parseCurrency(txtWageNo2.value), 0));
        }
    }

    function CalcGrossComp() {

        if (parseCurrency(txtWageNo1.value) != (parseCurrency(txtWageNo2.value) + parseCurrency(txtWageNo4.value) + parseCurrency(txtWageNo6.value))) {
            $('#txtWageNo1').attr('class', 'inpError');
            $('#AppError').text('Line 1 is not equal to the sum of lines 2,4 & 6');
            AppError.scrollIntoView(true);
        } else {
            $('#txtWageNo1').attr('class', 'inpNormal');
            $('#AppError').text('');
        }
    }

    function TaxDueLine5(dTax) {
        if (txtWageNo4.value != "") {
            $('#lblWageNo5').text(ispFormatMoney(parseCurrency(parseCurrency(txtWageNo4.value) * parseCurrency(dTax)), 0));
        }
    }

    function TaxDueLine7(dTax) {
        if (txtWageNo6.value != "") {
            $('#lblWageNo7').text(ispFormatMoney(parseCurrency(parseCurrency(txtWageNo6.value) * parseCurrency(dTax)), 0));
        }
    }

    function TaxDueLine8() {
        if ($('#lblWageNo5').text() != "" && $('#lblWageNo7').text() != "") {
            $('#lblWageNo8').text(
            ispFormatMoney(parseCurrency($('#lblWageNo5').text()) + parseCurrency($('#lblWageNo7').text()), 0));
        }
    }

    function TaxDueLine10_11() {

        if ($('#lblWageNo8').text() != "" && $('#lblWageNo9').text() != "") {
            if (parseCurrency($('#lblWageNo8').text()) > parseCurrency($('#lblWageNo9').text())) {
                $('#lblWageNo10').text(
                ispFormatMoney(parseCurrency($('#lblWageNo8').text()) - parseCurrency($('#lblWageNo9').text()), 0));
                $('#lblWageNo11').text(ispFormatMoney(0, 0));
            } else {
                $('#lblWageNo10').text(ispFormatMoney(0, 0));
                $('#lblWageNo11').text(
                ispFormatMoney(parseCurrency($('#lblWageNo9').text()) - parseCurrency($('#lblWageNo8').text()), 0));
            }
        }
    }

    function parseCurrency(value) {
        return ispRemoveMoney(value);
    }



</script>

    <title></title>
</head>
<body onload="ispDisplayProgress('DisplayWage05Return()','Retrieving 2011 wage tax information')">
    <div style="DISPLAY: block; VISIBILTY: visible" id="WageReturn" name="WageReturn">
        <!--<table width="90%" cellSpacing="0" cellPadding="0" border=0 style  ="MARGIN-LEFT: 4%">
  <tr align ="left">
    <td><label class="lblTextBlack">       
			The City of Philadelphia Annual Reconciliation of Wage Tax for 2011 is 
			due February 28, 2013.</label></td>
  </tr>
</table>	-->

        <table class="tblShowBorder" width="90%" bgcolor="whitesmoke" style="MARGIN-LEFT: 4%" border="0"
            cellspacing="0" cellpadding="0" id="TABLE1">
            <tr>
                <td width="2%"></td>
                <td width="8%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td colspan="2">
                    <label class="lblInstrNormal">Account Id:&nbsp;</label>
                </td>
                <td colspan="4">
                    <label id="lblAcctId" class="lblTextBlack"></label>
                </td>
                <td colspan="2" align="right">
                    <label id="lblEntityType" class="lblInstrNormal">EIN:&nbsp;</label></td>
                <td colspan="5">
                    <label id="lblEntityId" class="lblTextBlack"></label>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td colspan="2">
                    <label class="lblInstrNormal">Name:&nbsp;</label>
                </td>
                <td colspan="17">
                    <label id="lblEntityName" class="lblTextBlack"></label>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td colspan="2">
                    <label class="lblInstrNormal">Address:&nbsp;</label>
                </td>
                <td colspan="17">
                    <label id="lblAddress" class="lblTextBlack"></label>
                </td>
            </tr>
        </table>

        <table style="LEFT: 43px; MARGIN-LEFT: 4%; TOP: 205px" border="0" width="90%">
            <tr>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
            </tr>
            <tr>
                <td align="left" colspan="10" nowrap>
                    <input id="chkAmended" type="checkbox" onclick="chkAmended_onclick()">
                    <label class="lblTextBlacksmall">Check if amended return.</label></td>
            </tr>
        </table>

        <table class="tblShowBorder" cellspacing="0" cellpadding="0" border="0" style="MARGIN-LEFT: 4%" id="TABLE2" width="90%">
            <tr>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
            </tr>
            <tr class="rowDataEven">
                <td>
                    <label class="lblInstrNormal">A.</label></td>
                <td colspan="16">
                    <label class="lblInstrNormal">
                        Enter the number of Philadelphia Residents for whom 
				wage tax was remitted for the pay period including March 12, 2011.</label></td>
                <td colspan="3">
                    <input class="inpNormal" id="txtWageNoA" onchange="ValidateWage05Number()"
                        onfocus="ReadOnlySetFocus()" maxlength="10" style="WIDTH: 100%"></td>
            </tr>
            <tr class="rowDataOdd">
                <td>
                    <label class="lblInstrNormal" style="vAlign: TOP">B.</label></td>
                <td colspan="16">
                    <label class="lblInstrNormal">
                        Enter the number of non-residents (employees living 
				outside Philadelphia city limits) for whom wage tax was remitted for pay 
				period including March 12, 2011.</label>
                </td>
                <td colspan="3">
                    <input class="inpNormal" id="txtWageNoB" onchange="ValidateWage05Number()"
                        onfocus="ReadOnlySetFocus()" maxlength="10" style="WIDTH: 100%"></td>
            </tr>
            <tr class="rowDataEven">
                <td>
                    <label class="lblInstrNormal">C.</label></td>
                <td colspan="16">
                    <label class="lblInstrNormal">
                        Total number of employees for all company locations
				reported on the Employer's Federal Quarterly Tax Return for the first 
				quarter of 2011 (for the pay period including March 12, 2011).</label></td>
                <td colspan="3">
                    <input class="inpNormal" id="txtWageNoC" onchange="ValidateWage05Number()"
                        onfocus="ReadOnlySetFocus()" maxlength="10" style="WIDTH: 100%"></td>
            </tr>
            <tr class="rowDataOdd">
                <td>
                    <label class="lblInstrNormal">D.</label></td>
                <td colspan="16">
                    <label class="lblInstrNormal">
                        Number of employees working at company locations within
				Philadelphia city limits, for the pay period including March 12, 2011.</label></td>
                <td colspan="3">
                    <input class="inpNormal" id="txtWageNoD" onchange="ValidateWage05Number()"
                        onfocus="ReadOnlySetFocus()" maxlength="10" style="WIDTH: 100%"></td>
            </tr>
            <tr class="rowDataEven">
                <td>
                    <label class="lblInstrNormal">1.</label></td>
                <td colspan="16">
                    <label class="lblInstrNormal">Gross Compensation per W-2 forms for all employees</label></td>
                <td colspan="3">
                    <input class="inpNormal" id="txtWageNo1" onchange="ValidateWage05Prelim()"
                        onfocus="ReadOnlySetFocus()" maxlength="20" style="WIDTH: 100%"></td>
            </tr>
            <tr class="rowDataOdd">
                <td>
                    <label class="lblInstrNormal">2.</label></td>
                <td colspan="16">
                    <label class="lblInstrNormal">
                        Non-Taxable Compensation include in line 1
				(Paid to non-residents working outside of Philadelphia)</label></td>
                <td colspan="3">
                    <input class="inpNormal" id="txtWageNo2" onchange="ValidateWage05Prelim()"
                        onfocus="ReadOnlySetFocus()" maxlength="20" style="WIDTH: 100%"></td>
            </tr>
            <tr class="rowDataEven">
                <td>
                    <label class="lblInstrNormal">3.</label></td>
                <td colspan="10">
                    <label class="lblInstrNormal">
                        Gross Compensation per W-2 forms on 
				which Philadelphia Wage Tax was withheld or due</label></td>
                <td colspan="6" align="right">
                    <label class="lblInstrNormal">[Calculated - line 1 less line 2]</label></td>
                <td colspan="3" class="inpReadOnlyRtTD">
                    <div>
                        <label id="lblWageNo3" style="WIDTH: 100%"></label>
                    </div>
                </td>
            </tr>
            <tr class="rowDataOdd">
                <td>
                    <label class="lblInstrNormal">4.</label></td>
                <td colspan="16">
                    <label class="lblInstrNormal">
                        Total Taxable Compensation paid to residents of 
				Philadelphia in 2011</label></td>
                <td colspan="3">
                    <input class="inpNormal" id="txtWageNo4" onchange="ValidateWage05Prelim()"
                        onfocus="ReadOnlySetFocus()" maxlength="20" style="WIDTH: 100%"></td>
            </tr>
            <tr class="rowDataEven">
                <td>
                    <label class="lblInstrNormal">5.</label></td>
                <td colspan="8">
                    <label class="lblInstrNormal">Tax Due</label></td>
                <td colspan="8" align="right">
                    <label class="lblInstrNormal">[Calculated - line 4 X .03928]</label></td>
                <td colspan="3" class="inpReadOnlyRtTD">
                    <div>
                        <label id="lblWageNo5" style="WIDTH: 100%"></label>
                    </div>
                </td>
            </tr>
            <tr class="rowDataOdd">
                <td>
                    <label class="lblInstrNormal">6.</label></td>
                <td colspan="16">
                    <label class="lblInstrNormal">
                        Total Taxable Compensation paid to non-residents of 
				Philadelphia in 2011</label></td>
                <td colspan="3">
                    <input class="inpNormal" id="txtWageNo6" onchange="ValidateWage05Prelim()"
                        onfocus="ReadOnlySetFocus()" maxlength="20" style="WIDTH: 100%"></td>
            </tr>
            <tr class="rowDataEven">
                <td>
                    <label class="lblInstrNormal">7.</label></td>
                <td colspan="8">
                    <label class="lblInstrNormal">Tax Due</label></td>
                <td colspan="8" align="right">
                    <label class="lblInstrNormal">[Calculated - line 6 X .034985]</label></td>
                <td colspan="3" class="inpReadOnlyRtTD">
                    <div>
                        <label id="lblWageNo7" style="WIDTH: 100%"></label>
                    </div>
                </td>
            </tr>
            <tr class="rowDataOdd">
                <td>
                    <label class="lblInstrNormal">8.</label></td>
                <td colspan="8">
                    <label class="lblInstrNormal"><b>Total Tax Due</b></label></td>
                <td colspan="8" align="right">
                    <label class="lblInstrNormal">[Calculated - lines 5 and 7]</label></td>
                <td colspan="3" class="inpReadOnlyRtTD">
                    <div>
                        <label id="lblWageNo8" style="WIDTH: 100%"></label>
                    </div>
                </td>
            </tr>
            <tr class="rowDataEven">
                <td>
                    <label class="lblInstrNormal">9.</label></td>
                <td colspan="16">
                    <label class="lblInstrNormal" onclick="PreviousPaid()" style="CURSOR: hand">
                        Tax previously paid for 2011 -
                        <label style="FONT-WEIGHT: normal; COLOR: red">
                            This amount may not yet include	your most recent payment.
						<br>
                            Click on link for more information.</label></label></td>
                <td colspan="3" class="inpReadOnlyRtTD">
                    <div>
                        <label id="lblWageNo9" style="WIDTH: 100%"></label>
                    </div>
                </td>
            </tr>
            <tr class="rowDataOdd">
                <td>
                    <label class="lblInstrNormal">10.</label></td>
                <td colspan="16">
                    <label class="lblInstrNormal">
                        <b>ADDITIONAL TAX DUE</b> If line 8 is greater than line 9,
				enter the amount here</label></td>
                <td colspan="3" class="inpReadOnlyRtTD">
                    <div>
                        <label id="lblWageNo10" style="WIDTH: 100%"></label>
                    </div>
                </td>
            </tr>
            <tr class="rowDataEven">
                <td>
                    <label class="lblInstrNormal">11.</label></td>
                <td colspan="16">
                    <label class="lblInstrNormal">
                        <b>TAX OVERPAID</b> If line 9 is less than line 8,
				enter the amount here.</label></td>
                <td colspan="3" class="inpReadOnlyRtTD">
                    <div>
                        <label id="lblWageNo11" style="WIDTH: 100%"></label>
                    </div>
                </td>
            </tr>
        </table>

        <table style="MARGIN-LEFT: 4%" border="0" width="90%">
            <tr>
                <td width="80%">

                    <%
                        Html.RenderAction("PreparerSection", "INC");   
                    %>
                </td>
                <td valign="bottom" align="right">
                    <p style="MARGIN-TOP: 10px">
                        <input id="btnWage05Print" type="button" value="Print" onclick="btnWage05Print_onclick()">&nbsp;&nbsp;
			<input id="btnWage05Submit" type="button" value="Submit"
                onclick="ValidateWage05Number(); ValidateWage05Return();
    ispDisplayProgress('btnWage05Submit_onclick()', 'Submitting 2011 wage tax information')">&nbsp;&nbsp;
                    </p>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <label class="lblTextBlack">
                        Note: <b>DO NOT FILE THIS RETURN if you have no taxable activity. If you registered for 
				this tax and you no longer have taxable activity, complete a 
				<a href="http://www.phila.gov/revenue/Change_Form.pdf" target="_blank">Change Form<a> to cancel
				your account.</b></label></td>
            </tr>

        </table>
    </div>
</body>
</html>
