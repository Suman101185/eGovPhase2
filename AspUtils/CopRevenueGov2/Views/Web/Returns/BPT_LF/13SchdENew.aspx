<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head >    
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
         var arrSchdEErr = new Array();
         var xSecScE = 'BPT_SCH_E ';
         var xFldScELi1 = xSecScE + 'M_ALT_RECEIPTS';
         var xFldScELi2 = xSecScE + 'M_GOODS_COST';
         var xFldScELi3 = xSecScE + 'M_TAX_BASE';
         var xFldScELi4 = xSecScE + 'M_TAX_DUE';
         var xFldScELi5 = xSecScE + 'W_ALT_RECEIPTS';
         var xFldScELi6a = xSecScE + 'W_GOODS_MATERIALS';
         var xFldScELi6b = xSecScE + 'W_GOODS_LABOR';
         var xFldScELi7 = xSecScE + 'W_GOODS_COST';
         var xFldScELi8 = xSecScE + 'W_TAX_BASE';
         var xFldScELi9 = xSecScE + 'W_TAX_DUE';
         var xFldScELi10 = xSecScE + 'R_ALT_RECEIPTS';
         var xFldScELi11a = xSecScE + 'R_GOODS_MATERIALS';
         var xFldScELi11b = xSecScE + 'R_GOODS_LABOR';
         var xFldScELi12 = xSecScE + 'R_GOODS_COST';
         var xFldScELi13 = xSecScE + 'R_TAX_BASE';
         var xFldScELi14 = xSecScE + 'R_TAX_DUE';
         var xFldScELi15 = xSecScE + 'TOTAL_TAX_DUE';

         function LoadErrorBPTlfSchdE() {

             var lblBPT_SchE_1 = document.getElementById('lblBPT_SchE_1');
             var txtBPT_SchE_2 = document.getElementById('txtBPT_SchE_2');
             var lblBPT_SchE_3 = document.getElementById('lblBPT_SchE_3');
             var lblBPT_SchE_4 = document.getElementById('lblBPT_SchE_4');
             var lblBPT_SchE_5 = document.getElementById('lblBPT_SchE_5');
             var txtBPT_SchE_6A = document.getElementById('txtBPT_SchE_6A');
             var txtBPT_SchE_6B = document.getElementById('txtBPT_SchE_6B');
             var lblBPT_SchE_7 = document.getElementById('lblBPT_SchE_7');
             var lblBPT_SchE_8 = document.getElementById('lblBPT_SchE_8');
             var lblBPT_SchE_9 = document.getElementById('lblBPT_SchE_9');
             var lblBPT_SchE_10 = document.getElementById('lblBPT_SchE_10');
             var txtBPT_SchE_11A = document.getElementById('txtBPT_SchE_11A');
             var txtBPT_SchE_11B = document.getElementById('txtBPT_SchE_11B');
             var lblBPT_SchE_12 = document.getElementById('lblBPT_SchE_12');
             var lblBPT_SchE_13 = document.getElementById('lblBPT_SchE_13');
             var lblBPT_SchE_14 = document.getElementById('lblBPT_SchE_14');
             var lblBPT_SchE_15 = document.getElementById('lblBPT_SchE_15');


             var i = 0;
             /*arrSchdEErr[i++] = [txtBPT_SchE_1, 'txtBPT_SchE_1.value == ""', 'Answer Question 1'];
             arrSchdEErr[i++] = [txtBPT_SchE_1, 'ispValue(txtBPT_SchE_1.value) == false', 'Value for Question 1 must be numeric'];
             arrSchdEErr[i++] = [txtBPT_SchE_1, 'ispNegativeNumber(txtBPT_SchE_1.value) == false', 'Value for Question 1 must NOT be negative'];*/ //binoy
             arrSchdEErr[i++] = [txtBPT_SchE_2, txtBPT_SchE_2.value == "", 'Answer Question 2'];
             arrSchdEErr[i++] = [txtBPT_SchE_2, ispValue(txtBPT_SchE_2.value) == false, 'Value for Question 2 must be numeric'];
             arrSchdEErr[i++] = [txtBPT_SchE_2, ispNegativeNumber(txtBPT_SchE_2.value) == false, 'Value for Question 2 must NOT be negative'];
             /*arrSchdEErr[i++] = [txtBPT_SchE_5, 'txtBPT_SchE_5.value == ""', 'Answer Question 5'];
             arrSchdEErr[i++] = [txtBPT_SchE_5, 'ispValue(txtBPT_SchE_5.value) == false', 'Value for Question 5 must be numeric'];
             arrSchdEErr[i++] = [txtBPT_SchE_5, 'ispNegativeNumber(txtBPT_SchE_5.value) == false', 'Value for Question 5 must NOT be negative'];*/ //binoy
             arrSchdEErr[i++] = [txtBPT_SchE_6A, txtBPT_SchE_6A.value == "", 'Answer Question 6a'];
             arrSchdEErr[i++] = [txtBPT_SchE_6A, ispValue(txtBPT_SchE_6A.value) == false, 'Value for Question 6a must be numeric'];
             arrSchdEErr[i++] = [txtBPT_SchE_6A, ispNegativeNumber(txtBPT_SchE_6A.value) == false, 'Value for Question 6a must NOT be negative'];
             arrSchdEErr[i++] = [txtBPT_SchE_6B, txtBPT_SchE_6B.value == "", 'Answer Question 6b'];
             arrSchdEErr[i++] = [txtBPT_SchE_6B, ispValue(txtBPT_SchE_6B.value) == false, 'Value for Question 6b must be numeric'];
             arrSchdEErr[i++] = [txtBPT_SchE_6B, ispNegativeNumber(txtBPT_SchE_6B.value) == false, 'Value for Question 6b must NOT be negative'];
             /*arrSchdEErr[i++] = [txtBPT_SchE_10, 'txtBPT_SchE_10.value == ""', 'Answer Question 10']
             arrSchdEErr[i++] = [txtBPT_SchE_10, 'ispValue(txtBPT_SchE_10.value) == false', 'Value for Question 10 must be numeric'];
             arrSchdEErr[i++] = [txtBPT_SchE_10, 'ispNegativeNumber(txtBPT_SchE_10.value) == false', 'Value for Question 10 must NOT be negative'];*/ //binoy
             arrSchdEErr[i++] = [txtBPT_SchE_11A, txtBPT_SchE_11A.value == "", 'Answer Question 11a'];
             arrSchdEErr[i++] = [txtBPT_SchE_11A, ispValue(txtBPT_SchE_11A.value) == false, 'Value for Question 11a must be numeric'];
             arrSchdEErr[i++] = [txtBPT_SchE_11A, ispNegativeNumber(txtBPT_SchE_11A.value) == false, 'Value for Question 11a must NOT be negative'];
             arrSchdEErr[i++] = [txtBPT_SchE_11B, txtBPT_SchE_11B.value == "", 'Answer Question 11b'];
             arrSchdEErr[i++] = [txtBPT_SchE_11B, ispValue(txtBPT_SchE_11B.value) == false, 'Value for Question 11b must be numeric'];
             arrSchdEErr[i++] = [txtBPT_SchE_11B, ispNegativeNumber(txtBPT_SchE_11B.value) == false, 'Value for Question 11b must NOT be negative'];
         }		//LoadErrorBPTlfSchdE

         function ClearBPTlfSchdE() {

             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScELi1, '', 0);
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScELi2, '', 0);
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScELi3, '', 0);
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScELi4, '', 0);
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScELi5, '', 0);
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScELi6a, '', 0);
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScELi6b, '', 0);
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScELi7, '', 0);
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScELi8, '', 0);
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScELi9, '', 0);
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScELi10, '', 0);
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScELi11a, '', 0);
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScELi11b, '', 0);
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScELi12, '', 0);
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScELi13, '', 0);
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScELi14, '', 0);
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScELi15, '', 0);

         }		//ClearBPTlfSchdE

         function PopulateBPTlfSchdE() {

             var lblBPT_SchE_1 = document.getElementById('lblBPT_SchE_1');
             var txtBPT_SchE_2 = document.getElementById('txtBPT_SchE_2');
             var lblBPT_SchE_3 = document.getElementById('lblBPT_SchE_3');
             var lblBPT_SchE_4 = document.getElementById('lblBPT_SchE_4');
             var lblBPT_SchE_5 = document.getElementById('lblBPT_SchE_5');
             var txtBPT_SchE_6A = document.getElementById('txtBPT_SchE_6A');
             var txtBPT_SchE_6B = document.getElementById('txtBPT_SchE_6B');
             var lblBPT_SchE_7 = document.getElementById('lblBPT_SchE_7');
             var lblBPT_SchE_8 = document.getElementById('lblBPT_SchE_8');
             var lblBPT_SchE_9 = document.getElementById('lblBPT_SchE_9');
             var lblBPT_SchE_10 = document.getElementById('lblBPT_SchE_10');
             var txtBPT_SchE_11A = document.getElementById('txtBPT_SchE_11A');
             var txtBPT_SchE_11B = document.getElementById('txtBPT_SchE_11B');
             var lblBPT_SchE_12 = document.getElementById('lblBPT_SchE_12');
             var lblBPT_SchE_13 = document.getElementById('lblBPT_SchE_13');
             var lblBPT_SchE_14 = document.getElementById('lblBPT_SchE_14');
             var lblBPT_SchE_15 = document.getElementById('lblBPT_SchE_15');


             //clipboardData.setData ('Text', parent.$g.xmlBPTlf_2014.xml.xml);
             $('#lblBPT_SchE_1').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScELi1, '', 0), 0)); //binoy
             txtBPT_SchE_2.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScELi2, '', 0), 0);
             $('#lblBPT_SchE_3').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScELi3, '', 0), 0));
             $('#lblBPT_SchE_4').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScELi4, '', 0), 0));
             $('#lblBPT_SchE_5').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScELi5, '', 0), 0));
             txtBPT_SchE_6A.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScELi6a, '', 0), 0);
             txtBPT_SchE_6B.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScELi6b, '', 0), 0);
             $('#lblBPT_SchE_7').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScELi7, '', 0), 0));
             $('#lblBPT_SchE_8').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScELi8, '', 0), 0));
             $('#lblBPT_SchE_9').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScELi9, '', 0), 0));
             $('#lblBPT_SchE_10').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScELi10, '', 0), 0));
             txtBPT_SchE_11A.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScELi11a, '', 0), 0);
             txtBPT_SchE_11B.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScELi11b, '', 0), 0);
             $('#lblBPT_SchE_12').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScELi12, '', 0), 0));
             $('#lblBPT_SchE_13').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScELi13, '', 0), 0));
             $('#lblBPT_SchE_14').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScELi14, '', 0), 0));
             $('#lblBPT_SchE_15').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScELi15, '', 0), 0));

             $('#msgBPT_SchE_4').text($('#msgBPT_SchE_4').text().replace('###', dBPTManufacturerRate));
             $('#msgBPT_SchE_9').text($('#msgBPT_SchE_9').text().replace('###', dBPTWholesaleRate));
             $('#msgBPT_SchE_14').text($('#msgBPT_SchE_14').text().replace('###', dBPTRetailerRate));
         }		//PopulateBPTlfSchdE

         function PopulateXmlBPTlfSchdE() {

             var lblBPT_SchE_1 = document.getElementById('lblBPT_SchE_1');
             var txtBPT_SchE_2 = document.getElementById('txtBPT_SchE_2');
             var lblBPT_SchE_3 = document.getElementById('lblBPT_SchE_3');
             var lblBPT_SchE_4 = document.getElementById('lblBPT_SchE_4');
             var lblBPT_SchE_5 = document.getElementById('lblBPT_SchE_5');
             var txtBPT_SchE_6A = document.getElementById('txtBPT_SchE_6A');
             var txtBPT_SchE_6B = document.getElementById('txtBPT_SchE_6B');
             var lblBPT_SchE_7 = document.getElementById('lblBPT_SchE_7');
             var lblBPT_SchE_8 = document.getElementById('lblBPT_SchE_8');
             var lblBPT_SchE_9 = document.getElementById('lblBPT_SchE_9');
             var lblBPT_SchE_10 = document.getElementById('lblBPT_SchE_10');
             var txtBPT_SchE_11A = document.getElementById('txtBPT_SchE_11A');
             var txtBPT_SchE_11B = document.getElementById('txtBPT_SchE_11B');
             var lblBPT_SchE_12 = document.getElementById('lblBPT_SchE_12');
             var lblBPT_SchE_13 = document.getElementById('lblBPT_SchE_13');
             var lblBPT_SchE_14 = document.getElementById('lblBPT_SchE_14');
             var lblBPT_SchE_15 = document.getElementById('lblBPT_SchE_15');



             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency(lblBPT_SchE_1.value), xFldScELi1, '', 0) //binoy
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency(txtBPT_SchE_2.value), xFldScELi2, '', 0)
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency($('#lblBPT_SchE_3').text()), xFldScELi3, '', 0)
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency($('#lblBPT_SchE_4').text()), xFldScELi4, '', 0)
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency($('#lblBPT_SchE_5').text()), xFldScELi5, '', 0)
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency(txtBPT_SchE_6A.value), xFldScELi6a, '', 0)
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency(txtBPT_SchE_6B.value), xFldScELi6b, '', 0)
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency($('#lblBPT_SchE_7').text()), xFldScELi7, '', 0)
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency($('#lblBPT_SchE_8').text()), xFldScELi8, '', 0)
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency($('#lblBPT_SchE_9').text()), xFldScELi9, '', 0)
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency($('#lblBPT_SchE_10').text()), xFldScELi10, '', 0)
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency(txtBPT_SchE_11A.value), xFldScELi11a, '', 0)
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency(txtBPT_SchE_11B.value), xFldScELi11b, '', 0)
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency($('#lblBPT_SchE_12').text()), xFldScELi12, '', 0)
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency($('#lblBPT_SchE_13').text()), xFldScELi13, '', 0)
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency($('#lblBPT_SchE_14').text()), xFldScELi14, '', 0)
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency($('#lblBPT_SchE_15').text()), xFldScELi15, '', 0)

         }		//PopulateXmlBPTlfSchdE

         function FieldLockBPTlfSchdE(bDisabled) {
             //$('#lblBPT_SchE_A').attr('disabled', bDisabled);  //binoy
             $('#lblBPT_SchE_1').attr('disabled', bDisabled);
             $('#txtBPT_SchE_2').attr('disabled', bDisabled);
             $('#lblBPT_SchE_3').attr('disabled', bDisabled);
             $('#lblBPT_SchE_4').attr('disabled', bDisabled);
             $('#lblBPT_SchE_5').attr('disabled', bDisabled);
             $('#txtBPT_SchE_6A').attr('disabled', bDisabled);
             $('#txtBPT_SchE_6B').attr('disabled', bDisabled);
             $('#lblBPT_SchE_7').attr('disabled', bDisabled);
             $('#lblBPT_SchE_8').attr('disabled', bDisabled);
             $('#lblBPT_SchE_9').attr('disabled', bDisabled);
             $('#lblBPT_SchE_10').attr('disabled', bDisabled);
             $('#txtBPT_SchE_11A').attr('disabled', bDisabled);
             $('#txtBPT_SchE_11B').attr('disabled', bDisabled);
             $('#lblBPT_SchE_12').attr('disabled', bDisabled);
             $('#lblBPT_SchE_13').attr('disabled', bDisabled);
             $('#lblBPT_SchE_14').attr('disabled', bDisabled);
             $('#lblBPT_SchE_15').attr('disabled', bDisabled);
         }		//FieldLockBPTlfSchdE

         function PerformCalcsBPTlfSchdE() {

             var lblBPT_SchE_1 = document.getElementById('lblBPT_SchE_1');
             var txtBPT_SchE_2 = document.getElementById('txtBPT_SchE_2');
             var lblBPT_SchE_3 = document.getElementById('lblBPT_SchE_3');
             var lblBPT_SchE_4 = document.getElementById('lblBPT_SchE_4');
             var lblBPT_SchE_5 = document.getElementById('lblBPT_SchE_5');
             var txtBPT_SchE_6A = document.getElementById('txtBPT_SchE_6A');
             var txtBPT_SchE_6B = document.getElementById('txtBPT_SchE_6B');
             var lblBPT_SchE_7 = document.getElementById('lblBPT_SchE_7');
             var lblBPT_SchE_8 = document.getElementById('lblBPT_SchE_8');
             var lblBPT_SchE_9 = document.getElementById('lblBPT_SchE_9');
             var lblBPT_SchE_10 = document.getElementById('lblBPT_SchE_10');
             var txtBPT_SchE_11A = document.getElementById('txtBPT_SchE_11A');
             var txtBPT_SchE_11B = document.getElementById('txtBPT_SchE_11B');
             var lblBPT_SchE_12 = document.getElementById('lblBPT_SchE_12');
             var lblBPT_SchE_13 = document.getElementById('lblBPT_SchE_13');
             var lblBPT_SchE_14 = document.getElementById('lblBPT_SchE_14');
             var lblBPT_SchE_15 = document.getElementById('lblBPT_SchE_15');


             CalcSchdELine4();
             CalcSchdELine9();
             CalcSchdELine14();
             CalcSchdELine15();
             VerifyTaxBasis();
         }		//PerformCalcsBPTlfSchdE

         function CalcSchdELine4() {

             var lblBPT_SchE_1 = document.getElementById('lblBPT_SchE_1');
             var txtBPT_SchE_2 = document.getElementById('txtBPT_SchE_2');
             var lblBPT_SchE_3 = document.getElementById('lblBPT_SchE_3');
             var lblBPT_SchE_4 = document.getElementById('lblBPT_SchE_4');
             var lblBPT_SchE_5 = document.getElementById('lblBPT_SchE_5');
             var txtBPT_SchE_6A = document.getElementById('txtBPT_SchE_6A');
             var txtBPT_SchE_6B = document.getElementById('txtBPT_SchE_6B');
             var lblBPT_SchE_7 = document.getElementById('lblBPT_SchE_7');
             var lblBPT_SchE_8 = document.getElementById('lblBPT_SchE_8');
             var lblBPT_SchE_9 = document.getElementById('lblBPT_SchE_9');
             var lblBPT_SchE_10 = document.getElementById('lblBPT_SchE_10');
             var txtBPT_SchE_11A = document.getElementById('txtBPT_SchE_11A');
             var txtBPT_SchE_11B = document.getElementById('txtBPT_SchE_11B');
             var lblBPT_SchE_12 = document.getElementById('lblBPT_SchE_12');
             var lblBPT_SchE_13 = document.getElementById('lblBPT_SchE_13');
             var lblBPT_SchE_14 = document.getElementById('lblBPT_SchE_14');
             var lblBPT_SchE_15 = document.getElementById('lblBPT_SchE_15');


             if ($('#lblBPT_SchE_1').text() != '' && txtBPT_SchE_2.value != '') {
                 $('#lblBPT_SchE_3').text(ispFormatMoney(PrepForMath($('#lblBPT_SchE_1').text()) - PrepForMath(txtBPT_SchE_2.value), 0)); //binoy
             }		//if

             if (PrepForMath($('#lblBPT_SchE_3').text()) < 0) {
                 $('#lblBPT_SchE_4').text(ispFormatMoney(0, 0));
             } else {
                 $('#lblBPT_SchE_4').text(ispFormatMoney(PrepForMath($('#lblBPT_SchE_3').text()) * dBPTManufacturerRate, 0));
             }		//if
         }		//CalcSchdELine4

         function CalcSchdELine9() {

             var lblBPT_SchE_1 = document.getElementById('lblBPT_SchE_1');
             var txtBPT_SchE_2 = document.getElementById('txtBPT_SchE_2');
             var lblBPT_SchE_3 = document.getElementById('lblBPT_SchE_3');
             var lblBPT_SchE_4 = document.getElementById('lblBPT_SchE_4');
             var lblBPT_SchE_5 = document.getElementById('lblBPT_SchE_5');
             var txtBPT_SchE_6A = document.getElementById('txtBPT_SchE_6A');
             var txtBPT_SchE_6B = document.getElementById('txtBPT_SchE_6B');
             var lblBPT_SchE_7 = document.getElementById('lblBPT_SchE_7');
             var lblBPT_SchE_8 = document.getElementById('lblBPT_SchE_8');
             var lblBPT_SchE_9 = document.getElementById('lblBPT_SchE_9');
             var lblBPT_SchE_10 = document.getElementById('lblBPT_SchE_10');
             var txtBPT_SchE_11A = document.getElementById('txtBPT_SchE_11A');
             var txtBPT_SchE_11B = document.getElementById('txtBPT_SchE_11B');
             var lblBPT_SchE_12 = document.getElementById('lblBPT_SchE_12');
             var lblBPT_SchE_13 = document.getElementById('lblBPT_SchE_13');
             var lblBPT_SchE_14 = document.getElementById('lblBPT_SchE_14');
             var lblBPT_SchE_15 = document.getElementById('lblBPT_SchE_15');


             if ($('#lblBPT_SchE_5').text() != '' && txtBPT_SchE_6A.value != '' && txtBPT_SchE_6B.value != '') {
                 $('#lblBPT_SchE_7').text(ispFormatMoney(PrepForMath(txtBPT_SchE_6A.value) + PrepForMath(txtBPT_SchE_6B.value), 0));
                 $('#lblBPT_SchE_8').text(ispFormatMoney(PrepForMath($('#lblBPT_SchE_5').text()) - PrepForMath($('#lblBPT_SchE_7').text()), 0));
             }		//if

             if (PrepForMath($('#lblBPT_SchE_8').text()) < 0) {
                 $('#lblBPT_SchE_9').text(ispFormatMoney(0, 0));
             } else {
                 $('#lblBPT_SchE_9').text(ispFormatMoney(PrepForMath($('#lblBPT_SchE_8').text()) * dBPTWholesaleRate, 0));
             }		//if
         }		//CalcSchdELine9

         function CalcSchdELine14() {

             var lblBPT_SchE_1 = document.getElementById('lblBPT_SchE_1');
             var txtBPT_SchE_2 = document.getElementById('txtBPT_SchE_2');
             var lblBPT_SchE_3 = document.getElementById('lblBPT_SchE_3');
             var lblBPT_SchE_4 = document.getElementById('lblBPT_SchE_4');
             var lblBPT_SchE_5 = document.getElementById('lblBPT_SchE_5');
             var txtBPT_SchE_6A = document.getElementById('txtBPT_SchE_6A');
             var txtBPT_SchE_6B = document.getElementById('txtBPT_SchE_6B');
             var lblBPT_SchE_7 = document.getElementById('lblBPT_SchE_7');
             var lblBPT_SchE_8 = document.getElementById('lblBPT_SchE_8');
             var lblBPT_SchE_9 = document.getElementById('lblBPT_SchE_9');
             var lblBPT_SchE_10 = document.getElementById('lblBPT_SchE_10');
             var txtBPT_SchE_11A = document.getElementById('txtBPT_SchE_11A');
             var txtBPT_SchE_11B = document.getElementById('txtBPT_SchE_11B');
             var lblBPT_SchE_12 = document.getElementById('lblBPT_SchE_12');
             var lblBPT_SchE_13 = document.getElementById('lblBPT_SchE_13');
             var lblBPT_SchE_14 = document.getElementById('lblBPT_SchE_14');
             var lblBPT_SchE_15 = document.getElementById('lblBPT_SchE_15');


             if ($('#lblBPT_SchE_10').text() != '' && txtBPT_SchE_11A.value != '' && txtBPT_SchE_11B.value != '') {
                 $('#lblBPT_SchE_12').text(ispFormatMoney(PrepForMath(txtBPT_SchE_11A.value) + PrepForMath(txtBPT_SchE_11B.value), 0));
                 $('#lblBPT_SchE_13').text(ispFormatMoney(PrepForMath($('#lblBPT_SchE_10').text()) - PrepForMath($('#lblBPT_SchE_12').text()), 0));
             }		//if

             if (PrepForMath($('#lblBPT_SchE_13').text()) < 0) {
                 $('#lblBPT_SchE_14').text(ispFormatMoney(0, 0));
             } else {
                 $('#lblBPT_SchE_14').text(ispFormatMoney(PrepForMath($('#lblBPT_SchE_13').text()) * dBPTRetailerRate, 0));
             }		//if
         }		//CalcSchdELine14

         function CalcSchdELine15() {

             var lblBPT_SchE_1 = document.getElementById('lblBPT_SchE_1');
             var txtBPT_SchE_2 = document.getElementById('txtBPT_SchE_2');
             var lblBPT_SchE_3 = document.getElementById('lblBPT_SchE_3');
             var lblBPT_SchE_4 = document.getElementById('lblBPT_SchE_4');
             var lblBPT_SchE_5 = document.getElementById('lblBPT_SchE_5');
             var txtBPT_SchE_6A = document.getElementById('txtBPT_SchE_6A');
             var txtBPT_SchE_6B = document.getElementById('txtBPT_SchE_6B');
             var lblBPT_SchE_7 = document.getElementById('lblBPT_SchE_7');
             var lblBPT_SchE_8 = document.getElementById('lblBPT_SchE_8');
             var lblBPT_SchE_9 = document.getElementById('lblBPT_SchE_9');
             var lblBPT_SchE_10 = document.getElementById('lblBPT_SchE_10');
             var txtBPT_SchE_11A = document.getElementById('txtBPT_SchE_11A');
             var txtBPT_SchE_11B = document.getElementById('txtBPT_SchE_11B');
             var lblBPT_SchE_12 = document.getElementById('lblBPT_SchE_12');
             var lblBPT_SchE_13 = document.getElementById('lblBPT_SchE_13');
             var lblBPT_SchE_14 = document.getElementById('lblBPT_SchE_14');
             var lblBPT_SchE_15 = document.getElementById('lblBPT_SchE_15');


             if ($('#lblBPT_SchE_4').text() != '' && $('#lblBPT_SchE_9').text() != '' && $('#lblBPT_SchE_14').text() != '') {
                 $('#lblBPT_SchE_15').text(ispFormatMoney(PrepForMath($('#lblBPT_SchE_4').text()) +
                         PrepForMath($('#lblBPT_SchE_9').text()) + PrepForMath($('#lblBPT_SchE_14').text()), 0));
                 $('#lblBPT_SchD_11').text($('#lblBPT_SchE_15').text());
             }		//if
         }		//CalcSchdELine15

         function VerifyTaxBasis(sSchd) {
             //	if (BPT_SchdE.style.display != 'none') {
             //alert(sSchd)


             /* if ($('#lblBPT_SchE_A').text() != '' && txtBPT_SchE_1.value != '' && txtBPT_SchE_5.value != ''
                      && txtBPT_SchE_10.value != '') {
                  if (PrepForMath($('#lblBPT_SchE_A').text()) != PrepForMath(txtBPT_SchE_1.value) +
                          PrepForMath(txtBPT_SchE_5.value) + PrepForMath(txtBPT_SchE_10.value)) {
                      if ($(parent.AppError).text() == '') {
                          if (sSchd == '') {
                              $(parent.AppError).text('The sum of lines 1, 5 and 10 have to equal the amount on line A');
                          } else {
                              $(parent.AppError).text('Schedule E is either incorrect becuase of a change to Line 7 or ' +
                                      'needs to filled out');
                          }		//if
                      }		//if
                  }		//if
              }		//if */ //binoy

             //	}		//if

         }		//VerifyTaxBasis
