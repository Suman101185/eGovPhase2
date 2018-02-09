<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
    <title></title>
    <script src="../../Content/Scripts/JqueryMin.js" type="text/javascript"></script>
    <!-- Bootstrap Core CSS -->
    <link href="../../Content/Styles/bootstrap.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="../../Content/Styles/copegov.css" rel="stylesheet">
    <link href="../../Content/Styles/style.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../../Content/Styles/jPushMenu.css">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via fil// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
     <style type="text/css">
        .disable-link {
            color:#cfcfcf;
        }
    </style>
    <script id="bptIF" language="javascript" type="text/javascript">
        //EGOVWEB-60 Changed lblBPT1_10a to txtBPT1_10a (8 places)
        var mbFirstTime = false;
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

        });

        var b_txtBPT1_4 = false;
        var arrPage1Err = new Array();
        var sAppError = '';
        var b3800val = false;
        var scheduleC1_AB = '';
        //
        var sIncomeMethod = '';
        var Sch;
        //
        var xSecErr = 'ERROR_INFO ';
        var xFldErrProgram = xSecErr + ' PROGRAM';
        var xFldErrError = xSecErr + ' ERROR';
        var xFldErrLine = xSecErr + ' LINE';
        var xFldErrMessage = xSecErr + ' MESSAGE';

        var xSecInfo = 'BPT_INFO ';
        var xFldInfAcctID = xSecInfo + ' ACCOUNT_ID';
        var xFldInfPeriod = xSecInfo + ' PERIOD';
        var xFldInfVer = xSecInfo + ' VERSION';
        var xFldInfRetStat = xSecInfo + ' RETURN_STATUS';
        var xFldInfLastUpdDate = xSecInfo + ' LAST_UPD_DATE';
        var xFldInfRecDate = xSecInfo + ' RECORDING_DATE';
        var xFldInfExtDate = xSecInfo + ' EXTENSION_DATE';
        var xFldInfSeq = xSecInfo + ' SEQUENCE';
        var xFldInfAdjRef = xSecInfo + ' ADJUSTMENT_REF_NO';
        var xFldInfUserId = xSecInfo + ' USER_ID';
        var xFldInfABtaxRate = xSecInfo + ' SCH_AB_TAX_RATE';
        var xFldInfDtaxRate = xSecInfo + ' SCH_D_TAX_RATE';
        var xFldInfEmanTaxRate = xSecInfo + ' SCH_E_M_TAX_RATE';
        var xFldInfEwhoTaxRate = xSecInfo + ' SCH_E_W_TAX_RATE';
        var xFldInfEretTaxRate = xSecInfo + ' SCH_E_R_TAX_RATE';
        var xFldInfLossCarry = xSecInfo + ' LOSS_CARRY_FOWARD';

        var xSecPg1 = 'BPT_PG1 ';
        var xFldPg1Li1 = xSecPg1 + 'NET_INCOME';
        var xFldPg1Li2 = xSecPg1 + 'GROSS_RECEIPTS';
        var xFldPg1Li3 = xSecPg1 + 'TAX_DUE';
        var xFldPg1Li4 = xSecPg1 + 'ESTIMATED_TAX';
        var xFldPg1Li5 = xSecPg1 + 'TOTAL_TAX';
        var xFldPg1Li6 = xSecPg1 + 'NPT_TAX_CREDIT';
        var xFldPg1Li7 = xSecPg1 + 'BPT_TAX_CREDIT';
        var xFldPg1Li8 = xSecPg1 + 'TOTAL_PAY_CREDITS';
        var xFldPg1Li9 = xSecPg1 + 'NET_TAX';
        var xFldPg1Li10 = xSecPg1 + 'INTEREST_PENALTY';
        var xFldPg1Li11 = xSecPg1 + 'AMOUNT_OWED';
        var xFldPg1Li12 = xSecPg1 + 'REFUND';
        var xFldPg1Li13 = xSecPg1 + 'NPT_OVERPAY';
        var xFldPg1Li14 = xSecPg1 + 'BPT_OVERPAY';

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
                } //if
                newName = fName + " " + mName + " " + lName;
                return newName;
            } else {
                return sEntityName;
            } //if
        } //AdjustNameDisplay

        function DisplayBPTlfReturn() {

            if ($(parent.$g.xmlAccount.xml).find('TAX_ACCT[ACCOUNT = "24"]').eq(0)) {

               

                parent.$g.xmlBPTlf_2015.loadXML(parent.$g.xmlBPTlfTemplate_2015.xml);

                $(BPT_Pg1).css('display', 'block');
                //--I frame height issue resolved
                var iframe = window.parent.document.getElementById('ifrmDocwin');
                var container = $('#tab1').css("height");
                iframe.style.height = container;
                //--------------------------------------------
                //FieldLock(true);
                $('#AppHeader').html('Business Income & Receipts Tax for ' + '<Font>' + (sCurrYear - 1) + '</Font>');

                parent.gsInstructionItem = '#BIR';
                
                $('#AppMessage').html('The Business Privilege Tax for ' + (sCurrYear - 1) + ' is due April 18, ' + sCurrYear + '.');
                $('#InstructionText').html(' ');



                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 'INQ', xFldInfRetStat, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ACCOUNT_ID', '', 0), xFldInfAcctID, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, '12/31/' + (sCurrYear - 1), xFldInfPeriod, '', 0);
                var ReqXML = parent.$g.xmlBPTlf_2015;               
               
                debugger;
                // calling ajax to  write log 
                $.ajax({
                    type: 'POST',
                    url: '../../Returns/Log',
                    data: '{ "OriginationFom" : "BPTLF-2017","ServiceName" : "RTTIE030","RequestXML" : "' +btoa(ReqXML.toString()) + '"}',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    success: function (msg) {
                        
                    }
                });
                





                setTimeout(function () { }, 3000);

                ispCallXMLForm(parent.$g.xmlBPTlf_2015, parent.$g.xmlBPTlf_2015, "BPT_LF/BPTlfReturn_2015", "");

                var ResXML = parent.$g.xmlBPTlf_2015;

                $.ajax({
                    type: 'POST',
                    url: '../../Returns/Log',
                    data: '{ "OriginationFom" : "BPTLF-2017","ServiceName" : "RTTIE030","ResponseXML" : "' + btoa(ResXML.toString()) + '"}',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    success: function (msg) {

                    }
                });

                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldErrError, '', 0) != 0) {
                    $(parent.RightFrame).attr('rows', '*,0');
                    $(BPT_Pg1).css('display', 'block');
                    //--I frame height issue resolved
                    var iframe = window.parent.document.getElementById('ifrmDocwin');
                    var container = $('#tab1').css("height");
                    iframe.style.height = container;
                    //--------------------------------------------
                    FieldLock(true);
                    $('#AppError').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldErrMessage, "", 0));
                    $('#btnBPTSubmit').attr('disabled', true);
                    $('#chkAmended_08').attr('disabled', true);
                    return;
                }
               
                //if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldInfRetStat, '', 0) == 'EZ') {
                //    parent.setFrameUrl('Returns/BPTez?y=' + 2016);
                //}
                if ($(parent.divAcctInfo).css("display") == 'none') {
                    $(parent.divAcctInfo).css("display", "block");
                    $(parent.divAccount).css("display", "none");
                } //if

                $(parent.RightFrame).attr('rows', '*,0');
               
                LoadError();
                CheckBPTXML();
                SetBPTFields();
                PopulateBPTHeader();
                //ResetBPTlfSchdB();
                PopulateBPTData();
                RightAlignText();
                ValidateWorksheet('BPT_Pg1');
                $('#AppError').text('');
            } else {
                parent.$g.xmlBPTlf_2015.loadXML(parent.$g.xmlBPTlfTemplate_2015.xml);
                parent.ispMenu_onclick(parent.mnuAcctInfo);
            }
            // loadpage();
            //***********************eleminate 0 from prep area
            var txtPrepAreaCode = document.getElementById("txtPrepAreaCode");
            if (txtPrepAreaCode.value == 0) {
                txtPrepAreaCode.value = "";
            }
        } //DisplayBPTlfReturn
         
        function CheckBPTXML() {
            var bPeriodExist = true;
            var firstOfYear = '01/01/' + (sCurrYear - 1);
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldInfPeriod, '', 0) != '' && new Date(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldInfPeriod, '', 0)) < new Date(firstOfYear)) {
                bPeriodExist = false;
            }
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldInfPeriod, '', 0) == '') {
                bPeriodExist = false;
            }
            if (bPeriodExist == false) {
                //error_info
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, '', xFldErrProgram, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, '', xFldErrError, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, '', xFldErrLine, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, '', xFldErrMessage, '', 0);
                //BPT_info	
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, '12/31/' + (sCurrYear - 1), xFldInfPeriod, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, '', xFldInfVer, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, '', xFldInfRetStat, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, '', xFldInfLastUpdDate, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, '', xFldInfRecDate, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, '', xFldInfExtDate, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, '', xFldInfSeq, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, '', xFldInfAdjRef, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, '', xFldInfUserId, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, '', xFldInfABtaxRate, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, '', xFldInfDtaxRate, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, '', xFldInfEmanTaxRate, '', 0);;
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, '', xFldInfEwhoTaxRate, '', 0)
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, '', xFldInfEretTaxRate, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, '', xFldInfLossCarry, '', 0);
                //BPT_pg1
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldPg1Li1, '', 0)
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldPg1Li2, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldPg1Li3, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldPg1Li4, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldPg1Li5, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldPg1Li6, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldPg1Li7, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldPg1Li8, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldPg1Li9, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldPg1Li10, '', 0)
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldPg1Li11, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldPg1Li12, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldPg1Li13, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldPg1Li14, '', 0);

                //BPT_schdA
                ClearBPTlfSchdA();
                //BPT_schdB
                ClearBPTlfSchdB();
                //BPT_schdC1
                ClearBPTlfSchdC1();  //tanu
                //BPT_SchdD
                ClearBPTlfSchdD();
                //BPT_SchdE
                ClearBPTlfSchdE();
                // worksheets
                ClearBPTlfWorkSheetS();
                //
                ClearPreparerXML(parent.$g.xmlBPTlf_2015, xSecInfo);
            } //if
        } //CheckBPTXML

        function SetBPTFields() {

            var chkAmended = document.getElementById('chkAmended_08');
            var chkAgreement = document.getElementById('chkAgreement');
            var chkTaxpayer = document.getElementById('chkTaxpayer');
            chkAgreement.checked = false;
            chkAmended.checked = false;

            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldInfVer, '', 0) == '') {
                FieldLock(false);
                $('#chkAmended_08').attr('disabled', true);
                chkTaxpayer.checked = false;
                //
                //$('#btnBPTPrint').attr("disabled", true);
            }
            else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldInfVer, '', 0) != '' && parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, 'BPT_INFO PREPARER_NAME', '', 0) == '') {

                FieldLock(false);
                $('#chkAmended_08').attr('disabled', true);
                chkTaxpayer.checked = false;
            }
            else {
                //Sanghamitra:
                //in old system the dll used to return string value but  in new system service returns double in the field NI_loss thus we need to call PrepForMath() and then compare the value with 0 instead of '' 
                if (PrepForMath(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScALi1, '', 0)) != 0) {

                    $('#lblLnkSchdB').removeAttr('onclick');
                    $('#lblLnkSchdB').css('cursor', 'default');
                    $('#lblLnkSchdB').attr("disabled", true);
                    $('#lblLnkSchdB').attr('class', 'disable-link');
                } else {

                    if (PrepForMath(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi1, '', 0)) != 0) {
                        $('#lblLnkSchdA').removeAttr('onclick');
                        $('#lblLnkSchdA').css('cursor', 'default');
                        $('#lblLnkSchdA').attr("disabled", true);
                        $('#lblLnkSchdA').attr('class', 'disable-link');
                    }
                }
                $('#chkAmended_08').removeAttr("disabled");
                FieldLock(true);
                chkAgreement.checked = true;
                //
                //$('#btnBPTPrint').removeAttr("disabled");
            }
        } //SetBPTFields

        function PopulateBPTHeader() {
            var addrIdx;
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ENTITY_ID', '', 0) != '') {
                $('#lblAccountId').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ACCOUNT_ID', '', 0));
                $('#lblEntityId').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ENTITY_ID', '', 0));
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO TYPE', '', 0) == 1) {
                    $('#lblEntityType').text('EIN:');
                    $('#lblEntityId').text(' ' + $('#lblEntityId').text().substr(0, 2) + '-' + $('#lblEntityId').text().substr(2));
                } else {
                    $('#lblEntityType').text('SSN:');
                    $('#lblEntityId').text(' ' + $('#lblEntityId').text().substr(0, 3) + '-' + $('#lblEntityId').text().substr(3, 2) + '-' + $('#lblEntityId').text().substr(5));
                } //if
                $('#lblName').text(AdjustNameDisplay(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS NAME', '', addrIdx)));
                addrIdx = LocatePrimaryAddr();
                $('#lblAddress').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS1', '', addrIdx) + ' ' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS CITY', '', addrIdx) + ' ' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS STATE', '', addrIdx) + ' ' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ZIP', '', addrIdx));
            } //if
        } //PopulateBPTHeader
        function RightAlignText() {
            $('#txtBPT1_4').css('text-align', 'right');
            $('#txtBPT1_6a').css('text-align', 'right');
            $('#txtBPT1_6b').css('text-align', 'right');
            $('#txtBPT1_8').css('text-align', 'right');
            $('#txtBPT1_10a').css('text-align', 'right');
            $('#txtBPT1_10b').css('text-align', 'right');
            $('#txtBPT1_10c').css('text-align', 'right');//Added           

            $('#lblBPT1_1').parent().css("text-align", "right");
            $('#lblBPT1_2').parent().css("text-align", "right");
            $('#lblBPT1_3').parent().css("text-align", "right");
            $('#lblBPT1_5').parent().css("text-align", "right");
            $('#lblBPT1_6c').parent().css("text-align", "right");
            $('#lblBPT1_7').parent().css("text-align", "right");
            $('#lblBPT1_9').parent().css("text-align", "right");
        }

        function PopulateBPTData() {
            dBPTNetRate = parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldInfABtaxRate, '', 0);
            dBPTGrossRate = parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldInfDtaxRate, '', 0);
            dBPTManufacturerRate = parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldInfEmanTaxRate, '', 0);
            dBPTWholesaleRate = parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldInfEwhoTaxRate, '', 0);
            dBPTRetailerRate = parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldInfEretTaxRate, '', 0);
            
            //BPT_Pg1
            $('#txtTermDate').val('');
            $('#lblBPT1_1').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldPg1Li1, '', 0), 0));
            $('#lblBPT1_2').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldPg1Li2, '', 0), 0));
            $('#lblBPT1_3').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldPg1Li3, '', 0), 0));

            $('#txtBPT1_4').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldPg1Li4, '', 0), 0));
            $('#lblBPT1_5').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldPg1Li5, '', 0), 0));
            $('#txtBPT1_6a').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldPg1Li6, '', 0), 0));
            $('#txtBPT1_6b').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldPg1Li7, '', 0), 0));
            $('#lblBPT1_6c').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldPg1Li8, '', 0), 0));
            //EGOVWEB-60 Changed xFldPg1Li8 to xFldPg1Li9
            $('#lblBPT1_7').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldPg1Li9, '', 0), 0));
            $('#txtBPT1_8').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldPg1Li10, '', 0), 0));
            $('#lblBPT1_9').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldPg1Li11, '', 0), 0));
            $('#txtBPT1_10a').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldPg1Li12, '', 0), 0));
            $('#txtBPT1_10b').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldPg1Li13, '', 0), 0));
            $('#txtBPT1_10c').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldPg1Li14, '', 0), 0));

            //BPT_SchdA
            PopulateBPTlfSchdA();
            //BPT_SchdB
            PopulateBPTlfSchdB();
            //BPT_SchdC1
            PopulateBPTlfSchdC1();//tanu
            //BPT_SchdD
            PopulateBPTlfSchdD();
            //BPT_SchdE
           // debugger;
            PopulateBPTlfSchdE();
            //WorkSheetS
            PopulateBPTlfWorkSheetS();
            PopulatePreparer(parent.$g.xmlBPTlf_2015, xSecInfo);

        } //PopulateBPTData

        function FieldLock(bDisabled) {
            $('#txtTermDate').attr('disabled', bDisabled);
            $('#lblBPT1_1').attr('disabled', bDisabled);
            $('#lblBPT1_2').attr('disabled', bDisabled);
            $('#lblBPT1_3').attr('disabled', bDisabled);
            $('#txtBPT1_4').attr('disabled', bDisabled);
            $('#lblBPT1_5').attr('disabled', bDisabled);
            $('#txtBPT1_6a').attr('disabled', bDisabled);
            $('#txtBPT1_6b').attr('disabled', bDisabled);
            $('#lblBPT1_6c').attr('disabled', bDisabled);
            $('#lblBPT1_7').attr('disabled', bDisabled);
            $('#txtBPT1_8').attr('disabled', bDisabled);
            $('#lblBPT1_9').attr('disabled', bDisabled);
            $('#txtBPT1_10a').attr('disabled', bDisabled);
            $('#txtBPT1_10b').attr('disabled', bDisabled);
            $('#txtBPT1_10c').attr('disabled', bDisabled);
            $('#btnBPTSubmit').attr('disabled', bDisabled);

            FieldLockBPTlfSchdA(bDisabled);
            FieldLockBPTlfSchdB(bDisabled);
            FieldLockBPTlfSchdC1(bDisabled); // tanu
            FieldLockBPTlfSchdD(bDisabled);
            FieldLockBPTlfSchdE(bDisabled);
            FieldLockBPTlfWrkS(bDisabled);
            DisablePreparer(bDisabled);
            //EGOVWEB-65
            if (bDisabled == true) {
                $('#txtBPT1_4').attr('class', 'form-control input-sm pull-right');
                $('#txtBPT1_6a').attr('class', 'form-control input-sm pull-right');
                $('#txtBPT1_6b').attr('class', 'form-control input-sm pull-right');                
                $('#txtBPT1_10b').attr('class', 'form-control input-sm pull-right');
                $('#txtBPT1_10c').attr('class', 'form-control input-sm pull-right');
                $('#txtTermDate').attr('class', 'form-control input-sm pull-right');
            }
        } //FieldLock

        function SetFocus() {
            $(getActiveElement()).select();
        } //SetFocus

        function btnBPTPrint_onclick() {

            var objCurrDisplayed;

            $('#btnBPTPrint').css('visibility', 'hidden');
            $('#btnBPTSubmit').css('visibility', 'hidden');
           
            if ($('#BPT_Pg1').css('display') == 'block') {
                objCurrDisplayed = 'BPT_Pg1';
                $('#BPT_SchdA').css('display', "block");
               
                $('#BPT_SchdB').css('display', "block");
                $('#BPT_SchdC1').css('display', "block");
                $('#BPT_SchdD').css('display', "block");
                $('#BPT_SchdE').css('display', "block");
                $('#lblBPT_SchE_A').text($('#txtBPT_SchD_8').val());
                
            }		//if
            $('#AppError').text('');
            window.print();
            $('#btnBPTPrint').css('visibility', 'visible');
           $('#btnBPTSubmit').css('visibility', 'visible');

            if (objCurrDisplayed == 'BPT_Pg1') {
               $('#BPT_SchdA').css('display', "none");
               $('#BPT_SchdB').css('display', "none");
                $('#BPT_SchdC1').css('display', "none");
                $('#BPT_SchdD').css('display', "none");
                $('#BPT_SchdE').css('display', "none");
                $('#BPT_WrkShtN').css('display', 'none');
           }		//if


            
        } //btnBPTPrint_onclick

        function btnBPTSubmit_onclick() {
            var tempXML = parent.$g.getXmlDocObj();
            $('#AppError').text('');

           
            if ($("#AppError").text() == '') {
                $("#AppError").text(ValidatePreparer());
                if ($("#AppError").text() != '') {
                    resolvedIframeheight();
                    parent.ScrollTop(ValidatePreparer());
                    return;
                }
            }

            //EGOVWEB-73 Moved outside the error If statement
            txtTermDate_onblur();
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, '', xFldInfRetStat, '', 0);
          
            PopulateXmlBPTlf();
           
            if ($('#AppError').text() == '') {


                var ReqXML = parent.$g.xmlBPTlf_2015;

                $.ajax({
                    type: 'POST',
                    url: '../../Returns/Log',
                    data: '{ "OriginationFom" : "BPTLF-2017","ServiceName" : "RTTIE030","RequestXML" : "' + btoa(ReqXML.toString()) + '"}',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    success: function (msg) {

                    }
                });
                setTimeout(function () { }, 3000);
                ispCallXMLForm(parent.$g.xmlBPTlf_2015, tempXML, "BPT_LF/BPTlfReturn_2015", "");
                
                //return false;
                if (parent.$x.ispXmlGetFieldVal(tempXML, xFldErrProgram, '', 0) == '') {

                    parent.$g.xmlBPTlf_2015.loadXML(tempXML.xml);
                    var ResXML = tempXML;
                    $.ajax({
                        type: 'POST',
                        url: '../../Returns/Log',
                        data: '{ "OriginationFom" : "BPTLF-2017","ServiceName" : "RTTIE030","ResponseXML" : "' + btoa(ResXML.toString()) + '"}',
                        contentType: 'application/json; charset=utf-8',
                        dataType: 'json',
                        success: function (msg) {

                        }
                    });
                    $('#BIRTReturn').css('display', 'none');
                    DisplayBPTlfThankYou();
                } else {
                    parent.$g.xmlBPTlf_2015.loadXML(tempXML.xml);
                    $('#AppError').text(parent.$x.ispXmlGetFieldVal(tempXML, xFldErrMessage, '', 0));
                }
            }
        }

        function DisplayBPTlfThankYou() {
            $('#AppConfirmNoMessage').text("");
            $(frmePay.imgCards).attr("src", "../../Content/Images/ePay.gif");
         
            $('#BPT_Pg1').css('display', "none");
            $('#BPT_SchdA').css('display', "none");
            $('#BPT_SchdB').css('display', "none");
            $('#BPT_SchdC1').css('display', "none");
            $('#BPT_SchdD').css('display', "none");
            $('#BPT_SchdE').css('display', "none");
            var btnBPTThankYou = document.getElementById('btnBPTThankYou');
            if (mbFirstTime == true) {
                btnBPTThankYou.value = 'File Net Profit Tax';
            }
            else {
                btnBPTThankYou.value = 'Update Net Profit Tax';
            }

            $('#lblThankYouName').text($('#lblName').text());
            $('#lblAcctNo').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, 'BPT_INFO ACCOUNT_ID', '', 0));
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldInfAdjRef, '', 0) != '') {
                $('#lblConfirmNo').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldInfAdjRef, '', 0));
            } else {
                debugger;
                $('#lblConfirmNo').text("");
                $('#AppConfirmNoMessage').text("Submissions could not be processed. Please contact System Administrator");
                
                $.ajax({
                    type: 'POST',
                    url: '../../Returns/Log',
                    data: '{ "OriginationFom" : "BPTLF-2017","ServiceName" : "RTTIE030"}',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    success: function (msg) {

                    }
                });
             
            } //if Adjustment reference number
            $('#divBPTlfThankYou').css('display', 'block');
            // resolved thanku page iframe height issue: manoranjan
            var iframe = window.parent.document.getElementById('ifrmDocwin');
            var container = $('#divBPTlfThankYou').css("height");
            iframe.style.height = container;
            //-----------------------------------
            return

        } //DisplayThankyou
        function resolvedIframeheight() {
            //iframe height issue resolved
            var iframe = window.parent.document.getElementById('ifrmDocwin');
            var container = $('#tab1').css("height");
            iframe.style.height = container;
        }
        function txtTermDate_onblur() {
            //EGOVWEB-65

            $('#AppError').text('');
            if ($('#AppError').text() == "" && $('#txtTermDate').val() != "") {
                var strBD = ispValidateDate($('#txtTermDate').val());

                if (strBD == false) {
                    $('#AppError').text('Invalid termination date');
                    $('#txtTermDate').attr("class", "inpError form-control input-sm pull-right");
                    blnErr = true;
                    $('#txtTermDate').focus();
                    resolvedIframeheight();
                    parent.ScrollTop(1);
                } else {
                    $('#txtTermDate').attr('class', 'form-control input-sm pull-right');
                    $('#txtTermDate').val(strBD);
                    $('#txtBPT1_4').attr('class', 'form-control input-sm pull-right');
                    $('#txtBPT1_4').val(ispFormatMoney(0, 0));
                    $('#txtBPT1_4').attr('disabled', true);
                    $('#txtBPT1_6a').focus();
                    PerformCalcsBPTlfPg1();
                    resolvedIframeheight();
                    parent.ScrollTop(1);
                } //if
            } else {

                $('#txtTermDate').attr('class', 'form-control input-sm pull-right');
                //EGOVWEB-65
                $('#txtBPT1_4').removeAttr('disabled');
                //EGOVWEB-73 - Estimate payment not being set to mainframe (reseting estimate payment to what is in the XML)
                //		txtBPT1_4.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldPg1Li4, '', 0), 0)
                if ($('#BPT_Pg1').css("display") == 'block') {
                    $('#txtBPT1_4').focus();
                }
                PerformCalcsBPTlfPg1();
                resolvedIframeheight();
                parent.ScrollTop(1);
            } //if
        } //txtToDate_onblur

        function chkAmended_08_onclick() {
            if ($('#chkAmended_08').is(':checked')) {

               
                $('#btnNo').removeAttr('checked');
                $('#btnYes').removeAttr('checked');
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldInfRetStat, '', 0) == 'A1' || parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldInfRetStat, '', 0) == 'A2') {
                    $('#BPT_19_3800').css('display', 'block');
                    $('#BPT_19_3800').css('visibility', 'visible');
                    $('#BPT_Pg1').css('display', 'none');
                } else {
                    $('#BPT_Pg1').css("display", "block");
                    $('#btnBPTSubmit').removeAttr("disabled");
                    FieldLock(false);
                    $('#txtBPT1_4').focus();
                } //if
                FieldLock(false);
                ClearPreparer();
            } else {
                $('#BPT_Pg1').css('display', 'block');
                PopulateBPTData();
                $('#btnBPTSubmit').attr('disabled', true);
                chkAgreement.checked = true;
                FieldLock(true);
                PopulatePreparer(parent.$g.xmlBPTlf_2015, xSecInfo);
                $('#AppError').text('');
            } //if
        } //chkAmended_onclick

        function ShowPage(iSch) {

            $('#BPT_Pg1').css('display', 'none');
            
            $('#BPT_SchdA').css('display', 'none');
            $('#BPT_SchdB').css('display', 'none');
            $('#BPT_SchdC1').css('display', 'none');
            $('#BPT_SchdD').css('display', 'none');
            $('#BPT_SchdE').css('display', 'none');
            $('#BPT_WrkShtN').css('display', 'none');
            $('#BPT_WorkSheetS').css('display', 'none');
            $('#lblLnkSchdN1').text('');
            $('#lblLnkSchdN2').text('');
            $('#BPT_19_3800').css('display', 'none');

            sPrevWrkSht = sCurrWrkSht;
            $('#AppError').text('');
            var FocusItem;
            switch (iSch) {
                case "Pg1":

                    sCurrWrkSht = 'PG1';
                    $('#BPT_Pg1').css('display', 'block');
                    if (sPrevWrkSht == 'SCHDA') {

                        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldInfRetStat, '', 0) == 'A1' || parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldInfRetStat, '', 0) == 'A2')
                        {
                            if ($('#btnYes').is(':checked'))
                            {
                                
                                $('#lblBPT1_1').text(ispFormatMoney(0, 0));
                            } else
                            {
                                $('#lblBPT1_1').text($('#lblBPT_SchA_12').text());
                            } //if
                        } else
                        {
                            $('#lblBPT1_1').text($('#lblBPT_SchA_12').text());
                        }
                    } else if (sPrevWrkSht == 'SCHDB') {

                        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldInfRetStat, '', 0) == 'A1' || parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldInfRetStat, '', 0) == 'A2') {
                            if ($('#btnYes').is(':checked')) {
                                
                                $('#lblBPT1_1').text(ispFormatMoney(0, 0));
                            } else {
                                $('#lblBPT1_1').text($('#lblBPT_SchB_13').text());
                            } //if
                        } else {
                            $('#lblBPT1_1').text($('#lblBPT_SchB_13').text());
                        }
                    } else if (sPrevWrkSht == 'SCHDD') {
                        //
                        if ($('#btnYes').is(':checked') == true) {
                            $('#lblBPT1_2').text(ispFormatMoney($('#lblBPT1_2').text(), 0));
                        } else {
                           
                            $('#lblBPT1_2').text($('#lblBPT_SchD_12').text());
                        } //if
                    } else if (sPrevWrkSht == 'WRKSHTN') {
                        $('#lblBPT1_1').text(ispFormatMoney($('#lblWrkShtN_2').text(), 0));
                        $('#lblBPT1_2').text(ispFormatMoney($('#lblWrkShtN_4').text(), 0));
                    } //if
                    if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldInfRetStat, '', 0) == 'A1' || parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldInfRetStat, '', 0) == 'A2') {
                        //SUMAN : AS PER REQUIREMENT DICUSSED ON 24TH JAN 2014, CLIENT DONT WANT SCHEDULE N LINK IF USER CHOSE YES OPTION
                        if ($("#btnYes").is(":checked") == false) {
                            $('#lblLnkSchdN1').html('<label class="lblInstrNormal"> or </label>' + '<label class="lblLink" style="FONT-SIZE: 7pt" onclick=ShowPage("WrkShtN")> Worksheet N, Line 2</label>');
                            $('#lblLnkSchdN2').html('<label class="lblInstrNormal"> or </label>' + '<label class="lblLink" style="FONT-SIZE: 7pt" onclick=ShowPage("WrkShtN")> Worksheet N, Line 4</label>');
                        }

                    } //if
                    // I-frame scroll issue resolved                  
                    var iframe = window.parent.document.getElementById('ifrmDocwin');
                    var container = $('#tab1').css("height");
                    iframe.style.height = container; 
                    //----------------------------------------
                    FocusItem = $('#txtBPT1_4');
                   
                    PerformCalcs();
                 
                    break;
                case "SchdA":
                   
                    if (PrepForMath($('#txtBPT_SchB_1').val()) != 0) {
                        alert('You have already filled out Schedule B. \n' + 'Click on the \'Return to Page 1\' button to preserve the Schedule B values. \n' + 'Once you enter a value on Schedule A, Schedule B will be cleared.');
                    } //if
                    sIncomeMethod = 'SCHDA';
                    //
                    sCurrWrkSht = 'SCHDA';
                    if (sPrevWrkSht == 'WRKSHTN') {
                        $('#btnAGoTo').val('Return to Worksheet N');
                        $('#btnAGoTo').click(Function('ShowPage("WrkShtN");'));
                    } else {
                        $('#btnAGoTo').val('Return to Page 1');
                        $('#btnAGoTo').click(Function('ShowPage("Pg1");'));
                    } //if
                    $('#BPT_SchdA').css('display', 'block');

                    // I-frame scroll issue resolved                  
                    var iframe = window.parent.document.getElementById('ifrmDocwin');
                    var container = $('#tab1').css("height");
                    iframe.style.height = container;
                    //----------------------------------------
                    FocusItem = $('#txtBPT_SchA_1');
                   
                    PerformCalcs();
                    RightAlignText_A();
                    //----------------                   
                    break;
                case "SchdB":

                    if (PrepForMath($('#txtBPT_SchA_1').val()) != 0) {
                        alert('You have already filled out Schedule A. \n' + 'Click on the \'Return to Page 1\' button to preserve the Schedule A values. \n' + 'Once you enter a value on Schedule B, Schedule A will be cleared.');
                    } //if
                    //
                    sIncomeMethod = 'SCHDB';
                    //
                    sCurrWrkSht = 'SCHDB';
                    if (sPrevWrkSht == 'WRKSHTN') {
                        $('#btnBGoTo').val('Return to Worksheet N');
                        $('#btnBGoTo').click(Function('ShowPage("WrkShtN");'));
                    } else {
                        $('#btnBGoTo').val('Return to Page 1');
                        $('#btnBGoTo').click(Function('ShowPage("Pg1");'));
                    } //if
                    $('#BPT_SchdB').css('display', 'block');
                                     
                    var iframe = window.parent.document.getElementById('ifrmDocwin');
                    var container = $('#tab1').css("height");
                    iframe.style.height = container;
                    //----------------------------------------
                    FocusItem = $('#txtBPT_SchB_1');
                    //////////// PerformCalcsBPTlfSchdB()
                    PerformCalcs();
                    RightAlignText_B();
                    break;
                case "SchdC1":
                    sCurrWrkSht = 'SCHDC1';
                    
                    $('#BPT_SchdC1').css('display', 'block');
                    // I-frame scroll issue resolved                  
                    var iframe = window.parent.document.getElementById('ifrmDocwin');
                    var container = $('#tab1').css("height");
                    iframe.style.height = container;
                    //----------------------------------------
                    if (sPrevWrkSht == 'SCHDA') {
                        $('#btnC1GoTo').val('Return to Schedule A');
                        //
                        $('#btnBGoTo').val('Return to Schedule A');
                        $('#btnBGoTo').click(Function('ShowPage("SchdA");'));
                        scheduleC1_AB = 'SCHDA'
                        
                    } else {
                        $('#btnC1GoTo').val('Return to Schedule B');

                        $('#btnBGoTo').val('Return to Schedule B');
                        $('#btnBGoTo').click(Function('ShowPage("SchdB");'));
                       
                        scheduleC1_AB = 'SCHDB'
                    } //if
                    FocusItem = $('#txtBPT_SchC1_1A');
                    
                    PerformCalcs();
                    RightAlignText_C1();
                    //----------------
                    break;
                case "SchdD":
                    sCurrWrkSht = 'SCHDD';
                    if (sPrevWrkSht == 'WRKSHTN') {
                        $('#btnDGoTo').val('Return to Worksheet N');
                        $('#btnDGoTo').click(Function('ShowPage("WrkShtN");'));
                    } else {
                        $('#btnDGoTo').val('Return to Page 1');
                        $('#btnDGoTo').click(Function('ShowPage("Pg1");'))
                    } //if
                    $('#BPT_SchdD').css('display', 'block');
                    
                    // I-frame scroll issue resolved                  
                    var iframe = window.parent.document.getElementById('ifrmDocwin');
                    var container = $('#tab1').css("height");
                    iframe.style.height = container;
                    //----------------------------------------
                   
                    $('#lblBPT_SchD_11').text($('#lblBPT_SchE_15').text());
                    FocusItem = $('#txtBPT_SchD_1');
                    PerformCalcs();
                    
                    RightAlignText_D();
                    break;
                case "SchdE":
                    sCurrWrkSht = 'SCHDE';
                    $('#BPT_SchdE').css('display', 'block');

                   

                                  
                    var iframe = window.parent.document.getElementById('ifrmDocwin');
                    var container = $('#tab1').css("height");
                    iframe.style.height = container;
                    //----------------------------------------
                    FocusItem = $('#lblBPT_SchE_1');
                   
                    PerformCalcs();
                    RightAlignText_E();
                    break;
                case "WrkShtN":
                    sCurrWrkSht = 'WRKSHTN'
                    DisplayWrkShtN()
                    //

                    // I-frame scroll issue resolved                  
                    var iframe = window.parent.document.getElementById('ifrmDocwin');
                    var container = $('#tab1').css("height");
                    iframe.style.height = container;
                    //----------------------------------------
                    break;
                case "WRKSB":

                    sCurrWrkSht = 'WRKSB';
                    $('#lbl_BPT_WS2').text($('#lblBPT_SchB_9').text());
                    $('#lbl_BPT_WS3').text($('#lblBPT_SchD_6').text());
                    $('#btnGoToPageWS1').val('Return to Schedule B');
                    $('#BPT_WorkSheetS').css('display', 'block');
                    

                    // I-frame scroll issue resolved                  
                    var iframe = window.parent.document.getElementById('ifrmDocwin');
                    var container = $('#tab1').css("height");
                    iframe.style.height = container;
                    //----------------------------------------
                    PerformloadingWorkSheetSb();
                    //alert('WRKSB');
                   
                    //alert('after');
                    RightAlignText_Ws();
                    break;
                case "WRKSA":

                    sCurrWrkSht = 'WRKSA';
                    $('#lbl_BPT_WS2').text($('#lblBPT_SchA_9').text());
                    $('#lbl_BPT_WS3').text($('#lblBPT_SchD_6').text());
                    $('#btnGoToPageWS1').val('Return to Schedule A');
                    $('#BPT_WorkSheetS').css('display', 'block');

                    // I-frame scroll issue resolved                  
                    var iframe = window.parent.document.getElementById('ifrmDocwin');
                    var container = $('#tab1').css("height");
                    iframe.style.height = container;
                    //----------------------------------------
                    PerformloadingWorkSheetSa();
                   
                    RightAlignText_Ws();
                    break;

            } //switch
            if (FocusItem) {
                if ($(FocusItem).is(':disabled') == false) {
                    $(FocusItem).focus();
                } //if
            } //if
        } //ShowPage   

        function PerformCalcs() {
            PerformCalcsBPTlfSchdE();
            PerformCalcsBPTlfSchdD();
            PerformCalcsBPTlfSchdC1();
            if (sIncomeMethod == 'SCHDA') {
                PerformCalcsBPTlfSchdA();
            } else if (sIncomeMethod == 'SCHDB') {
                PerformCalcsBPTlfSchdB();
            } 	//if
            PerformCalcsBPTlfPg1();
        }

        function LoadError() {
            var txtBPT1_4 = document.getElementById('txtBPT1_4');
            var txtBPT1_6a = document.getElementById('txtBPT1_6a');
            var txtBPT1_6b = document.getElementById('txtBPT1_6b');           
            var txtBPT1_10a = document.getElementById('txtBPT1_10a');
            var txtBPT1_10b = document.getElementById('txtBPT1_10b');
            var txtBPT1_10c = document.getElementById('txtBPT1_10c');
                   

            var i = 0;

            //BPT_Pg1	
            

            arrPage1Err[i++] = [txtBPT1_4, '$(\'#txtBPT1_4\').val() == ""', 'Answer question 4'];
            arrPage1Err[i++] = [txtBPT1_4, 'ispValue($(\'#txtBPT1_4\').val()) == false', 'Value for question 4 must be numeric'];
            arrPage1Err[i++] = [txtBPT1_4, 'ispNegativeNumber($(\'#txtBPT1_4\').val()) == false', 'Value for question 4 must not be negative'];

            arrPage1Err[i++] = [txtBPT1_6a, '$(\'#txtBPT1_6a\').val() == ""', 'Answer question 6a'];
            arrPage1Err[i++] = [txtBPT1_6a, 'ispValue($(\'#txtBPT1_6a\').val()) == false', 'Value for question 6a must be numeric'];
            arrPage1Err[i++] = [txtBPT1_6a, 'ispNegativeNumber($(\'#txtBPT1_6a\').val()) == false', 'Value for question 6a must not be negative'];

            arrPage1Err[i++] = [txtBPT1_6b, '$(\'#txtBPT1_6b\').val() == ""', 'Answer question 6b'];
            arrPage1Err[i++] = [txtBPT1_6b, 'ispValue($(\'#txtBPT1_6b\').val()) == false', 'Value for question 6b must be numeric'];
            arrPage1Err[i++] = [txtBPT1_6b, 'ispNegativeNumber($(\'#txtBPT1_6b\').val()) == false', 'Value for question 6b must not be negative'];

            //EGOVWEB-60 Added error section for txtBPT1_10a
            arrPage1Err[i++] = [txtBPT1_10a, '$(\'#txtBPT1_10a\').val() == ""', 'Answer question 10a'];
            arrPage1Err[i++] = [txtBPT1_10a, 'ispValue($(\'#txtBPT1_10a\').val()) == false', 'Value for question 10a must be numeric'];
            arrPage1Err[i++] = [txtBPT1_10a, 'ispNegativeNumber($(\'#txtBPT1_10a\').val()) == false', 'Value for question 10a must not be negative'];

            arrPage1Err[i++] = [txtBPT1_10b, '$(\'#txtBPT1_10b\').val() == ""', 'Answer question 10b'];
            arrPage1Err[i++] = [txtBPT1_10b, 'ispValue($(\'#txtBPT1_10b\').val()) == false', 'Value for question 10b must be numeric'];
            arrPage1Err[i++] = [txtBPT1_10b, 'ispNegativeNumber($(\'#txtBPT1_10b\').val()) == false', 'Value for question 10b must not be negative'];

            arrPage1Err[i++] = [txtBPT1_10c, '$(\'#txtBPT1_10c\').val() == ""', 'Answer question 10c'];
            arrPage1Err[i++] = [txtBPT1_10c, 'ispValue($(\'#txtBPT1_10c\').val()) == false', 'Value for question 10c must be numeric'];
            arrPage1Err[i++] = [txtBPT1_10c, 'ispNegativeNumber($(\'#txtBPT1_10c\').val()) == false', 'Value for question 10c must not be negative'];
            //BPT_SchdA
            LoadErrorBPTlfSchdA();
            //BPT_SchdB
            LoadErrorBPTlfSchdB();
            //BPT_SchdC1
            LoadErrorBPTlfSchdC1(); //tanu
            //BPT_SchdD
            LoadErrorBPTlfSchdD();
            //BPT_SchdE
            LoadErrorBPTlfSchdE();
            //WorkSheetS
            LoadErrorBPTlfWorkSheetS();
        } //LoadError

        function PopulateXmlBPTlf() {
           
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, '12/31/' + (sCurrYear - 1), xFldInfPeriod, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#lblBPT1_1').text()), xFldPg1Li1, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#lblBPT1_2').text()), xFldPg1Li2, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#lblBPT1_3').text()), xFldPg1Li3, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#txtBPT1_4').val()), xFldPg1Li4, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#lblBPT1_5').text()), xFldPg1Li5, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#txtBPT1_6a').val()), xFldPg1Li6, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#txtBPT1_6b').val()), xFldPg1Li7, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#lblBPT1_6c').text()), xFldPg1Li8, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#lblBPT1_7').text()), xFldPg1Li9, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#txtBPT1_8').val()), xFldPg1Li10, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#lblBPT1_9').text()), xFldPg1Li11, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#txtBPT1_10a').val()), xFldPg1Li12, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#txtBPT1_10b').val()), xFldPg1Li13, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#txtBPT1_10c').val()), xFldPg1Li14, '', 0);

            //BPT_SchdA
            if ($('#lblLnkSchdA').is(':disabled') == true || PrepForMath($('#txtBPT_SchA_1').val()) == 0) {
                ClearBPTlfSchdA();
            } else {
                PopulateXmlBPTlfSchdA();
            } //if
            //BPT_SchdB
            if ($('#lblLnkSchdB').is(':disabled') == true || PrepForMath($('#txtBPT_SchB_1').val()) == 0) {
                ClearBPTlfSchdB();
            } else {
                PopulateXmlBPTlfSchdB();
            } //if
            //BPT_SchdC1
            PopulateXmlBPTlfSchdC1(); //tanu
            //BPT_SchdD
            PopulateXmlBPTlfSchdD();
            //BPT_SchdE
            PopulateXmlBPTlfSchdE();
            //WorkSheet
            PopulateXmlWorkSheetS();
            PopulatePreparerXML(parent.$g.xmlBPTlf_2015, xSecInfo);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, '', 'DEBUG', '', 0);
        } //PopulateXmlBPTlf

        function ValidateWorksheet(formId) {
                 
            var ObjSelected = getActiveElement();
            $('#AppError').text('');
            if (ObjSelected) {
                if (ObjSelected.id == $('#txtPercentage')) {
                    //Do nothing
                } else if (ObjSelected.id != "") {
                    if (ObjSelected.type != 'button') {
                        ObjSelected.value = ispFormatMoney(ObjSelected.value, 0);
                    }
                }
            }
            switch (formId) {

                case "BPT_Pg1":
                    $('#AppError').text(ispSetInputErr_Form(arrPage1Err));
                    if ($("#AppError").text() == '') {
                        PerformCalcsBPTlfPg1();
                    } else {
                        parent.ScrollTop(arrPage1Err);
                        resolvedIframeheight();
                    }
                    break;
                case "BPT_SchdA":
                    $('#AppError').text(ispSetInputErr_Form(arrSchdAErr));
                    if ($("#AppError").text() == '') {
                        PerformCalcsBPTlfSchdA();
                    } else {
                        parent.ScrollTop(arrSchdAErr);
                        resolvedIframeheight();
                    }
                    break;
                case "BPT_SchdB":
                    $('#AppError').text(ispSetInputErr_Form(arrSchdBErr));
                    if ($("#AppError").text() == '') {
                        PerformCalcsBPTlfSchdB();
                    } else {
                        parent.ScrollTop(arrSchdBErr);
                        resolvedIframeheight();
                    }
                    break;
                case "BPT_SchdC1":
                    ///*********current code
                    $('#AppError').text(ispSetInputErr_Form(arrSchdC1Err));
                    if ($("#AppError").text() == '') {
                       
                        PerformCalcsBPTlfSchdC1(); //tanu
                    } else {
                        parent.ScrollTop(arrSchdC1Err);
                        resolvedIframeheight();
                    }

                   
                    break;
                case "BPT_SchdD":

                    $('#AppError').text(ispSetInputErr_Form(arrSchdDErr));
                    
                   
                   
                    if ($("#AppError").text() == '') {
                        //alert($("#AppError").text());
                        PerformCalcsBPTlfSchdD();
                    } else {
                        parent.ScrollTop(arrSchdDErr);
                        resolvedIframeheight();
                    }
                    if (ObjSelected.id == "txtBPT_SchD_8" && PrepForMath(ObjSelected.value) > 0) {
                        alert('You have entered or changed an amount greater then 0 on line 7. \n' + 'You will have to fill out Schedule E');
                    } //if
                    break;
                case "BPT_SchdE":
                    $('#AppError').text(ispSetInputErr_Form(arrSchdEErr));
                    if ($("#AppError").text() == '') {
                        PerformCalcsBPTlfSchdE();
                    } else {
                        parent.ScrollTop(arrSchdEErr);
                        resolvedIframeheight();
                    }
                    break;
                case "BPT_WorkSheetS":

                    var tempcal = PrepForMath($('#lbl_BPT_WS4').text() + $('#txt_BPT_WS4').val());
                    $('#AppError').text(ispSetInputErr_Form(arrWorkSheetSErr));
                    if (PrepForMath($('#txt_BPT_WS1').val()) > PrepForMath($("#lblBPT_SchD_6").text())) {
                        if (PrepForMath($('#txt_BPT_WS1').val()) != 50000) {
                            $('#AppError').text('S1 value must be lower of Line 6 of Schedule D or $50,000');
                        }
                    }
                    if (tempcal > PrepForMath($('#txt_BPT_WS1').val())) {
                        $('#AppError').text('Value for Line 4 cannot be greater than line1');
                        resolvedIframeheight();
                    }
                    Performvalidationandload();
                    break;

            } //Switch

        } //ValidateWorksheet			
        //Begin Calculations

        function PrepForMath(numString) { //Removes $ and , from the string and forces the string into a number
            var temp;
            temp = ispRemoveMoney(numString);
            return temp;

            //if
        } //PrepForMath

        function PerformCalcsBPTlfPg1() {
            CalcBPTlfPg1Line3();
            CalcBPTlfPg1Line5();
            CalcBPTlfPg1Line6c();
            CalcBPTlfPg1Line7();
            //EGOVWEB-60 rewrite CalcBPTlfPg1Line9 and CalcBPTlfPg1Line10a into CalcBPTlfPg1Line9_10
            CalcBPTlfPg1Line9_10();
            // nFlowCalc();  //binoy

        } //PerformCalcsBPTlfPg1

        function CalcBPTlfPg1Line3() {
          
            $('#lblBPT1_2').text($('#lblBPT_SchD_12').text());

           
            if ($('#lblBPT1_1').text() != '' && $('#lblBPT1_2').text() != '') {
                $('#lblBPT1_3').text(ispFormatMoney(PrepForMath($('#lblBPT1_1').text()) + PrepForMath($('#lblBPT1_2').text()), 0));
                if (b_txtBPT1_4 == false && PrepForMath($('#lblBPT1_3').text()) != 0) {
                    //EGOVWEB-65 - Added if statement
                    //EGOVWEB-73 - Estimate payment not being set to mainframe
                    //EGOVWEB-96 - Line 4 being loaded from Line 1 on Schedule D
                    if ($('#txtBPT1_4').is(':disabled') == false && $('#BPT_Pg1').css('display') == 'block') {
                        
                        if (getActiveElement().id != 'txtBPT1_4') {
                            $('#txtBPT1_4').val($('#lblBPT1_3').text());
                        }
                    } else {
                        if ($('#txtBPT1_4').val() == '') {
                            $('#txtBPT1_4').val(ispFormatMoney(0, 0));
                        } //if
                    } //if
                    //EGOVWEB-65 - Added the check for disabled
                //} 
                } 
                else if (b_txtBPT1_4 == true && $('#txtBPT1_4').is(':disabled') == false) {

                } else {
                    $('#txtBPT1_4').val($('#lblBPT1_3').text());
                }
            }
        }

        function CalcBPTlfPg1Line5() {
            if ($('#txtBPT1_4').val() != '') {
                var val3 = $('#lblBPT1_3').text();
                
                $('#lblBPT1_5').text(ispFormatMoney(PrepForMath(val3) + PrepForMath($('#txtBPT1_4').val()), 0));
            } //if
        } //CalcBPTlfPg1Line5

        function CalcBPTlfPg1Line6c() {
            if ($('#txtBPT1_6a').val() != '' && $('#txtBPT1_6b').val() != '') {
                $('#lblBPT1_6c').text(ispFormatMoney(PrepForMath($('#txtBPT1_6a').val()) + PrepForMath($('#txtBPT1_6b').val()), 0));
            } //if
        } //CalcBPTlfPg1Line6c

        function CalcBPTlfPg1Line7() {

            if ($('#lblBPT1_5').text() != '' && $('#lblBPT1_6c').text() != '') {
                $('#lblBPT1_7').text(ispFormatMoney(PrepForMath($('#lblBPT1_5').text()) - PrepForMath($('#lblBPT1_6c').text()), 0));
             
            }
        }

        //EGOVWEB-60 rewrite CalcBPTlfPg1Line9 and CalcBPTlfPg1Line10a into CalcBPTlfPg1Line9_10

        function CalcBPTlfPg1Line9_10() {

            if ($('#lblBPT1_7').text() != '' && $('#txtBPT1_8').val() != '') {
                $('#lblBPT1_9').text(ispFormatMoney(PrepForMath($('#lblBPT1_7').text()) + PrepForMath($('#txtBPT1_8').val()), 0));
            } //if
            
            if ($('#lblBPT1_9').text() != '') {
                if (PrepForMath($('#lblBPT1_9').text()) < 0) {                   
                    if ($('#txtBPT1_10a').val() == '') {
                        $('#txtBPT1_10a').val(ispFormatMoney(0, 0));
                    } //if
                    if ($('#txtBPT1_10b').val() == '') {
                        $('#txtBPT1_10b').val(ispFormatMoney(0, 0));
                    } //if
                    if ($('#txtBPT1_10c').val() == '') {
                        $('#txtBPT1_10c').val(ispFormatMoney(0, 0));
                    } //if
                    if (PrepForMath($('#txtBPT1_10a').val()) + PrepForMath($('#txtBPT1_10b').val()) + PrepForMath($('#txtBPT1_10c').val()) != Math.abs(PrepForMath($('#lblBPT1_7').text()))) {
                        $('#AppError').text('Page 1 Lines 10a, 10b and 10c must equal Line 7');
                        $('#txtBPT1_10a').attr('class', 'inpError form-control input-sm pull-right');
                        $('#txtBPT1_10b').attr('class', 'inpError form-control input-sm pull-right');
                        $('#txtBPT1_10c').attr('class', 'inpError form-control input-sm pull-right');
                        // I-frame scroll issue resolved                  
                        var iframe = window.parent.document.getElementById('ifrmDocwin');
                        var container = $('#tab1').css("height");
                        iframe.style.height = container;// Here 1 for some default value.
                    } else {
                        $('#txtBPT1_10a').attr('class', 'form-control input-sm pull-right');
                        $('#txtBPT1_10b').attr('class', 'form-control input-sm pull-right');
                        $('#txtBPT1_10c').attr('class', 'form-control input-sm pull-right');
                    }
                    $('#lblBPT1_9').text(ispFormatMoney(0, 0));
                } else {
                    $('#txtBPT1_10a').val(ispFormatMoney(0, 0));
                    $('#txtBPT1_10b').val(ispFormatMoney(0, 0));
                    $('#txtBPT1_10c').val(ispFormatMoney(0, 0));
                    $('#txtBPT1_10a').attr('class', 'form-control input-sm pull-right');
                    $('#txtBPT1_10b').attr('class', 'form-control input-sm pull-right');
                    $('#txtBPT1_10c').attr('class', 'form-control input-sm pull-right');
                }
            }
        }

        function nFlowCalc() {
            var l5val = PrepForMath($('#lblBPT1_5').text());
            var l6cval = PrepForMath($('#lblBPT1_6c').text())

            var l10a_val, l10b_val, l10c_val;
            l10a_val = PrepForMath($('#txtBPT1_10a').val());
            l10b_val = PrepForMath($('#txtBPT1_10b').val());
            l10c_val = PrepForMath($('#txtBPT1_10c').val());

            var nval = l5val - l6cval;

            var bval = 0;
            if (nval < 0) {
                bval = nval + l10a_val + l10b_val + l10c_val;
                $('#lblBPT1_7').text(ispFormatMoney(bval, 0));
                if (bval != 0) {
                    $('#AppError').text('Page 1 Lines 10a, 10b and 10c must equal Line 7');
                }
            }
        }

        //EGOVWEB-96 - Line 4 being loaded from Line 1 on Schedule D

        function Pg1L4Keyup() {
            b_txtBPT1_4 = true;
        } //Pg1L4Keyup

        function BirtLf_3800(btnClicked) {
            if ($('#div19_3800Msg').html() != '') {
                tmpHtml = $('#div19_3800Msg').html();
                //$('#div19_3800Msg').html('');
                $('#divMsg19_3800').html(tmpHtml);
            } //if
            if (btnClicked == null) {
                //loading time, do nothing
            } else if (btnClicked.id == $('#btnYes').attr('id')) {
                b3800val = true;
                $('#btnYes').attr('checked', true);
                $('#btnNo').attr('checked', false);
            } else {
                b3800val = false;
                $('#btnNo').attr('checked', true);
                $('#btnYes').attr('checked', false);
            } //if
            if ($('#BPT_WrkShtN').css('display') == 'none') {
                ShowPage('Pg1');
                if ($('#btnYes').is(':checked') == false) {
                    if ($('#lblLnkSchdA').is(':disabled')) {
                        $('#lblBPT1_1').text($('#lblBPT_SchB_13').text());
                    } else {
                        $('#lblBPT1_1').text($('#lblBPT_SchA_13').text());
                    }
                    $('#lblBPT1_2').text($('#lblBPT_SchD_11').text());
                    PerformCalcsBPTlfPg1();
                }

            } else {
                if (btnClicked == null) {
                    //do nothing
                } else if (btnClicked.id == $('#btnYes').attr('id')) { //Yes Radio Clicked
                    b3800val = true;
                    $('#btnYes').attr('checked', true);
                    $('#btnNo').attr('checked', false);
                    PerformCalcsBPTlfWrkShtN();
                } else { //No Radio Clicked
                    b3800val = false;
                    $('#btnNo').attr('checked', true);
                    $('#btnYes').attr('checked', false);
                    PerformCalcsBPTlfWrkShtN();
                } //if
            } //if
        } //12BirtLf_3800

        function striptest() {
            //alert(stripCurrency('0.00'));
        }
    </script>
