﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

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
    <script language='javascript' type="text/javascript">
             var arrSchdDErr = new Array();
             var xSecScD = 'BPT_SCH_D ';
             var xFldScDLi1 = xSecScD + 'GR_SALES';
             var xFldScDLi2 = xSecScD + 'GR_SERVICES';
             var xFldScDLi3 = xSecScD + 'GR_RENTALS';
             var xFldScDLi4 = xSecScD + 'GR_TOTALS';
             var xFldScDLi5a = xSecScD + 'LE_SALES_OUT';
             var xFldScDLi5b = xSecScD + 'LE_SERVICES_OUT';
             var xFldScDLi5c = xSecScD + 'LE_RENTALS_OUT';
             var xFldScDLi5d = xSecScD + 'LE_OTHER';
             var xFldScDLi6 = xSecScD + 'NET_TAXABLE_RECEIPTS';
             var xFldScDLi7 = xSecScD + 'STAT_EXCLUSION_D_X';
             var xFldScDLi8 = xSecScD + 'LE_TOTAL';
             var xFldScDLi9 = xSecScD + 'TAXABLE_RECEIPTS'
             var xFldScDLi10 = xSecScD + 'TAX_DUE';
             var xFldScDLi11 = xSecScD + 'TAX_DUE_ALT';
             var xFldScDLi12 = xSecScD + 'TOTAL_TAX_DUE';

             function LoadErrorBPTlfSchdD() {

                 var txtBPT_SchD_1 = document.getElementById('txtBPT_SchD_1');
                 var txtBPT_SchD_2 = document.getElementById('txtBPT_SchD_2');
                 var txtBPT_SchD_3 = document.getElementById('txtBPT_SchD_3');
                 var lblBPT_SchD_4 = document.getElementById('lblBPT_SchD_4');
                 var txtBPT_SchD_5A = document.getElementById('txtBPT_SchD_5A');
                 var txtBPT_SchD_5B = document.getElementById('txtBPT_SchD_5B');
                 var txtBPT_SchD_5C = document.getElementById('txtBPT_SchD_5C');
                 var txtBPT_SchD_5D = document.getElementById('txtBPT_SchD_5D');
                 var lblBPT_SchD_6 = document.getElementById('lblBPT_SchD_6');
                 var txtBPT_SchD_7 = document.getElementById('txtBPT_SchD_7');
                 var txtBPT_SchD_8 = document.getElementById('txtBPT_SchD_8');
                 var lblBPT_SchD_9 = document.getElementById('lblBPT_SchD_9');
                 var lblBPT_SchD_10 = document.getElementById('lblBPT_SchD_10');
                 var lblBPT_SchD_11 = document.getElementById('lblBPT_SchD_11');
                 var lblBPT_SchD_12 = document.getElementById('lblBPT_SchD_12');

                 var i = 0;
                 arrSchdDErr[i++] = [txtBPT_SchD_1, txtBPT_SchD_1.value == "", 'Answer Question 1'];
                 arrSchdDErr[i++] = [txtBPT_SchD_1, ispValue(txtBPT_SchD_1.value) == false, 'Value for Question 1 must be numeric'];
                 arrSchdDErr[i++] = [txtBPT_SchD_1, ispNegativeNumber(txtBPT_SchD_1.value) == false, 'Value for Question 1 must NOT be negative'];
                 arrSchdDErr[i++] = [txtBPT_SchD_2, txtBPT_SchD_2.value == "", 'Answer Question 2'];
                 arrSchdDErr[i++] = [txtBPT_SchD_2, ispValue(txtBPT_SchD_2.value) == false, 'Value for Question 2 must be numeric'];
                 arrSchdDErr[i++] = [txtBPT_SchD_2, ispNegativeNumber(txtBPT_SchD_2.value) == false, 'Value for Question 2 must NOT be negative'];
                 arrSchdDErr[i++] = [txtBPT_SchD_3, txtBPT_SchD_3.value == "", 'Answer Question 3']
                 arrSchdDErr[i++] = [txtBPT_SchD_3, ispValue(txtBPT_SchD_3.value) == false, 'Value for Question 3 must be numeric'];
                 arrSchdDErr[i++] = [txtBPT_SchD_3, ispNegativeNumber(txtBPT_SchD_3.value) == false, 'Value for Question 3 must NOT be negative'];
                 arrSchdDErr[i++] = [txtBPT_SchD_5A, txtBPT_SchD_5A.value == "", 'Answer Question 5a'];
                 arrSchdDErr[i++] = [txtBPT_SchD_5A, ispValue(txtBPT_SchD_5A.value) == false, 'Value for Question 5a must be numeric'];
                 arrSchdDErr[i++] = [txtBPT_SchD_5A, ispNegativeNumber(txtBPT_SchD_5A.value) == false, 'Value for Question 5a must NOT be negative'];
                 arrSchdDErr[i++] = [txtBPT_SchD_5B, txtBPT_SchD_5B.value == "", 'Answer Question 5b'];;
                 arrSchdDErr[i++] = [txtBPT_SchD_5B, ispValue(txtBPT_SchD_5B.value) == false, 'Value for Question 5b must be numeric'];
                 arrSchdDErr[i++] = [txtBPT_SchD_5B, ispNegativeNumber(txtBPT_SchD_5B.value) == false, 'Value for Question 5b must NOT be negative'];
                 arrSchdDErr[i++] = [txtBPT_SchD_5C, txtBPT_SchD_5C.value == "", 'Answer Question 5c']
                 arrSchdDErr[i++] = [txtBPT_SchD_5C, ispValue(txtBPT_SchD_5C.value) == false, 'Value for Question 5c must be numeric'];
                 arrSchdDErr[i++] = [txtBPT_SchD_5C, ispNegativeNumber(txtBPT_SchD_5C.value) == false, 'Value for Question 5c must NOT be negative'];
                 arrSchdDErr[i++] = [txtBPT_SchD_5D, txtBPT_SchD_5D.value == "", 'Answer Question 5d'];
                 arrSchdDErr[i++] = [txtBPT_SchD_5D, ispValue(txtBPT_SchD_5D.value) == false, 'Value for Question 5d must be numeric'];
                 arrSchdDErr[i++] = [txtBPT_SchD_5D, ispNegativeNumber(txtBPT_SchD_5D.value) == false, 'Value for Question 5d must NOT be negative'];
                 arrSchdDErr[i++] = [txtBPT_SchD_7, txtBPT_SchD_7.value == "", 'Answer Question 7'];
                 arrSchdDErr[i++] = [txtBPT_SchD_7, ispValue(txtBPT_SchD_7.value) == false, 'Value for Question 7 must be numeric'];
                 arrSchdDErr[i++] = [txtBPT_SchD_7, ispNegativeNumber(txtBPT_SchD_7.value) == false, 'Value for Question 7 must NOT be negative'];
                 //arrSchdDErr[i++] = [txtBPT_SchD_7, '(PrepForMath(txtBPT_SchD_7.value) > PrepForMath($("#lblBPT_SchD_6").text()))||PrepForMath(txtBPT_SchD_7.value)!=50000', 'Line 7 must be lower of Line 6 or $50,000.00'];


                 //arrSchdDErr[i++] = [txtBPT_SchD_7, 'PrepForMath(txtBPT_SchD_7.value) > PrepForMath($("#lblBPT_SchD_6").text()) || PrepForMath(txtBPT_SchD_7.value)!=50000', 'Line 7 must be lower of Line 6 or $50,000.00'];
                 arrSchdDErr[i++] = [txtBPT_SchD_8, txtBPT_SchD_8.value == "", 'Answer Question 8'];
                 arrSchdDErr[i++] = [txtBPT_SchD_8, ispValue(txtBPT_SchD_8.value) == false, 'Value for Question 8 must be numeric'];
                 arrSchdDErr[i++] = [txtBPT_SchD_8, ispNegativeNumber(txtBPT_SchD_8.value) == false, 'Value for Question 8 must NOT be negative'];
             }		//LoadErrorBPTlfSchdD

             function ClearBPTlfSchdD() {

                 parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScDLi1, '', 0);
                 parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScDLi2, '', 0);
                 parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScDLi3, '', 0);
                 parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScDLi4, '', 0);
                 parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScDLi5a, '', 0);
                 parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScDLi5b, '', 0);
                 parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScDLi5c, '', 0);
                 parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScDLi5d, '', 0);
                 parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScDLi6, '', 0);
                 parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScDLi7, '', 0);
                 parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScDLi8, '', 0);
                 parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScDLi9, '', 0);
                 parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScDLi10, '', 0);
                 parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScDLi11, '', 0);
                 parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScDLi12, '', 0);

             }		//ClearBPTlfSchdD

             function PopulateXmlBPTlfSchdD() {

                 var txtBPT_SchD_1 = document.getElementById('txtBPT_SchD_1');
                 var txtBPT_SchD_2 = document.getElementById('txtBPT_SchD_2');
                 var txtBPT_SchD_3 = document.getElementById('txtBPT_SchD_3');
                 var lblBPT_SchD_4 = document.getElementById('lblBPT_SchD_4');
                 var txtBPT_SchD_5A = document.getElementById('txtBPT_SchD_5A');
                 var txtBPT_SchD_5B = document.getElementById('txtBPT_SchD_5B');
                 var txtBPT_SchD_5C = document.getElementById('txtBPT_SchD_5C');
                 var txtBPT_SchD_5D = document.getElementById('txtBPT_SchD_5D');
                 var lblBPT_SchD_6 = document.getElementById('lblBPT_SchD_6');
                 var txtBPT_SchD_7 = document.getElementById('txtBPT_SchD_7');
                 var txtBPT_SchD_8 = document.getElementById('txtBPT_SchD_8');
                 var lblBPT_SchD_9 = document.getElementById('lblBPT_SchD_9');
                 var lblBPT_SchD_10 = document.getElementById('lblBPT_SchD_10');
                 var lblBPT_SchD_11 = document.getElementById('lblBPT_SchD_11');
                 var lblBPT_SchD_12 = document.getElementById('lblBPT_SchD_12');

                 parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchD_1.value), xFldScDLi1, '', 0);
                 parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchD_2.value), xFldScDLi2, '', 0);
                 parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchD_3.value), xFldScDLi3, '', 0);
                 parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchD_4').text()), xFldScDLi4, '', 0);
                 parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchD_5A.value), xFldScDLi5a, '', 0);

                 parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchD_5B.value), xFldScDLi5b, '', 0);
                 parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchD_5C.value), xFldScDLi5c, '', 0);
                 parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchD_5D.value), xFldScDLi5d, '', 0);
                 parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchD_6').text()), xFldScDLi6, '', 0);
                 parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchD_7.value), xFldScDLi7, '', 0);

                 parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchD_8.value), xFldScDLi8, '', 0);
                 parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchD_9').text()), xFldScDLi9, '', 0);
                 parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchD_10').text()), xFldScDLi10, '', 0);
                 parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchD_11').text()), xFldScDLi11, '', 0);
                 parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchD_12').text()), xFldScDLi11, '', 0);

             }		//PopulateXmlBPTlfSchdD

             function PopulateBPTlfSchdD() {

                 var txtBPT_SchD_1 = document.getElementById('txtBPT_SchD_1');
                 var txtBPT_SchD_2 = document.getElementById('txtBPT_SchD_2');
                 var txtBPT_SchD_3 = document.getElementById('txtBPT_SchD_3');
                 var lblBPT_SchD_4 = document.getElementById('lblBPT_SchD_4');
                 var txtBPT_SchD_5A = document.getElementById('txtBPT_SchD_5A');
                 var txtBPT_SchD_5B = document.getElementById('txtBPT_SchD_5B');
                 var txtBPT_SchD_5C = document.getElementById('txtBPT_SchD_5C');
                 var txtBPT_SchD_5D = document.getElementById('txtBPT_SchD_5D');
                 var lblBPT_SchD_6 = document.getElementById('lblBPT_SchD_6');
                 var txtBPT_SchD_7 = document.getElementById('txtBPT_SchD_7');
                 var txtBPT_SchD_8 = document.getElementById('txtBPT_SchD_8');
                 var lblBPT_SchD_9 = document.getElementById('lblBPT_SchD_9');
                 var lblBPT_SchD_10 = document.getElementById('lblBPT_SchD_10');
                 var lblBPT_SchD_11 = document.getElementById('lblBPT_SchD_11');
                 var lblBPT_SchD_12 = document.getElementById('lblBPT_SchD_12');

                 txtBPT_SchD_1.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScDLi1, '', 0), 0);
                 txtBPT_SchD_2.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScDLi2, '', 0), 0);
                 txtBPT_SchD_3.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScDLi3, '', 0), 0);
                 lblBPT_SchD_4.innerText = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScDLi4, '', 0), 0);
                 txtBPT_SchD_5A.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScDLi5a, '', 0), 0)
                 txtBPT_SchD_5B.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScDLi5b, '', 0), 0);
                 txtBPT_SchD_5C.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScDLi5c, '', 0), 0);
                 txtBPT_SchD_5D.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScDLi5d, '', 0), 0);
                 $('#lblBPT_SchD_6').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScDLi6, '', 0), 0));
                 txtBPT_SchD_7.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScDLi7, '', 0), 0);
                 txtBPT_SchD_8.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScDLi8, '', 0), 0);
                 $('#lblBPT_SchD_9').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScDLi9, '', 0), 0));
                 $('#lblBPT_SchD_10').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScDLi10, '', 0), 0));
                 $('#lblBPT_SchD_11').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScDLi11, '', 0), 0));
                 $('#lblBPT_SchD_12').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScDLi11, '', 0), 0));

                 $('#msgBPT_SchD_9').text($('#msgBPT_SchD_9').text().replace('###', dBPTGrossRate));

             }		//PopulateBPTlfSchdD

             function FieldLockBPTlfSchdD(bDisabled) {
                 $('#txtBPT_SchD_1').attr('disabled', bDisabled);
                 $('#txtBPT_SchD_2').attr('disabled', bDisabled);
                 $('#txtBPT_SchD_3').attr('disabled', bDisabled);
                 $('#lblBPT_SchD_4').attr('disabled', bDisabled);
                 $('#txtBPT_SchD_5A').attr('disabled', bDisabled);
                 $('#txtBPT_SchD_5B').attr('disabled', bDisabled);
                 $('#txtBPT_SchD_5C').attr('disabled', bDisabled);
                 $('#txtBPT_SchD_5D').attr('disabled', bDisabled);
                 $('#lblBPT_SchD_6').attr('disabled', bDisabled);
                 $('#txtBPT_SchD_7').attr('disabled', bDisabled);
                 $('#txtBPT_SchD_8').attr('disabled', bDisabled);
                 $('#lblBPT_SchD_9').attr('disabled', bDisabled);
                 $('#lblBPT_SchD_10').attr('disabled', bDisabled);
                 $('#lblBPT_SchD_11').attr('disabled', bDisabled);
                 $('#lblBPT_SchD_12').attr('disabled', bDisabled);
             }		//FieldLockBPTlfSchdD

             function PerformCalcsBPTlfSchdD() {

                 var txtBPT_SchD_1 = document.getElementById('txtBPT_SchD_1');
                 var txtBPT_SchD_2 = document.getElementById('txtBPT_SchD_2');
                 var txtBPT_SchD_3 = document.getElementById('txtBPT_SchD_3');
                 var lblBPT_SchD_4 = document.getElementById('lblBPT_SchD_4');
                 var txtBPT_SchD_5A = document.getElementById('txtBPT_SchD_5A');
                 var txtBPT_SchD_5B = document.getElementById('txtBPT_SchD_5B');
                 var txtBPT_SchD_5C = document.getElementById('txtBPT_SchD_5C');
                 var txtBPT_SchD_5D = document.getElementById('txtBPT_SchD_5D');
                 var lblBPT_SchD_6 = document.getElementById('lblBPT_SchD_6');
                 var txtBPT_SchD_7 = document.getElementById('txtBPT_SchD_7');
                 var txtBPT_SchD_8 = document.getElementById('txtBPT_SchD_8');
                 var lblBPT_SchD_9 = document.getElementById('lblBPT_SchD_9');
                 var lblBPT_SchD_10 = document.getElementById('lblBPT_SchD_10');
                 var lblBPT_SchD_11 = document.getElementById('lblBPT_SchD_11');
                 var lblBPT_SchD_12 = document.getElementById('lblBPT_SchD_12');

                 CalcSchdDLine4();
                 CalcSchdDLine6();
                 CalcSchdDLine8();
                 CalcSchdDLine9();
                 CalcSchdDLine10();	//Calculate lines 8 and 9
                 CalcSchdDLine12();

             }		//PerformCalcsBPTlfSchdD

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

             function CalcSchdDLine4() {

                 var txtBPT_SchD_1 = document.getElementById('txtBPT_SchD_1');
                 var txtBPT_SchD_2 = document.getElementById('txtBPT_SchD_2');
                 var txtBPT_SchD_3 = document.getElementById('txtBPT_SchD_3');
                 var lblBPT_SchD_4 = document.getElementById('lblBPT_SchD_4');
                 var txtBPT_SchD_5A = document.getElementById('txtBPT_SchD_5A');
                 var txtBPT_SchD_5B = document.getElementById('txtBPT_SchD_5B');
                 var txtBPT_SchD_5C = document.getElementById('txtBPT_SchD_5C');
                 var txtBPT_SchD_5D = document.getElementById('txtBPT_SchD_5D');
                 var lblBPT_SchD_6 = document.getElementById('lblBPT_SchD_6');
                 var txtBPT_SchD_7 = document.getElementById('txtBPT_SchD_7');
                 var txtBPT_SchD_8 = document.getElementById('txtBPT_SchD_8');
                 var lblBPT_SchD_9 = document.getElementById('lblBPT_SchD_9');
                 var lblBPT_SchD_10 = document.getElementById('lblBPT_SchD_10');
                 var lblBPT_SchD_11 = document.getElementById('lblBPT_SchD_11');
                 var lblBPT_SchD_12 = document.getElementById('lblBPT_SchD_12');
                 var txtBPT_SchA_1 = document.getElementById('txtBPT_SchA_1');
                 var txtBPT_SchB_1 = document.getElementById('txtBPT_SchB_1');

                 if (txtBPT_SchD_1.value != '' && txtBPT_SchD_2.value != '' && txtBPT_SchD_3.value != '') {
                     $('#lblBPT_SchD_4').text(ispFormatMoney(PrepForMath(txtBPT_SchD_1.value) + PrepForMath(txtBPT_SchD_2.value) +
                             PrepForMath(txtBPT_SchD_3.value), 0));
                     $('#lbl_BPT_WS3').text($('#lblBPT_SchD_4').text());
                    // Performvalidationandload();
                 }		//if

                 if (PrepForMath(txtBPT_SchA_1.value) != 0) {
                     if (PrepForMath($('#lblBPT_SchA_11').text()) > 0) {
                         if (PrepForMath($('#lblBPT_SchD_4').text()) == 0) {
                             $(parent.AppError).text('Line 4 Schedule D can not be $0.00');
                         }
                     }
                 } else if (PrepForMath(txtBPT_SchB_1.value) != 0) {
                     if (PrepForMath($('#lblBPT_SchB_11').text()) > 0) {
                         if (PrepForMath($('#lblBPT_SchD_4').text()) == 0) {
                             $(parent.AppError).text('Line 4 Schedule D can not be $0.00');
                         }
                     }
                 }

                 /*	if (PrepForMath($('#lblBPT_SchD_4').text())== 0) {
                         $('#AppError').text( 'Line 4 Schedule D can not be $0.00');
                         
                     } else {
                         $('#AppError').text('');
                     } 	//if	*/
             } 	//CalcSchdDLine4

             function CalcSchdDLine6() {

                 var txtBPT_SchD_1 = document.getElementById('txtBPT_SchD_1');
                 var txtBPT_SchD_2 = document.getElementById('txtBPT_SchD_2');
                 var txtBPT_SchD_3 = document.getElementById('txtBPT_SchD_3');
                 var lblBPT_SchD_4 = document.getElementById('lblBPT_SchD_4');
                 var txtBPT_SchD_5A = document.getElementById('txtBPT_SchD_5A');
                 var txtBPT_SchD_5B = document.getElementById('txtBPT_SchD_5B');
                 var txtBPT_SchD_5C = document.getElementById('txtBPT_SchD_5C');
                 var txtBPT_SchD_5D = document.getElementById('txtBPT_SchD_5D');
                 var lblBPT_SchD_6 = document.getElementById('lblBPT_SchD_6');
                 var txtBPT_SchD_7 = document.getElementById('txtBPT_SchD_7');
                 var txtBPT_SchD_8 = document.getElementById('txtBPT_SchD_8');
                 var lblBPT_SchD_9 = document.getElementById('lblBPT_SchD_9');
                 var lblBPT_SchD_10 = document.getElementById('lblBPT_SchD_10');
                 var lblBPT_SchD_11 = document.getElementById('lblBPT_SchD_11');
                 var lblBPT_SchD_12 = document.getElementById('lblBPT_SchD_12');

                 var temp = 0;
                 if (txtBPT_SchD_5A.value != '' && txtBPT_SchD_5B.value != '' && txtBPT_SchD_5C.value != '' &&
                         txtBPT_SchD_5D.value != '') {
                     temp = PrepForMath(txtBPT_SchD_5A.value) + PrepForMath(txtBPT_SchD_5B.value) +
                             PrepForMath(txtBPT_SchD_5C.value) + PrepForMath(txtBPT_SchD_5D.value);
                     $('#lblBPT_SchD_6').text(ispFormatMoney(PrepForMath($('#lblBPT_SchD_4').text()) - temp, 0));
                 }		//if
             }		//CalcSchdDLine6
             function CalcSchdDLine8() {

                 var txtBPT_SchD_1 = document.getElementById('txtBPT_SchD_1');
                 var txtBPT_SchD_2 = document.getElementById('txtBPT_SchD_2');
                 var txtBPT_SchD_3 = document.getElementById('txtBPT_SchD_3');
                 var lblBPT_SchD_4 = document.getElementById('lblBPT_SchD_4');
                 var txtBPT_SchD_5A = document.getElementById('txtBPT_SchD_5A');
                 var txtBPT_SchD_5B = document.getElementById('txtBPT_SchD_5B');
                 var txtBPT_SchD_5C = document.getElementById('txtBPT_SchD_5C');
                 var txtBPT_SchD_5D = document.getElementById('txtBPT_SchD_5D');
                 var lblBPT_SchD_6 = document.getElementById('lblBPT_SchD_6');
                 var txtBPT_SchD_7 = document.getElementById('txtBPT_SchD_7');
                 var txtBPT_SchD_8 = document.getElementById('txtBPT_SchD_8');
                 var lblBPT_SchD_9 = document.getElementById('lblBPT_SchD_9');
                 var lblBPT_SchD_10 = document.getElementById('lblBPT_SchD_10');
                 var lblBPT_SchD_11 = document.getElementById('lblBPT_SchD_11');
                 var lblBPT_SchD_12 = document.getElementById('lblBPT_SchD_12');

                 $('#lblBPT_SchE_1').text(txtBPT_SchD_8.value);
                 $('#lblBPT_SchE_5').text(txtBPT_SchD_8.value);
                 $('#lblBPT_SchE_10').text(txtBPT_SchD_8.value);
             }

             function CalcSchdDLine9() {

                 var txtBPT_SchD_1 = document.getElementById('txtBPT_SchD_1');
                 var txtBPT_SchD_2 = document.getElementById('txtBPT_SchD_2');
                 var txtBPT_SchD_3 = document.getElementById('txtBPT_SchD_3');
                 var lblBPT_SchD_4 = document.getElementById('lblBPT_SchD_4');
                 var txtBPT_SchD_5A = document.getElementById('txtBPT_SchD_5A');
                 var txtBPT_SchD_5B = document.getElementById('txtBPT_SchD_5B');
                 var txtBPT_SchD_5C = document.getElementById('txtBPT_SchD_5C');
                 var txtBPT_SchD_5D = document.getElementById('txtBPT_SchD_5D');
                 var lblBPT_SchD_6 = document.getElementById('lblBPT_SchD_6');
                 var txtBPT_SchD_7 = document.getElementById('txtBPT_SchD_7');
                 var txtBPT_SchD_8 = document.getElementById('txtBPT_SchD_8');
                 var lblBPT_SchD_9 = document.getElementById('lblBPT_SchD_9');
                 var lblBPT_SchD_10 = document.getElementById('lblBPT_SchD_10');
                 var lblBPT_SchD_11 = document.getElementById('lblBPT_SchD_11');
                 var lblBPT_SchD_12 = document.getElementById('lblBPT_SchD_12');

                 //if ($('#lblBPT_SchD_6').text() != '' && txtBPT_SchD_7.value != '') {
                 //    $('#lblBPT_SchD_8').text(ispFormatMoney(PrepForMath($('#lblBPT_SchD_6').text()) - PrepForMath(txtBPT_SchD_7.value), 0));
                 //    $('#lblBPT_SchD_9').text(ispFormatMoney(PrepForMath($('#lblBPT_SchD_8').text()) * dBPTGrossRate, 0));
                 //    //Fill in Schd E with info from this Schd
                 //    $('#lblBPT_SchE_A').text(txtBPT_SchD_7.value);

                 //    VerifyTaxBasis('SCHDD');
                 //}		//if
                 if ($('#lblBPT_SchD_6').text() != '' && txtBPT_SchD_7.value != '' && txtBPT_SchD_8.value != '') {
                     $('#lblBPT_SchD_9').text(ispFormatMoney(PrepForMath($('#lblBPT_SchD_6').text()) - (PrepForMath(txtBPT_SchD_7.value) + PrepForMath(txtBPT_SchD_8.value)), 0));

                 }
             }		//CalcSchdDLine9
             function CalcSchdDLine10() {
                 $('#lblBPT_SchD_10').text(ispFormatMoney(PrepForMath($('#lblBPT_SchD_9').text()) * dBPTGrossRate, 0));
             }
             function CalcSchdDLine12() {

                 var txtBPT_SchD_1 = document.getElementById('txtBPT_SchD_1');
                 var txtBPT_SchD_2 = document.getElementById('txtBPT_SchD_2');
                 var txtBPT_SchD_3 = document.getElementById('txtBPT_SchD_3');
                 var lblBPT_SchD_4 = document.getElementById('lblBPT_SchD_4');
                 var txtBPT_SchD_5A = document.getElementById('txtBPT_SchD_5A');
                 var txtBPT_SchD_5B = document.getElementById('txtBPT_SchD_5B');
                 var txtBPT_SchD_5C = document.getElementById('txtBPT_SchD_5C');
                 var txtBPT_SchD_5D = document.getElementById('txtBPT_SchD_5D');
                 var lblBPT_SchD_6 = document.getElementById('lblBPT_SchD_6');
                 var txtBPT_SchD_7 = document.getElementById('txtBPT_SchD_7');
                 var txtBPT_SchD_8 = document.getElementById('txtBPT_SchD_8');
                 var lblBPT_SchD_9 = document.getElementById('lblBPT_SchD_9');
                 var lblBPT_SchD_10 = document.getElementById('lblBPT_SchD_10');
                 var lblBPT_SchD_11 = document.getElementById('lblBPT_SchD_11');
                 var lblBPT_SchD_12 = document.getElementById('lblBPT_SchD_12');

                 if ($('#lblBPT_SchD_10').text() != '' && $('#lblBPT_SchD_11').text() != '') {
                     $('#lblBPT_SchD_12').text(ispFormatMoney(PrepForMath($('#lblBPT_SchD_10').text()) + PrepForMath($('#lblBPT_SchD_11').text()), 0));
                     if (PrepForMath($('#lblBPT_SchD_12').text()) < 0) {
                         $('#lblBPT_SchD_12').text(ispFormatMoney(0, 0));

                     }
                     $('#lblBPT1_2').text($('#lblBPT_SchD_12').text());

                     //if
                     //		$('#lblBPT1_2').text( $('#lblBPT_SchD_11').text());
                     //		PerformCalcsBPTlfPg1();
                 }		//if
             }		//CalcSchdDLine11
    </script>
