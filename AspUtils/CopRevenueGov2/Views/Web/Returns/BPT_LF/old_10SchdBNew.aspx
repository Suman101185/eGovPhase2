<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
   
    <title></title>
    <script language='javascript' type="text/javascript">
        var arrSchdBErr = new Array();
        var xSecScB = 'BPT_SCH_B ';
        var xFldScBLi1 = xSecScB + 'NI_LOSS';
        var xFldScBLi2a = xSecScB + 'ADJ_NI_INTEREST';
        var xFldScBLi2b = xSecScB + 'ADJ_NI_PORT_ACTIVITIES';
        var xFldScBLi2c = xSecScB + 'ADJ_NI_PUC_ICC';
        var xFldScBLi2d = xSecScB + 'ADJ_NI_PUBLIC_LAW';
        var xFldScBLi2e = xSecScB + 'ADJ_RECEIPTS_DIR';
        var xFldScBLi2f = xSecScB + 'ADJ_INCOME';
        var xFldScBLi2g = xSecScB + 'ADJ_RECEIPTS_OTHER';
        var xFldScBLi2h = xSecScB + 'ADJ_GROSS_RECEIPTS';
        var xFldScBLi2i = xSecScB + 'ADJ_GROSS_PERCENT';
        var xFldScBLi2j = xSecScB + 'ADJ_TOTAL';
        var xFldScBLi3 = xSecScB + 'NI_ADJUSTED';
        var xFldScBLi4 = xSecScB + 'I_NONBUS';
        var xFldScBLi5 = xSecScB + 'I_APPORTIONED';
        var xFldScBLi6 = xSecScB + 'I_APPORTIONED_PERCENT';
        var xFldScBLi7 = xSecScB + 'I_APPORTIONED_PHILA';
        var xFldScBLi8 = xSecScB + 'I_NONBUS_PHILA';
        var xFldScBLi9 = xSecScB + 'I_CURRENT_YEAR';
        var xFldScBLi10 = xSecScB + 'LOSS_CARRY_FORWARD';
        var xFldScBLi11 = xSecScB + 'I_TAXABLE';
        var xFldScBLi12 = xSecScB + 'TAX_DUE';

        function LoadErrorBPTlfSchdB() {
            var i = 0;
            arrSchdBErr[i++] = [txtBPT_SchB_1, 'txtBPT_SchB_1.value == ""', 'Answer Question 1'];
            arrSchdBErr[i++] = [txtBPT_SchB_1, 'ispValue(txtBPT_SchB_1.value) == false', 'Value for Question 1 must be numeric'];
            arrSchdBErr[i++] = [txtBPT_SchB_2A, 'txtBPT_SchB_2A.value == ""', 'Answer Question 2a'];
            arrSchdBErr[i++] = [txtBPT_SchB_2A, 'ispValue(txtBPT_SchB_2A.value) == false', 'Value for Question 2a must be numeric'];
            arrSchdBErr[i++] = [txtBPT_SchB_2B, 'txtBPT_SchB_2B.value == ""', 'Answer Question 2b'];
            arrSchdBErr[i++] = [txtBPT_SchB_2B, 'ispValue(txtBPT_SchB_2B.value) == false', 'Value for Question 2b must be numeric'];
            arrSchdBErr[i++] = [txtBPT_SchB_2C, 'txtBPT_SchB_2C.value == ""', 'Answer Question 2c'];
            arrSchdBErr[i++] = [txtBPT_SchB_2C, 'ispValue(txtBPT_SchB_2C.value) == false', 'Value for Question 2c must be numeric'];
            arrSchdBErr[i++] = [txtBPT_SchB_2D, 'txtBPT_SchB_2D.value == ""', 'Answer Question 2d'];
            arrSchdBErr[i++] = [txtBPT_SchB_2D, 'ispValue(txtBPT_SchB_2D.value) == false', 'Value for Question 2d must be numeric'];
            arrSchdBErr[i++] = [txtBPT_SchB_2E, 'txtBPT_SchB_2E.value == ""', 'Answer Question 2e'];
            arrSchdBErr[i++] = [txtBPT_SchB_2E, 'ispValue(txtBPT_SchB_2E.value) == false', 'Value for Question 2e must be numeric'];
            arrSchdBErr[i++] = [txtBPT_SchB_2G, 'txtBPT_SchB_2G.value == ""', 'Answer Question 2g'];
            arrSchdBErr[i++] = [txtBPT_SchB_2G, 'ispValue(txtBPT_SchB_2G.value) == false', 'Value for Question 2g must be numeric'];
            arrSchdBErr[i++] = [txtBPT_SchB_2H, 'txtBPT_SchB_2H.value == ""', 'Answer Question 2h'];
            arrSchdBErr[i++] = [txtBPT_SchB_2H, 'ispValue(txtBPT_SchB_2H.value) == false', 'Value for Question 2h must be numeric'];
            arrSchdBErr[i++] = [txtBPT_SchB_4, 'txtBPT_SchB_4.value == ""', 'Answer Question 4'];
            arrSchdBErr[i++] = [txtBPT_SchB_4, 'ispValue(txtBPT_SchB_4.value) == false', 'Value for Question 4 must be numeric'];
            arrSchdBErr[i++] = [txtBPT_SchB_8, 'txtBPT_SchB_8.value == ""', 'Answer Question 8'];
            arrSchdBErr[i++] = [txtBPT_SchB_8, 'ispValue(txtBPT_SchB_8.value) == false', 'Value for Question 8 must be numeric'];
        }		//LoadErrorBPTlfSchdB

        function ClearBPTlfSchdB() {

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScBLi1, '', 0);		//line 1
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScBLi2a, '', 0);		//line 2a
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScBLi2b, '', 0);		//line 2b
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScBLi2c, '', 0);		//line 2c
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScBLi2d, '', 0);		//line 2d
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScBLi2e, '', 0);		//line 2e
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScBLi2f, '', 0);		//line 2f
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScBLi2g, '', 0);		//line 2g
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScBLi2h, '', 0);		//line 2h
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScBLi2i, '', 0);		//line 2i
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScBLi2j, '', 0);		//line 2j
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScBLi3, '', 0);		//line 3
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScBLi4, '', 0);		//line 4
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScBLi5, '', 0);		//line 5
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScBLi6, '', 0);		//line 6
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScBLi7, '', 0);		//line 7
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScBLi8, '', 0);		//line 8
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScBLi9, '', 0);		//line 9
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScBLi10, '', 0)		//line 10
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScBLi11, '', 0);		//line 11
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScBLi12, '', 0);		//line 12
        }		//ClearBPTlfSchdB

        function PopulateXmlBPTlfSchdB() {
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchB_1.value), xFldScBLi1, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchB_2A.value), xFldScBLi2a, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchB_2B.value), xFldScBLi2b, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchB_2C.value), xFldScBLi2c, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchB_2D.value), xFldScBLi2d, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchB_2E.value), xFldScBLi2e, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchB_2F').text()), xFldScBLi2f, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchB_2G.value), xFldScBLi2g, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchB_2H.value), xFldScBLi2h, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, $('#lblBPT_SchB_2I').text(), xFldScBLi2i, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchB_2J').text()), xFldScBLi2j, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchB_3').text()), xFldScBLi3, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchB_4.value), xFldScBLi4, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchB_5').text()), xFldScBLi5, '', 0);
            //EGOVWEB-63
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, parseFloat($('#lblBPT_SchB_6').text()).toFixed(6), xFldScBLi6, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchB_7').text()), xFldScBLi7, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchB_8.value), xFldScBLi8, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchB_9').text()), xFldScBLi9, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchB_10.value), xFldScBLi10, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchB_11').text()), xFldScBLi11, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchB_12').text()), xFldScBLi12, '', 0);
        }		//PopulateBPTlfXMLSchdB

        function PopulateBPTlfSchdB() {
            txtBPT_SchB_1.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScBLi1, '', 0), 0);
            txtBPT_SchB_2A.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScBLi2a, '', 0), 0);
            txtBPT_SchB_2B.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScBLi2b, '', 0), 0);
            txtBPT_SchB_2C.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScBLi2c, '', 0), 0);
            txtBPT_SchB_2D.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScBLi2d, '', 0), 0);
            txtBPT_SchB_2E.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScBLi2e, '', 0), 0);
            $('#lblBPT_SchB_2F').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScBLi2f, '', 0), 0));
            txtBPT_SchB_2G.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScBLi2g, '', 0), 0);
            txtBPT_SchB_2H.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScBLi2h, '', 0), 0);
            $('#lblBPT_SchB_2I').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScBLi2i, '', 0) * 100);
            $('#lblBPT_SchB_2J').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScBLi2j, '', 0), 0));

            $('#lblBPT_SchB_3').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScBLi3, '', 0), 0));
            txtBPT_SchB_4.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScBLi4, '', 0), 0);
            $('#lblBPT_SchB_5').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScBLi5, '', 0), 0));
            $('#lblBPT_SchB_6').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScBLi6, '', 0) * 100);
            $('#lblBPT_SchB_7').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScBLi7, '', 0), 0));
            txtBPT_SchB_8.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScBLi8, '', 0), 0);
            $('#lblBPT_SchB_9').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScBLi9, '', 0), 0));
            txtBPT_SchB_10.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScBLi10, '', 0), 0);
            $('#lblBPT_SchB_11').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScBLi11, '', 0), 0));
            $('#lblBPT_SchB_12').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScBLi12, '', 0), 0));

            $('#msgBPT_SchB_12').text($('#msgBPT_SchB_12').text().replace('###', dBPTNetRate));
        }		//PopulateBPTlfSchdB

        function ResetBPTlfSchdB() {
            txtBPT_SchB_1.value = ispFormatMoney(0, 0);
            txtBPT_SchB_2A.value = ispFormatMoney(0, 0);
            txtBPT_SchB_2B.value = ispFormatMoney(0, 0);
            txtBPT_SchB_2C.value = ispFormatMoney(0, 0);
            txtBPT_SchB_2D.value = ispFormatMoney(0, 0);
            txtBPT_SchB_2E.value = ispFormatMoney(0, 0);
            $('#lblBPT_SchB_2F').text(ispFormatMoney(0, 0));
            txtBPT_SchB_2G.value = ispFormatMoney(0, 0);
            txtBPT_SchB_2H.value = ispFormatMoney(0, 0);
            $('#lblBPT_SchB_2I').text('');
            $('#lblBPT_SchB_2J').text(ispFormatMoney(0, 0));
            $('#lblBPT_SchB_3').text(ispFormatMoney(0, 0));
            txtBPT_SchB_4.value = ispFormatMoney(0, 0);
            $('#lblBPT_SchB_5').text(ispFormatMoney(0, 0));
            $('#lblBPT_SchB_6').text(0);
            $('#lblBPT_SchB_7').text(ispFormatMoney(0, 0));
            txtBPT_SchB_8.value = ispFormatMoney(0, 0);
            $('#lblBPT_SchB_9').text(ispFormatMoney(0, 0));
            txtBPT_SchB_10.value = ispFormatMoney(0, 0);
            $('#lblBPT_SchB_11').text(ispFormatMoney(0, 0));
            $('#lblBPT_SchB_12').text(ispFormatMoney(0, 0));

            $('#msgBPT_SchB_12').text($('#msgBPT_SchB_12').text().replace('###', dBPTNetRate));
        }		//ResetBPTlfSchdB

        function FieldLockBPTlfSchdB(bDisabled) {
            $('#txtBPT_SchB_1').attr('disabled', bDisabled);
            $('#txtBPT_SchB_2A').attr('disabled', bDisabled);
            $('#txtBPT_SchB_2B').attr('disabled', bDisabled);
            $('#txtBPT_SchB_2C').attr('disabled', bDisabled);
            $('#txtBPT_SchB_2D').attr('disabled', bDisabled);
            $('#txtBPT_SchB_2E').attr('disabled', bDisabled);
            $('#lblBPT_SchB_2F').attr('disabled', bDisabled);
            $('#txtBPT_SchB_2G').attr('disabled', bDisabled);
            $('#txtBPT_SchB_2H').attr('disabled', bDisabled);
            $('#lblBPT_SchB_2I').attr('disabled', bDisabled);
            $('#lblBPT_SchB_2J').attr('disabled', bDisabled);
            $('#lblBPT_SchB_3').attr('disabled', bDisabled);
            $('#txtBPT_SchB_4').attr('disabled', bDisabled);
            $('#lblBPT_SchB_5').attr('disabled', bDisabled);
            $('#lblBPT_SchB_6').attr('disabled', bDisabled);
            $('#lblBPT_SchB_7').attr('disabled', bDisabled);
            $('#txtBPT_SchB_8').attr('disabled', bDisabled);
            $('#lblBPT_SchB_9').attr('disabled', bDisabled);
            $('#txtBPT_SchB_10').attr('disabled', bDisabled);
            $('#lblBPT_SchB_11').attr('disabled', bDisabled);
            $('#lblBPT_SchB_12').attr('disabled', bDisabled);
        }		//FieldLockBPTlfSchdB

        //Begin Calculations
        function PerformCalcsBPTlfSchdB() {
            if (getActiveElement().id == 'txtBPT_SchB_1' && PrepForMath(txtBPT_SchA_1.value) != 0) {
                ResetBPTlfSchdA();
            }		//if
            if ($('#AppError').text() == "") {
                CalcSchdBLine2f();
                CalcSchdBLine3();		//Calculate lines 2i, 2j and 3
                CalcSchdBLine7();		//Calculate lines 5, and 7
                CalcSchdBLine9();
                CalcSchdBLine12();		//Calculate lines 11, and 12
            }		//if
        }		//PerformCalcsBPTlfSchdB

        function CalcSchdBLine2f() {

            if (txtBPT_SchB_1.value != '' && txtBPT_SchB_2A.value != '' && txtBPT_SchB_2B.value != '' &&
                    txtBPT_SchB_2C.value != '' && txtBPT_SchB_2D.value != '' && txtBPT_SchB_2E.value != '') {
                //Lines 2a thru 2e

                var temp = PrepForMath(txtBPT_SchB_2A.value) + PrepForMath(txtBPT_SchB_2B.value) +
                        PrepForMath(txtBPT_SchB_2C.value) + PrepForMath(txtBPT_SchB_2D.value) + PrepForMath(txtBPT_SchB_2E.value);

                $('#lblBPT_SchB_2F').text(ispFormatMoney(PrepForMath(txtBPT_SchB_1.value) - temp, 0));
            }		//if
        }		//CalcSchdBLine2f

        function CalcSchdBLine3() {
            if ($('#lblBPT_SchB_3').text() != '' && txtBPT_SchB_2G.value != '' && txtBPT_SchB_2H.value != '') {
                if (PrepForMath(txtBPT_SchB_2G.value) == 0 || PrepForMath(txtBPT_SchB_2H.value) == 0) {
                    $('#lblBPT_SchB_2I').text(0);
                } else {
                    $('#lblBPT_SchB_2I').text(parseFloat(PrepForMath(txtBPT_SchB_2G.value) / PrepForMath(txtBPT_SchB_2H.value)).toFixed(6));
                }		//if
                $('#lblBPT_SchB_2J').text(ispFormatMoney(PrepForMath($('#lblBPT_SchB_2F').text()) * PrepForMath($('#lblBPT_SchB_2I').text()), 0));
                $('#lblBPT_SchB_3').text(ispFormatMoney(PrepForMath($('#lblBPT_SchB_2F').text()) - PrepForMath($('#lblBPT_SchB_2J').text()), 0));
            }		//if
        }		//CalcSchdBLine3

        function CalcSchdBLine7() {
            if ($('#lblBPT_SchB_3').text() != '' && txtBPT_SchB_4.value != '') {
                $('#lblBPT_SchB_5').text(ispFormatMoney(PrepForMath($('#lblBPT_SchB_3').text()) - PrepForMath(txtBPT_SchB_4.value), 0));
            }		//if
            //EGOVWEB-63
            /*	if (PrepForMath(lblBPT_SchC1_12.innerText) == '0') {
                    if (lblBPT_SchB_6.innerText == '' || PrepForMath(lblBPT_SchB_6.innerText) == '0') {
                        lblBPT_SchB_6.innerText = '1.0'
                    }		//if
                } else {
                    lblBPT_SchB_6.innerText = lblBPT_SchC1_12.innerText
                }		//if
                if (PrepForMath(lblBPT_SchB_5.innerText) < 0) {
                    lblBPT_SchB_6.innerText = '0.0'
                }		//if	*/
            //EGOVWEB-60
            //EGOVWEB-102
            //	if (PrepForMath(lblBPT_SchC1_12.innerText) != '0') {
            $('#lblBPT_SchB_6').text(parseFloat($('#lblBPT_SchC1_12').text()).toFixed(6));
            //	} else {
            //	} else if (PrepForMath($('#lblBPT_SchC1_12').text()) == '0') {
            //		if (PrepForMath($('#lblBPT_SchB_5').text()) < 0) {
            //			$('#lblBPT_SchB_6').text( '0.0');
            //		} else {
            //			$('#lblBPT_SchB_6').text( '1.0');
            //		}		//if	
            //	}		//if

            if ($('#lblBPT_SchB_5').text() != '' && $('#lblBPT_SchB_6').text() != '') {
                if ($('#lblBPT_SchB_6').text() != '' && PrepForMath($('#lblBPT_SchB_6').text()) == 0 &&
                            $('#BPT_SchdB').css('display') == 'block') {
                    alert('Schedule C needs to be completed');
                }		//if
                $('#lblBPT_SchB_7').text(ispFormatMoney(PrepForMath($('#lblBPT_SchB_5').text()) * PrepForMath($('#lblBPT_SchB_6').text()), 0));
            }		//if
        }		//CalcSchdBLine7

        function CalcSchdBLine9() {
            if ($('#lblBPT_SchB_7').text() != '' && txtBPT_SchB_8.value != '') {
                $('#lblBPT_SchB_9').text(ispFormatMoney(PrepForMath($('#lblBPT_SchB_7').text()) + PrepForMath(txtBPT_SchB_8.value), 0));
            }		//if
        }		//CalcSchdBLine9

        function CalcSchdBLine12() {
            if ($('#lblBPT_SchB_9').text() != '' && txtBPT_SchB_10.value != '') {
                $('#lblBPT_SchB_11').text(ispFormatMoney(PrepForMath($('#lblBPT_SchB_9').text()) - PrepForMath(txtBPT_SchB_10.value), 0));
                $('#lblBPT_SchB_12').text(ispFormatMoney(PrepForMath($('#lblBPT_SchB_11').text()) * dBPTNetRate, 0));
                if (PrepForMath($('#lblBPT_SchB_12').text()) < 0) {
                    $('#lblBPT_SchB_12').text(ispFormatMoney(0, 0));
                }		//if
            }		//if
        }		//CalcSchdBLine12