</head>
<body>
    <div class="container-fluid no-padding" id="BIRTReturn">
        <div class="block3">

            <div class="container-fluid">

                <div class="row">

                    <div class="col-lg-12 col-md-12" style="display: block;" id="tab1">

                        <div class="blue_base_box" id="divblue">
                        
                            <h2>Taxpayer Information  |   <span id="AppHeader"></span></h2>
                            <div class="inner_white-panel">
                               <div class="col-lg-12 col-lg-offset-0 no-padding-left" style="height:1px;">
                                                  <div id="AppError" class="errormsg no-padding" style="display:block;">
                                                   </div>
                                                     </div>   
                                    <div class="clearfix"></div> 

                                <div class="contentsection">
                                    <h4 id="AppMessage">&nbsp;</h4>
                                    <div class="clearfix"></div>
                                    <div class="row">
                                        <!-- Tax Payer General Info Form -->
                                        
                                        <div class="col-lg-12">

                                             <div class="well" style="padding:3px 10px !important; margin-bottom:0px !important;">
                                                <div class="row">
                                                    <form>
                                                        <div class="col-lg-9 col-md-8 col-sm-9 col-xs-8">
                                                            <p style="margin-bottom:0 !important;">
                                                                <span>Name:</span>
                                                                <span id="lblName" class=""></span>
                                                            </p>
                                                        </div>

                                                        <div class="col-lg-3 col-md-4 col-sm-3 col-xs-4">
                                                            <p style="margin-bottom:0 !important;">
                                                                <span id="lblAccountType">Account No.:</span>
                                                                <span id="lblAccountId" class=""></span>
                                                            </p>
                                                        </div>

                                                    </form>
                                                </div>

                                                <div class="row">
                                                    <div class="col-lg-9 col-md-8 col-sm-9 col-xs-8">
                                                        <p style="margin-bottom:0 !important;">
                                                            <span>Address:</span>
                                                            <span id="lblAddress" class=""></span>
                                                        </p>
                                                    </div>
                                                    <div class="col-lg-3 col-md-4 col-sm-3 col-xs-4">
                                                        <p style="margin-bottom:0 !important;">
                                                            <span id="lblEntityType">EIN:</span>
                                                            <span id="lblEntityId" class=""></span>
                                                        </p>
                                                    </div>
                                                </div>
                                                <div class="clearfix"></div>

                                            </div>
                                        </div>
                                        <!-- Tax Payer General Info Form END -->
                                        <div class="clearfix"></div>
                                        <!---------------------------------->
                                        <div class="col-lg-12 col-md-12" id="BPT_Pg1">
                                            <div class="row">

                                                <div class="col-lg-12 templateclass">
                                                    <form class="form-horizontal">
                                                        <div class="row">
                                                            <div class="col-lg-3 col-sm-3 col-xs-12 newtop_padding" style="padding-top:5px;">
                                                                <label style="font-weight: normal;">
                                                                    <input id="chkAmended_08" type="checkbox" style="height:12px;" onclick="chkAmended_08_onclick()" />
                                                                    Check if amended return.</label>
                                                            </div>

                                                            <div class="col-lg-9 col-sm-9 col-xs-12 newtop_padding" style="padding-top:5px;">
                                                                <div class="col-lg-10 no-padding-right" style="padding-left: 0;">
                                                                    <label class="text-custom-left2" for="inputEmail3" style="font-size:11.5px;">
                                                                        <span class="custom_padding_span" style="font-weight: normal;">If your business terminated in 
				                    <script>document.write(sCurrYear - 1)</script>
                                                                            ,
					                    enter the termination date here <u>AND</u> file a <a href="https://beta.phila.gov/media/20170207132309/Change-Form.pdf">CHANGE FORM</a>.</span></label>
                                                                </div>
                                                                <div class="col-lg-2 new-margin-top-form wage-form-date no-padding-left" style="padding-right:0 !important;">
                                                                    <label>
                                                                        <span class="wage-from-date business-income-date-2015-from">
                                                                    <input class="inpNormal_custom date-input date-field-design business-income-date-2015" id="txtTermDate" onfocus="SetFocus()" placeholder="MM/DD/YYYY"
                                                                        onblur="return txtTermDate_onblur();" style="height:18px; margin-top:5px; padding:0 !important; width:100%;"></span>
                                                                </div>

                                                                <div class="clearfix"></div>

                                                            </div>
                                                        </div>
                                                        <div class="row" style="display:none">
                                                            <div class="col-sm-8 newtop_padding">
                                                                <label class="control-label text-custom-left2" for="inputEmail3">
                                                                    <span class="pull-left">YOU MUST COMPLETE WORKSHEET "S" and SCHEDULE "C-1"</span>

                                                                </label>
                                                            </div>
                                                        </div>
                                                    </form>

                                                    <!----------------------------------->
                                                    <div class="row table-responsive">
                                                        <div class="col-lg-12">



                                                            <table class="table table-condensed table-striped custom_table03 wage-table-print" style="margin-bottom:5px !important;">

                                                              
                                                                    <tr>
                                                                        <th colspan="3" width="100%" class="slim-headings">COMPUTATION OF TAX DUE OR OVERPAYMENT</th>

                                                                    </tr>

                                                              

                                                                <tbody>

                                                                    <tr>
                                                                        <td width="5%">1.</td>
                                                                        <td width="70%" class="text-left">NET INCOME PORTION OF TAX (from 
                                                <label id="lblLnkSchdB" class="lblLink label_NoLeft" onclick="ShowPage('SchdB')">Schedule B, Line 13</label>
                                                                            or 
			                                    <label id="lblLnkSchdA" class="lblLink label_NoLeft" onclick="ShowPage('SchdA')">Schedule A, Line 15</label>
                                                                            <label id="lblLnkSchdN1" style="display: none"></label>
                                                                            ).
                                                                        </td>
                                                                        <td width="25%" class="text-left">
                                                                            <form class="form-horizontal">

                                                                                <div class="form-group no-margin">
                                                                                    <div class="">
                                                                                        <label id="lblBPT1_1" style="width: 100%;" class="form-control input-sm pull-right"></label>
                                                                                    </div>
                                                                                </div>

                                                                            </form>
                                                                        </td>
                                                                    </tr>
                                                                    <tr class="odd">
                                                                        <td width="5%">2.</td>
                                                                        <td width="70%" class="text-left">GROSS RECEIPTS PORTION OF TAX (from
                                                <label class="lblLink label_NoLeft" style="width: 100%" onclick="ShowPage('SchdD')">Schedule D, Line 13</label>
                                                                            <label id="lblLnkSchdN2" style="display: none"></label>
                                                                            ).</td>
                                                                        <td width="25%" class="text-left">
                                                                            <form class="form-horizontal">

                                                                                <div class="form-group no-margin">
                                                                                    <div class="">
                                                                                        <label id="lblBPT1_2" style="width: 100%;" class="form-control input-sm pull-right"></label>
                                                                                    </div>
                                                                                </div>

                                                                            </form>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="5%">3.</td>
                                                                        <td width="70%" class="text-left">Tax Due for the 2017 Business Income & Receipts Tax[Calculated - add lines 1 and 2] </td>
                                                                        <td width="25%" class="text-left">
                                                                            <form class="form-horizontal">

                                                                                <div class="form-group no-margin">
                                                                                    <div class="">
                                                                                        <label id="lblBPT1_3" style="width: 100%;" class="form-control input-sm pull-right"></label>
                                                                                    </div>
                                                                                    </div>
                                                                            </form>
                                                                        </td>
                                                                    </tr>
                                                                    <tr class="odd">
                                                                        <td width="5%">4.</td>
                                                                        <td width="70%" class="text-left"><b><u>MANDATORY</u> 2018 BIRT Estimated Payment <u>(repeat line 3)</u> </b></td>
                                                                        <td width="25%" class="text-left">
                                                                            <form class="form-horizontal">
                                                                                <input class="form-control input-sm pull-right" type="text" id="txtBPT1_4" onchange="ValidateWorksheet('BPT_Pg1')" onkeyup="Pg1L4Keyup()"
                                                                                    onfocus="SetFocus()" maxlength="10" style="width: 100%;" />
                                                                                <div class="form-group no-margin">
                                                                                   
                                                                                </div>

                                                                            </form>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="5%">5.</td>
                                                                        <td width="70%" class="text-left">Total Due by <b>4/18/2018</b>[Calculated - add lines 3 and 4]</td>
                                                                        <td width="25%" class="text-left">
                                                                            <form class="form-horizontal">

                                                                                <div class="form-group no-margin">
                                                                                    <div class="">
                                                                                        <label id="lblBPT1_5" style="width: 100%;" class="form-control input-sm pull-right"></label>
                                                                                    </div>
                                                                                </div>

                                                                            </form>
                                                                        </td>
                                                                    </tr>


                                                                </tbody>

                                                               
                                                                    <tr>
                                                                        <th colspan="3" width="100%" class="slim-headings"><u>ESTIMATED PAYMENTS AND OTHER CREDITS</u></th>

                                                                    </tr>

                                                               

                                                                <tbody>

                                                                    <tr>
                                                                        <td width="5%">6a.</td>
                                                                        <td width="70%" class="text-left">Include any estimated and/or extension payments of 2017 BIRT previously made,
