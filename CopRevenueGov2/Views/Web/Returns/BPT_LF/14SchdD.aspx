<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>

    <title></title>
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
            var txtBPT_SchD_5A = document.getElementById('txtBPT_SchD_5A');
            var txtBPT_SchD_5B = document.getElementById('txtBPT_SchD_5B');
            var txtBPT_SchD_5C = document.getElementById('txtBPT_SchD_5C');
            var txtBPT_SchD_5D = document.getElementById('txtBPT_SchD_5D');
           // var txtBPT_SchD_7 = document.getElementById('txtBPT_SchD_7');
            var txtBPT_SchD_8 = document.getElementById('txtBPT_SchD_8');

            var i = 0;
            arrSchdDErr[i++] = [txtBPT_SchD_1, '$(\'#txtBPT_SchD_1\').val() == ""', 'Answer question 1'];
            arrSchdDErr[i++] = [txtBPT_SchD_1, 'ispValue($(\'#txtBPT_SchD_1\').val()) == false', 'Value for question 1 must be numeric'];
            arrSchdDErr[i++] = [txtBPT_SchD_1, 'ispNegativeNumber($(\'#txtBPT_SchD_1\').val()) == false', 'Value for question 1 must not be negative'];

            arrSchdDErr[i++] = [txtBPT_SchD_2, '$(\'#txtBPT_SchD_2\').val() == ""', 'Answer question 2'];
            arrSchdDErr[i++] = [txtBPT_SchD_2, 'ispValue($(\'#txtBPT_SchD_2\').val()) == false', 'Value for question 2 must be numeric'];
            arrSchdDErr[i++] = [txtBPT_SchD_2, 'ispNegativeNumber($(\'#txtBPT_SchD_2\').val()) == false', 'Value for question 2 must not be negative'];

            arrSchdDErr[i++] = [txtBPT_SchD_3, '$(\'#txtBPT_SchD_3\').val() == ""', 'Answer question 3'];
            arrSchdDErr[i++] = [txtBPT_SchD_3, 'ispValue($(\'#txtBPT_SchD_3\').val()) == false', 'Value for question 3 must be numeric'];
            arrSchdDErr[i++] = [txtBPT_SchD_3, 'ispNegativeNumber($(\'#txtBPT_SchD_3\').val()) == false', 'Value for question 3 must not be negative'];

            arrSchdDErr[i++] = [txtBPT_SchD_5A, '$(\'#txtBPT_SchD_5A\').val() == ""', 'Answer question 5a'];
            arrSchdDErr[i++] = [txtBPT_SchD_5A, 'ispValue($(\'#txtBPT_SchD_5A\').val()) == false', 'Value for question 5a must be numeric'];
            arrSchdDErr[i++] = [txtBPT_SchD_5A, 'ispNegativeNumber($(\'#txtBPT_SchD_5A\').val()) == false', 'Value for question 5a must not be negative'];

            arrSchdDErr[i++] = [txtBPT_SchD_5B, '$(\'#txtBPT_SchD_5B\').val() == ""', 'Answer question 5b'];
            arrSchdDErr[i++] = [txtBPT_SchD_5B, 'ispValue($(\'#txtBPT_SchD_5B\').val()) == false', 'Value for question 5b must be numeric'];
            arrSchdDErr[i++] = [txtBPT_SchD_5B, 'ispNegativeNumber($(\'#txtBPT_SchD_5B\').val()) == false', 'Value for question 5b must not be negative'];

            arrSchdDErr[i++] = [txtBPT_SchD_5C, '$(\'#txtBPT_SchD_5C\').val() == ""', 'Answer question 5c'];
            arrSchdDErr[i++] = [txtBPT_SchD_5C, 'ispValue($(\'#txtBPT_SchD_5C\').val()) == false', 'Value for question 5c must be numeric'];
            arrSchdDErr[i++] = [txtBPT_SchD_5C, 'ispNegativeNumber($(\'#txtBPT_SchD_5C\').val()) == false', 'Value for question 5c must not be negative'];

            arrSchdDErr[i++] = [txtBPT_SchD_5D, '$(\'#txtBPT_SchD_5D\').val() == ""', 'Answer question 5d'];
            arrSchdDErr[i++] = [txtBPT_SchD_5D, 'ispValue($(\'#txtBPT_SchD_5D\').val()) == false', 'Value for question 5d must be numeric'];
            arrSchdDErr[i++] = [txtBPT_SchD_5D, 'ispNegativeNumber($(\'#txtBPT_SchD_5D\').val()) == false', 'Value for question 5d must not be negative'];

           


            
            arrSchdDErr[i++] = [txtBPT_SchD_8, '$(\'#txtBPT_SchD_8\').val() == ""', 'Answer question 9'];
            arrSchdDErr[i++] = [txtBPT_SchD_8, 'ispValue($(\'#txtBPT_SchD_8\').val()) == false', 'Value for question 9 must be numeric'];
            arrSchdDErr[i++] = [txtBPT_SchD_8, 'ispNegativeNumber($(\'#txtBPT_SchD_8\').val()) == false', 'Value for question 9 must not be negative'];
        }

        function ClearBPTlfSchdD() {

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScDLi1, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScDLi2, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScDLi3, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScDLi4, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScDLi5a, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScDLi5b, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScDLi5c, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScDLi5d, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScDLi6, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScDLi7, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScDLi8, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScDLi9, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScDLi10, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScDLi11, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScDLi12, '', 0);

        }		//ClearBPTlfSchdD
        function RightAlignText_D() {//Added 
            $('#txtBPT_SchD_1').css('text-align', 'right');
            $('#txtBPT_SchD_2').css('text-align', 'right');
            $('#txtBPT_SchD_3').css('text-align', 'right');
            $('#txtBPT_SchD_5A').css('text-align', 'right');
            $('#txtBPT_SchD_5B').css('text-align', 'right');
            $('#txtBPT_SchD_5C').css('text-align', 'right');
            $('#txtBPT_SchD_5D').css('text-align', 'right');
           
            $('#txtBPT_SchD_8').css('text-align', 'right');


            $('#lblBPT_SchD_4').parent().css("text-align", "right");
            $('#lblBPT_SchD_6').parent().css("text-align", "right");
            $('#lblBPT_SchD_9').parent().css("text-align", "right");
            $('#lblBPT_SchD_10').parent().css("text-align", "right");
            $('#lblBPT_SchD_11').parent().css("text-align", "right");
            $('#lblBPT_SchD_12').parent().css("text-align", "right");
            $('#lblBPT_SchD_7').parent().css("text-align", "right");
        }
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
            var lblBPT_SchD_7 = document.getElementById('lblBPT_SchD_7');
            var txtBPT_SchD_8 = document.getElementById('txtBPT_SchD_8');
            var lblBPT_SchD_9 = document.getElementById('lblBPT_SchD_9');
            var lblBPT_SchD_10 = document.getElementById('lblBPT_SchD_10');
            var lblBPT_SchD_11 = document.getElementById('lblBPT_SchD_11');
            var lblBPT_SchD_12 = document.getElementById('lblBPT_SchD_12');
             
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency(txtBPT_SchD_1.value), xFldScDLi1, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency(txtBPT_SchD_2.value), xFldScDLi2, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency(txtBPT_SchD_3.value), xFldScDLi3, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency($('#lblBPT_SchD_4').text()), xFldScDLi4, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency(txtBPT_SchD_5A.value), xFldScDLi5a, '', 0);

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency(txtBPT_SchD_5B.value), xFldScDLi5b, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency(txtBPT_SchD_5C.value), xFldScDLi5c, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency(txtBPT_SchD_5D.value), xFldScDLi5d, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency($('#lblBPT_SchD_6').text()), xFldScDLi6, '', 0);

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency($('#lblBPT_SchD_7').text()), xFldScDLi7, '', 0);
            

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency(txtBPT_SchD_8.value), xFldScDLi8, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency($('#lblBPT_SchD_9').text()), xFldScDLi9, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency($('#lblBPT_SchD_10').text()), xFldScDLi10, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency($('#lblBPT_SchD_11').text()), xFldScDLi11, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency($('#lblBPT_SchD_12').text()), xFldScDLi12, '', 0);

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
            var lblBPT_SchD_7 = document.getElementById('lblBPT_SchD_7');
            var txtBPT_SchD_8 = document.getElementById('txtBPT_SchD_8');
            var lblBPT_SchD_9 = document.getElementById('lblBPT_SchD_9');
            var lblBPT_SchD_10 = document.getElementById('lblBPT_SchD_10');
            var lblBPT_SchD_11 = document.getElementById('lblBPT_SchD_11');
            var lblBPT_SchD_12 = document.getElementById('lblBPT_SchD_12');

            txtBPT_SchD_1.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScDLi1, '', 0), 0);
            txtBPT_SchD_2.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScDLi2, '', 0), 0);
            txtBPT_SchD_3.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScDLi3, '', 0), 0);
            lblBPT_SchD_4.innerText = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScDLi4, '', 0), 0);
            txtBPT_SchD_5A.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScDLi5a, '', 0), 0)
            txtBPT_SchD_5B.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScDLi5b, '', 0), 0);
            txtBPT_SchD_5C.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScDLi5c, '', 0), 0);
            txtBPT_SchD_5D.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScDLi5d, '', 0), 0);
            $('#lblBPT_SchD_6').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScDLi6, '', 0), 0));

            $('#lblBPT_SchD_7').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScDLi7, '', 0), 0));

            
            txtBPT_SchD_8.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScDLi8, '', 0), 0);
            $('#lblBPT_SchD_9').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScDLi9, '', 0), 0));
            $('#lblBPT_SchD_10').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScDLi10, '', 0), 0));
            $('#lblBPT_SchD_11').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScDLi11, '', 0), 0));
            $('#lblBPT_SchD_12').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScDLi12, '', 0), 0));

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
           
            $('#lblBPT_SchD_7').attr('disabled', bDisabled);
            //
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
            var lblBPT_SchD_7 = document.getElementById('lblBPT_SchD_7');
            var txtBPT_SchD_8 = document.getElementById('txtBPT_SchD_8');
            var lblBPT_SchD_9 = document.getElementById('lblBPT_SchD_9');
            var lblBPT_SchD_10 = document.getElementById('lblBPT_SchD_10');
            var lblBPT_SchD_11 = document.getElementById('lblBPT_SchD_11');
            var lblBPT_SchD_12 = document.getElementById('lblBPT_SchD_12');

            CalcSchdDLine4();
            CalcSchdDLine6();
            CalcSchdDLine9();	//Calculate lines 8 and 9
            CalcSchdDLine11();

        }		//PerformCalcsBPTlfSchdD

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
            var lblBPT_SchD_7 = document.getElementById('lblBPT_SchD_7');
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
                Performvalidationandload();
            }		//if

            if (PrepForMath(txtBPT_SchA_1.value) != 0) {
                if (PrepForMath($('#lblBPT_SchA_12').text()) > 0) {
                    if (PrepForMath($('#lblBPT_SchD_4').text()) == 0) {
                        $('#AppError').text('Line 4 Schedule D can not be $0.00');
                        //
                        parent.ScrollTop(1); //Here 1 meand any default value
                        resolvedIframeheight();
                    }
                }
            } else if (PrepForMath(txtBPT_SchB_1.value) != 0) {
                if (PrepForMath($('#lblBPT_SchB_12').text()) > 0) {
                    if (PrepForMath($('#lblBPT_SchD_4').text()) == 0) {
                        $('#AppError').text('Line 4 Schedule D can not be $0.00');
                        //
                        parent.ScrollTop(1); //Here 1 meand any default value
                        resolvedIframeheight();
                    }
                }
            }
        } 	//CalcSchdDLine4


        function CalcSchdDLine6() {
            var temp = 0;
            
            if ($('#txtBPT_SchD_5A').val() != '' && $('#txtBPT_SchD_5B').val() != '' && $('#txtBPT_SchD_5C').val() != '' &&
                    $('#txtBPT_SchD_5D').val() != '')
            {
                temp = PrepForMath($('#txtBPT_SchD_5A').val()) + PrepForMath($('#txtBPT_SchD_5B').val()) +
                        PrepForMath($('#txtBPT_SchD_5C').val()) + PrepForMath($('#txtBPT_SchD_5D').val());

                $('#lblBPT_SchD_6').text(ispFormatMoney(PrepForMath($('#lblBPT_SchD_4').text()) - temp, 0));
            }		//if

            if (PrepForMath($('#lblBPT_SchD_6').text()) < 0)
            {
                $('#lblBPT_SchD_6').text(ispFormatMoney(0, 0));
                $('#AppError').text('Exclusions can not be greater than Gross Receipts');
                parent.ScrollTop(1); //Here 1 meand any default value
                resolvedIframeheight();
            }
            if (PrepForMath($('#lblBPT_SchD_6').text()) < 50000)
            {
                $('#lblBPT_SchD_7').text($('#lblBPT_SchD_6').text());
            } else {
                $('#lblBPT_SchD_7').text(ispFormatMoney(50000, 0));
            }		//if
            //
            
        }		//CalcSchdDLine6

        function CalcSchdDLine9() {
             
            if ($('#lblBPT_SchD_6').text() != '' && $('#txtBPT_SchD_8').val() != '') {
                $('#lblBPT_SchD_9').text(ispFormatMoney(PrepForMath($('#lblBPT_SchD_6').text()) - (PrepForMath($('#lblBPT_SchD_7').text()) + PrepForMath($('#txtBPT_SchD_8').val())), 0));

                if (PrepForMath($('#lblBPT_SchD_9').text()) < 0) {
                    $('#lblBPT_SchD_9').text(ispFormatMoney(0, 0));
                }
                $('#lblBPT_SchD_10').text(ispFormatMoney(PrepForMath($('#lblBPT_SchD_9').text()) * dBPTGrossRate, 0));
                //Fill in Schd E with info from this Schd
                $('#lblBPT_SchE_A').text($('#txtBPT_SchD_8').val());
                VerifyTaxBasis('SCHDD');
            }		//if
        }		//CalcSchdDLine9



        function CalcSchdDLine11() {
            if ($('#lblBPT_SchD_10').text() != '' && $('#lblBPT_SchD_11').text() != '') {
                $('#lblBPT_SchD_12').text(ispFormatMoney(PrepForMath($('#lblBPT_SchD_10').text()) + PrepForMath($('#lblBPT_SchD_11').text()), 0));
                if (PrepForMath($('#lblBPT_SchD_12').text()) < 0) {
                    $('#lblBPT_SchD_12').text(ispFormatMoney(0, 0));
                }		//if
                $('#lblBPT1_2').text($('#lblBPT_SchD_12').text());
                //EHD PerformCalcsBPTlfPg1();
            }		//if
        }		//CalcSchdDLine11
    </script>
