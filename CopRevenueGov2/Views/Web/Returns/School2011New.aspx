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

    <script id="clientEventHandlersJS" language="javascript" type="text/javascript">
        var dRate;
        $(document).ready(function () {
            $('.inpReadOnlyRt').parent().css("text-align", "right");
            DisplaySchool08Return();
        });
        var arrSchool08Err = new Array();
        var arrSchool08DateErr = new Array();
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
            ReloadNPT();
            if ($(parent.$g.xmlAccount).find("TAX_ACCT").find("ACCOUNT:contains('29')")) {

                parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, 'INQ', 'SCHOOL_INFO RETURN_STATUS', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ENTITY_ID', "", 0), 'SCHOOL_INFO ACCOUNT_ID', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, '12/31/2011', 'SCHOOL_INFO PERIOD', '', 0)
                ispCallXMLForm(parent.$g.xmlSchool, parent.$g.xmlSchool, "SchoolReturn", "");
                ispHideProgress();
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'ERROR_INFO ERROR', "", 0) != 0) {
                    $(parent.RightFrame).attr("rows", "*,0");
                    $('#SchoolReturn_08').css("display", "block");
                    resolvedIframeheight();
                    $('#AppHeader').html('school income tax return for 2011');
                    PopulateSchool08Header();
                    FieldLock_08(true);
                    $("#AppError").text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'ERROR_INFO MESSAGE', "", 0));
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
            resolvedIframeheight();
            $('#AppHeader').html('school income tax return for 2011');
            parent.gsInstructionItem = '#SchoolReturn';

            $('#AppMessage').html('<BR>The School Income Tax for 2011 is due April 17, 2012.');

            LoadSchool08Error();
            RightAlignText();
            CheckSchool08XML();
            SetSchool08Fields();
            PopulateSchool08Header();
            PopulateSchool08Data();
            $("#AppError").text("");


            var txtPrepAreaCode = document.getElementById("txtPrepAreaCode");
            if (txtPrepAreaCode.value == 0) {
                txtPrepAreaCode.value = "";
            }
        } //DisplaySchool08ReturnS
        function resolvedIframeheight() {
            //iframe height issue resolved
            var iframe = window.parent.document.getElementById('ifrmDocwin');
            var container = $('#tab1').css("height");
            iframe.style.height = container;
        }
        function SetSchool08Fields() {
            var chkAmended_08 = document.getElementById('chkAmended_08');
            var chkTaxpayer = document.getElementById('chkTaxpayer');
            var chkAgreement = document.getElementById('chkAgreement');
            FieldLock_08(false)
            chkAmended_08.disabled = true
            chkAmended_08.checked = false
            chkTaxpayer.checked = false
            chkAgreement.checked = false;
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO VERSION', '', 0) != '') {
                chkAmended_08.disabled = false
                FieldLock_08(true)
                chkAgreement.checked = true;

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
                $('#btnSchool08Print').attr('disabled', 'disable');
                $('#btnSchool08Submit').attr('disabled', 'disable');


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
                $('#btnSchool08Print').removeAttr('disabled');
                $('#btnSchool08Submit').removeAttr('disabled');

            }

            DisablePreparer(bDisabled);
        } //FieldLock_08

        function CheckSchool08XML() {
            var bPeriodExist = true

            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO PERIOD', '', 0) != '' && new Date(parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO PERIOD', '', 0)) < new Date('01/01/2011')) {
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

                parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, '12/31/2011', 'SCHOOL_INFO PERIOD', '', 0)
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

            dRate = parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO RATE', '', 0);

            $('#lblSchoolRate').text($('#lblSchoolRate').text().replace('###', dRate));

            dSchoolTaxRate = parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO RATE', '', 0);


            $('#txtSchoolNo1_08').val(ispFormatMoney(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'AMT_INFO NET_TAX_DIVIDENDS', '', 0), 0));
            $('#txtSchoolNo2_08').val(ispFormatMoney(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'AMT_INFO TAXABLE_INTEREST', '', 0), 0));
            $('#txtSchoolNo3_08').val(ispFormatMoney(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'AMT_INFO S_CORP_DISTRIBUTIONS', '', 0), 0));
            $('#txtSchoolNo4_08').val(ispFormatMoney(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'AMT_INFO PARTNERSHIP_INCOME', '', 0), 0));
            $('#txtSchoolNo5_08').val(ispFormatMoney(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'AMT_INFO BENEFICIARY_INCOME', '', 0), 0));
            $('#txtSchoolNo6_08').val(ispFormatMoney(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'AMT_INFO SHORT_TERM_GAINS', '', 0), 0));
            $('#txtSchoolNo7_08').val(ispFormatMoney(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'AMT_INFO NET_RENTAL_INCOME', '', 0), 0));
            $('#txtSchoolNo8_08').val(ispFormatMoney(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'AMT_INFO OTHER_TAXABLE_INCOME', '', 0), 0));
            $('#lblSchoolNo9_08').text(ispFormatMoney(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'AMT_INFO TOTAL_TAXABLE_INCOME', '', 0), 0));

            $('#txtSchoolNo10_08').val(ispFormatMoney(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'AMT_INFO DEDUCTIBLE_EXPENSES', '', 0), 0));
            $('#lblSchoolNo11_08').text(ispFormatMoney(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'AMT_INFO NET_TAXABLE_INCOME', '', 0), 0));
            $('#lblSchoolNo12_08').text(ispFormatMoney(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'AMT_INFO GROSS_TAX_DUE', '', 0), 0));
            $('#txtSchoolNo13_08').val(ispFormatMoney(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'AMT_INFO CREDITS', '', 0), 0));
            $('#lblSchoolNo14_08').text(ispFormatMoney(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'AMT_INFO TAX_DUE', '', 0), 0));
            $('#txtSchoolNo15a_08').val(ispFormatMoney(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'AMT_INFO TAX_REFUND', '', 0), 0));
            $('#txtSchoolNo15b_08').val(ispFormatMoney(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'AMT_INFO TAX_OVERPAID', '', 0), 0));

            PopulatePreparer(parent.$g.xmlSchool, 'SCHOOL_INFO');

            CalcLine14();
            CalcLine15();
        } //PopulateSchool08Data

        function PopulateSchool08XML() {
            var d = new Date()
            var lYear = String(d.getFullYear())
            var lMonth = String(d.getMonth() + 1)
            lMonth = lMonth.length == 1 ? '0' + lMonth : lMonth
            var lDate = String(d.getDate())
            lDate = lDate.length == 1 ? '0' + lDate : lDate

            parent.$x.ispXmlSetFieldVal(
            parent.$g.xmlSchool, lMonth + '/' + lDate + '/' + lYear, 'SCHOOL_INFO RECORDING_DATE', '', 0)

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, stripCurrency($('#txtSchoolNo1_08').val()), 'AMT_INFO NET_TAX_DIVIDENDS', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, stripCurrency($('#txtSchoolNo2_08').val()), 'AMT_INFO TAXABLE_INTEREST', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, stripCurrency($('#txtSchoolNo3_08').val()), 'AMT_INFO S_CORP_DISTRIBUTIONS', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, stripCurrency($('#txtSchoolNo4_08').val()), 'AMT_INFO PARTNERSHIP_INCOME', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, stripCurrency($('#txtSchoolNo5_08').val()), 'AMT_INFO BENEFICIARY_INCOME', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, stripCurrency($('#txtSchoolNo6_08').val()), 'AMT_INFO SHORT_TERM_GAINS', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, stripCurrency($('#txtSchoolNo7_08').val()), 'AMT_INFO NET_RENTAL_INCOME', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, stripCurrency($('#txtSchoolNo8_08').val()), 'AMT_INFO OTHER_TAXABLE_INCOME', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, stripCurrency($('#lblSchoolNo9_08').text()), 'AMT_INFO TOTAL_TAXABLE_INCOME', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, stripCurrency($('#txtSchoolNo10_08').val()), 'AMT_INFO DEDUCTIBLE_EXPENSES', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, stripCurrency($('#lblSchoolNo11_08').text()), 'AMT_INFO NET_TAXABLE_INCOME', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, stripCurrency($('#lblSchoolNo12_08').text()), 'AMT_INFO GROSS_TAX_DUE', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, stripCurrency($('#txtSchoolNo13_08').val()), 'AMT_INFO CREDITS', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, stripCurrency($('#lblSchoolNo14_08').text()), 'AMT_INFO TAX_DUE', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, stripCurrency($('#txtSchoolNo15a_08').val()), 'AMT_INFO TAX_REFUND', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, stripCurrency($('#txtSchoolNo15b_08').val()), 'AMT_INFO TAX_OVERPAID', '', 0)

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

            arrSchool08Err[i++] = [txtSchoolNo1_08, '$(\'#txtSchoolNo1_08\').val() == ""', 'Answer question 1']
            arrSchool08Err[i++] = [txtSchoolNo1_08, 'ispValue($(\'#txtSchoolNo1_08\').val()) == false', 'Value for question 1 must be numeric']
            arrSchool08Err[i++] = [txtSchoolNo1_08, 'ispNegativeNumber($(\'#txtSchoolNo1_08\').val()) == false', 'Value for question 1 must not be negative']

            arrSchool08Err[i++] = [txtSchoolNo2_08, '$(\'#txtSchoolNo2_08\').val() == ""', 'Answer question 2']
            arrSchool08Err[i++] = [txtSchoolNo2_08, 'ispValue($(\'#txtSchoolNo2_08\').val()) == false', 'Value for question 2 must be numeric']
            arrSchool08Err[i++] = [txtSchoolNo2_08, 'ispNegativeNumber($(\'#txtSchoolNo2_08\').val()) == false', 'Value for question 2 must not be negative']

            arrSchool08Err[i++] = [txtSchoolNo3_08, '$(\'#txtSchoolNo3_08\').val() == ""', 'Answer question 3']
            arrSchool08Err[i++] = [txtSchoolNo3_08, 'ispValue($(\'#txtSchoolNo3_08\').val()) == false', 'Value for question 3 must be numeric']
            arrSchool08Err[i++] = [txtSchoolNo3_08, 'ispNegativeNumber($(\'#txtSchoolNo3_08\').val()) == false', 'Value for question 3 must not be negative']

            arrSchool08Err[i++] = [txtSchoolNo4_08, '$(\'#txtSchoolNo4_08\').val() == ""', 'Answer question 4']
            arrSchool08Err[i++] = [txtSchoolNo4_08, 'ispValue($(\'#txtSchoolNo4_08\').val()) == false', 'Value for question 4 must be numeric']
            arrSchool08Err[i++] = [txtSchoolNo4_08, 'ispNegativeNumber($(\'#txtSchoolNo4_08\').val()) == false', 'Value for question 4 must not be negative']

            arrSchool08Err[i++] = [txtSchoolNo5_08, '$(\'#txtSchoolNo5_08\').val() == ""', 'Answer question 5']
            arrSchool08Err[i++] = [txtSchoolNo5_08, 'ispValue($(\'#txtSchoolNo5_08\').val()) == false', 'Value for question 5 must be numeric']
            arrSchool08Err[i++] = [txtSchoolNo5_08, 'ispNegativeNumber($(\'#txtSchoolNo5_08\').val()) == false', 'Value for question 5 must not be negative']

            arrSchool08Err[i++] = [txtSchoolNo6_08, '$(\'#txtSchoolNo6_08\').val() == ""', 'Answer question 6']
            arrSchool08Err[i++] = [txtSchoolNo6_08, 'ispValue($(\'#txtSchoolNo6_08\').val()) == false', 'Value for question 6 must be numeric']
            arrSchool08Err[i++] = [txtSchoolNo6_08, 'ispNegativeNumber($(\'#txtSchoolNo6_08\').val()) == false', 'Value for question 6 must not be negative']

            arrSchool08Err[i++] = [txtSchoolNo7_08, '$(\'#txtSchoolNo7_08\').val() == ""', 'Answer question 7']
            arrSchool08Err[i++] = [txtSchoolNo7_08, 'ispValue($(\'#txtSchoolNo7_08\').val()) == false', 'Value for question 7 must be numeric']
            arrSchool08Err[i++] = [txtSchoolNo7_08, 'ispNegativeNumber($(\'#txtSchoolNo7_08\').val()) == false', 'Value for question 7 must not be negative']

            arrSchool08Err[i++] = [txtSchoolNo8_08, '$(\'#txtSchoolNo8_08\').val() == ""', 'Answer question 8']
            arrSchool08Err[i++] = [txtSchoolNo8_08, 'ispValue($(\'#txtSchoolNo8_08\').val()) == false', 'Value for question 8 must be numeric']
            arrSchool08Err[i++] = [txtSchoolNo8_08, 'ispNegativeNumber($(\'#txtSchoolNo8_08\').val()) == false', 'Value for question 8 must not be negative']

            arrSchool08Err[i++] = [txtSchoolNo10_08, '$(\'#txtSchoolNo10_08\').val() == ""', 'Answer question 10']
            arrSchool08Err[i++] = [txtSchoolNo10_08, 'ispValue($(\'#txtSchoolNo10_08\').val()) == false', 'Value for question 10 must be numeric']
            arrSchool08Err[i++] = [txtSchoolNo10_08, 'ispNegativeNumber($(\'#txtSchoolNo10_08\').val()) == false', 'Value for question 10 must not be negative']

            arrSchool08Err[i++] = [txtSchoolNo13_08, '$(\'#txtSchoolNo13_08\').val() == ""', 'Answer question 13']
            arrSchool08Err[i++] = [txtSchoolNo13_08, 'ispValue($(\'#txtSchoolNo13_08\').val()) == false', 'Value for question 13 must be numeric']
            arrSchool08Err[i++] = [txtSchoolNo13_08, 'ispNegativeNumber($(\'#txtSchoolNo13_08\').val()) == false', 'Value for question 13 must not be negative']

            arrSchool08Err[i++] = [txtSchoolNo15a_08, '$(\'#txtSchoolNo15a_08\').val() == ""', 'Answer question 15A']
            arrSchool08Err[i++] = [txtSchoolNo15a_08, 'ispValue($(\'#txtSchoolNo15a_08\').val()) == false', 'Value for question 15A must be numeric']
            arrSchool08Err[i++] = [txtSchoolNo15a_08, 'ispNegativeNumber($(\'#txtSchoolNo15a_08\').val()) == false', 'Value for question 15A must not be negative']

            arrSchool08Err[i++] = [txtSchoolNo15b_08, '$(\'#txtSchoolNo15b_08\').val() == ""', 'Answer question 15B']
            arrSchool08Err[i++] = [txtSchoolNo15b_08, 'ispValue($(\'#txtSchoolNo15b_08\').val()) == false', 'Value for question 15B must be numeric']
            arrSchool08Err[i++] = [txtSchoolNo15b_08, 'ispNegativeNumber($(\'#txtSchoolNo15b_08\').val()) == false', 'Value for question 15B must not be negative']
            // added manoranjan
            var txtFromDate_08 = document.getElementById('txtFromDate_08');
            var txtToDate_08 = document.getElementById('txtToDate_08');
            i = 0;


            arrSchool08DateErr[i++] = [txtFromDate_08, 'new Date($(\'#txtFromDate_08\').val()) > new Date((new Date().getMonth() + 1) + " / " + new Date().getDate() + " / " + new Date().getFullYear()) ', 'From date should not be greater than current date.'];
            arrSchool08DateErr[i++] = [txtFromDate_08, 'new Date($(\'#txtFromDate_08\').val()) > new Date(document.getElementById("txtToDate_08").value) ', 'From date should not be greater than To date.'];


            arrSchool08DateErr[i++] = [txtToDate_08, 'new Date($(\'#txtToDate_08\').val()) > new Date((new Date().getMonth() + 1) + " / " + new Date().getDate() + " / " + new Date().getFullYear()) ', 'To date should not be greater than current date.'];
            arrSchool08DateErr[i++] = [txtToDate_08, 'new Date($("#txtToDate_08").val()) < new Date(document.getElementById("txtFromDate_08").value) ', 'To date should not be less than From date.'];



        } //LoadSchool08Error
        function ValidateSchool08Date() {
            $("#AppError").text('');
            $("#AppError").text(ispSetInputErr1(arrSchool08DateErr));
            if ($("#AppError").text() != '') {
                resolvedIframeheight();
                parent.ScrollTop(arrSchool08DateErr);
            }
        }
        function ValidateSchool08Return() {
            var evt = window.event || arguments.callee.caller.arguments[0];
            var source = parent.getEventSource(evt);
            var ObjSelected = source;
            $("#AppError").text("");
            if (ObjSelected) {
                if (ObjSelected.type != 'button') {
                    ObjSelected.value = ispFormatMoney(ObjSelected.value, 0);
                }
            }
            $("#AppError").text(ispSetInputErr_Form(arrSchool08Err));
            if ($("#AppError").text() == '') {
                CalcLine9();
                CalcLine11();
                CalcLine12(dSchoolTaxRate);
                CalcLine14();
                CalcLine15();
            } else {
                resolvedIframeheight();
                parent.ScrollTop(1);
            } //if
        } //ValidateSchool08Return

        function btnSchool08Print_onclick() {
            $('#btnSchool08Print').css('visibility', 'hidden');
            $('#btnSchool08Submit').css('visibility', 'hidden');

            $("#AppError").text('');
            if ($('#txtSchoolNo1_08').disabled == true) {
                FieldLock_08(false);
                window.print();
                FieldLock_08(true);
            } else {
                window.print();
            } //if

            $('#btnSchool08Print').css('visibility', 'visible');
            $('#btnSchool08Submit').css('visibility', 'visible');




        } //btnSchool08Print_onclick

        function btnSchoolValidate() {
            ValidateSchool08Date();
            if ($("#AppError").text() == '') {
                ValidateSchool08Return();
                if ($("#AppError").text() == '') {
                    ValidateSchool08Return();
                } //if
                if ($("#AppError").text() == '') {
                    $("#AppError").text(ValidatePreparer());
                    if ($("#AppError").text() != '') {
                        resolvedIframeheight();
                        parent.ScrollTop(ValidatePreparer());
                    }
                } //if
            }
        } //btnWageValidate
        var tempXML = parent.$g.getXmlDocObj();

        function btnSchool08Submit_onclick() {
            if ($("#AppError").text() == '') {
                txtFromDate_08_onblur()
                txtToDate_08_onblur()
                if ($("#AppError").text() == '') {
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, '', 'SCHOOL_INFO RETURN_STATUS', '', 0)
                    PopulateSchool08XML()
                    ispCallXMLForm(parent.$g.xmlSchool, parent.$g.xmlSchool, "SchoolReturn", "")
                    ispHideProgress()
                    if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'ERROR_INFO PROGRAM', '', 0) == '') {
                        $('#SchoolReturn_08').css('display', 'none');
                        DisplaySchoolThankYou()
                    } else {
                        $("#AppError").text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'ERROR_INFO MESSAGE', '', 0));
                    } //if
                } //if
            } else {
                ispHideProgress()
            } //if
        } //btnSchool08Submit_onclick

        function txtToDate_08_onblur() {
            debugger;
            if ($("#AppError").text() == '' && $('#txtToDate_08').val() != '') {
                var strBD = ispValidateDate($('#txtToDate_08').val());
                if (strBD == false) {
                    $("#AppError").text('Invalid To date');
                    blnErr = true
                } else {
                    $('#txtToDate_08').val(strBD);
                } //if
            }
        } //txtToDate_08_onblur

        function txtFromDate_08_onblur() {
            debugger;
            if ($("#AppError").text() == "" && $('#txtFromDate_08').val() != '') {
                var strBD = ispValidateDate($('#txtFromDate_08').val());
                if (strBD == false) {
                    $("#AppError").text('Invalid From date');
                    blnErr = true
                } else {
                    $('#txtFromDate_08').val(strBD);
                } //if
            }
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
            if ($('#txtSchoolNo1_08').val() != "" && $('#txtSchoolNo2_08').val() != "" && $('#txtSchoolNo3_08').val() != "" && $('#txtSchoolNo4_08').val() != "" && $('#txtSchoolNo5_08').val() != "" && $('#txtSchoolNo6_08').val() != "" && $('#txtSchoolNo7_08').val() != "" && $('#txtSchoolNo8_08').val() != "") {
                $('#lblSchoolNo9_08').text(ispFormatMoney(ispRemoveMoney($('#txtSchoolNo1_08').val()) + ispRemoveMoney($('#txtSchoolNo2_08').val()) + ispRemoveMoney($('#txtSchoolNo3_08').val()) + ispRemoveMoney($('#txtSchoolNo4_08').val()) + ispRemoveMoney($('#txtSchoolNo5_08').val()) + ispRemoveMoney($('#txtSchoolNo6_08').val()) + ispRemoveMoney($('#txtSchoolNo7_08').val()) + ispRemoveMoney($('#txtSchoolNo8_08').val()), 0));
            }
        }

        function CalcLine11() {
            if ($('#lblSchoolNo9_08').text() != '' && $('#txtSchoolNo10_08').val() != "") {
                $('#lblSchoolNo11_08').text(ispFormatMoney(ispRemoveMoney($('#lblSchoolNo9_08').text()) - ispRemoveMoney($('#txtSchoolNo10_08').val()), 0));
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
            if ($('#txtSchoolNo13_08').val() == '') {
                $('#txtSchoolNo13_08').text(ispFormatMoney(0, 0));
            }
            var val_12 = ispRemoveMoney($('#lblSchoolNo12_08').text());
            var val_13 = ispRemoveMoney($('#txtSchoolNo13_08').val());
            $('#lblSchoolNo14_08').text(ispFormatMoney(val_12 - val_13, 0));
        }

        //'EGOVWEB-60 - Created CalcLine15
        function CalcLine15() {
            if ($('#txtSchoolNo15a_08').val() == '') {
                $('#txtSchoolNo15a_08').val(ispFormatMoney(0, 0));
            }

            if ($('#txtSchoolNo15b_08').val() == '') {
                $('#txtSchoolNo15b_08').val(ispFormatMoney(0, 0));
            }
            var dvalue = ispRemoveMoney($('#lblSchoolNo14_08').text());
            if (dvalue < 0) {

                if ((ispRemoveMoney($('#txtSchoolNo15a_08').val()) + ispRemoveMoney($('#txtSchoolNo15b_08').val())) != Math.abs(ispRemoveMoney($('#lblSchoolNo14_08').text()))) {
                    $("#AppError").text("Lines 15a and 15b must equal Line 14");
                    $('#txtSchoolNo15a_08').attr('class', 'inpError form-control input-sm pull-right');
                    $('#txtSchoolNo15b_08').attr('class', 'inpError form-control input-sm pull-right');
                    parent.ScrollTop(1);// Here 1 for some default value.
                }
                else {
                    $('#txtSchoolNo15a_08').attr('class', 'inpNormal form-control input-sm pull-right');
                    $('#txtSchoolNo15b_08').attr('class', 'inpNormal form-control input-sm pull-right');
                }
            } else {
                $('#txtSchoolNo15a_08').attr('class', 'inpNormal form-control input-sm pull-right');
                $('#txtSchoolNo15b_08').attr('class', 'inpNormal form-control input-sm pull-right');
                $('#txtSchoolNo15a_08').val(ispFormatMoney(0, 0));
                $('#txtSchoolNo15b_08').val(ispFormatMoney(0, 0));
            }
        }


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
    <div class="container-fluid no-padding" id="SchoolReturn_08">
  <div class="block3">
    <div class="container-fluid">
      <div class="row">
        <div class="col-lg-12 col-md-12" style="display: block;" id="tab1">
          <div class="blue_base_box">           
            <h2>Taxpayer Information  | <span id="AppHeader"></span> </h2>
            <div class="inner_white-panel">
              <div class="col-lg-12 col-lg-offset-0 no-padding-left">
                <div id="AppError" class="errormsg no-padding" style="display:block;"> </div>
              </div>
              <br />
              <div class="contentsection sit-print-section school-warp">
                <h4 id="AppMessage">&nbsp;</h4>
                <div class="clearfix"></div>
                <br>
                <div class="row">
                  <div class="col-lg-12">                 
                    
                    <div class="well">
                      <div class="row">
                        <form>
                          <div class="col-lg-9 col-md-9 col-sm-9 col-xs-8">
                            <p> <span>Name:</span> <span id="lblName_08" class=""></span> </p>
                          </div>
                          <div class="col-lg-3 col-md-3 col-sm-3 col-xs-4">
                            <p> <span id="lblEntityType_08">EIN:</span> <span id="lblEntityId_08" class=""></span> </p>
                          </div>
                        </form>
                      </div>
                      <div class="row">
                        <div class="col-lg-9 col-md-9 col-sm-9 col-xs-8">
                          <p> <span>Address:</span> <span id="lblAddress_08" class=""></span> </p>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-3 col-xs-4"> </div>
                      </div>
                      <div class="clearfix"></div>
                    </div>
                    
                    <!---------------------------------->
                    <div class="row">
                      <div class="col-lg-12 templateclass">
                        <form class="form-horizontal school_form">
                          <div class="row">
                            <div class="col-sm-12 col-xs-12 newtop_padding">
                              <label <%--class="radio"--%> style="font-weight: bold;">
                                <input id="chkAmended_08" type="checkbox" onclick="chkAmended_08_onclick()" />
                                Check if amended return.</label>
                            </div>
                            <div class="clearfix"></div>
                            <div class="col-sm-12 col-xs-12 newtop_padding after-amended-sit"style="padding-left:0;">
                              <div class="col-lg-6 col-md-12 col-sm-12 col-xs-12">
                                <label  class="text-custom-left2" for="inputEmail3"> <span class="custom_padding_span">If you were a partial year resident in 2011, enter dates of residency :</span></label>
                              </div>
                              <div class="col-lg-6 col-md-12 col-sm-12 col-xs-12 new-margin-top-form wage-form-date" style="padding-left:0; margin-left:0;">
                                <label><span class="wage-from-date"> From:
                                  <input class="inpNormal_custom date-input date-field-design" style="width:32%;" id="txtFromDate_08" onchange="ValidateSchool08Date()" placeholder="MM/DD/YYYY"
                                                                         onblur="return txtFromDate_08_onblur();">
                                  </span>
                                 
                                  &nbsp<span class="wage-to-date"> To:
                                  <input class="inpNormal_custom date-input  date-field-design" style="width:32%;" id="txtToDate_08" onchange="ValidateSchool08Date()" placeholder="MM/DD/YYYY"
                                                                         onblur="return txtToDate_08_onblur();">
                                  </span></label>
                              
                              </div>
                              <div class="clearfix"></div>
                            </div>
                          </div>
                          <div class="row" style="display:none">
                            <div class="col-sm-8 newtop_padding">
                              <label class="control-label text-custom-left2" for="inputEmail3"> <span class="pull-left">If you no longer have income subject to School Income Tax enter the termination date AND file a CHANGE FORM.</span> </label>
                            </div>
                            <div class="col-sm-2 newtop_padding margin-below">
                              <input class="inpNormal_custom date-input date-field-design" id="txtTerminationDate" placeholder="MM/DD/YYYY" onchange="ValidateSchool08Date()" maxlength="10" style="WIDTH: 70%;"
                                                                        onfocus="SetFocus()" onblur="return txtTerminationDate_onblur()">
                            </div>
                          </div>
                        </form>
                        
                        <!-- Return Form -->
                        <div class="row ">
                          <div class="col-lg-12 templateclass">
                            <div class="row table-responsive">
                              <div class="col-lg-12" >
                                <table class="table table-condensed table-striped custom_table03">
                                  <tbody>
                                  </tbody>
                                  <tbody>
                                    <tr>
                                      <td width="5%">1.</td>
                                      <td width="70%" class="text-left">Net taxable dividends </td>
                                      <td width="25%" class="text-left"><Div class="form-horizontal">
                                          <div class="form-group no-margin">
                                            <div class="">
                                              <input type="text" class="form-control input-sm pull-right"  id="txtSchoolNo1_08" onchange="ValidateSchool08Return()" onfocus="SetFocus()" maxlength="10" style="WIDTH: 70%;" />
                                            </div>
                                          </div>
                                        </Div></td>
                                    </tr>
                                    <tr class="odd">
                                      <td width="5%">2.</td>
                                      <td width="70%" class="text-left">Taxable interest </td>
                                      <td width="25%" class="text-left"><form class="form-horizontal">
                                          <div class="form-group no-margin">
                                            <div class="">
                                              <input type="text" class="form-control input-sm pull-right"  id="txtSchoolNo2_08" onchange="ValidateSchool08Return()" onfocus="SetFocus()" maxlength="10" style="WIDTH: 70%;"/>
                                            </div>
                                          </div>
                                        </form></td>
                                    </tr>
                                    <tr>
                                      <td width="5%">3.</td>
                                      <td width="70%" class="text-left">Distributive Shares of "Subchapter S" Corporation (If loss, enter "0")</td>
                                      <td width="25%" class="text-left"><form class="form-horizontal">
                                          <div class="form-group no-margin">
                                            <div class="">
                                              <input type="text" class="form-control input-sm pull-right" style="WIDTH: 70%;" id="txtSchoolNo3_08" onchange="ValidateSchool08Return()" onfocus="SetFocus()" maxlength="10" />
                                            </div>
                                          </div>
                                        </form></td>
                                    </tr>
                                    <tr class="odd">
                                      <td width="5%">4.</td>
                                      <td width="70%" class="text-left">Limited Partnership Income (If loss, enter "0")</td>
                                      <td width="25%" class="text-left"><form class="form-horizontal">
                                          <div class="form-group no-margin">
                                            <div class="">
                                              <input type="text" class="form-control input-sm pull-right" id="txtSchoolNo4_08" onchange="ValidateSchool08Return()" onfocus="SetFocus()" maxlength="10" style="WIDTH: 70%;"/>
                                            </div>
                                          </div>
                                        </form></td>
                                    </tr>
                                    <tr>
                                      <td width="5%">5.</td>
                                      <td width="70%" class="text-left">Taxable Income received by a Beneficiary from an Estate or Trust </td>
                                      <td width="25%" class="text-left"><form class="form-horizontal">
                                          <div class="form-group no-margin">
                                            <div class="">
                                              <input type="text" class="form-control input-sm pull-right" id="txtSchoolNo5_08" onchange="ValidateSchool08Return()" onfocus="SetFocus()" maxlength="10" style="WIDTH: 70%;"/>
                                            </div>
                                          </div>
                                        </form></td>
                                    </tr>
                                    <tr class="odd">
                                      <td width="5%">6.</td>
                                      <td width="70%" class="text-left">Net Short Term Capital Gains (<strong><u>Held 6 months or less</u></strong>) (if loss, enter "0")</td>
                                      <td width="25%" class="text-left"><form class="form-horizontal">
                                          <div class="form-group no-margin">
                                            <div class="">
                                              <input type="text" class="form-control input-sm pull-right" id="txtSchoolNo6_08" onchange="ValidateSchool08Return()" onfocus="SetFocus()" maxlength="10" style="WIDTH: 70%;"/>
                                            </div>
                                          </div>
                                        </form></td>
                                    </tr>
                                    <tr>
                                      <td width="5%">7.</td>
                                      <td width="70%" class="text-left">Net Rental Income (If loss, enter "0") </td>
                                      <td width="25%" class="text-left"><form class="form-horizontal">
                                          <div class="form-group no-margin">
                                            <div class="">
                                              <input type="text" class="form-control input-sm pull-right" id="txtSchoolNo7_08" onchange="ValidateSchool08Return()" onfocus="SetFocus()" maxlength="10" style="WIDTH: 70%;"/>
                                            </div>
                                          </div>
                                        </form></td>
                                    </tr>
                                    <tr class="odd">
                                      <td width="5%">8.</td>
                                      <td width="70%" class="text-left">Other Taxable Income</td>
                                      <td width="25%" class="text-left"><form class="form-horizontal">
                                          <div class="form-group no-margin">
                                            <div class="">
                                              <input type="text" class="form-control input-sm pull-right" id="txtSchoolNo8_08" onchange="ValidateSchool08Return()" onfocus="SetFocus()" maxlength="10" style="WIDTH: 70%;"/>
                                            </div>
                                          </div>
                                        </form></td>
                                    </tr>
                                    <tr>
                                      <td width="5%">9.</td>
                                      <td width="70%" class="text-left">Total Taxable Income [Calculated - add lines 1 through 8]&nbsp; </td>
                                      <td width="25%" class="text-left"><form class="form-horizontal">
                                          <div class="form-group no-margin">
                                            <div class="">
                                              <label class="form-control input-sm pull-right" id="lblSchoolNo9_08" style="WIDTH: 70%;"></label>
                                            </div>
                                          </div>
                                        </form></td>
                                    </tr>
                                    <tr class="odd">
                                      <td width="5%">10.</td>
                                      <td width="70%" class="text-left">Deductible Expenses</td>
                                      <td width="25%" class="text-left"><form class="form-horizontal">
                                          <div class="form-group no-margin">
                                            <div class="">
                                              <input type="text" class="form-control input-sm pull-right" id="txtSchoolNo10_08" onchange="ValidateSchool08Return()" onfocus="SetFocus()" maxlength="10" style="WIDTH: 70%;"/>
                                            </div>
                                          </div>
                                        </form></td>
                                    </tr>
                                    <tr>
                                      <td width="5%">11.</td>
                                      <td width="70%" class="text-left">Net Taxable Income [Calculated - line 9 minus line 10]&nbsp;</td>
                                      <td width="25%" class="text-left"><form class="form-horizontal">
                                          <div class="form-group no-margin">
                                            <div class="">
                                              <label class="form-control input-sm pull-right" id="lblSchoolNo11_08" style="WIDTH: 70%;"></label>
                                            </div>
                                          </div>
                                        </form></td>
                                    </tr>
                                    <tr class="odd">
                                      <td width="5%">12.</td>
                                      <td width="70%" class="text-left">Gross Tax Due <span class="" id="lblSchoolRate" style="float:none;">[Calculated - line 11 * ###]</span>&nbsp;</td>
                                      <td width="25%" class="text-left"><form class="form-horizontal">
                                          <div class="form-group no-margin">
                                            <div class="">
                                              <label class="form-control input-sm pull-right" id="lblSchoolNo12_08" style="WIDTH: 70%;"></label>
                                            </div>
                                          </div>
                                        </form></td>
                                    </tr>
                                    <tr>
                                      <td width="5%">13.</td>
                                      <td width="70%" class="text-left">Credit from overpayment of prior year or tax previously paid with an extension coupon</td>
                                      <td width="25%" class="text-left"><form class="form-horizontal">
                                          <div class="form-group no-margin">
                                            <div class="">
                                              <input type="text" class="form-control input-sm pull-right" id="txtSchoolNo13_08" onchange="ValidateSchool08Return()" onfocus="SetFocus()" maxlength="10" style="WIDTH: 70%;"/>
                                            </div>
                                          </div>
                                        </form></td>
                                    </tr>
                                    <tr class="odd">
                                      <td width="5%">14.</td>
                                      <td width="70%" class="text-left"><u>TAX DUE</u> [Calculated - if line 12 greater than line 13]&nbsp;</td>
                                      <td width="25%" class="text-left"><form class="form-horizontal">
                                          <div class="form-group no-margin">
                                            <div class="">
                                              <label class="form-control input-sm pull-right" id="lblSchoolNo14_08" style="WIDTH: 70%;"></label>
                                            </div>
                                          </div>
                                        </form></td>
                                    </tr>
                                    <tr>
                                      <td width="5%">15.</td>
                                      <td width="70%" class="text-left"><u>OVERPAYMENT OPTIONS</u> [If line 12 less than line 13, check whether amount is to be:]&nbsp;</td>
                                      <td width="25%" class="text-left"><form class="form-horizontal">
                                          <div class="form-group no-margin">
                                            <div class=""> </div>
                                          </div>
                                        </form></td>
                                    </tr>
                                    <tr class="odd">
                                      <td width="5%">15A.</td>
                                      <td width="70%" class="text-left"><strong><u>Refunded</u></strong>. <strong>Do not file a separate Refund Petition</strong>. <strong>OR</strong></td>
                                      <td width="25%" class="text-left"><form class="form-horizontal">
                                          <div class="form-group no-margin">
                                            <div class="">
                                              <input type="text" class="form-control input-sm pull-right" id="txtSchoolNo15a_08" onchange="ValidateSchool08Return()" onfocus="SetFocus()" maxlength="10" style="WIDTH: 70%;"/>
                                            </div>
                                          </div>
                                        </form></td>
                                    </tr>
                                    <tr>
                                      <td width="5%">15B.</td>
                                      <td width="70%" class="text-left"><strong><u>Applied</u></strong> to the 2012 School Income Tax &nbsp;</td>
                                      <td width="25%" class="text-left"><form class="form-horizontal">
                                          <div class="form-group no-margin">
                                            <div class="">
                                              <input type="text" class="form-control input-sm pull-right" id="txtSchoolNo15b_08" onchange="ValidateSchool08Return()" onfocus="SetFocus()" maxlength="10" style="WIDTH: 70%;"/>
                                            </div>
                                          </div>
                                        </form></td>
                                    </tr>
                                  </tbody>
                                  <tbody>
                                  </tbody>
                                </table>
                              </div>
                            </div>
                            
                          
                            <form class="form-horizontal form-year-background">
                              <div>
                                <%
                                                            Html.RenderAction("PreparerSection", "INC");   
                                                        %>
                              </div>
                              <div class="form-group submit-button-for-print">
                                <div class="col-sm-offset-3 col-sm-9  text-right">
                                  <input id="btnSchool08Print" type="button" value="Print" class="btn btn-default submit_button_light" onclick="btnSchool08Print_onclick()" />
                                  <input type="button" value="Submit" class="btn btn-default submit_button" id="btnSchool08Submit"  onclick="btnSchoolValidate(); ispDisplayProgress('btnSchool08Submit_onclick()', 'Submitting 2011 school tax information')" />
                                </div>
                              </div>
                              <div class="clearfix"></div>
                              <div class="col-md-12">
                                <div style="margin-left: 5px; font: 12px/20px opensans-regular;" class="here_input_table sit_here_input_table">
                                  <label> Note: DO NOT FILE THIS RETURN if you have no taxable activity. If you registered for 
                                    this tax and you no longer have taxable activity, complete a &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </label>
                                  <div class="clearfix"></div>
                                  <label style="margin-top:0;"><a href="https://beta.phila.gov/media/20170207132309/Change-Form.pdf" target="_blank">Change Form</a>to cancel your account.</label>
                                </div>
                              </div>
                            </form>
                           
                          </div>
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