and any credit from overpayment of the 2016 BIRT and/or 2017 NPT return.</label> </td>
                                                                        <td width="25%" class="text-left">
                                                                            <form class="form-horizontal">

                                                                                <div class="form-group no-margin">
                                                                                    <div class="">
                                                                                        <input id="txtBPT1_6a" type="text" class="form-control input-sm pull-right" onchange="ValidateWorksheet('BPT_Pg1')"
                                                                                            onfocus="SetFocus()" style="width: 100%;" />
                                                                                    </div>
                                                                                </div>

                                                                            </form>
                                                                        </td>
                                                                    </tr>
                                                                    <tr class="odd">
                                                                        <td width="5%">6b.</td>
                                                                        <td width="70%" class="text-left">Credit from Special Credit Schedule (SC). (Cannot exceed amount on Line 3)</td>
                                                                        <td width="25%" class="text-left">
                                                                            <form class="form-horizontal">

                                                                                <div class="form-group no-margin">
                                                                                    <div class="">
                                                                                        <input id="txtBPT1_6b" type="text" class="form-control input-sm pull-right" onchange="ValidateWorksheet('BPT_Pg1')"
                                                                                            onfocus="SetFocus()" maxlength="10" style="width: 100%;" />
                                                                                    </div>
                                                                                </div>

                                                                            </form>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="5%">6c.</td>
                                                                        <td width="70%" class="text-left">Total Payments and Credits[Calculated - add lines 6a and 6b]</td>
                                                                        <td width="25%" class="text-left">
                                                                            <form class="form-horizontal">

                                                                                <div class="form-group no-margin">
                                                                                    <div class="">
                                                                                        <label id="lblBPT1_6c" class="form-control input-sm pull-right" style="width: 100%;"></label>
                                                                                    </div>
                                                                                </div>

                                                                            </form>
                                                                        </td>
                                                                    </tr>
                                                                    <tr class="odd">
                                                                        <td width="5%">7.</td>
                                                                        <td width="70%" class="text-left">Net Tax Due[Calculated - line 5 minus 6c]</td>
                                                                        <td width="25%" class="text-left">
                                                                            <form class="form-horizontal">

                                                                                <div class="form-group no-margin">
                                                                                    <div class="">
                                                                                        <label id="lblBPT1_7" style="width: 100%;" class="form-control input-sm pull-right"></label>
                                                                                    </div>
                                                                                </div>

                                                                            </form>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="5%">8.</td>
                                                                      <td width="70%" class="text-left">Interest and Penalty <a href="https://beta.phila.gov/services/payments-assistance-taxes/paying-city-taxes/interest-penalties-and-fees/" target="_blank" style="color:red">(see Instruction)</a></td>
                                                                        <td width="25%" class="text-left">
                                                                            <form class="form-horizontal">

                                                                                <div class="form-group no-margin">
                                                                                    <div class="">
                                                                                       <%-- <label id="lblBPT1_8" 
                                                                                            class="form-control input-sm pull-right" style="width: 70%;" />--%>
                                                                                         <input id="txtBPT1_8" class="form-control input-sm pull-right" style="width: 100%;" />
                                                                                    </div>
                                                                                </div>

                                                                            </form>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="5%">9.</td>
                                                                        <td width="70%" class="text-left"><u><b>TOTAL DUE</b></u> including Interest and Penalty<br>
                                                                            <b>Use payment coupon. Make check payable to: "City of Philadelphia"[Calculated - add line 7 and 8]</td>
                                                                        <td width="25%" class="text-left">
                                                                            <form class="form-horizontal">

                                                                                <div class="form-group no-margin">
                                                                                    <div class="">
                                                                                        <label id="lblBPT1_9" style="width: 100%;" class="form-control input-sm pull-right"></label>
                                                                                    </div>
                                                                                </div>

                                                                            </form>
                                                                        </td>
                                                                    </tr>


                                                                </tbody>

                                                               
                                                                    <tr>
                                                                        <th colspan="3" width="100%" class="slim-headings">OVERPAYMENT OPTIONS</th>

                                                                    </tr>

                                                               

                                                                <tbody>

                                                                    <tr>
                                                                        <td width="5%">10a.</td>
                                                                        <td width="70%" class="text-left">Refunded. <b>Do not file separate Refund Petition</b></td>
                                                                        <td width="25%" class="text-left">
                                                                            <form class="form-horizontal">

                                                                                <div class="form-group no-margin">
                                                                                    <div class="">
                                                                                        <input id="txtBPT1_10a" type="text" class="form-control input-sm pull-right" onchange="ValidateWorksheet('BPT_Pg1')" onfocus="SetFocus()" style="width: 100%;" />
                                                                                    </div>
                                                                                </div>

                                                                            </form>
                                                                        </td>
                                                                    </tr>
                                                                    <tr class="odd">
                                                                        <td width="5%">10b.</td>
                                                                        <td width="70%" class="text-left">Applied, up to the tax due, to the 2017 Net Profits Tax Return</td>
                                                                        <td width="25%" class="text-left">
                                                                            <form class="form-horizontal">

                                                                                <div class="form-group no-margin">
                                                                                    <div class="">
                                                                                        <input id="txtBPT1_10b" type="text" class="form-control input-sm pull-right" onchange="ValidateWorksheet('BPT_Pg1')" onfocus="SetFocus()" style="width: 100%;" />
                                                                                    </div>
                                                                                </div>

                                                                            </form>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="5%">10c.</td>
                                                                        <td width="70%" class="text-left">Applied to the 2018 Business Income & Receipts Tax</td>
                                                                        <td width="25%" class="text-left">
                                                                            <form class="form-horizontal">

                                                                                <div class="form-group no-margin">
                                                                                    <div class="">
                                                                                        <input id="txtBPT1_10c" type="text" class="form-control input-sm pull-right" onchange="ValidateWorksheet('BPT_Pg1')" onfocus="SetFocus()" style="width: 100%;" />
                                                                                    </div>
                                                                                </div>

                                                                            </form>
                                                                        </td>
                                                                    </tr>


                                                                </tbody>

                                                            </table>

                                                        </div>
                                                    </div>
                                                    <!-- Form 1 End -->

                                                    <!-- Preperar Section Form -->

                                                    <form class="form-horizontal form-year-background" style="padding:5px !important;">
                                                        <div>
                                                            <%
                                                                Html.RenderAction("PreparerSection", "INC");   
                                                            %>
                                                        </div>
                                                        <div class="form-group page-print-wage-section">
                                                            <div class="col-sm-offset-3 col-sm-9  text-right">

                                                                <input id="btnBPTPrint" type="button" value="Print" class="btn btn-default submit_button_light" onclick="return btnBPTPrint_onclick()" />
                                                                <input type="button" value="Submit" class="btn btn-default submit_button" id="btnBPTSubmit" onclick="return btnBPTSubmit_onclick()" />

                                                            </div>
                                                        </div>
                                                        <div style="margin-left: 5px; font-size: 12px; margin-top:0px !important;" class="here_input_table">
                                                            <label style="margin-top:3px !important;">
                                                                Note: DO NOT FILE THIS RETURN if you have no taxable activity. If you registered for 
				this tax and you no longer have taxable activity, complete a 
				<a href="https://beta.phila.gov/media/20170207132309/Change-Form.pdf" target="_blank">Change Form</a> to cancel
				your account.</label>
                                                        </div>


                                                    </form>

                                                    <!-- Preperar Section Form END -->

                                                </div>
                                            </div>
                                        </div>
                                            
                                        <div class="lets-split"></div>

                                        <div class="col-lg-12">
                                        <% 
                 
                                            

                                            Html.RenderAction("_17SchdA", "BPT_LF");//Changed by SumanG
                                            Html.RenderAction("_17SchdB", "BPT_LF");
                                            Html.RenderAction("_17SchdC1", "BPT_LF");
                                            Html.RenderAction("_17SchdD", "BPT_LF");
                                            Html.RenderAction("_17SchdE", "BPT_LF");
                                            Html.RenderAction("_17WorkSheet5", "BPT_LF");
                                            Html.RenderAction("LossCarryForwardfromBPT", "Returns");
                                            
           
          
             
                                        %></div>
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
</body>
</html>
