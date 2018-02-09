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
    <!-- WARNING: Respond.js doesn't work if you view the page via file -->
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

             var txtBPT_SchE_2 = document.getElementById('txtBPT_SchE_2');
             var txtBPT_SchE_6A = document.getElementById('txtBPT_SchE_6A');
             var txtBPT_SchE_6B = document.getElementById('txtBPT_SchE_6B');
             var txtBPT_SchE_11A = document.getElementById('txtBPT_SchE_11A');
             var txtBPT_SchE_11B = document.getElementById('txtBPT_SchE_11B');

             var i = 0;

             arrSchdEErr[i++] = [txtBPT_SchE_2, '$(\'#txtBPT_SchE_2\').val() == ""', 'Answer question 2'];
             arrSchdEErr[i++] = [txtBPT_SchE_2, 'ispValue($(\'#txtBPT_SchE_2\').val()) == false', 'Value for question 2 must be numeric'];
             arrSchdEErr[i++] = [txtBPT_SchE_2, 'ispNegativeNumber($(\'#txtBPT_SchE_2\').val()) == false', 'Value for question 2 must not be negative'];

             arrSchdEErr[i++] = [txtBPT_SchE_6A, '$(\'#txtBPT_SchE_6A\').val() == ""', 'Answer question 6a'];
             arrSchdEErr[i++] = [txtBPT_SchE_6A, 'ispValue($(\'#txtBPT_SchE_6A\').val()) == false', 'Value for question 6a must be numeric'];
             arrSchdEErr[i++] = [txtBPT_SchE_6A, 'ispNegativeNumber($(\'#txtBPT_SchE_6A\').val()) == false', 'Value for question 6a must not be negative'];

             arrSchdEErr[i++] = [txtBPT_SchE_6B, '$(\'#txtBPT_SchE_6B\').val() == ""', 'Answer question 6b'];
             arrSchdEErr[i++] = [txtBPT_SchE_6B, 'ispValue($(\'#txtBPT_SchE_6B\').val()) == false', 'Value for question 6b must be numeric'];
             arrSchdEErr[i++] = [txtBPT_SchE_6B, 'ispNegativeNumber($(\'#txtBPT_SchE_6B\').val()) == false', 'Value for question 6b must not be negative'];

             arrSchdEErr[i++] = [txtBPT_SchE_11A, '$(\'#txtBPT_SchE_11A\').val() == ""', 'Answer question 11a'];
             arrSchdEErr[i++] = [txtBPT_SchE_11A, 'ispValue($(\'#txtBPT_SchE_11A\').val()) == false', 'Value for question 11a must be numeric'];
             arrSchdEErr[i++] = [txtBPT_SchE_11A, 'ispNegativeNumber($(\'#txtBPT_SchE_11A\').val()) == false', 'Value for question 11a must not be negative'];

             arrSchdEErr[i++] = [txtBPT_SchE_11B, '$(\'#txtBPT_SchE_11B\').val() == ""', 'Answer question 11b'];
             arrSchdEErr[i++] = [txtBPT_SchE_11B, 'ispValue($(\'#txtBPT_SchE_11B\').val()) == false', 'Value for question 11b must be numeric'];
             arrSchdEErr[i++] = [txtBPT_SchE_11B, 'ispNegativeNumber($(\'#txtBPT_SchE_11B\').val()) == false', 'Value for question 11b must not be negative'];
         }		//LoadErrorBPTlfSchdE

         function ClearBPTlfSchdE() {

             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScELi1, '', 0);
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScELi2, '', 0);
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScELi3, '', 0);
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScELi4, '', 0);
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScELi5, '', 0);
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScELi6a, '', 0);
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScELi6b, '', 0);
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScELi7, '', 0);
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScELi8, '', 0);
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScELi9, '', 0);
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScELi10, '', 0);
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScELi11a, '', 0);
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScELi11b, '', 0);
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScELi12, '', 0);
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScELi13, '', 0);
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScELi14, '', 0);
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScELi15, '', 0);

         }		//ClearBPTlfSchdE
         function RightAlignText_E() {//Added 
             $('#txtBPT_SchE_2').css('text-align', 'right');
             $('#txtBPT_SchE_6A').css('text-align', 'right');
             $('#txtBPT_SchE_6B').css('text-align', 'right');
             $('#txtBPT_SchE_11A').css('text-align', 'right');
             $('#txtBPT_SchE_11B').css('text-align', 'right');
             $('#txtBPT_SchE_1').css('text-align', 'right');
             $('#txtBPT_SchE_5').css('text-align', 'right');
             $('#txtBPT_SchE_10').css('text-align', 'right');

             
             $('#lblBPT_SchE_3').parent().css("text-align", "right");
             $('#lblBPT_SchE_4').parent().css("text-align", "right");
            
             $('#lblBPT_SchE_7').parent().css("text-align", "right");
             $('#lblBPT_SchE_8').parent().css("text-align", "right");

             $('#lblBPT_SchE_9').parent().css("text-align", "right");
             
             $('#lblBPT_SchE_12').parent().css("text-align", "right");
             $('#lblBPT_SchE_13').parent().css("text-align", "right");
             $('#lblBPT_SchE_14').parent().css("text-align", "right");
             $('#lblBPT_SchE_15').parent().css("text-align", "right");
         }
         function PopulateBPTlfSchdE() {

             var txtBPT_SchE_1 = document.getElementById('txtBPT_SchE_1');
             var txtBPT_SchE_2 = document.getElementById('txtBPT_SchE_2');
             var lblBPT_SchE_3 = document.getElementById('lblBPT_SchE_3');
             var lblBPT_SchE_4 = document.getElementById('lblBPT_SchE_4');
             var txtBPT_SchE_5 = document.getElementById('txtBPT_SchE_5');
             var txtBPT_SchE_6A = document.getElementById('txtBPT_SchE_6A');
             var txtBPT_SchE_6B = document.getElementById('txtBPT_SchE_6B');
             var lblBPT_SchE_7 = document.getElementById('lblBPT_SchE_7');
             var lblBPT_SchE_8 = document.getElementById('lblBPT_SchE_8');
             var lblBPT_SchE_9 = document.getElementById('lblBPT_SchE_9');
             var txtBPT_SchE_10 = document.getElementById('txtBPT_SchE_10');
             var txtBPT_SchE_11A = document.getElementById('txtBPT_SchE_11A');
             var txtBPT_SchE_11B = document.getElementById('txtBPT_SchE_11B');
             var lblBPT_SchE_12 = document.getElementById('lblBPT_SchE_12');
             var lblBPT_SchE_13 = document.getElementById('lblBPT_SchE_13');
             var lblBPT_SchE_14 = document.getElementById('lblBPT_SchE_14');
             var lblBPT_SchE_15 = document.getElementById('lblBPT_SchE_15');


             
             txtBPT_SchE_1.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScELi1, '', 0), 0);
             txtBPT_SchE_2.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScELi2, '', 0), 0);
             $('#lblBPT_SchE_3').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScELi3, '', 0), 0));
             $('#lblBPT_SchE_4').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScELi4, '', 0), 0));
             txtBPT_SchE_5.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScELi5, '', 0), 0);
           
             txtBPT_SchE_6A.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScELi6a, '', 0), 0);
             txtBPT_SchE_6B.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScELi6b, '', 0), 0);
             $('#lblBPT_SchE_7').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScELi7, '', 0), 0));
             $('#lblBPT_SchE_8').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScELi8, '', 0), 0));
             $('#lblBPT_SchE_9').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScELi9, '', 0), 0));
             txtBPT_SchE_10.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScELi10, '', 0), 0);
             
             txtBPT_SchE_11A.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScELi11a, '', 0), 0);
             txtBPT_SchE_11B.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScELi11b, '', 0), 0);
             $('#lblBPT_SchE_12').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScELi12, '', 0), 0));
             $('#lblBPT_SchE_13').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScELi13, '', 0), 0));
             $('#lblBPT_SchE_14').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScELi14, '', 0), 0));
             $('#lblBPT_SchE_15').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScELi15, '', 0), 0));

             $('#msgBPT_SchE_4').text($('#msgBPT_SchE_4').text().replace('###', dBPTManufacturerRate));
             $('#msgBPT_SchE_9').text($('#msgBPT_SchE_9').text().replace('###', dBPTWholesaleRate));
             $('#msgBPT_SchE_14').text($('#msgBPT_SchE_14').text().replace('###', dBPTRetailerRate));
         }		//PopulateBPTlfSchdE

         function PopulateXmlBPTlfSchdE() {
             var txtBPT_SchE_1 = document.getElementById('txtBPT_SchE_1');
             var txtBPT_SchE_2 = document.getElementById('txtBPT_SchE_2');
             var lblBPT_SchE_3 = document.getElementById('lblBPT_SchE_3');
             var lblBPT_SchE_4 = document.getElementById('lblBPT_SchE_4');
             var txtBPT_SchE_5 = document.getElementById('txtBPT_SchE_5');
             var txtBPT_SchE_6A = document.getElementById('txtBPT_SchE_6A');
             var txtBPT_SchE_6B = document.getElementById('txtBPT_SchE_6B');
             var lblBPT_SchE_7 = document.getElementById('lblBPT_SchE_7');
             var lblBPT_SchE_8 = document.getElementById('lblBPT_SchE_8');
             var lblBPT_SchE_9 = document.getElementById('lblBPT_SchE_9');
             var txtBPT_SchE_10 = document.getElementById('txtBPT_SchE_10');
             var txtBPT_SchE_11A = document.getElementById('txtBPT_SchE_11A');
             var txtBPT_SchE_11B = document.getElementById('txtBPT_SchE_11B');
             var lblBPT_SchE_12 = document.getElementById('lblBPT_SchE_12');
             var lblBPT_SchE_13 = document.getElementById('lblBPT_SchE_13');
             var lblBPT_SchE_14 = document.getElementById('lblBPT_SchE_14');
             var lblBPT_SchE_15 = document.getElementById('lblBPT_SchE_15');



             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchE_1.value), xFldScELi1, '', 0) //binoy

             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchE_2.value), xFldScELi2, '', 0)
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchE_3').text()), xFldScELi3, '', 0)
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchE_4').text()), xFldScELi4, '', 0)
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchE_5.value), xFldScELi5, '', 0)
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchE_6A.value), xFldScELi6a, '', 0)
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchE_6B.value), xFldScELi6b, '', 0)
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchE_7').text()), xFldScELi7, '', 0)
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchE_8').text()), xFldScELi8, '', 0)
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchE_9').text()), xFldScELi9, '', 0)
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchE_10.value), xFldScELi10, '', 0)
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchE_11A.value), xFldScELi11a, '', 0)
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchE_11B.value), xFldScELi11b, '', 0)
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchE_12').text()), xFldScELi12, '', 0)
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchE_13').text()), xFldScELi13, '', 0)
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchE_14').text()), xFldScELi14, '', 0)
             parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchE_15').text()), xFldScELi15, '', 0)

         }		//PopulateXmlBPTlfSchdE

         function FieldLockBPTlfSchdE(bDisabled) {
             $('#txtBPT_SchE_1').attr('disabled', bDisabled);
             $('#txtBPT_SchE_2').attr('disabled', bDisabled);
             $('#lblBPT_SchE_3').attr('disabled', bDisabled);
             $('#lblBPT_SchE_4').attr('disabled', bDisabled);
             $('#txtBPT_SchE_5').attr('disabled', bDisabled);
             $('#txtBPT_SchE_6A').attr('disabled', bDisabled);
             $('#txtBPT_SchE_6B').attr('disabled', bDisabled);
             $('#lblBPT_SchE_7').attr('disabled', bDisabled);
             $('#lblBPT_SchE_8').attr('disabled', bDisabled);
             $('#lblBPT_SchE_9').attr('disabled', bDisabled);
             $('#txtBPT_SchE_10').attr('disabled', bDisabled);
             $('#txtBPT_SchE_11A').attr('disabled', bDisabled);
             $('#txtBPT_SchE_11B').attr('disabled', bDisabled);
             $('#lblBPT_SchE_12').attr('disabled', bDisabled);
             $('#lblBPT_SchE_13').attr('disabled', bDisabled);
             $('#lblBPT_SchE_14').attr('disabled', bDisabled);
             $('#lblBPT_SchE_15').attr('disabled', bDisabled);
         }		//FieldLockBPTlfSchdE

         function PerformCalcsBPTlfSchdE() {

             CalcSchdELine4();
             CalcSchdELine9();
             CalcSchdELine14();
             CalcSchdELine15();
             VerifyTaxBasis();
         }		//PerformCalcsBPTlfSchdE

         function CalcSchdELine4() {
             if ($('#txtBPT_SchE_1').val() != '' && $('#txtBPT_SchE_2').val() != '') {
                 $('#lblBPT_SchE_3').text(ispFormatMoney(PrepForMath($('#txtBPT_SchE_1').val()) - PrepForMath($('#txtBPT_SchE_2').val()), 0));
             }		//if

             if (PrepForMath($('#lblBPT_SchE_3').text()) < 0) {
                 $('#lblBPT_SchE_4').text(ispFormatMoney(0, 0));
             } else {
                 $('#lblBPT_SchE_4').text(ispFormatMoney(PrepForMath($('#lblBPT_SchE_3').text()) * dBPTManufacturerRate, 0));
             }		//if
         }		//CalcSchdELine4

         function CalcSchdELine9() {
             if ($('#txtBPT_SchE_5').val() != '' && $('#txtBPT_SchE_6A').val() != '' && $('#txtBPT_SchE_6B').val() != '') {
                 $('#lblBPT_SchE_7').text(ispFormatMoney(PrepForMath($('#txtBPT_SchE_6A').val()) + PrepForMath($('#txtBPT_SchE_6B').val()), 0));
                 $('#lblBPT_SchE_8').text(ispFormatMoney(PrepForMath($('#txtBPT_SchE_5').val()) - PrepForMath($('#lblBPT_SchE_7').text()), 0));
             }		//if

             if (PrepForMath($('#lblBPT_SchE_8').text()) < 0) {
                 $('#lblBPT_SchE_9').text(ispFormatMoney(0, 0));
             } else {
                 $('#lblBPT_SchE_9').text(ispFormatMoney(PrepForMath($('#lblBPT_SchE_8').text()) * dBPTWholesaleRate, 0));
             }		//if
         }		//CalcSchdELine9

         function CalcSchdELine14() {
             if ($('#txtBPT_SchE_10').val() != '' && $('#txtBPT_SchE_11A').val() != '' && $('#txtBPT_SchE_11B').val() != '') {
                 $('#lblBPT_SchE_12').text(ispFormatMoney(PrepForMath($('#txtBPT_SchE_11A').val()) + PrepForMath($('#txtBPT_SchE_11B').val()), 0));
                 $('#lblBPT_SchE_13').text(ispFormatMoney(PrepForMath($('#txtBPT_SchE_10').val()) - PrepForMath($('#lblBPT_SchE_12').text()), 0));
             }		//if

             if (PrepForMath($('#lblBPT_SchE_13').text()) < 0) {
                 $('#lblBPT_SchE_14').text(ispFormatMoney(0, 0));
             } else {
                 $('#lblBPT_SchE_14').text(ispFormatMoney(PrepForMath($('#lblBPT_SchE_13').text()) * dBPTRetailerRate, 0));
             }		//if
         }		//CalcSchdELine14

         function CalcSchdELine15() {
             if ($('#lblBPT_SchE_4').text() != '' && $('#lblBPT_SchE_9').text() != '' && $('#lblBPT_SchE_14').text() != '') {
                 $('#lblBPT_SchE_15').text(ispFormatMoney(PrepForMath($('#lblBPT_SchE_4').text()) +
                         PrepForMath($('#lblBPT_SchE_9').text()) + PrepForMath($('#lblBPT_SchE_14').text()), 0));
             }		//if
         }		//CalcSchdELine15

         function VerifyTaxBasis(sSchd) {
             
             var s1, s2, s3, s4, s5;
             s1 = PrepForMath($('#lblBPT_SchE_A').text());
             s2 = PrepForMath($('#txtBPT_SchE_1').val());
             s3 = PrepForMath($('#txtBPT_SchE_5').val());
             s4 = PrepForMath($('#txtBPT_SchE_10').val());
             s5 = (s2 + s3 + s4);
            

             if ($('#lblBPT_SchE_A').text() != '' && $('#txtBPT_SchE_1').val() != '' && $('#txtBPT_SchE_5').val() != ''
                    && $('#txtBPT_SchE_10').val() != '') {

                 if (s1 != s5) {
                     if ($(parent.AppError).text() == '') {
                         
                         if (sSchd == '') {
                             $(AppError).text('The sum of lines 1, 5 and 10 have to equal the amount on line A');
                         } else {
                             $(AppError).text('Schedule E is either incorrect because of a change to Line 7 or ' +
                                     'needs to filled out');
                         }		//if
                     }		//if
                 }		//if
             }		//if */ //binoy
              
             if ($('#txtBPT_SchD_7').val() != '' && $('#lblBPT_SchE_15').text() == '') {
                 $(AppError).text('Schedule E needs to filled out');
             }

             //}		//if

         }		//VerifyTaxBasis
