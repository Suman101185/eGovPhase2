﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>


<html>
<head>


<script id="clientEventHandlersJS" language="javascript">



    var arrTobaccoErr = new Array();
    var txtHeader = 'Taxpayer Information';
    var dTobaccoItemTaxRate, dTobaccoPackTaxRate, dTobaccoPaperTaxRate;
    var gUserAddr = '<%Response.Write(Request.ServerVariables["REMOTE_ADDR"]);%>'

    $(document).ready(function () {
        DisplayTobaccoReturn();
    });

    function AdjustNameDisplay(incName) {
        var sEntityName = incName;
        var lName = "",
            fName = "",
            mName = "",
            newName = "";
        newName = incName;

        if (sEntityName.indexOf("*") != -1) { //If name contains *'s
            sEntityName = sEntityName.split("*");
            lName = (sEntityName[0].substr(0, 1)) + (sEntityName[0].substr(1).toLowerCase());
            if (sEntityName[1]) {
                fName = (sEntityName[1].substr(0, 1)) + (sEntityName[1].substr(1).toLowerCase());
            } //if
            if (sEntityName[2]) {
                mName = sEntityName[2].substr(0, 1).toUpperCase();
            } //if
            newName = fName + " " + mName + " " + lName;
        } //if
        return newName;
    } //AdjustNameDisplay

    function ReloadNPT() {

        parent.$g.loadXmlSync('XML/TobaccoReturn', parent.parseXml_xmlTobacco);
        parent.$g.loadXmlSync('XML/TobaccoReturn', parent.parseXml_xmlTobaccoTemplate);

    }

    function DisplayTobaccoReturn() {
        ReloadNPT();
        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_FORM", "") == 'TOBACCO') {
            DisplayTobaccoThankYou();
            return;
        } //if
        if (parent.GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '27') == 1) { //Chayan
            //  parent.MenuWin.ispHighlightMenu(parent.MenuWin.mnuTOBYear10);

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, 'INQ', 'TOBACCO_INFO RETURN_STATUS', '', 0);
            var entityInfo_ENTITY_ID = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ENTITY_ID', "", 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, entityInfo_ENTITY_ID, 'TOBACCO_INFO ACCOUNT_ID', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, '12/31/2010', 'TOBACCO_INFO PERIOD', '', 0);
            ispCallXMLForm(parent.$g.xmlTobacco, parent.$g.xmlTobacco, "TobaccoReturn", "");
            ispHideProgress();

            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'ERROR_INFO ERROR', "", 0) != 0) {
                $(parent.RightFrame).attr("rows", "*,0");
                $('#TobaccoReturn').css("display", "block");
                $('AppHeader').html(txtHeader + '<Font class=hdrMedium>|tobacco tax return for 2010</Font>');
                PopulateTobaccoHeader();
                FieldLock(true);
                $(parent.AppError).text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'ERROR_INFO MESSAGE', "", 0));
                $('#btnTobaccoSubmit').attr("disabled", "disabled");
                $('#chkAmended').attr("disabled", "disabled");
                return;
            }
            if ($(parent.divAcctInfo).css("display") == 'none') {
                $(parent.divAcctInfo).css("display", "block");
                $(parent.divAccount).css("display", "none");
            }
        } else {
            parent.$g.xmlTobacco = parent.xmlTobaccoTemplate;
            parent.ispMenu_onclick(parent.mnuAcctInfo);

        } //if
        $(parent.RightFrame).attr("rows", "*,0");
        $('#TobaccoReturn').css("display", "block");

        $('#AppHeader').html(txtHeader + '<Font class=hdrMedium>|tobacco tax return for 2010</Font>');
        parent.gsInstructionItem = '#TobaccoReturn';
        $('#AppMessage').html(parent.gsInstructionText + '<BR>The Tobacco Tax for 2010 is due January 31, 2011.');
        $('#InstructionText').html(' for Instructions on filing this return');

        LoadTobaccoError();
        RightAlignText();
        CheckTobaccoXML();
        SetTobaccoFields();
        PopulateTobaccoHeader();
        PopulateTobaccoData();
        $(parent.AppError).text('');
    } //DisplayTobaccoReturn

    function SetTobaccoFields() {
        FieldLock(false);
        $('chkAmended').attr("disabled", "disabled");
        $('chkAmended').removeAttr("checked");
        $('chkTaxpayer').removeAttr("checked");
        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'TOBACCO_INFO VERSION', '', 0) != '') {
            $('chkAmended').removeAttr("disabled");
            FieldLock(true);
        } //if
    } //SetTobaccoFields

    function FieldLock(bDisabled) {
        if (bDisabled == true) {
            $('#txtTobaccoNo1a').attr("disabled", "disabled");
            $('#txtTobaccoNo1b').attr("disabled", "disabled");
            $('#lblTobaccoNo1c').attr("disabled", "disabled");
            $('#lblTobaccoNo1d').attr("disabled", "disabled");
            $('#txtTobaccoNo2a').attr("disabled", "disabled");
            $('#txtTobaccoNo2b').attr("disabled", "disabled");
            $('#lblTobaccoNo2c').attr("disabled", "disabled");
            $('#lblTobaccoNo2d').attr("disabled", "disabled");
            $('#txtTobaccoNo3a').attr("disabled", "disabled");
            $('#txtTobaccoNo3b').attr("disabled", "disabled");
            $('#lblTobaccoNo3c').attr("disabled", "disabled");
            $('#lblTobaccoNo3d').attr("disabled", "disabled");
            $('#lblTobaccoNo4').attr("disabled", "disabled");
            $('#txtTobaccoNo5').attr("disabled", "disabled");
            $('#lblTobaccoNo6').attr("disabled", "disabled");
            $('#txtTobaccoNo7').attr("disabled", "disabled");
            $('#lblTobaccoNo8').attr("disabled", "disabled");
            $('#lblTobaccoNo9a').attr("disabled", "disabled");
            $('#lblTobaccoNo9b').attr("disabled", "disabled");
            $('#chkTobaccoNo9a').attr("disabled", "disabled");
            $('#chkTobaccoNo9b').attr("disabled", "disabled");
            DisablePreparer(bDisabled);
        } else {

            $('#txtTobaccoNo1a').removeAttr("disabled");
            $('#txtTobaccoNo1b').removeAttr("disabled");
            $('#lblTobaccoNo1c').removeAttr("disabled");
            $('#lblTobaccoNo1d').removeAttr("disabled");
            $('#txtTobaccoNo2a').removeAttr("disabled");
            $('#txtTobaccoNo2b').removeAttr("disabled");
            $('#lblTobaccoNo2c').removeAttr("disabled");
            $('#lblTobaccoNo2d').removeAttr("disabled");
            $('#txtTobaccoNo3a').removeAttr("disabled");
            $('#txtTobaccoNo3b').removeAttr("disabled");
            $('#lblTobaccoNo3c').removeAttr("disabled");
            $('#lblTobaccoNo3d').removeAttr("disabled");
            $('#lblTobaccoNo4').removeAttr("disabled");
            $('#txtTobaccoNo5').removeAttr("disabled");
            $('#lblTobaccoNo6').removeAttr("disabled");
            $('#txtTobaccoNo7').removeAttr("disabled");
            $('#lblTobaccoNo8').removeAttr("disabled");
            $('#lblTobaccoNo9a').removeAttr("disabled");
            $('#lblTobaccoNo9b').removeAttr("disabled");
            $('#chkTobaccoNo9a').removeAttr("disabled");
            $('#chkTobaccoNo9b').removeAttr("disabled");
            DisablePreparer(bDisabled);


        }
    } //FieldLock

    function CheckTobaccoXML() {
        var bPeriodExist = true;

        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'TOBACCO_INFO PERIOD', '', 0) != '' && new Date(parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'TOBACCO_INFO PERIOD', '', 0)) < new Date('01/01/2010')) {
            bPeriodExist = false;
        }

        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'TOBACCO_INFO PERIOD', '', 0) == '') {
            bPeriodExist = false;
        }

        if (bPeriodExist == false) {
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, '', 'ERROR_INFO PROGRAM', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, '', 'ERROR_INFO ERROR', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, '', 'ERROR_INFO LINE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, '', 'ERROR_INFO MESSAGE', '', 0);

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, '12/31/2010', 'TOBACCO_INFO PERIOD', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, '', 'TOBACCO_INFO VERSION', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, '', 'TOBACCO_INFO RETURN_STATUS', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, '', 'TOBACCO_INFO LAST_UPD_DATE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, '', 'TOBACCO_INFO RECORDING_DATE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, '', 'TOBACCO_INFO EXTENSION_DATE', '', 0);

            ClearPreparerXML(parent.$g.xmlTobacco, 'TOBACCO_INFO');

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, 0, 'AMT_INFO ITEM_TOTAL', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, 0, 'AMT_INFO ITEM_NOT_PHILA', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, 0, 'AMT_INFO ITEM_PHILA', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, 0, 'AMT_INFO ITEM_TAX_DUE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, 0, 'AMT_INFO PACK_TOTAL', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, 0, 'AMT_INFO PACK_NOT_PHILA', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, 0, 'AMT_INFO PACK_PHILA', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, 0, 'AMT_INFO PACK_TAX_DUE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, 0, 'AMT_INFO PAPER_TOTAL', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, 0, 'AMT_INFO PAPER_NOT_PHILA', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, 0, 'AMT_INFO PAPER_PHILA', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, 0, 'AMT_INFO PAPER_TAX_DUE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, 0, 'AMT_INFO TOTAL_TAX_DUE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, 0, 'AMT_INFO CREDITS', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, 0, 'AMT_INFO NET_TAX_DUE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, 0, 'AMT_INFO INTEREST_PENALTY', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, 0, 'AMT_INFO TOTAL_AMOUNT_DUE', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, 0, 'AMT_INFO REFUND', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, 0, 'AMT_INFO ROLL_FORWARD', '', 0);
        } //if
    } //CheckTobaccoXML

    function PopulateTobaccoHeader() {
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
            }

            addrIdx = LocatePrimaryAddr();
            $('#lblName').text(AdjustNameDisplay(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS NAME', '', addrIdx)));
            $('#lblAddress').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS1', '', addrIdx) + ' ' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS CITY', '', addrIdx) + ' ' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS STATE', '', addrIdx) + ' ' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ZIP', '', addrIdx));
        }
    } //PopulateTobaccoHeader

    function PopulateTobaccoData() {
       
        dTobaccoItemTaxRate = parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'TOBACCO_INFO RATE_ITEM', '', 0);
        dTobaccoPackTaxRate = parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'TOBACCO_INFO RATE_PACK', '', 0);
        dTobaccoPaperTaxRate = parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'TOBACCO_INFO RATE_PAPER', '', 0);

        $('#msgTobaccoNo1d').text($('#msgTobaccoNo1d').text().replace('###', dTobaccoItemTaxRate));
        $('#msgTobaccoNo2d').text($('#msgTobaccoNo2d').text().replace('###', dTobaccoPackTaxRate));
        $('#msgTobaccoNo3d').text($('#msgTobaccoNo3d').text().replace('###', dTobaccoPaperTaxRate));

        $('#txtTobaccoNo1a').val(parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'AMT_INFO ITEM_TOTAL', '', 0));
        $('#txtTobaccoNo1b').val(parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'AMT_INFO ITEM_NOT_PHILA', '', 0));
        $('#lblTobaccoNo1c').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'AMT_INFO ITEM_PHILA', '', 0));
        var amtInfo_ITEM_TAX_DUE = parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'AMT_INFO ITEM_TAX_DUE', '', 0);
        $('#lblTobaccoNo1d').text(ispFormatMoney(amtInfo_ITEM_TAX_DUE, 0));

        $('#txtTobaccoNo2a').val(parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'AMT_INFO PACK_TOTAL', '', 0));
        $('#txtTobaccoNo2b').val(parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'AMT_INFO PACK_NOT_PHILA', '', 0));
        $('#lblTobaccoNo2c').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'AMT_INFO PACK_PHILA', '', 0));
        var amtInfo_PACK_TAX_DUE = parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'AMT_INFO PACK_TAX_DUE', '', 0);
        $('#lblTobaccoNo2d').text(ispFormatMoney(amtInfo_PACK_TAX_DUE, 0));

        $('#txtTobaccoNo3a').val(parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'AMT_INFO PAPER_TOTAL', '', 0));
        txtTobaccoNo3b.value = parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'AMT_INFO PAPER_NOT_PHILA', '', 0);
        $('#lblTobaccoNo3c').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'AMT_INFO PAPER_PHILA', '', 0));
        $('#lblTobaccoNo3d').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'AMT_INFO PAPER_TAX_DUE', '', 0), 0));

        $('#lblTobaccoNo4').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'AMT_INFO TOTAL_TAX_DUE', '', 0), 0));
        $('#txtTobaccoNo5').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'AMT_INFO CREDITS', '', 0), 0));
        $('#lblTobaccoNo6').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'AMT_INFO NET_TAX_DUE', '', 0), 0));
        $('#txtTobaccoNo7').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'AMT_INFO INTEREST_PENALTY', '', 0), 0));
        $('#lblTobaccoNo8').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'AMT_INFO TOTAL_AMOUNT_DUE', '', 0), 0));
        $('#lblTobaccoNo9a').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'AMT_INFO TAX_REFUND', '', 0), 0));
        $('#lblTobaccoNo9b').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'AMT_INFO TAX_OVERPAID', '', 0), 0));
        PopulatePreparer(parent.$g.xmlTobacco, 'TOBACCO_INFO');
        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'AMT_INFO REFUND', '', 0) != 0) {
            $('#chkTobaccoNo9a').attr("checked", "checked");
            $('#chkTobaccoNo9b').removeAttr("checked");;
        } else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'AMT_INFO ROLL_FORWARD', '', 0) != 0) {
            $('#chkTobaccoNo9a').removeAttr("checked");
            $('#chkTobaccoNo9b').attr("checked", "checked");
        }

        CalcLine8_9a_9b();
    } //PopulateTobaccoData

    function PopulateTobaccoXML() {
        var d = new Date();
        var lYear = String(d.getFullYear());
        var lMonth = String(d.getMonth() + 1);
        lMonth = lMonth.length == 1 ? '0' + lMonth : lMonth;
        var lDate = String(d.getDate());
        lDate = lDate.length == 1 ? '0' + lDate : lDate;

        parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, lMonth + '/' + lDate + '/' + lYear, 'TOBACCO_INFO RECORDING_DATE', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, $('#txtTobaccoNo1a').val(), 'AMT_INFO ITEM_TOTAL', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, $('#txtTobaccoNo1b').val(), 'AMT_INFO ITEM_NOT_PHILA', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, $('#lblTobaccoNo1c').text(), 'AMT_INFO ITEM_PHILA', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, stripCurrency($('#lblTobaccoNo1d').text()), 'AMT_INFO ITEM_TAX_DUE', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, $('#txtTobaccoNo2a').val(), 'AMT_INFO PACK_TOTAL', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, $('#txtTobaccoNo2b').val(), 'AMT_INFO PACK_NOT_PHILA', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, $('#lblTobaccoNo2c').text(), 'AMT_INFO PACK_PHILA', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, stripCurrency($('#lblTobaccoNo2d').text()), 'AMT_INFO PACK_TAX_DUE', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, $('#txtTobaccoNo3a').val(), 'AMT_INFO PAPER_TOTAL', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, $('#txtTobaccoNo3b').val(), 'AMT_INFO PAPER_NOT_PHILA', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, $('#lblTobaccoNo3c').text(), 'AMT_INFO PAPER_PHILA', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, stripCurrency($('#lblTobaccoNo3d').text()), 'AMT_INFO PAPER_TAX_DUE', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, stripCurrency($('#lblTobaccoNo4').text()), 'AMT_INFO TOTAL_TAX_DUE', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, stripCurrency($('#txtTobaccoNo5').val()), 'AMT_INFO CREDITS', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, stripCurrency($('#lblTobaccoNo6').text()), 'AMT_INFO NET_TAX_DUE', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, stripCurrency($('#txtTobaccoNo7').val()), 'AMT_INFO INTEREST_PENALTY', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, stripCurrency($('#lblTobaccoNo8').text()), 'AMT_INFO TOTAL_AMOUNT_DUE', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, stripCurrency($('#lblTobaccoNo9a').text()), 'AMT_INFO REFUND', '', 0);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, stripCurrency($('#lblTobaccoNo9b').text()), 'AMT_INFO ROLL_FORWARD', '', 0);

        PopulatePreparerXML(parent.$g.xmlTobacco, 'TOBACCO_INFO');
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, '', 'DEBUG', '', 0);
    } //PopulateTobaccoXML

    function RightAlignText() {
        $('#txtTobaccoNo1a').css("text-align", "right");
        $('#txtTobaccoNo1b').css("text-align", "right");
        $('#lblTobaccoNo1c').parent().css("text-align", "right");
        $('#lblTobaccoNo1d').parent().css("text-align", "right");
        $('#txtTobaccoNo2a').css("text-align", "right");
        $('#txtTobaccoNo2b').css("text-align", "right");
        $('#lblTobaccoNo2c').parent().css("text-align", "right");
        $('#lblTobaccoNo2d').parent().css("text-align", "right");
        $('#txtTobaccoNo3a').css("text-align", "right");
        $('#txtTobaccoNo3b').css("text-align", "right");
        $('#lblTobaccoNo3c').parent().css("text-align", "right");
        $('#lblTobaccoNo3d').parent().css("text-align", "right");
        $('#lblTobaccoNo4').parent().css("text-align", "right");
        $('#txtTobaccoNo5').css("text-align", "right");
        $('#lblTobaccoNo6').parent().css("text-align", "right");
        $('#txtTobaccoNo7').css("text-align", "right");
        $('#lblTobaccoNo8').parent().css("text-align", "right");
        $('#lblTobaccoNo9a').parent().css("text-align", "right");
        $('#lblTobaccoNo9b').parent().css("text-align", "right");
    } //RightAlignText

    function LoadTobaccoError() {
        var txtTobaccoNo1a = document.getElementById("txtTobaccoNo1a");
        var txtTobaccoNo1b = document.getElementById("txtTobaccoNo1b");
        var txtTobaccoNo2a = document.getElementById("txtTobaccoNo2a");
        var txtTobaccoNo2b = document.getElementById("txtTobaccoNo2b");
        var txtTobaccoNo3a = document.getElementById("txtTobaccoNo3a");
        var txtTobaccoNo3b = document.getElementById("txtTobaccoNo3b");
        var txtTobaccoNo5 = document.getElementById("txtTobaccoNo5");
        var txtTobaccoNo7 = document.getElementById("txtTobaccoNo7");
        var chkTobaccoNo9a = document.getElementById("chkTobaccoNo9a");
        var i = 0;

        arrTobaccoErr[i++] = [txtTobaccoNo1a, '$(\'#txtTobaccoNo1a\').val() == ""', 'Answer Question 1a'];
        arrTobaccoErr[i++] = [txtTobaccoNo1a, 'ispValue($(\'#txtTobaccoNo1a\').val()) == false', 'Value for Question 1a must be numeric'];
        arrTobaccoErr[i++] = [txtTobaccoNo1a, 'ispNegativeNumber($(\'#txtTobaccoNo1a\').val()) == false', 'Value for Question 1a must NOT be negative'];
        //arrTobaccoErr[i++] = [txtTobaccoNo1a, 'parseInt(txtTobaccoNo1b.value) > parseInt(txtTobaccoNo1a.value)', 'Value for Question 1b must NOT be greater than Question 1a'];
        arrTobaccoErr[i++] = [txtTobaccoNo1b, '$(\'#txtTobaccoNo1b\').val() == ""', 'Answer Question 1b'];
        arrTobaccoErr[i++] = [txtTobaccoNo1b, 'ispValue($(\'#txtTobaccoNo1b\').val()) == false', 'Value for Question 1b must be numeric'];
        arrTobaccoErr[i++] = [txtTobaccoNo1b, 'ispNegativeNumber($(\'#txtTobaccoNo1b\').val()) == false', 'Value for Question 1b must NOT be negative'];
        arrTobaccoErr[i++] = [txtTobaccoNo1b, 'parseInt($(\'#txtTobaccoNo1b\').val()) > parseInt($(\'#txtTobaccoNo1a\').val())', 'Value for Question 1b must NOT be greater than Question 1a'];
        arrTobaccoErr[i++] = [txtTobaccoNo2a, '$(\'#txtTobaccoNo2a\').val() == ""', 'Answer Question 2a'];
        arrTobaccoErr[i++] = [txtTobaccoNo2a, 'ispValue($(\'#txtTobaccoNo2a\').val()) == false', 'Value for Question 2a must be numeric'];
        arrTobaccoErr[i++] = [txtTobaccoNo2a, 'ispNegativeNumber($(\'#txtTobaccoNo2a\').val()) == false', 'Value for Question 2a must NOT be negative'];
        arrTobaccoErr[i++] = [txtTobaccoNo2b, '$(\'#txtTobaccoNo2b\').val() == ""', 'Answer Question 2b'];
        arrTobaccoErr[i++] = [txtTobaccoNo2b, 'ispValue($(\'#txtTobaccoNo2b\').val()) == false', 'Value for Question 2b must be numeric'];
        arrTobaccoErr[i++] = [txtTobaccoNo2b, 'ispNegativeNumber($(\'#txtTobaccoNo2b\').val()) == false', 'Value for Question 2b must NOT be negative'];
        arrTobaccoErr[i++] = [txtTobaccoNo2b, 'parseInt($(\'#txtTobaccoNo2b\').val()) > parseInt($(\'#txtTobaccoNo2a\').val())', 'Value for Question 2b must NOT be greater than Question 2a'];
        arrTobaccoErr[i++] = [txtTobaccoNo3a, '$(\'#txtTobaccoNo3a\').val() == ""', 'Answer Question 3a'];
        arrTobaccoErr[i++] = [txtTobaccoNo3a, 'ispValue($(\'#txtTobaccoNo3a\').val()) == false', 'Value for Question 3a must be numeric'];
        arrTobaccoErr[i++] = [txtTobaccoNo3a, 'ispNegativeNumber($(\'#txtTobaccoNo3a\').val()) == false', 'Value for Question 3a must NOT be negative'];

        arrTobaccoErr[i++] = [txtTobaccoNo3b, '$(\'#txtTobaccoNo3b\').val() == ""', 'Answer Question 3b'];
        arrTobaccoErr[i++] = [txtTobaccoNo3b, 'ispValue($(\'#txtTobaccoNo3b\').val()) == false', 'Value for Question 3b must be numeric'];
        arrTobaccoErr[i++] = [txtTobaccoNo3b, 'ispNegativeNumber($(\'#txtTobaccoNo3b\').val()) == false', 'Value for Question 3b must NOT be negative'];
        arrTobaccoErr[i++] = [txtTobaccoNo3b, 'parseInt($(\'#txtTobaccoNo3b\').val()) > parseInt($(\'#txtTobaccoNo3a\').val())', 'Value for Question 3b must NOT be greater than Question 3a'];
        arrTobaccoErr[i++] = [txtTobaccoNo5, '$(\'#txtTobaccoNo5\').val() == ""', 'Answer Question 5'];
        arrTobaccoErr[i++] = [txtTobaccoNo5, 'ispValue($(\'#txtTobaccoNo5\').val()) == false', 'Value for Question 5 must be numeric'];
        arrTobaccoErr[i++] = [txtTobaccoNo5, 'ispNegativeNumber($(\'#txtTobaccoNo5\').val()) == false', 'Value for Question 5 must NOT be negative'];
        arrTobaccoErr[i++] = [txtTobaccoNo7, '$(\'#txtTobaccoNo7\').val() == ""', 'Answer Question 7'];
        arrTobaccoErr[i++] = [txtTobaccoNo7, 'ispValue($(\'#txtTobaccoNo7\').val()) == false', 'Value for Question 7 must be numeric'];
        arrTobaccoErr[i++] = [txtTobaccoNo7, 'ispNegativeNumber($(\'#txtTobaccoNo7\').val()) == false', 'Value for Question 7 must NOT be negative'];
        arrTobaccoErr[i++] = [chkTobaccoNo9a, '$("#lblTobaccoNo9a").text() !== "$0" && (chkTobaccoNo9a.checked == false && chkTobaccoNo9b.checked == false)', 'Select one of the Refund Options'];
    } //LoadTobaccoError

    function ValidateTobaccoReturn() {
        var sId = document.activeElement.id;
        var ObjSelected;
        $(parent.AppError).text('');

        ObjSelected = document.getElementById(sId);
        $(parent.AppError).text(ispSetInputErr(arrTobaccoErr));
        if ($(parent.AppError).text() == '') {
            CalcLine1d();
            CalcLine2d();
            CalcLine3d();
            CalcLine4();

            CalcLine6();
            CalcLine8_9a_9b();
        } else {
         //   parent.AppError.scrollIntoView(true);
        }

    } //ValidateTobaccoReturn

    function btnTobaccoPrint_onclick() {

        $('#btnTobaccoPrint').css("visibility", "hidden");
        $('#btnTobaccoSubmit').css("visibility", "hidden");

        $(parent.AppError).text('');

        if ($('#txtTobaccoNo1a').attr("disabled") == "disabled") {
            FieldLock(false);
            window.print();
            FieldLock(true);
        } else {
            window.print();
        } //if
        $('#btnTobaccoPrint').css("visibility", "visible");
        $('#btnTobaccoSubmit').css("visibility", "visible");
    } //btnTobaccoPrint_onclick

    function btnTobaccoValidate() {
        ValidateTobaccoReturn();
        if ($(parent.AppError).text() == '') {
            ValidateTobaccoReturn();
        }
        if ($(parent.AppError).text() == '') {
            $(parent.AppError).text(ValidatePreparer());
        }
    } //btnWageValidate
    var tempXML = parent.$g.getXmlDocObj();

    function btnTobaccoSubmit_onclick() {

        if ($(parent.AppError).text() == '') {
            if ($(parent.AppError).text() == '') {
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlTobacco, '', 'TOBACCO_INFO RETURN_STATUS', '', 0);
                PopulateTobaccoXML();
                var tempXML = parent.$g.getXmlDocObj(); //new ActiveXObject("MSXML.DOMDocument")
                ispCallXMLForm(parent.$g.xmlTobacco, tempXML, "TobaccoReturn", "");

                ispHideProgress();
                if (parent.$x.ispXmlGetFieldVal(tempXML, 'ERROR_INFO PROGRAM', '', 0) == '') {
                    parent.$g.xmlTobacco.loadXML(tempXML.xml);
                    $('#TobaccoReturn').css("display", "none");
                    DisplayTobaccoThankYou();
                } else {
                    $(parent.AppError).text(parent.$x.ispXmlGetFieldVal(tempXML, 'ERROR_INFO MESSAGE', '', 0));

                }
            }
        } else {
            ispHideProgress();
        }
    }


    function chkAmended_onclick() {

        if ($('#chkAmended').is(":checked")) {
            $('#btnTobaccoSubmit').removeAttr("disabled");
            FieldLock(false);
            ClearPreparer();

        } else {

            $('#btnTobaccoSubmit').attr("disabled", "disabled");
            FieldLock(true);
            PopulatePreparer(parent.$g.xmlTobacco, 'TOBACCO_INFO');

        }
    }


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
        } //for
    } //locatePrimaryAddr

    function SetFocus() {
        document.activeElement.select();
    }


    function chkRefund_onclick() {
        if (document.activeElement.id == 'chkTobaccoNo9a') {
            if ($('#chkTobaccoNo9a').attr("checked") == "checked") {
                $('#chkTobaccoNo9b').removeAttr("checked");
            } else {
                $('#chkTobaccoNo9b').attr("checked", "checked");
            }
        } else {
            if ($('#chkTobaccoNo9b').attr("checked") == "checked") {
                $('#chkTobaccoNo9a').removeAttr("checked");
            } else {
                $('#chkTobaccoNo9a').attr("checked", "checked");
            }
        }

        CalcLine8_9a_9b();

    }

    function splitField(value, start, end) {

        if (value.length != 0) {
            return value.substr(start, end);
        } else {
            return '';
        }
    }

    //EGOVWEB-47 EHD Change lblTobaccoNo7 (HMTL Label) to txtTobaccoNo7 (HTML Input) and all associated code.
    //########## VBSCRIPT CONVERTED TO JAVASCRIPT #####################

    function parseCurrency(value) {
        return ispRemoveMoney(value);
    }

    function CalcLine1d() {
       
        if ($('#txtTobaccoNo1a').val() != '' && $('#txtTobaccoNo1b').val() != '') {
            $('#lblTobaccoNo1c').text(parseCurrency($('#txtTobaccoNo1a').val()) - parseCurrency($('#txtTobaccoNo1b').val()));
            $('#lblTobaccoNo1d').text(ispFormatMoney(parseCurrency($('#lblTobaccoNo1c').text()) * dTobaccoItemTaxRate, 0));
        }
    }

    function CalcLine2d() {
       
        if ($('#txtTobaccoNo2a').val() != "" && $('#txtTobaccoNo2b').val() != "") {
            $('#lblTobaccoNo2c').text(parseCurrency($('#txtTobaccoNo2a').val()) - parseCurrency($('#txtTobaccoNo2b').val()));
            $('#lblTobaccoNo2d').text(ispFormatMoney(parseCurrency($('#lblTobaccoNo2c').text()) * dTobaccoPackTaxRate, 0));

        }
    }

    function CalcLine3d() {
       
        if ($('#txtTobaccoNo3a').val() != "" && $('#txtTobaccoNo3b').val() != "") {
            $('#lblTobaccoNo3c').text(parseCurrency($('#txtTobaccoNo3a').val()) - parseCurrency($('#txtTobaccoNo3b').val()));
            $('#lblTobaccoNo3d').text(ispFormatMoney(parseCurrency($('#lblTobaccoNo3c').text()) * dTobaccoPaperTaxRate, 0));

        }
    }

    function CalcLine4() {
        if ($('#lblTobaccoNo1d').text() != '' && $('#lblTobaccoNo2d').text() != '' && $('#lblTobaccoNo3d').text() != '') {
            $('#lblTobaccoNo4').text(ispFormatMoney(parseCurrency($('#lblTobaccoNo1d').text()) + parseCurrency($('#lblTobaccoNo2d').text()) + parseCurrency($('#lblTobaccoNo3d').text()), 0));
        }
    }

    function CalcLine6() {      
        if ($('#lblTobaccoNo4').text() != '' && $('#txtTobaccoNo5').val() != '') {
            $('#lblTobaccoNo6').text(ispFormatMoney((parseCurrency($('#lblTobaccoNo4').text()) - parseCurrency($('#txtTobaccoNo5').val())), 0));
        }
    }

    function CalcLine8_9a_9b() {       
        var lTaxDue;
        var Tdate;
        if ($('#lblTobaccoNo6').text() == '') {
            $('#lblTobaccoNo6').text(ispFormatMoney(0, 0));
        }

        if ($('#txtTobaccoNo7').val() == '') {
            $('#txtTobaccoNo7').val(ispFormatMoney(0, 0));
        } else {
            $('#txtTobaccoNo7').val(ispFormatMoney(parseCurrency($('#txtTobaccoNo7').val()), 0));
        }

        lTaxDue = parseCurrency($('#lblTobaccoNo6').text()) + parseCurrency($('#txtTobaccoNo7').val());

        if (lTaxDue < 0) {
            Tdate = 0;
        } else {
            Tdate = ispFormatMoney(lTaxDue, 0);
        }


        if (lTaxDue >= 0) {
            $('#chkTobaccoNo9a').attr("disabled", "disabled");
            $('#chkTobaccoNo9b').attr("disabled", "disabled");
            $('#chkTobaccoNo9a').removeAttr("checked");
            $('#chkTobaccoNo9b').removeAttr("checked");

            $('#lblTobaccoNo9a').text(ispFormatMoney(0, 0));
            $('#lblTobaccoNo9b').text(ispFormatMoney(0, 0));
            $('#lblTobaccoNo8').text(ispFormatMoney(Tdate));

        } else {
            if ($('#lblTobaccoNo9a').attr("disabled") != "disabled") {
                $('#chkTobaccoNo9a').removeAttr("disabled");
                $('#chkTobaccoNo9b').removeAttr("disabled");
            }

            $('#lblTobaccoNo8').text(ispFormatMoney(0, 0));

            if ($('#chkTobaccoNo9a').is(":checked") != true && $('#chkTobaccoNo9b').is(":checked") != true) {
                $('#chkTobaccoNo9a').attr("checked", "checked");
                $('#lblTobaccoNo9a').text(ispFormatMoney(Tdate, 0));

            } else if ($('#chkTobaccoNo9a').is(":checked")) {
                $('#chkTobaccoNo9a').attr("checked", "checked");
                $('#lblTobaccoNo9a').text(ispFormatMoney(Tdate));
                $('#lblTobaccoNo9b').text(ispFormatMoney(0, 0));

            } else if ($('#chkTobaccoNo9b').is(":checked")) {
                $('#chkTobaccoNo9b').attr("checked", "checked");
                $('#lblTobaccoNo9a').text(ispFormatMoney(0, 0));
                $('#lblTobaccoNo9b').text(ispFormatMoney(Tdate));
            }
        }
    } //CalcLine8_9a_9b

    function GETabs(n) {
        if (parseFloat(n) < 0) {
            return (-1) * parseFloat(n);
        } else {
            return parseFloat(n);
        }
    }



