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
   
    <script id="clientEventHandlersJS" language="javascript">

        var arrNumWage08Err = new Array();
        var arrWage08Err = new Array();
        var txtHeader = 'Taxpayer Information';
        var dResTax_A, dResTax_B, dNonResTax_A, dNonResTax_B;
        var gUserAddr = '<%Response.Write(Request.ServerVariables["REMOTE_ADDR"]);%>'
        $(document).ready(function () {
            $('input').keyup(function (e) {

                var key = e.charCode ? e.charCode : e.keyCode ? e.keyCode : 0;
                if (key == 13) {
                    e.preventDefault();
                    return false;
                }

            });

            $('input').keydown(function (e) {

                var key = e.charCode ? e.charCode : e.keyCode ? e.keyCode : 0;
                if (key == 13) {

                    e.preventDefault();
                    return false;
                }

            });
        DisplayWage08Return();
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

    function DisplayWage08Return() {
       
        if (parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, 'TAX_ACCT[ACCOUNT = "1"]', '', 0)) {
           
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, 'INQ', 'WAGE_INFO RETURN_STATUS', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ENTITY_ID', '', 0), 'WAGE_INFO ENTITY_ID', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ACCOUNT_ID', '', 0), 'WAGE_INFO ACCOUNT_ID', '', 0);

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, '12/31/2014', 'WAGE_INFO PERIOD', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, '', 'DEBUG', '', 0);

            var ReqXML = parent.$g.xmlWage;
            $.ajax({
                type: 'POST',
                url: '../Returns/Log',
                data: '{ "OriginationFom" : "Wage-2014","ServiceName" : "RTTIE027","RequestXML" : "' + btoa(ReqXML.toString()) + '"}',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (msg) {

                }
            });
            //var xmlTemp = parent.$g.getXmlDocObj();
            ispCallXMLForm(parent.$g.xmlWage, parent.$g.xmlWage, "WageReturn", "");

            var ResXML =parent.$g.xmlWage;
            $.ajax({
                type: 'POST',
                url: '../Returns/Log',
                data: '{ "OriginationFom" : "Wage-2014","ServiceName" : "RTTIE027","ResponseXML" : "' + btoa(ResXML.toString()) + '"}',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (msg) {

                }
            });


            ispHideProgress();
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'ERROR_INFO ERROR', "", 0) != 0) {
               
                $('#WageReturn_08').css('display', 'block');
                resolvedIframeheight();
                AppHeader.innerHTML = 'wage tax reconciliation return';
                PopulateWage08Header();
                FieldLock_08(true);
                $("#AppError").innerText = parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'ERROR_INFO MESSAGE', '', 0)
                $('#btnWage08Submit').attr('disabled', 'disable');
                $('#chkAmended_08').attr('disabled', 'disable');
                return
            } //if
            if ($(parent.divAcctInfo).css("display") == 'none') {
                $(parent.divAcctInfo).css("display", "block");
                $(parent.divAccount).css("display", "none");
            } //if
        } else {          
            parent.ispMenu_onclick(parent.mnuAcctInfo);
        } //if     
        $('#WageReturn').css('display', 'block');

        resolvedIframeheight();
        $('#AppHeader').html('wage tax reconciliation return for 2014');
        parent.gsInstructionItem = '#WageReturn';    

        $('#AppMessage').html('<BR>The Reconciliation of Wage Tax for 2014 is due February 28, 2015.');
       

        LoadWage08Error()
        RightAlignText()
        CheckWage08XML()
        SetWage08Fields()
        PopulateWage08Header()
        PopulateWage08Data()
        $("#AppError").text('');
        
        
        var txtPrepAreaCode = document.getElementById("txtPrepAreaCode");
        if (txtPrepAreaCode.value == 0) {
            txtPrepAreaCode.value = "";
        }
        $('#txtWageNo1_08').focus();
    }


    function SetWage08Fields() {       
        var chkTaxpayer = document.getElementById('chkTaxpayer');
        var chkAmended_08 = document.getElementById('chkAmended_08');
        var chkAgreement = document.getElementById('chkAgreement');
        FieldLock_08(false)
        $('#chkAmended_08').attr('disabled', 'disable');       
        chkTaxpayer.checked = false
        chkAmended_08.checked = false
        chkAgreement.checked = false;
        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO VERSION', '', 0) != '') {
            $('#chkAmended_08').removeAttr('disabled');
            FieldLock_08(true)
            chkAgreement.checked = true;           
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
            $('#btnWage08Submit').attr('disabled', 'disable');
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
            $('#btnWage08Submit').removeAttr('disabled');
        }
        DisablePreparer(bDisabled)
    }


    function CheckWage08XML() {
        var bPeriodExist = true
        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO PERIOD', '', 0) != '' && new Date(parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO PERIOD', '', 0)) < new Date('01/01/2014')) {
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

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, '12/31/2014', 'WAGE_INFO PERIOD', '', 0)
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

        $('#txtWageNoA_08').val(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO NO_OF_RESIDENTS', '', 0));
        $('#txtWageNoB_08').val(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO NO_OF_NONRESIDENTS', '', 0));
        $('#txtWageNoC_08').val(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO TOTAL_EMPLOYEES', '', 0));
        $('#txtWageNoD_08').val(
            parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO PHILA_EMPLOYEES', '', 0));
        $('#txtWageNo1_08').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO GROSS_COMP', '', 0), 0));
        $('#txtWageNo2_08').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO NON_TAXABLE_COMP', '', 0), 0));
        $('#lblWageNo3_08').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO NET_COMP', '', 0), 0));
        $('#txtWageNo4_08').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO RESIDENT_PAYROLL_A', '', 0), 0));
        $('#lblWageNo5_08').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO RESIDENT_TAX_DUE_A', '', 0), 0));
        $('#txtWageNo6_08').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO RESIDENT_PAYROLL_B', '', 0), 0));
        $('#lblWageNo7_08').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO RESIDENT_TAX_DUE_B', '', 0), 0));
        $('#txtWageNo8_08').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO NON_RES_PAYROLL_A', '', 0), 0));
        $('#lblWageNo9_08').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO NON_RES_TAX_DUE_A', '', 0), 0));
        $('#txtWageNo10_08').val(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO NON_RES_PAYROLL_B', '', 0), 0));
        $('#lblWageNo11_08').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO NON_RES_TAX_DUE_B', '', 0), 0));
        $('#lblWageNo12_08').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO TOTAL_GROSS_TAX_DUE', '', 0), 0));
        $('#lblWageNo13_08').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO TAX_PAID', '', 0), 0));
        $('#lblWageNo14_08').text(ispFormatMoney(
        parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'AMT_INFO TAX_DUE', '', 0), 0));
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

        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, $('#txtWageNoA_08').val(), 'WAGE_INFO NO_OF_RESIDENTS', '', 0)
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, $('#txtWageNoB_08').val(), 'WAGE_INFO NO_OF_NONRESIDENTS', '', 0)
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, $('#txtWageNoC_08').val(), 'WAGE_INFO TOTAL_EMPLOYEES', '', 0)
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, $('#txtWageNoD_08').val(), 'WAGE_INFO PHILA_EMPLOYEES', '', 0)

        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, stripCurrency($('#txtWageNo1_08').val()), 'AMT_INFO GROSS_COMP', '', 0)
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, stripCurrency($('#txtWageNo2_08').val()), 'AMT_INFO NON_TAXABLE_COMP', '', 0)
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, stripCurrency($('#lblWageNo3_08').text()), 'AMT_INFO NET_COMP', '', 0)
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, stripCurrency($('#txtWageNo4_08').val()), 'AMT_INFO RESIDENT_PAYROLL_A', '', 0)
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, stripCurrency($('#lblWageNo5_08').text()), 'AMT_INFO RESIDENT_TAX_DUE_A', '', 0)
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, stripCurrency($('#txtWageNo6_08').val()), 'AMT_INFO RESIDENT_PAYROLL_B', '', 0)
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, stripCurrency($('#lblWageNo7_08').text()), 'AMT_INFO RESIDENT_TAX_DUE_B', '', 0)
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, stripCurrency($('#txtWageNo8_08').val()), 'AMT_INFO NON_RES_PAYROLL_A', '', 0)
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, stripCurrency($('#lblWageNo9_08').text()), 'AMT_INFO NON_RES_TAX_DUE_A', '', 0)
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, stripCurrency($('#txtWageNo10_08').val()), 'AMT_INFO NON_RES_PAYROLL_B', '', 0)
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
        var txtWageNoA_08 = document.getElementById('txtWageNoA_08');
        var txtWageNoB_08 = document.getElementById('txtWageNoB_08');
        var txtWageNoC_08 = document.getElementById('txtWageNoC_08');
        var txtWageNoD_08 = document.getElementById('txtWageNoD_08');
        var txtWageNo1_08 = document.getElementById('txtWageNo1_08');
        var txtWageNo2_08 = document.getElementById('txtWageNo2_08');            
        var txtWageNo4_08 = document.getElementById('txtWageNo4_08');       
        var txtWageNo6_08 = document.getElementById('txtWageNo6_08');       
        var txtWageNo8_08 = document.getElementById('txtWageNo8_08');       
        var txtWageNo10_08 = document.getElementById('txtWageNo10_08');
       
        arrWage08Err[i++] = [txtWageNo1_08, '$(\'#txtWageNo1_08\').val() == ""', 'Answer question 1'];
        arrWage08Err[i++] = [txtWageNo1_08, 'ispValue($(\'#txtWageNo1_08\').val()) == false', 'Value for question 1  must be numeric']
        arrWage08Err[i++] = [txtWageNo1_08, 'ispNegativeNumber($(\'#txtWageNo1_08\').val()) == false', 'Value for question 1 must not be negative']
      
        arrWage08Err[i++] = [txtWageNo2_08, '$(\'#txtWageNo2_08\').val() == ""', 'Answer question 2']
        arrWage08Err[i++] = [txtWageNo2_08, 'ispValue($(\'#txtWageNo2_08\').val()) == false', 'Value for question 2  must be numeric']
        arrWage08Err[i++] = [txtWageNo2_08, 'ispNegativeNumber($(\'#txtWageNo2_08\').val()) == false', 'Value for question 2 must not be negative']

        arrWage08Err[i++] = [txtWageNo4_08, '$(\'#txtWageNo4_08\').val() == ""', 'Answer question 4']
        arrWage08Err[i++] = [txtWageNo4_08, 'ispValue($(\'#txtWageNo4_08\').val()) == false', 'Value for question 4  must be numeric']
        arrWage08Err[i++] = [txtWageNo4_08, 'ispNegativeNumber($(\'#txtWageNo4_08\').val()) == false', 'Value for question 4 must not be negative']

        arrWage08Err[i++] = [txtWageNo6_08, '$(\'#txtWageNo6_08\').val() == ""', 'Answer question 6']
        arrWage08Err[i++] = [txtWageNo6_08, 'ispValue($(\'#txtWageNo6_08\').val()) == false', 'Value for question 6  must be numeric']
        arrWage08Err[i++] = [txtWageNo6_08, 'ispNegativeNumber($(\'#txtWageNo6_08\').val()) == false', 'Value for question 6 must not be negative']

        arrWage08Err[i++] = [txtWageNo8_08, '$(\'#txtWageNo8_08\').val() == ""', 'Answer question 8']
        arrWage08Err[i++] = [txtWageNo8_08, 'ispValue($(\'#txtWageNo8_08\').val()) == false', 'Value for question 8  must be numeric']
        arrWage08Err[i++] = [txtWageNo8_08, 'ispNegativeNumber($(\'#txtWageNo8_08\').val()) == false', 'Value for question 8 must not be negative']

        arrWage08Err[i++] = [txtWageNo10_08, '$(\'#txtWageNo10_08\').val() == ""', 'Answer question 10']
        arrWage08Err[i++] = [txtWageNo10_08, 'ispValue($(\'#txtWageNo10_08\').val()) == false', 'Value for question 10  must be numeric']
        arrWage08Err[i++] = [txtWageNo10_08, 'ispNegativeNumber($(\'#txtWageNo10_08\').val()) == false', 'Value for question 10 must not be negative']
      
        i = 0 //Reset
        arrNumWage08Err[i++] = [txtWageNoA_08, 'ispValue($(\'#txtWageNoA_08\').val()) == false', 'Value for question A  must be numeric']
        arrNumWage08Err[i++] = [txtWageNoB_08, 'ispValue($(\'#txtWageNoB_08\').val()) == false', 'Value for question B  must be numeric']
        arrNumWage08Err[i++] = [txtWageNoC_08, 'ispValue($(\'#txtWageNoC_08\').val()) == false', 'Value for question C  must be numeric']
        arrNumWage08Err[i++] = [txtWageNoD_08, 'ispValue($(\'#txtWageNoD_08\').val()) == false', 'Value for question D  must be numeric']

        arrNumWage08Err[i++] = [txtWageNoA_08, 'ispNegativeNumber($(\'#txtWageNoA_08\').val()) == false', 'Value for question A must not be negative']
        arrNumWage08Err[i++] = [txtWageNoB_08, 'ispNegativeNumber($(\'#txtWageNoB_08\').val()) == false', 'Value for question B must not be negative']
        arrNumWage08Err[i++] = [txtWageNoC_08, 'ispNegativeNumber($(\'#txtWageNoC_08\').val()) == false', 'Value for question C must not be negative']
        arrNumWage08Err[i++] = [txtWageNoD_08, 'ispNegativeNumber($(\'#txtWageNoD_08\').val()) == false', 'Value for question D must not be negative']
    } //LoadWage08Error

    function ValidateWage08Number() {       
        $("#AppError").text('');
        CheckABCD();
        $("#AppError").text(ispSetInputErr_Form(arrNumWage08Err));
        if ($("#AppError").text() != '') {
            resolvedIframeheight();
            parent.ScrollTop(arrNumWage08Err);
        }
    }

    function ValidateWage08Prelim() {
       
        var evt = window.event || arguments.callee.caller.arguments[0];
        var source = parent.getEventSource(evt);
        var ObjSelected = source;

        $("#AppError").text('');

        $('#txtWageNo1_8').attr('class', 'inpNormal form-control input-sm pull-right');
        if (ObjSelected) {
            if (ObjSelected.type != 'button') {
                ObjSelected.value = ispFormatMoney(ObjSelected.value, 0);
            }
        }

        $("#AppError").text(ispSetInputErr_Form(arrWage08Err));

        if ($("#AppError").text() == '') {
            Calc1Minus2();
            TaxDueLine5(dResTax_A);
            TaxDueLine7(dResTax_B);
            TaxDueLine9(dNonResTax_A);
            TaxDueLine11(dNonResTax_B);
            TaxDueLine12();
            TaxDueLine14_15();
        } else {
            resolvedIframeheight();
            parent.ScrollTop(arrWage08Err);
        }
    }


    function ValidateWage08Return() {
        var evt = window.event || arguments.callee.caller.arguments[0];
        var source = parent.getEventSource(evt);

        var ObjSelected = source;

        if ($("#AppError").text() == '') {
            $('#txtWageNo1_8').attr('class', 'inpNormal form-control input-sm pull-right');
            if (ObjSelected) {
                if (ObjSelected.type != 'button') {
                    ObjSelected.value = ispFormatMoney(ObjSelected.value, 0);
                }
            }

            $("#AppError").text(ispSetInputErr_Form(arrWage08Err));

            if ($("#AppError").text() == '') {
                Calc1Minus2()
                TaxDueLine5(dResTax_A);
                TaxDueLine7(dResTax_B);
                TaxDueLine9(dNonResTax_A);
                TaxDueLine11(dNonResTax_B);
                TaxDueLine12();
                TaxDueLine14_15();
                if ($("#AppError").text() == '') {
                    CalcGrossComp();
                }

            } else {
                resolvedIframeheight();
                parent.ScrollTop(arrWage08Err);
            }
        }
    }


    function resolvedIframeheight()
    {
        //iframe height issue resolved
        var iframe = window.parent.document.getElementById('ifrmDocwin');
        var container = $('#tab1').css("height");
        iframe.style.height = container;
    }

    function btnWage08Print_onclick() {
        $('#btnWage08Print').css('visibility', 'hidden');
        $('#btnWage08Submit').css('visibility', 'hidden');
        $("#AppError").text('');

        if ($('#txtWageNo1_08').is(':disabled') == true) {
            FieldLock_08(false);
            window.print();
            FieldLock_08(true);
        } else {
            window.print();
        } //if
        $('#btnWage08Print').css('visibility', 'visible');
        $('#btnWage08Submit').css('visibility', 'visible');


      
    }



    var tempXML = parent.$g.getXmlDocObj();

    function btnWageValidate() {       
        ValidateWage08Number();
        //ValidateWage08Prelim();
        if ($("#AppError").text() == '') {
            ValidateWage08Return();
        }
        if ($("#AppError").text() == '') {
            $("#AppError").text(ValidatePreparer());
            if ($("#AppError").text() != '') {
                resolvedIframeheight();
                parent.ScrollTop(ValidatePreparer());
            }
        }
       
    }


    function btnWage08Submit_onclick() {
        if ($("#AppError").text() == "") {
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlWage, '', 'WAGE_INFO RETURN_STATUS', '', 0);
            PopulateWage08XML();

            var ReqXML = parent.$g.xmlWage;
            $.ajax({
                type: 'POST',
                url: '../Returns/Log',
                data: '{ "OriginationFom" : "Wage-2014","ServiceName" : "RTTIE027","RequestXML" : "' + btoa(ReqXML.toString()) + '"}',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (msg) {

                }
            });

            ispCallXMLForm(parent.$g.xmlWage, tempXML, "WageReturn", "");


           

            ispHideProgress();

            parent.$g.xmlWage.loadXML(tempXML.xml);
            var ResXML = tempXML;
            $.ajax({
                type: 'POST',
                url: '../Returns/Log',
                data: '{ "OriginationFom" : "Wage-2014","ServiceName" : "RTTIE027","ResponseXML" : "' + btoa(ResXML.toString()) + '"}',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (msg) {

                }
            });
            if (parent.$x.ispXmlGetFieldVal(tempXML, 'ERROR_INFO PROGRAM', '', 0) == '') {
                parent.$g.xmlWage.loadXML(tempXML.xml);
                $('#WageReturn_08').css('display', 'none');
                DisplayWageThankYou();
            } else {
                $("#AppError").text(parent.$x.ispXmlGetFieldVal(tempXML, 'ERROR_INFO MESSAGE', '', 0));
            }
        } else {
            ispHideProgress();
        }
    }




    function chkAmended_08_onclick() {
        var chkTaxpayer = document.getElementById('chkTaxpayer');
        var chkAmended_08 = document.getElementById('chkAmended_08');
        var chkAgreement = document.getElementById('chkAmended_08');
        if (chkAmended_08.checked == true) {
            $('#btnWage08Submit').removeAttr('disabled');
            FieldLock_08(false);
            ClearPreparer();
            $('#txtWageNo1_08').focus();
        } else {
            $('#btnWage08Submit').attr('disabled', 'disable');
            chkAgreement.checked = false;
            FieldLock_08(true);
            PopulatePreparer(parent.$g.xmlWage, 'WAGE_INFO');
        }
    }


    function ReadOnlySetFocus() {

        var txtWageNo10_08 = document.getElementById('txtWageNo10_08');
        var txtWageNo1_08 = document.getElementById('txtWageNo1_08');
        var evt = window.event || arguments.callee.caller.arguments[0];
        var source = parent.getEventSource(evt);

        var sId = source.id;

        switch (sId) {

            case 'txtWageNo10_08':
                $('#txtWageNo10_08').select()
                break
            case 'lblWageNo13_08':
                $('#txtWageNo1_08').select()
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

        if (($('#txtWageNoA_08').val() == "") || ($('#txtWageNoA_08').val() < 0)) {
            $('#txtWageNoA_08').val(0);
        } else {
            $('#txtWageNoA_08').val($('#txtWageNoA_08').val())
        }

        if (($('#txtWageNoB_08').val() == "") || ($('#txtWageNoB_08').val() < 0)) {
            $('#txtWageNoB_08').val(0);
        } else {
            $('#txtWageNoB_08').val($('#txtWageNoB_08').val());
        }
        if (($('#txtWageNoC_08').val() == "") || ($('#txtWageNoC_08').val() < 0)) {
            $('#txtWageNoC_08').val(0);
        } else {
            $('#txtWageNoC_08').val($('#txtWageNoC_08').val());
        }

        if (($('#txtWageNoD_08').val() == "") || ($('#txtWageNoD_08').val() < 0)) {
            $('#txtWageNoD_08').val(0);
        } else {
            $('#txtWageNoD_08').val($('#txtWageNoD_08').val());
        }
    }

    function CheckGrossComp() {
        if ((parseCurrency($('#lblWageNo5_08').text()) != 0) || (parseCurrency($('#lblWageNo7_08').text()) != 0) || (parseCurrency($('#lblWageNo9_08').text()) != 0) || (parseCurrency($('#lblWageNo11_08').text()) != 0) || (parseCurrency($('#lblWageNo12_08').text()) != 0) || (parseCurrency($('#lblWageNo13_08').text()) != 0)) {

            if ($("#AppError").text() == '') {
                $('#txtWageNo4_08').attr('class', 'inpNormal form-control input-sm pull-right');
                $('#txtWageNo6_08').attr('class', 'inpNormal form-control input-sm pull-right');
                $('#txtWageNo8_08').attr('class', 'inpNormal form-control input-sm pull-right');
                $('#txtWageNo10_08').attr('class', 'inpNormal form-control input-sm pull-right');
                if (parseCurrency($('#txtWageNo4_08').val()) == 0 && parseCurrency($('#txtWageNo6_08').val()) == 0 && parseCurrency($('#txtWageNo8_08').val()) == 0 && parseCurrency($('#txtWageNo10_08').val()) == 0) {
                    $("#AppError").text('Lines 4, 6, 8 & 10 can not all equal 0');
                    $('#txtWageNo4_08').attr('class', 'inpNormal form-control input-sm pull-right');
                    $('#txtWageNo6_08').attr('class', 'inpError form-control input-sm pull-right');
                    $('#txtWageNo8_08').attr('class', 'inpError form-control input-sm pull-right');
                    $('#txtWageNo10_08').attr('class', 'inpError form-control input-sm pull-right');
                }
            }
        }
    }

    function Calc1Minus2() {
      
        if ($('#txtWageNo1_08').val() != "" && $('#txtWageNo2_08').val() != "") {
            //var val1 =
            $('#lblWageNo3_08').text(ispFormatMoney(parseCurrency($('#txtWageNo1_08').val()) - parseCurrency($('#txtWageNo2_08').val()), 0));
        }
    }

    function CalcGrossComp() {       
        if (parseCurrency($('#lblWageNo3_08').text()) != (parseCurrency($('#txtWageNo4_08').val()) + parseCurrency($('#txtWageNo6_08').val()) + parseCurrency($('#txtWageNo8_08').val()) + parseCurrency($('#txtWageNo10_08').val()))) {
            //$('#txtWageNo1_08').attr('class', 'inpError form-control input-sm pull-right ');
            $("#AppError").text('Line 3 is not equal to the sum of lines 4, 6, 8 & 10');
            parent.ScrollTop(1);
        } else {
            //$('#txtWageNo1_08').attr('class', 'inpNormal form-control input-sm pull-right');
            $("#AppError").text('');
        }
    }

    function TaxDueLine5(dTax) {       
        var dTax = .03924;
        if ($('#txtWageNo4_08').val() != "") {

            $('#lblWageNo5_08').text(ispFormatMoney(parseCurrency(parseCurrency($('#txtWageNo4_08').val()) * parseCurrency(dTax)), 0));
        }
    }

    function TaxDueLine7(dTax) {       
        var dTax = .03920;
        if ($('#txtWageNo6_08').val() != "") {
            $('#lblWageNo7_08').text(ispFormatMoney(parseCurrency(parseCurrency($('#txtWageNo6_08').val()) * parseCurrency(dTax)), 0));
        }
    }

    function TaxDueLine9(dTax) {
        var dTax = .03495;
        if ($('#txtWageNo8_08').val() != "") {
            $('#lblWageNo9_08').text(ispFormatMoney(parseCurrency(parseCurrency($('#txtWageNo8_08').val()) * parseCurrency(dTax)), 0))
        }
    }

    function TaxDueLine11(dTax) {
        var dTax = .034915;
        if ($('#txtWageNo10_08').val() != "") {
            $('#lblWageNo11_08').text(ispFormatMoney(parseCurrency(parseCurrency($('#txtWageNo10_08').val()) * parseCurrency(dTax)), 0))
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
<body>
    <div class="container-fluid no-padding" id="WageReturn_08">

        <div class="block3">

            <div class="container-fluid">

                <div class="row">

                    <div class="col-lg-12 col-md-12" style="display: block;" id="tab1">

                        <div class="blue_base_box">
                       
                              <h2>Taxpayer Information  |   <span id="AppHeader"></span>  </h2>
                            <div class="inner_white-panel">
                                 <div class="col-lg-6 col-lg-offset-3 no-padding-left">
                                                  <div id="AppError" class="errormsg no-padding" style="display:block; margin-bottom:0 !important;">
                                                   </div>
                                                     </div>   
                                <div class="contentsection">
                                    <h4 id="AppMessage">&nbsp;</h4>

                                    <div class="clearfix"></div>

                                  

                                    <div class="row">

                                        <div class="col-lg-12">                                          
                                            <div class="well" style="padding:6px 10px !important; margin-bottom:0px !important;">
                                                <div class="row">
                                                    <form>
                                                        <div class="col-lg-9 col-md-9 col-sm-9 col-xs-9">
                                                            <p style="margin-bottom:0 !important;">
                                                                <span>Name:</span>
                                                                <span id="lblName_08" class=""></span>
                                                            </p>
                                                        </div>

                                                        <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3">
                                                            <p style="margin-bottom:0 !important;">
                                                                <span id="lblAccountType">Account No.:</span>
                                                                <span id="lblAcctId_08" class=""></span>
                                                            </p>
                                                        </div>

                                                    </form>
                                                </div>

                                                <div class="row">
                                                    <div class="col-lg-9 col-md-9 col-sm-9 col-xs-9">
                                                        <p style="margin-bottom:0 !important;">
                                                            <span>Address:</span>
                                                            <span id="lblAddress_08" class=""></span>
                                                        </p>
                                                    </div>
                                                    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3">
                                                        <p style="margin-bottom:0 !important;">
                                                            <span id="lblEntityType_08">EIN:</span>
                                                            <span id="lblEntityId_08" class=""></span>
                                                        </p>
                                                    </div>
                                                </div>
                                                <div class="clearfix"></div>

                                            </div>  

                                            <div class="row">
                                                <div class="col-sm-4 col-xs-12 newtop_padding">
                                                    <label style="font-weight: normal;">
                                                        <input id="chkAmended_08" type="checkbox" onclick="chkAmended_08_onclick()"  />
                                                        Check if amended return.</label>
                                                </div>
                                                <div class="col-sm-8">
                                                    <label class="" style="color: Red; width: 100%">All decimals will be rounded to the nearest whole number</label></div>
                                                <div class="col-sm-3"></div>
                                            </div>
                                            <div class="row">
                                                <div class="col-lg-12 templateclass">
                                                    <!-- Return Form -->
                                                    
                                                            <div class="row table-responsive">
                                                              <div class="col-lg-12">
                                                                <table class="table table-condensed table-striped custom_table03 wage-table-print">
                                                                   
                                                                    <tbody>
                                                                        <tr>
                                                                             <td width="5%">A.</td>
                                                                            <td width="70%" class="text-left">Enter the number of Philadelphia Residents for whom wage tax was remitted for the pay period including March 12, 2014. </td>
                                                                            <td width="25%" class="text-left">
                                                                                <form class="form-horizontal">
                                                                                    <div class="form-group no-margin">
                                                                                        <div class="">
                                                                                            <input type="text" id="txtWageNoA_08" class="form-control input-sm pull-right" onchange="ValidateWage08Number()" onfocus="ReadOnlySetFocus()" maxlength="10" style="WIDTH: 100%;" />
                                                                                        </div>
                                                                                    </div>
                                                                                </form>
                                                                            </td>
                                                                        </tr>
                                                                        <tr class="odd">
                                                                              <td width="5%">B.</td>
                                                                            <td width="70%" class="text-left">Enter the number of <strong>nonresidents</strong> (employees living outside Philadelphia city limits) for whom wage tax was remitted for the pay period including March 12, 2014. </td>
                                                                            <td width="25%" class="text-left">
                                                                                <form class="form-horizontal">
                                                                                    <div class="form-group no-margin">
                                                                                        <div class="">
                                                                                            <input class="form-control input-sm pull-right" id="txtWageNoB_08" onchange="ValidateWage08Number()"
                                                                                                onfocus="ReadOnlySetFocus()" maxlength="10" style="WIDTH: 100%;">
                                                                                        </div>
                                                                                    </div>
                                                                                </form>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                             <td width="5%">C.</td>
                                                                            <td width="70%" class="text-left">Total number of employees <strong>for all company locations</strong>
                                                                                reported on the Employer's Federal Quarterly Tax Return for the first 
				quarter of 2014 (for the pay period including March 12, 2014). </td>
                                                                            <td width="25%" class="text-left">
                                                                                <form class="form-horizontal">
                                                                                    <div class="form-group no-margin">
                                                                                        <div class="">
                                                                                            <input class="form-control input-sm pull-right" id="txtWageNoC_08" onchange="ValidateWage08Number()"
                                                                                                onfocus="ReadOnlySetFocus()" maxlength="10" style="WIDTH: 100%;">
                                                                                        </div>
                                                                                    </div>
                                                                                </form>
                                                                            </td>
                                                                        </tr>
                                                                        <tr class="odd">
                                                                             <td width="5%">D.</td>
                                                                            <td width="70%" class="text-left">Number of employees working <strong>at company locations within
				Philadelphia city limits</strong>, for the pay period including March 12, 2014.</td>
                                                                            <td width="25%" class="text-left">
                                                                                <form class="form-horizontal">
                                                                                    <div class="form-group no-margin">
                                                                                        <div class="">
                                                                                            <input class="form-control input-sm pull-right" id="txtWageNoD_08" onchange="ValidateWage08Number()"
                                                                                                onfocus="ReadOnlySetFocus()" maxlength="10" style="WIDTH: 100%;">
                                                                                        </div>
                                                                                    </div>
                                                                                </form>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                             <td width="5%">1.</td>
                                                                            <td width="70%" class="text-left">Gross Compensation per W-2 forms for all employees</td>
                                                                            <td width="25%" class="text-left">
                                                                                <form class="form-horizontal">
                                                                                    <div class="form-group no-margin">
                                                                                        <div class="">
                                                                                            <input onfocus="this.select();" class="form-control input-sm pull-right" id="txtWageNo1_08" onchange="ValidateWage08Prelim()"
                                                                                                 maxlength="20" style="WIDTH: 100%;">
                                                                                        </div>
                                                                                    </div>
                                                                                </form>
                                                                            </td>
                                                                        </tr>
                                                                        <tr class="odd">
                                                                             <td width="5%">2.</td>
                                                                            <td width="70%" class="text-left">Non-Taxable Gross Compensation include in line 1
				(Paid to non-residents working outside of Philadelphia)</td>
                                                                            <td width="25%" class="text-left">
                                                                                <form class="form-horizontal">
                                                                                    <div class="form-group no-margin">
                                                                                        <div class="">
                                                                                            <input class="form-control input-sm pull-right" id="txtWageNo2_08" onchange="ValidateWage08Prelim()"
                                                                                                onfocus="ReadOnlySetFocus()" maxlength="20" style="WIDTH: 100%;">
                                                                                        </div>
                                                                                    </div>
                                                                                </form>
                                                                            </td>
                                                                        </tr>

                                                                        <tr>
                                                                             <td width="5%">3.</td>
                                                                            <td width="70%" class="text-left">Gross Compensation per W-2 forms on 
				which Philadelphia Wage Tax was withheld or due[Calculated - line 1 less line 2] </td>
                                                                            <td width="25%" class="text-left">
                                                                                <form class="form-horizontal">
                                                                                    <div class="form-group no-margin">
                                                                                        <div class="">
                                                                                            <label id="lblWageNo3_08" style="WIDTH: 100%;" class="form-control input-sm pull-right"></label>
                                                                                        </div>
                                                                                    </div>
                                                                                </form>
                                                                            </td>
                                                                        </tr>
                                                                        <tr class="odd">
                                                                             <td width="5%">4.</td>
                                                                            <td  width="70%" class="text-left">Taxable Gross Compensation paid to <u>residents</u>      of 
				Philadelphia (1/1/2014 to 06/30/2014)</td>
                                                                            <td width="25%" class="text-left">
                                                                                <form class="form-horizontal">
                                                                                    <div class="form-group no-margin">
                                                                                        <div class="">
                                                                                            <input class="form-control input-sm pull-right" id="txtWageNo4_08" onchange="ValidateWage08Prelim()"
                                                                                                onfocus="ReadOnlySetFocus()" maxlength="20" style="WIDTH: 100%;">
                                                                                        </div>
                                                                                    </div>
                                                                                </form>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                             <td width="5%">5.</td>
                                                                            <td width="70%" class="text-left">Tax Due [Calculated - line 4 X .03924] </td>
                                                                            <td width="25%" class="text-left">
                                                                                <form class="form-horizontal">
                                                                                    <div class="form-group no-margin">
                                                                                        <div class="">
                                                                                            <label id="lblWageNo5_08" style="WIDTH: 100%;" class="form-control input-sm pull-right"></label>
                                                                                        </div>
                                                                                    </div>
                                                                                </form>
                                                                            </td>
                                                                        </tr>

                                                                          <tr class="top-margin-pdf odd">
                                                                       
                                                                             <td width="5%">6.</td>
                                                                            <td width="70%" class="text-left">Taxable Gross Compensation paid to <u>residents</u>      of 
				Philadelphia (7/1/2014 to 12/31/2014)</td>
                                                                            <td width="25%" class="text-left">
                                                                                <form class="form-horizontal">
                                                                                    <div class="form-group no-margin">
                                                                                        <div class="">
                                                                                            <input class="form-control input-sm pull-right" id="txtWageNo6_08" onchange="ValidateWage08Prelim()"
                                                                                                onfocus="ReadOnlySetFocus()" maxlength="20" style="WIDTH: 100%;">
                                                                                        </div>
                                                                                    </div>
                                                                                </form>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                              <td width="5%">7.</td>
                                                                            <td width="70%" class="text-left">Tax Due[Calculated - line 6 X .03920]&nbsp;</td>
                                                                            <td width="25%" class="text-left">
                                                                                <form class="form-horizontal">
                                                                                    <div class="form-group no-margin">
                                                                                        <div class="">                                                                                           
                                                                                             <label id="lblWageNo7_08" style="WIDTH: 100%;" class="form-control input-sm pull-right"></label>
                                                                                        </div>
                                                                                    </div>
                                                                                </form>
                                                                            </td>
                                                                        </tr>
                                                                        <tr class="odd">
                                                                             <td width="5%">8.</td>
                                                                            <td width="70%" class="text-left">Taxable Gross Compensation paid to 
      <u>non-residents</u>      of 
				Philadelphia (1/1/2014 to 06/30/2014)&nbsp;</td>
                                                                            <td width="25%" class="text-left">
                                                                                <form class="form-horizontal">
                                                                                    <div class="form-group no-margin">
                                                                                        <div class="">
                                                                                            <input class="form-control input-sm pull-right" id="txtWageNo8_08" onchange="ValidateWage08Prelim()"
                                                                                                onfocus="ReadOnlySetFocus()" maxlength="20" style="WIDTH: 100%;">
                                                                                        </div>
                                                                                    </div>
                                                                                </form>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                              <td width="5%">9.</td>
                                                                            <td width="70%" class="text-left">Tax Due[Calculated - line&nbsp;8 X .03495]</td>
                                                                            <td width="25%" class="text-left">
                                                                                <form class="form-horizontal">
                                                                                    <div class="form-group no-margin">
                                                                                        <div class="">
                                                                                            <label id="lblWageNo9_08" style="WIDTH: 100%;" class="form-control input-sm pull-right"></label>
                                                                                        </div>
                                                                                    </div>
                                                                                </form>
                                                                            </td>
                                                                        </tr>
                                                                        <tr class="odd">
                                                                             <td width="5%">10.</td>
                                                                            <td width="70%" class="text-left">Taxable Gross Compensation paid to 
      <u>non-residents</u>      of 
				Philadelphia (7/1/2014 to 12/31/2014)</td>
                                                                            <td width="25%" class="text-left">
                                                                                <form class="form-horizontal">
                                                                                    <div class="form-group no-margin">
                                                                                        <div class="">
                                                                                            <input class="form-control input-sm pull-right" id="txtWageNo10_08" onchange="ValidateWage08Prelim()"
                                                                                                onfocus="ReadOnlySetFocus()" maxlength="20" style="WIDTH: 100%;">
                                                                                        </div>
                                                                                    </div>
                                                                                </form>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td width="5%">11.</td>
                                                                            <td width="70%" class="text-left">Tax Due[Calculated - line 10 X .034915]&nbsp;</td>
                                                                            <td width="25%" class="text-left">
                                                                                <form class="form-horizontal">
                                                                                    <div class="form-group no-margin">
                                                                                        <div class="">
                                                                                            <label id="lblWageNo11_08" style="WIDTH: 100%;" class="form-control input-sm pull-right"></label>
                                                                                        </div>
                                                                                    </div>
                                                                                </form>
                                                                            </td>
                                                                        </tr>
                                                                        <tr class="odd">
                                                                             <td width="5%">12.</td>
                                                                            <td width="70%" class="text-left">Total Tax Due[Calculated - lines 5, 7, 9 and 11]</td>
                                                                            <td width="25%" class="text-left">
                                                                                <form class="form-horizontal">
                                                                                    <div class="form-group no-margin">
                                                                                        <div class="">
                                                                                            <label id="lblWageNo12_08" style="WIDTH: 100%;" class="form-control input-sm pull-right"></label>
                                                                                        </div>
                                                                                    </div>
                                                                                </form>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                             <td width="5%">13.</td>
                                                                            <td width="70%" class="text-left">Tax previously paid for 2014 
                                                                                <label style="font-weight: normal; color: red; width: 100%">
                                                                                    This amount may not yet include	your most recent payment.
					
                                                                                    Click on link for more information.</label></td>
                                                                            <td width="25%" class="text-left">
                                                                                <form class="form-horizontal">
                                                                                    <div class="form-group no-margin">
                                                                                        <div class="">
                                                                                            <label id="lblWageNo13_08" style="WIDTH: 100%;" class="form-control input-sm pull-right"></label>
                                                                                        </div>
                                                                                    </div>
                                                                                </form>
                                                                            </td>
                                                                        </tr>
                                                                        <tr class="odd">
                                                                            <td width="5%">14.</td>
                                                                            <td width="70%" class="text-left">ADDITIONAL TAX DUE If line 12 is greater than line 13,
				enter the amount here.</td>
                                                                            <td width="25%" class="text-left">
                                                                                <form class="form-horizontal">
                                                                                    <div class="form-group no-margin">
                                                                                        <div class="">
                                                                                            <label id="lblWageNo14_08" style="WIDTH: 100%;" class="form-control input-sm pull-right"></label>
                                                                                        </div>
                                                                                    </div>
                                                                                </form>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                             <td width="5%">15.</td>
                                                                            <td width="70%" class="text-left">TAX OVERPAID If line 12 is less than line 13,
				enter the amount here. See instructions for filing a Refund Petition.</td>
                                                                            <td width="25%" class="text-left">
                                                                                <form class="form-horizontal">
                                                                                    <div class="form-group no-margin">
                                                                                        <div class="">
                                                                                            <label id="lblWageNo15_08" style="WIDTH: 100%;" class="form-control input-sm pull-right"></label>
                                                                                        </div>
                                                                                    </div>
                                                                                </form>
                                                                            </td>
                                                                        </tr>

                                                                    </tbody>
                                                                   
                                                                </table>
                                                                </div>
                                                            </div>
                                                         </div>
                                                    <!-- Form End-->
                                                    <!-- Preperar Section Form -->
                                                  <div class="col-lg-12" style="margin-top:-10px !important;">
                                                    <form class="form-horizontal form-year-background" style="padding:5px !important;">
                                                        <div>
                                                            <%
                                                                Html.RenderAction("PreparerSection", "INC");   
                                                            %>
                                                        </div>
                                                           <div class="form-group page-print-wage-section">
                                                  <div class="col-sm-offset-3 col-sm-9  text-right">
                                                      <input id="btnWage08Print" type="button" value="Print" style="margin-top:3px !important;" class="btn btn-default submit_button_light" onclick="btnWage08Print_onclick()" />
                                               <input type="button" value="Submit" class="btn btn-default submit_button" id="btnWage08Submit" style="margin-top:3px !important;" onclick="btnWageValidate(); ispDisplayProgress('btnWage08Submit_onclick()', 'Submitting 2014 wage tax information')" />                  
                                               
                                                </div>
                                              </div>      
                                                     
                                                     <div style="margin-left: 5px; font-size: 14px;" class="wage-filer-print">
                                                        <label style="font-size: 11px !important; font-weight:normal !important;">
                                                            Note: DO NOT FILE THIS RETURN if you have no taxable activity. If you registered for 
				this tax and you no longer have taxable activity, complete a 
				<a href="https://beta.phila.gov/media/20170207132309/Change-Form.pdf" target="_blank">Change Form</a> to cancel
				your account.</label>
                                                        </div>
                                                    </form>
                                                   </div>
                                                    <!-- Preperar Section Form END -->                                               
                                            </div>
                                        </div>
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

 
</body>
</html>