</script>
</head>
<body>
    
     <div id="BPT_SchdE" style="DISPLAY: none;"> 
      <div class="col-lg-12 col-md-12">   
          <div class="row">
                    <div class="col-lg-12 templateclass">
     
                                <div class="table-responsive">
                                
                                	<table class="table table-condensed table-striped custom_table03 wage-table-print">
                                    
                                    	<thead>
                                        	<tr>
                                            	<th colspan="3" width="100%" class="slim-headings"><B>2013 BIRT Schedule E: Computation Of Tax On 
    Gross Receipts</B><br>Alternate Method of Computing Tax on Gross Receipts<br>(To be used by 
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
                                                            <div class="">
                                                                <LABEL id="lblBPT_SchE_A"  class="form-control input-sm"></LABEL>
                                                          </div>
                                                       </div>
                                            		</form>
                                                </td>

                                              
                                            </tr>
                                            <tr>
                                            	<td width="5%"><B>Manufacturers:</B></td>
                                                <td width="70%" class="text-left"><B></B></td>
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
    Method 
			                                    <LABEL class=""></LABEL></td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                           
                                        <INPUT class="form-control input-sm pull-right" id="txtBPT_SchE_1" type="text" style="WIDTH: 100%" 
      onfocus="SetFocus()" onchange="ValidateWorksheet('BPT_SchdE')"/>
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
                                                          
                                                                       <INPUT class="form-control input-sm" id=txtBPT_SchE_2 type="text" style="WIDTH: 100%" 
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
                                            	<td width="5%"><b>Wholesalers:</b></td>
                                                <td width="70%" class="text-left"><b></b>
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
    Method 
			                                    <label id="Label1" style="display:none"></td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                              
                                                                <INPUT class="form-control input-sm" id=txtBPT_SchE_5 type="text" style="WIDTH: 100%" 
      onfocus=SetFocus() onchange='ValidateWorksheet("BPT_SchdE")'/>
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
                                                                  <INPUT class="form-control input-sm" id=txtBPT_SchE_6A type="text" style="WIDTH: 100%" 
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
                                                                <INPUT class="form-control input-sm" id=txtBPT_SchE_6B type="text" style="WIDTH: 100%" 
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
                                            	<td width="5%"><b>Retailers:</b></td>
                                                <td width="70%" class="text-left">
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
    Method 
			                                    <label id="Label2">
			                                    </label></td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                               
                                                                 <INPUT class="form-control input-sm" id="txtBPT_SchE_10" type="text" style="WIDTH: 100%" 
                                                                    onfocus=SetFocus() onchange='ValidateWorksheet("BPT_SchdE")'/>
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
                                                                  <INPUT  id=txtBPT_SchE_11A type="text" style="WIDTH: 100%" 
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
                                                               <INPUT id=txtBPT_SchE_11B type="text" style="WIDTH: 100%" 
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

                                
                                	<div class="form-group page-print-wage-section">
                                        <div class="col-sm-offset-3 col-sm-9  text-right">
                                     
                                            <input type="button" value="Return to Schedule D" class="submit_button2" id="btnGoToPage1" onclick='ShowPage("SchdD")' />
                                        </div>
                                  </div>
                                
                                </form>
                        </div>
              </div>
         </div>

     </div>
         
    <div class="lets-split"></div>
                          
</body>
</html>

