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
        var dRate;
        $(document).ready(function () {
            $('.inpReadOnlyRt').parent().css("text-align", "right");
            DisplaySchool08Return();
        });
        var arrSchool08Err = new Array()
        var txtHeader = 'Taxpayer Information'
        var dSchoolTaxRate
        var gUserAddr = '<%Response.Write(Request.ServerVariables["REMOTE_ADDR"]);%>'

        function AdjustNameDisplay(incName) {
            var sEntityName = incName
            var lName = "",
                fName = "",
                mName = "",
                newName = ""

            if (sEntityName.indexOf("*") != -1) { //If name contains *'s
                sEntityName = sEntityName.split("*")
                lName = (sEntityName[0].substr(0, 1)) + (sEntityName[0].substr(1).toLowerCase())
                if (sEntityName[1]) {
                    fName = (sEntityName[1].substr(0, 1)) + (sEntityName[1].substr(1).toLowerCase())
                } //if
                if (sEntityName[2]) {
                    mName = sEntityName[2].substr(0, 1).toUpperCase()
                } //if
                sEntityName = fName + " " + mName + " " + lName
            } //if
            return sEntityName
        } //AdjustNameDisplay

        function ReloadNPT() {

            parent.$g.loadXmlSync('XML/SchoolReturn', parent.parseXml_xmlSchoolTemplate);

        }

        function DisplaySchool08Return() {
            //------declare controls------//
            var txtSchoolNo1_08 = document.getElementById('txtSchoolNo1_08');
            var txtSchoolNo2_08 = document.getElementById('txtSchoolNo2_08');
            var txtSchoolNo3_08 = document.getElementById('txtSchoolNo3_08');
            var txtSchoolNo4_08 = document.getElementById('txtSchoolNo4_08');
            var txtSchoolNo5_08 = document.getElementById('txtSchoolNo5_08');
            var txtSchoolNo6_08 = document.getElementById('txtSchoolNo6_08');
            var txtSchoolNo7_08 = document.getElementById('txtSchoolNo7_08');
            var txtSchoolNo8_08 = document.getElementById('txtSchoolNo8_08');
            var txtSchoolNo10_08 = document.getElementById('txtSchoolNo10_08');
            var txtSchoolNo13_08 = document.getElementById('txtSchoolNo13_08');
            var txtSchoolNo15a_08 = document.getElementById('txtSchoolNo15a_08');
            var txtSchoolNo10_08 = document.getElementById('txtSchoolNo10_08');
            var txtSchoolNo15b_08 = document.getElementById('txtSchoolNo15b_08');
            //--------------------------end----------------------//
            ReloadNPT();
            if ($(parent.$g.xmlAccount).find("TAX_ACCT").find("ACCOUNT:contains('29')")) {

                // parent.MenuWin.ispHighlightMenu(parent.MenuWin.mnuSchoolYear13)//Sangha


                parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, 'INQ', 'SCHOOL_INFO RETURN_STATUS', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ENTITY_ID', "", 0), 'SCHOOL_INFO ACCOUNT_ID', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, '12/31/2012', 'SCHOOL_INFO PERIOD', '', 0)
                ispCallXMLForm(parent.$g.xmlSchool, parent.$g.xmlSchool, "SchoolReturn", "");
                ispHideProgress();
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'ERROR_INFO ERROR', "", 0) != 0) {
                    $(parent.RightFrame).attr("rows", "*,0");
                    $('#SchoolReturn_08').css("display", "block");
                    $('#AppHeader').html(txtHeader + '<Font class=hdrMedium>|school income tax return for 2012</Font>');
                    PopulateSchool08Header();
                    FieldLock_08(true);
                    $(parent.AppError).text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'ERROR_INFO MESSAGE', "", 0));
                    $('#btnSchool08Submit').attr('disabled', 'disable');
                    $('#chkAmended_08').attr('disabled', 'disable');
                    return
                } //if
                if ($(parent.divAcctInfo).css("display") == 'none') {
                    $(parent.divAcctInfo).css("display", "block");
                    $(parent.divAccount).css("display", "none");
                } //if
            } else {
                parent.$g.xmlSchool.loadXML(parent.$g.xmlSchoolTemplate.xml);
                parent.ispMenu_onclick(parent.mnuAcctInfo);
            } //if
            $(parent.RightFrame).attr("rows", "*,0");
            $('#SchoolReturn_08').css("display", "block");
            $('#AppHeader').html(txtHeader + '<Font class=hdrMedium>|school income tax return for 2012</Font>');
            parent.gsInstructionItem = '#SchoolReturn';
            $('#AppMessage').html(parent.gsInstructionText + '<BR>The School Income Tax for 2012 is due April 15, 2013.');
            $('#InstructionText').html(' for Instructions on filing this return');

            LoadSchool08Error();
            RightAlignText();
            CheckSchool08XML();
            SetSchool08Fields();
            PopulateSchool08Header();
            PopulateSchool08Data();
            $(parent.AppError).text("");
            // $('#AppError').text("");//Sangha
        } //DisplaySchool08Return

        function SetSchool08Fields() {
            var chkAmended_08 = document.getElementById('chkAmended_08');
            //var FieldLock_08 = document.getElementById('FieldLock_08');
            var chkTaxpayer = document.getElementById('chkTaxpayer');

            FieldLock_08(false)
            chkAmended_08.disabled = true
            chkAmended_08.checked = false
            chkTaxpayer.checked = false
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO VERSION', '', 0) != '') {
                chkAmended_08.disabled = false
                FieldLock_08(true)
            } //if
        } //SetSchool08Fields

        function FieldLock_08(bDisabled) {
            if (bDisabled == true) {

                $('#txtToDate_08').attr('disabled', 'disable');
                $('#txtFromDate_08').attr('disabled', 'disable');
                $('#txtSchoolNo1_08').attr('disabled', 'disable');
                $('#txtSchoolNo2_08').attr('disabled', 'disable');
                $('#txtSchoolNo3_08').attr('disabled', 'disable');
                $('#txtSchoolNo4_08').attr('disabled', 'disable');
                $('#txtSchoolNo5_08').attr('disabled', 'disable');
                $('#txtSchoolNo6_08').attr('disabled', 'disable');
                $('#txtSchoolNo7_08').attr('disabled', 'disable');
                $('#txtSchoolNo8_08').attr('disabled', 'disable');
                $('#lblSchoolNo9_08').attr('disabled', 'disable');
                $('#txtSchoolNo10_08').attr('disabled', 'disable');
                $('#lblSchoolNo11_08').attr('disabled', 'disable');
                $('#lblSchoolNo12_08').attr('disabled', 'disable');
                $('#txtSchoolNo13_08').attr('disabled', 'disable');
                $('#lblSchoolNo14_08').attr('disabled', 'disable');
                $('#txtSchoolNo15a_08').attr('disabled', 'disable');
                $('#txtSchoolNo15b_08').attr('disabled', 'disable');

            } else {

                $('#txtToDate_08').removeAttr('disabled');
                $('#txtFromDate_08').removeAttr('disabled');
                $('#txtSchoolNo1_08').removeAttr('disabled');
                $('#txtSchoolNo2_08').removeAttr('disabled');
                $('#txtSchoolNo3_08').removeAttr('disabled');
                $('#txtSchoolNo4_08').removeAttr('disabled');
                $('#txtSchoolNo5_08').removeAttr('disabled');
                $('#txtSchoolNo6_08').removeAttr('disabled');
                $('#txtSchoolNo7_08').removeAttr('disabled');
                $('#txtSchoolNo8_08').removeAttr('disabled');
                $('#lblSchoolNo9_08').removeAttr('disabled');
                $('#txtSchoolNo10_08').removeAttr('disabled');
                $('#lblSchoolNo11_08').removeAttr('disabled');
                $('#lblSchoolNo12_08').removeAttr('disabled');
                $('#txtSchoolNo13_08').removeAttr('disabled');
                $('#lblSchoolNo14_08').removeAttr('disabled');
                $('#txtSchoolNo15a_08').removeAttr('disabled');
                $('#txtSchoolNo15b_08').removeAttr('disabled');

            }

            DisablePreparer(bDisabled);
        } //FieldLock_08

        function CheckSchool08XML() {
            //------declare controls------//
            var txtSchoolNo1_08 = document.getElementById('txtSchoolNo1_08');
            var txtSchoolNo2_08 = document.getElementById('txtSchoolNo2_08');
            var txtSchoolNo3_08 = document.getElementById('txtSchoolNo3_08');
            var txtSchoolNo4_08 = document.getElementById('txtSchoolNo4_08');
            var txtSchoolNo5_08 = document.getElementById('txtSchoolNo5_08');
            var txtSchoolNo6_08 = document.getElementById('txtSchoolNo6_08');
            var txtSchoolNo7_08 = document.getElementById('txtSchoolNo7_08');
            var txtSchoolNo8_08 = document.getElementById('txtSchoolNo8_08');
            var txtSchoolNo10_08 = document.getElementById('txtSchoolNo10_08');
            var txtSchoolNo13_08 = document.getElementById('txtSchoolNo13_08');
            var txtSchoolNo15a_08 = document.getElementById('txtSchoolNo15a_08');
            var txtSchoolNo10_08 = document.getElementById('txtSchoolNo10_08');
            var txtSchoolNo15b_08 = document.getElementById('txtSchoolNo15b_08');
            //---------------------end-------------//
            var bPeriodExist = true

            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO PERIOD', '', 0) != '' && new Date(parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO PERIOD', '', 0)) < new Date('01/01/2012')) {
                bPeriodExist = false
            } //if
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO PERIOD', '', 0) == '') {
                bPeriodExist = false
            } //if
            if (bPeriodExist == false) {
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, '', 'ERROR_INFO PROGRAM', '', 0)
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, '', 'ERROR_INFO ERROR', '', 0)
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, '', 'ERROR_INFO LINE', '', 0)
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, '', 'ERROR_INFO MESSAGE', '', 0)

                parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, '12/31/2012', 'SCHOOL_INFO PERIOD', '', 0)
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, '', 'SCHOOL_INFO VERSION', '', 0)
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, '', 'SCHOOL_INFO RETURN_STATUS', '', 0)
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, '', 'SCHOOL_INFO LAST_UPD_DATE', '', 0)
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, '', 'SCHOOL_INFO RECORDING_DATE', '', 0)
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, '', 'SCHOOL_INFO EXTENSION_DATE', '', 0)
                ClearPreparerXML(parent.$g.xmlSchool, 'SCHOOL_INFO')

                parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, 0, 'AMT_INFO NET_TAX_DIVIDENDS', '', 0)
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, 0, 'AMT_INFO TAXABLE_INTEREST', '', 0)
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, 0, 'AMT_INFO S_CORP_DISTRIBUTIONS', '', 0)
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, 0, 'AMT_INFO PARTNERSHIP_INCOME', '', 0)
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, 0, 'AMT_INFO BENEFICIARY_INCOME', '', 0)
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, 0, 'AMT_INFO SHORT_TERM_GAINS', '', 0)
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, 0, 'AMT_INFO NET_RENTAL_INCOME', '', 0)
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, 0, 'AMT_INFO OTHER_TAXABLE_INCOME', '', 0)
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, 0, 'AMT_INFO TOTAL_TAXABLE_INCOME', '', 0)
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, 0, 'AMT_INFO DEDUCTIBLE_EXPENSES', '', 0)
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, 0, 'AMT_INFO NET_TAXABLE_INCOME', '', 0)
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, 0, 'AMT_INFO GROSS_TAX_DUE', '', 0)
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, 0, 'AMT_INFO CREDITS', '', 0)
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, 0, 'AMT_INFO TAX_DUE', '', 0)
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, 0, 'AMT_INFO TAX_OVERPAID', '', 0)
            } //if
        } //CheckSchool08XML

        function PopulateSchool08Header() {
            //------declare controls------//
            var txtSchoolNo1_08 = document.getElementById('txtSchoolNo1_08');
            var txtSchoolNo2_08 = document.getElementById('txtSchoolNo2_08');
            var txtSchoolNo3_08 = document.getElementById('txtSchoolNo3_08');
            var txtSchoolNo4_08 = document.getElementById('txtSchoolNo4_08');
            var txtSchoolNo5_08 = document.getElementById('txtSchoolNo5_08');
            var txtSchoolNo6_08 = document.getElementById('txtSchoolNo6_08');
            var txtSchoolNo7_08 = document.getElementById('txtSchoolNo7_08');
            var txtSchoolNo8_08 = document.getElementById('txtSchoolNo8_08');
            var txtSchoolNo10_08 = document.getElementById('txtSchoolNo10_08');
            var txtSchoolNo13_08 = document.getElementById('txtSchoolNo13_08');
            var txtSchoolNo15a_08 = document.getElementById('txtSchoolNo15a_08');
            var txtSchoolNo10_08 = document.getElementById('txtSchoolNo10_08');
            var txtSchoolNo15b_08 = document.getElementById('txtSchoolNo15b_08');
            //---------------------end-------------//
            var addrIdx
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ENTITY_ID', '', 0) != '') {
                $('#lblEntityId_08').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ENTITY_ID', '', 0))
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO TYPE', '', 0) == 1) {
                    $('#lblEntityType_08').text('EIN:');
                    $('#lblEntityId_08').text(' ' + $('#lblEntityId_08').text().substr(0, 2) + '-' + $('#lblEntityId_08').text().substr(2));
                } else {
                    $('#lblEntityType_08').text('SSN:');
                    $('#lblEntityId_08').text(' ' + $('#lblEntityId_08').text().substr(0, 3) + '-' + $('#lblEntityId_08').text().substr(3, 2) + '-' + $('#lblEntityId_08').text().substr(5));
                } //if
                addrIdx = LocatePrimaryAddr()
                $('#lblName_08').text(AdjustNameDisplay(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS NAME', '', addrIdx)));
                $('#lblAddress_08').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS1', '', addrIdx) + ' ' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS CITY', '', addrIdx) + ' ' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS STATE', '', addrIdx) + ' ' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ZIP', '', addrIdx));
            } //if
        } //PopulateSchool08Header

        function PopulateSchool08Data() {
            //------declare controls------//
            var txtSchoolNo1_08 = document.getElementById('txtSchoolNo1_08');
            var txtSchoolNo2_08 = document.getElementById('txtSchoolNo2_08');
            var txtSchoolNo3_08 = document.getElementById('txtSchoolNo3_08');
            var txtSchoolNo4_08 = document.getElementById('txtSchoolNo4_08');
            var txtSchoolNo5_08 = document.getElementById('txtSchoolNo5_08');
            var txtSchoolNo6_08 = document.getElementById('txtSchoolNo6_08');
            var txtSchoolNo7_08 = document.getElementById('txtSchoolNo7_08');
            var txtSchoolNo8_08 = document.getElementById('txtSchoolNo8_08');
            var txtSchoolNo10_08 = document.getElementById('txtSchoolNo10_08');
            var txtSchoolNo13_08 = document.getElementById('txtSchoolNo13_08');
            var txtSchoolNo15a_08 = document.getElementById('txtSchoolNo15a_08');
            var txtSchoolNo10_08 = document.getElementById('txtSchoolNo10_08');
            var txtSchoolNo15b_08 = document.getElementById('txtSchoolNo15b_08');
            //---------------------end-------------//
            dRate = parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO RATE', '', 0);

            $('#lblSchoolRate').text($('#lblSchoolRate').text().replace('###', dRate));

            dSchoolTaxRate = parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO RATE', '', 0)
            txtSchoolNo1_08.value = ispFormatMoney(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'AMT_INFO NET_TAX_DIVIDENDS', '', 0), 0)
            txtSchoolNo2_08.value = ispFormatMoney(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'AMT_INFO TAXABLE_INTEREST', '', 0), 0)
            txtSchoolNo3_08.value = ispFormatMoney(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'AMT_INFO S_CORP_DISTRIBUTIONS', '', 0), 0)
            txtSchoolNo4_08.value = ispFormatMoney(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'AMT_INFO PARTNERSHIP_INCOME', '', 0), 0)
            txtSchoolNo5_08.value = ispFormatMoney(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'AMT_INFO BENEFICIARY_INCOME', '', 0), 0)
            txtSchoolNo6_08.value = ispFormatMoney(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'AMT_INFO SHORT_TERM_GAINS', '', 0), 0)
            txtSchoolNo7_08.value = ispFormatMoney(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'AMT_INFO NET_RENTAL_INCOME', '', 0), 0)
            txtSchoolNo8_08.value = ispFormatMoney(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'AMT_INFO OTHER_TAXABLE_INCOME', '', 0), 0)
            $('#lblSchoolNo9_08').text(ispFormatMoney(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'AMT_INFO TOTAL_TAXABLE_INCOME', '', 0), 0));

            txtSchoolNo10_08.value = ispFormatMoney(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'AMT_INFO DEDUCTIBLE_EXPENSES', '', 0), 0);
            $('#lblSchoolNo11_08').text(ispFormatMoney(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'AMT_INFO NET_TAXABLE_INCOME', '', 0), 0));
            $('#lblSchoolNo12_08').text(ispFormatMoney(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'AMT_INFO GROSS_TAX_DUE', '', 0), 0));
            txtSchoolNo13_08.value = ispFormatMoney(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'AMT_INFO CREDITS', '', 0), 0)
            $('#lblSchoolNo14_08').text(ispFormatMoney(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'AMT_INFO TAX_DUE', '', 0), 0));
            txtSchoolNo15a_08.value = ispFormatMoney(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'AMT_INFO TAX_REFUND', '', 0), 0)
            txtSchoolNo15b_08.value = ispFormatMoney(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'AMT_INFO TAX_OVERPAID', '', 0), 0)

            PopulatePreparer(parent.$g.xmlSchool, 'SCHOOL_INFO');

            CalcLine14();
            CalcLine15();
        } //PopulateSchool08Data

        function PopulateSchool08XML() {

            //------declare controls------//
            var txtSchoolNo1_08 = document.getElementById('txtSchoolNo1_08');
            var txtSchoolNo2_08 = document.getElementById('txtSchoolNo2_08');
            var txtSchoolNo3_08 = document.getElementById('txtSchoolNo3_08');
            var txtSchoolNo4_08 = document.getElementById('txtSchoolNo4_08');
            var txtSchoolNo5_08 = document.getElementById('txtSchoolNo5_08');
            var txtSchoolNo6_08 = document.getElementById('txtSchoolNo6_08');
            var txtSchoolNo7_08 = document.getElementById('txtSchoolNo7_08');
            var txtSchoolNo8_08 = document.getElementById('txtSchoolNo8_08');
            var txtSchoolNo10_08 = document.getElementById('txtSchoolNo10_08');
            var txtSchoolNo13_08 = document.getElementById('txtSchoolNo13_08');
            var txtSchoolNo15a_08 = document.getElementById('txtSchoolNo15a_08');
            var txtSchoolNo10_08 = document.getElementById('txtSchoolNo10_08');
            var txtSchoolNo15b_08 = document.getElementById('txtSchoolNo15b_08');
            //---------------------end-------------//
            var d = new Date()
            var lYear = String(d.getFullYear())
            var lMonth = String(d.getMonth() + 1)
            lMonth = lMonth.length == 1 ? '0' + lMonth : lMonth
            var lDate = String(d.getDate())
            lDate = lDate.length == 1 ? '0' + lDate : lDate

            parent.$x.ispXmlSetFieldVal(
            parent.$g.xmlSchool, lMonth + '/' + lDate + '/' + lYear, 'SCHOOL_INFO RECORDING_DATE', '', 0)

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, stripCurrency(txtSchoolNo1_08.value), 'AMT_INFO NET_TAX_DIVIDENDS', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, stripCurrency(txtSchoolNo2_08.value), 'AMT_INFO TAXABLE_INTEREST', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, stripCurrency(txtSchoolNo3_08.value), 'AMT_INFO S_CORP_DISTRIBUTIONS', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, stripCurrency(txtSchoolNo4_08.value), 'AMT_INFO PARTNERSHIP_INCOME', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, stripCurrency(txtSchoolNo5_08.value), 'AMT_INFO BENEFICIARY_INCOME', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, stripCurrency(txtSchoolNo6_08.value), 'AMT_INFO SHORT_TERM_GAINS', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, stripCurrency(txtSchoolNo7_08.value), 'AMT_INFO NET_RENTAL_INCOME', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, stripCurrency(txtSchoolNo8_08.value), 'AMT_INFO OTHER_TAXABLE_INCOME', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, stripCurrency($('#lblSchoolNo9_08').text()), 'AMT_INFO TOTAL_TAXABLE_INCOME', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, stripCurrency(txtSchoolNo10_08.value), 'AMT_INFO DEDUCTIBLE_EXPENSES', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, stripCurrency($('#lblSchoolNo11_08').text()), 'AMT_INFO NET_TAXABLE_INCOME', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, stripCurrency($('#lblSchoolNo12_08').text()), 'AMT_INFO GROSS_TAX_DUE', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, stripCurrency(txtSchoolNo13_08.value), 'AMT_INFO CREDITS', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, ispRemoveMoney($('#lblSchoolNo14_08').text()), 'AMT_INFO TAX_DUE', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, stripCurrency(txtSchoolNo15a_08.value), 'AMT_INFO TAX_REFUND', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, stripCurrency(txtSchoolNo15b_08.value), 'AMT_INFO TAX_OVERPAID', '', 0)

            PopulatePreparerXML(parent.$g.xmlSchool, 'SCHOOL_INFO')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, '', 'DEBUG', '', 0)
        } //PopulateSchool08XML

        function RightAlignText() {
            //------declare controls------//
            var txtSchoolNo1_08 = document.getElementById('txtSchoolNo1_08');
            var txtSchoolNo2_08 = document.getElementById('txtSchoolNo2_08');
            var txtSchoolNo3_08 = document.getElementById('txtSchoolNo3_08');
            var txtSchoolNo4_08 = document.getElementById('txtSchoolNo4_08');
            var txtSchoolNo5_08 = document.getElementById('txtSchoolNo5_08');
            var txtSchoolNo6_08 = document.getElementById('txtSchoolNo6_08');
            var txtSchoolNo7_08 = document.getElementById('txtSchoolNo7_08');
            var txtSchoolNo8_08 = document.getElementById('txtSchoolNo8_08');
            var txtSchoolNo10_08 = document.getElementById('txtSchoolNo10_08');
            var txtSchoolNo13_08 = document.getElementById('txtSchoolNo13_08');
            var txtSchoolNo15a_08 = document.getElementById('txtSchoolNo15a_08');
            var txtSchoolNo10_08 = document.getElementById('txtSchoolNo10_08');
            var txtSchoolNo15b_08 = document.getElementById('txtSchoolNo15b_08');
            //---------------------end-------------//
            ispAlignRight(txtSchoolNo1_08);
            ispAlignRight(txtSchoolNo2_08);
            ispAlignRight(txtSchoolNo3_08);
            ispAlignRight(txtSchoolNo4_08);
            ispAlignRight(txtSchoolNo5_08);
            ispAlignRight(txtSchoolNo6_08);
            ispAlignRight(txtSchoolNo7_08);
            ispAlignRight(txtSchoolNo8_08);
            ispAlignRight(lblSchoolNo9_08);
            ispAlignRight(txtSchoolNo10_08);
            ispAlignRight(lblSchoolNo11_08);
            ispAlignRight(lblSchoolNo12_08);
            ispAlignRight(txtSchoolNo13_08);
            ispAlignRight(lblSchoolNo14_08);
            ispAlignRight(txtSchoolNo15a_08);
            ispAlignRight(txtSchoolNo15b_08);

        } //RightAlignText

        function LoadSchool08Error() {
            //------declare controls------//
            var txtSchoolNo1_08 = document.getElementById('txtSchoolNo1_08');
            var txtSchoolNo2_08 = document.getElementById('txtSchoolNo2_08');
            var txtSchoolNo3_08 = document.getElementById('txtSchoolNo3_08');
            var txtSchoolNo4_08 = document.getElementById('txtSchoolNo4_08');
            var txtSchoolNo5_08 = document.getElementById('txtSchoolNo5_08');
            var txtSchoolNo6_08 = document.getElementById('txtSchoolNo6_08');
            var txtSchoolNo7_08 = document.getElementById('txtSchoolNo7_08');
            var txtSchoolNo8_08 = document.getElementById('txtSchoolNo8_08');
            var txtSchoolNo10_08 = document.getElementById('txtSchoolNo10_08');
            var txtSchoolNo13_08 = document.getElementById('txtSchoolNo13_08');
            var txtSchoolNo15a_08 = document.getElementById('txtSchoolNo15a_08');
            var txtSchoolNo10_08 = document.getElementById('txtSchoolNo10_08');
            var txtSchoolNo15b_08 = document.getElementById('txtSchoolNo15b_08');
            //---------------------end-------------//
            var i = 0

            arrSchool08Err[i++] = [txtSchoolNo1_08, 'txtSchoolNo1_08.value == ""', 'Answer Question 1']
            arrSchool08Err[i++] = [txtSchoolNo1_08, 'ispValue(txtSchoolNo1_08.value) == false', 'Value for Question 1 must be numeric']
            arrSchool08Err[i++] = [txtSchoolNo1_08, 'ispNegativeNumber(txtSchoolNo1_08.value) == false', 'Value for Question 1 must NOT be negative']

            arrSchool08Err[i++] = [txtSchoolNo2_08, 'txtSchoolNo2_08.value == ""', 'Answer Question 2']
            arrSchool08Err[i++] = [txtSchoolNo2_08, 'ispValue(txtSchoolNo2_08.value) == false', 'Value for Question 2 must be numeric']
            arrSchool08Err[i++] = [txtSchoolNo2_08, 'ispNegativeNumber(txtSchoolNo2_08.value) == false', 'Value for Question 2 must NOT be negative']

            arrSchool08Err[i++] = [txtSchoolNo3_08, 'txtSchoolNo3_08.value == ""', 'Answer Question 3']
            arrSchool08Err[i++] = [txtSchoolNo3_08, 'ispValue(txtSchoolNo3_08.value) == false', 'Value for Question 3 must be numeric']
            arrSchool08Err[i++] = [txtSchoolNo3_08, 'ispNegativeNumber(txtSchoolNo3_08.value) == false', 'Value for Question 3 must NOT be negative']

            arrSchool08Err[i++] = [txtSchoolNo4_08, 'txtSchoolNo4_08.value == ""', 'Answer Question 4']
            arrSchool08Err[i++] = [txtSchoolNo4_08, 'ispValue(txtSchoolNo4_08.value) == false', 'Value for Question 4 must be numeric']
            arrSchool08Err[i++] = [txtSchoolNo4_08, 'ispNegativeNumber(txtSchoolNo4_08.value) == false', 'Value for Question 4 must NOT be negative']

            arrSchool08Err[i++] = [txtSchoolNo5_08, 'txtSchoolNo5_08.value == ""', 'Answer Question 5']
            arrSchool08Err[i++] = [txtSchoolNo5_08, 'ispValue(txtSchoolNo5_08.value) == false', 'Value for Question 5 must be numeric']
            arrSchool08Err[i++] = [txtSchoolNo5_08, 'ispNegativeNumber(txtSchoolNo5_08.value) == false', 'Value for Question 5 must NOT be negative']

            arrSchool08Err[i++] = [txtSchoolNo6_08, 'txtSchoolNo6_08.value == ""', 'Answer Question 6']
            arrSchool08Err[i++] = [txtSchoolNo6_08, 'ispValue(txtSchoolNo6_08.value) == false', 'Value for Question 6 must be numeric']
            arrSchool08Err[i++] = [txtSchoolNo6_08, 'ispNegativeNumber(txtSchoolNo6_08.value) == false', 'Value for Question 6 must NOT be negative']

            arrSchool08Err[i++] = [txtSchoolNo7_08, 'txtSchoolNo7_08.value == ""', 'Answer Question 7']
            arrSchool08Err[i++] = [txtSchoolNo7_08, 'ispValue(txtSchoolNo7_08.value) == false', 'Value for Question 7 must be numeric']
            arrSchool08Err[i++] = [txtSchoolNo7_08, 'ispNegativeNumber(txtSchoolNo7_08.value) == false', 'Value for Question 7 must NOT be negative']

            arrSchool08Err[i++] = [txtSchoolNo8_08, 'txtSchoolNo8_08.value == ""', 'Answer Question 8']
            arrSchool08Err[i++] = [txtSchoolNo8_08, 'ispValue(txtSchoolNo8_08.value) == false', 'Value for Question 8 must be numeric']
            arrSchool08Err[i++] = [txtSchoolNo8_08, 'ispNegativeNumber(txtSchoolNo8_08.value) == false', 'Value for Question 8 must NOT be negative']

            arrSchool08Err[i++] = [txtSchoolNo10_08, 'txtSchoolNo10_08.value == ""', 'Answer Question 10']
            arrSchool08Err[i++] = [txtSchoolNo10_08, 'ispValue(txtSchoolNo10_08.value) == false', 'Value for Question 10 must be numeric']
            arrSchool08Err[i++] = [txtSchoolNo10_08, 'ispNegativeNumber(txtSchoolNo10_08.value) == false', 'Value for Question 10 must NOT be negative']

        } //LoadSchool08Error

        function ValidateSchool08Return() {
            //------declare controls------//
            var txtSchoolNo1_08 = document.getElementById('txtSchoolNo1_08');
            var txtSchoolNo2_08 = document.getElementById('txtSchoolNo2_08');
            var txtSchoolNo3_08 = document.getElementById('txtSchoolNo3_08');
            var txtSchoolNo4_08 = document.getElementById('txtSchoolNo4_08');
            var txtSchoolNo5_08 = document.getElementById('txtSchoolNo5_08');
            var txtSchoolNo6_08 = document.getElementById('txtSchoolNo6_08');
            var txtSchoolNo7_08 = document.getElementById('txtSchoolNo7_08');
            var txtSchoolNo8_08 = document.getElementById('txtSchoolNo8_08');
            var txtSchoolNo10_08 = document.getElementById('txtSchoolNo10_08');
            var txtSchoolNo13_08 = document.getElementById('txtSchoolNo13_08');
            var txtSchoolNo15a_08 = document.getElementById('txtSchoolNo15a_08');
            var txtSchoolNo10_08 = document.getElementById('txtSchoolNo10_08');
            var txtSchoolNo15b_08 = document.getElementById('txtSchoolNo15b_08');
            //---------------------end-------------//
            var evt = window.event || arguments.callee.caller.arguments[0];
            var source = parent.getEventSource(evt);
            var ObjSelected
            // $('#AppError').text('');//SanghA
            // Parent.$('#AppError').text("");
            $(parent.AppError).text("");


            if (source != null) {
                var sId = source.id;
                ObjSelected = document.getElementById(sId)

                if (ObjSelected != null) {
                    if (sId == "txtToDate_08" || sId == "txtFromDate_08" || source.type == 'button') { } else {
                        ObjSelected.value = ispFormatMoney(ObjSelected.value, 0)
                    } //if
                }
            }

            $(parent.AppError).text(ispSetInputErr(arrSchool08Err));
            if ($(parent.AppError).text() == '') {
                CalcLine9();
                CalcLine11();
                CalcLine12(dSchoolTaxRate);
                CalcLine14();
                CalcLine15();
            } else {
                //$(parent.AppError).scrollIntoView(true);
            } //if
        } //ValidateSchool08Return

        function btnSchool08Print_onclick() {
            //------declare controls------//
            var txtSchoolNo1_08 = document.getElementById('txtSchoolNo1_08');
            var txtSchoolNo2_08 = document.getElementById('txtSchoolNo2_08');
            var txtSchoolNo3_08 = document.getElementById('txtSchoolNo3_08');
            var txtSchoolNo4_08 = document.getElementById('txtSchoolNo4_08');
            var txtSchoolNo5_08 = document.getElementById('txtSchoolNo5_08');
            var txtSchoolNo6_08 = document.getElementById('txtSchoolNo6_08');
            var txtSchoolNo7_08 = document.getElementById('txtSchoolNo7_08');
            var txtSchoolNo8_08 = document.getElementById('txtSchoolNo8_08');
            var txtSchoolNo10_08 = document.getElementById('txtSchoolNo10_08');
            var txtSchoolNo13_08 = document.getElementById('txtSchoolNo13_08');
            var txtSchoolNo15a_08 = document.getElementById('txtSchoolNo15a_08');
            var txtSchoolNo10_08 = document.getElementById('txtSchoolNo10_08');
            var txtSchoolNo15b_08 = document.getElementById('txtSchoolNo15b_08');
            //---------------------end-------------//
            $('#btnSchool08Print').css('visibility', 'hidden');
            $('#btnSchool08Submit').css('visibility', 'hidden');


            $(parent.AppError).text('');

            if (txtSchoolNo1_08.disabled == true) {
                FieldLock_08(false)
                window.print()
                FieldLock_08(true)
            } else {
                window.print()
            } //if
            $('#btnSchool08Print').css('visibility', 'visible');
            $('#btnSchool08Submit').css('visibility', 'visible');

        } //btnSchool08Print_onclick

        function btnSchoolValidate() {
            //------declare controls------//
            var txtSchoolNo1_08 = document.getElementById('txtSchoolNo1_08');
            var txtSchoolNo2_08 = document.getElementById('txtSchoolNo2_08');
            var txtSchoolNo3_08 = document.getElementById('txtSchoolNo3_08');
            var txtSchoolNo4_08 = document.getElementById('txtSchoolNo4_08');
            var txtSchoolNo5_08 = document.getElementById('txtSchoolNo5_08');
            var txtSchoolNo6_08 = document.getElementById('txtSchoolNo6_08');
            var txtSchoolNo7_08 = document.getElementById('txtSchoolNo7_08');
            var txtSchoolNo8_08 = document.getElementById('txtSchoolNo8_08');
            var txtSchoolNo10_08 = document.getElementById('txtSchoolNo10_08');
            var txtSchoolNo13_08 = document.getElementById('txtSchoolNo13_08');
            var txtSchoolNo15a_08 = document.getElementById('txtSchoolNo15a_08');
            var txtSchoolNo10_08 = document.getElementById('txtSchoolNo10_08');
            var txtSchoolNo15b_08 = document.getElementById('txtSchoolNo15b_08');
            //---------------------end-------------//
            ValidateSchool08Return();
            if ($(parent.AppError).text() == '') {
                ValidateSchool08Return();
            } //if
            if ($(parent.AppError).text() == '') {
                $(parent.AppError).text(ValidatePreparer());
            } //if
        } //btnWageValidate
        var tempXML = parent.$g.getXmlDocObj();

        function btnSchool08Submit_onclick() {
            //------declare controls------//
            var txtSchoolNo1_08 = document.getElementById('txtSchoolNo1_08');
            var txtSchoolNo2_08 = document.getElementById('txtSchoolNo2_08');
            var txtSchoolNo3_08 = document.getElementById('txtSchoolNo3_08');
            var txtSchoolNo4_08 = document.getElementById('txtSchoolNo4_08');
            var txtSchoolNo5_08 = document.getElementById('txtSchoolNo5_08');
            var txtSchoolNo6_08 = document.getElementById('txtSchoolNo6_08');
            var txtSchoolNo7_08 = document.getElementById('txtSchoolNo7_08');
            var txtSchoolNo8_08 = document.getElementById('txtSchoolNo8_08');
            var txtSchoolNo10_08 = document.getElementById('txtSchoolNo10_08');
            var txtSchoolNo13_08 = document.getElementById('txtSchoolNo13_08');
            var txtSchoolNo15a_08 = document.getElementById('txtSchoolNo15a_08');
            var txtSchoolNo10_08 = document.getElementById('txtSchoolNo10_08');
            var txtSchoolNo15b_08 = document.getElementById('txtSchoolNo15b_08');
            //---------------------end-------------//
            if ($(parent.AppError).text() == '') {
                txtFromDate_08_onblur()
                txtToDate_08_onblur()
                if ($(parent.AppError).text() == '') {
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, '', 'SCHOOL_INFO RETURN_STATUS', '', 0)
                    PopulateSchool08XML()
                    ispCallXMLForm(parent.$g.xmlSchool, parent.$g.xmlSchool, "SchoolReturn", "")
                    ispHideProgress()
                    if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'ERROR_INFO PROGRAM', '', 0) == '') {
                        $('#SchoolReturn_08').css('display', 'none');
                        DisplaySchoolThankYou()
                    } else {
                        $(parent.AppError).text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'ERROR_INFO MESSAGE', '', 0));
                    } //if
                } //if
            } else {
                ispHideProgress()
            } //if
        } //btnSchool08Submit_onclick

        function txtToDate_08_onblur() {
            //------declare controls------//
            var txtToDate_08 = document.getElementById('txtToDate_08');

            //---------------------end-------------//
            if ($(parent.AppError).text() == '' && txtToDate_08.value != "") {
                var strBD = ispValidateDate(txtToDate_08.value)

                if (strBD == false) {
                    $(parent.AppError).innerText = 'Invalid to date'
                    //AppError.innerText = 'Invalid to date'//sangha
                    txtToDate_08.className = 'inpError'
                    blnErr = true
                } else {
                    txtToDate_08.className = 'inpNormal_custom'
                    txtToDate_08.value = strBD
                } //if
            } else {
                txtToDate_08.className = 'inpNormal_custom'
            } //if
        } //txtToDate_08_onblur

        function txtFromDate_08_onblur() {
            //------declare controls------//
            var txtFromDate_08 = document.getElementById('txtFromDate_08');

            //---------------------end-------------//
            if ($(parent.AppError).innerText == "" && txtFromDate_08.value != "") {
                var strBD = ispValidateDate(txtFromDate_08.value)

                if (strBD == false) {
                    $(parent.AppError).innerText = 'Invalid from date'
                    txtFromDate_08.className = 'inpError'
                    blnErr = true
                } else {
                    txtFromDate_08.className = 'inpNormal_custom'
                    txtFromDate_08.value = strBD
                } //if
            } else {
                txtFromDate_08.className = 'inpNormal_custom'
            } //if
        } //txtFromDate_08

        function chkAmended_08_onclick() {

            if ($('#chkAmended_08').is(':checked')) {
                $('#btnSchool08Submit').removeAttr('disabled');
                FieldLock_08(false);
                ClearPreparer();
            } else {
                $('#btnSchool08Submit').attr('disabled', 'disable');
                FieldLock_08(true);
                PopulatePreparer(parent.$g.xmlSchool, 'SCHOOL_INFO');
            } //if
        } //chkAmended_08_onclick

        function LocatePrimaryAddr() {
            var iMaxIdx = parent.$x.ispXmlGetRecCount(parent.$g.xmlAccount, 'NAME_ADDRESS', '')

            for (idx = 0; idx < iMaxIdx; i++) {
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS_TYPE', '', idx) == '60') {
                    if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS RELATIONSHIP_CODE', '', idx) == '0') {
                        return idx
                    } //if
                } else {
                    return 0
                } //if
            } //for
        } //locatePrimaryAddr

        function SetFocus() {
            var evt = window.event || arguments.callee.caller.arguments[0];
            var source = parent.getEventSource(evt);
            source.select();
        } //SetFocus



        function splitField(value, start, end) {

            if (value.length != 0) {
                return value.substr(start, end)
            } else {
                return ''
            } //if
        } //splitField

        function CalcLine9() {
            //------declare controls------//
            var txtSchoolNo1_08 = document.getElementById('txtSchoolNo1_08');
            var txtSchoolNo2_08 = document.getElementById('txtSchoolNo2_08');
            var txtSchoolNo3_08 = document.getElementById('txtSchoolNo3_08');
            var txtSchoolNo4_08 = document.getElementById('txtSchoolNo4_08');
            var txtSchoolNo5_08 = document.getElementById('txtSchoolNo5_08');
            var txtSchoolNo6_08 = document.getElementById('txtSchoolNo6_08');
            var txtSchoolNo7_08 = document.getElementById('txtSchoolNo7_08');
            var txtSchoolNo8_08 = document.getElementById('txtSchoolNo8_08');
            var txtSchoolNo10_08 = document.getElementById('txtSchoolNo10_08');
            var txtSchoolNo13_08 = document.getElementById('txtSchoolNo13_08');
            var txtSchoolNo15a_08 = document.getElementById('txtSchoolNo15a_08');
            var txtSchoolNo10_08 = document.getElementById('txtSchoolNo10_08');
            var txtSchoolNo15b_08 = document.getElementById('txtSchoolNo15b_08');
            //---------------------end-------------//
            if (txtSchoolNo1_08.value != "" && txtSchoolNo2_08.value != "" && txtSchoolNo3_08.value != "" && txtSchoolNo4_08.value != "" && txtSchoolNo5_08.value != "" && txtSchoolNo6_08.value != "" && txtSchoolNo7_08.value != "" && txtSchoolNo8_08.value != "") {
                $('#lblSchoolNo9_08').text(ispFormatMoney(ispRemoveMoney(txtSchoolNo1_08.value) + ispRemoveMoney(txtSchoolNo2_08.value) + ispRemoveMoney(txtSchoolNo3_08.value) + ispRemoveMoney(txtSchoolNo4_08.value) + ispRemoveMoney(txtSchoolNo5_08.value) + ispRemoveMoney(txtSchoolNo6_08.value) + ispRemoveMoney(txtSchoolNo7_08.value) + ispRemoveMoney(txtSchoolNo8_08.value), 0));
            }
        }

        function CalcLine11() {
            //------declare controls------//
            var txtSchoolNo1_08 = document.getElementById('txtSchoolNo1_08');
            var txtSchoolNo2_08 = document.getElementById('txtSchoolNo2_08');
            var txtSchoolNo3_08 = document.getElementById('txtSchoolNo3_08');
            var txtSchoolNo4_08 = document.getElementById('txtSchoolNo4_08');
            var txtSchoolNo5_08 = document.getElementById('txtSchoolNo5_08');
            var txtSchoolNo6_08 = document.getElementById('txtSchoolNo6_08');
            var txtSchoolNo7_08 = document.getElementById('txtSchoolNo7_08');
            var txtSchoolNo8_08 = document.getElementById('txtSchoolNo8_08');
            var txtSchoolNo10_08 = document.getElementById('txtSchoolNo10_08');
            var txtSchoolNo13_08 = document.getElementById('txtSchoolNo13_08');
            var txtSchoolNo15a_08 = document.getElementById('txtSchoolNo15a_08');
            var txtSchoolNo10_08 = document.getElementById('txtSchoolNo10_08');
            var txtSchoolNo15b_08 = document.getElementById('txtSchoolNo15b_08');
            //---------------------end-------------//
            if ($('#lblSchoolNo9_08').text() != '' && txtSchoolNo10_08.value != "") {
                $('#lblSchoolNo11_08').text(ispFormatMoney(ispRemoveMoney($('#lblSchoolNo9_08').text()) - ispRemoveMoney(txtSchoolNo10_08.value), 0));
            }

        }

        function CalcLine12(dTax) {
            if (dTax == 0) {
                dTax = .039280
            }

            if ($('#lblSchoolNo12_08').text() == '') {
                $('#lblSchoolNo12_08').text(ispFormatMoney(0, 0));
            }

            var dvalue = ispRemoveMoney($('#lblSchoolNo11_08').text());
            if (dvalue < 0) {
                $('#lblSchoolNo12_08').text(ispFormatMoney(0, 0));
            } else {
                $('#lblSchoolNo12_08').text(ispFormatMoney(ispRemoveMoney($('#lblSchoolNo11_08').text()) * dTax, 0));
            }


        }

        // 'EGOVWEB-60 - Created CalcLine14


        function CalcLine14() {
            //------declare controls------//
            var txtSchoolNo1_08 = document.getElementById('txtSchoolNo1_08');
            var txtSchoolNo2_08 = document.getElementById('txtSchoolNo2_08');
            var txtSchoolNo3_08 = document.getElementById('txtSchoolNo3_08');
            var txtSchoolNo4_08 = document.getElementById('txtSchoolNo4_08');
            var txtSchoolNo5_08 = document.getElementById('txtSchoolNo5_08');
            var txtSchoolNo6_08 = document.getElementById('txtSchoolNo6_08');
            var txtSchoolNo7_08 = document.getElementById('txtSchoolNo7_08');
            var txtSchoolNo8_08 = document.getElementById('txtSchoolNo8_08');
            var txtSchoolNo10_08 = document.getElementById('txtSchoolNo10_08');
            var txtSchoolNo13_08 = document.getElementById('txtSchoolNo13_08');
            var txtSchoolNo15a_08 = document.getElementById('txtSchoolNo15a_08');
            var txtSchoolNo10_08 = document.getElementById('txtSchoolNo10_08');
            var txtSchoolNo15b_08 = document.getElementById('txtSchoolNo15b_08');
            //---------------------end-------------//
            if (txtSchoolNo13_08.value == '') {
                $('#txtSchoolNo13_08').text(ispFormatMoney(0, 0));
            }

            var val_12 = ispRemoveMoney($('#lblSchoolNo12_08').text());
            var val_13 = ispRemoveMoney(txtSchoolNo13_08.value);


            $('#lblSchoolNo14_08').text(ispFormatMoney(val_12 - val_13, 0));

        }

        //'EGOVWEB-60 - Created CalcLine15


        function CalcLine15() {
            //------declare controls------//
            var txtSchoolNo1_08 = document.getElementById('txtSchoolNo1_08');
            var txtSchoolNo2_08 = document.getElementById('txtSchoolNo2_08');
            var txtSchoolNo3_08 = document.getElementById('txtSchoolNo3_08');
            var txtSchoolNo4_08 = document.getElementById('txtSchoolNo4_08');
            var txtSchoolNo5_08 = document.getElementById('txtSchoolNo5_08');
            var txtSchoolNo6_08 = document.getElementById('txtSchoolNo6_08');
            var txtSchoolNo7_08 = document.getElementById('txtSchoolNo7_08');
            var txtSchoolNo8_08 = document.getElementById('txtSchoolNo8_08');
            var txtSchoolNo10_08 = document.getElementById('txtSchoolNo10_08');
            var txtSchoolNo13_08 = document.getElementById('txtSchoolNo13_08');
            var txtSchoolNo15a_08 = document.getElementById('txtSchoolNo15a_08');
            var txtSchoolNo10_08 = document.getElementById('txtSchoolNo10_08');
            var txtSchoolNo15b_08 = document.getElementById('txtSchoolNo15b_08');
            //---------------------end-------------//
            if (txtSchoolNo15a_08.value == '') {
                $('#txtSchoolNo15a_08').val(ispFormatMoney(0, 0));
            }

            if (txtSchoolNo15b_08.value == '') {
                $('#txtSchoolNo15b_08').val(ispFormatMoney(0, 0));
            }
            var dvalue = ispRemoveMoney($('#lblSchoolNo14_08').text());
            if (dvalue < 0) {

                if ((ispRemoveMoney(txtSchoolNo15a_08.value) + ispRemoveMoney(txtSchoolNo15b_08.value)) != Math.abs(ispRemoveMoney($('#lblSchoolNo14_08').text()))) {
                    $(parent.AppError).text("Lines 15a and 15b must equal Line 14");

                }
            }
        }

        //'EGOVWEB-60 - Changed CalcLine14_15 to CalcLine14 and CalcLine15
        function CalcLine14_15_old() {
            //------declare controls------//
            var txtSchoolNo1_08 = document.getElementById('txtSchoolNo1_08');
            var txtSchoolNo2_08 = document.getElementById('txtSchoolNo2_08');
            var txtSchoolNo3_08 = document.getElementById('txtSchoolNo3_08');
            var txtSchoolNo4_08 = document.getElementById('txtSchoolNo4_08');
            var txtSchoolNo5_08 = document.getElementById('txtSchoolNo5_08');
            var txtSchoolNo6_08 = document.getElementById('txtSchoolNo6_08');
            var txtSchoolNo7_08 = document.getElementById('txtSchoolNo7_08');
            var txtSchoolNo8_08 = document.getElementById('txtSchoolNo8_08');
            var txtSchoolNo10_08 = document.getElementById('txtSchoolNo10_08');
            var txtSchoolNo13_08 = document.getElementById('txtSchoolNo13_08');
            var txtSchoolNo15a_08 = document.getElementById('txtSchoolNo15a_08');
            var txtSchoolNo10_08 = document.getElementById('txtSchoolNo10_08');
            var txtSchoolNo15b_08 = document.getElementById('txtSchoolNo15b_08');
            //---------------------end-------------//
            if ($('#txtSchoolNo15b_08').text() == '') {
                $('#txtSchoolNo13_08').text(ispFormatMoney(0, 0));
            }

            if ($('#lblSchoolNo12_08').text() == '') {
                $('#lblSchoolNo12_08').text(ispFormatMoney(0, 0));
            }
            if ($('#txtSchoolNo13_08').text() == '') {
                $('#lblSchoolNo14_08').text() = $('#lblSchoolNo12_08').text();

                $('#txtSchoolNo15a_08').text(ispFormatMoney(0, 0));
                $('#txtSchoolNo15b_08').text(ispFormatMoney(0, 0));
            } else if ((lblSchoolNo12_08.value) >= (lblSchoolNo12_08.value)) {
                $('#lblSchoolNo14_08').text(ispFormatMoney(ispRemoveMoney($('#lblSchoolNo12_08').text()) - ispRemoveMoney($('#txtSchoolNo13_08').text()), 0));
                $('#txtSchoolNo15a_08').text(ispFormatMoney(0, 0));
                $('#txtSchoolNo15b_08').text(ispFormatMoney(0, 0));
            } else {
                $('#lblSchoolNo14_08').text(ispFormatMoney(0, 0));
                $('#lblSchoolNo15a_08').text(ispFormatMoney((ispRemoveMoney($('#txtSchoolNo13_08').value) - ispRemoveMoney($('#lblSchoolNo12_08').value)), 0))
                $('#lblSchoolNo15b_08').text(ispFormatMoney((ispRemoveMoney($('#txtSchoolNo13_08').value) - ispRemoveMoney($('#lblSchoolNo12_08').value)), 0))
            }
        }

    </script>



    <title></title>
