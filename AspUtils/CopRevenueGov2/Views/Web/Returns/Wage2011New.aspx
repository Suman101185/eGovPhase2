<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
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

        var arrNumWage05Err = new Array();
        var arrWage05Err = new Array();
        var txtHeader = 'Taxpayer Information';
        var dResTax_A, dResTax_B, dNonResTax_A, dNonResTax_B;
        $(document).ready(function () {

            var txtWageNoA = document.getElementById('txtWageNoA');
            var txtWageNoB = document.getElementById('txtWageNoB');
            var txtWageNoC = document.getElementById('txtWageNoC');
            var txtWageNoD = document.getElementById('txtWageNoD');
            var txtWageNo1 = document.getElementById('txtWageNo1');
            var txtWageNo2 = document.getElementById('txtWageNo2');
            var txtWageNo3 = document.getElementById('txtWageNo3');
            var txtWageNo4 = document.getElementById('txtWageNo4');
            var txtWageNo5 = document.getElementById('txtWageNo5');
            var txtWageNo6 = document.getElementById('txtWageNo6');
            var lblWageNo7 = document.getElementById('lblWageNo7');
            var lblWageNo8 = document.getElementById('lblWageNo8');
            var lblWageNo9 = document.getElementById('lblWageNo9');
            var lblWageNo10 = document.getElementById('lblWageNo10');
            var lblWageNo11 = document.getElementById('lblWageNo11');

            DisplayWage05Return();
        });
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
            var txtWageNoA = document.getElementById('txtWageNoA');
            var txtWageNoB = document.getElementById('txtWageNoB');
            var txtWageNoC = document.getElementById('txtWageNoC');
            var txtWageNoD = document.getElementById('txtWageNoD');
            var txtWageNo1 = document.getElementById('txtWageNo1');
            var txtWageNo2 = document.getElementById('txtWageNo2');
            var txtWageNo3 = document.getElementById('txtWageNo3');
            var txtWageNo4 = document.getElementById('txtWageNo4');
            var txtWageNo5 = document.getElementById('txtWageNo5');
            var txtWageNo6 = document.getElementById('txtWageNo6');
            var lblWageNo7 = document.getElementById('lblWageNo7');
            var lblWageNo8 = document.getElementById('lblWageNo8');
            var lblWageNo9 = document.getElementById('lblWageNo9');
            var lblWageNo10 = document.getElementById('lblWageNo10');
            var lblWageNo11 = document.getElementById('lblWageNo11');

            if (parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, 'TAX_ACCT[ACCOUNT = "1"]', '', 0)) {
                //  parent.MenuWin.ispHighlightMenu($(parent.MenuWin.document).find('#mnuWageYear11').first().get(0));
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
                    $(parent.AppError).text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'ERROR_INFO MESSAGE', "", 0));
                    $('#btnWage05Submit').attr('disabled', 'disable');
                    $('#chkAmended').attr('disabled', 'disable');
                    return;
                } //if
                if ($(parent.divAcctInfo).css("display") == 'none') {
                    $(parent.divAcctInfo).css("display", "block");
                    $(parent.divAccount).css("display", "none");
                } //if
            } else {
                parent.ispMenu_onclick(parent.mnuAcctInfo);
            } //if

            $(parent.RightFrame).attr("rows", "*,0");
            $('#WageReturn').css('display', 'block');

            $('#AppHeader').html(txtHeader + '<Font class=hdrMedium>|wage tax reconciliation return for 2011</Font>');
            parent.gsInstructionItem = '#WageReturn';
            $('#AppMessage').html(parent.gsInstructionText + '<BR>The Reconciliation of Wage Tax for 2011 is due February 28, 2012.');
            $('#InstructionText').html(' for Instructions on filing this return');

            LoadWage05Error();
            RightAlignText();
            CheckWage05XML();
            SetWage05Fields();
            PopulateWage05Header();
            PopulateWage05Data();
            $(parent.AppError).text('');

        } //DisplayWage05Return

        function SetWage05Fields() {

            var chkAmended = document.getElementById('chkAmended');
            var chkAgreement = document.getElementById('chkAgreement');
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

            var txtWageNoA = document.getElementById('txtWageNoA');
            var txtWageNoB = document.getElementById('txtWageNoB');
            var txtWageNoC = document.getElementById('txtWageNoC');
            var txtWageNoD = document.getElementById('txtWageNoD');
            var txtWageNo1 = document.getElementById('txtWageNo1');
            var txtWageNo2 = document.getElementById('txtWageNo2');
            var txtWageNo3 = document.getElementById('txtWageNo3');
            var txtWageNo4 = document.getElementById('txtWageNo4');
            var txtWageNo5 = document.getElementById('txtWageNo5');
            var txtWageNo6 = document.getElementById('txtWageNo6');
            var lblWageNo7 = document.getElementById('lblWageNo7');
            var lblWageNo8 = document.getElementById('lblWageNo8');
            var lblWageNo9 = document.getElementById('lblWageNo9');
            var lblWageNo10 = document.getElementById('lblWageNo10');
            var lblWageNo11 = document.getElementById('lblWageNo11');

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

            var txtWageNoA = document.getElementById('txtWageNoA');
            var txtWageNoB = document.getElementById('txtWageNoB');
            var txtWageNoC = document.getElementById('txtWageNoC');
            var txtWageNoD = document.getElementById('txtWageNoD');
            var txtWageNo1 = document.getElementById('txtWageNo1');
            var txtWageNo2 = document.getElementById('txtWageNo2');
            var txtWageNo3 = document.getElementById('txtWageNo3');
            var txtWageNo4 = document.getElementById('txtWageNo4');
            var txtWageNo5 = document.getElementById('txtWageNo5');
            var txtWageNo6 = document.getElementById('txtWageNo6');
            var lblWageNo7 = document.getElementById('lblWageNo7');
            var lblWageNo8 = document.getElementById('lblWageNo8');
            var lblWageNo9 = document.getElementById('lblWageNo9');
            var lblWageNo10 = document.getElementById('lblWageNo10');
            var lblWageNo11 = document.getElementById('lblWageNo11');

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

            var txtWageNoA = document.getElementById('txtWageNoA');
            var txtWageNoB = document.getElementById('txtWageNoB');
            var txtWageNoC = document.getElementById('txtWageNoC');
            var txtWageNoD = document.getElementById('txtWageNoD');
            var txtWageNo1 = document.getElementById('txtWageNo1');
            var txtWageNo2 = document.getElementById('txtWageNo2');
            var txtWageNo3 = document.getElementById('txtWageNo3');
            var txtWageNo4 = document.getElementById('txtWageNo4');
            var txtWageNo5 = document.getElementById('txtWageNo5');
            var txtWageNo6 = document.getElementById('txtWageNo6');
            var lblWageNo7 = document.getElementById('lblWageNo7');
            var lblWageNo8 = document.getElementById('lblWageNo8');
            var lblWageNo9 = document.getElementById('lblWageNo9');
            var lblWageNo10 = document.getElementById('lblWageNo10');
            var lblWageNo11 = document.getElementById('lblWageNo11');

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

            var txtWageNoA = document.getElementById('txtWageNoA');
            var txtWageNoB = document.getElementById('txtWageNoB');
            var txtWageNoC = document.getElementById('txtWageNoC');
            var txtWageNoD = document.getElementById('txtWageNoD');
            var txtWageNo1 = document.getElementById('txtWageNo1');
            var txtWageNo2 = document.getElementById('txtWageNo2');
            var txtWageNo3 = document.getElementById('txtWageNo3');
            var txtWageNo4 = document.getElementById('txtWageNo4');
            var txtWageNo5 = document.getElementById('txtWageNo5');
            var txtWageNo6 = document.getElementById('txtWageNo6');
            var lblWageNo7 = document.getElementById('lblWageNo7');
            var lblWageNo8 = document.getElementById('lblWageNo8');
            var lblWageNo9 = document.getElementById('lblWageNo9');
            var lblWageNo10 = document.getElementById('lblWageNo10');
            var lblWageNo11 = document.getElementById('lblWageNo11');
            var chkAgreement = document.getElementById('chkAgreement');
            var i = 0;

            arrWage05Err[i++] = [txtWageNo1, txtWageNo1.value == "", 'Answer Question 1'];
            arrWage05Err[i++] = [txtWageNo1, ispValue(txtWageNo1.value) == false, 'Value for Question 1 Number must be numeric'];
            arrWage05Err[i++] = [txtWageNo1, ispNegativeNumber(txtWageNo1.value) == false, 'Value for Question 1 must NOT be negative'];

            arrWage05Err[i++] = [txtWageNo2, txtWageNo2.value == "", 'Answer Question 2'];
            arrWage05Err[i++] = [txtWageNo2, ispValue(txtWageNo2.value) == false, 'Value for Question 2 Number must be numeric'];
            arrWage05Err[i++] = [txtWageNo2, ispNegativeNumber(txtWageNo2.value) == false, 'Value for Question 2 must NOT be negative'];

            arrWage05Err[i++] = [txtWageNo4, txtWageNo4.value == "", 'Answer Question 4'];
            arrWage05Err[i++] = [txtWageNo4, ispValue(txtWageNo4.value) == false, 'Value for Question 4 Number must be numeric'];
            arrWage05Err[i++] = [txtWageNo4, ispNegativeNumber(txtWageNo4.value) == false, 'Value for Question 4 must NOT be negative'];

            arrWage05Err[i++] = [txtWageNo6, txtWageNo6.value == "", 'Answer Question 6'];
            arrWage05Err[i++] = [txtWageNo6, ispValue(txtWageNo6.value) == false, 'Value for Question 6 Number must be numeric'];
            arrWage05Err[i++] = [txtWageNo6, ispNegativeNumber(txtWageNo6.value) == false, 'Value for Question 6 must NOT be negative'];

            arrWage05Err[i++] = [chkAgreement, (chkAgreement.checked) == false, 'Signature box must be checked before submitting the Wage Tax Form'];

            i = 0; //Reset
            arrNumWage05Err[i++] = [txtWageNoA, ispValue(txtWageNoA.value) == false, 'Value for Question A Number must be numeric'];
            arrNumWage05Err[i++] = [txtWageNoB, ispValue(txtWageNoB.value) == false, 'Value for Question B Number must be numeric'];
            arrNumWage05Err[i++] = [txtWageNoC, ispValue(txtWageNoC.value) == false, 'Value for Question C Number must be numeric'];
            arrNumWage05Err[i++] = [txtWageNoD, ispValue(txtWageNoD.value) == false, 'Value for Question D Number must be numeric'];
        } //LoadWage05Error

        function ValidateWage05Number() {
            var evt = window.event || arguments.callee.caller.arguments[0];
            var source = parent.getEventSource(evt);

            $(parent.AppError).text('');
            if (source != null && source.type != 'button') {
                if (source.value == '') {
                    source.value = 0;
                }
            }

            $(parent.AppError).text(ispSetInputErr(arrNumWage05Err));

            if ($(parent.AppError).text() != '') {
                // $(parent.AppError).scrollIntoView(true);
            } else {
                $(parent.AppError).text(ValidatePreparer());
            } //if	
        } //ValidateWage05Number

        function ValidateWage05Prelim() {
            var evt = window.event || arguments.callee.caller.arguments[0];
            var source = parent.getEventSource(evt);

            var sId = source.id;

            var ObjSelected = source;

            $(parent.AppError).text('');

            if ($(parent.AppError).text() == '') {
                $('#txtWageNo1').attr('class', 'inpNormal');
                if (ObjSelected) {
                    if (ObjSelected.type != 'button') {
                        ObjSelected.value = ispFormatMoney(ObjSelected.value, 0);
                    }
                } //if
                $(parent.AppError).text(ispSetInputErr(arrWage05Err));

                if ($(parent.AppError).text() == '') {
                    Calc1Minus2();
                    TaxDueLine5(dResTax_A);
                    TaxDueLine7(dNonResTax_A);
                    TaxDueLine8();
                    TaxDueLine10_11();
                } else {
                    // $(parent.AppError).scrollIntoView(true);
                } //if
            } //if
        } //ValidateWage05Number

        function ValidateWage05Return() {
            var evt = window.event || arguments.callee.caller.arguments[0];
            var source = parent.getEventSource(evt);

            var sId = source.id;

            var ObjSelected = source;
            if ($(parent.AppError).text() == '') {
                $('#txtWageNo1').attr('class', 'inpNormal');
                if (ObjSelected) {
                    if (ObjSelected.type != 'button') {
                        ObjSelected.value = ispFormatMoney(ObjSelected.value, 0);
                    }
                } //if
                $(parent.AppError).text(ispSetInputErr(arrWage05Err));

                if ($(parent.AppError).text() == '') {
                    Calc1Minus2();
                    TaxDueLine5(dResTax_A);
                    TaxDueLine7(dNonResTax_A);
                    TaxDueLine8();
                    TaxDueLine10_11();
                    if ($(parent.AppError).text() == '') {
                        CalcGrossComp();
                    } //if
                    CheckLine4_6();
                } else {
                    //$(parent.AppError).scrollIntoView(true);
                } //if
            } //if
        } //ValidateWage05Number

        function btnWage05Print_onclick() {

            $('#btnWage05Print').css('visibility', 'hidden');
            $('#btnWage05Submit').css('visibility', 'hidden');
            $(parent.AppError).text('');

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
            if ($(parent.AppError).text() == "") {
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, '', 'WAGE_INFO RETURN_STATUS', '', 0);
                PopulateWage05XML();
                ispCallXMLForm(parent.$g.xmlWage, tempXML, "WageReturn", "");
                ispHideProgress();
                if (parent.$x.ispXmlGetFieldVal(tempXML, 'ERROR_INFO PROGRAM', '', 0) == '') {
                    parent.$g.xmlWage.loadXML(tempXML.xml);
                    $('#WageReturn').css('display', 'none');
                    DisplayWageThankYou();
                } else {
                    $(parent.AppError).text(parent.$x.ispXmlGetFieldVal(tempXML, 'ERROR_INFO MESSAGE', '', 0));
                } //if
            } else {
                ispHideProgress();
            } //if
        } //btnWage05Submit_onclick

        function chkAgreement_onclick() {

            ValidateWage05Number();

            if ($(parent.AppError).text() == '') {
                ValidateWage05Return();
            } //if
        } //chkAgreement

        function chkAmended_onclick() {

            var chkAgreement = document.getElementById('chkAgreement');
            var chkAmended = document.getElementById('chkAmended');
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
            var txtWageNo1 = document.getElementById('txtWageNo1');
            var evt = window.event || arguments.callee.caller.arguments[0];
            var source = parent.getEventSource(evt);

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
            var txtWageNo4 = document.getElementById('txtWageNo4');
            var txtWageNo6 = document.getElementById('txtWageNo6');

            if (parseCurrency($('#lblWageNo7').text()) != 0 || parseCurrency($('#lblWageNo8').text()) != 0 || parseCurrency($('#lblWageNo9').text()) != 0) {

                if ($(parent.AppError).text() == "") {
                    $('#txtWageNo4').attr('class', 'inpNormal');
                    $('txtWageNo6').attr('class', 'inpNormal');
                    if (parseCurrency(txtWageNo4.value) == 0 && parseCurrency(txtWageNo6.value) == 0) {
                        $(parent.AppError).text("Line 4 or 6 can not equal 0");
                        $('#txtWageNo4').attr('class', 'inpError');
                        $('#txtWageNo6').attr('class', 'inpError');
                    }
                }
            }
        }

        function Calc1Minus2() {
            var txtWageNo1 = document.getElementById('txtWageNo1');
            var txtWageNo2 = document.getElementById('txtWageNo2');
            if (txtWageNo1.value != "" && txtWageNo2.value != "") {
                $('#lblWageNo3').text(
                ispFormatMoney(parseCurrency(txtWageNo1.value) - parseCurrency(txtWageNo2.value), 0));
            }
        }

        function CalcGrossComp() {
            var txtWageNo1 = document.getElementById('txtWageNo1');
            var txtWageNo2 = document.getElementById('txtWageNo2');
            var txtWageNo4 = document.getElementById('txtWageNo4');

            if (parseCurrency(txtWageNo1.value) != (parseCurrency(txtWageNo2.value) + parseCurrency(txtWageNo4.value) + parseCurrency(txtWageNo6.value))) {
                $('#txtWageNo1').attr('class', 'inpError');
                $(parent.AppError).text('Line 1 is not equal to the sum of lines 2,4 & 6');
                // $(parent.AppError).scrollIntoView(true);
            } else {
                $('#txtWageNo1').attr('class', 'inpNormal');
                $(parent.AppError).text('');
            }
        }

        function TaxDueLine5(dTax) {
            var txtWageNo4 = document.getElementById('txtWageNo4');

            if (txtWageNo4.value != "") {
                $('#lblWageNo5').text(ispFormatMoney(parseCurrency(parseCurrency(txtWageNo4.value) * parseCurrency(dTax)), 0));
            }
        }

        function TaxDueLine7(dTax) {

            var txtWageNo6 = document.getElementById('txtWageNo6');
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
<body>
    <div class="container-fluid no-padding" id="WageReturn">

        <div class="block3">

            <div class="container-fluid">

                <div class="row">

                    <div class="col-lg-12 col-md-12" style="display: block;" id="tab1">

                        <div class="blue_base_box">
                            <h2><span id="AppHeader">&nbsp;</span>  </h2>

                            <div class="inner_white-panel">

                                <div class="contentsection">
                                    <h4 id="AppMessage">&nbsp;</h4>

                                    <div class="clearfix"></div>

                                    <br>

                                    <div class="row">

                                        <div class="col-lg-12">
                                            <div class="well">

                                                <div class="row">
                                                    <form>
                                                        <div class="col-lg-4">
                                                            <p>
                                                                <strong>Account Id :</strong>
                                                                <label id="lblAcctId" class="lblTextBlack"></label>
                                                            </p>
                                                        </div>

                                                        <div class="col-lg-4">
                                                            <p>
                                                                <strong><font id="lblEntityType">EIN :</font></strong>
                                                                <label id="lblEntityId" class="lblTextBlack"></label>
                                                            </p>
                                                        </div>

                                                    </form>
                                                </div>

                                                <div class="row">
                                                    <div class="col-lg-4">
                                                        <p>
                                                            <strong>Name :</strong>
                                                            <label id="lblEntityName" class="lblTextBlack"></label>
                                                        </p>
                                                    </div>
                                                    <div class="col-lg-4">
                                                        <p>
                                                            <strong>Address :</strong>
                                                            <label id="lblAddress" class="lblTextBlack"></label>
                                                        </p>
                                                    </div>

                                                </div>
                                                <div class="clearfix"></div>

                                            </div>

                                            <div class="row">
                                                <div class="col-sm-3">
                                                    <label style="font-weight: bold;">
                                                        <input id="chkAmended" type="checkbox" onclick="chkAmended_onclick()" type="checkbox" />
                                                        Check if amended return.</label>
                                                </div>
                                                <div class="col-sm-6">
                                                    <label class="" style="color: Red; width: 100%">All decimals will be rounded to the nearest whole number</label></div>
                                                <div class="col-sm-3"></div>
                                            </div>

                                            
                                                <div class="row ">

                                                    <div class="col-lg-12 templateclass">
                                                    <!-- Return Form -->
                                                    
                                                        <div class="table-responsive">
                                                            <table class="table table-condensed table-striped custom_table03">
                                                                <tbody>
                                                                </tbody>
                                                                <tbody>
                                                                    <tr>
                                                                        <td class="text-left"><span><strong>A.</strong></span> &nbsp; Enter the number of Philadelphia Residents for whom 
				wage tax was remitted for the pay period including March 12, 2011. </td>
                                                                        <td width="25%">
                                                                            <form class="form-horizontal">
                                                                                <div class="form-group no-margin">
                                                                                    <div class="">
                                                                                        <input type="text" id="txtWageNoA" class="form-control input-sm" onchange="ValidateWage05Number()" onfocus="ReadOnlySetFocus()" maxlength="10" style="width: 100%" />
                                                                                    </div>
                                                                                </div>
                                                                            </form>
                                                                        </td>
                                                                    </tr>
                                                                    <tr class="odd">
                                                                        <td class="text-left"><span><strong>B</strong></span> &nbsp; Enter the number of <strong>nonresidents</strong> (employees living 
				outside Philadelphia city limits) for whom wage tax was remitted for the pay period
				including March 12, 2011. </td>
                                                                        <td width="25%">
                                                                            <form class="form-horizontal">
                                                                                <div class="form-group no-margin">
                                                                                    <div class="">
                                                                                        <input class="form-control input-sm" id="txtWageNoB" onchange="ValidateWage05Number()"
                                                                                            onfocus="ReadOnlySetFocus()" maxlength="10" style="width: 100%">
                                                                                    </div>
                                                                                </div>
                                                                            </form>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="text-left"><span><strong>C.</strong></span> &nbsp; Total number of employees <strong>for all company locations</strong>
                                                                            reported on the Employer's Federal Quarterly Tax Return for the first 
				quarter of 2011 (for the pay period including March 12, 2011). </td>
                                                                        <td width="25%">
                                                                            <form class="form-horizontal">
                                                                                <div class="form-group no-margin">
                                                                                    <div class="">
                                                                                        <input class="form-control input-sm" id="txtWageNoC" onchange="ValidateWage05Number()"
                                                                                            onfocus="ReadOnlySetFocus()" maxlength="10" style="width: 100%">
                                                                                    </div>
                                                                                </div>
                                                                            </form>
                                                                        </td>
                                                                    </tr>
                                                                    <tr class="odd">
                                                                        <td class="text-left"><span><strong>D.</strong></span> &nbsp; Number of employees working <strong>at company locations within
				Philadelphia city limits</strong>, for the pay period including March 12, 2011.</td>
                                                                        <td width="25%">
                                                                            <form class="form-horizontal">
                                                                                <div class="form-group no-margin">
                                                                                    <div class="">
                                                                                        <input class="form-control input-sm" id="txtWageNoD" onchange="ValidateWage05Number()"
                                                                                            onfocus="ReadOnlySetFocus()" maxlength="10" style="width: 100%">
                                                                                    </div>
                                                                                </div>
                                                                            </form>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="text-left"><span><strong>1.</strong></span> &nbsp; Gross Compensation per W-2 forms for all employees</td>
                                                                        <td width="25%">
                                                                            <form class="form-horizontal">
                                                                                <div class="form-group no-margin">
                                                                                    <div class="">
                                                                                        <input class="form-control input-sm" id="txtWageNo1" onchange="ValidateWage05Prelim()"
                                                                                            onfocus="ReadOnlySetFocus()" maxlength="20" style="width: 100%">
                                                                                    </div>
                                                                                </div>
                                                                            </form>
                                                                        </td>
                                                                    </tr>
                                                                    <tr class="odd">
                                                                        <td class="text-left"><span><strong>2.</strong></span> &nbsp; Non-Taxable Gross Compensation include in line 1
				(Paid to non-residents working outside of Philadelphia)</td>
                                                                        <td width="25%">
                                                                            <form class="form-horizontal">
                                                                                <div class="form-group no-margin">
                                                                                    <div class="">
                                                                                        <input class="form-control input-sm" id="txtWageNo2" onchange="ValidateWage05Prelim()"
                                                                                            onfocus="ReadOnlySetFocus()" maxlength="20" style="width: 100%">
                                                                                    </div>
                                                                                </div>
                                                                            </form>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="text-left"><span><strong>3.</strong></span> &nbsp; Gross Compensation per W-2 forms on 
				which Philadelphia Wage Tax was withheld or due[Calculated - line 1 less line 2] </td>
                                                                        <td width="25%">
                                                                            <form class="form-horizontal">
                                                                                <div class="form-group no-margin">
                                                                                    <div class="">
                                                                                        <label id="lblWageNo3" style="width: 100%" class="form-control input-sm"></label>
                                                                                    </div>
                                                                                </div>
                                                                            </form>
                                                                        </td>
                                                                    </tr>
                                                                    <tr class="odd">
                                                                        <td class="text-left"><span><strong>4.</strong></span> &nbsp; Total Taxable Compensation paid to residents of Philadelphia in 2011</td>
                                                                        <td width="25%">
                                                                            <form class="form-horizontal">
                                                                                <div class="form-group no-margin">
                                                                                    <div class="">
                                                                                        <input class="form-control input-sm" id="txtWageNo4" onchange="ValidateWage05Prelim()"
                                                                                            onfocus="ReadOnlySetFocus()" maxlength="20" style="width: 100%">
                                                                                    </div>
                                                                                </div>
                                                                            </form>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="text-left"><span><strong>5.</strong></span> &nbsp; Tax Due [Calculated - line 4 X .039280] </td>
                                                                        <td width="25%">
                                                                            <form class="form-horizontal">
                                                                                <div class="form-group no-margin">
                                                                                    <div class="">
                                                                                        <label id="lblWageNo5" style="width: 100%" class="form-control input-sm"></label>
                                                                                    </div>
                                                                                </div>
                                                                            </form>
                                                                        </td>
                                                                    </tr>
                                                                    <tr class="odd">
                                                                        <td class="text-left"><span><strong>6.</strong></span> &nbsp;  Total Taxable Compensation paid to non-residents of Philadelphia in 2011</td>
                                                                        <td width="25%">
                                                                            <form class="form-horizontal">
                                                                                <div class="form-group no-margin">
                                                                                    <div class="">
                                                                                        <input class="form-control input-sm" id="txtWageNo6" onchange="ValidateWage05Prelim()"
                                                                                            onfocus="ReadOnlySetFocus()" maxlength="20" style="width: 100%">
                                                                                    </div>
                                                                                </div>
                                                                            </form>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="text-left"><span><strong>7.</strong></span> &nbsp; Tax Due[Calculated - line 6 X .039240]&nbsp;</td>
                                                                        <td width="25%">
                                                                            <form class="form-horizontal">
                                                                                <div class="form-group no-margin">
                                                                                    <div class="">
                                                                                        <label id="lblWageNo7" style="width: 100%" class="form-control input-sm"></label>
                                                                                    </div>
                                                                                </div>
                                                                            </form>
                                                                        </td>
                                                                    </tr>
                                                                    <tr class="odd">
                                                                        <td class="text-left"><span><strong>8.</strong></span> &nbsp;  Total Tax Due[Calculated - lines 5 and 7]</td>
                                                                        <td width="25%">
                                                                            <form class="form-horizontal">
                                                                                <div class="form-group no-margin">
                                                                                    <div class="">
                                                                                        <label id="lblWageNo8" style="width: 100%" class="form-control input-sm"></label>
                                                                                    </div>
                                                                                </div>
                                                                            </form>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="text-left"><span><strong>9.</strong></span> &nbsp; Tax previously paid for 2011-
                                                                            <label style="font-weight: normal; color: red; width: 100%">
                                                                                This amount may not yet include	your most recent payment.
						<br>
                                                                                Click on link for more information.</label></td>
                                                                        <td width="25%">
                                                                            <form class="form-horizontal">
                                                                                <div class="form-group no-margin">
                                                                                    <div class="">
                                                                                        <label id="lblWageNo9" style="width: 100%" class="form-control input-sm"></label>
                                                                                    </div>
                                                                                </div>
                                                                            </form>
                                                                        </td>
                                                                    </tr>
                                                                    <tr class="odd">
                                                                        <td class="text-left"><span><strong>10.</strong></span><b>ADDITIONAL TAX DUE</b> If line 8 is greater than line 9,
				enter the amount here</td>
                                                                        <td width="25%">
                                                                            <form class="form-horizontal">
                                                                                <div class="form-group no-margin">
                                                                                    <div class="">
                                                                                        <label id="lblWageNo10" style="width: 100%" class="form-control input-sm"></label>
                                                                                    </div>
                                                                                </div>
                                                                            </form>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="text-left"><span><strong>11.</strong></span> &nbsp; <b>TAX OVERPAID</b> If line 9 is less than line 8,
				enter the amount here.</td>
                                                                        <td width="25%">
                                                                            <form class="form-horizontal">
                                                                                <div class="form-group no-margin">
                                                                                    <div class="">
                                                                                        <label id="lblWageNo11" style="width: 100%" class="form-control input-sm"></label>
                                                                                    </div>
                                                                                </div>
                                                                            </form>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                                <tbody>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                        
                                                    <!-- Form End-->
                                                    <!-- Preperar Section Form -->
                                                    <form class="form-horizontal school_form">
                                                        <div>
                                                            <%
                                                                Html.RenderAction("PreparerSection", "INC");   
                                                            %>
                                                        </div>
                                                        <div class="form_segment here_input_table" align="right">
                                                            <input type="button" value="Print" class="submit_button_light" onclick="parent.doPrintDocWin()" />
                                                            <input type="button" value="Submit" class="submit_button" id="btnSchoolSubmit" onclick="btnSchoolValidate();
    ispDisplayProgress('btnSchool05Submit_onclick()', 'Submitting 2011 school tax information')" />
                                                        </div>
                                                        <div style="margin-left: 5px; font: 12px/20px opensans-regular;" class="here_input_table">
                                                            <label>
                                                                Note: DO NOT FILE THIS RETURN if you have no taxable activity. If you registered for 
				this tax and you no longer have taxable activity, complete a 
				<a href="http://www.phila.gov/revenue/Change_Form.pdf" target="_blank">Change Form</a> to cancel
				your account.</label>
                                                        </div>
                                                    </form>
                                                    <!-- Preperar Section Form END -->
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