</script>
<title></title>
</head>
    <body>
<%--<body onload="ispDisplayProgress('DisplayTobaccoReturn()', 'Retrieving 2010 tobacco tax information')">--%>
    <div class="tab_Tcontainer" id="TobaccoReturn">
        <div class="tab_container">
            <div style="display: block;" id="tab1" class="tab_content">
               <h2><span id="AppHeader">&nbsp;</span>  </h2>

                <div class="thankyou">
                    <h4 id="AppMessage">&nbsp;</h4>

                    <div class="school_form">


                        <div class="school_page_form">

                         

                            <div class="account_greybox">
                                 <p><strong>Account Id:</strong> <label id=lblAcctId class="lblTextBlack" ></label> </p>

                                <p><strong><font id=lblEntityType>EIN :</font></strong> <label id=lblEntityId class="lblTextBlack"></label> </p>
                                 <div class="clear"></div>
                                <p><strong>Name :</strong> <label id=lblName_08 class="lblTextBlack" ></label> </p>

                                <div class="clear"></div>
                                <p><strong>Address :</strong> <label id=lblAddress class="lblTextBlack"></label> </p>

                                <div class="clear"></div>

                            </div>


                            <div class="form_segment">


                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabularform">
                                    <tr>
                                        <th width="24%" scope="col" valign="middle" align="left" class="here_input_table">
                                            <input id=chkAmended type=checkbox onclick="chkAmended_onclick()" type="checkbox" />
                                            Check if amended return. </th>
                                        <th colspan=15 >
			<label class="" style="color: Red;width:100%" >All decimals will be rounded to the nearest whole number</label></th>
                                        </tr>
                                   
                                </table>


                            </div>


                            <div class="form_segment">

                                <table summary="Employee Pay Sheet" class="hor-zebra">

                                    <tbody>

                                        <tr class="odd">
                                            <td width="70%"><b>1. Tobacco and tobacco-related products that consists of individual items rolled for smoking (e.g., cigars) </b></td>
                                            <td align="center" class="no_border_right">
                                               </td>
                                        </tr>
                                        <tr>
                                            <td>1a.  Taxable interest</td>
                                            <td align="center" class="no_border_right">
                                                <input type="text"  id="txtTobaccoNo1a" onchange="ValidateTobaccoReturn()" onfocus="SetFocus()" maxlength="10" style="WIDTH: 100%"  /></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">1b.  Number of items delivered to bona fida customer locations outside Philadelphia. </td>
                                            <td align="center" class="no_border_right">
                                               <input class=inpNormal id=txtTobaccoNo1b onchange="ValidateTobaccoReturn()" onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%" /></td>
                                        </tr>
                                        <tr>
                                            <td>1c.  Number of items sold to customers within Philadelphia.[Calculated - line 1a minus line 1b]&nbsp;</td>
                                            <td align="center" class="no_border_right">
                                                <label class="" id=lblTobaccoNo1c style="WIDTH: 100%"></label></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%"><label class="" id=msgTobaccoNo1d style="width:100%">1d.  TAX DUE [Calculated - line 1c * ### per item]&nbsp;</label></td>
                                            <td align="center" class="no_border_right">
                                               <label class="" id=lblTobaccoNo1d style="WIDTH: 100%"></label></td>
                                        </tr>
                                        <tr>
                                            <td><b>2. All other tobacco and tobacco-related products (e.g., smokeless tobacco, pipe tobacco, loose tobacco)</b></td>
                                            <td align="center" class="no_border_right">
                                               </td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">2a.  Total number of ounces of all tobacco and tobacco-related items sold January 1 through December 31, 2010. </td>
                                            <td align="center" class="no_border_right">
                                               <input class=inpNormal id=txtTobaccoNo2a onchange="ValidateTobaccoReturn()" onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%"></td>
                                        </tr>
                                        <tr>
                                            <td>2b.  Total ounces delivered to bona fida customer locations outside Philadelphia.</td>
                                            <td align="center" class="no_border_right">
                                                <input class=inpNormal id=txtTobaccoNo2b onchange="ValidateTobaccoReturn()" onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%"></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">2c.  Ounces of products sold to customers within Philadelphia.[Calculated - line 2a minus line 2b] </td>
                                            <td align="center" class="no_border_right">
                                               <label class="" id=lblTobaccoNo2c style="WIDTH: 100%"></label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><label class="" id=msgTobaccoNo2d style="width:100%">2d.  Deductible ExpenseTAX DUE[Calculated - line 2c * ### per ounce]&nbsp;</label></td>
                                            <td align="center" class="no_border_right">
                                                <label class="" id=lblTobaccoNo2d style="WIDTH: 100%"></label></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%"><b>3. Rolling Papers</b></td>
                                            <td align="center" class="no_border_right">
                                               
                                            </td>
                                        </tr>
                                        <tr >
                                            <td width="70%"> 3a.  Total number of packs sold January 1 through December 31, 2010.&nbsp;</td>
                                            <td align="center" class="no_border_right">
                                                <input class="" id=txtTobaccoNo3a onchange="ValidateTobaccoReturn()"
			 onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%">
                                            </td>
                                        </tr>
                                        <tr class="odd">
                                            <td>3b.  Total number of packs delivered to bona fida customer locations outside Philadelphia.</td>
                                            <td align="center" class="no_border_right">
                                                <input class="" id=txtTobaccoNo3b onchange="ValidateTobaccoReturn()"
			 onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%"></td>
                                        </tr>
                                        <tr >
                                            <td width="70%">3c.  Number of packs sold to customers within Philadelphia.[Calculated - line 3a minus line 3b]&nbsp;</td>
                                            <td align="center" class="no_border_right">
                                               	<label class="" id=lblTobaccoNo3c style="WIDTH: 100%"></label>
                                            </td>
                                        </tr>
                                        <tr class="odd">
                                            <td><label class="" id=msgTobaccoNo3d style="WIDTH: 100%">3d. TAX DUE[Calculated - line 3c * ### per pack]&nbsp;</label></td>
                                            <td align="center" class="no_border_right">
                                               <label class="" id=lblTobaccoNo3d style="WIDTH: 100%"></label> </td>
                                        </tr>
                                        <tr>
                                            <td width="70%">4. Tax due by January 31, 2011[Calculated - add lines 1d, 2d and 3d]</td>
                                            <td align="center" class="no_border_right">
                                                <label class="" id=lblTobaccoNo4 style="WIDTH: 100%"></label></td>
                                        </tr>
                                        <tr class="odd">
                                            <td>5. Tax previously paid for tax year 2010 and other credits</td>
                                            <td align="center" class="no_border_right">
                                                <input class="" id=txtTobaccoNo5 onchange="ValidateTobaccoReturn()"
			 onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%"></td>
                                        </tr>

                                         <tr >
                                            <td>6. Net Tax Due[Calculated - line 4 minus line 5]&nbsp;</td>
                                            <td align="center" class="no_border_right">
                                               <label class="" id=lblTobaccoNo6 style="WIDTH: 100%"></label></td>
                                        </tr>

                                         <tr class="odd">
                                            <td>7. Interest and Penalty</td>
                                            <td align="center" class="no_border_right">
                                                <input class="" id=txtTobaccoNo7 onchange="ValidateTobaccoReturn()"
			 onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%"></td>
                                        </tr>

                                        <tr >
                                            <td>8. <b><u>Total Due</u></b> including Interest and Penalty[Calculated - line 6 plus line 7]&nbsp;</td>
                                            <td align="center" class="no_border_right">
                                                <label class="" id=lblTobaccoNo8 style="WIDTH: 100%"></label></td>
                                        </tr>

                                        <tr class="odd">
                                            <td>9a. <input id=chkTobaccoNo9a type=checkbox style="WIDTH: 13px; HEIGHT: 20px" size=13 onclick="chkRefund_onclick()" /> 
			<label class="" style="WIDTH: 100%">If Line 5 is greater than Line 8, enter the amount to be <b><i>refunded</i></b> or  skip to Line 9b.</label></td>
                                            <td align="center" class="no_border_right">
                                              <label class="" id=lblTobaccoNo9a style="WIDTH: 100%"></label></td>
                                        </tr>
                                        <tr >
                                            <td>9b. <input id=chkTobaccoNo9b type=checkbox style="WIDTH: 13px; HEIGHT: 20px" size=13 onclick="chkRefund_onclick()" /> 
			<label class="" style="WIDTH: 100%">Amount of overpayment to be applied to the 2011 Tobacco and Tobacco-Related Products Tax.</label></td>
                                            <td align="center" class="no_border_right">
                                             <label class="" id=lblTobaccoNo9b style="WIDTH: 100%"></label></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="clear"></div>

                            </div>


                           <div> <%
                Html.RenderAction("PreparerSection", "INC");   
            %></div>
                             <div class="form_segment here_input_table" align="right">
                                <input id="btnTobaccoPrint" type="button" value="Print" class="submit_button_light" onclick="parent.doPrintDocWin()" />
                                <input type="button" value="Submit" class="submit_button" id="btnTobaccoSubmit" onclick="btnTobaccoValidate(); ispDisplayProgress('btnTobaccoSubmit_onclick()', 'Submitting 2011 tobacco tax information')" />
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
    </div>
</body>
</html>
