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
            var lblBPT_SchB_2F = document.getElementById('lblBPT_SchB_2F');
            var txtBPT_SchB_2G = document.getElementById('txtBPT_SchB_2G');
            var txtBPT_SchB_2H = document.getElementById('txtBPT_SchB_2H');
            var lblBPT_SchB_2I = document.getElementById('lblBPT_SchB_2I');
            var lblBPT_SchB_3 = document.getElementById('lblBPT_SchB_3');
            var txtBPT_SchB_4 = document.getElementById('txtBPT_SchB_4');
            var lblBPT_SchB_5 = document.getElementById('lblBPT_SchB_5');
            var lblBPT_SchB_7 = document.getElementById('lblBPT_SchB_7');
            var txtBPT_SchB_8 = document.getElementById('txtBPT_SchB_8');
            var lblBPT_SchB_9 = document.getElementById('lblBPT_SchB_9');
            var txtBPT_SchB_11 = document.getElementById('txtBPT_SchB_11');
            var lblBPT_SchB_12 = document.getElementById('lblBPT_SchB_12');
            var lblBPT_SchB_13 = document.getElementById('lblBPT_SchB_13');
           

            var i = 0;
            arrSchdBErr[i++] = [txtBPT_SchB_1, txtBPT_SchB_1.value == "", 'Answer Question 1'];
            arrSchdBErr[i++] = [txtBPT_SchB_1, ispValue(txtBPT_SchB_1.value) == false, 'Value for Question 1 must be numeric'];
            arrSchdBErr[i++] = [txtBPT_SchB_2A, txtBPT_SchB_2A.value == "", 'Answer Question 2a'];
            arrSchdBErr[i++] = [txtBPT_SchB_2A, ispValue(txtBPT_SchB_2A.value) == false, 'Value for Question 2a must be numeric'];
            arrSchdBErr[i++] = [txtBPT_SchB_2B, txtBPT_SchB_2B.value == "", 'Answer Question 2b'];
            arrSchdBErr[i++] = [txtBPT_SchB_2B, ispValue(txtBPT_SchB_2B.value) == false, 'Value for Question 2b must be numeric'];
            arrSchdBErr[i++] = [txtBPT_SchB_2C, txtBPT_SchB_2C.value == "", 'Answer Question 2c'];
            arrSchdBErr[i++] = [txtBPT_SchB_2C, ispValue(txtBPT_SchB_2C.value) == false, 'Value for Question 2c must be numeric'];
            arrSchdBErr[i++] = [txtBPT_SchB_2D, txtBPT_SchB_2D.value == "", 'Answer Question 2d'];
            arrSchdBErr[i++] = [txtBPT_SchB_2D, ispValue(txtBPT_SchB_2D.value) == false, 'Value for Question 2d must be numeric'];
            arrSchdBErr[i++] = [txtBPT_SchB_2E, txtBPT_SchB_2E.value == "", 'Answer Question 2e'];
            arrSchdBErr[i++] = [txtBPT_SchB_2E, ispValue(txtBPT_SchB_2E.value) == false, 'Value for Question 2e must be numeric'];
            arrSchdBErr[i++] = [txtBPT_SchB_2G, txtBPT_SchB_2G.value == "", 'Answer Question 2g'];
            arrSchdBErr[i++] = [txtBPT_SchB_2G, ispValue(txtBPT_SchB_2G.value) == false, 'Value for Question 2g must be numeric'];
            arrSchdBErr[i++] = [txtBPT_SchB_2H, txtBPT_SchB_2H.value == "", 'Answer Question 2h'];
            arrSchdBErr[i++] = [txtBPT_SchB_2H, ispValue(txtBPT_SchB_2H.value) == false, 'Value for Question 2h must be numeric'];
            arrSchdBErr[i++] = [txtBPT_SchB_4, txtBPT_SchB_4.value == "", 'Answer Question 4'];
            arrSchdBErr[i++] = [txtBPT_SchB_4, ispValue(txtBPT_SchB_4.value) == false, 'Value for Question 4 must be numeric'];
            arrSchdBErr[i++] = [txtBPT_SchB_8, txtBPT_SchB_8.value == "", 'Answer Question 8'];
            arrSchdBErr[i++] = [txtBPT_SchB_8,ispValue(txtBPT_SchB_8.value) == false, 'Value for Question 8 must be numeric'];

            arrSchdBErr[i++] = [txtBPT_SchB_11, txtBPT_SchB_11.value == "", 'Answer Question 11'];  //binoy
            arrSchdBErr[i++] = [txtBPT_SchB_11, ispValue(txtBPT_SchB_11.value) == false, 'Value for Question 11 must be numeric'];
            arrSchdBErr[i++] = [txtBPT_SchB_11, ispNegativeNumber(txtBPT_SchB_11.value) == false, 'Value for Question 11 must NOT be negative'];
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

            var txtBPT_SchB_1 = document.getElementById('txtBPT_SchB_1');
            var txtBPT_SchB_2A = document.getElementById('txtBPT_SchB_2A');
            var txtBPT_SchB_2B = document.getElementById('txtBPT_SchB_2B');
            var txtBPT_SchB_2C = document.getElementById('txtBPT_SchB_2C');
            var txtBPT_SchB_2D = document.getElementById('txtBPT_SchB_2D');
            var txtBPT_SchB_2E = document.getElementById('txtBPT_SchB_2E');
            var lblBPT_SchB_2F = document.getElementById('lblBPT_SchB_2F');
            var txtBPT_SchB_2G = document.getElementById('txtBPT_SchB_2G');
            var txtBPT_SchB_2H = document.getElementById('txtBPT_SchB_2H');
            var lblBPT_SchB_2I = document.getElementById('lblBPT_SchB_2I');
            var lblBPT_SchB_3 = document.getElementById('lblBPT_SchB_3');
            var txtBPT_SchB_4 = document.getElementById('txtBPT_SchB_4');
            var lblBPT_SchB_5 = document.getElementById('lblBPT_SchB_5');
            var lblBPT_SchB_7 = document.getElementById('lblBPT_SchB_7');
            var txtBPT_SchB_8 = document.getElementById('txtBPT_SchB_8');
            var lblBPT_SchB_9 = document.getElementById('lblBPT_SchB_9');
            var txtBPT_SchB_11 = document.getElementById('txtBPT_SchB_11');
            var lblBPT_SchB_12 = document.getElementById('lblBPT_SchB_12');
            var lblBPT_SchB_13 = document.getElementById('lblBPT_SchB_13');

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency(txtBPT_SchB_1.value), xFldScBLi1, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency(txtBPT_SchB_2A.value), xFldScBLi2a, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency(txtBPT_SchB_2B.value), xFldScBLi2b, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency(txtBPT_SchB_2C.value), xFldScBLi2c, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency(txtBPT_SchB_2D.value), xFldScBLi2d, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency(txtBPT_SchB_2E.value), xFldScBLi2e, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#lblBPT_SchB_2F').text()), xFldScBLi2f, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency(txtBPT_SchB_2G.value), xFldScBLi2g, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency(txtBPT_SchB_2H.value), xFldScBLi2h, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, $('#lblBPT_SchB_2I').text(), xFldScBLi2i, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#lblBPT_SchB_2J').text()), xFldScBLi2j, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#lblBPT_SchB_3').text()), xFldScBLi3, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency(txtBPT_SchB_4.value), xFldScBLi4, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#lblBPT_SchB_5').text()), xFldScBLi5, '', 0);
            //EGOVWEB-63
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, parseFloat($('#lblBPT_SchB_6').text()).toFixed(6), xFldScBLi6, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#lblBPT_SchB_7').text()), xFldScBLi7, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency(txtBPT_SchB_8.value), xFldScBLi8, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#lblBPT_SchB_9').text()), xFldScBLi9, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#lblBPT_SchB_10').text()), xFldScBLi10, '', 0);  //binoy

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency(txtBPT_SchB_11.value), xFldScBLi11, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#lblBPT_SchB_12').text()), xFldScBLi12, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#lblBPT_SchB_13').text()), xFldScBLi13, '', 0);
        }		//PopulateBPTlfXMLSchdB

        function PopulateBPTlfSchdB() {

            var txtBPT_SchB_1 = document.getElementById('txtBPT_SchB_1');
            var txtBPT_SchB_2A = document.getElementById('txtBPT_SchB_2A');
            var txtBPT_SchB_2B = document.getElementById('txtBPT_SchB_2B');
            var txtBPT_SchB_2C = document.getElementById('txtBPT_SchB_2C');
            var txtBPT_SchB_2D = document.getElementById('txtBPT_SchB_2D');
            var txtBPT_SchB_2E = document.getElementById('txtBPT_SchB_2E');
            var lblBPT_SchB_2F = document.getElementById('lblBPT_SchB_2F');
            var txtBPT_SchB_2G = document.getElementById('txtBPT_SchB_2G');
            var txtBPT_SchB_2H = document.getElementById('txtBPT_SchB_2H');
            var lblBPT_SchB_2I = document.getElementById('lblBPT_SchB_2I');
            var lblBPT_SchB_3 = document.getElementById('lblBPT_SchB_3');
            var txtBPT_SchB_4 = document.getElementById('txtBPT_SchB_4');
            var lblBPT_SchB_5 = document.getElementById('lblBPT_SchB_5');
            var lblBPT_SchB_7 = document.getElementById('lblBPT_SchB_7');
            var txtBPT_SchB_8 = document.getElementById('txtBPT_SchB_8');
            var lblBPT_SchB_9 = document.getElementById('lblBPT_SchB_9');
            var txtBPT_SchB_11 = document.getElementById('txtBPT_SchB_11');
            var lblBPT_SchB_12 = document.getElementById('lblBPT_SchB_12');
            var lblBPT_SchB_13 = document.getElementById('lblBPT_SchB_13');

            txtBPT_SchB_1.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi1, '', 0), 0);
            txtBPT_SchB_2A.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi2a, '', 0), 0);
            txtBPT_SchB_2B.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi2b, '', 0), 0);
            txtBPT_SchB_2C.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi2c, '', 0), 0);
            txtBPT_SchB_2D.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi2d, '', 0), 0);
            txtBPT_SchB_2E.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi2e, '', 0), 0);
            $('#lblBPT_SchB_2F').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi2f, '', 0), 0));
            txtBPT_SchB_2G.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi2g, '', 0), 0);
            txtBPT_SchB_2H.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi2h, '', 0), 0);
            //alert(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi2i, '', 0));
            //alert(PrepForMath(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi2i, '', 0)) * 100);

            $('#lblBPT_SchB_2I').text('$' + (PrepForMath(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi2i, '', 0)) * 100).toString());
            $('#lblBPT_SchB_2J').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi2j, '', 0), 0));

            $('#lblBPT_SchB_3').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi3, '', 0), 0));
            txtBPT_SchB_4.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi4, '', 0), 0);
            $('#lblBPT_SchB_5').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi5, '', 0), 0));
            $('#lblBPT_SchB_6').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi6, '', 0) * 100);
            $('#lblBPT_SchB_7').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi7, '', 0), 0));
            txtBPT_SchB_8.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi8, '', 0), 0);
            $('#lblBPT_SchB_9').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi9, '', 0), 0));
            //EGOVWEB-131 EHD 03/25/2013 Always populate from BPT_INFO(xFldInfLossCarry) not BPT_SCH_A(xFldScBLi10)
            //  $('#lblBPT_SchB_10').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldInfLossCarry, '', 0), 0));
            $('#lblBPT_SchB_10').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi10, '', 0), 0)); //binoy
            txtBPT_SchB_11.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi11, '', 0), 0);
            $('#lblBPT_SchB_12').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi12, '', 0), 0));
            $('#lblBPT_SchB_13').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScBLi13, '', 0), 0));

            $('#msgBPT_SchB_13').text($('#msgBPT_SchB_13').text().replace('###', dBPTNetRate));
        }		//PopulateBPTlfSchdB

        function ResetBPTlfSchdB() {

            var txtBPT_SchB_1 = document.getElementById('txtBPT_SchB_1');
            var txtBPT_SchB_2A = document.getElementById('txtBPT_SchB_2A');
            var txtBPT_SchB_2B = document.getElementById('txtBPT_SchB_2B');
            var txtBPT_SchB_2C = document.getElementById('txtBPT_SchB_2C');
            var txtBPT_SchB_2D = document.getElementById('txtBPT_SchB_2D');
            var txtBPT_SchB_2E = document.getElementById('txtBPT_SchB_2E');
            var lblBPT_SchB_2F = document.getElementById('lblBPT_SchB_2F');
            var txtBPT_SchB_2G = document.getElementById('txtBPT_SchB_2G');
            var txtBPT_SchB_2H = document.getElementById('txtBPT_SchB_2H');
            var lblBPT_SchB_2I = document.getElementById('lblBPT_SchB_2I');
            var lblBPT_SchB_3 = document.getElementById('lblBPT_SchB_3');
            var txtBPT_SchB_4 = document.getElementById('txtBPT_SchB_4');
            var lblBPT_SchB_5 = document.getElementById('lblBPT_SchB_5');
            var lblBPT_SchB_7 = document.getElementById('lblBPT_SchB_7');
            var txtBPT_SchB_8 = document.getElementById('txtBPT_SchB_8');
            var lblBPT_SchB_9 = document.getElementById('lblBPT_SchB_9');
            var txtBPT_SchB_11 = document.getElementById('txtBPT_SchB_11');
            var lblBPT_SchB_12 = document.getElementById('lblBPT_SchB_12');
            var lblBPT_SchB_13 = document.getElementById('lblBPT_SchB_13');

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
            $('#lblBPT_SchB_10').text(ispFormatMoney(0, 0));  //binoy
            txtBPT_SchB_11.value = ispFormatMoney(0, 0);

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

            var txtBPT_SchB_1 = document.getElementById('txtBPT_SchB_1');
            var txtBPT_SchB_2A = document.getElementById('txtBPT_SchB_2A');
            var txtBPT_SchB_2B = document.getElementById('txtBPT_SchB_2B');
            var txtBPT_SchB_2C = document.getElementById('txtBPT_SchB_2C');
            var txtBPT_SchB_2D = document.getElementById('txtBPT_SchB_2D');
            var txtBPT_SchB_2E = document.getElementById('txtBPT_SchB_2E');
            var lblBPT_SchB_2F = document.getElementById('lblBPT_SchB_2F');
            var txtBPT_SchB_2G = document.getElementById('txtBPT_SchB_2G');
            var txtBPT_SchB_2H = document.getElementById('txtBPT_SchB_2H');
            var lblBPT_SchB_2I = document.getElementById('lblBPT_SchB_2I');
            var lblBPT_SchB_3 = document.getElementById('lblBPT_SchB_3');
            var txtBPT_SchB_4 = document.getElementById('txtBPT_SchB_4');
            var lblBPT_SchB_5 = document.getElementById('lblBPT_SchB_5');
            var lblBPT_SchB_7 = document.getElementById('lblBPT_SchB_7');
            var txtBPT_SchB_8 = document.getElementById('txtBPT_SchB_8');
            var lblBPT_SchB_9 = document.getElementById('lblBPT_SchB_9');
            var txtBPT_SchB_11 = document.getElementById('txtBPT_SchB_11');
            var lblBPT_SchB_12 = document.getElementById('lblBPT_SchB_12');
            var lblBPT_SchB_13 = document.getElementById('lblBPT_SchB_13');
            var txtBPT_SchA_1 = document.getElementById('txtBPT_SchA_1');
            if (getActiveElement().id == txtBPT_SchB_1 && PrepForMath(txtBPT_SchA_1.value) != 0) {
                ResetBPTlfSchdA();
            }		//if
            if ($(parent.AppError).text() == "") {
                CalcSchdBLine2f();
                CalcSchdBLine3();		//Calculate lines 2i, 2j and 3
                CalcSchdBLine7();		//Calculate lines 5, and 7
                CalcSchdBLine9();
                CalcSchdBLine12();		//Calculate lines 11, and 12
            }		//if
        }		//PerformCalcsBPTlfSchdB

        function CalcSchdBLine2f() {

            var txtBPT_SchB_1 = document.getElementById('txtBPT_SchB_1');
            var txtBPT_SchB_2A = document.getElementById('txtBPT_SchB_2A');
            var txtBPT_SchB_2B = document.getElementById('txtBPT_SchB_2B');
            var txtBPT_SchB_2C = document.getElementById('txtBPT_SchB_2C');
            var txtBPT_SchB_2D = document.getElementById('txtBPT_SchB_2D');
            var txtBPT_SchB_2E = document.getElementById('txtBPT_SchB_2E');
            var lblBPT_SchB_2F = document.getElementById('lblBPT_SchB_2F');
            var txtBPT_SchB_2G = document.getElementById('txtBPT_SchB_2G');
            var txtBPT_SchB_2H = document.getElementById('txtBPT_SchB_2H');
            var lblBPT_SchB_2I = document.getElementById('lblBPT_SchB_2I');
            var lblBPT_SchB_3 = document.getElementById('lblBPT_SchB_3');
            var txtBPT_SchB_4 = document.getElementById('txtBPT_SchB_4');
            var lblBPT_SchB_5 = document.getElementById('lblBPT_SchB_5');
            var lblBPT_SchB_7 = document.getElementById('lblBPT_SchB_7');
            var txtBPT_SchB_8 = document.getElementById('txtBPT_SchB_8');
            var lblBPT_SchB_9 = document.getElementById('lblBPT_SchB_9');
            var txtBPT_SchB_11 = document.getElementById('txtBPT_SchB_11');
            var lblBPT_SchB_12 = document.getElementById('lblBPT_SchB_12');
            var lblBPT_SchB_13 = document.getElementById('lblBPT_SchB_13');

            if (txtBPT_SchB_1.value != '' && txtBPT_SchB_2A.value != '' && txtBPT_SchB_2B.value != '' &&
                    txtBPT_SchB_2C.value != '' && txtBPT_SchB_2D.value != '' && txtBPT_SchB_2E.value != '') {
                //Lines 2a thru 2e

                var temp = PrepForMath(txtBPT_SchB_2A.value) + PrepForMath(txtBPT_SchB_2B.value) +
                        PrepForMath(txtBPT_SchB_2C.value) + PrepForMath(txtBPT_SchB_2D.value) + PrepForMath(txtBPT_SchB_2E.value);

                $('#lblBPT_SchB_2F').text(ispFormatMoney(PrepForMath(txtBPT_SchB_1.value) - temp, 0));
            }		//if
        }		//CalcSchdBLine2f

        function CalcSchdBLine3() {

            var txtBPT_SchB_1 = document.getElementById('txtBPT_SchB_1');
            var txtBPT_SchB_2A = document.getElementById('txtBPT_SchB_2A');
            var txtBPT_SchB_2B = document.getElementById('txtBPT_SchB_2B');
            var txtBPT_SchB_2C = document.getElementById('txtBPT_SchB_2C');
            var txtBPT_SchB_2D = document.getElementById('txtBPT_SchB_2D');
            var txtBPT_SchB_2E = document.getElementById('txtBPT_SchB_2E');
            var lblBPT_SchB_2F = document.getElementById('lblBPT_SchB_2F');
            var txtBPT_SchB_2G = document.getElementById('txtBPT_SchB_2G');
            var txtBPT_SchB_2H = document.getElementById('txtBPT_SchB_2H');
            var lblBPT_SchB_2I = document.getElementById('lblBPT_SchB_2I');
            var lblBPT_SchB_3 = document.getElementById('lblBPT_SchB_3');
            var txtBPT_SchB_4 = document.getElementById('txtBPT_SchB_4');
            var lblBPT_SchB_5 = document.getElementById('lblBPT_SchB_5');
            var lblBPT_SchB_7 = document.getElementById('lblBPT_SchB_7');
            var txtBPT_SchB_8 = document.getElementById('txtBPT_SchB_8');
            var lblBPT_SchB_9 = document.getElementById('lblBPT_SchB_9');
            var txtBPT_SchB_11 = document.getElementById('txtBPT_SchB_11');
            var lblBPT_SchB_12 = document.getElementById('lblBPT_SchB_12');
            var lblBPT_SchB_13 = document.getElementById('lblBPT_SchB_13');

            //if ($('#lblBPT_SchB_3').text() != '' && txtBPT_SchB_2G.value != '' && txtBPT_SchB_2H.value != '') {

            //    if (PrepForMath(txtBPT_SchB_2G.value) == 0 || PrepForMath(txtBPT_SchB_2H.value) == 0) {

            //        $('#lblBPT_SchB_2I').text(0);
            //    } else {

            //        $('#lblBPT_SchB_2I').ispFormatMoney(text(parseFloat(PrepForMath(txtBPT_SchB_2G.value) / PrepForMath(txtBPT_SchB_2H.value)).toFixed(6)),0);
            //    }		//if
            //    $('#lblBPT_SchB_2J').text(ispFormatMoney(PrepForMath($('#lblBPT_SchB_2F').text()) * PrepForMath($('#lblBPT_SchB_2I').text()), 0));
            //    $('#lblBPT_SchB_3').text(ispFormatMoney(PrepForMath($('#lblBPT_SchB_2F').text()) - PrepForMath($('#lblBPT_SchB_2J').text()), 0));
            //}	
            if (txtBPT_SchB_2G.value != '' && txtBPT_SchB_2H.value != '') {

                if (PrepForMath(txtBPT_SchB_2G.value) == 0 || PrepForMath(txtBPT_SchB_2H.value) == 0) {

                    $('#lblBPT_SchB_2I').text(0);
                } else {

                    $('#lblBPT_SchB_2I').text(ispFormatMoney(parseFloat(PrepForMath(txtBPT_SchB_2G.value) / PrepForMath(txtBPT_SchB_2H.value)).toFixed(6)), 0);
                }
                $('#lblBPT_SchB_2J').text(ispFormatMoney(PrepForMath($('#lblBPT_SchB_2F').text()) * PrepForMath($('#lblBPT_SchB_2I').text()), 0));
            }
            if ($('#lblBPT_SchB_3').text() != '' && txtBPT_SchB_2G.value != '' && txtBPT_SchB_2H.value != '') {
                //if

                $('#lblBPT_SchB_3').text(ispFormatMoney(PrepForMath($('#lblBPT_SchB_2F').text()) - PrepForMath($('#lblBPT_SchB_2J').text()), 0));
            }
            //if
        }		//CalcSchdBLine3

        function CalcSchdBLine7() {

            var txtBPT_SchB_1 = document.getElementById('txtBPT_SchB_1');
            var txtBPT_SchB_2A = document.getElementById('txtBPT_SchB_2A');
            var txtBPT_SchB_2B = document.getElementById('txtBPT_SchB_2B');
            var txtBPT_SchB_2C = document.getElementById('txtBPT_SchB_2C');
            var txtBPT_SchB_2D = document.getElementById('txtBPT_SchB_2D');
            var txtBPT_SchB_2E = document.getElementById('txtBPT_SchB_2E');
            var lblBPT_SchB_2F = document.getElementById('lblBPT_SchB_2F');
            var txtBPT_SchB_2G = document.getElementById('txtBPT_SchB_2G');
            var txtBPT_SchB_2H = document.getElementById('txtBPT_SchB_2H');
            var lblBPT_SchB_2I = document.getElementById('lblBPT_SchB_2I');
            var lblBPT_SchB_3 = document.getElementById('lblBPT_SchB_3');
            var txtBPT_SchB_4 = document.getElementById('txtBPT_SchB_4');
            var lblBPT_SchB_5 = document.getElementById('lblBPT_SchB_5');
            var lblBPT_SchB_7 = document.getElementById('lblBPT_SchB_7');
            var txtBPT_SchB_8 = document.getElementById('txtBPT_SchB_8');
            var lblBPT_SchB_9 = document.getElementById('lblBPT_SchB_9');
            var txtBPT_SchB_11 = document.getElementById('txtBPT_SchB_11');
            var lblBPT_SchB_12 = document.getElementById('lblBPT_SchB_12');
            var lblBPT_SchB_13 = document.getElementById('lblBPT_SchB_13');

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


            var txtBPT_SchB_1 = document.getElementById('txtBPT_SchB_1');
            var txtBPT_SchB_2A = document.getElementById('txtBPT_SchB_2A');
            var txtBPT_SchB_2B = document.getElementById('txtBPT_SchB_2B');
            var txtBPT_SchB_2C = document.getElementById('txtBPT_SchB_2C');
            var txtBPT_SchB_2D = document.getElementById('txtBPT_SchB_2D');
            var txtBPT_SchB_2E = document.getElementById('txtBPT_SchB_2E');
            var lblBPT_SchB_2F = document.getElementById('lblBPT_SchB_2F');
            var txtBPT_SchB_2G = document.getElementById('txtBPT_SchB_2G');
            var txtBPT_SchB_2H = document.getElementById('txtBPT_SchB_2H');
            var lblBPT_SchB_2I = document.getElementById('lblBPT_SchB_2I');
            var lblBPT_SchB_3 = document.getElementById('lblBPT_SchB_3');
            var txtBPT_SchB_4 = document.getElementById('txtBPT_SchB_4');
            var lblBPT_SchB_5 = document.getElementById('lblBPT_SchB_5');
            var lblBPT_SchB_7 = document.getElementById('lblBPT_SchB_7');
            var txtBPT_SchB_8 = document.getElementById('txtBPT_SchB_8');
            var lblBPT_SchB_9 = document.getElementById('lblBPT_SchB_9');
            var txtBPT_SchB_11 = document.getElementById('txtBPT_SchB_11');
            var lblBPT_SchB_12 = document.getElementById('lblBPT_SchB_12');
            var lblBPT_SchB_13 = document.getElementById('lblBPT_SchB_13');

            if ($('#lblBPT_SchB_7').text() != '' && txtBPT_SchB_8.value != '') {

                $('#lblBPT_SchB_9').text(ispFormatMoney(PrepForMath($('#lblBPT_SchB_7').text()) + PrepForMath(txtBPT_SchB_8.value), 0));

                if ((PrepForMath($('#lblBPT_SchB_7').text()) + PrepForMath(txtBPT_SchB_8.value)) < 0) {

                    $('#lbl_BPT_WS2').text(ispFormatMoney(0, 0));

                }
                else {
                    $('#lbl_BPT_WS2').text($('#lblBPT_SchB_9').text());

                }
                Performvalidationandload();


            }		//if
        }		//CalcSchdBLine9

        function CalcSchdBLine12() {

            var txtBPT_SchB_1 = document.getElementById('txtBPT_SchB_1');
            var txtBPT_SchB_2A = document.getElementById('txtBPT_SchB_2A');
            var txtBPT_SchB_2B = document.getElementById('txtBPT_SchB_2B');
            var txtBPT_SchB_2C = document.getElementById('txtBPT_SchB_2C');
            var txtBPT_SchB_2D = document.getElementById('txtBPT_SchB_2D');
            var txtBPT_SchB_2E = document.getElementById('txtBPT_SchB_2E');
            var lblBPT_SchB_2F = document.getElementById('lblBPT_SchB_2F');
            var txtBPT_SchB_2G = document.getElementById('txtBPT_SchB_2G');
            var txtBPT_SchB_2H = document.getElementById('txtBPT_SchB_2H');
            var lblBPT_SchB_2I = document.getElementById('lblBPT_SchB_2I');
            var lblBPT_SchB_3 = document.getElementById('lblBPT_SchB_3');
            var txtBPT_SchB_4 = document.getElementById('txtBPT_SchB_4');
            var lblBPT_SchB_5 = document.getElementById('lblBPT_SchB_5');
            var lblBPT_SchB_7 = document.getElementById('lblBPT_SchB_7');
            var txtBPT_SchB_8 = document.getElementById('txtBPT_SchB_8');
            var lblBPT_SchB_9 = document.getElementById('lblBPT_SchB_9');
            var txtBPT_SchB_11 = document.getElementById('txtBPT_SchB_11');
            var lblBPT_SchB_12 = document.getElementById('lblBPT_SchB_12');
            var lblBPT_SchB_13 = document.getElementById('lblBPT_SchB_13');

            if ($('#lblBPT_SchB_9').text() != '' && $('#lblBPT_SchB_10').text() != '') {
                $('#lblBPT_SchB_12').text(ispFormatMoney(PrepForMath($('#lblBPT_SchB_9').text()) - PrepForMath($('#lblBPT_SchB_10').text())
                    - PrepForMath($('#txtBPT_SchB_11').value), 0));
                $('#lblBPT_SchB_13').text(ispFormatMoney(PrepForMath($('#lblBPT_SchB_12').text()) * dBPTNetRate, 0));
                if (PrepForMath($('#lblBPT_SchB_13').text()) < 0) {
                    $('#lblBPT_SchB_13').text(ispFormatMoney(0, 0));
                }
                $('#lblBPT1_1').text($('#lblBPT_SchB_13').text());
                //if
            }

            //if
        }		//CalcSchdBLine12