</head>
<body>
    <%--<body onload="ispDisplayProgress('DisplaySchool08Return()', 'Retrieving 2014 school tax information')">--%>
    <%--  <div class="tab_Tcontainer" id="SchoolReturn_08">
        <div class="tab_container">
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



                            <div class="account_greybox">

                                <p><strong>Name :</strong> <label id=lblName_08 class="lblTextBlack" nowrap></label> </p>

                                <p><strong><font id=lblEntityType_08>SSN :</font></strong> <label id=lblEntityId_08 class="lblTextBlack"></label> </p>
                                <div class="clear"></div>
                                <p><strong>Address :</strong> <label id=lblAddress_08 class="lblTextBlack"></label> </p>

                                <div class="clear"></div>

                            </div>


                            <div class="form_segment">


                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabularform schooltables">
                                    <tr>
                                        <td colspan="3" width="100%" scope="col" valign="middle" align="left" class="here_input_table">
                                            <input id=chkAmended_08 type=checkbox onclick="chkAmended_08_onclick()" type="checkbox" />
                                            Check if amended return.

                                        </td>
                                        </tr>

                                    <tr>
                                      <td width="50%" scope="col" align="left">
                                          If you were a  partial year resident in 2014, enter dates of residency :  </td>
                                        
                                        <td width="25%" scope="col" align="right" class="here_input_table">
                                            <span>From:</span> &nbsp;
                                          <input class=inpNormal id=txtFromDate_08 onchange="ValidateSchool08Return()" maxlength=10 
			 onfocus="SetFocus()" onblur="return txtFromDate_08_onblur()"></td>

                                        <td width="25%" scope="col" align="left" class="here_input_table">
                                            <span>To:</span>
                                          <input class=inpNormal id=txtToDate_08 onchange="ValidateSchool08Return()" 
			onfocus="SetFocus()" maxlength=10 onblur="return txtToDate_08_onblur()"></td>

                                    </tr>
                                </table>


                            </div>


                            <div class="form_segment">

                                <table summary="Employee Pay Sheet" id="hor-zebra">

                                    <tbody>

                                        <tr class="odd">
                                            <td width="70%">1.  Net taxable dividends </td>
                                            <td align="center" class="no_border_right">
                                                <input type="text" id="txtSchoolNo1_08" onchange="ValidateSchool08Return()" onfocus="SetFocus()" maxlength="10" /></td>
                                        </tr>
                                        <tr>
                                            <td>2.  Taxable interest</td>
                                            <td align="center" class="no_border_right">
                                                <input type="text" id="txtSchoolNo2_08" onchange="ValidateSchool08Return()" onfocus="SetFocus()" maxlength="10" /></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">3.  Distributive Shares of "Subchapter S" Corporation (If loss, enter "0") </td>
                                            <td align="center" class="no_border_right">
                                                <input type="text" id="txtSchoolNo3_08" onchange="ValidateSchool08Return()" onfocus="SetFocus()" maxlength="10" /></td>
                                        </tr>
                                        <tr>
                                            <td>4.  Limited Partnership Income (If loss, enter "0")</td>
                                            <td align="center" class="no_border_right">
                                                <input type="text" id="txtSchoolNo4_08" onchange="ValidateSchool08Return()" onfocus="SetFocus()" maxlength="10" /></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">5.  Taxable Income received by a Beneficiary from an Estate or Trust </td>
                                            <td align="center" class="no_border_right">
                                                <input type="text" id="txtSchoolNo5_08" onchange="ValidateSchool08Return()" onfocus="SetFocus()" maxlength="10" /></td>
                                        </tr>
                                        <tr>
                                            <td>6.  Net Short Term Capital Gains (<strong><u>Held 6 months or less</u></strong>) (if loss, enter "0")</td>
                                            <td align="center" class="no_border_right">
                                                <input type="text" id="txtSchoolNo6_08" onchange="ValidateSchool08Return()" onfocus="SetFocus()" maxlength="10" /></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">7.  Net Rental Income (If loss, enter "0") </td>
                                            <td align="center" class="no_border_right">
                                                <input type="text" id="txtSchoolNo7_08" onchange="ValidateSchool08Return()" onfocus="SetFocus()" maxlength="10" /></td>
                                        </tr>
                                        <tr>
                                            <td>8.  Other Taxable Income</td>
                                            <td align="center" class="no_border_right">
                                                <input type="text" id="txtSchoolNo8_08" onchange="ValidateSchool08Return()" onfocus="SetFocus()" maxlength="10" /></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">9.  Total Taxable Income [Calculated - add lines 1 through 8]&nbsp; </td>
                                            <td align="center" class="no_border_right">
                                                <label class="" id="lblSchoolNo9_08" style="WIDTH: 100%"></label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>10.  Deductible Expenses</td>
                                            <td align="center" class="no_border_right">
                                                <input type="text" id="txtSchoolNo10_08" onchange="ValidateSchool08Return()" onfocus="SetFocus()" maxlength="10" /></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">11.  Net Taxable Income [Calculated - line 9 minus line 10]&nbsp;</td>
                                            <td align="center" class="no_border_right">
                                                <label class="" id="lblSchoolNo11_08" style="WIDTH: 100%"></label>
                                            </td>
                                        </tr>
                                        <tr >
                                            <td width="70%"> <label id=lblSchoolRate style="width:70%">12.  Gross Tax Due [Calculated - line 11 * ###]&nbsp;</label></td>
                                            <td align="center" class="no_border_right">
                                                <label class="" id="lblSchoolNo12_08" style="WIDTH: 100%"></label>
                                            </td>
                                        </tr>
                                        <tr class="odd">
                                            <td>13.  Credit from overpayment of prior year or tax 
				previously paid with an extension coupon</td>
                                            <td align="center" class="no_border_right">
                                                <input type="text" id="txtSchoolNo13_08" onchange="ValidateSchool08Return()" onfocus="SetFocus()" maxlength="10" /></td>
                                        </tr>
                                        <tr >
                                            <td width="70%">14.  <u>TAX DUE</u> [Calculated - if line 12 greater than line 13]&nbsp;</td>
                                            <td align="center" class="no_border_right">
                                                <label class="" id="lblSchoolNo14_08" style="WIDTH: 100%"></label>
                                            </td>
                                        </tr>
                                        <tr class="odd">
                                            <td>15. <u>OVERPAYMENT OPTIONS</u> [If line 12 less than line 13, check whether amount is to be:]&nbsp;</td>
                                            <td align="center" class="no_border_right">
                                                </td>
                                        </tr>
                                        <tr>
                                            <td width="70%">15A. <strong><u>Refunded</u></strong>. <strong>Do not file a separate Refund Petition</strong>. <strong>OR</strong> </td>
                                            <td align="center" class="no_border_right">
                                                <input type="text" id="txtSchoolNo15a_08" onchange="ValidateSchool08Return()" onfocus="SetFocus()" maxlength="10" /></td>
                                        </tr>
                                        <tr class="odd">
                                            <td>15B.  <strong><u>Applied</u></strong> to the 2014 School Income Tax</td>
                                            <td align="center" class="no_border_right">
                                                <input type="text" id="txtSchoolNo15b_08" onchange="ValidateSchool08Return()" onfocus="SetFocus()" maxlength="10" /></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="clear"></div>

                            </div>


                           <div> <%
                Html.RenderAction("PreparerSection", "INC");   
            %></div>
                             <div class="form_segment here_input_table" align="right">
                                <input type="button" value="Print" class="submit_button_light" onclick="parent.doPrintDocWin()" />
                                <input type="button" value="Submit" class="submit_button" id="btnSchool08Submit" onclick="btnSchoolValidate();
    ispDisplayProgress('btnSchool08Submit_onclick()', 'Submitting 2014 school tax information')" />
                            </div>
                           <div style="margin-left:5px;font:12px/20px opensans-regular;" class="here_input_table" >
                                <label >
				Note: DO NOT FILE THIS RETURN if you have no taxable activity. If you registered for 
				this tax and you no longer have taxable activity, complete a 
				<a href="http://www.phila.gov/revenue/Change_Form.pdf" target=_blank 
     >Change Form</a> to cancel
				your account.</label>
                            </div>
                        </div>


                    </div>

                </div>
                <div class="quicklink_btm_gen"></div>
            </div>

        </div>
    </div>--%>

    <div class="container-fluid no-padding" id="SchoolReturn_08">

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
                                            <!-- Tax Payer General Info Form -->
                                            <div class="well">

                                                <div class="row">
                                                    <form>
                                                        <div class="col-lg-4">
                                                            <p>
                                                                <strong>Name :</strong>
                                                                <label id="lblName_08" class="lblTextBlack"></label>
                                                            </p>
                                                        </div>

                                                        <div class="col-lg-4">
                                                            <p>
                                                                <strong><font id="lblEntityType_08">SSN :</font></strong>
                                                                <label id="lblEntityId_08" class="lblTextBlack"></label>
                                                            </p>
                                                        </div>

                                                    </form>
                                                </div>

                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <p>
                                                            <strong>Address :</strong>
                                                            <label id="lblAddress_08" class="lblTextBlack"></label>
                                                        </p>
                                                    </div>
                                                </div>
                                                <div class="clearfix"></div>

                                            </div>
                                            <!-- Tax Payer General Info Form END -->

                                            <!---------------------------------->
                                            <div class="row">
                                                <div class="col-lg-12 templateclass">
                                                    <form class="form-horizontal school_form">

                                                        <div class="form-group topsmallform">

                                                            <div class="col-sm-3 newtop_padding">
                                                                <label class="radio" style="font-weight: bold;">
                                                                    <input id="chkAmended_08" type="checkbox" onclick="chkAmended_08_onclick()" type="checkbox" />
                                                                    Check if amended return.</label>
                                                            </div>
                                                            <div>
                                                                <label class="col-sm-8 control-label text-custom-left2" for="inputEmail3">
                                                                    <span class="custom_padding_span">If you were a partial year resident in 2012, enter dates of residency : From: 
                                                                    <input class="inpNormal_custom" id="txtFromDate_08" onchange="ValidateSchool08Return()"
                                                                        onfocus="SetFocus()" onblur="return txtFromDate_08_onblur()"></span>
                                                                    <span>to
                                                                       <input class="inpNormal_custom" id="txtToDate_08" onchange="ValidateSchool08Return()"
                                                                           onfocus="SetFocus()" onblur="return txtToDate_08_onblur()"></label>
                                                                </span>
                                                                <div class="clearfix"></div>

                                                            </div>
                                                            <%--<div class="radio">
                                                                <label class="col-sm-9 control-label text-custom-left2" for="inputEmail3">
                                                                    <span class="pull-left">If you no longer have income subject to School Income Tax enter the termination date AND file a CHANGE FORM.</span>
                                                                    <input class="inpNormal" id="txtTerminationDate" onchange="ValidateSchool08Return()" maxlength="10"
                                                                        onfocus="SetFocus()"><span class="pull-left">
                                                                </label>
                                                            </div>--%>
                                                        </div>


                                                    </form>
                                                    <!-- Return Form -->
                                                    <div class="row ">

                                                        <div class="col-lg-12 templateclass">
                                                            <div class="table-responsive">
                                                                <table class="table table-condensed table-striped custom_table03">
                                                                    <tbody>
                                                                    </tbody>
                                                                    <tbody>
                                                                        <tr>
                                                                            <td class="text-left"><span><strong>1.</strong></span> &nbsp; Net taxable dividends </td>
                                                                            <td width="25%">
                                                                                <form class="form-horizontal">
                                                                                    <div class="form-group no-margin">
                                                                                        <div class="">
                                                                                            <input type="text" class="form-control input-sm" id="txtSchoolNo1_08" onchange="ValidateSchool08Return()" onfocus="SetFocus()" maxlength="10" />
                                                                                        </div>
                                                                                    </div>
                                                                                </form>
                                                                            </td>
                                                                        </tr>
                                                                        <tr class="odd">
                                                                            <td class="text-left"><span><strong>2.</strong></span> &nbsp; Taxable interest </td>
                                                                            <td width="25%">
                                                                                <form class="form-horizontal">
                                                                                    <div class="form-group no-margin">
                                                                                        <div class="">
                                                                                            <input type="text" class="form-control input-sm" id="txtSchoolNo2_08" onchange="ValidateSchool08Return()" onfocus="SetFocus()" maxlength="10" />
                                                                                        </div>
                                                                                    </div>
                                                                                </form>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="text-left"><span><strong>3.</strong></span> &nbsp; Distributive Shares of "Subchapter S" Corporation (If loss, enter "0")</td>
                                                                            <td width="25%">
                                                                                <form class="form-horizontal">
                                                                                    <div class="form-group no-margin">
                                                                                        <div class="">
                                                                                            <input type="text" class="form-control input-sm" id="txtSchoolNo3_08" onchange="ValidateSchool08Return()" onfocus="SetFocus()" maxlength="10" />
                                                                                        </div>
                                                                                    </div>
                                                                                </form>
                                                                            </td>
                                                                        </tr>
                                                                        <tr class="odd">
                                                                            <td class="text-left"><span><strong>4.</strong></span> &nbsp; Limited Partnership Income (If loss, enter "0")</td>
                                                                            <td width="25%">
                                                                                <form class="form-horizontal">
                                                                                    <div class="form-group no-margin">
                                                                                        <div class="">
                                                                                            <input type="text" class="form-control input-sm" id="txtSchoolNo4_08" onchange="ValidateSchool08Return()" onfocus="SetFocus()" maxlength="10" />
                                                                                        </div>
                                                                                    </div>
                                                                                </form>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="text-left"><span><strong>5.</strong></span> &nbsp; Taxable Income received by a Beneficiary from an Estate or Trust </td>
                                                                            <td width="25%">
                                                                                <form class="form-horizontal">
                                                                                    <div class="form-group no-margin">
                                                                                        <div class="">
                                                                                            <input type="text" class="form-control input-sm" id="txtSchoolNo5_08" onchange="ValidateSchool08Return()" onfocus="SetFocus()" maxlength="10" />
                                                                                        </div>
                                                                                    </div>
                                                                                </form>
                                                                            </td>
                                                                        </tr>
                                                                        <tr class="odd">
                                                                            <td class="text-left"><span><strong>6.</strong></span> &nbsp; Net Short Term Capital Gains (<strong><u>Held 6 months or less</u></strong>) (if loss, enter "0")</td>
                                                                            <td width="25%">
                                                                                <form class="form-horizontal">
                                                                                    <div class="form-group no-margin">
                                                                                        <div class="">
                                                                                            <input type="text" class="form-control input-sm" id="txtSchoolNo6_08" onchange="ValidateSchool08Return()" onfocus="SetFocus()" maxlength="10" />
                                                                                        </div>
                                                                                    </div>
                                                                                </form>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="text-left"><span><strong>7.</strong></span> &nbsp; Net Rental Income (If loss, enter "0") </td>
                                                                            <td width="25%">
                                                                                <form class="form-horizontal">
                                                                                    <div class="form-group no-margin">
                                                                                        <div class="">
                                                                                            <input type="text" class="form-control input-sm" id="txtSchoolNo7_08" onchange="ValidateSchool08Return()" onfocus="SetFocus()" maxlength="10" />
                                                                                        </div>
                                                                                    </div>
                                                                                </form>
                                                                            </td>
                                                                        </tr>
                                                                        <tr class="odd">
                                                                            <td class="text-left"><span><strong>8.</strong></span> &nbsp; Other Taxable Income</td>
                                                                            <td width="25%">
                                                                                <form class="form-horizontal">
                                                                                    <div class="form-group no-margin">
                                                                                        <div class="">
                                                                                            <input type="text" class="form-control input-sm" id="txtSchoolNo8_08" onchange="ValidateSchool08Return()" onfocus="SetFocus()" maxlength="10" />
                                                                                        </div>
                                                                                    </div>
                                                                                </form>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="text-left"><span><strong>9.</strong></span> &nbsp; Total Taxable Income [Calculated - add lines 1 through 8]&nbsp; </td>
                                                                            <td width="25%">
                                                                                <form class="form-horizontal">
                                                                                    <div class="form-group no-margin">
                                                                                        <div class="">
                                                                                            <label class="form-control input-sm" id="lblSchoolNo9_08" style="width: 100%"></label>
                                                                                        </div>
                                                                                    </div>
                                                                                </form>
                                                                            </td>
                                                                        </tr>
                                                                        <tr class="odd">
                                                                            <td class="text-left"><span><strong>10.</strong></span> &nbsp; Deductible Expenses</td>
                                                                            <td width="25%">
                                                                                <form class="form-horizontal">
                                                                                    <div class="form-group no-margin">
                                                                                        <div class="">
                                                                                            <input type="text" class="form-control input-sm" id="txtSchoolNo10_08" onchange="ValidateSchool08Return()" onfocus="SetFocus()" maxlength="10" />
                                                                                        </div>
                                                                                    </div>
                                                                                </form>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="text-left"><span><strong>11.</strong></span> &nbsp; Net Taxable Income [Calculated - line 9 minus line 10]&nbsp;</td>
                                                                            <td width="25%">
                                                                                <form class="form-horizontal">
                                                                                    <div class="form-group no-margin">
                                                                                        <div class="">
                                                                                            <label class="form-control input-sm" id="lblSchoolNo11_08" style="width: 100%"></label>
                                                                                        </div>
                                                                                    </div>
                                                                                </form>
                                                                            </td>
                                                                        </tr>
                                                                        <tr class="odd">
                                                                            <td class="text-left"><span><strong>12.</strong></span> &nbsp; Gross Tax Due [Calculated - line 11 * ###]&nbsp;</td>
                                                                            <td width="25%">
                                                                                <form class="form-horizontal">
                                                                                    <div class="form-group no-margin">
                                                                                        <div class="">
                                                                                            <label class="form-control input-sm" id="lblSchoolNo12_08" style="width: 100%"></label>
                                                                                        </div>
                                                                                    </div>
                                                                                </form>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="text-left"><span><strong>13.</strong></span> &nbsp; Credit from overpayment of prior year or tax 
				previously paid with an extension coupon</td>
                                                                            <td width="25%">
                                                                                <form class="form-horizontal">
                                                                                    <div class="form-group no-margin">
                                                                                        <div class="">
                                                                                            <input type="text" class="form-control input-sm" id="txtSchoolNo13_08" onchange="ValidateSchool08Return()" onfocus="SetFocus()" maxlength="10" />
                                                                                        </div>
                                                                                    </div>
                                                                                </form>
                                                                            </td>
                                                                        </tr>
                                                                        <tr class="odd">
                                                                            <td class="text-left"><span><strong>14.</strong></span> &nbsp; <u>TAX DUE</u> [Calculated - if line 12 greater than line 13]&nbsp;</td>
                                                                            <td width="25%">
                                                                                <form class="form-horizontal">
                                                                                    <div class="form-group no-margin">
                                                                                        <div class="">
                                                                                            <label class="form-control input-sm" id="lblSchoolNo14_08" style="width: 100%"></label>
                                                                                        </div>
                                                                                    </div>
                                                                                </form>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="text-left"><span><strong>15.</strong></span> &nbsp; <u>OVERPAYMENT OPTIONS</u> [If line 12 less than line 13, check whether amount is to be:]&nbsp;</td>
                                                                            <td width="25%">
                                                                                <form class="form-horizontal">
                                                                                    <div class="form-group no-margin">
                                                                                        <div class="">
                                                                                        </div>
                                                                                    </div>
                                                                                </form>
                                                                            </td>
                                                                        </tr>
                                                                        <tr class="odd">
                                                                            <td class="text-left"><span><strong>15A.</strong></span> &nbsp; <strong><u>Refunded</u></strong>. <strong>Do not file a separate Refund Petition</strong>. <strong>OR</strong></td>
                                                                            <td width="25%">
                                                                                <form class="form-horizontal">
                                                                                    <div class="form-group no-margin">
                                                                                        <div class="">
                                                                                            <input type="text" class="form-control input-sm" id="txtSchoolNo15a_08" onchange="ValidateSchool08Return()" onfocus="SetFocus()" maxlength="10" />
                                                                                        </div>
                                                                                    </div>
                                                                                </form>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="text-left"><span><strong>15B.</strong></span> &nbsp; <strong><u>Applied</u></strong> to the 2013 School Income Tax &nbsp;</td>
                                                                            <td width="25%">
                                                                                <form class="form-horizontal">
                                                                                    <div class="form-group no-margin">
                                                                                        <div class="">
                                                                                            <input type="text" class="form-control input-sm" id="txtSchoolNo15b_08" onchange="ValidateSchool08Return()" onfocus="SetFocus()" maxlength="10" />
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
                                                                    <input type="button" value="Submit" class="submit_button" id="btnSchool08Submit" onclick="btnSchoolValidate();
    ispDisplayProgress('btnSchool08Submit_onclick()', 'Submitting 2012 school tax information')" />
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
                                            </div>

                                            <div class="clearfix"></div>

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