</script>
</head>
<body>
   <div class="form_segment" id="BPT_SchdB" style="DISPLAY: none;">
      
                                <table summary="Employee Pay Sheet" class="hor-zebra">

                                    <tbody>

                                        <tr class="odd">
                                            <td width="70%"><B><U>2010 BIRT Schedule B: Computation of Tax On Net Income(Method II)</U></B></td>
                                            <td align="center" class="no_border_right">
                                                
                                               </td>
                                        </tr>
                                        <tr>
                                            <td>1.  Net Income (Loss) as properly reported to the Federal Government</td>
                                            <td align="center" class="no_border_right">
                                                <INPUT class="" id=txtBPT_SchB_1 style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("BPT_SchdB")>
                                               </td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%"><B>ADJUSTMENTS</B> (Per BIRT Reg. 404 and Public Law 82-272)
                                            </td>
                                            <td align="center" class="no_border_right">
                                               </td>
                                        </tr>
                                        <tr>
                                            <td>2a. Income net of interest expense attributable to direct obligations
				of the Federal Government, Pennsylvania or the political subdivisions of Pennsylvania. (If less than
				 zero, enter zero on this line)</td>
                                            <td align="center" class="no_border_right">
                                             <INPUT class="" id=txtBPT_SchB_2A style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("BPT_SchdB")></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">2b. Net Income (Loss) from certain port related activities 
				(Reg. 302(19))</td>
                                            <td align="center" class="no_border_right">
                                             <INPUT class="" id=txtBPT_SchB_2B style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("BPT_SchdB")></td>
                                        </tr>
                                        <tr>
                                            <td>2c. Net Income (Loss) from specific PUC and ICC business
				activities. (Reg 101(d) & 302(19))</td>
                                            <td align="center" class="no_border_right">
                                            <INPUT class="" id=txtBPT_SchB_2C style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("BPT_SchdB")>
                                               </td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">2d.  Net Income (Loss) from Public Law 86-272 activities</LABEL>
                                            </td>
                                            <td align="center" class="no_border_right">
                                               <INPUT class="" id=txtBPT_SchB_2D style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("BPT_SchdB")>
                                              </td>
                                        </tr>
                                        <tr>
                                            <td>2e.  Receipts by corporations of dividends, interest and royalties
				received from other corporations in the same affiliated group and/or from other corporations of which
				the receiving corporation owns at least 20% of the stock and/or BIRT Regulation §404(G) adjustments
				(Reg. 302(14)).</td>
                                            <td align="center" class="no_border_right">
                                              <INPUT class="" id=txtBPT_SchB_2E style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("BPT_SchdB")></td>
                                        </tr>
                                        <tr class="odd">
                                            <td >2f.  Line 1 minus Lines 2a through 2e</td>
                                            <td align="center" class="no_border_right">
                                             <LABEL id=lblBPT_SchB_2F 
				style="WIDTH: 100%"></LABEL>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>2g.  All other receipts from other corporations of the same
    		affiliated group. (Reg. 302(14)).</td>
                                            <td align="center" class="no_border_right">
                                               <INPUT class="" id=txtBPT_SchB_2G style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("BPT_SchdB")></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">2h. Gross Receipts per BIRT Regulation §404(2)(E)(V).</td>
                                            <td align="center" class="no_border_right">
                                           <INPUT class="" id=txtBPT_SchB_2H style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("BPT_SchdB")>
                                            </td>
                                        </tr>
                                        <tr >
                                            <td width="70%">2i.  Divide Line 2g by Line 2h</td>
                                            <td align="center" class="no_border_right">
                                            <LABEL id=lblBPT_SchB_2I
				style="WIDTH: 100%"></LABEL>
                                            </td>
                                        </tr>
                                        <tr class="odd">
                                            <td>2j.  Multiply Line 2f by Line 2i</td>
                                            <td align="center" class="no_border_right">
                                             <LABEL id=lblBPT_SchB_2J
				style="WIDTH: 100%"></LABEL></td>
                                        </tr>

                                         <tr>
                                            <td>3. ADJUSTED NET INCOME(Loss)[Calculated - Line 2f minus Line 2j]</td>
                                            <td align="center" class="no_border_right">
                                           	<label id="lblBPT_SchB_3" style="width:100%;"></label>
                                               </td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">4.  Total Nonbusiness Income(Loss)
                                            </td>
                                            <td align="center" class="no_border_right">
                                               <INPUT class="" id=txtBPT_SchB_4 style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("BPT_SchdB")>
                                              </td>
                                        </tr>
                                        <tr>
                                            <td>5.  Income(Loss) to be apportioned[Calculated - Line 3 minus Line 4]</td>
                                            <td align="center" class="no_border_right">
                                              <LABEL id=lblBPT_SchB_5	style="WIDTH: 100%"></LABEL></td>
                                        </tr>
                                       
                                        <tr class="odd">
                                            <td>6.  Average of Apportionment Factors (from
                                                <label id="lnkSchC1" class="lblLink" style="width:100%" 
				onclick=ShowPage("SchdC1")>Click here for Schedule C-1, Line 12</label>
                                                ).
                                            </td>
                                            <td align="center" class="no_border_right">
                                              <LABEL id=lblBPT_SchB_6 
				style="WIDTH: 100%"></LABEL></td>
                                        </tr>
                                        <tr >
                                            <td width="70%">7. Income (Loss) apportioned to Philadelphia[Calculated - Multiply Line 5 by Line 6]</td>
                                            <td align="center" class="no_border_right">
                                           <LABEL id=lblBPT_SchB_7 style="WIDTH: 100%"></LABEL>
                                            </td>
                                        </tr>
                                      
                                        <tr class="odd">
                                            <td>8.  Nonbusiness Income (Loss) allocated to Philadelphia</td>
                                            <td align="center" class="no_border_right">
                                            <INPUT class="" id=txtBPT_SchB_8 style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("BPT_SchdB")></td>
                                        </tr>
                                       <tr >
                                            <td width="70%">9.  Current Year Income (Loss)[Calculated - Line 7 plus Line 8]</td>
                                            <td align="center" class="no_border_right">
                                           <LABEL  id=lblBPT_SchB_9 style="WIDTH: 100%"></LABEL>
                                            </td>
                                        </tr>
                                          <tr class="odd">
                                            <td width="70%">10.  Loss carry foward, if any.</td>
                                            <td align="center" class="no_border_right">
                                            <INPUT class="" id=txtBPT_SchB_10 style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("BPT_SchdB")>
                                            </td>
                                        </tr>
                                          <tr >
                                            <td width="70%">11. Taxable Income (Loss)[Calculated - Line 9 minus Line 10]</td>
                                            <td align="center" class="no_border_right">
                                           <LABEL id=lblBPT_SchB_11 style="WIDTH: 100%"></LABEL>
                                            </td>
                                        </tr>
                                          <tr class="odd">
                                            <td width="70%">12.  <LABEL id=msgBPT_SchB_12 class=""><B>TAX DUE</B> (Multiply Line 11 by ###) If Line 11 is a loss, enter zero</LABEL></td>
                                            <td align="center" class="no_border_right">
                                            <LABEL id=lblBPT_SchB_12 style="WIDTH: 100%"></LABEL>
                                            </td>
                                        </tr>
                                        <tr >
                                            <td></td>
                                            <td align="right" class="no_border_right">
                                               
                               
                                 <input type="button" value="Return to Page 1" class="submit_button2" id="btnGoToPage1" onclick="ShowPage('Pg1')" />
                                  </td>
                                        </tr>

                                         
                                    </tbody>
                                </table>
                                <div class="clear"></div>

                            </div>
</body>
</html>
