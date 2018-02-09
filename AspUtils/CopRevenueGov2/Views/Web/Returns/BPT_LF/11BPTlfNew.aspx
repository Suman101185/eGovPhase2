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
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script id="bptIF" language="javascript" type="text/javascript">
        //EGOVWEB-60 Changed lblBPT1_10a to txtBPT1_10a (8 places)


        var b_txtBPT1_4 = false;
        var arrPage1Err = new Array();
        var sAppError = '';
        var b3800val = false;
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

            var lblBPT1_1 = document.getElementById('lblBPT1_1');
            var lblBPT1_2 = document.getElementById('lblBPT1_2');
            var lblBPT1_3 = document.getElementById('lblBPT1_3');
            var txtBPT1_4 = document.getElementById('txtBPT1_4');
            var lblBPT1_4 = document.getElementById('lblBPT1_4');
            var txtBPT1_6a = document.getElementById('txtBPT1_6a');
            var txtBPT1_6b = document.getElementById('txtBPT1_6b');
            var lblBPT1_6c = document.getElementById('lblBPT1_6c');
            var lblBPT1_7 = document.getElementById('lblBPT1_7');
            var txtBPT1_8 = document.getElementById('txtBPT1_8');
            var lblBPT1_9 = document.getElementById('lblBPT1_9');
            var txtBPT1_10a = document.getElementById('txtBPT1_10a');
            var txtBPT1_10b = document.getElementById('txtBPT1_10b');

            if ($(parent.$g.xmlAccount.xml).find('TAX_ACCT[ACCOUNT = "24"]').eq(0)) {

                // parent.MenuWin.ispHighlightMenu(parent.MenuWin.mnuBPTlfYear13);

                parent.$g.xmlBPTlf.loadXML(parent.$g.xmlBPTlfTemplate.xml);

                $(BPT_Pg1).css('display', 'block');
                FieldLock(true);
                $('#AppHeader').html(txtHeader + '<Font class=hdrMedium>|Business Income & Receipts Tax for </Font>' + '<Font class=hdrMedium>' + (sCurrYear - 1) + '</Font>');

                parent.gsInstructionItem = '#BIR';
                $('#AppMessage').html(parent.gsInstructionText + '<BR>The Business Privilege Tax for ' + (sCurrYear - 1) + ' is due April 15, ' + sCurrYear + '.');
                $('#InstructionText').html(' for Loss Carry Forward and Estimated Payments');



                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 'INQ', xFldInfRetStat, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ACCOUNT_ID', '', 0), xFldInfAcctID, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, '12/31/' + (sCurrYear - 1), xFldInfPeriod, '', 0);
                ispCallXMLForm(parent.$g.xmlBPTlf, parent.$g.xmlBPTlf, "BPT_LF/BPTlfReturn", "");

                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldErrError, '', 0) != 0) {
                    $(parent.RightFrame).attr('rows', '*,0');
                    $(BPT_Pg1).css('display', 'block');
                    FieldLock(true);
                    $(parent.AppError).text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldErrMessage, "", 0));
                    $('#btnBPTSubmit').attr('disabled', true);
                    $('#chkAmended').attr('disabled', true);
                    return;
                }
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldInfRetStat, '', 0) == 'EZ') {
                    parent.$g.xmlBPTlf.loadXML(parent.$g.xmlBPTlfTemplate.xml);
                    //  parent.ispMenu_onclick($(parent.document).find('#mnuBPTezYear13').get(0));
                }
                if ($(parent.divAcctInfo).css("display") == 'none') {
                    $(parent.divAcctInfo).css("display", "block");
                    $(parent.divAccount).css("display", "none");
                } //if

                $(parent.RightFrame).attr('rows', '*,0');
                //if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldInfRetStat, '', 0) == 'A1' || parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldInfRetStat, '', 0) == 'A2') {
                //    if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldInfVer, '', 0) == '') {

                //        $('#BPT_Pg1').css('display', 'none');
                //        $('#BPT_19_3800').css('display', 'block');
                //    } else {
                //        btn3800YN_onclick(null)
                //        $('#BPT_Pg1').css('display', 'block');
                //    }
                //} else {
                //    $('#BPT_Pg1').css('display', 'block');
                //}

                LoadError();
                CheckBPTXML();
                SetBPTFields();
                PopulateBPTHeader();
                //ResetBPTlfSchdB();	
                PopulateBPTData();
            } else {
                parent.$g.xmlBPTlf.loadXML(parent.$g.xmlBPTlfTemplate.xml);
                parent.ispMenu_onclick(parent.mnuAcctInfo);
            }
            // loadpage();
        } //DisplayBPTlfReturn
        //function loadpage() {
        //    //if ($.browser.mozilla || $.browser.firefox || $.browser.opera || $.browser.safari || $.browser.chrome) {
        //    try {
        //        var iFrameID = parent.window.frames['ifrmDocwin'];

        //        $(iFrameID).height($(iFrameID).contents().find("html").height() + 70);
        //    }
        //    catch (ee) {
        //        var iFrameID1 = parent.document.getElementById('ifrmDocwin');

        //        iFrameID1.height = (iFrameID1.contentWindow.document.body.scrollHeight + 70) + "px";
        //    }
        //    //    }
        //    //}
        //    //else {
        //    //    var iFrameID1 = parent.document.getElementById('ifrmDocwin');
        //    //    iFrameID1.height = (iFrameID1.contentWindow.document.body.scrollHeight + 70) + "px";

        //    //}


        //} // binoy
        function CheckBPTXML() {

            var lblBPT1_1 = document.getElementById('lblBPT1_1');
            var lblBPT1_2 = document.getElementById('lblBPT1_2');
            var lblBPT1_3 = document.getElementById('lblBPT1_3');
            var txtBPT1_4 = document.getElementById('txtBPT1_4');
            var lblBPT1_4 = document.getElementById('lblBPT1_4');
            var txtBPT1_6a = document.getElementById('txtBPT1_6a');
            var txtBPT1_6b = document.getElementById('txtBPT1_6b');
            var lblBPT1_6c = document.getElementById('lblBPT1_6c');
            var lblBPT1_7 = document.getElementById('lblBPT1_7');
            var txtBPT1_8 = document.getElementById('txtBPT1_8');
            var lblBPT1_9 = document.getElementById('lblBPT1_9');
            var txtBPT1_10a = document.getElementById('txtBPT1_10a');
            var txtBPT1_10b = document.getElementById('txtBPT1_10b');
            var txtTermDate = document.getElementById('txtTermDate');

            var bPeriodExist = true;
            var firstOfYear = '01/01/' + (sCurrYear - 1);

            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldInfPeriod, '', 0) != '' && new Date(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldInfPeriod, '', 0)) < new Date(firstOfYear)) {

                bPeriodExist = false;

            }

            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldInfPeriod, '', 0) == '') {
                bPeriodExist = false;
            }

            if (bPeriodExist == false) {
                //error_info
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, '', xFldErrProgram, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, '', xFldErrError, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, '', xFldErrLine, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, '', xFldErrMessage, '', 0);
                //BPT_info	
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, '12/31/' + (sCurrYear - 1), xFldInfPeriod, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, '', xFldInfVer, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, '', xFldInfRetStat, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, '', xFldInfLastUpdDate, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, '', xFldInfRecDate, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, '', xFldInfExtDate, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, '', xFldInfSeq, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, '', xFldInfAdjRef, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, '', xFldInfUserId, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, '', xFldInfABtaxRate, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, '', xFldInfDtaxRate, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, '', xFldInfEmanTaxRate, '', 0);;
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, '', xFldInfEwhoTaxRate, '', 0)
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, '', xFldInfEretTaxRate, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, '', xFldInfLossCarry, '', 0);
                //BPT_pg1
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldPg1Li1, '', 0)
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldPg1Li2, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldPg1Li3, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldPg1Li4, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldPg1Li5, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldPg1Li6, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldPg1Li7, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldPg1Li8, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldPg1Li9, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldPg1Li10, '', 0)
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldPg1Li11, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldPg1Li12, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldPg1Li13, '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldPg1Li14, '', 0);

                //BPT_schdA
                ClearBPTlfSchdA();
                //BPT_schdB
                ClearBPTlfSchdB();
                //BPT_schdC1
                ClearBPTlfSchdC1();
                //BPT_SchdD
                ClearBPTlfSchdD();
                //BPT_SchdE
                ClearBPTlfSchdE();
                // worksheets
                //ClearBPTlfWorkSheetS();
                //
                ClearPreparerXML(parent.$g.xmlBPTlf, xSecInfo);
            } //if
        } //CheckBPTXML

        function SetBPTFields() {

            var chkAmended = document.getElementById('chkAmended_08');
            var chkAgreement = document.getElementById('chkAgreement');
            var chkTaxpayer = document.getElementById('chkTaxpayer');
            chkAgreement.checked = false;
            chkAmended.checked = false;

            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldInfVer, '', 0) == '') {
                FieldLock(false);
                $('#chkAmended').attr('disabled', true);
                chkTaxpayer.checked = false;
            } else {
                //Sanghamitra:
                //in old system the dll used to return string value but  in new system service returns double in the field NI_loss thus we need to call PrepForMath() and then compare the value with 0 instead of '' 
                if (PrepForMath(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScALi1, '', 0)) != 0) {

                    $('#lblLnkSchdB').removeAttr('onclick');
                    $('#lblLnkSchdB').css('cursor', 'default');
                    $('#lblLnkSchdB').attr("disabled", true);
                } else {

                    if (PrepForMath(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScBLi1, '', 0)) != 0) {
                        $('#lblLnkSchdA').removeAttr('onclick');
                        $('#lblLnkSchdA').css('cursor', 'default');
                        $('#lblLnkSchdA').attr("disabled", true);
                    }
                }
                $('#chkAmended').removeAttr("disabled");
                FieldLock(true);
            }
        } //SetBPTFields

        function PopulateBPTHeader() {

            var lblBPT1_1 = document.getElementById('lblBPT1_1');
            var lblBPT1_2 = document.getElementById('lblBPT1_2');
            var lblBPT1_3 = document.getElementById('lblBPT1_3');
            var txtBPT1_4 = document.getElementById('txtBPT1_4');
            var lblBPT1_4 = document.getElementById('lblBPT1_4');
            var txtBPT1_6a = document.getElementById('txtBPT1_6a');
            var txtBPT1_6b = document.getElementById('txtBPT1_6b');
            var lblBPT1_6c = document.getElementById('lblBPT1_6c');
            var lblBPT1_7 = document.getElementById('lblBPT1_7');
            var txtBPT1_8 = document.getElementById('txtBPT1_8');
            var lblBPT1_9 = document.getElementById('lblBPT1_9');
            var txtBPT1_10a = document.getElementById('txtBPT1_10a');
            var txtBPT1_10b = document.getElementById('txtBPT1_10b');
            var txtTermDate = document.getElementById('txtTermDate');
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

        function PopulateBPTData() {

            var lblBPT1_1 = document.getElementById('lblBPT1_1');
            var lblBPT1_2 = document.getElementById('lblBPT1_2');
            var lblBPT1_3 = document.getElementById('lblBPT1_3');
            var txtBPT1_4 = document.getElementById('txtBPT1_4');
            var lblBPT1_4 = document.getElementById('lblBPT1_4');
            var txtBPT1_6a = document.getElementById('txtBPT1_6a');
            var txtBPT1_6b = document.getElementById('txtBPT1_6b');
            var lblBPT1_6c = document.getElementById('lblBPT1_6c');
            var lblBPT1_7 = document.getElementById('lblBPT1_7');
            var txtBPT1_8 = document.getElementById('txtBPT1_8');
            var lblBPT1_9 = document.getElementById('lblBPT1_9');
            var txtBPT1_10a = document.getElementById('txtBPT1_10a');
            var txtBPT1_10b = document.getElementById('txtBPT1_10b');
            var txtBPT1_10c = document.getElementById('txtBPT1_10c');
            var txtTermDate = document.getElementById('txtTermDate');

            dBPTNetRate = parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldInfABtaxRate, '', 0);
            dBPTGrossRate = parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldInfDtaxRate, '', 0);
            dBPTManufacturerRate = parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldInfEmanTaxRate, '', 0);
            dBPTWholesaleRate = parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldInfEwhoTaxRate, '', 0);
            dBPTRetailerRate = parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldInfEretTaxRate, '', 0);
            //BPT_Pg1
            txtTermDate.value = "";
            $('#lblBPT1_1').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldPg1Li1, '', 0), 0));
            $('#lblBPT1_2').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldPg1Li2, '', 0), 0));
            $('#lblBPT1_3').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldPg1Li3, '', 0), 0));

            txtBPT1_4.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldPg1Li4, '', 0), 0);
            $('#lblBPT1_5').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldPg1Li5, '', 0), 0));;
            txtBPT1_6a.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldPg1Li6, '', 0), 0)
            txtBPT1_6b.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldPg1Li7, '', 0), 0);
            $('#lblBPT1_6c').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldPg1Li8, '', 0), 0));
            //EGOVWEB-60 Changed xFldPg1Li8 to xFldPg1Li9
            $('#lblBPT1_7').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldPg1Li9, '', 0), 0));
            txtBPT1_8.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldPg1Li10, '', 0), 0);
            $('#lblBPT1_9').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldPg1Li11, '', 0), 0));
            txtBPT1_10a.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldPg1Li12, '', 0), 0);
            txtBPT1_10b.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldPg1Li13, '', 0), 0);
            txtBPT1_10c.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldPg1Li14, '', 0), 0);

            //BPT_SchdA
            PopulateBPTlfSchdA();
            //BPT_SchdB
            PopulateBPTlfSchdB();
            //BPT_SchdC1
            PopulateBPTlfSchdC1();
            //BPT_SchdD
            PopulateBPTlfSchdD();
            //BPT_SchdE
            PopulateBPTlfSchdE();
            //WorkSheetS
            //PopulateBPTlfWorkSheetS();
            PopulatePreparer(parent.$g.xmlBPTlf, xSecInfo);

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
            FieldLockBPTlfSchdC1(bDisabled);
            FieldLockBPTlfSchdD(bDisabled);
            FieldLockBPTlfSchdE(bDisabled);
            //FieldLockBPTlfWrkS(bDisabled);
            DisablePreparer(bDisabled);
            //EGOVWEB-65
            if (bDisabled == true) {
                $('#txtBPT1_4').attr('class', 'form-control input-sm');
                $('#txtBPT1_6a').attr('class', 'form-control input-sm');
                $('#txtBPT1_6b').attr('class', 'form-control input-sm');
                $('#txtBPT1_8').attr('class', 'form-control input-sm');
                $('#txtBPT1_10b').attr('class', 'form-control input-sm');
                $('#txtBPT1_10c').attr('class', 'form-control input-sm');
                $('#txtTermDate').attr('class', 'form-control input-sm');
            }
        } //FieldLock

        function SetFocus() {
            var lblBPT1_1 = document.getElementById('lblBPT1_1');
            var lblBPT1_2 = document.getElementById('lblBPT1_2');
            var lblBPT1_3 = document.getElementById('lblBPT1_3');
            var txtBPT1_4 = document.getElementById('txtBPT1_4');
            var lblBPT1_4 = document.getElementById('lblBPT1_4');
            var txtBPT1_6a = document.getElementById('txtBPT1_6a');
            var txtBPT1_6b = document.getElementById('txtBPT1_6b');
            var lblBPT1_6c = document.getElementById('lblBPT1_6c');
            var lblBPT1_7 = document.getElementById('lblBPT1_7');
            var txtBPT1_8 = document.getElementById('txtBPT1_8');
            var lblBPT1_9 = document.getElementById('lblBPT1_9');
            var txtBPT1_10a = document.getElementById('txtBPT1_10a');
            var txtBPT1_10b = document.getElementById('txtBPT1_10b');
            var txtTermDate = document.getElementById('txtTermDate');
            $(getActiveElement()).select();
        } //SetFocus

        function btnBPTPrint_onclick() {
            var objCurrDisplayed;

            $('#btnBPTPrint').css('visibility', 'hidden');
            $('#btnBPTSubmit').css('visibility', 'hidden');
            PerformCalcsBPTlfWrkShtN()
            if ($('#BPT_Pg1').css('display') == 'block') {
                objCurrDisplayed = 'BPT_Pg1';
                $('#BPT_SchdA').css('display', "block");
                $('#BPT_SchdB').css('display', "block");
                $('#BPT_SchdC1').css('display', "block");
                $('#BPT_SchdD').css('display', "block");
                $('#BPT_SchdE').css('display', "block");
                $('#BPT_WrkShtN').css('display', 'block');
            } //if
            $(parent.AppError).text('');
            window.print();
            $('#btnBPTPrint').css('visibility', 'visible');
            $('#btnBPTSubmit').css('visibility', 'visible');

            if (objCurrDisplayed == 'BPT_Pg1') {
                $('#BPT_SchdA').css('display', "none");
                $('#BPT_SchdB').css('display', "none");
                $('#BPT_SchdC1').css('display', "none");
                $('#BPT_SchdD').css('display', "none");
                $('#BPT_SchdE').css('display', "none");
                //$('#BPT_WrkShtN').css('display', 'none');
            } //if
        } //btnBPTPrint_onclick

        function btnBPTSubmit_onclick() {

            var lblBPT1_1 = document.getElementById('lblBPT1_1');
            var lblBPT1_2 = document.getElementById('lblBPT1_2');
            var lblBPT1_3 = document.getElementById('lblBPT1_3');
            var txtBPT1_4 = document.getElementById('txtBPT1_4');
            var lblBPT1_4 = document.getElementById('lblBPT1_4');
            var txtBPT1_6a = document.getElementById('txtBPT1_6a');
            var txtBPT1_6b = document.getElementById('txtBPT1_6b');
            var lblBPT1_6c = document.getElementById('lblBPT1_6c');
            var lblBPT1_7 = document.getElementById('lblBPT1_7');
            var txtBPT1_8 = document.getElementById('txtBPT1_8');
            var lblBPT1_9 = document.getElementById('lblBPT1_9');
            var txtBPT1_10a = document.getElementById('txtBPT1_10a');
            var txtBPT1_10b = document.getElementById('txtBPT1_10b');
            var txtTermDate = document.getElementById('txtTermDate');

            var tempXML = parent.$g.getXmlDocObj();
            $(parent.AppError).text('');
            ValidateWorksheet('BPT_Pg1');
            if ($(parent.AppError).text() != '') {
                alert($(parent.AppError).text());
                ShowPage('Pg1');
                return;
            } //if
            ValidateWorksheet('BPT_SchdA');
            if ($(parent.AppError).text() != '') {
                alert($(parent.AppError).text());
                ShowPage('SchdA');

                return;
            } //if
            ValidateWorksheet('BPT_SchdB');
            if ($(parent.AppError).text() != '') {
                ShowPage('SchdB');

                return;
            } //if
            ValidateWorksheet('BPT_SchdC1');
            if ($(parent.AppError).text() != '') {
                alert($(parent.AppError).text());
                ShowPage('SchdC1');

                return;
            } //if
            ValidateWorksheet('BPT_SchdD');
            if ($(parent.AppError).text() != '') {
                alert($(parent.AppError).text());
                ShowPage('SchdD');
                return;
            } //if
            ValidateWorksheet('BPT_SchdE');
            if ($(parent.AppError).text() != '') {
                alert($(parent.AppError).text());
                ShowPage('SchdE');

                //return;
            }
            //ValidateWorksheet('BPT_WorkSheetS');
            //if ($(parent.AppError).text() != '') {
            //    alert($(parent.AppError).text());
            //    ShowPage('SchdE');

            //    //return;
            //}//if
            if ($(parent.AppError).text() == '') {

                $(parent.AppError).text(ValidatePreparer());
                if ($(parent.AppError).text() != '') {
                    return;
                }
            } //if
            //EGOVWEB-73 Moved outside the error If statement
            txtTermDate_onblur();
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, '', xFldInfRetStat, '', 0);
            PopulateXmlBPTlf();

            if ($(parent.AppError).text() == '') {

                ispCallXMLForm(parent.$g.xmlBPTlf, tempXML, "BPT_LF/BPTlfReturn", "");

                if (parent.$x.ispXmlGetFieldVal(tempXML, xFldErrProgram, '', 0) == '') {

                    parent.$g.xmlBPTlf.loadXML(tempXML.xml);
                    //$(BPT).css('display' , 'none');
                    DisplayBPTlfThankYou();
                } else {
                    parent.$g.xmlBPTlf.loadXML(tempXML.xml);
                    $(parent.AppError).text(parent.$x.ispXmlGetFieldVal(tempXML, xFldErrMessage, '', 0));
                }
            }
        }

        function DisplayBPTlfThankYou() {
            $(frmePay.imgCards).attr("src", "../../Content/Images/ePay.gif");
            //suman, this lines should converted
            //frmePay.imgCards.src = '../../Images/ePay.gif';
            //xmlCC.src = '../../xml/CCBilling.xml';
            //xmlCCTemplate.src = '../../xml/CCBilling.xml';
            //-------------------------
            $('#BPT_Pg1').css('display', "none");
            $('#BPT_Pg1').css('display', "none");
            $('#BPT_SchdA').css('display', "none");
            $('#BPT_SchdB').css('display', "none");
            $('#BPT_SchdC1').css('display', "none");
            $('#BPT_SchdD').css('display', "none");
            $('#BPT_SchdE').css('display', "none");

            $('#lblThankYouName').text($('#lblName').text());
            $('#lblAcctNo').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, 'BPT_INFO ACCOUNT_ID', '', 0));
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldInfAdjRef, '', 0) != '') {
                $('#lblConfirmNo').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldInfAdjRef, '', 0));
            } else {
                $('#lblConfirmNo').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ACCOUNT_ID', '', 0));
            } //if Adjustment reference number
            $('#divBPTlfThankYou').css('display', 'block');
            return

        } //DisplayThankyou

        function txtTermDate_onblur() {

            var lblBPT1_1 = document.getElementById('lblBPT1_1');
            var lblBPT1_2 = document.getElementById('lblBPT1_2');
            var lblBPT1_3 = document.getElementById('lblBPT1_3');
            var txtBPT1_4 = document.getElementById('txtBPT1_4');
            var lblBPT1_4 = document.getElementById('lblBPT1_4');
            var txtBPT1_6a = document.getElementById('txtBPT1_6a');
            var txtBPT1_6b = document.getElementById('txtBPT1_6b');
            var lblBPT1_6c = document.getElementById('lblBPT1_6c');
            var lblBPT1_7 = document.getElementById('lblBPT1_7');
            var txtBPT1_8 = document.getElementById('txtBPT1_8');
            var lblBPT1_9 = document.getElementById('lblBPT1_9');
            var txtBPT1_10a = document.getElementById('txtBPT1_10a');
            var txtBPT1_10b = document.getElementById('txtBPT1_10b');
            var txtTermDate = document.getElementById('txtTermDate');

            //EGOVWEB-65
            $(parent.AppError).text('');
            if ($(parent.AppError).text() == "" && txtTermDate.value != "") {
                var strBD = ispValidateDate(txtTermDate.value);

                if (strBD == false) {
                    $(parent.AppError).text('Invalid termination date');
                    $('#txtTermDate').attr("class", "inpError");
                    blnErr = true;
                    $('#txtTermDate').focus();
                } else {
                    $('#txtTermDate').attr('class', 'form-control input-sm');

                    txtTermDate.value = strBD;

                    $('#txtBPT1_4').attr('class', 'form-control input-sm');

                    txtBPT1_4.value = ispFormatMoney(0, 0);
                    $('#txtBPT1_4').attr('disabled', true);
                    $('#txtBPT1_6a').focus();
                    PerformCalcsBPTlfPg1();
                } //if
            } else {

                $('#txtTermDate').attr('class', 'form-control input-sm');
                //EGOVWEB-65
                $('#txtBPT1_4').removeAttr('disabled');
                //EGOVWEB-73 - Estimate payment not being set to mainframe (reseting estimate payment to what is in the XML)
                //		txtBPT1_4.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldPg1Li4, '', 0), 0)
                if ($('#BPT_Pg1').css("display") == 'block') {
                    $('#txtBPT1_4').focus();
                }
                PerformCalcsBPTlfPg1();
            } //if
        } //txtToDate_onblur

        function chkAmended_08_onclick() {
            var lblBPT1_1 = document.getElementById('lblBPT1_1');
            var lblBPT1_2 = document.getElementById('lblBPT1_2');
            var lblBPT1_3 = document.getElementById('lblBPT1_3');
            var txtBPT1_4 = document.getElementById('txtBPT1_4');
            var lblBPT1_4 = document.getElementById('lblBPT1_4');
            var txtBPT1_6a = document.getElementById('txtBPT1_6a');
            var txtBPT1_6b = document.getElementById('txtBPT1_6b');
            var lblBPT1_6c = document.getElementById('lblBPT1_6c');
            var lblBPT1_7 = document.getElementById('lblBPT1_7');
            var txtBPT1_8 = document.getElementById('txtBPT1_8');
            var lblBPT1_9 = document.getElementById('lblBPT1_9');
            var txtBPT1_10a = document.getElementById('txtBPT1_10a');
            var txtBPT1_10b = document.getElementById('txtBPT1_10b');
            var txtTermDate = document.getElementById('txtTermDate');
            var chkAgreement = document.getElementById('chkAgreement');

            if ($('#chkAmended_08').is(':checked')) {

                //parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, "A1", "xFldInfRetStat", '', 0); //temporarily
                $('#btnNo').removeAttr('checked');
                $('#btnYes').removeAttr('checked');
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldInfRetStat, '', 0) == 'A1' || parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldInfRetStat, '', 0) == 'A2') {
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
                chkAgreement.checked = false;
                FieldLock(true);
                PopulatePreparer(parent.$g.xmlBPTlf, xSecInfo);
                $(parent.AppError).text('');
            } //if
        } //chkAmended_onclick

        function ShowPage(iSch) {

            var lblBPT1_1 = document.getElementById('lblBPT1_1');
            var lblBPT1_2 = document.getElementById('lblBPT1_2');
            var lblBPT1_3 = document.getElementById('lblBPT1_3');
            var txtBPT1_4 = document.getElementById('txtBPT1_4');
            var lblBPT1_4 = document.getElementById('lblBPT1_4');
            var txtBPT1_6a = document.getElementById('txtBPT1_6a');
            var txtBPT1_6b = document.getElementById('txtBPT1_6b');
            var lblBPT1_6c = document.getElementById('lblBPT1_6c');
            var lblBPT1_7 = document.getElementById('lblBPT1_7');
            var txtBPT1_8 = document.getElementById('txtBPT1_8');
            var lblBPT1_9 = document.getElementById('lblBPT1_9');
            var txtBPT1_10a = document.getElementById('txtBPT1_10a');
            var txtBPT1_10b = document.getElementById('txtBPT1_10b');
            var txtTermDate = document.getElementById('txtTermDate');
            var chkAgreement = document.getElementById('chkAgreement');
            var txtBPT_SchB_1 = document.getElementById('txtBPT_SchB_1');
            var txtBPT_SchA_1 = document.getElementById('txtBPT_SchA_1');
            var btnC1GoTo = document.getElementById('btnC1GoTo');
            var txtBPT_SchC1_1A = document.getElementById('txtBPT_SchC1_1A');
            var txtBPT_SchD_1 = document.getElementById('txtBPT_SchD_1');
            var txtBPT_SchC1_1A = document.getElementById('');
            var btnGoToPageWS1 = document.getElementById('btnGoToPageWS1');
            // var txtBPT_SchC1_1A = document.getElementById('');

            $('#BPT_Pg1').css('display', 'none');
            //$('#BPT').css('display', 'none');
            $('#BPT_SchdA').css('display', 'none');
            $('#BPT_SchdB').css('display', 'none');
            $('#BPT_SchdC1').css('display', 'none');
            $('#BPT_SchdD').css('display', 'none');
            $('#BPT_SchdE').css('display', 'none');
            $('#BPT_WrkShtN').css('display', 'none');
            // $('#BPT_WorkSheetS').css('display', 'none');
            $('#lblLnkSchdN1').text('');
            $('#lblLnkSchdN2').text('');
            $('#BPT_19_3800').css('display', 'none');

            sPrevWrkSht = sCurrWrkSht;
            $(parent.AppError).text('');
            var FocusItem;
            switch (iSch) {
                case "Pg1":

                    sCurrWrkSht = 'PG1';
                    $('#BPT_Pg1').css('display', 'block');
                    if (sPrevWrkSht == 'SCHDA') {

                        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldInfRetStat, '', 0) == 'A1' || parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldInfRetStat, '', 0) == 'A2') {
                            if ($('#btnYes').is(':checked')) {
                                //SUMAN : ON EXEMPTED YES THE WILL BE $0
                                //$('#lblBPT1_1').text( ispFormatMoney($('#lblBPT1_1').text(), 0));
                                $('#lblBPT1_1').text(ispFormatMoney(0, 0));
                            } else {
                                $('#lblBPT1_1').text($('#lblBPT_SchA_13').text());
                            } //if
                        } else {
                            $('#lblBPT1_1').text($('#lblBPT_SchA_13').text());
                        }
                    } else if (sPrevWrkSht == 'SCHDB') {



                        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldInfRetStat, '', 0) == 'A1' || parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldInfRetStat, '', 0) == 'A2') {
                            if ($('#btnYes').is(':checked')) {
                                //SUMAN : ON EXEMPTED YES THE WILL BE $0
                                //$('#lblBPT1_1').text( ispFormatMoney($('#lblBPT1_1').text(), 0));
                                $('#lblBPT1_1').text(ispFormatMoney(0, 0));
                            } else {
                                $('#lblBPT1_1').text($('#lblBPT_SchB_13').text());
                            } //if
                        } else {
                            $('#lblBPT1_1').text($('#lblBPT_SchB_13').text());
                        }
                    } else if (sPrevWrkSht == 'SCHDD') {
                        if ($('#btnYes').is(':checked') == true) {
                            $('#lblBPT1_2').text(ispFormatMoney($('#lblBPT1_2').text(), 0));
                        } else {
                            $('#lblBPT1_2').text($('#lblBPT_SchD_12').text());
                        } //if
                    } else if (sPrevWrkSht == 'WRKSHTN') {
                        $('#lblBPT1_1').text(ispFormatMoney($('#lblWrkShtN_2').text(), 0));
                        $('#lblBPT1_2').text(ispFormatMoney($('#lblWrkShtN_4').text(), 0));
                    } //if
                    if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldInfRetStat, '', 0) == 'A1' || parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldInfRetStat, '', 0) == 'A2') {
                        //SUMAN : AS PER REQUIREMENT DICUSSED ON 24TH JAN 2014, CLIENT DONT WANT SCHEDULE N LINK IF USER CHOSE YES OPTION
                        if ($("#btnYes").is(":checked") == false) {
                            $('#lblLnkSchdN1').html('<label class="lblInstrNormal"> or </label>' + '<label class="lblLink" style="FONT-SIZE: 7pt" onclick=ShowPage("WrkShtN")> Worksheet N, Line 2</label>');
                            $('#lblLnkSchdN2').html('<label class="lblInstrNormal"> or </label>' + '<label class="lblLink" style="FONT-SIZE: 7pt" onclick=ShowPage("WrkShtN")> Worksheet N, Line 4</label>');
                        }
                        //suman : no special treatment is required
                        /*if ($('#btnYes').is(':checked')) {	
                                                if(b_txtBPT1_4==true){
                                                    //SUMAN : USER HAS CHANGE IT'S VALUE MANUALLY SO KEEP IT 						
                                                }
                                                else{
                                                    txtBPT1_4.value = '$0'
                                                }
                                            }	//if  */
                    } //if
                    FocusItem = txtBPT1_4;
                    PerformCalcsBPTlfPg1();
                    // alert('hello');
                    break;
                case "SchdA":
                    if (PrepForMath($('#lblBPT_SchC1_12').text()) == 0) {
                        $('#lblBPT_SchA_10').text(ispFormatMoney(0, 0));
                    }
                    else {
                        $('#lblBPT_SchA_10').text($('#lbl_BPT_WS5').text());
                    }
                    if (PrepForMath(txtBPT_SchB_1.value) != 0) {
                        alert('You have already filled out Schedule B. \n' + 'Click on the \'Return to Page 1\' button to preserve the Schedule B values. \n' + 'Once you enter a value on Schedule A, Schedule B will be cleared.');
                    } //if
                    sCurrWrkSht = 'SCHDA';
                    if (sPrevWrkSht == 'WRKSHTN') {
                        $('#btnAGoTo').val('Return to Worksheet N');
                        $('#btnAGoTo').click(Function('ShowPage("WrkShtN");'));
                    } else {
                        $('#btnAGoTo').val('Return to Page 1');
                        $('#btnAGoTo').click(Function('ShowPage("Pg1");'));
                    } //if
                    $('#BPT_SchdA').css('display', 'block');
                    FocusItem = txtBPT_SchA_1;
                    //SUMAN 04-03-2013 //no need to recalculate data for population
                    PerformCalcsBPTlfSchdA()
                    //----------------
                    break;
                case "SchdB":
                    if (PrepForMath(txtBPT_SchA_1.value) != 0) {
                        alert('You have already filled out Schedule A. \n' + 'Click on the \'Return to Page 1\' button to preserve the Schedule A values. \n' + 'Once you enter a value on Schedule B, Schedule A will be cleared.');
                    } //if
                    if (PrepForMath($('#lblBPT_SchC1_12').text()) == 0) {
                        $('#lblBPT_SchB_10').text(ispFormatMoney(0, 0));

                    }
                    else {
                        $('#lblBPT_SchB_10').text($('#lbl_BPT_WS5').text());
                    }
                    sCurrWrkSht = 'SCHDB';
                    if (sPrevWrkSht == 'WRKSHTN') {
                        $('#btnBGoTo').val('Return to Worksheet N');
                        $('#btnBGoTo').click(Function('ShowPage("WrkShtN");'));
                    } else {
                        $('#btnBGoTo').val('Return to Page 1');
                        $('#btnBGoTo').click(Function('ShowPage("Pg1");'));
                    } //if
                    $('#BPT_SchdB').css('display', 'block');
                    FocusItem = txtBPT_SchB_1;
                    PerformCalcsBPTlfSchdB()
                    break;
                case "SchdC1":
                    sCurrWrkSht = 'SCHDC1';

                    //alert( DisplaySchC1());
                    $('#BPT_SchdC1').css('display', 'block');
                    if (sPrevWrkSht == 'SCHDA') {

                        btnC1GoTo.value = 'Return to Schedule A';
                        btnC1GoTo.onclick = Function('ShowPage("SchdA");')
                        // $('#btnC1GoTo').live('onclick', 'javascript:ShowPage("SchdA")');
                    } else {
                        btnC1GoTo.value = 'Return to Schedule B';
                        btnC1GoTo.onclick = Function('ShowPage("SchdB");')
                        // $('#btnC1GoTo').live('onclick', 'javascript:ShowPage("SchdB")');
                    } //if
                    FocusItem = txtBPT_SchC1_1A;
                    //SUMAN : 28th jan 2014
                    //FOR DATA FETCH OPT. RECALCULATION IS NOT REQUIRED IN SECTION C
                    //PerformCalcsBPTlfSchdC1()
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
                    $('#lblBPT_SchD_10').text($('#lblBPT_SchE_15').text());
                    FocusItem = txtBPT_SchD_1;
                    PerformCalcsBPTlfSchdD();
                    break;
                case "SchdE":
                    sCurrWrkSht = 'SCHDE';
                    $('#BPT_SchdE').css('display', 'block');

                    FocusItem = lblBPT_SchE_1;
                    PerformCalcsBPTlfSchdE();
                    break;
                case "WrkShtN":
                    sCurrWrkSht = 'WRKSHTN'
                    DisplayWrkShtN()
                    break;
                case "WRKSB":

                    sCurrWrkSht = 'WRKSB';



                    $('#lbl_BPT_WS2').text($('#lblBPT_SchB_9').text());
                    $('#lbl_BPT_WS3').text($('#lblBPT_SchD_6').text());
                    btnGoToPageWS1.value = 'Return to Schedule B';
                    //$('#BPT_WorkSheetS').css('display', 'block');

                    //PerformloadingWorkSheetSb();

                    break;
                case "WRKSA":

                    sCurrWrkSht = 'WRKSA';
                    $('#lbl_BPT_WS2').text($('#lblBPT_SchA_9').text());
                    $('#lbl_BPT_WS3').text($('#lblBPT_SchD_6').text());
                    btnGoToPageWS1.value = 'Return to Schedule A';
                    //$('#BPT_WorkSheetS').css('display', 'block');

                    //PerformloadingWorkSheetSa();

                    break;

            } //switch
            if (FocusItem) {
                if ($(FocusItem).is(':disabled') == false) {
                    $(FocusItem).focus();
                } //if
            } //if
        } //ShowPage

        function LoadError() {

            var lblBPT1_1 = document.getElementById('lblBPT1_1');
            var lblBPT1_2 = document.getElementById('lblBPT1_2');
            var lblBPT1_3 = document.getElementById('lblBPT1_3');
            var txtBPT1_4 = document.getElementById('txtBPT1_4');
            var lblBPT1_4 = document.getElementById('lblBPT1_4');
            var txtBPT1_6a = document.getElementById('txtBPT1_6a');
            var txtBPT1_6b = document.getElementById('txtBPT1_6b');
            var lblBPT1_6c = document.getElementById('lblBPT1_6c');
            var lblBPT1_7 = document.getElementById('lblBPT1_7');
            var txtBPT1_8 = document.getElementById('txtBPT1_8');
            var lblBPT1_9 = document.getElementById('lblBPT1_9');
            var txtBPT1_10a = document.getElementById('txtBPT1_10a');
            var txtBPT1_10b = document.getElementById('txtBPT1_10b');
            var txtBPT1_10c = document.getElementById('txtBPT1_10c');
            var txtTermDate = document.getElementById('txtTermDate');
            var chkAgreement = document.getElementById('chkAgreement');


            var i = 0;

            //BPT_Pg1	
            arrPage1Err[i++] = [txtTermDate, txtTermDate.value != "" & ispValidateDate(txtTermDate.value) == false, 'Invalid to termination date'];
            arrPage1Err[i++] = [txtBPT1_4, txtBPT1_4.value == "", 'Answer Question 4'];
            arrPage1Err[i++] = [txtBPT1_4, ispValue(txtBPT1_4.value) == false, 'Value for Question 4 must be numeric'];
            arrPage1Err[i++] = [txtBPT1_4, ispNegativeNumber(txtBPT1_4.value) == false, 'Value for Question 4 must NOT be negative'];
            arrPage1Err[i++] = [txtBPT1_6a, txtBPT1_6a.value == "", 'Answer Question 6a'];
            arrPage1Err[i++] = [txtBPT1_6a, ispValue(txtBPT1_6a.value) == false, 'Value for Question 6a must be numeric'];
            arrPage1Err[i++] = [txtBPT1_6a, ispNegativeNumber(txtBPT1_6a.value) == false, 'Value for Question 6a must NOT be negative'];
            arrPage1Err[i++] = [txtBPT1_6b, txtBPT1_6b.value == "", 'Answer Question 6b'];
            arrPage1Err[i++] = [txtBPT1_6b, ispValue(txtBPT1_6b.value) == false, 'Value for Question 6b must be numeric'];
            arrPage1Err[i++] = [txtBPT1_6b, ispNegativeNumber(txtBPT1_6b.value) == false, 'Value for Question 6b must NOT be negative'];
            arrPage1Err[i++] = [txtBPT1_8, txtBPT1_8.value == "", 'Answer Question 8'];
            arrPage1Err[i++] = [txtBPT1_8, ispValue(txtBPT1_8.value) == false, 'Value for Question 8 must be numeric'];
            arrPage1Err[i++] = [txtBPT1_8, ispNegativeNumber(txtBPT1_8.value) == false, 'Value for Question 8 must NOT be negative'];
            //EGOVWEB-60 Added error section for txtBPT1_10a
            arrPage1Err[i++] = [txtBPT1_10a, txtBPT1_10a.value == "", 'Answer Question 10a'];
            arrPage1Err[i++] = [txtBPT1_10a, ispValue(txtBPT1_10a.value) == false, 'Value for Question 10a must be numeric'];
            arrPage1Err[i++] = [txtBPT1_10a, ispNegativeNumber(txtBPT1_10a.value) == false, 'Value for Question 10a must NOT be negative'];
            arrPage1Err[i++] = [txtBPT1_10b, txtBPT1_10b.value == "", 'Answer Question 10b'];
            arrPage1Err[i++] = [txtBPT1_10b, ispValue(txtBPT1_10b.value) == false, 'Value for Question 10b must be numeric'];
            arrPage1Err[i++] = [txtBPT1_10b, ispNegativeNumber(txtBPT1_10b.value) == false, 'Value for Question 10b must NOT be negative'];
            arrPage1Err[i++] = [txtBPT1_10c, txtBPT1_10c.value == "", 'Answer Question 10c'];
            arrPage1Err[i++] = [txtBPT1_10c, ispValue(txtBPT1_10c.value) == false, 'Value for Question 10c must be numeric'];
            arrPage1Err[i++] = [txtBPT1_10c, ispNegativeNumber(txtBPT1_10c.value) == false, 'Value for Question 10c must NOT be negative'];
            //BPT_SchdA
            LoadErrorBPTlfSchdA();
            //BPT_SchdB
            LoadErrorBPTlfSchdB();
            //BPT_SchdC1
            LoadErrorBPTlfSchdC1();
            //BPT_SchdD
            LoadErrorBPTlfSchdD();
            //BPT_SchdE
            LoadErrorBPTlfSchdE();
            //WorkSheetS
            //LoadErrorBPTlfWorkSheetS();
        } //LoadError

        function PopulateXmlBPTlf() {

            var lblBPT1_1 = document.getElementById('lblBPT1_1');
            var lblBPT1_2 = document.getElementById('lblBPT1_2');
            var lblBPT1_3 = document.getElementById('lblBPT1_3');
            var txtBPT1_4 = document.getElementById('txtBPT1_4');
            var lblBPT1_4 = document.getElementById('lblBPT1_4');
            var txtBPT1_6a = document.getElementById('txtBPT1_6a');
            var txtBPT1_6b = document.getElementById('txtBPT1_6b');
            var lblBPT1_6c = document.getElementById('lblBPT1_6c');
            var lblBPT1_7 = document.getElementById('lblBPT1_7');
            var txtBPT1_8 = document.getElementById('txtBPT1_8');
            var lblBPT1_9 = document.getElementById('lblBPT1_9');
            var txtBPT1_10a = document.getElementById('txtBPT1_10a');
            var txtBPT1_10b = document.getElementById('txtBPT1_10b');
            var txtBPT1_10c = document.getElementById('txtBPT1_10c');
            var txtTermDate = document.getElementById('txtTermDate');
            var chkAgreement = document.getElementById('chkAgreement');
            var txtBPT_SchA_1 = document.getElementById('txtBPT_SchA_1');

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, '12/31/' + (sCurrYear - 1), xFldInfPeriod, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT1_1').text()), xFldPg1Li1, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT1_2').text()), xFldPg1Li2, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT1_3').text()), xFldPg1Li3, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT1_4.value), xFldPg1Li4, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT1_5').text()), xFldPg1Li5, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT1_6a.value), xFldPg1Li6, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT1_6b.value), xFldPg1Li7, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT1_6c').text()), xFldPg1Li8, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT1_7').text()), xFldPg1Li9, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT1_8.value), xFldPg1Li10, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT1_9').text()), xFldPg1Li11, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT1_10a.value), xFldPg1Li12, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT1_10b.value), xFldPg1Li13, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT1_10c.value), xFldPg1Li14, '', 0);

            //BPT_SchdA
            if ($('#lblLnkSchdA').is(':disabled') == true || PrepForMath(txtBPT_SchA_1.value) == 0) {
                ClearBPTlfSchdA();
            } else {
                PopulateXmlBPTlfSchdA();
            } //if
            //BPT_SchdB
            if ($('#lblLnkSchdB').is(':disabled') == true || PrepForMath(txtBPT_SchB_1.value) == 0) {
                ClearBPTlfSchdB();
            } else {
                PopulateXmlBPTlfSchdB();
            } //if
            //BPT_SchdC1
            PopulateXmlBPTlfSchdC1();
            //BPT_SchdD
            PopulateXmlBPTlfSchdD();
            //BPT_SchdE
            PopulateXmlBPTlfSchdE();
            //WorkSheet
            // PopulateXmlWorkSheetS();
            PopulatePreparerXML(parent.$g.xmlBPTlf, xSecInfo);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, '', 'DEBUG', '', 0);
        } //PopulateXmlBPTlf

        function ValidateWorksheet(formId) {
            var txtPercentage = document.getElementById('txtPercentage');
            var lblBPT1_1 = document.getElementById('lblBPT1_1');
            var lblBPT1_2 = document.getElementById('lblBPT1_2');
            var lblBPT1_3 = document.getElementById('lblBPT1_3');
            var txtBPT1_4 = document.getElementById('txtBPT1_4');
            var lblBPT1_4 = document.getElementById('lblBPT1_4');
            var txtBPT1_6a = document.getElementById('txtBPT1_6a');
            var txtBPT1_6b = document.getElementById('txtBPT1_6b');
            var lblBPT1_6c = document.getElementById('lblBPT1_6c');
            var lblBPT1_7 = document.getElementById('lblBPT1_7');
            var txtBPT1_8 = document.getElementById('txtBPT1_8');
            var lblBPT1_9 = document.getElementById('lblBPT1_9');
            var txtBPT1_10a = document.getElementById('txtBPT1_10a');
            var txtBPT1_10b = document.getElementById('txtBPT1_10b');
            var txtBPT1_10c = document.getElementById('txtBPT1_10c');
            var txtTermDate = document.getElementById('txtTermDate');
            var chkAgreement = document.getElementById('chkAgreement');
            var txtBPT_SchA_1 = document.getElementById('txtBPT_SchA_1');

            //var sId = document.activeElement.id
            var ObjSelected = getActiveElement();

            $(parent.AppError).text('');
            if (ObjSelected) {
                if (ObjSelected.id == txtPercentage) {
                    //Do nothing
                } else if (ObjSelected.id != "") {
                    if (ObjSelected.type != 'button') {
                        ObjSelected.value = ispFormatMoney(ObjSelected.value, 0);
                    }
                }
            }


            switch (formId) {

                case "BPT_Pg1":
                    $(parent.AppError).text(ispSetInputErr(arrPage1Err));
                    PerformCalcsBPTlfPg1();
                    break;
                case "BPT_SchdA":
                    $(parent.AppError).text(ispSetInputErr(arrSchdAErr));
                    PerformCalcsBPTlfSchdA();
                    break;
                case "BPT_SchdB":
                    $(parent.AppError).text(ispSetInputErr(arrSchdBErr));
                    PerformCalcsBPTlfSchdB();
                    break;
                case "BPT_SchdC1":
                    $(parent.AppError).text(ispSetInputErr(arrSchdC1Err));
                    PerformCalcsBPTlfSchdC1();
                    break;
                case "BPT_SchdD":

                    $(parent.AppError).text(ispSetInputErr(arrSchdDErr));

                    if (PrepForMath(txtBPT_SchD_7.value) > PrepForMath($("#lblBPT_SchD_6").text())) {
                        if (PrepForMath(txtBPT_SchD_7.value) != 50000) {
                            $(parent.AppError).text('Line 7 value must be lower of Line 6 of Schedule D or $50,000');

                        }


                    }


                    PerformCalcsBPTlfSchdD();
                    if (ObjSelected.id == 'txtBPT_SchD_7' && PrepForMath(ObjSelected.value) > 0) {
                        alert('You have entered or changed an amount greater then 0 on line 7. \n' + 'You will have to fill out Schedule E');
                    } //if
                    break;
                case "BPT_SchdE":
                    $(parent.AppError).text(ispSetInputErr(arrSchdEErr));
                    PerformCalcsBPTlfSchdE();
                    break;
                case "BPT_WorkSheetS":

                    var tempcal = PrepForMath($('#lbl_BPT_WS4').text() + txt_BPT_WS4.value);
                    $(parent.AppError).text(ispSetInputErr(arrWorkSheetSErr));
                    if (PrepForMath(txt_BPT_WS1.value) > PrepForMath($("#lblBPT_SchD_6").text())) {
                        if (PrepForMath(txt_BPT_WS1.value) != 50000) {
                            $(parent.AppError).text('S1 value must be lower of Line 6 of Schedule D or $50,000');
                        }

                    }
                    if (tempcal > PrepForMath(txt_BPT_WS1.value)) {
                        $(parent.AppError).text('Value for Line 4 cannot be greater than line1');
                    }


                    // Performvalidationandload();
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
            var lblBPT1_1 = document.getElementById('lblBPT1_1');
            var lblBPT1_2 = document.getElementById('lblBPT1_2');
            var lblBPT1_3 = document.getElementById('lblBPT1_3');
            var txtBPT1_4 = document.getElementById('txtBPT1_4');
            var lblBPT1_4 = document.getElementById('lblBPT1_4');
            var txtBPT1_6a = document.getElementById('txtBPT1_6a');
            var txtBPT1_6b = document.getElementById('txtBPT1_6b');
            var lblBPT1_6c = document.getElementById('lblBPT1_6c');
            var lblBPT1_7 = document.getElementById('lblBPT1_7');
            var txtBPT1_8 = document.getElementById('txtBPT1_8');
            var lblBPT1_9 = document.getElementById('lblBPT1_9');
            var txtBPT1_10a = document.getElementById('txtBPT1_10a');
            var txtBPT1_10b = document.getElementById('txtBPT1_10b');
            var txtTermDate = document.getElementById('txtTermDate');
            var chkAgreement = document.getElementById('chkAgreement');

            CalcBPTlfPg1Line3();
            CalcBPTlfPg1Line5();
            CalcBPTlfPg1Line6c();
            CalcBPTlfPg1Line7();
            //EGOVWEB-60 rewrite CalcBPTlfPg1Line9 and CalcBPTlfPg1Line10a into CalcBPTlfPg1Line9_10
            CalcBPTlfPg1Line9_10();
            // nFlowCalc();  //binoy

        } //PerformCalcsBPTlfPg1

        function CalcBPTlfPg1Line3() {

            var lblBPT1_1 = document.getElementById('lblBPT1_1');
            var lblBPT1_2 = document.getElementById('lblBPT1_2');
            var lblBPT1_3 = document.getElementById('lblBPT1_3');
            var txtBPT1_4 = document.getElementById('txtBPT1_4');
            var lblBPT1_4 = document.getElementById('lblBPT1_4');
            var txtBPT1_6a = document.getElementById('txtBPT1_6a');
            var txtBPT1_6b = document.getElementById('txtBPT1_6b');
            var lblBPT1_6c = document.getElementById('lblBPT1_6c');
            var lblBPT1_7 = document.getElementById('lblBPT1_7');
            var txtBPT1_8 = document.getElementById('txtBPT1_8');
            var lblBPT1_9 = document.getElementById('lblBPT1_9');
            var txtBPT1_10a = document.getElementById('txtBPT1_10a');
            var txtBPT1_10b = document.getElementById('txtBPT1_10b');
            var txtTermDate = document.getElementById('txtTermDate');
            var chkAgreement = document.getElementById('chkAgreement');

            //Suman 18 Dec 2013: there will be no calculation for line 4 as for 2013 user can enter any value on line 4
            //Suman 3th jan 2014: CR requested is reverted.
            if ($('#lblBPT1_1').text() != '' && $('#lblBPT1_2').text() != '') {
                $('#lblBPT1_3').text(ispFormatMoney(PrepForMath($('#lblBPT1_1').text()) + PrepForMath($('#lblBPT1_2').text()), 0));
                if (b_txtBPT1_4 == false && PrepForMath($('#lblBPT1_3').text()) != 0) {
                    //EGOVWEB-65 - Added if statement
                    //EGOVWEB-73 - Estimate payment not being set to mainframe
                    //EGOVWEB-96 - Line 4 being loaded from Line 1 on Schedule D
                    if ($('#txtBPT1_4').is(':disabled') == false && $('#BPT_Pg1').css('display') == 'block') {
                        //if (document.activeElement.id != 'txtBPT1_4') {
                        if (getActiveElement().id != 'txtBPT1_4') {
                            txtBPT1_4.value = $('#lblBPT1_3').text();
                        }
                    } else {
                        if (txtBPT1_4.value == '') {
                            txtBPT1_4.value = ispFormatMoney(0, 0);
                        } //if
                    } //if
                    //EGOVWEB-65 - Added the check for disabled
                } else if (b_txtBPT1_4 == true && PrepForMath($('#lblBPT1_3').text()) != 0 && PrepForMath(txtBPT1_4.value) == 0 && $('#txtBPT1_4').is(':disabled') == false) {

                }
            }
        }

        function CalcBPTlfPg1Line5() {
            var txtBPT1_4 = document.getElementById('txtBPT1_4');

            if (txtBPT1_4.value != '') {
                $('#lblBPT1_5').text(ispFormatMoney(PrepForMath($('#lblBPT1_3').text()) + PrepForMath(txtBPT1_4.value), 0));
            } //if
        } //CalcBPTlfPg1Line5

        function CalcBPTlfPg1Line6c() {
            var txtBPT1_6a = document.getElementById('txtBPT1_6a');
            var txtBPT1_6b = document.getElementById('txtBPT1_6b');

            if (txtBPT1_6a.value != '' && txtBPT1_6b.value != '') {
                $('#lblBPT1_6c').text(ispFormatMoney(PrepForMath(txtBPT1_6a.value) + PrepForMath(txtBPT1_6b.value), 0));
            } //if
        } //CalcBPTlfPg1Line6c

        function CalcBPTlfPg1Line7() {

            if ($('#lblBPT1_5').text() != '' && $('#lblBPT1_6c').text() != '') {
                $('#lblBPT1_7').text(ispFormatMoney(PrepForMath($('#lblBPT1_5').text()) - PrepForMath($('#lblBPT1_6c').text()), 0));
                /* SUMAN -- if (PrepForMath($('#lblBPT1_7').text()) < 0) {
                                $('#lblBPT1_7').text( ispFormatMoney(0, 0));
                            }	SUMAN*/
            }
        }

        //EGOVWEB-60 rewrite CalcBPTlfPg1Line9 and CalcBPTlfPg1Line10a into CalcBPTlfPg1Line9_10

        function CalcBPTlfPg1Line9_10() {
            var lblBPT1_1 = document.getElementById('lblBPT1_1');
            var lblBPT1_2 = document.getElementById('lblBPT1_2');
            var lblBPT1_3 = document.getElementById('lblBPT1_3');
            var txtBPT1_4 = document.getElementById('txtBPT1_4');
            var lblBPT1_4 = document.getElementById('lblBPT1_4');
            var txtBPT1_6a = document.getElementById('txtBPT1_6a');
            var txtBPT1_6b = document.getElementById('txtBPT1_6b');
            var lblBPT1_6c = document.getElementById('lblBPT1_6c');
            var lblBPT1_7 = document.getElementById('lblBPT1_7');
            var txtBPT1_8 = document.getElementById('txtBPT1_8');
            var lblBPT1_9 = document.getElementById('lblBPT1_9');
            var txtBPT1_10a = document.getElementById('txtBPT1_10a');
            var txtBPT1_10b = document.getElementById('txtBPT1_10b');
            var txtBPT1_10c = document.getElementById('txtBPT1_10c');
            var txtTermDate = document.getElementById('txtTermDate');
            var chkAgreement = document.getElementById('chkAgreement');

            if ($('#lblBPT1_7').text() != '' && txtBPT1_8.value != '') {
                $('#lblBPT1_9').text(ispFormatMoney(PrepForMath($('#lblBPT1_7').text()) + PrepForMath(txtBPT1_8.value), 0));
            } //if
            $('#txtBPT1_8').removeAttr('disabled');
            if ($('#lblBPT1_9').text() != '') {
                if (PrepForMath($('#lblBPT1_9').text()) < 0) {
                    $('#txtBPT1_8').attr('disabled', 'disable');
                    if (txtBPT1_10a.value == '') {
                        txtBPT1_10a.value = ispFormatMoney(0, 0);
                    } //if
                    if (txtBPT1_10b.value == '') {
                        txtBPT1_10b.value = ispFormatMoney(0, 0);
                    } //if
                    if (txtBPT1_10c.value == '') {
                        txtBPT1_10c.value = ispFormatMoney(0, 0);
                    } //if
                    if (PrepForMath(txtBPT1_10a.value) + PrepForMath(txtBPT1_10b.value) + PrepForMath(txtBPT1_10c.value) != Math.abs(PrepForMath($('#lblBPT1_7').text()))) {
                        $(parent.AppError).text('Lines 10a, 10b and 10c must equal Line 7');
                    } //if
                    $('#lblBPT1_9').text(ispFormatMoney(0, 0));
                } else {
                    txtBPT1_10a.value = ispFormatMoney(0, 0);
                    txtBPT1_10b.value = ispFormatMoney(0, 0);
                    txtBPT1_10c.value = ispFormatMoney(0, 0);
                }
            }
        }

        function nFlowCalc() {

            var txtBPT1_10a = document.getElementById('txtBPT1_10a');
            var txtBPT1_10b = document.getElementById('txtBPT1_10b');
            var txtBPT1_10c = document.getElementById('txtBPT1_10c');

            var l5val = PrepForMath($('#lblBPT1_5').text());
            var l6cval = PrepForMath($('#lblBPT1_6c').text())

            var l10a_val, l10b_val, l10c_val;
            l10a_val = PrepForMath(txtBPT1_10a.value);
            l10b_val = PrepForMath(txtBPT1_10b.value);
            l10c_val = PrepForMath(txtBPT1_10c.value);

            var nval = l5val - l6cval;

            var bval = 0;
            if (nval < 0) {
                bval = nval + l10a_val + l10b_val + l10c_val;
                $('#lblBPT1_7').text(ispFormatMoney(bval, 0));
                if (bval != 0) {
                    $(parent.AppError).text('Lines 10a, 10b and 10c must equal Line 7');
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
            alert(stripCurrency('0.00'));
        }
    </script>
</head>

<body>
    <div class="container-fluid no-padding">
        <div class="block3">

            <div class="container-fluid">

                <div class="row">

                    <div class="col-lg-12 col-md-12">

                        <div class="blue_base_box">
                            <h2><span id="AppHeader">&nbsp;</span>  </h2>

                            <div class="inner_white-panel">

                                <div class="contentsection">
                                    <h4 id="AppMessage">&nbsp;</h4>
                                    <div class="clearfix"></div>
                                    <div class="row">
                                        <!-- Tax Payer General Info Form -->

                                        <div class="col-lg-12">

                                            <div class="well">

                                                <div class="row">
                                                    <form>
                                                        <div class="col-lg-4">
                                                            <p>
                                                                <strong>Name :</strong>
                                                                <label id="lblName" class="lblTextBlack"></label>
                                                            </p>
                                                        </div>

                                                        <div class="col-lg-4">
                                                            <p>
                                                                <strong><font id="lblAccountType">Account No. :</font></strong>
                                                                <label id="lblAccountId" class="lblTextBlack"></label>
                                                            </p>
                                                        </div>

                                                    </form>
                                                </div>

                                                <div class="row">
                                                    <div class="col-lg-4">
                                                        <p>
                                                            <strong>Address :</strong>
                                                            <label id="lblAddress" class="lblTextBlack"></label>
                                                        </p>
                                                    </div>
                                                    <div class="col-lg-4">
                                                        <p>
                                                            <strong><font id="lblEntityType">EIN :</font></strong>
                                                            <label id="lblEntityId" class="lblTextBlack"></label>
                                                        </p>
                                                    </div>
                                                </div>
                                                <div class="clearfix"></div>

                                            </div>
                                        </div>
                                        <!-- Tax Payer General Info Form END -->

                                        <!---------------------------------->

                                      <div class="col-lg-12 col-md-12" id="BPT_Pg1">    
                                          <div class="row" >

                                            <div class="col-lg-12 templateclass">
                                                <form class="form-horizontal">
                                                    <%--         <div class="row form-group topsmallform">
                                <div class="col-sm-10">
                                  <div class="checkbox">
                                    <label class="no-padding">
                                       <input id=chkAmended type=checkbox onclick="chkAmended_onclick()" type="checkbox" />
                                            Check if amended return.
                                    </label>
                                  </div>
                                </div>
                              </div>
                              <div class="form-group">
                                <label class="col-sm-8">If your business terminated in 
				                    <script>document.write(sCurrYear - 1)</script>,
					                    enter the termination date here <u>AND</u> file a <a href="http://www.phila.gov/revenue/pdfs/chgform.html" >CHANGE FORM</a>.</label>
                                <div class="col-sm-4">
                                 <input class="" id=txtTermDate onfocus="SetFocus()" onblur="return txtTermDate_onblur()">
				 s	
                                </div>
                              </div>--%>
                                                    <div class="row form-group topsmallform">

                                                        <div class="col-sm-3 newtop_padding">
                                                            <label class="radio" style="font-weight: bold;">
                                                                <input id="chkAmended_08" type="checkbox" onclick="chkAmended_08_onclick()" type="checkbox" />
                                                                Check if amended return.</label>
                                                        </div>
                                                        <div>

                                                            <%--   <div class="clearfix"></div>--%>
                                                        </div>

                                                    </div>
                                                    <div class="row">
                                                        <div class="col-sm-9">
                                                            <label class="control-label text-custom-left2" for="inputEmail3">
                                                                <span class="pull-left">If your business terminated in 
				                    <script>document.write(sCurrYear - 1)</script>
                                                                    ,
					                    enter the termination date here <u>AND</u> file a <a href="http://www.phila.gov/revenue/pdfs/chgform.html">CHANGE FORM</a>.</span>

                                                            </label>
                                                        </div>
                                                        <div class="col-sm-3">
                                                            <input class="" id="txtTermDate" onfocus="SetFocus()" onblur="return txtTermDate_onblur()">
                                                        </div>
                                                    </div>
                                                </form>

                                                <!----------------------------------->
                                                <div class="row table-responsive">
                                                    <div class="col-lg-12">



                                                        <table class="table table-condensed table-striped custom_table03">

                                                            <thead>
                                                                <tr>
                                                                    <th colspan="3" width="100%">COMPUTATION OF TAX DUE OR OVERPAYMENT</th>

                                                                </tr>

                                                            </thead>

                                                            <tbody>

                                                                <tr>
                                                                    <td width="5%">1.</td>
                                                                    <td width="70%" class="text-left">NET INCOME PORTION OF TAX (from 
                                                <label id="lblLnkSchdB" class="lblLink label_NoLeft" style="width: 100%" onclick="ShowPage('SchdB')">Schedule B, Line 13</label>
                                                                        or 
			                                    <label id="lblLnkSchdA" class="lblLink label_NoLeft" style="width: 100%" onclick="ShowPage('SchdA')">Schedule A, Line 13</label>
                                                                        <label id="lblLnkSchdN1" style="display: none"></label>
                                                                        ).
                                                                    </td>
                                                                    <td width="25%" class="text-left">
                                                                        <form class="form-horizontal">

                                                                            <div class="form-group no-margin">
                                                                                <div class="">
                                                                                    <label id="lblBPT1_1" style="width: 100%" class="form-control input-sm"></label>
                                                                                </div>
                                                                            </div>

                                                                        </form>
                                                                    </td>
                                                                </tr>
                                                                <tr class="odd">
                                                                    <td width="5%">2.</td>
                                                                    <td width="70%" class="text-left">GROSS RECEIPTS PORTION OF TAX (from
                                                <label class="lblLink label_NoLeft" style="width: 100%" onclick="ShowPage('SchdD')">Schedule D, Line 12</label>
                                                                        <label id="lblLnkSchdN2" style="display: none"></label>
                                                                        ).</td>
                                                                    <td width="25%" class="text-left">
                                                                        <form class="form-horizontal">

                                                                            <div class="form-group no-margin">
                                                                                <div class="">
                                                                                    <label id="lblBPT1_2" style="width: 100%" class="form-control input-sm"></label>
                                                                                </div>
                                                                            </div>

                                                                        </form>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td width="5%">3.</td>
                                                                    <td width="70%" class="text-left">Tax Due for the 2011 Business Income & Receipts Tax[Calculated - add lines 1 and 2] </td>
                                                                    <td width="25%" class="text-left">
                                                                        <form class="form-horizontal">

                                                                            <div class="form-group no-margin">
                                                                                <div class="">
                                                                                    <label id="lblBPT1_3" style="width: 100%" class="form-control input-sm"></label>
                                                                                </div>
                                                                        </form>
                                                                    </td>
                                                                </tr>
                                                                <tr class="odd">
                                                                    <td width="5%">4.</td>
                                                                    <td width="70%" class="text-left"><b><u>MANDATORY</u> 2015 BIRT Estimated Payment <u>(repeat line 3)</u> </b>)</td>
                                                                    <td width="25%" class="text-left">
                                                                        <form class="form-horizontal">
                                                                            <input class="form-control input-sm" id="txtBPT1_4" onchange="ValidateWorksheet('BPT_Pg1')" onkeyup="Pg1L4Keyup()"
                                                                                onfocus="SetFocus()" maxlength="10">
                                                                            <div class="form-group no-margin">
                                                                                <div class="">
                                                                                    <input type="text" class="form-control input-sm" onfocus="SetFocus()" maxlength="10">
                                                                                </div>
                                                                            </div>

                                                                        </form>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td width="5%">5.</td>
                                                                    <td width="70%" class="text-left">Total Due by <b>4/15/2013</b>[Calculated - add lines 3 and 4]</td>
                                                                    <td width="25%" class="text-left">
                                                                        <form class="form-horizontal">

                                                                            <div class="form-group no-margin">
                                                                                <div class="">
                                                                                    <label id="lblBPT1_4" style="width: 100%" class="form-control input-sm"></label>
                                                                                </div>
                                                                            </div>

                                                                        </form>
                                                                    </td>
                                                                </tr>


                                                            </tbody>

                                                            <thead>
                                                                <tr>
                                                                    <th colspan="3" width="100%"><u><b>ESTIMATED PAYMENTS AND OTHER CREDITS</b></u></th>

                                                                </tr>

                                                            </thead>

                                                            <tbody>

                                                                <tr>
                                                                    <td width="5%">6a.</td>
                                                                    <td width="70%" class="text-left">Credit from overpayment of 2010 or 2011 Net Profit Tax</td>
                                                                    <td width="25%" class="text-left">
                                                                        <form class="form-horizontal">

                                                                            <div class="form-group no-margin">
                                                                                <div class="">
                                                                                    <input id="txtBPT1_6a" class="form-control input-sm" onchange="ValidateWorksheet('BPT_Pg1')"
                                                                                        onfocus="SetFocus()">
                                                                                </div>
                                                                            </div>

                                                                        </form>
                                                                    </td>
                                                                </tr>
                                                                <tr class="odd">
                                                                    <td width="5%">6b.</td>
                                                                    <td width="70%" class="text-left">Include any estimated and/or extension payments of 2011 BIRT previously
			  made,<br>
                                                                        and any credit from overpayment of the 2010 BPT return</td>
                                                                    <td width="25%" class="text-left">
                                                                        <form class="form-horizontal">

                                                                            <div class="form-group no-margin">
                                                                                <div class="">
                                                                                    <input id="txtBPT1_6b" class="form-control input-sm" onchange="ValidateWorksheet('BPT_Pg1')"
                                                                                        onfocus="SetFocus()" maxlength="10">
                                                                                </div>
                                                                            </div>

                                                                        </form>
                                                                    </td>
                                                                </tr>
                                                                <%--<tr>
                                                                    <td width="5%">6c.</td>
                                                                    <td width="70%" class="text-left">Total Payments and Credits[Calculated - add lines 6a and 6b]</td>
                                                                    <td width="25%" class="text-left">
                                                                        <form class="form-horizontal">

                                                                            <div class="form-group no-margin">
                                                                                <div class="">
                                                                                    <label id="lblBPT1_6c" style="width: 100%"></label>
                                                                                </div>

                                                                            </div>
                                                                        </form>
                                                                    </td>
                                                                </tr>--%>

                                                                <tr>
                                                                    <td width="5%">6c.</td>
                                                                    <td width="70%" class="text-left">Total Payments and Credits[Calculated - add lines 6a and 6b]</td>
                                                                    <td width="25%" class="text-left">
                                                                        <form class="form-horizontal">

                                                                            <div class="form-group no-margin">
                                                                                <div class="">
                                                                                    <label id="lblBPT1_6c" class="form-control input-sm" style="width: 100%"></label>
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
                                                                                    <label id="lblBPT1_7" style="width: 100%" class="form-control input-sm"></label>
                                                                                </div>
                                                                            </div>

                                                                        </form>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td width="5%">8.</td>
                                                                    <td width="70%" class="text-left">Interest and Penalty (see instruction Sheet II)</td>
                                                                    <td width="25%" class="text-left">
                                                                        <form class="form-horizontal">

                                                                            <div class="form-group no-margin">
                                                                                <div class="">
                                                                                    <input id="txtBPT1_8" onchange="ValidateWorksheet('BPT_Pg1')"
                                                                                        onfocus="SetFocus()" class="form-control input-sm">
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
                                                                                    <label id="lblBPT1_9" style="width: 100%" class="form-control input-sm"></label>
                                                                                </div>
                                                                            </div>

                                                                        </form>
                                                                    </td>
                                                                </tr>


                                                            </tbody>

                                                            <thead>
                                                                <tr>
                                                                    <th colspan="3" width="100%">OVERPAYMENT OPTIONS</th>

                                                                </tr>

                                                            </thead>

                                                            <tbody>

                                                                <tr>
                                                                    <td width="5%">10a.</td>
                                                                    <td width="70%" class="text-left">Refunded. <b>Do not file separate Refund Petition</b></td>
                                                                    <td width="25%" class="text-left">
                                                                        <form class="form-horizontal">

                                                                            <div class="form-group no-margin">
                                                                                <div class="">
                                                                                    <input id="txtBPT1_10a" class="form-control input-sm" onchange="ValidateWorksheet('BPT_Pg1')"
                                                                                        onfocus="SetFocus()">
                                                                                </div>
                                                                            </div>

                                                                        </form>
                                                                    </td>
                                                                </tr>
                                                                <tr class="odd">
                                                                    <td width="5%">10b.</td>
                                                                    <td width="70%" class="text-left">Applied, up to the tax due,	to the 2011 Net Profits Tax Return</td>
                                                                    <td width="25%" class="text-left">
                                                                        <form class="form-horizontal">

                                                                            <div class="form-group no-margin">
                                                                                <div class="">
                                                                                    <input id="txtBPT1_10b" class="form-control input-sm" onchange="ValidateWorksheet('BPT_Pg1')"
                                                                                        onfocus="SetFocus()">
                                                                                </div>
                                                                            </div>

                                                                        </form>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td width="5%">10c.</td>
                                                                    <td width="70%" class="text-left">Applied to the 2012 Business Income & Receipts Tax</td>
                                                                    <td width="25%" class="text-left">
                                                                        <form class="form-horizontal">

                                                                            <div class="form-group no-margin">
                                                                                <div class="">
                                                                                    <input id="txtBPT1_10c" class="form-control input-sm" onchange="ValidateWorksheet('BPT_Pg1')"
                                                                                        onfocus="SetFocus()">
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

                                                <form class="form-horizontal school_form">
                                                    <div>
                                                        <%
                                                            Html.RenderAction("PreparerSection", "INC");   
                                                        %>
                                                    </div>
                                                    <div class="form-group">
                                                        <div class="col-sm-offset-3 col-sm-9  text-right">
                                                            <input type="button" value="Print" class="btn btn-default submit_button" onclick="parent.doPrintDocWin()" />
                                                            <input type="button" value="Submit" class="btn btn-default submit_button" id="btnBPTSubmit" onclick="btnSchoolValidate();
    ispDisplayProgress('btnSchool08Submit_onclick()', 'Submitting 2013 school tax information')" />
                                                        </div>
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
                                          <% 
                    Html.RenderAction("_11SchdE", "BPT_LF");
                    Html.RenderAction("_11SchdD", "BPT_LF");
                    Html.RenderAction("_11SchdB", "BPT_LF");
                    Html.RenderAction("_11SchdA", "BPT_LF");
                    Html.RenderAction("_11SchdC1", "BPT_LF");


                    Html.RenderAction("_14WorkSheet5", "BPT_LF");

    // Html.RenderAction("_14SchdE", "BPT_LF");
             
             
                %>
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
</body>
</html>