</script>
</head>
<body>
 <%--  <div class="form_segment" id="BPT_SchdB" style="DISPLAY: none;">
      
                                <table summary="Employee Pay Sheet" class="hor-zebra">

                                    <tbody>

                                        <tr class="odd">
                                            <td width="70%"><B><U>2014 BIRT Schedule B: Computation of Tax On Net Income(Method II)</U></B></td>
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
                                            <td>2c. Net Income (Loss) from specific PUC and ICC business activities. (Reg. 101 (D) (3))</td>
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
                                            <td>2e.  Receipts by corporations of dividends, interest and royalties received from other corporations in the same affiliated group and/or from other corporations of which the receiving corporation owns at least 20% of the stock and/or BIRT Regulation §404 (B)(5) adjustments (Reg. 302 (O))</td>
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
                                            <td>2g. All other receipts from other corporations of the same affiliated group. (Reg. 302 (N))</td>
                                            <td align="center" class="no_border_right">
                                               <INPUT class="" id=txtBPT_SchB_2G style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("BPT_SchdB")></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">2h. Gross Receipts per BIRT Regulation §404(B) (5) (e)</td>
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
                                            <td width="70%">10. Statutory Net Income Deduction  (from 
                                        <label id="lblLnkBWRKS" class="lblLink label_NoLeft" style="width:100%" onclick="ShowPage('WRKSB')">Worksheet S, Line S5</label>
                                        
			                                ).</td>
                                            <td align="center" class="no_border_right">
                                          <label class="" id=lblBPT_SchB_10 style="WIDTH: 100%" onfocus="SetFocus()" maxLength=10 ></label>
                                            </td>
                                        </tr>
                                          <tr >
                                            <td width="70%">11. Loss Carry Forward, if any.</td>
                                            <td align="center" class="no_border_right">
                                            <INPUT class="" id=txtBPT_SchB_11 style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("BPT_SchdB")>
                                            </td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">12. Taxable Income (Loss)[Calculated - Line 9 minus Line 10 minus Line 11]</td>
                                            <td align="center" class="no_border_right">
                                            <label  id=lblBPT_SchB_12 style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("BPT_SchdB")></label>
                                            </td>
                                        </tr>
                                          <tr class="odd">
                                            <%--<td width="70%">13.  <LABEL id=msgBPT_SchB_13 class=""><B>TAX DUE</B> (Multiply Line 11 by ###) If Line 12 is a loss, enter zero</LABEL></td>--%>
 <%--<td width="70%">13.  <LABEL id=msgBPT_SchB_13 class=""><B>TAX DUE</B> (Multiply Line 12 by ###) </LABEL></td>
                                            <td align="center" class="no_border_right">
                                            <LABEL id=lblBPT_SchB_13 style="WIDTH: 100%"></LABEL>
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

                            </div>--%>

 <%--<div class="container-fluid no-padding">
    <div class="block3">
        
     <div class="container-fluid">
     
     <div class="row">--%>
     
     <div class="col-lg-12 col-md-12" id="BPT_SchdB" style="DISPLAY: none;">   
     
     
            	<div class="row">
                    
                	
                    <!-- Schedule B Form -->
                    
                	<div class="col-lg-12 templateclass">
                        
                        <div class="well">                                          
                                <div class="table-responsive">
                                
                                	<table class="table table-condensed table-striped custom_table03">
                                    
                                    	<thead>
                                        	<tr>
                                            	<th colspan="3" width="100%"><B><U>2015 BIRT Schedule B: Computation of Tax On Net Income(Method II)</U></B></th>
                                       
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
                                                                  <INPUT class="form-control input-sm" id=txtBPT_SchB_1 style="WIDTH: 100%" 
				                                                    onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("BPT_SchdB")>
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                            <tr>
                                            <td colspan="3" class="text-left">ADJUSTMENTS (Per BIRT Reg. 404 and Public Law 86-272)</td>
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
                                                                <INPUT class="form-control input-sm" id=txtBPT_SchB_2A style="WIDTH: 100%" 
				                                                    onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("BPT_SchdB")>
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
                                                               <INPUT class="form-control input-sm" id=txtBPT_SchB_2B style="WIDTH: 100%" 
				                                                onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("BPT_SchdB")>
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                     		<tr class="odd">
                                            	<td width="5%">2c.</td>
                                                <td width="70%" class="text-left"> Net Income (Loss) from specific PUC and ICC business activities. (Reg. 101 (D) (3))</td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                             <INPUT class="form-control input-sm" id=txtBPT_SchB_2C style="WIDTH: 100%" 
				                                                onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("BPT_SchdB")>

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
                                                              <INPUT class="form-control input-sm" id=txtBPT_SchB_2D style="WIDTH: 100%" 
				                                                onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("BPT_SchdB")> </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                            
                                            <tr class="odd">
                                            	<td width="5%">2e.</td>
                                                <td width="70%" class="text-left"> Receipts by corporations of dividends, interest and royalties received from other corporations in the same affiliated group and/or from other corporations of which the receiving corporation owns at least 20% of the stock and/or BIRT Regulation §404 (B)(5) adjustments (Reg. 302 (O))</td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                              <INPUT class="form-control input-sm" id=txtBPT_SchB_2E style="WIDTH: 100%" 
				                                                onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("BPT_SchdB")>
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
                                                                 <LABEL id=lblBPT_SchB_2F style="WIDTH: 100%" class="form-control input-sm"></LABEL>
				
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
                                                                 <INPUT class="form-control input-sm" id=txtBPT_SchB_2G style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("BPT_SchdB")>
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                            <tr>
                                            	<td width="5%">2h.</td>
                                                <td width="70%" class="text-left">Gross Receipts per BIRT Regulation §404(B) (5) (e)</td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class=""
                                                                  <INPUT class="form-control input-sm" id=txtBPT_SchB_2H style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("BPT_SchdB")>
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
                                                            
                                                                 <LABEL id=lblBPT_SchB_2I class="form-control input-sm"
				style="WIDTH: 100%"></LABEL>
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
                                                            
                                                                <LABEL id=lblBPT_SchB_2J class="form-control input-sm" 
				style="WIDTH: 100%"></LABEL>
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
                                                             
                                                                <label id="lblBPT_SchB_3" style="width:100%;" class="form-control input-sm"></label>
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
                                                                <INPUT class="form-control input-sm" id=txtBPT_SchB_4 style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("BPT_SchdB")>
                                                            </div>
                                                          </div>
                                            
                                            		</form>

                                                </td>
                                            </tr>
                                            
                                            <tr class="odd">
                                            	<td widh="5%">5.</td>
                                                <td widh="70%" class="text-left">Income(Loss) to be apportioned[Calculated - Line 3 minus Line 4]/td>
                                                <td widh="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                             
                                                                 <LABEL id=lblBPT_SchB_5 class="form-control input-sm"style="WIDTH: 100%"></LABEL>
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                            <tr>
                                            	<td widh="5%">6.</td>
                                                <td widh="70%" class="text-left">Average of Apportionment Factors (from
                                                <label id="lnkSchC1" class="lblLink" style="width:100%" 
				onclick=ShowPage("SchdC1")>Click here for Schedule C-1, Line 12</label>
                                                ).</td>
                                                <td widh="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                             
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
                                                             
                                                                <LABEL id=lblBPT_SchB_7 style="WIDTH: 100%" class="form-control input-sm"></LABEL>
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                            <tr>
                                            	<td widh="5%"8.</td>
                                                    8.<td widh="70%" class="text-left">Nonbusiness Income (Loss) allocated to Philadelphia</td>
                                                <td widh="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                           
                                                                 <INPUT class="form-control input-sm" id=txtBPT_SchB_8 style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("BPT_SchdB")>
                                                            </div>
                                                          </div>
                                            
                                            		</form>

                                                </td>
                                            </tr>
                                     		
                                            <tr class="odd">
                                            	<td widh="5%"9.</td>
                                                    9.<td widh="70%" class="text-left">Current Year Income (Loss)[Calculated - Line 7 plus Line 8]</td>
                                                <td widh="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                             
                                                                 <LABEL  id=lblBPT_SchB_9 style="WIDTH: 100%" class="form-control input-sm"></LABEL>
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                            <tr>
                                            	<td widh="5%">10.</td>
                                                <td widh="70%" class="text-left">Statutory Net Income Deduction  (from 
                                        <label id="lblLnkBWRKS" class="lblLink" style="width:100%" onclick="ShowPage('WRKSB')">Worksheet S, Line S5</label>
                                        
			                                ).</td>
                                                <td widh="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                           </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                     		<tr class="odd">
                                            	<td widh="5%">11.</td>
                                                <td widh="70%" class="text-left">Loss Carry Forward, if any.</td>
                                                <td widh="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                              <INPUT id=txtBPT_SchB_11 style="WIDTH: 100%" class="form-control input-sm"
				onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("BPT_SchdB")></div>
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
                                                             
                                                                  <label  id=lblBPT_SchB_12 style="WIDTH: 100%" class="form-control input-sm"
				onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("BPT_SchdB")></label>
                                                            </div>
                                                          </div>
                                            
                                            		</form>

                                                </td>
                                            </tr>
                                            <tr class="odd">
                                            	<td widh="5%">13.</td>
                                                <td widh="70%" class="text-left"><LABEL id=msgBPT_SchB_13 class=""><B>TAX DUE</B> (Multiply Line 12 by ###) </LABEL></td>
                                                <td widh="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                                  <LABEL id=lblBPT_SchB_13 style="WIDTH: 100%" class="form-control input-sm"></LABEL>
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
                                           <input type="button" value="Return to Page 1" class="submit_button2" id="btnGoToPage1" onclick="ShowPage('Pg1')" />
                                        </div>
                                  </div>
                                
                                </form>
                              </div>  
                                 <!--  <!-- Schedule B Form  END -->
   
                                </div>
                                
                            </div>
                        </div>
                        
                    	
          
</body>

</html>
