﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<script language="javascript" type="text/javascript">
    $('.inpReadOnlyRt').parent().css("text-align", "right");
    var arrPage1Err = new Array();
    var arrWrkAErr = new Array();
    var arrWrkBErr = new Array();
    var arrWrkCErr = new Array();
    var arrWrkDErr = new Array();
    var arrWrkEErr = new Array();
    var arrWrkKErr = new Array();
    var arrPage4Err = new Array();
    var qExemtedAns = false;
    var isAccExemted = false;
    var txtHeader = 'Taxpayer Information';
    var hasCorpMembers = false;
    var new_rule;
    //Resident and NonResident Rates change yearly, will be updated from Server returned  XML
    var dNPTResidentRate;
    var dNPTNonResidentRate;
    //-----------------------------------------------------------------
    var negTaxDue = false;
    var amntNegDue = 0;
    var sPrevWrkSht = '';
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
            newName = fName + " " + mName + " " + lName;
            return newName;
        }
        else {
            return sEntityName;
        }
    }

    function GetBptEzInfo() {
        //EHD Clear BPTez XML
        parent.$g.xmlBPTez.loadXML(parent.$g.xmlBPTezTemplate.xml);

        //GET NPT ACCOUNT ID and PERIOD
        var NPTACCID = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ACCOUNT_ID', '', 0);
        var NPTPERIOD = '12/31/2015';
        //CALL BPT EZ TO CHECK IT'S STATUS AND IT WILL HELP TO BLOCK NPT IF NO BIRT IS SUBMITTED
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, 'INQ', 'BPT_INFO RETURN_STATUS', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, NPTACCID, 'BPT_INFO ACCOUNT_ID', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTez, NPTPERIOD, 'BPT_INFO PERIOD', '', 0);
        ispCallXMLForm(parent.$g.xmlBPTez, parent.$g.xmlBPTez, 'BPTezReturn', '');

    }

    function ReloadNPT() {

       // parent.$g.loadXmlSync('XML/NPTReturn', parent.parseXml_xmlNPTTemplate);

         parent.$g.loadXmlSync('XML/NPTReturn_2015', parent.parseXml_xmlNPTTemplate_2015);
    }

    function NPT_Exempted(btnClicked) {

        if (btnClicked.id == $('#btnYes').attr('id')) {
            qExemtedAns = true;
            $('#btnYes').attr('checked', true);
            $('#btnNo').attr('checked', false);
        }
        else {
            qExemtedAns = false;
            $('#btnNo').attr('checked', true);
            $('#btnYes').attr('checked', false);
        }

        $('#NPTExemptedMsg').css('display', 'none');
        ShowPage('Page1');
    }

    function DisplayNPTReturn() {       
        $(parent.AppError).text('');
        $('.inpReadOnlyRt').parent().css("text-align", "right");
        ReloadNPT();

        if ((parent.GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '24') == 1) && parent.GetInnerNodeText(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', 'PRK_ID', '24') != undefined && parent.GetInnerNodeText(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', 'PRK_ID', '24').slice(-4) > 2010) {
            GetBptEzInfo();
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_INFO VERSION', '', 0) == '') {
                $('#NPT_2015').css("display", "block");
                $('#NPT_Page1').css("display", "none");
                $('#NPT_BPT_msg').css("display", "block");
                alert('Your 2015 BIRT return must be filed prior to filing your 2015 NPT Return.' + '\n To fill out your 2015 BIRT form, Please select BIRT from the side menu.');
                return;
            }
        }
        if (parent.GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '3') == 1) {
            // parent.MenuWin.ispHighlightMenu(parent.MenuWin.mnuNPTYear13);
            $('#NPT_2015').css("display", "block");
            $('#NPT').css("display", "block");
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 'INQ', 'NPT_INFO RETURN_STATUS', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ACCOUNT_ID', '', 0), 'NPT_INFO ACCOUNT_ID', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, '12/31/2015', 'NPT_INFO PERIOD', '', 0);

            ispCallXMLForm(parent.$g.xmlNPT_2015, parent.$g.xmlNPT_2015, "NPT/NPTReturn_2015", "");
            if ($(parent.divAcctInfo).css("display") == 'none') {
                $(parent.divAcctInfo).css("display", "block");
                $(parent.divAccount).css("display", "none");
            }
        }
        else {
            parent.$g.xmlNPT_2015.loadXML(parent.$g.xmlNPTTemplate_2015.xml);
            parent.ispMenu_onclick(parent.mnuAcctInfo);
        }

        $('#AppHeader').html(txtHeader + '<Font class=hdrMedium>|Net Profit Tax for </Font>' + '<Font class=hdrMedium>' + (sCurrYear - 1) + '</Font>');
        parent.gsInstructionItem = '#NPTReturn';
        $('#AppMessage').html(parent.gsInstructionText + '<BR>The Net Profit Tax for ' + (sCurrYear - 1) + ' is due April 15, ' + sCurrYear + '.');
        $('#InstructionText').html(' for Instructions on filing this return');

        $('#parent.RightFrame').attr("rows", "*,0");
        $('#NPT_2015').css("display", "block");
        $('#NPT_Page1').css("display", "block");
        //Call of the methods---------------------
        DisplayExempted();
        LoadError("Page1");
        CheckNPTXML();
        SetNPTFields();
        PopulateNPTHeader();
        PopulateNPTData();
        PerformCalcs('Page1');
        //----------------------------------------
        $('#CorpMembers_1').removeAttr("style");
        $('#CorpMembers_2').removeAttr("style");
    }

    function DisplayExempted() {
        //EXEMPTED
        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_INFO RETURN_STATUS', '', 0) == 'X') {
            isAccExemted = true;
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_INFO VERSION', '', 0) != '') {
                $('#NPT_2015').css("display", "block");
                $('#NPT_Page1').css("visibility", "hidden");
                $('#NPT_Page1').css("display", "none");
                $('#NPTExemptedMsg').css('display', 'block');

            }
        }
    }

    function CheckNPTXML() {

        var bPeriodExist = true;
        var firstOfYear = '01/01/' + (sCurrYear - 1);

        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_INFO PERIOD', '', 0) != '' && new Date(parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_INFO PERIOD', '', 0)) < new Date(firstOfYear)) {
            bPeriodExist = false;
        }

        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_INFO PERIOD', '', 0) == '') {
            bPeriodExist = false;
        }
        if (bPeriodExist == false) {
            //error_info
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, '', 'ERROR_INFO PROGRAM', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, '', 'ERROR_INFO ERROR', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, '', 'ERROR_INFO LINE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, '', 'ERROR_INFO MESSAGE', '', 0);
            //npt_info
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, '12/31/' + (sCurrYear - 1), 'NPT_INFO PERIOD', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, '', 'NPT_INFO VERSION', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, '', 'NPT_INFO RETURN_STATUS', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, '', 'NPT_INFO LAST_UPD_DATE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, '', 'NPT_INFO RECORDING_DATE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, '', 'NPT_INFO EXTENSION_DATE', '', 0);
            ClearPreparerXML(parent.$g.xmlNPT_2015, 'NPT_INFO');
            //npt_pg1
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG1 RESIDENT_INCOME_NOT_ELIGIBLE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG1 RESIDENT_INCOME_TAX_NOT_ELIGIBLE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG1 RESIDENT_INCOME_ELIGIBLE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG1 RES_INCOME_TAX_ELIGIBLE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG1 RESIDENT_TOTAL_TAX', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG1 NON_RES_INCOME_NOT_ELIGIBLE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG1 NON_RES_INCOME_TAX_NOT_ELIGIBLE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG1 NON_RES_INCOME_ELIGIBLE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG1 NON_RES_INCOME_TAX_ELIGIBLE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG1 NON_RES_TOTAL_TAX', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG1 TOTAL_TAX', '', 0);

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG1 BPT_TAX_CREDIT', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG1 OTHER_TAX_CREDIT', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG1 TOTAL_PAY_CREDIT', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG1 TAX_DUE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG1 INTEREST_PENALTY', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG1 TOTAL_DUE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG1 OVERPAY', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG1 LINE17', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG1 BALANCE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG1 REFUND', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG1 BPT_OVERPAY', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG1 NPT_OVERPAY', '', 0);
            //npt_wrka
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_WRKA RESIDENT_NET_INCOME', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_WRKA RESIDENT_FORM_1065', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_WRKA RESIDENT_OTHER_INCOME', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_WRKA RESIDENT_TAXABLE_INCOME', '', 0);
            // Newly Added
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_WRKA RESIDENT_TAXABLE_INCOME_NOT_ELIGIBLE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_WRKA RESIDENT_TAXABLE_INCOME_ELIGIBLE', '', 0);
            //npt_wrkb
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_WRKB NON_RES__NET_INCOME', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_WRKB NON_RES_FORM_1065', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_WRKB NON_RES_OTHER_INCOME', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_WRKB NON_RES_TOTAL_INCOME', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_WRKB NON_RES_OUTSIDE_INCOME', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_WRKB NON_RES_TAXABLE_INCOME', '', 0);
            // Newly Added
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_WRKB NON_RES_TAXABLE_INCOME_NOT_ELIGIBLE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_WRKB NON_RES_TAXABLE_INCOME_ELIGIBLE', '', 0);
            //npt_wrkc
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_WRKC NET_PROFITS_LIABILTY', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_WRKC BTP_TAX_CREDIT', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_WRKC ESTIMATED_PAYMENT_BASE', '', 0);
            //npt_wrkd
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_WRKD PORTION_TAXABLE_INCOME', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_WRKD TOTAL_TAXABLE_INCOME', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_WRKD PERCENTAGE_TAXABLE_INCOME', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_WRKD WRKK_LINE2', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_WRKD MULTIPLY_LINE4_PERCENTAGE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_WRKD SUBTRACT_LINE5_LINE4', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_WRKD PAGE1_LINE5', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_WRKD BPT_TAX_CREDIT', '', 0);
            //npt_wrke
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_WRKE ESTIMATED_PROFIT_PAYMENT', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_WRKE PAYMENTS_WITH_EXTENSION', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_WRKE PRIOR_OVERPAYMENT_TBA', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_WRKE TOTAL_PAYMENTS_CREDITS', '', 0);
            //npt_wrkk
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_WRKK BPT_PAGE1_LINE1', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_WRKK SIXTY_PERCENT_LINE1', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_WRKK NPT_PAGE1_LINE5', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_WRKK BPT_TAX_CREDIT', '', 0);
            //npt_pg4
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG4 INVENTORY_RAW_A', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG4 INVENTORY_RAW_B', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG4 LAND_BUILDING_A', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG4 LAND_BUILDING_B', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG4 MACHINERY_EQUIP_A', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG4 MACHINERY_EQUIP_B', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG4 OTHER_ASSESTS_A', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG4 OTHER_ASSESTS_B', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG4 RENTED_PROPERTY_A', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG4 RENTED_PROPERTY_B', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG4 TOTAL_VALUE_OUTSIDE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG4 TOTAL_VALUE_EVERYWHERE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG4 TOTAL_VALUE_OUTSIDE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG4 TOTAL_VALUE_EVERYWHERE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG4 OUTSIDE_PROPERTY_FACTOR', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG4 OUT_PHILLY_PAYROLL', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG4 PAYROLL_EVERYWHERE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG4 OUTSIDE_PAYROLL_FACTOR', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG4 OUT_PHILLY_RECEIPTS', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG4 GROSS_RECEIPTS_EVERYWHERE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG4 OUTSIDE_RECEIPTS_FACTOR', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG4 TOTAL_FACTORS', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, 0, 'NPT_PG4 AVERAGE_FACTORS', '', 0);
        }
    }


    function SetNPTFields() {
        var chkAmended = document.getElementById("chkAmended");
        chkAmended.checked = false;
        $('#chkAmended').removeAttr("checked");

        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_INFO VERSION', '', 0) == '') {
            FieldLock(false);
            //$('#chkAmended').attr("disabled", "disabled");
            $('#chkTaxpayer').removeAttr("checked");
        }
        else {

            $('#chkAmended').removeAttr("disabled");
            FieldLock(true);
        }
    }

    function PopulateNPTHeader() {
        var addrIdx

        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ENTITY_ID', '', 0) != '') {
            $('#lblAccountId').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ACCOUNT_ID', '', 0));
            $('#lblEntityId').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ENTITY_ID', '', 0));

            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO TYPE', '', 0) == 1) {
                $('#lblEntityType').text('EIN:');
                $('#lblEntityId').text(' ' + $('#lblEntityId').text().substr(0, 2) + '-' + $('#lblEntityId').text().substr(2));

            }
            else {

                $('#lblEntityType').text('SSN:');
                $('#lblEntityId').text(' ' + $('#lblEntityId').text().substr(0, 3) + '-' + $('#lblEntityId').text().substr(3, 2) + '-' + $('#lblEntityId').text().substr(5));
            }
            $('#lblName').text(AdjustNameDisplay(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS NAME', '', addrIdx)));


            addrIdx = LocatePrimaryAddr();

            $('#lblAddress').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS1', '', addrIdx) + ' ' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS CITY', '', addrIdx) + ' ' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS STATE', '', addrIdx) + ' ' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ZIP', '', addrIdx));
        }
    }

    function PopulateNPTData() {

        dNPTResidentRate = parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_INFO RESIDENT_RATE', '', 0);
        dNPTNonResidentRate = parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_INFO NON_RES_RATE', '', 0);

        $('#msgNPT1_2').text($('#msgNPT1_2').text().replace('###', dNPTResidentRate));
        $('#msgNPT1_4').text($('#msgNPT1_4').text().replace('###', dNPTNonResidentRate));

        $('#txtPercentage').val(ispFormatMoney(0, 0));
        $('#txtNPT1').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG1 RESIDENT_INCOME_NOT_ELIGIBLE', '', 0), 0));
        $('#lblNPT2').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG1 RESIDENT_INCOME_TAX_NOT_ELIGIBLE', '', 0), 0));
        $('#txtNPT3').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG1 RESIDENT_INCOME_ELIGIBLE', '', 0), 0));
        $('#lblNPT4').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG1 RES_INCOME_TAX_ELIGIBLE', '', 0), 0));
        $('#lblNPT5').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG1 RESIDENT_TOTAL_TAX', '', 0), 0));
        //newly Added
        $('#lblNPT6').text(ispFormatMoney(
             parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG1 NON_RES_INCOME_NOT_ELIGIBLE', '', 0), 0));
        $('#lblNPT7').text(ispFormatMoney(
       parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG1 NON_RES_INCOME_TAX_NOT_ELIGIBLE', '', 0), 0));
        $('#lblNPT8').text(ispFormatMoney(
              parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG1 NON_RES_INCOME_ELIGIBLE', '', 0), 0));
        $('#lblNPT9').text(ispFormatMoney(
              parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG1 NON_RES_INCOME_TAX_ELIGIBLE', '', 0), 0));
        $('#lblNPT10').text(ispFormatMoney(
               parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG1 NON_RES_TOTAL_TAX', '', 0), 0));
        $('#lblNPT11').text(ispFormatMoney(
             parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG1 TOTAL_TAX', '', 0), 0));


        // EHD Get from BPT  
        $('#lblNPT12a').text(ispFormatMoney(.6 * parseCurrency(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 NET_TAX', '', 0)), 0));
        $('#lblNPT12b').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG1 OTHER_TAX_CREDIT', '', 0), 0));
        $('#lblNPT12c').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG1 TOTAL_PAY_CREDITS', '', 0), 0));
        $('#lblNPT13').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG1 TAX_DUE', '', 0), 0));
        $('#txtNPT14').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG1 INTEREST_PENALTY', '', 0), 0));
        $('#lblNPT15').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG1 TOTAL_DUE', '', 0), 0));
        $('#lblNPT16').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG1 OVERPAY', '', 0), 0));
        $('#lblNPT17').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG1 LINE17', '', 0), 0));
        $('#lblNPT18').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG1 BALANCE', '', 0), 0));
        $('#txtNPT19a').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG1 REFUND', '', 0), 0));
        $('#txtNPT19b').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG1 BPT_OVERPAY', '', 0), 0));
        $('#txtNPT19c').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG1 NPT_OVERPAY', '', 0), 0));

        PopulatePreparer(parent.$g.xmlNPT_2015, 'NPT_INFO');
        //WrkA    
        $('#txtNPT_WrkA_1').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_WRKA RESIDENT_NET_INCOME', '', 0), 0));
        $('#txtNPT_WrkA_2').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_WRKA RESIDENT_FORM_1065', '', 0), 0));
        $('#txtNPT_WrkA_3').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_WRKA RESIDENT_OTHER_INCOME', '', 0), 0));
        $('#lblNPT_WrkA_4').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_WRKA RESIDENT_TAXABLE_INCOME', '', 0), 0));
        //newly Added     
        $('#txtNPT_WrkA_5').val(ispFormatMoney(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_WRKA RESIDENT_TAXABLE_INCOME_NOT_ELIGIBLE', '', 0), 0));
        $('#txtNPT_WrkA_6').val(ispFormatMoney(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_WRKA RESIDENT_TAXABLE_INCOME_ELIGIBLE', '', 0), 0));
        //WrkB  
        $('#txtNPT_WrkB_1').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_WRKB NON_RES__NET_INCOME', '', 0), 0));
        $('#txtNPT_WrkB_2').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_WRKB NON_RES_FORM_1065', '', 0), 0));
        $('#txtNPT_WrkB_3').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_WRKB NON_RES_OTHER_INCOME', '', 0), 0));
        $('#lblNPT_WrkB_4').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_WRKB NON_RES_TOTAL_INCOME', '', 0), 0));
        $('#lblNPT_WrkB_5').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_WRKB NON_RES_OUTSIDE_INCOME', '', 0), 0));
        $('#lblNPT_WrkB_6').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_WRKB NON_RES_TAXABLE_INCOME', '', 0), 0));
        //newly Added
        $('#txtNPT_WrkB_7').val(ispFormatMoney(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_WRKB NON_RES_TAXABLE_INCOME_NOT_ELIGIBLE', '', 0), 0));
        $('#txtNPT_WrkB_8').val(ispFormatMoney(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_WRKB NON_RES_TAXABLE_INCOME_ELIGIBLE', '', 0), 0));
        //WrkC
        $('#lblNPT_WrkC_1').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_WRKC NET_PROFITS_LIABILTY', '', 0), 0));
        $('#lblNPT_WrkC_2').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_WRKC BTP_TAX_CREDIT', '', 0), 0));
        $('#lblNPT_WrkC_3').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_WRKC ESTIMATED_PAYMENT_BASE', '', 0), 0));
        //WrkD    
        $('#txtNPT_WrkD_1').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_WRKD PORTION_TAXABLE_INCOME', '', 0), 0));
        $('#txtNPT_WrkD_2').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_WRKD TOTAL_TAXABLE_INCOME', '', 0), 0));
        $('#lblNPT_WrkD_3').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_WRKD PERCENTAGE_TAXABLE_INCOME', '', 0), 0));
        $('#lblNPT_WrkD_4').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_WRKD WRKK_LINE2', '', 0), 0));
        $('#lblNPT_WrkD_5').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_WRKD MULTIPLY_LINE4_PERCENTAGE', '', 0), 0));
        $('#lblNPT_WrkD_6').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_WRKD SUBTRACT_LINE5_LINE4', '', 0), 0));
        $('#lblNPT_WrkD_7').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_WRKD PAGE1_LINE11', '', 0), 0));
        $('#lblNPT_WrkD_8').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_WRKD BPT_TAX_CREDIT', '', 0), 0));
        //WrkE  
        $('#txtNPT_WrkE_1').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_WRKE ESTIMATED_PROFIT_PAYMENT', '', 0), 0));
        $('#txtNPT_WrkE_2').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_WRKE PAYMENTS_WITH_EXTENSION', '', 0), 0));
        $('#txtNPT_WrkE_3').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_WRKE PRIOR_OVERPAYMENT_TBA', '', 0), 0));
        $('#lblNPT_WrkE_4').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_WRKE TOTAL_PAYMENTS_CREDITS', '', 0), 0));
        //WrkK  
        $('#txtNPT_WrkK_1').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 NET_TAX', '', 0), 0));
        $('#lblNPT_WrkK_2').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_WRKK SIXTY_PERCENT_LINE1', '', 0), 0));
        $('#lblNPT_WrkK_3').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_WRKK NPT_PAGE1_LINE5', '', 0), 0));
        $('#lblNPT_WrkK_4').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_WRKK BPT_TAX_CREDIT', '', 0), 0));
        //Page 4    
        $('#txtNPT_Page4_1a').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG4 INVENTORY_RAW_A', '', 0), 0));
        $('#txtNPT_Page4_1b').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG4 INVENTORY_RAW_B', '', 0), 0));
        $('#txtNPT_Page4_2a').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG4 LAND_BUILDING_A', '', 0), 0));
        $('#txtNPT_Page4_2b').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG4 LAND_BUILDING_B', '', 0), 0));
        $('#txtNPT_Page4_3a').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG4 MACHINERY_EQUIP_A', '', 0), 0));
        $('#txtNPT_Page4_3b').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG4 MACHINERY_EQUIP_B', '', 0), 0));
        $('#txtNPT_Page4_4a').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG4 OTHER_ASSESTS_A', '', 0), 0));
        $('#txtNPT_Page4_4b').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG4 OTHER_ASSESTS_B', '', 0), 0));
        $('#txtNPT_Page4_5a').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG4 RENTED_PROPERTY_A', '', 0), 0));
        $('#txtNPT_Page4_5b').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG4 RENTED_PROPERTY_B', '', 0), 0));
        $('#lblNPT_Page4_6a').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG4 TOTAL_VALUE_OUTSIDE', '', 0), 0));
        $('#lblNPT_Page4_7b').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG4 TOTAL_VALUE_EVERYWHERE', '', 0), 0));
        $('#lblNPT_Page4_8a').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG4 TOTAL_VALUE_OUTSIDE', '', 0), 0));
        $('#lblNPT_Page4_8b').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG4 TOTAL_VALUE_EVERYWHERE', '', 0), 0));
        $('#lblNPT_Page4_8c').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG4 OUTSIDE_PROPERTY_FACTOR', '', 0), 0));
        $('#txtNPT_Page4_9a').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG4 OUT_PHILLY_PAYROLL', '', 0), 0));
        $('#txtNPT_Page4_9b').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG4 PAYROLL_EVERYWHERE', '', 0), 0));
        $('#lblNPT_Page4_9c').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG4 OUTSIDE_PAYROLL_FACTOR', '', 0), 0));
        $('#txtNPT_Page4_10a').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG4 OUT_PHILLY_RECEIPTS', '', 0), 0));
        $('#txtNPT_Page4_10b').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG4 GROSS_RECEIPTS_EVERYWHERE', '', 0), 0));
        $('#lblNPT_Page4_10c').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG4 OUTSIDE_RECEIPTS_FACTOR', '', 0), 0));
        $('#lblNPT_Page4_11').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG4 TOTAL_FACTORS', '', 0), 0));
        $('#lblNPT_Page4_12').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_PG4 AVERAGE_FACTORS', '', 0), 0));
    }

    function FieldLock(bDisabled) {

        if (bDisabled == true) {

            $('#txtTermDate').attr("disabled", "disabled");
            $('#txtNPT1').attr("disabled", "disabled");
            $('#lblNPT2').attr("disabled", "disabled");
            $('#txtNPT3').attr("disabled", "disabled");
            $('#lblNPT4').attr("disabled", "disabled");
            $('#lblNPT5').attr("disabled", "disabled");
            $('#lblNPT6').attr("disabled", "disabled");
            $('#lblNPT7').attr("disabled", "disabled");
            $('#lblNPT8').attr("disabled", "disabled");
            $('#lblNPT9').attr("disabled", "disabled");
            $('#lblNPT10').attr("disabled", "disabled");
            $('#lblNPT11').attr("disabled", "disabled");
            $('#lblNPT12a').attr("disabled", "disabled");
            $('#lblNPT12b').attr("disabled", "disabled");
            $('#lblNPT12c').attr("disabled", "disabled");
            $('#lblNPT13').attr("disabled", "disabled");
            $('#txtNPT14').attr("disabled", "disabled");
            $('#lblNPT15').attr("disabled", "disabled");
            $('#lblNPT13').attr("disabled", "disabled");
            $('#txtNPT14').attr("disabled", "disabled");
            $('#lblNPT15').attr("disabled", "disabled");
            $('#lblNPT16').attr("disabled", "disabled");
            $('#lblNPT17').attr("disabled", "disabled");
            $('#lblNPT18').attr("disabled", "disabled");
            $('#txtNPT19a').attr("disabled", "disabled");
            $('#txtNPT19b').attr("disabled", "disabled");
            $('#txtNPT19c').attr("disabled", "disabled");
            DisablePreparer(bDisabled);
            $('#btnNPTSubmit').attr("disabled", "disabled");
            $('#lnkWrkA').attr("disabled", "disabled");
            $('#lnkWrkB').attr("disabled", "disabled");
            $('#lnkWrkC').attr("disabled", "disabled");
            $('#lnkWrkD').attr("disabled", "disabled");
            $('#lnkWrkE').attr("disabled", "disabled");
            $('#lnkWrkA').unbind();
        }
        else {

            $('#txtTermDate').removeAttr("disabled");
            $('#txtNPT1').removeAttr("disabled");
            $('#lblNPT2').removeAttr("disabled");
            $('#txtNPT3').removeAttr("disabled");
            $('#lblNPT4').removeAttr("disabled");
            $('#lblNPT5').removeAttr("disabled");
            $('#lblNPT6').removeAttr("disabled");
            $('#lblNPT7').removeAttr("disabled");
            $('#lblNPT8').removeAttr("disabled");
            $('#lblNPT9').removeAttr("disabled");
            $('#lblNPT10').removeAttr("disabled");
            $('#lblNPT11').removeAttr("disabled");
            $('#lblNPT12a').removeAttr("disabled");
            $('#lblNPT12b').removeAttr("disabled");
            $('#lblNPT12c').removeAttr("disabled");
            $('#lblNPT13').removeAttr("disabled");
            $('#txtNPT14').removeAttr("disabled");
            $('#lblNPT15').removeAttr("disabled");
            $('#lblNPT13').removeAttr("disabled");
            $('#txtNPT14').removeAttr("disabled");
            $('#lblNPT15').removeAttr("disabled");
            $('#lblNPT16').removeAttr("disabled");
            $('#lblNPT17').removeAttr("disabled");
            $('#lblNPT18').removeAttr("disabled");
            $('#txtNPT19a').removeAttr("disabled");
            $('#txtNPT19b').removeAttr("disabled");
            $('#txtNPT19c').removeAttr("disabled");
            DisablePreparer(bDisabled);
            $('#btnNPTSubmit').removeAttr("disabled");
            $('#lnkWrkA').removeAttr("disabled");
            $('#lnkWrkB').removeAttr("disabled");
            $('#lnkWrkC').removeAttr("disabled");
            $('#lnkWrkD').removeAttr("disabled");
            $('#lnkWrkE').removeAttr("disabled");


        }
    }

    function SetFocus() {
        document.activeElement.select();
    }

    function btnNPTPrint_onclick() {
        var objCurrDisplayed;

        $('#btnNPTPrint').css("visibility", "hidden");
        $('#btnNPTSubmit').css("visibility", "hidden");
        $('#btnGoToPage1').css("visibility", "hidden");
        $('#btnWrkEGoToPage1').css("visibility", "hidden");
        $('#btnNRGoToPage1').css("visibility", "hidden");
        $('#btnKGoToPage1').css("visibility", "hidden");
        $('#btnDGoToPage1').css("visibility", "hidden");
        $('#btnCGoToPage1').css("visibility", "hidden");
        $('#btnBGoToPage1').css("visibility", "hidden");

        if ($('#NPT').css("display") == 'block') {
            objCurrDisplayed = NPT;
            $('#NPT_WrkA').css("display", "block");
            $('#NPT_WrkB').css("display", "block");
            $('#NPT_WrkC').css("display", "block");
            $('#NPT_WrkD').css("display", "block");
            $('#NPT_WrkE').css("display", "block");
            $('#NPT_WrkK').css("display", "block");
            $('#NPT_Page4').css("display", "block");

        }
        $(parent.AppError).text('');

        window.print();

        $('#btnNPTPrint').css("visibility", "visible");
        $('#btnNPTSubmit').css("visibility", "visible");
        $('#btnGoToPage1').css("visibility", "visible");
        $('#btnWrkEGoToPage1').css("visibility", "visible");
        $('#btnNRGoToPage1').css("visibility", "visible");
        $('#btnKGoToPage1').css("visibility", "visible");
        $('#btnDGoToPage1').css("visibility", "visible");
        $('#btnCGoToPage1').css("visibility", "visible");
        $('#btnBGoToPage1').css("visibility", "visible");

        if (objCurrDisplayed = NPT) {
            $('#NPT_WrkA').css("display", "none");
            $('#NPT_WrkB').css("display", "none");
            $('#NPT_WrkC').css("display", "none");
            $('#NPT_WrkD').css("display", "none");
            $('#NPT_WrkE').css("display", "none");
            $('#NPT_WrkK').css("display", "none");
            $('#NPT_Page4').css("display", "none");
        }
    }

    function btnNPTSubmit_onclick() {
        $(parent.AppError).text('');
        ValidateWorksheet("Page1");
        if ($(parent.AppError).text() == '') {
            $(parent.AppError).text(ValidatePreparer());

        }
        if ($(parent.AppError).text() == '') {
            var tempXML = parent.$g.getXmlDocObj();
            tempXML.xml = parent.$g.xmlNPT_2015.xml;
            txtTermDate_onblur();
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, '', 'NPT_INFO RETURN_STATUS', '', 0);
            PopulateNPTXML();
            ispCallXMLForm(parent.$g.xmlNPT_2015, tempXML, "NPT/NPTReturn_2015", "");
            if (parent.$x.ispXmlGetFieldVal(tempXML, 'ERROR_INFO PROGRAM', '', 0) == '') {
                parent.$g.xmlNPT_2015 = tempXML;
                $('#NPT').css("display", "none");
                DisplayNPTThankYou();
            }
            else {
                $(parent.AppError).text(parent.$x.ispXmlGetFieldVal(tempXML, 'ERROR_INFO MESSAGE', '', 0));

            }
        }
    }

    function DisplayNPTThankYou() {

        $('#NPT').css("visibility", "hidden");
        $('#NPT').css("display", "none");

        $('#NPT_Page1').css("visibility", "hidden");
        $('#NPT_Page1').css("display", "none");

        $('#NPT_WrkA').css("visibility", "hidden");
        $('#NPT_WrkA').css("display", "none");

        $('#NPT_WrkB').css("visibility", "hidden");
        $('#NPT_WrkB').css("display", "none");

        $('#NPT_WrkC').css("visibility", "hidden");
        $('#NPT_WrkC').css("display", "none");

        $('#NPT_WrkD').css("visibility", "hidden");
        $('#NPT_WrkD').css("display", "none");

        $('#NPT_WrkE').css("visibility", "hidden");
        $('#NPT_WrkE').css("display", "none");

        $('#NPT_WrkK').css("visibility", "hidden");
        $('#NPT_WrkK').css("display", "none");

        $('#NPT_Page4').css("visibility", "hidden");
        $('#NPT_Page4').css("display", "none");
        $('#NPT_2015').css("display", "none");
        $('#NPT_2015').css("visibility", "hidden");

        $('#lblThankYouName').text($('#lblName').text());
        $('#lblAcctNo').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ENTITY_ID', '', 0));

        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_INFO ADJUSTMENT_REF_NO', '', 0) != '') {
            $('#lblConfirmNo').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_INFO ADJUSTMENT_REF_NO', '', 0));

        }
        else {
            $('#lblConfirmNo').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ACCOUNT_ID', '', 0));

        }
        $('#divNPTThankYou').css("display", "block");

        this.focus()
        parent.gsInstructionItem = '';
        $('#AppMessage').html('');
        $('#AppHeaderThankyou').html(txtHeader + '<Font class=hdrMedium>|thank you</Font>');
        $('#ccFeeText').text('A user fee of 2.49% will be charged in addition to the amount of tax due.');

    }

    function DoThankYou() {

        var sEmailMsg;
        if ($('#txaComments').val() != '') {
            sEmailMsg = '<p align=middle><strong>Comments and Feedback</strong></p>';
            sEmailMsg += '<p>The following comments or feedback was submitted by: ';
            sEmailMsg += parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS NAME', '', 0) + '</p>';
            sEmailMsg += '<p>Company: ';
            sEmailMsg += parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS TRADE_NAME', '', 0) + '</p>';
            sEmailMsg += '<p>E-mail address: ';
            sEmailMsg += parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS EMAIL', '', 0) + '</p><br>';
            sEmailMsg += '<p><strong>Message: </strong></p>';
            sEmailMsg += '<p>' + txaComments.value + '</p>';

            sEmailMsg = sEmailMsg.replace('>', '&GT&');
            sEmailMsg = sEmailMsg.replace('<', '&LT&');

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, 'COMMENT', 'FUNCTION', '', 0); //chayan
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, sEmailMsg, 'DATA', '', 0); //chayan
            ispCallXMLForm(parent.$g.xmlEmail, parent.$g.xmlEmail, '../../MailPIN', ''); //chayan
        }
        parent.setFrameUrl('Acct/ApplyMain');
        // parent.DocWin.location.href = '../../Acct/ApplyMain';
    }

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

    function chkAmended_onclick() {

        if ($('#chkAmended').prop('checked') == true) {

            $('#btnNo').removeAttr('checked');
            $('#btnYes').removeAttr('checked');

            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_INFO RETURN_STATUS', '', 0) == 'X') {
                $('#NPT_2015').css("display", "block");
                $('#NPT').css("display", "block");
                $('#btnNPTSubmit').removeAttr("disabled");

            }
            else {
                //DO NOTHING
            }
            FieldLock(false);
            ClearPreparer();
            txtNPT1.focus();

        }
        else {
            $('#NPT_2015').css("display", "block");
            $('#NPT').css("display", "block");
            $('#btnNPTSubmit').attr("disabled", "disabled");
            FieldLock(true);;
            PopulatePreparer(parent.$g.xmlNPT_2015, 'NPT_INFO');
        }
    }

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
    }

    function PopulateNPTXML() {
        var d = new Date();
        var lYear = String(d.getFullYear());
        var lMonth = String(d.getMonth() + 1);
        lMonth = lMonth.length == 1 ? '0' + lMonth : lMonth;
        var lDate = String(d.getDate());
        lDate = lDate.length == 1 ? '0' + lDate : lDate;

        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, lMonth + '/' + lDate + '/' + lYear, 'NPT_INFO RECORDING_DATE', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#txtNPT1').val()), 'NPT_PG1 RESIDENT_INCOME_NOT_ELIGIBLE', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT2').text()), 'NPT_PG1 RESIDENT_INCOME_TAX_NOT_ELIGIBLE', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#txtNPT3').val()), 'NPT_PG1 RESIDENT_INCOME_ELIGIBLE', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT4').text()), 'NPT_PG1 RES_INCOME_TAX_ELIGIBLE', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT5').text()), 'NPT_PG1 RESIDENT_TOTAL_TAX', '', 0);

        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT6').text()), 'NPT_PG1 NON_RES_INCOME_NOT_ELIGIBLE', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT7').text()), 'NPT_PG1 NON_RES_INCOME_TAX_NOT_ELIGIBLE', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT8').text()), 'NPT_PG1 NON_RES_INCOME_ELIGIBLE', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNP9').text()), 'NPT_PG1 NON_RES_INCOME_TAX_ELIGIBLE', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT10').text()), 'NPT_PG1 NON_RES_TOTAL_TAX', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT11').text()), 'NPT_PG1 TOTAL_TAX', '', 0);

        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT12a').text()), 'NPT_PG1 BPT_TAX_CREDIT', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT12b').text()), 'NPT_PG1 OTHER_TAX_CREDIT', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT12c').text()), 'NPT_PG1 TOTAL_PAY_CREDITS', '', 0);

        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT13').text()), 'NPT_PG1 TAX_DUE', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#txtNPT14').val()), 'NPT_PG1 INTEREST_PENALTY', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT15').text()), 'NPT_PG1 TOTAL_DUE', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT16').text()), 'NPT_PG1 OVERPAY', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT17').text()), 'NPT_PG1 LINE17', '', 0);

        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT18').text()), 'NPT_PG1 BALANCE', '', 0);


        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#txtNPT19a').val()), 'NPT_PG1 REFUND', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#txtNPT19b').val()), 'NPT_PG1 BPT_OVERPAY', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#txtNPT19c').val()), 'NPT_PG1 NPT_OVERPAY', '', 0);
        PopulatePreparerXML(parent.$g.xmlNPT_2015, 'NPT_INFO');
        //WrkA   
        parent.$x.ispXmlSetFieldVal(parent.$g.xmxmlNPT_2015lNPT, stripCurrency($('#txtNPT_WrkA_1').val()), 'NPT_WRKA RESIDENT_NET_INCOME', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#txtNPT_WrkA_2').val()), 'NPT_WRKA RESIDENT_FORM_1065', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#txtNPT_WrkA_3').val()), 'NPT_WRKA RESIDENT_OTHER_INCOME', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT_WrkA_4').text()), 'NPT_WRKA RESIDENT_TAXABLE_INCOME', '', 0);
        //newly Added  
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#txtNPT_WrkA_5').val()), 'NPT_WRKA RESIDENT_TAXABLE_INCOME_NOT_ELIGIBLE', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#txtNPT_WrkA_6').val()), 'NPT_WRKA RESIDENT_TAXABLE_INCOME_ELIGIBLE', '', 0);
        //WrkB  
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#txtNPT_WrkB_1').val()), 'NPT_WRKB NON_RES__NET_INCOME', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#txtNPT_WrkB_2').val()), 'NPT_WRKB NON_RES_FORM_1065', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#txtNPT_WrkB_3').val()), 'NPT_WRKB NON_RES_OTHER_INCOME', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT_WrkB_4').text()), 'NPT_WRKB NON_RES_TOTAL_INCOME', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT_WrkB_5').text()), 'NPT_WRKB NON_RES_OUTSIDE_INCOME', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT_WrkB_6').text()), 'NPT_WRKB NON_RES_TAXABLE_INCOME', '', 0);

        //newly Addded
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#txtNPT_WrkB_7').val()), 'NPT_WRKB NON_RES_TAXABLE_INCOME_NOT_ELIGIBLE', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#txtNPT_WrkB_8').val()), 'NPT_WRKB NON_RES_TAXABLE_INCOME_ELIGIBLE', '', 0);

        //WrkC
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT_WrkC_1').text()), 'NPT_WRKC NET_PROFITS_LIABILTY', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT_WrkC_2').text()), 'NPT_WRKC BTP_TAX_CREDIT', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT_WrkC_3').text()), 'NPT_WRKC ESTIMATED_PAYMENT_BASE', '', 0);
        //WrkD
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#txtNPT_WrkD_1').val()), 'NPT_WRKD PORTION_TAXABLE_INCOME', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#txtNPT_WrkD_2').val()), 'NPT_WRKD TOTAL_TAXABLE_INCOME', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT_WrkD_3').text()), 'NPT_WRKD PERCENTAGE_TAXABLE_INCOME', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT_WrkD_4').text()), 'NPT_WRKD WRKK_LINE2', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT_WrkD_5').text()), 'NPT_WRKD MULTIPLY_LINE4_PERCENTAGE', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT_WrkD_6').text()), 'NPT_WRKD SUBTRACT_LINE5_LINE4', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT_WrkD_7').text()), 'NPT_WRKD PAGE1_LINE5', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT_WrkD_8').text()), 'NPT_WRKD BPT_TAX_CREDIT', '', 0);
        //WrkE     
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#txtNPT_WrkE_1').val()), 'NPT_WRKE ESTIMATED_PROFIT_PAYMENT', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#txtNPT_WrkE_2').val()), 'NPT_WRKE PAYMENTS_WITH_EXTENSION', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#txtNPT_WrkE_3').val()), 'NPT_WRKE PRIOR_OVERPAYMENT_TBA', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT_WrkE_4').text()), 'NPT_WRKE TOTAL_PAYMENTS_CREDITS', '', 0);
        //WrkK   
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#txtNPT_WrkK_1').val()), 'NPT_WRKK BPT_PAGE1_LINE1', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT_WrkK_2').text()), 'NPT_WRKK SIXTY_PERCENT_LINE1', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT_WrkK_3').text()), 'NPT_WRKK NPT_PAGE1_LINE5', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT_WrkK_4').text()), 'NPT_WRKK BPT_TAX_CREDIT', '', 0);
        //Page 4  
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#txtNPT_Page4_1a').val()), 'NPT_PG4 INVENTORY_RAW_A', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#txtNPT_Page4_1b').val()), 'NPT_PG4 INVENTORY_RAW_B', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#txtNPT_Page4_2a').val()), 'NPT_PG4 LAND_BUILDING_A', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#txtNPT_Page4_2b').val()), 'NPT_PG4 LAND_BUILDING_B', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#txtNPT_Page4_3a').val()), 'NPT_PG4 MACHINERY_EQUIP_A', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#txtNPT_Page4_3b').val()), 'NPT_PG4 MACHINERY_EQUIP_B', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#txtNPT_Page4_4a').val()), 'NPT_PG4 OTHER_ASSESTS_A', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#txtNPT_Page4_4b').val()), 'NPT_PG4 OTHER_ASSESTS_B', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#txtNPT_Page4_5a').val()), 'NPT_PG4 RENTED_PROPERTY_A', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#txtNPT_Page4_5b').val()), 'NPT_PG4 RENTED_PROPERTY_B', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT_Page4_6a').text()), 'NPT_PG4 TOTAL_VALUE_OUTSIDE', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT_Page4_7b').text()), 'NPT_PG4 TOTAL_VALUE_EVERYWHERE', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT_Page4_8a').text()), 'NPT_PG4 TOTAL_VALUE_OUTSIDE', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT_Page4_8b').text()), 'NPT_PG4 TOTAL_VALUE_EVERYWHERE', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT_Page4_8c').text()), 'NPT_PG4 OUTSIDE_PROPERTY_FACTOR', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#txtNPT_Page4_9a').val()), 'NPT_PG4 OUT_PHILLY_PAYROLL', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#txtNPT_Page4_9b').val()), 'NPT_PG4 PAYROLL_EVERYWHERE', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT_Page4_9c').text()), 'NPT_PG4 OUTSIDE_PAYROLL_FACTOR', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#txtNPT_Page4_10a').val()), 'NPT_PG4 OUT_PHILLY_RECEIPTS', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#txtNPT_Page4_10b').val()), 'NPT_PG4 GROSS_RECEIPTS_EVERYWHERE', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT_Page4_10c').text()), 'NPT_PG4 OUTSIDE_RECEIPTS_FACTOR', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT_Page4_11').text()), 'NPT_PG4 TOTAL_FACTORS', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, stripCurrency($('#lblNPT_Page4_12').text()), 'NPT_PG4 AVERAGE_FACTORS', '', 0);

        parent.$x.ispXmlSetFieldVal(parent.$g.xmlNPT_2015, '', 'DEBUG', '', 0);

    }

    function ShowPage(iPage, iWrk) {

        $('#AppMessage').css("visibility", "hidden");
        $('#AppMessage').css("display", "none");

        $('#InstructionText').css("visibility", "hidden");
        $('#InstructionText').css("display", "none");

        $('#NPT_Page1').css("visibility", "hidden");
        $('#NPT_Page1').css("display", "none");

        $('#NPT_WrkA').css("visibility", "hidden");
        $('#NPT_WrkA').css("display", "none");

        $('#NPT_WrkB').css("visibility", "hidden");
        $('#NPT_WrkB').css("display", "none");

        $('#NPT_WrkC').css("visibility", "hidden");
        $('#NPT_WrkC').css("display", "none");

        $('#NPT_WrkD').css("visibility", "hidden");
        $('#NPT_WrkD').css("display", "none");

        $('#NPT_WrkE').css("visibility", "hidden");
        $('#NPT_WrkE').css("display", "none");

        $('#NPT_WrkK').css("visibility", "hidden");
        $('#NPT_WrkK').css("display", "none");

        $('#NPT_Page4').css("visibility", "hidden");
        $('#NPT_Page4').css("display", "none");

        switch (iPage) {
            case "Page1":
                $('#AppMessage').css("visibility", "visible");
                $('#InstructionText').css("visibility", "visible");

                $('#NPT_Page1').css("visibility", "visible");
                $('#NPT_Page1').css("display", "block");

                $('#btnNPTSubmit').removeAttr("disabled");

                switch (iWrk) {
                    case "WrkA":
                        txtNPT1.focus();
                        break;
                    case "WrkB":
                        //txtNPT3.focus();
                        break;
                    case "WrkC":
                        // txtNPT11.focus();
                        break;
                    case "WrkD":
                        // txtPercentage.focus();
                        $('#txtPercentage').focus();
                        break;
                    case "WrkE":
                        // txtNPT6b.focus();
                        break;
                    case "WrkK":
                        //txtNPT6b.focus();
                        break;
                }
                break;

            case "WrkA":
                $('#NPT_WrkA').css("visibility", "visible");
                $('#NPT_WrkA').css("display", "block");
                $('#btnNPTSubmit').attr("disabled", "disabled");
                break;

            case "WrkB":
                $('#NPT_WrkB').css("visibility", "visible");
                $('#NPT_WrkB').css("display", "block");
                $('#btnNPTSubmit').attr("disabled", "disabled");
                break;

            case "WrkC":
                $('#NPT_WrkC').css("visibility", "visible");
                $('#NPT_WrkC').css("display", "block");
                $('#btnNPTSubmit').attr("disabled", "disabled");
                break;

            case "WrkD":
                $('#NPT_WrkD').css("visibility", "visible");
                $('#NPT_WrkD').css("display", "block");
                $('#btnNPTSubmit').attr("disabled", "disabled");
                break;

            case "WrkE":
                $('#NPT_WrkE').css("visibility", "visible");
                $('#NPT_WrkE').css("display", "block");
                $('#btnNPTSubmit').attr("disabled", "disabled");
                break;

            case "WrkK":
                $('#NPT_WrkK').css("visibility", "visible");
                $('#NPT_WrkK').css("display", "block");
                $('#btnNPTSubmit').attr("disabled", "disabled");
                break;

            case "Page4":
                $('#NPT_Page4').css("visibility", "visible");
                $('#NPT_Page4').css("display", "block");
                $('#btnNPTSubmit').attr("disabled", "disabled");
                break;

        }
        $(parent.AppError).text('');

        PerformCalcs(iPage);
        LoadError(iPage);

        ValidateWorksheet(iPage);

    }

    function LoadError(formId) {
        var txtPercentage = document.getElementById("txtPercentage");
        var txtTermDate = document.getElementById("txtTermDate");
        var i = 0;

        switch (formId) {  // txtPercentage
            case "Page1":
                arrPage1Err[i++] = [txtPercentage, '$(\'#txtPercentage\').val() == ""', 'Answer Percentage'];
                arrPage1Err[i++] = [txtPercentage, 'ispValue($(\'#txtPercentage\').val()) == false', 'Value for Percentage must be numeric'];
                arrPage1Err[i++] = [txtPercentage, 'ispNegativeNumber($(\'#txtPercentage\').val()) == false', 'Value for Percentage must NOT be negative']
                arrPage1Err[i++] = [txtTermDate, '$(\'#txtTermDate\').val() != "" & ispValidateDate($(\'#txtTermDate\').val()) == false', 'Invalid to termination date'];
                arrPage1Err[i++] = [txtNPT1, '$(\'#txtNPT1\').val() == ""', 'Answer Question 1'];
                arrPage1Err[i++] = [txtNPT1, 'ispValue($(\'#txtNPT1\').val()) == false', 'Value for Question 1 must be numeric'];
                arrPage1Err[i++] = [txtNPT1, 'ispNegativeNumber($(\'#txtNPT1\').val()) == false', 'Value for Question 1 must NOT be negative']
                arrPage1Err[i++] = [txtNPT3, '$(\'#txtNPT3\').val() == ""', 'Answer Question 3'];
                arrPage1Err[i++] = [txtNPT3, 'ispValue($(\'#txtNPT3\').val()) == false', 'Value for Question 3 must be numeric'];
                arrPage1Err[i++] = [txtNPT3, 'ispNegativeNumber($(\'#txtNPT3\').val()) == false', 'Value for Question 3 must NOT be negative']

                arrPage1Err[i++] = [txtNPT14, '$(\'#txtNPT14\').val() == ""', 'Answer Question 14'];
                arrPage1Err[i++] = [txtNPT14, 'ispValue($(\'#txtNPT14\').val()) == false', 'Value for Question 14 must be numeric'];
                arrPage1Err[i++] = [txtNPT14, 'ispNegativeNumber($(\'#txtNPT14\').val()) == false', 'Value for Question 14 must NOT be negative']

                arrPage1Err[i++] = [txtNPT19a, '$(\'#txtNPT19a\').val() == ""', 'Answer Question 19a'];
                arrPage1Err[i++] = [txtNPT19a, 'ispValue($(\'#txtNPT19a\').val()) == false', 'Value for Question 19a must be numeric'];
                arrPage1Err[i++] = [txtNPT19a, 'ispNegativeNumber($(\'#txtNPT19a\').val()) == false', 'Value for Question 19a must NOT be negative']

                arrPage1Err[i++] = [txtNPT19b, '$(\'#txtNPT19b\').val() == ""', 'Answer Question 19b'];
                arrPage1Err[i++] = [txtNPT19b, 'ispValue($(\'#txtNPT19b\').val()) == false', 'Value for Question 19b must be numeric'];
                arrPage1Err[i++] = [txtNPT19b, 'ispNegativeNumber($(\'#txtNPT19b\').val()) == false', 'Value for Question 19b must NOT be negative']

                arrPage1Err[i++] = [txtNPT19c, '$(\'#txtNPT19c\').val() == ""', 'Answer Question 19c'];
                arrPage1Err[i++] = [txtNPT19c, 'ispValue($(\'#txtNPT19c\').val()) == false', 'Value for Question 19c must be numeric'];
                arrPage1Err[i++] = [txtNPT19c, 'ispNegativeNumber($(\'#txtNPT19c\').val()) == false', 'Value for Question 19c must NOT be negative']


                break;

            case "WrkA":

                arrWrkAErr[i++] = [txtNPT_WrkA_1, 'ispValue( $(\'#txtNPT_WrkA_1\').val()) == false', 'Value for Question 1 must be numeric'];
                arrWrkAErr[i++] = [txtNPT_WrkA_1, 'ispNegativeNumber($(\'#txtNPT_WrkA_1\').val()) == false', 'Value for Question 1 must NOT be negative']
                arrWrkAErr[i++] = [txtNPT_WrkA_2, 'ispValue($(\'#txtNPT_WrkA_2\').val()) == false', 'Value for Question 2 must be numeric'];
                arrWrkAErr[i++] = [txtNPT_WrkA_2, 'ispNegativeNumber($(\'#txtNPT_WrkA_2\').val()) == false', 'Value for Question 2 must NOT be negative']
                arrWrkAErr[i++] = [txtNPT_WrkA_3, 'ispValue( $(\'#txtNPT_WrkA_3\').val()) == false', 'Value for Question 3 must be numeric'];
                arrWrkAErr[i++] = [txtNPT_WrkA_3, 'ispNegativeNumber($(\'#txtNPT_WrkA_3\').val()) == false', 'Value for Question 3 must NOT be negative']
                arrWrkAErr[i++] = [txtNPT_WrkA_5, 'ispValue( $(\'#txtNPT_WrkA_5\').val()) == false', 'Value for Question 5 must be numeric'];
                arrWrkAErr[i++] = [txtNPT_WrkA_5, 'ispNegativeNumber($(\'#txtNPT_WrkA_5\').val()) == false', 'Value for Question 5 must NOT be negative']
                arrWrkAErr[i++] = [txtNPT_WrkA_6, 'ispValue( $(\'#txtNPT_WrkA_6\').val()) == false', 'Value for Question 6 must be numeric'];
                arrWrkAErr[i++] = [txtNPT_WrkA_6, 'ispNegativeNumber($(\'#txtNPT_WrkA_6\').val()) == false', 'Value for Question 6 must NOT be negative']

                break

            case "WrkB":

                arrWrkBErr[i++] = [txtNPT_WrkB_1, 'ispValue( $(\'#txtNPT_WrkB_1\').val()) == false', 'Value for Question 1 must be numeric'];
                arrWrkBErr[i++] = [txtNPT_WrkB_1, 'ispNegativeNumber($(\'#txtNPT_WrkB_1\').val()) == false', 'Value for Question 1 must NOT be negative']
                arrWrkBErr[i++] = [txtNPT_WrkB_2, 'ispValue($(\'#txtNPT_WrkB_2\').val()) == false', 'Value for Question 2 must be numeric'];
                arrWrkBErr[i++] = [txtNPT_WrkB_2, 'ispNegativeNumber($(\'#txtNPT_WrkB_2\').val()) == false', 'Value for Question 2 must NOT be negative']
                arrWrkBErr[i++] = [txtNPT_WrkB_3, 'ispValue( $(\'#txtNPT_WrkB_3\').val()) == false', 'Value for Question 3 must be numeric'];
                arrWrkBErr[i++] = [txtNPT_WrkB_3, 'ispNegativeNumber($(\'#txtNPT_WrkB_3\').val()) == false', 'Value for Question 3 must NOT be negative']
                arrWrkBErr[i++] = [txtNPT_WrkB_7, 'ispValue($(\'#txtNPT_WrkB_7\').val()) == false', 'Value for Question 7 must be numeric'];
                arrWrkBErr[i++] = [txtNPT_WrkB_7, 'ispNegativeNumber($(\'#txtNPT_WrkB_7\').val()) == false', 'Value for Question 7 must NOT be negative']
                arrWrkBErr[i++] = [txtNPT_WrkB_8, 'ispValue( $(\'#txtNPT_WrkB_8\').val()) == false', 'Value for Question 8 must be numeric'];
                arrWrkBErr[i++] = [txtNPT_WrkB_8, 'ispNegativeNumber($(\'#txtNPT_WrkB_8\').val()) == false', 'Value for Question 8 must NOT be negative']


                break

            case "WrkD":

                arrWrkDErr[i++] = [txtNPT_WrkD_1, 'ispValue($(\'#txtNPT_WrkD_1\').val()) == false', 'Value for Question 1 must be numeric'];
                arrWrkDErr[i++] = [txtNPT_WrkD_1, 'ispNegativeNumber($(\'#txtNPT_WrkD_1\').val()) == false', 'Value for Question 1 must NOT be negative']
                arrWrkDErr[i++] = [txtNPT_WrkD_2, 'ispValue($(\'#txtNPT_WrkD_2\').val()) == false', 'Value for Question 2 must be numeric'];
                arrWrkDErr[i++] = [txtNPT_WrkD_2, 'ispNegativeNumber($(\'#txtNPT_WrkD_2\').val()) == false', 'Value for Question 2 must NOT be negative']

                break;

            case "WrkE":
                arrWrkEErr[i++] = [txtNPT_WrkE_1, 'ispValue( $(\'#txtNPT_WrkE_1\').val()) == false', 'Value for Question 1 must be numeric'];
                arrWrkEErr[i++] = [txtNPT_WrkE_1, 'ispNegativeNumber($(\'#txtNPT_WrkE_1\').val()) == false', 'Value for Question 1 must NOT be negative']
                arrWrkEErr[i++] = [txtNPT_WrkE_2, 'ispValue( $(\'#txtNPT_WrkE_2\').val()) == false', 'Value for Question 2 must be numeric'];
                arrWrkEErr[i++] = [txtNPT_WrkE_2, 'ispNegativeNumber($(\'#txtNPT_WrkE_2\').val()) == false', 'Value for Question 2 must NOT be negative']
                arrWrkEErr[i++] = [txtNPT_WrkE_3, 'ispValue( $(\'#txtNPT_WrkE_3\').val()) == false', 'Value for Question 3 must be numeric'];
                arrWrkEErr[i++] = [txtNPT_WrkE_3, 'ispNegativeNumber($(\'#txtNPT_WrkE_3\').val()) == false', 'Value for Question 3 must NOT be negative']

                break;

            case "WrkK":
                arrWrkKErr[i++] = [txtNPT_WrkK_1, 'ispValue( $(\'#txtNPT_WrkK_1\').val()) == false', 'Value for Question 1 must be numeric'];
                arrWrkKErr[i++] = [txtNPT_WrkK_1, 'ispNegativeNumber($(\'#txtNPT_WrkK_1\').val()) == false', 'Value for Question 1 must NOT be negative']
                break;

            case "Page4":
                var txtNPT_Page4_1a = document.getElementById("txtNPT_Page4_1a");
                var txtNPT_Page4_1b = document.getElementById("txtNPT_Page4_1b");
                var txtNPT_Page4_2a = document.getElementById("txtNPT_Page4_2a");
                var txtNPT_Page4_2b = document.getElementById("txtNPT_Page4_2b");
                var txtNPT_Page4_3a = document.getElementById("txtNPT_Page4_3a");
                var txtNPT_Page4_3b = document.getElementById("txtNPT_Page4_3b");
                var txtNPT_Page4_4a = document.getElementById("txtNPT_Page4_4a");
                var txtNPT_Page4_4b = document.getElementById("txtNPT_Page4_4b");
                var txtNPT_Page4_5a = document.getElementById("txtNPT_Page4_5a");
                var txtNPT_Page4_5b = document.getElementById("txtNPT_Page4_5b");
                var txtNPT_Page4_9a = document.getElementById("txtNPT_Page4_9a");
                var txtNPT_Page4_9b = document.getElementById("txtNPT_Page4_9b");
                var txtNPT_Page4_10a = document.getElementById("txtNPT_Page4_10a");
                var txtNPT_Page4_10b = document.getElementById("txtNPT_Page4_10b");
                arrPage4Err[i++] = [txtNPT_Page4_1a, 'ispValue( $(\'#txtNPT_Page4_1a\').val()) == false', 'Value for Question 1a must be numeric'];
                arrPage4Err[i++] = [txtNPT_Page4_1a, 'ispNegativeNumber($(\'#txtNPT_Page4_1a\').val()) == false', 'Value for Question 1a must NOT be negative']
                arrPage4Err[i++] = [txtNPT_Page4_1b, 'ispValue($(\'#txtNPT_Page4_1b\').val()) == false', 'Value for Question 1b must be numeric'];
                arrPage4Err[i++] = [txtNPT_Page4_1b, 'ispNegativeNumber($(\'#txtNPT_Page4_1b\').val()) == false', 'Value for Question 1b must NOT be negative']

                arrPage4Err[i++] = [txtNPT_Page4_2a, 'ispValue($(\'#txtNPT_Page4_2a\').val()) == false', 'Value for Question 2a must be numeric'];
                arrPage4Err[i++] = [txtNPT_Page4_2a, 'ispNegativeNumber($(\'#txtNPT_Page4_2a\').val()) == false', 'Value for Question 2a must NOT be negative']
                arrPage4Err[i++] = [txtNPT_Page4_2b, 'ispValue($(\'#txtNPT_Page4_2b\').val()) == false', 'Value for Question 2b must be numeric'];
                arrPage4Err[i++] = [txtNPT_Page4_2b, 'ispNegativeNumber($(\'#txtNPT_Page4_2b\').val()) == false', 'Value for Question 2b must NOT be negative']
                arrPage4Err[i++] = [txtNPT_Page4_3a, 'ispValue($(\'#txtNPT_Page4_3a\').val()) == false', 'Value for Question 3a must be numeric'];
                arrPage4Err[i++] = [txtNPT_Page4_3a, 'ispNegativeNumber($(\'#txtNPT_Page4_3a\').val()) == false', 'Value for Question 3a must NOT be negative']

                arrPage4Err[i++] = [txtNPT_Page4_3b, 'ispValue($(\'#txtNPT_Page4_3b\').val()) == false', 'Value for Question 3b must be numeric'];
                arrPage4Err[i++] = [txtNPT_Page4_3b, 'ispNegativeNumber($(\'#txtNPT_Page4_3b\').val()) == false', 'Value for Question 3b must NOT be negative']
                arrPage4Err[i++] = [txtNPT_Page4_4a, 'ispValue($(\'#txtNPT_Page4_4a\').val()) == false', 'Value for Question 4a must be numeric'];
                arrPage4Err[i++] = [txtNPT_Page4_4a, 'ispNegativeNumber($(\'#txtNPT_Page4_4a\').val()) == false', 'Value for Question 4a must NOT be negative']
                arrPage4Err[i++] = [txtNPT_Page4_4b, 'ispValue($(\'#txtNPT_Page4_4b\').val()) == false', 'Value for Question 4b must be numeric'];
                arrPage4Err[i++] = [txtNPT_Page4_4b, 'ispNegativeNumber($(\'#txtNPT_Page4_4b\').val()) == false', 'Value for Question 4b must NOT be negative']

                arrPage4Err[i++] = [txtNPT_Page4_5a, 'ispValue($(\'#txtNPT_Page4_5a\').val()) == false', 'Value for Question 5a must be numeric'];
                arrPage4Err[i++] = [txtNPT_Page4_5a, 'ispNegativeNumber($(\'#txtNPT_Page4_5a\').val()) == false', 'Value for Question 5a must NOT be negative']
                arrPage4Err[i++] = [txtNPT_Page4_5b, 'ispValue($(\'#txtNPT_Page4_5b\').val()) == false', 'Value for Question 5b must be numeric'];
                arrPage4Err[i++] = [txtNPT_Page4_5b, 'ispNegativeNumber($(\'#txtNPT_Page4_5b\').val()) == false', 'Value for Question 5b must NOT be negative']
                arrPage4Err[i++] = [txtNPT_Page4_9a, 'ispValue($(\'#txtNPT_Page4_9a\').val()) == false', 'Value for Question 9a must be numeric'];
                arrPage4Err[i++] = [txtNPT_Page4_9a, 'ispNegativeNumber($(\'#txtNPT_Page4_9a\').val()) == false', 'Value for Question 9a must NOT be negative']
                arrPage4Err[i++] = [txtNPT_Page4_9b, 'ispValue($(\'#txtNPT_Page4_9b\').val()) == false', 'Value for Question 9b must be numeric'];
                arrPage4Err[i++] = [txtNPT_Page4_9b, 'ispNegativeNumber($(\'#txtNPT_Page4_9b\').val()) == false', 'Value for Question 9b must NOT be negative']
                arrPage4Err[i++] = [txtNPT_Page4_10a, 'ispValue($(\'#txtNPT_Page4_10a\').val()) == false', 'Value for Question 10a must be numeric'];
                arrPage4Err[i++] = [txtNPT_Page4_10a, 'ispNegativeNumber($(\'#txtNPT_Page4_10a\').val()) == false', 'Value for Question 10a must NOT be negative']
                arrPage4Err[i++] = [txtNPT_Page4_10b, 'ispValue($(\'#txtNPT_Page4_10b\').val()) == false', 'Value for Question 10b must be numeric'];
                arrPage4Err[i++] = [txtNPT_Page4_10b, 'ispNegativeNumber($(\'#txtNPT_Page4_10b\').val()) == false', 'Value for Question 10b must NOT be negative']

                break;
        }
    }

    function ValidateWorksheet(formId) {
        var evt = window.event || arguments.callee.caller.arguments[0];
        var source = parent.getEventSource(evt);

        var ObjSelected;

        $(parent.AppError).text('');
        if (source != null) {
            var sId = source.id;

            if (sId != null && sId != '') {
                ObjSelected = document.getElementById(sId);
                //alert(source.type);
                if (ObjSelected != null) {
                    if (ObjSelected.value == '' && ObjSelected.id != 'txtPercentage' && source.type != 'button') {

                        ObjSelected.value = ispFormatMoney(0, 0);
                    }
                    else if (ObjSelected.value != '' && ObjSelected.id != 'txtPercentage' && source.type != 'button') {
                        ObjSelected.value = ispFormatMoney(ObjSelected.value, 0);
                    }
                }
            }
        }

        switch (formId) {
            case "Page1":
                $(parent.AppError).text(ispSetInputErr(arrPage1Err));

                break;

            case "WrkA":
                $(parent.AppError).text(ispSetInputErr(arrWrkAErr));
                break;

            case "WrkB":
                $(parent.AppError).text(ispSetInputErr(arrWrkBErr));
                break

            case "WrkD":
                $(parent.AppError).text(ispSetInputErr(arrWrkDErr));
                break

            case "WrkE":
                $(parent.AppError).text(ispSetInputErr(arrWrkEErr));
                break

            case "WrkK":
                $(parent.AppError).text(ispSetInputErr(arrWrkKErr));
                break

            case "Page4":
                $(parent.AppError).text(ispSetInputErr(arrPage4Err));
                break
        } //Switch
        if ($(parent.AppError).text() == '') {
            PerformCalcs(formId);
        }
        else {
            // AppError.scrollIntoView(true);
        } //if
    } //ValidateWorksheet Ends		

    function PerformCalcs(formId) {
        switch (formId) {
            case "Page1":
                CalcPage1Line2(dNPTResidentRate);
                //CalcPage1Line3();

                CalcPage1Line4(dNPTNonResidentRate);
                CalcPage1Line5();

                CalcPage1Line7();

                CalcPage1Line9();
                CalcPage1Line10();
                CalcPage1Line11();

                CalkWrkKLine2();
                // CalcWrkKLine4();
                CalcWrkDLine3();
                CalcWrkDLine5();

                CalcWrkDLine6();
                //CalcWrkDLine8();

                CalcPage1Line12c();
                CalcPage1Line13();
                CalcPage1Line15();
                CalcPage1Line16();
                CalcWrkCLine3();
                CalcPage1Line18();
                CalcPage1Line19();
                break;

            case "WrkA":
                CalcPage1Line1and3();
                CalcWrkALine4();
                break;

            case "WrkB":
                CalcPage1Line6And8();

                CalcWrkBLine4();
                CalcWrkBLine6();

                break;

            case "WrkC":
                CalcWrkCLine3();
                break;

            case "WrkD":
                CalcWrkDLine3();
                CalcWrkDLine5();
                CalcWrkDLine6();
                CalPage1Line12afrom_D();
                CalcWrkDLine8();
                break;

            case "WrkE":
                CalcWrkELine4();
                CalcPage1Line12c();
                CalcPage1Line13();
                break;

            case "WrkK":
                CalkWrkKLine2();
                CalPage1Line12afrom_K();
                CalcWrkKLine4();

                break;

            case "Page4":
                CalcPage4Line6a();
                CalcPage4Line7b();
                CalcPage4Line8c();
                CalcPage4Line9c();
                CalcPage4Line10c();
                CalcPage4Line11();
                CalcPage4Line12();
                break;
        } //Switch Ends
    } //PerformCalcs Ends

    function chkCorpMembers_onclick() { //Determine if questions 3 & 4 of Worksheet K are needed or if Worksheet D will be used instead
        if ($('#chkCorpMembers').attr("checked") == "checked") { //Company has Corporate Members
            $('#CorpMembers_1').css("visibility", "hidden");
            $('#CorpMembers_1').css("display", "none");
            $('#CorpMembers_2').css("visibility", "hidden");
            $('#CorpMembers_2').css("display", "none");

            hasCorpMembers = true;
        }
        else { //Company does not have Corporate Members
            $('#CorpMembers_1').css("visibility", "visible");
            $('#CorpMembers_1').css("display", "block");
            $('#CorpMembers_1').removeAttr("style");
            $('#CorpMembers_2').css("visibility", "visible");
            $('#CorpMembers_2').css("display", "block");
            $('#CorpMembers_2').removeAttr("style");
            hasCorpMembers = false;
        }
        PerformCalcs("WrkK")
    } //chkCorpMembers_onclick()
    //Begin Calculations

    function PrepForMath(numString) { //Removes $ and , from the string and converts the string into a number
        if (numString != 'undefined' && numString != null && numString != '') {
            var temp;
            temp = numString;
            if (temp.indexOf("(") == -1) {
                return temp = (1 * (temp.replace(/[,$]/g, "")));
            }
            else { //Negative Value
                temp = temp.replace(/[,$()]/g, "");
                temp = (-1) * temp;
                return temp;
            }
        }
    } //PrepForMath

    function parseCurrency(value) {
        return ispRemoveMoney(value);
    }
    //*****Page 1*****
    function CalcPage1Line1and3() { // get valu from Worksheet A to Line 1 and Line 3 of Page1

        $('#txtNPT1').val((ispFormatMoney(parseCurrency($('#txtNPT_WrkA_5').val()), 0)));
        $('#txtNPT3').val((ispFormatMoney(parseCurrency($('#txtNPT_WrkA_6').val()), 0)));
    }
    function CalcPage1Line2(rRate) {   //Line 1 times Resident Rate   
        var rRate = ".039102";
        if ($('#txtNPT1').val() == '')//manoranjan
        {
            $('#lblNPT2').text(ispFormatMoney(0, 0));
        }
        if (parseCurrency($('#txtNPT1').val()) < 0) {
            $('#lblNPT2').text(ispFormatMoney(0, 0));
        }
        else {
            $('#lblNPT2').text(ispFormatMoney((parseCurrency($('#txtNPT1').val()) * rRate), 0));
        }
    } //CalcPage1Line2

    function CalcPage1Line4(nrRate) {
        var nrRate = ".034102";
        if ($('#txtNPT3').val() == '') {

            $('#lblNPT4').text(ispFormatMoney(0, 0));
        } //if
        if (parseCurrency($('#txtNPT3').val()) < 0) {
            $('#lblNPT4').text(ispFormatMoney(0, 0));
        }
        else {
            $('#lblNPT4').text(ispFormatMoney((parseCurrency(txtNPT3.value) * nrRate), 0));

        } //if
    } //CalcPage1Line4
    function CalcPage1Line5() { //Line 2 Plus Line 4, Enter here and WrkC Line 1, WrkD Line 7 and WrkK Line 3
        if ($('#lblNPT2').text() != '' && $('#lblNPT4').text() != '') {

            $('#lblNPT5').text(ispFormatMoney((parseCurrency($('#lblNPT2').text()) + parseCurrency($('#lblNPT4').text())), 0));

        }
        else
            $('#lblNPT5').text(ispFormatMoney(0, 0));
    }

    function CalcPage1Line6And8() {

        $('#lblNPT6').text((ispFormatMoney(parseCurrency($('#txtNPT_WrkB_7').val()), 0)));
        $('#lblNPT8').text((ispFormatMoney(parseCurrency($('#txtNPT_WrkB_8').val()), 0)));
    }

    function CalcPage1Line7() {
        var nrRate = ".034828";
        if ($('#lblNPT6').text() == '') {

            $('#lblNPT7').text(ispFormatMoney(0, 0));
        } //if
        if (parseCurrency($('#lblNPT6').val()) < 0) {
            $('#lblNPT7').text(ispFormatMoney(0, 0));
        }
        else {
            $('#lblNPT7').text(ispFormatMoney((parseCurrency($('#lblNPT6').text()) * nrRate), 0));

        }
    }
    function CalcPage1Line9() {
        var nrRate = ".029828";
        if ($('#lblNPT8').text() == '') {

            $('#lblNPT9').text(ispFormatMoney(0, 0));
        } //if
        if (parseCurrency($('#lblNPT8').val()) < 0) {
            $('#lblNPT9').text(ispFormatMoney(0, 0));
        }
        else {
            $('#lblNPT9').text(ispFormatMoney((parseCurrency($('#lblNPT8').text()) * nrRate), 0));

        }
    }
    function CalcPage1Line10() {
        if ($('#lblNPT7').text() != '' && $('#lblNPT9').text() != '') {
            $('#lblNPT10').text(ispFormatMoney((parseCurrency($('#lblNPT7').text()) + parseCurrency($('#lblNPT9').text())), 0));
        }
        else
            $('#lblNPT10').text(ispFormatMoney(0, 0));
    }
    function CalcPage1Line11() { //Line 5 Plus Line 10, Enter here and WrkC Line 1, WrkD Line 7 and WrkK Line 3
        if ($('#lblNPT5').text() != '' && $('#lblNPT10').text() != '') {
            //IF ACCOUNT EXEMPTED. TAX AMOUNT WILL BE ZERO
            if (qExemtedAns == true) {
                $('#lblNPT11').text(ispFormatMoney(0, 0));
            }
            else {
                $('#lblNPT11').text(ispFormatMoney((parseCurrency($('#lblNPT5').text()) + parseCurrency($('#lblNPT10').text())), 0));
            }
            $('#lblNPT_WrkC_1').text($('#lblNPT11').text());
            $('#lblNPT_WrkD_7').text($('#lblNPT11').text());
            $('#lblNPT_WrkK_3').text($('#lblNPT11').text());

            //if (parseCurrency($('#lblNPT11').text()) < .6 * parseCurrency(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 NET_TAX', '', 0)))
            //{
            //    $('#lblNPT12a').text(ispFormatMoney(parseCurrency($('#lblNPT11').text()), 0))
            //}
            //else {

            //    if (parseCurrency($('#lblNPT_WrkD_8').text()) == 0) {
            //        $('#lblNPT12a').text(ispFormatMoney(.6 * parseCurrency(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 NET_TAX', '', 0)), 0));
            //    }
            //    else {
            //        $('#lblNPT12a').text($('#lblNPT_WrkD_8').text());
            //    }
            //}
        }
    }
    function CalPage1Line12afrom_D() {
        if ($('#lblNPT11').text() != '') {
            if (parseCurrency($('#lblNPT11').text()) < .6 * parseCurrency(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 NET_TAX', '', 0))) {
                $('#lblNPT12a').text(ispFormatMoney(parseCurrency($('#lblNPT11').text()), 0))
            }
            else {

                if (parseCurrency($('#lblNPT_WrkD_8').text()) == 0) {
                    $('#lblNPT12a').text(ispFormatMoney(.6 * parseCurrency(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 NET_TAX', '', 0)), 0));
                }
                else {
                    $('#lblNPT12a').text($('#lblNPT_WrkD_8').text());
                }
            }
        }
    }
    function CalPage1Line12afrom_K() {
        if ($('#lblNPT11').text() != '') {
            if (parseCurrency($('#lblNPT11').text()) < .6 * parseCurrency(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 NET_TAX', '', 0))) {
                $('#lblNPT12a').text(ispFormatMoney(parseCurrency($('#lblNPT11').text()), 0))
            }
            else {

                if (parseCurrency($('#lblNPT_WrkK_4').text()) == 0) {
                    $('#lblNPT12a').text(ispFormatMoney(.6 * parseCurrency(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_PG1 NET_TAX', '', 0)), 0));
                }
                else {
                    $('#lblNPT12a').text($('#lblNPT_WrkK_4').text());
                }
            }
        }
    }
    function CalcPage1Line12c() {
        if ($('#lblNPT12a').text() != '' && $('#lblNPT12b').text() != '') {
            $('#lblNPT12c').text(ispFormatMoney((parseCurrency($('#lblNPT12a').text()) + parseCurrency($('#lblNPT12b').text())), 0));
        }
    }

    function CalcPage1Line13() {
        if ($('#lblNPT11').text() != '' && $('#lblNPT12c').text() != '') {
            if ((parseCurrency($('#lblNPT11').text()) - parseCurrency($('#lblNPT12c').text())) <= 0) { //Net Tax Due is Negative
                $('#lblNPT13').text(ispFormatMoney(0, 0));
                $('#txtNPT14').val(ispFormatMoney(0, 0));
                $('#txtNPT14').attr("disabled", "disabled");
            }
            else if ((parseCurrency($('#lblNPT11').text()) - parseCurrency($('#lblNPT12c').text())) > 0) { //Net Tax Due is Positive
                $('#lblNPT13').text(ispFormatMoney((parseCurrency($('#lblNPT11').text()) - parseCurrency($('#lblNPT12c').text())), 0));
                //if ($('#chkAmended').attr("checked") == "checked") {
                $('#txtNPT14').removeAttr("disabled");

                //}
            }
        }
    }

    function CalcPage1Line15() {
        //Line 13 plus Line 14
        if ($('#lblNPT13').text() != '' && $('#txtNPT14').val() != '') {
            $('#lblNPT15').text(ispFormatMoney((parseCurrency($('#lblNPT13').text()) + parseCurrency($('#txtNPT14').val())), 0));
            //if (parseCurrency($('#lblNPT15').text()) != 0) {
            //    $('#txtNPT19a').val(ispFormatMoney(0, 0));
            //    $('#txtNPT19b').val(ispFormatMoney(0, 0));
            //    $('#txtNPT19c').val(ispFormatMoney(0, 0));
            //}
        }
    }

    function CalcPage1Line16() {
        if ($('#lblNPT12c').text() != '' && $('#lblNPT11').text() != '') {
            if (parseCurrency($('#lblNPT12c').text()) > parseCurrency($('#lblNPT11').text())) {
                $('#lblNPT16').text(ispFormatMoney((parseCurrency($('#lblNPT12c').text()) - parseCurrency($('#lblNPT11').text())), 0));
            }
            else {
                $('#lblNPT16').text(ispFormatMoney(0, 0));
            }
        }
    }
    function CalcPage1Line18() {
        if ($('#lblNPT16').text() != '' && $('#lblNPT17').text() != '') {
            //if (parseCurrency($('#lblNPT16').text()) > parseCurrency($('#lblNPT17').text())) {
            $('#lblNPT18').text(ispFormatMoney((parseCurrency($('#lblNPT16').text()) - parseCurrency($('#lblNPT17').text())), 0));
            if ($('#lblNPT18').text() < 0) {
                $('#lblNPT18').text(ispFormatMoney(0, 0));
                $('#txtNPT19a').val(ispFormatMoney(0, 0));
                $('#txtNPT19b').val(ispFormatMoney(0, 0));
                $('#txtNPT19c').val(ispFormatMoney(0, 0));
            }
        }
    }
    function CalcPage1Line19() {
        if (parseCurrency($('#lblNPT16').text()) > parseCurrency($('#txtNPT17').val())) {
            if ($('#txtNPT19a').val() == '') {
                $('#txtNPT19a').val(ispFormatMoney(0, 0));
            }
            if ($('#txtNPT19b').val() == '') {
                $('#txtNPT19b').val(ispFormatMoney(0, 0));
            }
            if ($('#txtNPT19c').val() == '') {
                $('#txtNPT19c').val(ispFormatMoney(0, 0));
            }
            if (parseCurrency($('#txtNPT19a').val()) + parseCurrency($('#txtNPT19b').val()) + parseCurrency($('#txtNPT19c').val()) != parseCurrency($('#lblNPT16').text())) {
                $(parent.AppError).text('Lines 19a, 19b and 19c must equal Line 16');
            }
        }
        else {
            $('#txtNPT19a').val(ispFormatMoney(0, 0));
            $('#txtNPT19b').val(ispFormatMoney(0, 0));
            $('#txtNPT19c').val(ispFormatMoney(0, 0));
        }
    }
    //*****End Page 1*****
    //*****Worksheet A*****

    function CalcWrkALine4() { //Add Lines 1 thru 3 and enter on Page 1, Line 1
        if ($('#txtNPT_WrkA_1').val() != '' && $('#txtNPT_WrkA_2').val() != '' && $('#txtNPT_WrkA_3').val() != '') {
            $('#lblNPT_WrkA_4').text(ispFormatMoney((parseCurrency($('#txtNPT_WrkA_1').val())) + (parseCurrency($('#txtNPT_WrkA_2').val())) + (parseCurrency($('#txtNPT_WrkA_3').val())), 0));

        }
    }

    //*****Worksheet B*****

    function CalcWrkBLine4() { //Add Lines 1 thru 3 and Enter on Page 4, Line 13
        if ($('#txtNPT_WrkB_1').val() != '' && $('#txtNPT_WrkB_2').val() != '' && $('#txtNPT_WrkB_3').val() != '') {
            $('#lblNPT_WrkB_4').text(ispFormatMoney((parseCurrency($('#txtNPT_WrkB_1').val()) + parseCurrency($('#txtNPT_WrkB_2').val()) + parseCurrency($('#txtNPT_WrkB_3').val())), 0));

            $('#txtNPT3').val($('#lblNPT_WrkB_4').text());
        }
    }

    function CalcWrkBLine6() { //Subtract Line 5 from Line 4 and enter on Page 1, Line 3
        if ($('#lblNPT_WrkB_4').text() != '' && $('#lblNPT_WrkB_5').text() != '') {
            $('#lblNPT_WrkB_6').text(ispFormatMoney((parseCurrency($('#lblNPT_WrkB_4').text()) - parseCurrency($('#lblNPT_WrkB_5').text())), 0));

            // $('#txtNPT3').val($('#lblNPT_WrkB_6').text());
        }
    }
    //*****End Worksheet B*****
    //*****Worksheet C*****

    function CalcWrkCLine3() { //Subtract Line 2 from Line 1 and enter 50% of result on Page 1, Line 11
        if ($('#lblNPT_WrkC_1').text() != '' && $('#lblNPT_WrkC_2').text() != '') {

            $('#lblNPT_WrkC_3').text(ispFormatMoney((parseCurrency($('#lblNPT_WrkC_1').text()) - parseCurrency($('#lblNPT_WrkC_2').text())), 0));

            $('#lblNPT17').text(ispFormatMoney((parseCurrency($('#lblNPT_WrkC_3').text()) / 2), 0));//Manoranjan
        }
    }
    //*****End Worksheet C*****
    //*****Worksheet D*****

    function CalcWrkDLine3() { //Divide Line 1 by 2 and enter the percentage here and on Page 1
        if ($('#txtNPT_WrkD_1').val() != '' && $('#txtNPT_WrkD_2').val() != '') {

            $('#lblNPT_WrkD_3').text(ispFormatMoney(0, 0));
            if (parseCurrency($('#txtNPT_WrkD_2').val()) == 0) { //Not dividing by 0
            }
            else if (parseCurrency($('#txtNPT_WrkD_2').val()) < parseCurrency($('#txtNPT_WrkD_1').val())) {

                $(parent.AppError).text('Line 2 cannot be less than Line 1');
            }
            else {
                var temp = (parseCurrency($('#txtNPT_WrkD_1').val()) / parseCurrency($('#txtNPT_WrkD_2').val()))

                $('#lblNPT_WrkD_3').text((temp.toFixed(2) * 100));
                $('#txtPercentage').val($('#lblNPT_WrkD_3').text());//Manoranjan
            }
        }
    } //CalcWrkDLine3

    function CalcWrkDLine5() { //Multiply the amount on Line 4 by the percentage on Line 3
        $('#lblNPT_WrkD_4').text($('#lblNPT_WrkK_2').text());
        if ($('#lblNPT_WrkD_4').text() != '' && $('#lblNPT_WrkD_3').text() != '') {
            $('#lblNPT_WrkD_5').text(ispFormatMoney((parseCurrency($('#lblNPT_WrkD_4').text()) * (parseCurrency($('#lblNPT_WrkD_3').text()) / 100)), 0))
        }
    }

    function CalcWrkDLine6() { //Subtract Line 5 from Line 4
        if ($('#lblNPT_WrkD_4').text() != '' && $('#lblNPT_WrkD_5').text() != '') {
            $('#lblNPT_WrkD_6').text(ispFormatMoney((parseCurrency($('#lblNPT_WrkD_4').text()) - parseCurrency($('#lblNPT_WrkD_5').text())), 0));
        }
    }

    function CalcWrkDLine8() { //Enter the lesser of Line 6 or Line 7 here and on Page 1, Line 12a :done
        if ($('#lblNPT_WrkD_6').text() != '' && $('#lblNPT_WrkD_7').text() != '') {
            if (parseCurrency($('#lblNPT_WrkD_6').text()) < parseCurrency($('#lblNPT_WrkD_7').text())) {
                $('#lblNPT_WrkD_8').text($('#lblNPT_WrkD_6').text());
                $('#lblNPT12a').text($('#lblNPT_WrkD_8').text());
                $('#lblNPT_WrkC_2').text($('#lblNPT12a').text());
            }
            else { //line 7 < line 6                
                $('#lblNPT_WrkD_8').text($('#lblNPT_WrkD_7').text());
                $('#lblNPT12a').text($('#lblNPT_WrkD_8').text());
                $('#lblNPT_WrkC_2').text($('#lblNPT12a').text());
            }
        }
    }
    //*****End Worksheet D*****
    //*****Worksheet E*****

    function CalcWrkELine4() { //Total of Lines 1 through 3. Enter here and on Page 1, Line 12b
        if ($('#txtNPT_WrkE_1').val() != '' && $('#txtNPT_WrkE_2').val() != '' && $('#txtNPT_WrkE_3').val() != '') {

            $('#lblNPT_WrkE_4').text(ispFormatMoney((parseCurrency($('#txtNPT_WrkE_1').val()) + parseCurrency($('#txtNPT_WrkE_2').val()) + parseCurrency($('#txtNPT_WrkE_3').val())), 0));

            if (ispNegativeNumber($("#lblNPT_WrkE_4").text()) == false) {
                $(parent.AppError).text('Line 4  must NOT be negative');
                $('#btnWrkEGoToPage1').attr("disabled", "disable");
            }
            else {
                $('#lblNPT12b').text($('#lblNPT_WrkE_4').text());
                $('#btnWrkEGoToPage1').removeAttr("disabled");
            }
        }
    }
    //*****End Worksheet E*****
    //*****Worksheet K*****

    function CalkWrkKLine2() { //Enter 60% of the amount on Line 1, if entity has corporate members, enter amount on Worksheed D, Line 4
        if ($('#txtNPT_WrkK_1').val() != "") {
            $('#lblNPT_WrkK_2').text(ispFormatMoney((parseCurrency($('#txtNPT_WrkK_1').val()) * .6), 0));

            if (hasCorpMembers) {
                $('#lblNPT_WrkD_4').text($('#lblNPT_WrkK_2').text());
            }
        }
    }

    function CalcWrkKLine4() { //Enter the lesser of Line 2 or Line 3 here and on Page 1, Line 12a       
        if ($('#lblNPT_WrkK_2').text() != '' && $('#lblNPT_WrkK_3').text() != '') {
            if (hasCorpMembers) { //Don't Calculate / Undo Calculations
                $('#lblNPT_WrkK_4').text('');
                $('#lblNPT12a').text('');
                $('#lblNPT_WrkC_2').text('');
            }
            else {
                if (parseCurrency($('#lblNPT_WrkK_2').text()) < parseCurrency($('#lblNPT_WrkK_3').text())) {
                    $('#lblNPT_WrkK_4').text($('#lblNPT_WrkK_2').text());
                    $('#lblNPT12a').text($('#lblNPT_WrkK_4').text());
                    $('#lblNPT_WrkC_2').text($('#lblNPT12a').text());
                }
                else { //Line 3 < Line 2
                    $('#lblNPT_WrkK_4').text($('#lblNPT_WrkK_3').text());
                    $('#lblNPT12a').text($('#lblNPT_WrkK_4').text());
                    $('#lblNPT_WrkC_2').text($('#lblNPT12a').text());
                }
            }
        }
    }
    //*****End Worksheet K*****
    //*****Page 4*****

    function CalcPage4Line6a() { //Total average value of Property used Outside Philadelphia, Lines 1a thru 5a and Enter on Line 8a
        if ($('#txtNPT_Page4_1a').val() != '' && $('#txtNPT_Page4_2a').val() != '' && $('#txtNPT_Page4_3a').val() != '' && $('#txtNPT_Page4_4a').val() != "" && $('#txtNPT_Page4_5a').val() != '') {

            $('#lblNPT_Page4_6a').text(ispFormatMoney((parseCurrency($('#txtNPT_Page4_1a').val()) + parseCurrency($('#txtNPT_Page4_2a').val()) + parseCurrency($('#txtNPT_Page4_3a').val()) + parseCurrency($('#txtNPT_Page4_4a').val()) + parseCurrency($('#txtNPT_Page4_5a').val())), 0));
            $('#lblNPT_Page4_8a').text($('#lblNPT_Page4_6a').text());
        }
    }

    function CalcPage4Line7b() { //Total average value of Property used Everywhere, Lines 1b thru 5b and Enter on Line 8b
        if ($('#txtNPT_Page4_1b').val() != '' && $('#txtNPT_Page4_2b').val() != '' && $('#txtNPT_Page4_3b').val() != '' && $('#txtNPT_Page4_4b').val() != '' && $('#txtNPT_Page4_5b').val() != '') {

            $('#lblNPT_Page4_7b').text(ispFormatMoney((parseCurrency($('#txtNPT_Page4_1b').val()) + parseCurrency($('#txtNPT_Page4_2b').val()) + parseCurrency($('#txtNPT_Page4_3b').val()) + parseCurrency($('#txtNPT_Page4_4b').val()) + parseCurrency($('#txtNPT_Page4_5b').val())), 0));
            $('#lblNPT_Page4_8b').text($('#lblNPT_Page4_7b').text());
        }
    }

    function CalcPage4Line8c() { //Line 8a divided by 8b (Out of Philadelphia Property Factor)
        if ($('#lblNPT_Page4_8a').text() != '' && $('#lblNPT_Page4_8b').text() != '') {
            if (parseCurrency($('#lblNPT_Page4_8b').text()) != 0) { //Not dividing by 0
                var temp = (parseCurrency($('#lblNPT_Page4_8a').text()) / parseCurrency($('#lblNPT_Page4_8b').text()));
                $('#lblNPT_Page4_8c').text(temp.toFixed(2));
            }
        }
    }

    function CalcPage4Line9c() { //Line 9a divided by 9b (Out of Philadelphia Payroll Factor)
        if ($('#txtNPT_Page4_9a').val() != '' && $('#txtNPT_Page4_9b').val() != '') {
            if (parseCurrency($('#txtNPT_Page4_9b').val()) != 0) { //Not dividing by 0
                var temp = (parseCurrency($('#txtNPT_Page4_9a').val()) / parseCurrency($('#txtNPT_Page4_9b').val()));
                $('#lblNPT_Page4_9c').text(temp.toFixed(2));
            }
        }
    }

    function CalcPage4Line10c() { //Line 10a divided by 10b (Out of Philadelphia Receipts Factor)
        if ($('#txtNPT_Page4_10a').val() != '' && $('#txtNPT_Page4_10b').val() != '') {
            if (parseCurrency($('#txtNPT_Page4_10b').val()) != 0) { //Not dividing by 0
                var temp = (parseCurrency($('#txtNPT_Page4_10a').val()) / parseCurrency($('#txtNPT_Page4_10b').val()));
                $('#lblNPT_Page4_10c').text(temp.toFixed(2));
            }
        }
    }

    function CalcPage4Line11() { //Total Lines 8c, 9c & 10c (Total Factors)
        if ($('#lblNPT_Page4_8c').text() != "" && $('#lblNPT_Page4_9c').text() != "" && $('#lblNPT_Page4_10c').text() != "") {
            var temp = (parseCurrency($('#lblNPT_Page4_8c').text()) + parseCurrency($('#lblNPT_Page4_9c').text()) + parseCurrency($('#lblNPT_Page4_10c').text()));
            $('#lblNPT_Page4_11').text(temp.toFixed(2));
        }
    } //CalcPage4Line11

    function CalcPage4Line12() { //Line 11 divided by applicable number of factors (Average of Factors)
        //Assuming 1 to 3 possible factors -- 8c>0, 9c>0, 10c>0
        var numOfFactors = 0

        if ($('#lblNPT_Page4_11').text() != '') {

            if (parseCurrency($('#lblNPT_Page4_8c').text()) > 0) {
                numOfFactors++;
            }
            if (parseCurrency($('#lblNPT_Page4_9c').text()) > 0) {
                numOfFactors++;
            }
            if (parseCurrency($('#lblNPT_Page4_10c').text()) > 0) {
                numOfFactors++;
            }

            if (numOfFactors != 0) {
                var temp = (parseCurrency($('#lblNPT_Page4_11').text()) / numOfFactors)
                $('#lblNPT_Page4_12').text(temp.toFixed(2));
                $('#lblNPT_WrkB_5').text($('#lblNPT_Page4_12').text());
            }
        }
    } //CalcPage4Line12


    //*****End Page 4*****

    function splitField(value, start, end) {

        if (value.length != 0) {
            return value.substr(start, end);
        }
        else {
            return '';
        }
    } //splitField

    //End Calculations
</script>
