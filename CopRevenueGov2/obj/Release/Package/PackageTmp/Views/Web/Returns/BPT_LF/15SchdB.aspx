﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

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

        var xFldScBLi10 = xSecScB + 'STAT_NET_DEDUCTION_B_X';  //binoy

        var xFldScBLi11 = xSecScB + 'LOSS_CARRY_FORWARD';
        var xFldScBLi12 = xSecScB + 'I_TAXABLE';
        var xFldScBLi13 = xSecScB + 'TAX_DUE';

        function LoadErrorBPTlfSchdB() {
            var txtBPT_SchB_1 = document.getElementById('txtBPT_SchB_1');
            var txtBPT_SchB_2A = document.getElementById('txtBPT_SchB_2A');
            var txtBPT_SchB_2B = document.getElementById('txtBPT_SchB_2B');
            var txtBPT_SchB_2C = document.getElementById('txtBPT_SchB_2C');
            var txtBPT_SchB_2D = document.getElementById('txtBPT_SchB_2D');
            var txtBPT_SchB_2E = document.getElementById('txtBPT_SchB_2E');
            var txtBPT_SchB_2G = document.getElementById('txtBPT_SchB_2G');
            var txtBPT_SchB_2H = document.getElementById('txtBPT_SchB_2H');
            var txtBPT_SchB_4 = document.getElementById('txtBPT_SchB_4');
            var txtBPT_SchB_8 = document.getElementById('txtBPT_SchB_8');
            var txtBPT_SchB_11 = document.getElementById('txtBPT_SchB_11');

            var i = 0;
            arrSchdBErr[i++] = [txtBPT_SchB_1, '$(\'#txtBPT_SchB_1\').val() == ""', 'Answer question 1'];
            arrSchdBErr[i++] = [txtBPT_SchB_1, 'ispValue($(\'#txtBPT_SchB_1\').val()) == false', 'Value for question 1 must be numeric'];
            
            arrSchdBErr[i++] = [txtBPT_SchB_2A, '$(\'#txtBPT_SchB_2A\').val() == ""', 'Answer question 2a'];
            arrSchdBErr[i++] = [txtBPT_SchB_2A, 'ispValue($(\'#txtBPT_SchB_2A\').val()) == false', 'Value for question 2a must be numeric'];

            arrSchdBErr[i++] = [txtBPT_SchB_2B, '$(\'#txtBPT_SchB_2B\').val() == ""', 'Answer question 2b'];
            arrSchdBErr[i++] = [txtBPT_SchB_2B, 'ispValue($(\'#txtBPT_SchB_2B\').val()) == false', 'Value for question 2b must be numeric'];

            arrSchdBErr[i++] = [txtBPT_SchB_2C, '$(\'#txtBPT_SchB_2C\').val() == ""', 'Answer question 2c'];
            arrSchdBErr[i++] = [txtBPT_SchB_2C, 'ispValue($(\'#txtBPT_SchB_2C\').val()) == false', 'Value for question 2c must be numeric'];

            arrSchdBErr[i++] = [txtBPT_SchB_2D, '$(\'#txtBPT_SchB_2D\').val() == ""', 'Answer question 2d'];
            arrSchdBErr[i++] = [txtBPT_SchB_2D, 'ispValue($(\'#txtBPT_SchB_2D\').val()) == false', 'Value for question 2d must be numeric'];

            arrSchdBErr[i++] = [txtBPT_SchB_2E, '$(\'#txtBPT_SchB_2E\').val() == ""', 'Answer question 2e'];
            arrSchdBErr[i++] = [txtBPT_SchB_2E, 'ispValue($(\'#txtBPT_SchB_2E\').val()) == false', 'Value for question 2e must be numeric'];

            arrSchdBErr[i++] = [txtBPT_SchB_2G, '$(\'#txtBPT_SchB_2G\').val() == ""', 'Answer question 2g'];
            arrSchdBErr[i++] = [txtBPT_SchB_2G, 'ispValue($(\'#txtBPT_SchB_2G\').val()) == false', 'Value for question 2g must be numeric'];

            arrSchdBErr[i++] = [txtBPT_SchB_2H, '$(\'#txtBPT_SchB_2H\').val() == ""', 'Answer question 2h'];
            arrSchdBErr[i++] = [txtBPT_SchB_2H, 'ispValue($(\'#txtBPT_SchB_2H\').val()) == false', 'Value for question 2h must be numeric'];

            arrSchdBErr[i++] = [txtBPT_SchB_4, '$(\'#txtBPT_SchB_4\').val() == ""', 'Answer question 4'];
            arrSchdBErr[i++] = [txtBPT_SchB_4, 'ispValue($(\'#txtBPT_SchB_4\').val()) == false', 'Value for question 4 must be numeric'];

            arrSchdBErr[i++] = [txtBPT_SchB_8, '$(\'#txtBPT_SchB_8\').val() == ""', 'Answer question 8'];
            arrSchdBErr[i++] = [txtBPT_SchB_8, 'ispValue($(\'#txtBPT_SchB_8\').val()) == false', 'Value for question 8 must be numeric'];
            
        }		//LoadErrorBPTlfSchdB

        function ClearBPTlfSchdB() {

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldScBLi1, '', 0);		//line 1
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldScBLi2a, '', 0);		//line 2a
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldScBLi2b, '', 0);		//line 2b
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldScBLi2c, '', 0);		//line 2c
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldScBLi2d, '', 0);		//line 2d
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldScBLi2e, '', 0);		//line 2e
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldScBLi2f, '', 0);		//line 2f
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldScBLi2g, '', 0);		//line 2g
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldScBLi2h, '', 0);		//line 2h
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldScBLi2i, '', 0);		//line 2i
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldScBLi2j, '', 0);		//line 2j
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldScBLi3, '', 0);		//line 3
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldScBLi4, '', 0);		//line 4
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldScBLi5, '', 0);		//line 5
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldScBLi6, '', 0);		//line 6
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldScBLi7, '', 0);		//line 7
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldScBLi8, '', 0);		//line 8
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldScBLi9, '', 0);		//line 9
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldScBLi10, '', 0)		//line 10
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldScBLi11, '', 0);		//line 11
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldScBLi12, '', 0);		//line 12
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldScBLi13, '', 0);		//line 13
        }		//ClearBPTlfSchdB

        function PopulateXmlBPTlfSchdB() {            
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#txtBPT_SchB_1').val()), xFldScBLi1, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#txtBPT_SchB_2A').val()), xFldScBLi2a, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#txtBPT_SchB_2B').val()), xFldScBLi2b, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#txtBPT_SchB_2C').val()), xFldScBLi2c, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#txtBPT_SchB_2D').val()), xFldScBLi2d, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#txtBPT_SchB_2E').val()), xFldScBLi2e, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#lblBPT_SchB_2F').text()), xFldScBLi2f, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#txtBPT_SchB_2G').val()), xFldScBLi2g, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#txtBPT_SchB_2H').val()), xFldScBLi2h, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, $('#lblBPT_SchB_2I').text(), xFldScBLi2i, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#lblBPT_SchB_2J').text()), xFldScBLi2j, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#lblBPT_SchB_3').text()), xFldScBLi3, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#txtBPT_SchB_4').val()), xFldScBLi4, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#lblBPT_SchB_5').text()), xFldScBLi5, '', 0);
            //EGOVWEB-63
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, parseFloat($('#lblBPT_SchB_6').text()).toFixed(6), xFldScBLi6, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#lblBPT_SchB_7').text()), xFldScBLi7, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#txtBPT_SchB_8').val()), xFldScBLi8, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#lblBPT_SchB_9').text()), xFldScBLi9, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#lblBPT_SchB_10').text()), xFldScBLi10, '', 0);  //binoy

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#txtBPT_SchB_11').val()), xFldScBLi11, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#lblBPT_SchB_12').text()), xFldScBLi12, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#lblBPT_SchB_13').text()), xFldScBLi13, '', 0);
        }		//PopulateBPTlfXMLSchdB

        function RightAlignText_B() {//Added 
            $('#txtBPT_SchB_1').css('text-align', 'right');
            $('#txtBPT_SchB_2A').css('text-align', 'right');
            $('#txtBPT_SchB_2B').css('text-align', 'right');
            $('#txtBPT_SchB_2C').css('text-align', 'right');
            $('#txtBPT_SchB_2D').css('text-align', 'right');
            $('#txtBPT_SchB_2E').css('text-align', 'right');
            $('#txtBPT_SchB_2G').css('text-align', 'right');
            $('#txtBPT_SchB_2H').css('text-align', 'right');
            $('#txtBPT_SchB_4').css('text-align', 'right');
            $('#txtBPT_SchB_8').css('text-align', 'right');
            $('#txtBPT_SchB_11').css('text-align', 'right');

            $('#lblBPT_SchB_2F').parent().css("text-align", "right");
            $('#lblBPT_SchB_2I').parent().css("text-align", "right");
            $('#lblBPT_SchB_2J').parent().css("text-align", "right");
            $('#lblBPT_SchB_3').parent().css("text-align", "right");
            $('#lblBPT_SchB_5').parent().css("text-align", "right");
            $('#lblBPT_SchB_6').parent().css("text-align", "right");
            $('#lblBPT_SchB_7').parent().css("text-align", "right");
            $('#lblBPT_SchB_9').parent().css("text-align", "right");
            $('#lblBPT_SchB_10').parent().css("text-align", "right");
            $('#lblBPT_SchB_12').parent().css("text-align", "right");
            $('#lblBPT_SchB_13').parent().css("text-align", "right");
        }
        function PopulateBPTlfSchdB() {
            
            $('#txtBPT_SchB_1').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi1, '', 0), 0));
            $('#txtBPT_SchB_2A').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi2a, '', 0), 0));
            $('#txtBPT_SchB_2B').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi2b, '', 0), 0));
            $('#txtBPT_SchB_2C').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi2c, '', 0), 0));
            $('#txtBPT_SchB_2D').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi2d, '', 0), 0));
            $('#txtBPT_SchB_2E').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi2e, '', 0), 0));
            $('#lblBPT_SchB_2F').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi2f, '', 0), 0));
            $('#txtBPT_SchB_2G').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi2g, '', 0), 0));
            $('#txtBPT_SchB_2H').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi2h, '', 0), 0));
            

            $('#lblBPT_SchB_2I').text('$' + (PrepForMath(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi2i, '', 0)) * 100).toString());
            $('#lblBPT_SchB_2J').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi2j, '', 0), 0));

            $('#lblBPT_SchB_3').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi3, '', 0), 0));
            $('#txtBPT_SchB_4').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi4, '', 0), 0));
            $('#lblBPT_SchB_5').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi5, '', 0), 0));
           
            //
            $('#lblBPT_SchB_6').text(parseFloat(ispRemoveMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi6, '', 0)) / 10000).toFixed(6));//updated by SumanG
            

            $('#lblBPT_SchB_7').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi7, '', 0), 0));
            $('#txtBPT_SchB_8').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi8, '', 0), 0));
            $('#lblBPT_SchB_9').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi9, '', 0), 0));
            //EGOVWEB-131 EHD 03/25/2013 Always populate from BPT_INFO(xFldInfLossCarry) not BPT_SCH_A(xFldScBLi10)
            
            $('#lblBPT_SchB_10').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi10, '', 0), 0)); //binoy
            $('#txtBPT_SchB_11').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldInfLossCarry, '', 0), 0));
            $('#lblBPT_SchB_12').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi12, '', 0), 0));
            $('#lblBPT_SchB_13').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi13, '', 0), 0));

            $('#msgBPT_SchB_13').text($('#msgBPT_SchB_13').text().replace('###', dBPTNetRate));
        }		//PopulateBPTlfSchdB

        function ResetBPTlfSchdB() {          

            $('#txtBPT_SchB_1').val(ispFormatMoney(0, 0));
            $('#txtBPT_SchB_2A').val(ispFormatMoney(0, 0));
            $('#txtBPT_SchB_2B').val(ispFormatMoney(0, 0));
            $('#txtBPT_SchB_2C').val(ispFormatMoney(0, 0));
            $('#txtBPT_SchB_2D').val(ispFormatMoney(0, 0));
            $('#txtBPT_SchB_2E').val(ispFormatMoney(0, 0));
            $('#lblBPT_SchB_2F').text(ispFormatMoney(0, 0));
            $('#txtBPT_SchB_2G').val(ispFormatMoney(0, 0));
            $('#txtBPT_SchB_2H').val(ispFormatMoney(0, 0));
            $('#lblBPT_SchB_2I').text(ispFormatMoney(0, 0));
            $('#lblBPT_SchB_2J').text(ispFormatMoney(0, 0));
            $('#lblBPT_SchB_3').text(ispFormatMoney(0, 0));
            $('#txtBPT_SchB_4').val(ispFormatMoney(0, 0));
            $('#lblBPT_SchB_5').text(ispFormatMoney(0, 0));
            $('#lblBPT_SchB_6').text(ispFormatMoney(0, 0));
            $('#lblBPT_SchB_7').text(ispFormatMoney(0, 0));
            $('#txtBPT_SchB_8').val(ispFormatMoney(0, 0));
            $('#lblBPT_SchB_9').text(ispFormatMoney(0, 0));
            $('#lblBPT_SchB_10').text(ispFormatMoney(0, 0));  //binoy
            $('#txtBPT_SchB_11').val(ispFormatMoney(0, 0));

            $('#lblBPT_SchB_12').text(ispFormatMoney(0, 0));

            $('#lblBPT_SchB_13').text(ispFormatMoney(0, 0));
            $('#msgBPT_SchB_13').text($('#msgBPT_SchB_13').text().replace('###', dBPTNetRate));
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
            //EGOVWEB-131 EHD 03/25/2013 Loss Cerry Forward is always disabled
            $('#lblBPT_SchB_10').attr('disabled', bDisabled); //binoy
            $('#txtBPT_SchB_11').attr('disabled', 'disabled');

            $('#lblBPT_SchB_12').attr('disabled', bDisabled);
            $('#lblBPT_SchB_13').attr('disabled', bDisabled);
        }		//FieldLockBPTlfSchdB

        //Begin Calculations
        function PerformCalcsBPTlfSchdB() {
            debugger;
            if (getActiveElement().id == $('#txtBPT_SchB_1') && PrepForMath($('#txtBPT_SchA_1').val()) != 0) {
                ResetBPTlfSchdA();
            }		//if
            if ($(parent.AppError).text() == "") {
                CalcSchdBLine2f();
                CalcSchdBLine3();		//Calculate lines 2i, 2j and 3
                CalcSchdBLine7();		//Calculate lines 5, and 7
                CalcSchdBLine9();
                CalcWrkS("B");			//Calculate Worksheet S - Code in 14BIRTlf.js.htm(worksheet S frontend not implemented)
                CalcSchdBLine12();		//Calculate lines 11, and 12
            }		//if
        }		//PerformCalcsBPTlfSchdB

        function CalcSchdBLine2f() {
            if ($('#txtBPT_SchB_1').val() != '' && $('#txtBPT_SchB_2A').val() != '' && $('#txtBPT_SchB_2B').val() != '' &&
                    $('#txtBPT_SchB_2C').val() != '' && $('#txtBPT_SchB_2D').val() != '' && $('#txtBPT_SchB_2E').val() != '') {
                //Lines 2a thru 2e

                var temp = PrepForMath($('#txtBPT_SchB_2A').val()) + PrepForMath($('#txtBPT_SchB_2B').val()) +
                        PrepForMath($('#txtBPT_SchB_2C').val()) + PrepForMath($('#txtBPT_SchB_2D').val()) + PrepForMath($('#txtBPT_SchB_2E').val());

                $('#lblBPT_SchB_2F').text(ispFormatMoney(PrepForMath($('#txtBPT_SchB_1').val()) - temp, 0));
            }		//if
        }		//CalcSchdBLine2f

        function CalcSchdBLine3() {
            if ($('#txtBPT_SchB_2G').val() != '' && $('#txtBPT_SchB_2H').val() != '') {
                if (PrepForMath($('#txtBPT_SchB_2G').val()) == 0 || PrepForMath($('#txtBPT_SchB_2H').val()) == 0) {
                    $('#lblBPT_SchB_2I').text(ispFormatMoney(0, 0));
                } else {
                    
                    $('#lblBPT_SchB_2I').text(parseFloat(PrepForMath($('#txtBPT_SchB_2G').val()) / PrepForMath($('#txtBPT_SchB_2H').val())).toFixed(6));
                }
                $('#lblBPT_SchB_2J').text(ispFormatMoney(PrepForMath($('#lblBPT_SchB_2F').text()) * PrepForMath($('#lblBPT_SchB_2I').text()), 0));
            }
            if ($('#lblBPT_SchB_3').text() != '' && $('#txtBPT_SchB_2G').val() != '' && $('#txtBPT_SchB_2H').val() != '') {
                //if
                $('#lblBPT_SchB_3').text(ispFormatMoney(PrepForMath($('#lblBPT_SchB_2F').text()) - PrepForMath($('#lblBPT_SchB_2J').text()), 0));
            }
            //if
        }		//CalcSchdBLine3

       

        function CalcSchdBLine7() {
            if ($('#lblBPT_SchB_3').text() != '' && $('#txtBPT_SchB_4').val() != '') {
                $('#lblBPT_SchB_5').text(ispFormatMoney(PrepForMath($('#lblBPT_SchB_3').text()) - PrepForMath($('#txtBPT_SchB_4').val()), 0));
            }		//if

            if ($('#lblBPT_SchB_5').text() != '' && $('#lblBPT_SchB_6').text() != '') {
                if (PrepForMath($('#lblBPT_SchC1_3').text()) == 1 && $('#BPT_SchdB').css('display') == 'block') {
                   
                    alert('Schedule C needs to be completed');
                }		//if
                $('#lblBPT_SchB_6').text(parseFloat($('#lblBPT_SchC1_3').text()).toFixed(6));
                $('#lblBPT_SchB_7').text(ispFormatMoney(PrepForMath($('#lblBPT_SchB_5').text()) * PrepForMath($('#lblBPT_SchB_6').text()), 0));
            }		//if
        }

        function CalcSchdBLine9() {

            if ($('#lblBPT_SchB_7').text() != '' && $('#txtBPT_SchB_8').val() != '') {
                $('#lblBPT_SchB_9').text(ispFormatMoney(PrepForMath($('#lblBPT_SchB_7').text()) + PrepForMath($('#txtBPT_SchB_8').val()), 0));
                if ((PrepForMath($('#lblBPT_SchB_7').text()) + PrepForMath($('#txtBPT_SchB_8').val())) < 0) {
                    $('#lbl_BPT_WS2').text(ispFormatMoney(0, 0));
                }
                else {
                    $('#lbl_BPT_WS2').text($('#lblBPT_SchB_9').text());
                }
                //Performvalidationandload();

            }		//if
        }		//CalcSchdBLine9

        function CalcSchdBLine12() {           

            if ($('#lblBPT_SchB_9').text() != '' && $('#lblBPT_SchB_10').text() != '') {               
                $('#lblBPT_SchB_12').text(ispFormatMoney(PrepForMath($('#lblBPT_SchB_9').text()) - PrepForMath($('#lblBPT_SchB_10').text())
                    - PrepForMath($('#txtBPT_SchB_11').val()), 0));
                $('#lblBPT_SchB_13').text(ispFormatMoney(PrepForMath($('#lblBPT_SchB_12').text()) * dBPTNetRate, 0));
                if (PrepForMath($('#lblBPT_SchB_13').text()) < 0) {
                    $('#lblBPT_SchB_13').text(ispFormatMoney(0, 0));
                }
                $('#lblBPT1_1').text($('#lblBPT_SchB_13').text());
                //if
            }

            //if
        }		//CalcSchdBLine12

        function gotolcf_B() {
            Sch = 'B';
            $('#losscarryforward').css('display', 'block');
            $('#BPT_SchdB').css('display', 'none');
        }