</script>
</head>
<body>
    <%--<div class="form_segment" id="BPT_SchdE" style="DISPLAY: none;">

                                <table summary="Employee Pay Sheet" class="hor-zebra" id="tblBptSchE">

                                    <tbody>

                                        <tr class="odd">
                                            <td width="70%"><B><U>2014 BIRT Schedule E: Computation Of Tax On 
    Gross Receipts</U></b><br>Alternate Method of Computing Tax on Gross Receipts<br>(To be used by 
    Manufacturers, Wholesalers and Retailers electing to use the Alternate Method of computation</td>
                                            <td align="center" class="no_border_right">
                                                
                                               </td>
                                        </tr>                                        
                                         <tr>
                                            <td><B>A. Manufacturers:</B></td>
                                            <td align="center" class="no_border_right">
                                             
                                               </td>
                                        </tr>
                                        <tr  class="odd">
                                            <td width="70%">1.  Receipts on which tax is to be computed by the Alternate 
    Method (from <label class="lblLink label_NoLeft" style="width:100%" onclick="ShowPage('SchdD')">Schedule D, Line 8</label>
			                                    <LABEL class="">).</LABEL>
                                            </td>
                                            <td align="center" class="no_border_right">
                                             <Label class="" id=lblBPT_SchE_1 style="WIDTH: 100%"  /></td>
                                        </tr>
                                        <tr >
                                            <td>2.  Cost of goods solds</td>
                                            <td align="center" class="no_border_right">
                                            <INPUT class="" id=txtBPT_SchE_2 style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange='ValidateWorksheet("BPT_SchdE")'></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">3. TAX BASE[Calculated - Line 1 minus Line 2]</td>
                                            <td align="center" class="no_border_right">
                                           <LABEL id=lblBPT_SchE_3 style="WIDTH: 100%"></LABEL></td>
                                        </tr>
                                        <tr >
                                            <td>4.  <b>TAX DUE</b><LABEL id=msgBPT_SchE_4 class="" style="width:100%">[Calculated - Multiply Line 3 by ###]&nbsp;</LABEL></td>
                                            <td align="center" class="no_border_right">
                                             <LABEL id=lblBPT_SchE_4 style="WIDTH: 100%"></LABEL>
                                               </td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%"><B>B. Wholesalers:</B>
                                            </td>
                                            <td align="center" class="no_border_right">
                                              
                                              </td>
                                        </tr>
                                        <tr >
                                            <td>5.  Receipts on which tax is to be computed by the Alternate 
    Method (from <label class="lblLink label_NoLeft" style="width:100%" onclick="ShowPage('SchdD')">Schedule D, Line 8</label>
			                                    <label id="Label1" style="display:none"></label>
			                                    ).</td>
                                            <td align="center" class="no_border_right">
                                             <Label class="" id=lblBPT_SchE_5 style="WIDTH: 100%"  /></td>
                                        </tr>
                                        <tr class="odd">
                                            <td >Applicable Cost of Goods:</td>
                                            <td align="center" class="no_border_right">
                                            
                                            </td>
                                        </tr>
                                        <tr >
                                            <td>6a.  Cost of material</td>
                                            <td align="center" class="no_border_right">
                                              <INPUT class="" id=txtBPT_SchE_6A style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange='ValidateWorksheet("BPT_SchdE")'></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">6b. Cost of labor</td>
                                            <td align="center" class="no_border_right">
                                        <INPUT class="" id=txtBPT_SchE_6B style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange='ValidateWorksheet("BPT_SchdE")'>
                                            </td>
                                        </tr>
                                        <tr >
                                            <td width="70%">7.  TOTAL APPLICABLE COST OF GOODS[Calculated - Line 6a plus Line 6b]</td>
                                            <td align="center" class="no_border_right">
                                          <LABEL id=lblBPT_SchE_7 style="WIDTH: 100%"></LABEL>
                                            </td>
                                        </tr>
                                        <tr class="odd">
                                            <td>8.  TAX BASE[Calculated - Line 5 minus Line 7]</td>
                                            <td align="center" class="no_border_right">
                                              <LABEL id=lblBPT_SchE_8 style="WIDTH: 100%"></LABEL></td>
                                        </tr>
                                         <tr >
                                            <td width="70%">9.  <b>TAX DUE</b><LABEL id=msgBPT_SchE_9 class="" style="width:100%">[Calculated - Multiply Line 8 by ###]&nbsp;</LABEL></td>
                                            <td align="center" class="no_border_right">
                                         <LABEL id=lblBPT_SchE_9 style="WIDTH: 100%"></LABEL>
                                            </td>
                                        </tr>
                                      
                                          <tr class="odd">
                                            <td width="70%"><B>C. Retailers:</B></td>
                                            <td align="center" class="no_border_right">
                                       
                                            </td>
                                        </tr>

                                         <tr >
                                            <td width="70%">10.  Receipts on which tax is to be computed by the Alternate 
    Method (from <label class="lblLink label_NoLeft" style="width:100%" onclick="ShowPage('SchdD')">Schedule D, Line 8</label>
			                                    <label id="Label2">
			                                    ).</label></td>
                                            <td align="center" class="no_border_right">
                                      <LABEL id=lblBPT_SchE_10 style="WIDTH: 100%"></LABEL>
                                            </td>
                                        </tr>

                                         <tr class="odd">
                                            <td width="70%">Applicable Cost of Goods:</td>
                                            <td align="center" class="no_border_right">
                                       
                                            </td>
                                        </tr>
                                          <tr >
                                            <td width="70%">11a.  Cost of material</td>
                                            <td align="center" class="no_border_right">
                                       <INPUT class="" id=txtBPT_SchE_11A style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange='ValidateWorksheet("BPT_SchdE")'>
                                            </td>
                                        </tr>
                                          <tr class="odd">
                                            <td width="70%">11b.  Cost of labor</td>
                                            <td align="center" class="no_border_right">
                                       <INPUT class="" id=txtBPT_SchE_11B style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange='ValidateWorksheet("BPT_SchdE")'>
                                            </td>
                                        </tr>
                                      
                                         <tr>
                                            <td width="70%">12.  TOTAL APPLICABLE COST OF GOODS[Calculated - Line 11a plus Line 11b]</td>
                                            <td align="center" class="no_border_right">
                                      <LABEL id=lblBPT_SchE_12 style="WIDTH: 100%"></LABEL>
                                            </td>
                                        </tr>
                                          <tr  class="odd">
                                            <td width="70%">13.  TAX BASE[Calculated - Line 10 minus Line 12]</td>
                                            <td align="center" class="no_border_right">
                                      <LABEL id=lblBPT_SchE_13 style="WIDTH: 100%"></LABEL>
                                            </td>
                                        </tr>

                                          <tr >
                                            <td width="70%">14.  <b>TAX DUE</b><LABEL id=msgBPT_SchE_14 class="">[Calculated - Multiply Line 13 by ###]&nbsp;</LABEL></td>
                                            <td align="center" class="no_border_right">
                                    <LABEL id=lblBPT_SchE_14 style="WIDTH: 100%"></LABEL>
                                            </td>
                                        </tr>
                                          <tr class="odd">
                                            <td width="70%">15.  <b>TOTAL TAX DUE</b>[Calculated - Sum Lines 4, 9 and 14]</td>
                                            <td align="center" class="no_border_right">
                                   <LABEL id=lblBPT_SchE_15 style="WIDTH: 100%"></LABEL>
                                            </td>
                                        </tr>

                                        <tr >
                                            <td></td>
                                            <td align="center" class="no_border_right">
                                                <div class="form_segment here_input_table" align="right">
                                               <input type="button" value="Return to Schedule D" class="submit_button2" id="btnGoToPage1" onclick='ShowPage("SchdD")' />
                                                    </div>
                                                    </td>
                                        </tr>

                                         
                                    </tbody>
                                </table>
                                <div class="clear"></div>

                            </div>--%>

 <%--     <div class="container-fluid no-padding">
    <div class="block3">
        
     <div class="container-fluid">
     
     <div class="row">--%>
     
     <div class="col-lg-12 col-md-12" id="BPT_SchdE" style="DISPLAY: none;">   
          <div class="row">
                    <div class="col-lg-12 templateclass">
     
                                <div class="table-responsive">
                                
                                	<table class="table table-condensed table-striped custom_table03">
                                    
                                    	<thead>
                                        	<tr>
                                            	<th colspan="3" width="100%"><u><B>2014 BIRT Schedule E: Computation Of Tax On 
    Gross Receipts</U></B><br>Alternate Method of Computing Tax on Gross Receipts<br>(To be used by 
    Manufacturers, Wholesalers and Retailers electing to use the Alternate Method of computation</th>
                                       
                                            </tr>

                                        </thead>
                                        
                                        <tbody>
                                        	<tr>
                                            	<td width="5%">A.</td>
                                                <td width="70%" class="text-left">Total Tax Basis (from Schedule D, Line 7)</td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="input-group">
                                                               <LABEL id=lblBPT_SchE_A style="WIDTH: 100%"></LABEL>
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                            <tr>
                                            	<td width="5%"><B></B></td>
                                                <td width="70%" class="text-left"><B>Manufacturers:</B></td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="input-group">
                                                               
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                           
                                     		<tr class="odd">
                                            	<td width="5%">1.</td>
                                                <td width="70%" class="text-left">Receipts on which tax is to be computed by the Alternate 
    Method (from <label class="lblLink label_NoLeft" style="width:100%" onclick="ShowPage('SchdD')">Schedule D, Line 8</label>
			                                    <LABEL class="">).</LABEL></td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                             <Label id=lblBPT_SchE_1 style="WIDTH: 100%" class="form-control input-sm"  />
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                            <tr>
                                            	<td width="5%">2.</td>
                                                <td width="70%" class="text-left"> Cost of goods solds</td>
				
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                          
                                                                       <INPUT class="form-control input-sm" id=txtBPT_SchE_2 style="WIDTH: 100%" 
      onfocus=SetFocus() onchange='ValidateWorksheet("BPT_SchdE")'
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                     		<tr class="odd">
                                            	<td width="5%">3.</td>
                                                <td width="70%" class="text-left">TAX BASE[Calculated - Line 1 minus Line 2]</td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                                <LABEL id=lblBPT_SchE_3 style="WIDTH: 100%" class="form-control input-sm"></LABEL>
                                                          </div>
                                                       </div>
                                            		</form>
                                                </td>
                                            </tr>
                                          
                                            <tr>
                                            	<td width="5%">4.</td>
                                                <td width="70%" class="text-left"><b>TAX DUE</b><LABEL id=msgBPT_SchE_4 class="" style="width:100%">[Calculated - Multiply Line 3 by ###]&nbsp;</LABEL></td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                               <LABEL id=lblBPT_SchE_4 style="WIDTH: 100%" class="form-control input-sm" ></LABEL>
                                                               
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                           
                                            <tr class="odd">
                                            	<td width="5%">&nbsp;</td>
                                                <td width="70%" class="text-left"><b>Wholesalers:</b>
                                               </td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="input-group">
                                                           </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                            <tr>
                                            	<td width="5%">5.</td>
                                                <td width="70%" class="text-left">Rentals of real property outside of Philadelphia Receipts on which tax is to be computed by the Alternate 
    Method (from <label class="lblLink label_NoLeft" style="width:100%" onclick="ShowPage('SchdD')">Schedule D, Line 8</label>
			                                    <label id="Label1" style="display:none"></td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                              <Label id=lblBPT_SchE_5 style="WIDTH: 100%" class="form-control input-sm" />
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                     		<tr class="odd">
                                            	<td width="5%"></td>
                                                <td width="70%" class="text-left">Applicable Cost of Goods:</td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                             
                                                                 &nbsp;</div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                            <tr>
                                            	<td width="5%">6a.</td>
                                                <td width="70%" class="text-left">Cost of material</td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                                  <INPUT class="form-control input-sm" id=txtBPT_SchE_6A style="WIDTH: 100%" 
      onfocus=SetFocus() onchange='ValidateWorksheet("BPT_SchdE")'/>
                                                               
                                                            </div>
                                                          </div>
                                            
                                            		</form>

                                                </td>
                                            </tr>
                                            
                                            <tr class="odd">
                                            	<td width="5%">6b.</td>
                                                <td width="70%" class="text-left"> Cost of labor
                                        </td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                                <INPUT class="form-control input-sm" id=txtBPT_SchE_6B style="WIDTH: 100%" 
      onfocus=SetFocus() onchange='ValidateWorksheet("BPT_SchdE")'>
                                                                
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                            <tr>
                                            	<td width="5%">7.</td>
                                                <td width="70%" class="text-left">TOTAL APPLICABLE COST OF GOODS[Calculated - Line 6a plus Line 6b]</td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                                <LABEL id=lblBPT_SchE_7 style="WIDTH: 100%" class="form-control input-sm"></LABEL>
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                     		<tr class="odd">
                                            	<td width="5%">8.</td>
                                                <td width="70%" class="text-left">TAX BASE[Calculated - Line 5 minus Line 7]</td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                                 <LABEL id=lblBPT_SchE_8 class="form-control input-sm"></LABEL>
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                            <tr>
                                            	<td width="5%">9.</td>
                                                <td width="70%" class="text-left"> <b>TAX DUE</b><LABEL id=msgBPT_SchE_9 class="" style="width:100%">[Calculated - Multiply Line 8 by ###]&nbsp;</LABEL></td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                               <LABEL id=lblBPT_SchE_9 class="form-control input-sm"></LABEL>
                                                            </div>
                                                          </div>
                                            
                                            		</form>

                                                </td>
                                            </tr>
                                                <tr class="odd">
                                            	<td width="5%">&nbsp;</td>
                                                <td width="70%" class="text-left"><b>Retailers:</b>
                                               </td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="input-group">
                                                           </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                            <tr class="odd">
                                            	<td width="5%">10.</td>
                                                <td width="70%" class="text-left"> Receipts on which tax is to be computed by the Alternate 
    Method (from <label class="lblLink label_NoLeft" style="width:100%" onclick="ShowPage('SchdD')">Schedule D, Line 8</label>
			                                    <label id="Label2">
			                                    ).</label></td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                                  <LABEL id=lblBPT_SchE_10 style="WIDTH: 100%" class="form-control input-sm"></LABEL>
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                           <tr>
                                            	<td width="5%"></td>
                                                <td width="70%" class="text-left"><b>Applicable Cost of Goods:</b></td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                              
                                                            </div>
                                                          </div>
                                            
                                            		</form>

                                                </td>
                                            </tr>
                                            <tr class="odd">
                                            	<td width="5%">11a.</td>
                                                <td width="70%" class="text-left">Cost of material</td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                                  <INPUT class="" id=txtBPT_SchE_11A style="WIDTH: 100%" 
      onfocus=SetFocus() class="form-control input-sm" onchange='ValidateWorksheet("BPT_SchdE")'> 
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                            <tr>
                                            	<td width="5%">11b.</td>
                                                <td width="70%" class="text-left">Cost of labor</td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                               <INPUT id=txtBPT_SchE_11B style="WIDTH: 100%" 
      onfocus=SetFocus() class="form-control input-sm" onchange='ValidateWorksheet("BPT_SchdE")'>
                                                            </div>
                                                          </div>
                                            
                                            		</form>

                                                </td>
                                            </tr>
                                            <tr class="odd">
                                            	<td width="5%">12.</td>
                                                <td width="70%" class="text-left"> TOTAL APPLICABLE COST OF GOODS[Calculated - Line 11a plus Line 11b]</td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                                    <LABEL id=lblBPT_SchE_12 style="WIDTH: 100%" class="form-control input-sm"></LABEL>
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr><tr>
                                            	<td width="5%">13.</td>
                                                <td width="70%" class="text-left">TAX BASE[Calculated - Line 10 minus Line 12]</td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                                <LABEL id=lblBPT_SchE_13 style="WIDTH: 100%" class="form-control input-sm"></LABEL>
                                                            </div>
                                                          </div>
                                            
                                            		</form>

                                                </td>
                                            </tr>
                                            <tr class="odd">
                                            	<td width="5%">14.</td>
                                                <td width="70%" class="text-left">  <b>TAX DUE</b><LABEL id=msgBPT_SchE_14 class="">[Calculated - Multiply Line 13 by ###]&nbsp;</LABEL></td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                                    <LABEL id=lblBPT_SchE_14 style="WIDTH: 100%" class="form-control input-sm"></LABEL>
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                            <tr>
                                            	<td width="5%">15.</td>
                                                <td width="70%" class="text-left"><b>TOTAL TAX DUE</b>[Calculated - Sum Lines 4, 9 and 14]</td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                               <LABEL id=lblBPT_SchE_15 style="WIDTH: 100%" class="form-control input-sm"></LABEL>
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
                                            <input type="button" value="Return to Schedule D" class="submit_button2" id="btnGoToPage1" onclick='ShowPage("SchdD")' />
                                        </div>
                                  </div>
                                
                                </form>
                        </div>
              </div>
         </div>
                               
</body>
</html>

