<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>

<html>
<head>
<script src="../js/JqueryMin.js" type="text/javascript"></script>
<script id="clientEventHandlersJS" language="javascript" type="text/javascript">
    var dRate;
    $(document).ready(function () {
        $('.inpReadOnlyRt').parent().css("text-align", "right");
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

        parent.$g.loadXmlSync('XML/SchoolReturn', parent.MenuWin.parseXml_xmlSchoolTemplate);

    }

    function DisplaySchool08Return() {

        ReloadNPT();
        if ($(parent.$g.xmlAccount).find("TAX_ACCT").find("ACCOUNT:contains('29')")) {
            parent.MenuWin.ispHighlightMenu(parent.MenuWin.mnuSchoolYear11)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, 'INQ', 'SCHOOL_INFO RETURN_STATUS', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ENTITY_ID', "", 0), 'SCHOOL_INFO ACCOUNT_ID', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, '12/31/2011', 'SCHOOL_INFO PERIOD', '', 0)
            ispCallXMLForm(parent.$g.xmlSchool, parent.$g.xmlSchool, "SchoolReturn", "");
            ispHideProgress();
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'ERROR_INFO ERROR', "", 0) != 0) {
                $(parent.RightFrame).attr("rows", "*,0");
                $('#SchoolReturn_08').css("display", "block");
                $('#AppHeader').html(txtHeader + '<Font class=hdrMedium>|school income tax return for 2011</Font>');
                PopulateSchool08Header();
                FieldLock_08(true);
                $('#AppHeader').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'ERROR_INFO MESSAGE', "", 0));
                $('#btnSchool08Submit').attr('disabled', 'disable');
                $('#chkAmended_08').attr('disabled', 'disable');
                return
            } //if
            if ($(parent.MenuWin.divAcctInfo).css("display") == 'none') {
                $(parent.MenuWin.divAcctInfo).css("display", "block");
                $(parent.MenuWin.divAccount).css("display", "none");
            } //if
        } else {
            parent.$g.xmlSchool.xml = parent.$g.xmlSchoolTemplate;
            parent.MenuWin.ispMenu_onclick(parent.MenuWin.mnuAcctInfo);
        } //if
        $(parent.RightFrame).attr("rows", "*,0");
        $('#SchoolReturn_08').css("display", "block");
        $('#AppHeader').html(txtHeader + '<Font class=hdrMedium>|school income tax return for 2011</Font>');
        parent.MenuWin.gsInstructionItem = '#SchoolReturn';
        $('#AppMessage').html(parent.MenuWin.gsInstructionText + '<BR>The School Income Tax for 2011 is due April 15, 2012.');
        $('#InstructionText').html(' for Instructions on filing this return');

        LoadSchool08Error();
        RightAlignText();
        CheckSchool08XML();
        SetSchool08Fields();
        PopulateSchool08Header();
        PopulateSchool08Data();
        $('#AppError').text("");
    } //DisplaySchool08Return

    function SetSchool08Fields() {
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
        var evt = window.event || arguments.callee.caller.arguments[0];
        var source = parent.MenuWin.getEventSource(evt);
        var ObjSelected
        $('#AppError').text('');


        if (source != null) {
            var sId = source.id;
            ObjSelected = document.getElementById(sId)

            if (ObjSelected != null) {
                if (sId == "txtToDate_08" || sId == "txtFromDate_08" || source.type == 'button') { } else {
                    ObjSelected.value = ispFormatMoney(ObjSelected.value, 0)
                } //if
            }
        }

        $('#AppError').text(ispSetInputErr(arrSchool08Err));
        if ($('#AppError').text() == '') {
            CalcLine9();
            CalcLine11();
            CalcLine12(dSchoolTaxRate);
            CalcLine14();
            CalcLine15();
        } else {
            AppError.scrollIntoView(true);
        } //if
    } //ValidateSchool08Return

    function btnSchool08Print_onclick() {
        $('#btnSchool08Print').css('visibility', 'hidden');
        $('#btnSchool08Submit').css('visibility', 'hidden');


        $('#AppError').text('');

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
        ValidateSchool08Return();
        if ($('#AppError').text() == '') {
            ValidateSchool08Return();
        } //if
        if ($('#AppError').text() == '') {
            $('#AppError').text(ValidatePreparer());
        } //if
    } //btnWageValidate
    var tempXML = parent.$g.getXmlDocObj();

    function btnSchool08Submit_onclick() {
        if ($('#AppError').text() == '') {
            txtFromDate_08_onblur()
            txtToDate_08_onblur()
            if ($('#AppError').text() == '') {
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlSchool, '', 'SCHOOL_INFO RETURN_STATUS', '', 0)
                PopulateSchool08XML()
                parent.DocWin.ispCallXMLForm(parent.$g.xmlSchool, parent.$g.xmlSchool, "SchoolReturn", "")
                ispHideProgress()
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'ERROR_INFO PROGRAM', '', 0) == '') {
                    $('#SchoolReturn_08').css('display', 'none');
                    DisplaySchoolThankYou()
                } else {
                    $('#AppError').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'ERROR_INFO MESSAGE', '', 0));
                } //if
            } //if
        } else {
            ispHideProgress()
        } //if
    } //btnSchool08Submit_onclick

    function txtToDate_08_onblur() {
        if ($('#AppError').text() == '' && txtToDate_08.value != "") {
            var strBD = ispValidateDate(txtToDate_08.value)

            if (strBD == false) {
                AppError.innerText = 'Invalid to date'
                txtToDate_08.className = 'inpError'
                blnErr = true
            } else {
                txtToDate_08.className = 'inpNormal'
                txtToDate_08.value = strBD
            } //if
        } else {
            txtToDate_08.className = 'inpNormal'
        } //if
    } //txtToDate_08_onblur

    function txtFromDate_08_onblur() {
        if (AppError.innerText == "" && txtFromDate_08.value != "") {
            var strBD = ispValidateDate(txtFromDate_08.value)

            if (strBD == false) {
                AppError.innerText = 'Invalid from date'
                txtFromDate_08.className = 'inpError'
                blnErr = true
            } else {
                txtFromDate_08.className = 'inpNormal'
                txtFromDate_08.value = strBD
            } //if
        } else {
            txtFromDate_08.className = 'inpNormal'
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
        var source = parent.MenuWin.getEventSource(evt);
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
        if (txtSchoolNo1_08.value != "" && txtSchoolNo2_08.value != "" && txtSchoolNo3_08.value != "" && txtSchoolNo4_08.value != "" && txtSchoolNo5_08.value != "" && txtSchoolNo6_08.value != "" && txtSchoolNo7_08.value != "" && txtSchoolNo8_08.value != "") {
            $('#lblSchoolNo9_08').text(ispFormatMoney(ispRemoveMoney(txtSchoolNo1_08.value) + ispRemoveMoney(txtSchoolNo2_08.value) + ispRemoveMoney(txtSchoolNo3_08.value) + ispRemoveMoney(txtSchoolNo4_08.value) + ispRemoveMoney(txtSchoolNo5_08.value) + ispRemoveMoney(txtSchoolNo6_08.value) + ispRemoveMoney(txtSchoolNo7_08.value) + ispRemoveMoney(txtSchoolNo8_08.value), 0));
        }
    }

    function CalcLine11() {

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

        if (txtSchoolNo13_08.value == '') {
            $('#txtSchoolNo13_08').text(ispFormatMoney(0, 0));
        }

        var val_12 = ispRemoveMoney($('#lblSchoolNo12_08').text());
        var val_13 = ispRemoveMoney(txtSchoolNo13_08.value);


        $('#lblSchoolNo14_08').text(ispFormatMoney(val_12 - val_13, 0));

    }

    //'EGOVWEB-60 - Created CalcLine15

    function CalcLine15() {

        if (txtSchoolNo15a_08.value == '') {
            $('#txtSchoolNo15a_08').val(ispFormatMoney(0, 0));
        }

        if (txtSchoolNo15b_08.value == '') {
            $('#txtSchoolNo15b_08').val(ispFormatMoney(0, 0));
        }
        var dvalue = ispRemoveMoney($('#lblSchoolNo14_08').text());
        if (dvalue < 0) {

            if ((ispRemoveMoney(txtSchoolNo15a_08.value) + ispRemoveMoney(txtSchoolNo15b_08.value)) != Math.abs(ispRemoveMoney($('#lblSchoolNo14_08').text()))) {
                $('#AppError').text("Lines 15a and 15b must equal Line 14");

            }
        }
    }

    //'EGOVWEB-60 - Changed CalcLine14_15 to CalcLine14 and CalcLine15

    function CalcLine14_15_old() {

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
<body onload="ispDisplayProgress('DisplaySchool08Return()', 'Retrieving 2011 school tax information')">
<DIV style="DISPLAY: none; VISIBILTY: visible" Id="SchoolReturn_08" Name="SchoolReturn_08">
   
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
    <td WIDTH="5%"></td>
  </tr>
  
  <tr>
		<td >&nbsp;</td>
		<td colspan=2>
			<label class="lblInstrNormal">Name:&nbsp;</label>
		</td>
		<td colspan=5>
			<label id=lblName_08 class="lblTextBlack" nowrap></label></td>
		<td colspan=2 align=right>
			<label id=lblEntityType_08 class="lblInstrNormal">EIN: &nbsp;</label></td>
		<td colspan=5>
			<label id=lblEntityId_08 class="lblTextBlack"></label></td>
		<td colspan=5></td>
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

<table style="LEFT: 43px; MARGIN-LEFT:  4%; TOP: 205px" border=0 width="90%">
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
    <td WIDTH="5%"></td>
    </tr>
  <tr>
	<td align=left colspan=6 nowrap>
		<INPUT id=chkAmended_08 type=checkbox onclick="chkAmended_08_onclick()">
			<label class="lblTextBlacksmall">Check if amended return.</label></td>
	<td align=left colspan=10 nowrap>
		<label class="lblTextBlacksmall">If you were a partial year resident in 2011, enter dates of residency:</label>&nbsp; 
	<td align=right colspan=7 nowrap>
		<label class="lblInstrNormal">From</label>
		<input class=inpNormal id=txtFromDate_08 onchange="ValidateSchool08Return()" maxlength=10 
			 onfocus="SetFocus()" onblur 
      ="return txtFromDate_08_onblur()" style  ="WIDTH: 68px; HEIGHT: 22px" size=9>
		<label class="lblInstrNormal">To </label>
		<input class=inpNormal width="50%" id=txtToDate_08 onchange="ValidateSchool08Return()" 
			onfocus="SetFocus()" maxlength=10 onblur="return txtToDate_08_onblur()" 
      style="WIDTH: 68px; HEIGHT: 22px" size=9></td>
	</tr>
</table>

<table class=tblShowBorder cellSpacing=0 cellPadding=0 border=0 style="MARGIN-LEFT: 4%" id=TABLE2  width="90%">
  <tr height=0>
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
    <td WIDTH="5%"></td>
    </tr>
  <tr class=rowDataEven>
		<td><label class="lblInstrNormal">1.</label></td>
		<td colspan=16>
			<label class="lblInstrNormal">Net Taxable Dividends</label>
		</td>
		<td colspan=3>
			<input class=inpNormal id=txtSchoolNo1_08 onchange="ValidateSchool08Return()" 
			onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%"></td>
	</tr>
  <tr class=rowDataOdd>
		<td>
			<label class="lblInstrNormal">2.</label></td>
		<td colspan=16>
			<label class="lblInstrNormal">Taxable Interest</label>
		</td>
		<td colspan=3>
			<input class=inpNormal id=txtSchoolNo2_08 onchange="ValidateSchool08Return()"
			 onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%"></td>
	</tr>
  <tr class=rowDataEven>
		<td>
			<label class="lblInstrNormal">3.</label></td>
		<td colspan=16>
			<label class="lblInstrNormal">Distributive Shares of "Subchapter S" Corporation (If loss, enter "0")</label>
		</td>
		<td colspan=3>
			<input class=inpNormal id=txtSchoolNo3_08 onchange="ValidateSchool08Return()"
			 onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%"></td>
	</tr>
  <tr class=rowDataOdd>
		<td>
			<label class="lblInstrNormal">4.</label></td>
		<td colspan=16>
			<label class="lblInstrNormal">Limited Partnership Income (If loss, enter "0")</label>
		</td>
		<td colspan=3>
			<input class=inpNormal id=txtSchoolNo4_08 onchange="ValidateSchool08Return()"
			 onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%"></td>
	</tr>
  <tr class=rowDataEven>
		<td>
			<label class="lblInstrNormal">5.</label></td>
		<td colspan=16>
			<label class="lblInstrNormal">Taxable Income received by a Beneficiary from an Estate or Trust</label>
		</td>
		<td colspan=3>
			<input class=inpNormal id=txtSchoolNo5_08 onchange="ValidateSchool08Return()"
			 onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%"></td>
	</tr>
  <tr class=rowDataOdd>
		<td ><label class="lblInstrNormal">6.</label></td>
		<td colspan=16><label class="lblInstrNormal">Net Short Term Capital Gains (<STRONG><U>Held 6 months or less</U></STRONG>) (if loss, enter "0")</label>
		</td>
		<td colspan=3>
			<input class=inpNormal id=txtSchoolNo6_08 onchange="ValidateSchool08Return()"
			 onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%"></td>
	</tr>
  <tr class=rowDataEven>
		<td ><label class="lblInstrNormal">7.</label></td>
		<td colspan=16><label class="lblInstrNormal">Net Rental Income (If loss, enter "0")</label>
		</td>
		<td colspan=3>
			<input class=inpNormal id=txtSchoolNo7_08 onchange="ValidateSchool08Return()"
			 onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%"></td>
	</tr>
  <tr class=rowDataOdd>
		<td ><label class="lblInstrNormal">8.</label></td>
		<td colspan=16><label class="lblInstrNormal">Other Taxable Income</label>
		</td>
		<td colspan=3>
			<input class=inpNormal id=txtSchoolNo8_08 onchange="ValidateSchool08Return()"
			 onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%"></td>
	</tr>
  <tr class=rowDataEven>
		<td >
			<label class="lblInstrNormal">9.</label></td>
		<td colspan=7>
			<label class="lblInstrNormal">Total Taxable Income</label>
		</td>
		<td colspan=9 align=right>
			<label class="lblInstrNormal">[Calculated - add lines 1 through 8]&nbsp;</label>
		</td>
		<td colspan=3>
			<label class=inpReadOnlyRt id=lblSchoolNo9_08 style="WIDTH: 100%"></label></td>
	</tr>
  <tr class=rowDataOdd>
		<td >
			<label class="lblInstrNormal">10.</label></td>
		<td colspan=16>
			<label class="lblInstrNormal">Deductible Expenses</label></td>
		<td colspan=3>
			<input class=inpNormal id=txtSchoolNo10_08 onchange="ValidateSchool08Return()"
			 onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%"></td>
	</tr>
  <tr class=rowDataEven>
		<td >
			<label class="lblInstrNormal">11.</label></td>
		<td colspan=8>
			<label class="lblInstrNormal">Net Taxable Income</label></td>
		<td colspan=8 align=right>
			<label class="lblInstrNormal">[Calculated - line 9 minus line 10]&nbsp;</label></td>
		<td colspan=3>
			<label class=inpReadOnlyRt id=lblSchoolNo11_08 style="WIDTH: 100%"></label></td>
	</tr>
  <tr class=rowDataOdd>
		<td >
			<label class="lblInstrNormal">12.</label></td>
		<td colspan=8>
			<label class="lblInstrNormal">Gross Tax Due</label></td>
		<td colspan=8 align=right>
            <label class="lblInstrNormal" id=lblSchoolRate>[Calculated - line 11 * ###]&nbsp;</label>
			<%--<label class="lblInstrNormal">[Calculated - line 11 X .039280]&nbsp;</label>--%></td>
		<td colspan=3>
			<label class=inpReadOnlyRt id=lblSchoolNo12_08 style="WIDTH: 100%"></label></td>
	</tr>
  <tr class=rowDataEven>
		<td >
			<label class="lblInstrNormal">13.</label></td>
		<td colspan=16>
			<label class="lblInstrNormal">Credit from overpayment of prior year or tax 
				previously paid with an extension coupon</label></td>
		<td colspan=3>
			<input class=inpNormal id=txtSchoolNo13_08 onchange="ValidateSchool08Return()"
			 onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%"></td>
	</tr>
  <tr class=rowDataOdd>
		<td >
			<label class="lblInstrNormal">14.</label></td>
		<td colspan=6>
			<label class="lblInstrNormal" 
      style="FONT-WEIGHT: bold"><U>TAX DUE</U> </label></td>
 		<td colspan=10 align=right>
 			<label class="lblInstrNormal">[Calculated - if line 12 greater than line 13]&nbsp;</label></td>
		<td colspan=3>
			<label class=inpReadOnlyRt id=lblSchoolNo14_08 style="WIDTH: 100%"></label></td>
	</tr>
  <tr class=rowDataEven>
		<td >
			<label class="lblInstrNormal">15.</label></td>
		<td colspan=6>
			<label class="lblInstrNormal"  
      style="FONT-WEIGHT: bold"><U>OVERPAYMENT 
      OPTIONS</U> </label></td>
 		<td colspan=10 align=right nowrap>
 			<label class="lblInstrNormal">[If line 12 less than line 13, check whether amount is to be:]&nbsp;</label></td>
		<td colspan=3></td>
	</tr>
  <tr class=rowDataOdd>
		<td >
			<label class="lblInstrNormal"></label></td>

		<td colspan=16>
			<label class="lblInstrNormal">15A. 
<!--EGOVWEB-60
				<INPUT id=chk15a_08 type=checkbox style="WIDTH: 13px; HEIGHT: 20px" size=13
					 onclick="chkRefund_08_onclick()" 
     > -->
      <STRONG><U>Refunded</U></STRONG>. <STRONG>Do not file a separate Refund 
      Petition</STRONG>. <STRONG>OR</STRONG>          </label></td>
		<td colspan=3>
<!--EGOVWEB-60 Changed Label to Text
			<label class=inpReadOnlyRt id=lblSchoolNo15a_08 style="WIDTH: 100%"></label>	-->
			<input class=inpNormal id=txtSchoolNo15a_08 onchange="ValidateSchool08Return()"
			 onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%"></td>
	</tr>
  <tr class=rowDataEven>
		<td >
			<label class="lblInstrNormal"></label></td>
		<td colspan=16>
			<label class="lblInstrNormal">15B. 
<!--EGOVWEB-60
				<INPUT id=chk15b_08 type=checkbox style="WIDTH: 13px; HEIGHT: 20px" size=13
					 onclick="chkRefund_08_onclick()" 
     > -->
      <STRONG><U>Applied</U></STRONG> to the 2014 School Income Tax</label></td>
		<td colspan=3>
<!--EGOVWEB-60 Changed Label to Text
			<label class=inpReadOnlyRt id=lblSchoolNo15b_08 style="WIDTH: 100%"></label>	-->
			<input class=inpNormal id=txtSchoolNo15b_08 onchange="ValidateSchool08Return()"
			 onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%"></td>
	</tr>
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
			<input id="btnSchool08Print" type="button" value="Print" 
					onclick="return btnSchool08Print_onclick()">&nbsp;&nbsp;
			<input id="btnSchool08Submit" type="button" value="Submit" onclick="btnSchoolValidate();
    ispDisplayProgress('btnSchool08Submit_onclick()', 'Submitting 2011 school tax information')">&nbsp;&nbsp;</p></td></tr>

	<TR>
		<td colspan=2><label class="lblTextBlack">
				Note: <b>DO NOT FILE THIS RETURN if you have no taxable activity. If you registered for 
				this tax and you no longer have taxable activity, complete a 
				<a href="http://www.phila.gov/revenue/Change_Form.pdf" target=_blank 
     >Change Form<a> to cancel
				your account.</b></label></A></td>
	</TR>
</table>
</DIV>
</body>
</html>