</script>
</head>
<body>
      <div id="BPT_SchdB" style="DISPLAY: none;">
     <div class="col-lg-12 col-md-12 bptlf-sched-for-print">     
     
            	<div class="row">                   
                	
                    <!-- Schedule B Form -->
                    
                	<div class="col-lg-12 templateclass">
                                                               
                                <div class="table-responsive">
                                
                                	<table class="table table-condensed table-striped custom_table03 wage-table-print bptlf-sched-page-table bptlf-inner-page-print">
                                    
                                    	<thead>
                                        	<tr>
                                            	<th colspan="3" width="100%" class="slim-headings"><B>2015 BIRT Schedule B: Computation of Tax On Net Income(Method II)</B></th>
                                       
                                            </tr>

                                        </thead>
                                        
                                        <tbody>
                                        	
                                            <tr>
                                            	<td width="5%">1.</td>
                                                <td width="70%" class="text-left">Net Income (Loss) as properly reported to the Federal Government</td>
                                                <td width="25%"class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                                  <INPUT class="form-control input-sm pull-right" id="txtBPT_SchB_1" type="text" style="WIDTH: 100%" onfocus=SetFocus() maxLength=10 onchange="ValidateWorksheet('BPT_SchdB')"/>
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                            <tr>
                                            <td colspan="3" class="text-left">ADJUSTMENTS (Per BIRT Reg. 404 and Public Law 82-272)</td>
                                            </tr>
                                     		<tr class="odd">
                                            	<td width="5%">2a.</td>
                                                <td width="70%"class="text-left">Income net of interest expense attributable to direct obligations
				of the Federal Government, Pennsylvania or the political subdivisions of Pennsylvania. (If less than
				 zero, enter zero on this line)</td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                                <INPUT class="form-control input-sm pull-right" id="txtBPT_SchB_2A" type="text" style="WIDTH: 100%" 
				                                                    onfocus=SetFocus() maxLength=10 onchange="ValidateWorksheet('BPT_SchdB')"/>
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                            <tr>
                                            	<td width="5%">2b.</td>
                                                <td width="70%" class="text-left">Net Income (Loss) from certain port related activities 
				                                (Reg. 302(19))</td>
                                                <td width="25%"class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                               <INPUT class="form-control input-sm pull-right" id="txtBPT_SchB_2B" type="text" style="WIDTH: 100%" 
				                                                onfocus=SetFocus() maxLength="10" onchange="ValidateWorksheet('BPT_SchdB')"/>
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                     		<tr class="odd">
                                            	<td width="5%">2c.</td>
                                                <td width="70%" class="text-left">Net Income (Loss) from specific PUC and ICC business activities. (Reg 101(d) & 302(19))</td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                             <INPUT class="form-control input-sm pull-right" id="txtBPT_SchB_2C" type="text" style="WIDTH: 100%" 
				                                                onfocus=SetFocus() maxLength=10 onchange="ValidateWorksheet('BPT_SchdB')"/>

                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                            <tr>
                                            	<td width="5%">2d.</td>
                                                <td width="70%" class="text-left">Net Income (Loss) from Public Law 86-272 activities</td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                              <INPUT class="form-control input-sm pull-right" id="txtBPT_SchB_2D" type="text" style="WIDTH: 100%" 
				                                                onfocus=SetFocus() maxLength=10 onchange="ValidateWorksheet('BPT_SchdB')"/> </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                            
                                            <tr class="odd">
                                            	<td width="5%">2e.</td>
                                                <td width="70%" class="text-left">Receipts by corporations of dividends, interest and royalties received from other corporations in the same affiliated group and/or from other corporations of which the receiving corporation owns at least 20% of the stock and/or BIRT Regulation §404(G) adjustments (Reg. 302(14))</td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                              <INPUT class="form-control input-sm pull-right" id="txtBPT_SchB_2E" type="text" style="WIDTH: 100%" 
				                                                onfocus=SetFocus() maxLength=10 onchange="ValidateWorksheet('BPT_SchdB')"/>
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                            <tr>
                                            	<td width="5%">2f.</td>
                                                <td width="70%" class="text-left">Line 1 minus Lines 2a through 2e </td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                                 <LABEL id="lblBPT_SchB_2F" style="WIDTH: 100%" class="form-control input-sm pull-right"></LABEL>
				
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                     		<tr class="odd">
                                            	<td width="5%">2g.</td>
                                                <td width="70%" class="text-left">All other receipts from other corporations of the same affiliated group. (Reg. 302 (N))</td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                                 <INPUT class="form-control input-sm pull-right" id="txtBPT_SchB_2G" type="text" style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=10 onchange="ValidateWorksheet('BPT_SchdB')"/>
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                            <tr>
                                            	<td width="5%">2h.</td>
                                                <td width="70%" class="text-left">Gross Receipts per BIRT Regulation §404(2)(E)(V)</td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                                  <INPUT class="form-control input-sm pull-right" id="txtBPT_SchB_2H" type="text" style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=10 onchange="ValidateWorksheet('BPT_SchdB')"/>
                                                            </div>
                                                          </div>
                                            
                                            		</form>

                                                </td>
                                            </tr>
                                            
                                            <tr class="odd">
                                            	<td width="5%">2i.</td>
                                                <td width="70%" class="text-left">Divide Line 2g by Line 2h</td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">                                                            
                                                                 <LABEL id="lblBPT_SchB_2I" class="form-control input-sm pull-right" style="WIDTH: 100%"></LABEL>
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                            <tr>
                                            	<td width="5%">2j.</td>
                                                <td width="70%" class="text-left">Multiply Line 2f by Line 2i </td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                            
                                                                <LABEL id="lblBPT_SchB_2J" class="form-control input-sm pull-right" style="WIDTH: 100%"></LABEL>
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                     		<tr class="odd">
                                            	<td width="5%">3.</td>
                                                <td width="70%" class="text-left">ADJUSTED NET INCOME(Loss)[Calculated - Line 2f minus Line 2j]</td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                             
                                                                <label id="lblBPT_SchB_3" style="width:100%;" class="form-control input-sm pull-right"></label>
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                            <tr>
                                            	<td widh="5%">4</td>
                                                <td width="70%" class="text-left">Total Nonbusiness Income (Loss)</td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                                <INPUT class="form-control input-sm pull-right" id="txtBPT_SchB_4" type="text" style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=10 onchange="ValidateWorksheet('BPT_SchdB')"/>
                                                            </div>
                                                          </div>
                                            
                                            		</form>

                                                </td>
                                            </tr>
                                            
                                            <tr class="odd">
                                            	<td widh="5%">5.</td>
                                                <td widh="70%" class="text-left">Income(Loss) to be apportioned[Calculated - Line 3 minus Line 4]</td>
                                                <td widh="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                             
                                                                 <LABEL id="lblBPT_SchB_5" class="form-control input-sm pull-right"style="WIDTH: 100%"></LABEL>
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                            <tr>
                                            	<td widh="5%">6.</td>
                                                <td widh="70%" class="text-left">Average of Apportionment Factors (from
                                                <label id="lnkSchC1" class="lblLink" style="width:100%" onclick="ShowPage('SchdC1')">Click here for Schedule C-1, Line 3</label>).</td>
                                                <td widh="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                              <LABEL id="lblBPT_SchB_6" class="form-control input-sm pull-right"style="WIDTH: 100%"></LABEL>
                                                          </div>
                                                     </div>
                                            		</form>
                                                </td>
                                            </tr>
                                     		<tr class="odd">
                                            	<td widh="5%">7.</td>
                                                <td widh="70%" class="text-left">Income (Loss) apportioned to Philadelphia[Calculated - Multiply Line 5 by Line 6]</td>
                                                <td widh="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                             
                                                                <LABEL id="lblBPT_SchB_7" style="WIDTH: 100%" class="form-control input-sm pull-right"></LABEL>
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                            <tr>
                                            	<td widh="5%">8.</td>
                                                 <td widh="70%" class="text-left">Nonbusiness Income (Loss) allocated to Philadelphia</td>
                                                <td widh="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                           
                                                                 <INPUT class="form-control input-sm pull-right" id="txtBPT_SchB_8" type="text" style="WIDTH: 100%" onfocus=SetFocus() maxLength=10 onchange="ValidateWorksheet('BPT_SchdB')"/>
                                                            </div>
                                                          </div>
                                            
                                            		</form>

                                                </td>
                                            </tr>
                                     		
                                            <tr class="odd">
                                            	<td widh="5%">9.</td>
                                                 <td widh="70%" class="text-left">Current Year Income (Loss)[Calculated - Line 7 plus Line 8]</td>
                                                <td widh="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                             
                                                                 <LABEL  id="lblBPT_SchB_9" style="WIDTH: 100%" class="form-control input-sm pull-right"></LABEL>
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                            <tr>
                                            	<td widh="5%">10.</td>
                                               <%-- <td widh="70%" class="text-left">Statutory Net Income Deduction  (from 
                                        <label id="lblLnkBWRKS" class="lblLink" style="width:100%" onclick="ShowPage('WRKSB')">Worksheet S, Line S5</label>
                                        --%>
			                              <%--  ).</td>--%>
                                                <td widh="70%" class="text-left">Statutory Net Income Deduction from</td>
                                                <td widh="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                              <LABEL id="lblBPT_SchB_10" class="form-control input-sm pull-right"style="WIDTH: 100%"></LABEL>
                                                          </div>
                                                     </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                     		<tr class="odd">
                                            	<td widh="5%">11.</td>
                                                <td widh="70%" class="text-left">Loss Carry Forward, if any (<u><font>see LCF on side menu bar</font></u>)</td>
                                                <td widh="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                              <INPUT id="txtBPT_SchB_11" disabled="disabled" type="text" style="WIDTH: 100%" class="form-control input-sm pull-right"
				onfocus=SetFocus() maxLength=10 onchange="ValidateWorksheet('BPT_SchdB')"/></div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                            <tr>
                                            	<td widh="5%">12.</td>
                                                <td widh="70%" class="text-left">Taxable Income (Loss)[Calculated - Line 9 minus Line 10 minus Line 11]</td>
                                                <td widh="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">                                                             
                                                                  <label id="lblBPT_SchB_12" style="WIDTH: 100%" class="form-control input-sm pull-right"></label>
                                                            </div>
                                                          </div>                                            
                                            		</form>
                                                </td>
                                            </tr>
                                            <tr class="odd">
                                            	<td widh="5%">13.</td>
                                                <td widh="70%" class="text-left"><LABEL id=msgBPT_SchB_13 class=""><B>TAX DUE</B> (Multiply Line 12 by ###) If Line 12 is a loss, enter zero</LABEL></td>
                                                <td widh="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                                  <LABEL id="lblBPT_SchB_13" style="WIDTH: 100%" class="form-control input-sm pull-right"></LABEL>
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
                              </div>  
                                 <!--  <!-- Schedule B Form  END -->
   
                                
                            </div>
                        </div>
          </div>
                        
                 <div class="lets-split"></div>   	
          
</body>

</html>