</head>
<body>

    <div id="BPT_SchdD" style="display: none;">
    <div class="col-lg-12 col-md-12">


        <div class="row">


            <!-- Schedule A Form -->

            <div class="col-lg-12 templateclass">

                <div class="table-responsive">

                    <table class="table table-condensed table-striped custom_table03 wage-table-print">

                        <thead>
                            <tr>
                                <th colspan="3" width="100%" class="slim-headings"><b>2014 BIRT Schedule D: Computation Of Tax On Gross Receipts</b></th>

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
                                                <input class="form-control input-sm" id="txtBPT_SchD_1" type="text" style="width: 100%"
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
                                                <input class="form-control input-sm" id="txtBPT_SchD_2" type="text" style="width: 100%"
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
                                                <input class="form-control input-sm" id="txtBPT_SchD_3" type="text" style="width: 100%"
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

                                                <input class="form-control input-sm" id="txtBPT_SchD_5A" type="text" style="width: 100%"
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
                                                <input class="form-control input-sm" id="txtBPT_SchD_5B" type="text" style="width: 100%"
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
                                                <input class="form-control input-sm" id="txtBPT_SchD_5C" type="text" style="width: 100%"
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

                                                <input class="form-control input-sm" id="txtBPT_SchD_5D" type="text" style="width: 100%"
                                                    onfocus="SetFocus()" onchange='ValidateWorksheet("BPT_SchdD")'>
                                            </div>
                                        </div>

                                    </form>
                                </td>
                            </tr>
                            <tr>
                                <td width="5%">6.</td>
                                <td width="70%" class="text-left">Net Taxable Receipts [Calculated - Line 4 minus Lines 5a through 5d]</td>
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
                                <td width="70%" class="text-left">Statutory Exclusion (Lower of Line 6 or $50,000.00)
                                        </td>
                                <td width="25%" class="text-left">
                                    <form class="form-horizontal">

                                        <div class="form-group no-margin">
                                            <div class="">
                                                 <label id="lblBPT_SchD_7" class="form-control input-sm"></label>
                                               
                                            </div>
                                        </div>

                                    </form>
                                </td>
                            </tr>
                            <tr>
                                <td width="5%">8.</td>
                                <td width="70%" class="text-left">Less Receipts on which tax is to be computed by the Alternate Method.
                                                </td>
                                <td width="25%" class="text-left">
                                    <form class="form-horizontal">

                                        <div class="form-group no-margin">
                                            <div class="">
                                                <input class="form-control input-sm" id="txtBPT_SchD_8" type="text" style="width: 100%" onfocus="SetFocus()" onchange='ValidateWorksheet("BPT_SchdD")'>
                                            </div>
                                        </div>

                                    </form>
                                </td>
                            </tr>
                            <tr class="odd">
                                <td width="5%">9.</td>
                                <td width="70%" class="text-left">Receipts subject to tax at the regular rate [Line 6 minus (Line 7 plus Line 8)]</td>
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
                                <td width="70%" class="text-left"><b>TAX DUE</b> at regular rate(Calculated - Multiply Line 9 by 0.001415)</td>
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

                            <tr class="odd">
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
                            </tr>
                            <tr>
                                <td width="5%">12.</td>
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


                    <div class="form-group page-print-wage-section">
                        <div class="col-sm-offset-3 col-sm-9  text-right">
                           
                            <input type="button" value="Return to Page 1" class="submit_button2" id="btnGoToPage1" onclick="ShowPage('Pg1')" />
                        </div>
                    </div>

                </form>

                <!--  <!-- Schedule A Form  END -->

            </div>

        </div>


    </div>
        <div class="clearfix"></div>
    </div>
    <div class="clearfix"></div>
    <div class="lets-split"></div>
    <div class="clearfix"></div>
</body>
</html>