</head>
<div class="col-lg-12 col-md-12" id="BPT_SchdD" style="display: none;">
    <div class="row">
                    <div class="col-lg-12 templateclass">
                            <div class="table-responsive">

                                <table class="table table-condensed table-striped custom_table03">

                                    <thead>
                                        <tr>
                                            <th colspan="3" width="100%"><b><u>2013 BIRT Schedule D: Computation Of Tax On Gross Receipts</u></b></th>

                                        </tr>

                                    </thead>

                                    <tbody>

                                        <tr>
                                            <td width="5%">1.</td>
                                            <td width="70%" class="text-left">Gross Receipts from sales and/or rentals of tangible
    personal property, dividends, interest, royalties and gains on sale of stocks, bonds and
    business capital assests</td>
                                            <td width="25%" class="text-left">
                                                <form class="form-horizontal">

                                                    <div class="form-group no-margin">
                                                        <div class="">
                                                            <input class="form-control input-sm" id="txtBPT_SchD_1" style="width: 100%"
                                                                onfocus="SetFocus()" onchange='ValidateWorksheet("BPT_SchdD")'>
                                                        </div>
                                                    </div>

                                                </form>
                                            </td>
                                        </tr>

                                        <tr class="odd">
                                            <td width="5%">2.</td>
                                            <td width="70%" class="text-left">Gross Receipts from services</td>
                                            <td width="25%" class="text-left">
                                                <form class="form-horizontal">

                                                    <div class="form-group no-margin">
                                                        <div class="">
                                                            <input class="form-control input-sm" id="txtBPT_SchD_2" style="width: 100%"
                                                                onfocus="SetFocus()" onchange='ValidateWorksheet("BPT_SchdD")'>
                                                        </div>
                                                    </div>

                                                </form>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="5%">3.</td>
                                            <td width="70%" class="text-left">Gross Receipts from rentals of real property</td>

                                            <td width="25%" class="text-left">
                                                <form class="form-horizontal">

                                                    <div class="form-group no-margin">
                                                        <div class="">
                                                            <input class="form-control input-sm" id="txtBPT_SchD_3" style="width: 100%"
                                                                onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("BPT_SchdD")'>
                                                        </div>
                                                    </div>

                                                </form>
                                            </td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="5%">4.</td>
                                            <td width="70%" class="text-left">Total Gross Receipts[Calculated - Sum Lines 1, 2 and 3]</td>
                                            <td width="25%" class="text-left">
                                                <form class="form-horizontal">

                                                    <div class="form-group no-margin">
                                                        <div class="">
                                                            <label id="lblBPT_SchD_4" style="width: 100%" class="form-control input-sm"></label>
                                                        </div>
                                                    </div>
                                                </form>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="5%"></td>
                                            <td><b>Less Exclusions from:</b></td>
                                        </tr>
                                        <tr>
                                            <td width="5%">5a.</td>
                                            <td width="70%" class="text-left">Sales delivered outside of Philadelphia</td>
                                            <td width="25%" class="text-left">
                                                <form class="form-horizontal">

                                                    <div class="form-group no-margin">
                                                        <div class="">

                                                            <input class="form-control input-sm" id="txtBPT_SchD_5A" style="width: 100%"
                                                                onfocus="SetFocus()" onchange='ValidateWorksheet("BPT_SchdD")'>
                                                        </div>
                                                    </div>

                                                </form>
                                            </td>
                                        </tr>

                                        <tr class="odd">
                                            <td width="5%">5b.</td>
                                            <td width="70%" class="text-left">Services performed outside of Philadelphia
                                            </td>
                                            <td width="25%" class="text-left">
                                                <form class="form-horizontal">

                                                    <div class="form-group no-margin">
                                                        <div class="">
                                                            <input class="form-control input-sm" id="txtBPT_SchD_5B" style="width: 100%"
                                                                onfocus="SetFocus()" onchange='ValidateWorksheet("BPT_SchdD")'>
                                                        </div>
                                                    </div>

                                                </form>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="5%">5c.</td>
                                            <td width="70%" class="text-left">Rentals of real property outside of Philadelphia</td>
                                            <td width="25%" class="text-left">
                                                <form class="form-horizontal">

                                                    <div class="form-group no-margin">
                                                        <div class="">
                                                            <input class="form-control input-sm" id="txtBPT_SchD_5C" style="width: 100%"
                                                                onfocus="SetFocus()" onchange='ValidateWorksheet("BPT_SchdD")' />
                                                        </div>
                                                    </div>

                                                </form>
                                            </td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="5%">5d.</td>
                                            <td width="70%" class="text-left">Other</td>
                                            <td width="25%" class="text-left">
                                                <form class="form-horizontal">

                                                    <div class="form-group no-margin">
                                                        <div class="">

                                                            <input class="form-control input-sm" id="txtBPT_SchD_5D" style="width: 100%"
                                                                onfocus="SetFocus()" onchange='ValidateWorksheet("BPT_SchdD")'>
                                                        </div>
                                                    </div>

                                                </form>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="5%">6.</td>
                                            <td width="70%" class="text-left">Net Taxable Receipts before Statutory Exclusion [Calculated - Line 4 minus Lines 5a through 5d]</td>
                                            <td width="25%" class="text-left">
                                                <form class="form-horizontal">

                                                    <div class="form-group no-margin">
                                                        <div class="">
                                                            <label id="lblBPT_SchD_6" class="form-control input-sm"></label>
                                                        </div>
                                                    </div>

                                                </form>

                                            </td>
                                        </tr>

                                        <tr class="odd">
                                            <td width="5%">7.</td>
                                            <td width="70%" class="text-left"> Less Receipts on which tax is to be computed by the Alternate Method 
                                        </td>
                                            <td width="25%" class="text-left">
                                                <form class="form-horizontal">

                                                    <div class="form-group no-margin">
                                                        <div class="">
                                                            <input class="form-control input-sm" id="txtBPT_SchD_7" style="width: 100%"
                                                                onfocus="SetFocus()" onchange='ValidateWorksheet("BPT_SchdD")'>
                                                        </div>
                                                    </div>

                                                </form>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="5%">8.</td>
                                            <td width="70%" class="text-left">Receipts subject to tax at the regular rate[Calculated - Line 6 minus Line 7]</td>
                                            <td width="25%" class="text-left">
                                                <form class="form-horizontal">

                                                    <div class="form-group no-margin">
                                                        <div class="">
                                                            <input class="form-control input-sm" id="txtBPT_SchD_8" style="width: 100%" onfocus="SetFocus()" onchange='ValidateWorksheet("BPT_SchdD")'>
                                                        </div>
                                                    </div>

                                                </form>
                                            </td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="5%">9.</td>
                                            <td width="70%" class="text-left">TAX DUE at regular rate</td>
                                            <td width="25%" class="text-left">
                                                <form class="form-horizontal">

                                                    <div class="form-group no-margin">
                                                        <div class="">
                                                            <label id="lblBPT_SchD_9" class="form-control input-sm"></label>
                                                        </div>
                                                    </div>

                                                </form>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="5%">10.</td>
                                            <td width="70%" class="text-left"<b>TAX DUE</b> using the Alternate Method (from
				<label class="lblLink" style="FONT-SIZE: 7pt" onclick=ShowPage('SchdE')>Schedule E, Line 15</label>
				<LABEL class="">).</td>
                                            <td width="25%" class="text-left">
                                                <form class="form-horizontal">

                                                    <div class="form-group no-margin">
                                                        <div class="">
                                                            <label id="lblBPT_SchD_10" class="form-control input-sm"></label>
                                                        </div>
                                                    </div>

                                                </form>

                                            </td>
                                        </tr>

                                        <%--<tr class="odd">
                                            <td width="5%">11.</td>
                                            <td width="70%" class="text-left"><b>TAX DUE</b> using the Alternate Method (from
				<label class="lblLink" onclick='ShowPage("SchdE")'>Schedule E, Line 15</label>
                                                <label class="">).</label></td>
                                            <td width="25%" class="text-left">
                                                <form class="form-horizontal">

                                                    <div class="form-group no-margin">
                                                        <div class="">
                                                            <label id="lblBPT_SchD_11" style="width: 100%" class="form-control input-sm"></label>
                                                        </div>
                                                    </div>

                                                </form>
                                            </td>
                                        </tr>--%>
                                        <tr>
                                            <td width="5%">11.</td>
                                            <td width="70%" class="text-left"><b>TOTAL TAX DUE</b>[Calculated - Sum Line 10 and Line 11]</td>
                                            <td width="25%" class="text-left">
                                                <form class="form-horizontal">

                                                    <div class="form-group no-margin">
                                                        <div class="">
                                                            <label id="lblBPT_SchD_12" class="form-control input-sm"></label>
                                                        </div>
                                                    </div>

                                                </form>

                                            </td>
                                        </tr>
                                        
                                    </tbody>


                                </table>

                            </div>
                            
                            <form class="form-horizontal school_form">


                                <div class="form-group">
                                    <div class="col-sm-offset-3 col-sm-9  text-right">
                                        <%--  <button class="btn btn-default submit_button" type="submit">Print</button>--%>
                                        <input type="button" value="Return to Page 1" class="submit_button2" id="btnGoToPage1" onclick="ShowPage('Pg1')" />
                                    </div>
                                </div>

                            </form>
                  
                            <!--  <!-- Schedule A Form  END -->
</div>
        </div>

    </div>
</html>
