<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>

<html>
<head>

    <title></title>
    <script src="../Content/Scripts/JqueryMin.js" type="text/javascript"></script>
    <!-- Bootstrap Core CSS -->
    <link href="../Content/Styles/bootstrap.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="../Content/Styles/copegov.css" rel="stylesheet">
    <link href="../Content/Styles/style.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../Content/Styles/jPushMenu.css">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script language='javascript' type="text/javascript">
        var arrSchdAErr = new Array();
        var xSecScA = 'BPT_SCH_A '; // this ending space is required
        var xFldScALi1 = xSecScA + 'NI_LOSS';
        var xFldScALi2 = xSecScA + 'NI_PORT_ACTIVITIES';
        var xFldScALi3 = xSecScA + 'NI_PUC_ICC';
        var xFldScALi4 = xSecScA + 'NI_PUBLIC_LAW';
        var xFldScALi5 = xSecScA + 'I_APPORTIONED';
        var xFldScALi6 = xSecScA + 'I_APPORTIONED_PERCENT';
        var xFldScALi7 = xSecScA + 'I_APPORTIONED_PHILA';
        var xFldScALi8 = xSecScA + 'I_NONBUS_PHILA';
        var xFldScALi9 = xSecScA + 'I_CURRENT_YEAR';

        var xFldScALi10 = xSecScA + 'STAT_NET_DEDUCTION_A_X';

        var xFldScALi11 = xSecScA + 'LOSS_CARRY_FORWARD';
        var xFldScALi12 = xSecScA + 'I_TAXABLE';
        var xFldScALi13 = xSecScA + 'TAX_DUE';


        function LoadErrorBPTlfSchdA() {
            var txtBPT_SchA_1 = document.getElementById('txtBPT_SchA_1');
            var txtBPT_SchA_2 = document.getElementById('txtBPT_SchA_2');
            var txtBPT_SchA_3 = document.getElementById('txtBPT_SchA_3');
            var txtBPT_SchA_4 = document.getElementById('txtBPT_SchA_4');
            var txtBPT_SchA_8 = document.getElementById('txtBPT_SchA_8');
            

            var i = 0;
            arrSchdAErr[i++] = [txtBPT_SchA_1, '$(\'#txtBPT_SchA_1\').val() == ""', 'Answer question 1'];
            arrSchdAErr[i++] = [txtBPT_SchA_1, 'ispValue($(\'#txtBPT_SchA_1\').val()) == false', 'Value for question 1 must be numeric'];
           

            arrSchdAErr[i++] = [txtBPT_SchA_2, '$(\'#txtBPT_SchA_2\').val() == ""', 'Answer question 2'];
            arrSchdAErr[i++] = [txtBPT_SchA_2, 'ispValue($(\'#txtBPT_SchA_2\').val()) == false', 'Value for question 2 must be numeric'];
            

            arrSchdAErr[i++] = [txtBPT_SchA_3, '$(\'#txtBPT_SchA_3\').val() == ""', 'Answer question 3'];
            arrSchdAErr[i++] = [txtBPT_SchA_3, 'ispValue($(\'#txtBPT_SchA_3\').val()) == false', 'Value for question 3 must be numeric'];
            

            arrSchdAErr[i++] = [txtBPT_SchA_4, '$(\'#txtBPT_SchA_4\').val() == ""', 'Answer question 4'];
            arrSchdAErr[i++] = [txtBPT_SchA_4, 'ispValue($(\'#txtBPT_SchA_4\').val()) == false', 'Value for question 4 must be numeric'];
           

            arrSchdAErr[i++] = [txtBPT_SchA_8, '$(\'#txtBPT_SchA_8\').val() == ""', 'Answer question 8'];
            arrSchdAErr[i++] = [txtBPT_SchA_8, 'ispValue($(\'#txtBPT_SchA_8\').val()) == false', 'Value for question 8 must be numeric'];
            

           
        }		//LoadErrorBPTlfSchdA

        function ClearBPTlfSchdA() {

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScALi1, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScALi2, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScALi3, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScALi4, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScALi5, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScALi6, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScALi7, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScALi8, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScALi9, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScALi10, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScALi11, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScALi12, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScALi13, '', 0);

        }		//ClearBPTlfSchdA

        function PopulateXmlBPTlfSchdA() {

            var txtBPT_SchA_1 = document.getElementById('txtBPT_SchA_1');
            var txtBPT_SchA_2 = document.getElementById('txtBPT_SchA_2');
            var txtBPT_SchA_3 = document.getElementById('txtBPT_SchA_3');
            var txtBPT_SchA_4 = document.getElementById('txtBPT_SchA_4');
            var lblBPT_SchA_5 = document.getElementById('lblBPT_SchA_5');
            var lblBPT_SchA_6 = document.getElementById('lblBPT_SchA_6');
            var lblBPT_SchA_7 = document.getElementById('lblBPT_SchA_7');
            var txtBPT_SchA_8 = document.getElementById('txtBPT_SchA_8');
            var lblBPT_SchA_9 = document.getElementById('lblBPT_SchA_9');
            var lblBPT_SchA_10 = document.getElementById('lblBPT_SchA_10');
            
            var lblBPT_SchA_12 = document.getElementById('lblBPT_SchA_11');
            var lblBPT_SchA_13 = document.getElementById('lblBPT_SchA_12');

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchA_1.value), xFldScALi1, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchA_2.value), xFldScALi2, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchA_3.value), xFldScALi3, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchA_4.value), xFldScALi4, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchA_5').text()), xFldScALi5, '', 0);
            //EGOVWEB-63
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, parseFloat($('#lblBPT_SchA_6').text()).toFixed(6), xFldScALi6, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchA_7').text()), xFldScALi7, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchA_8.value), xFldScALi8, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchA_9').text()), xFldScALi9, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchA_10').text()), xFldScALi11, '', 0);

           
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchA_11').text()), xFldScALi12, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchA_12').text()), xFldScALi13, '', 0);
           

        }		//PopulateBPTlfXMLSchdA

        function RightAlignText_A() {//Added 
            $('#txtBPT_SchA_1').css('text-align', 'right');
            $('#txtBPT_SchA_2').css('text-align', 'right');
            $('#txtBPT_SchA_3').css('text-align', 'right');
            $('#txtBPT_SchA_4').css('text-align', 'right');
            $('#txtBPT_SchA_8').css('text-align', 'right');
            


            $('#lblBPT_SchA_5').parent().css("text-align", "right");
            $('#lblBPT_SchA_6').parent().css("text-align", "right");
            $('#lblBPT_SchA_7').parent().css("text-align", "right");
            $('#lblBPT_SchA_9').parent().css("text-align", "right");
            $('#lblBPT_SchA_10').parent().css("text-align", "right");
            $('#lblBPT_SchA_11').parent().css("text-align", "right");
            $('#lblBPT_SchA_12').parent().css("text-align", "right");
        }
        function PopulateBPTlfSchdA() {
            debugger;
            var txtBPT_SchA_1 = document.getElementById('txtBPT_SchA_1');
            var txtBPT_SchA_2 = document.getElementById('txtBPT_SchA_2');
            var txtBPT_SchA_3 = document.getElementById('txtBPT_SchA_3');
            var txtBPT_SchA_4 = document.getElementById('txtBPT_SchA_4');
            var lblBPT_SchA_5 = document.getElementById('lblBPT_SchA_5');
            var lblBPT_SchA_6 = document.getElementById('lblBPT_SchA_6');
            var lblBPT_SchA_7 = document.getElementById('lblBPT_SchA_7');
            var txtBPT_SchA_8 = document.getElementById('txtBPT_SchA_8');
            var lblBPT_SchA_9 = document.getElementById('lblBPT_SchA_9');
            var lblBPT_SchA_10 = document.getElementById('lblBPT_SchA_10');
           
            var lblBPT_SchA_11 = document.getElementById('lblBPT_SchA_11');
            var lblBPT_SchA_12 = document.getElementById('lblBPT_SchA_12');

            txtBPT_SchA_1.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScALi1, '', 0), 0);
            txtBPT_SchA_2.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScALi2, '', 0), 0);
            txtBPT_SchA_3.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScALi3, '', 0), 0);
            txtBPT_SchA_4.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScALi4, '', 0), 0);

            

            $('#lblBPT_SchA_5').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScALi5, '', 0), 0));

           

            $('#lblBPT_SchA_6').text(parseFloat(ispRemoveMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScALi6, '', 0)) / 10000).toFixed(6));//updated by SumanG
            
            $('#lblBPT_SchA_7').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScALi7, '', 0), 0));
            txtBPT_SchA_8.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScALi8, '', 0), 0);
            $('#lblBPT_SchA_9').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScALi9, '', 0), 0));
            //EGOVWEB-131 EHD 03/25/2013 Always populate from BPT_INFO(xFldInfLossCarry) not BPT_SCH_A(xFldScALi10)
            $('#lblBPT_SchA_10').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldInfLossCarry, '', 0), 0));
            
            $('#lblBPT_SchA_11').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScALi12, '', 0), 0));
            $('#lblBPT_SchA_12').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScALi13, '', 0), 0));

           
            $('#msgBPT_SchA_13').text($('#msgBPT_SchA_13').text().replace('###', dBPTNetRate));
        }		//PopulateBPTlfSchdA

        function ResetBPTlfSchdA() {
            var txtBPT_SchA_1 = document.getElementById('txtBPT_SchA_1');
            var txtBPT_SchA_2 = document.getElementById('txtBPT_SchA_2');
            var txtBPT_SchA_3 = document.getElementById('txtBPT_SchA_3');
            var txtBPT_SchA_4 = document.getElementById('txtBPT_SchA_4');
            var lblBPT_SchA_5 = document.getElementById('lblBPT_SchA_5');
            var lblBPT_SchA_6 = document.getElementById('lblBPT_SchA_6');
            var lblBPT_SchA_7 = document.getElementById('lblBPT_SchA_7');
            var txtBPT_SchA_8 = document.getElementById('txtBPT_SchA_8');
            var lblBPT_SchA_9 = document.getElementById('lblBPT_SchA_9');
            var lblBPT_SchA_10 = document.getElementById('lblBPT_SchA_10');
            
            var lblBPT_SchA_11 = document.getElementById('lblBPT_SchA_11');
            var lblBPT_SchA_12 = document.getElementById('lblBPT_SchA_12');

            txtBPT_SchA_1.value = ispFormatMoney(0, 0);
            txtBPT_SchA_2.value = ispFormatMoney(0, 0);
            txtBPT_SchA_3.value = ispFormatMoney(0, 0);
            txtBPT_SchA_4.value = ispFormatMoney(0, 0);
            $('#lblBPT_SchA_5').text(ispFormatMoney(0, 0));
            $('#lblBPT_SchA_6').text(0);
            $('#lblBPT_SchA_7').text(ispFormatMoney(0, 0));
            txtBPT_SchA_8.value = ispFormatMoney(0, 0);
            $('#lblBPT_SchA_9').text(ispFormatMoney(0, 0));
            $('#lblBPT_SchA_10').text(ispFormatMoney(0, 0));
            
            $('#lblBPT_SchA_11').text(ispFormatMoney(0, 0));
            $('#lblBPT_SchA_12').text(ispFormatMoney(0, 0));


            $('#msgBPT_SchA_13').text($('#msgBPT_SchA_13').text().replace('###', dBPTNetRate));
        }		//ResetBPTlfSchdA

        function FieldLockBPTlfSchdA(bDisabled) {
            $('#txtBPT_SchA_1').attr('disabled', bDisabled);
            $('#txtBPT_SchA_2').attr('disabled', bDisabled);
            $('#txtBPT_SchA_3').attr('disabled', bDisabled);
            $('#txtBPT_SchA_4').attr('disabled', bDisabled);
            $('#lblBPT_SchA_5').attr('disabled', bDisabled);
            $('#lblBPT_SchA_6').attr('disabled', bDisabled);
            $('#lblBPT_SchA_7').attr('disabled', bDisabled);
            $('#txtBPT_SchA_8').attr('disabled', bDisabled);
            $('#lblBPT_SchA_9').attr('disabled', bDisabled);
            //EGOVWEB-131 EHD 03/25/2013 Loss Carry Forward field is always locked
            $('#lblBPT_SchA_10').attr('disabled', bDisabled);
            
            $('#lblBPT_SchA_11').attr('disabled', bDisabled);
            $('#lblBPT_SchA_12').attr('disabled', bDisabled);
        }		//FieldLockBPTlfSchdA

        function PerformCalcsBPTlfSchdA() {
            var txtBPT_SchA_1 = document.getElementById('txtBPT_SchA_1');
            var txtBPT_SchA_2 = document.getElementById('txtBPT_SchA_2');
            var txtBPT_SchA_3 = document.getElementById('txtBPT_SchA_3');
            var txtBPT_SchA_4 = document.getElementById('txtBPT_SchA_4');
            var lblBPT_SchA_5 = document.getElementById('lblBPT_SchA_5');
            var lblBPT_SchA_6 = document.getElementById('lblBPT_SchA_6');
            var lblBPT_SchA_7 = document.getElementById('lblBPT_SchA_7');
            var txtBPT_SchA_8 = document.getElementById('txtBPT_SchA_8');
            var lblBPT_SchA_9 = document.getElementById('lblBPT_SchA_9');
            var lblBPT_SchA_10 = document.getElementById('lblBPT_SchA_10');
            var txtBPT_SchA_11 = document.getElementById('txtBPT_SchA_11');
            var lblBPT_SchA_12 = document.getElementById('lblBPT_SchA_12');
            var lblBPT_SchA_13 = document.getElementById('lblBPT_SchA_13');
            var txtBPT_SchB_1 = document.getElementById('txtBPT_SchB_1');

            if (getActiveElement().id == $('#txtBPT_SchA_1') && PrepForMath($('#txtBPT_SchB_1').val()) != 0) {
                ResetBPTlfSchdB();
            }		//if
            if ($(parent.AppError).text() == "") {
                CalcBPTlfSchdALine5();
                CalcBPTlfSchdALine7();
                CalcBPTlfSchdALine9();

                CalcBPTlfSchdALine11();
            }		//if
        }		//PerformCalcsBPTlfSchdA

        function CalcBPTlfSchdALine5() {

             
            if ($('#txtBPT_SchA_1').val() != '' && $('#txtBPT_SchA_2').val() != '' &&
                    $('#txtBPT_SchA_3').val() != '' && $('#txtBPT_SchA_4').val() != '') {
                $('#lblBPT_SchA_5').text(ispFormatMoney(PrepForMath($('#txtBPT_SchA_1').val()) -
                        (PrepForMath($('#txtBPT_SchA_2').val()) + PrepForMath($('#txtBPT_SchA_3').val()) + PrepForMath($('#txtBPT_SchA_4').val())), 0));
            } 	//if

            if ($('#lblBPT_SchA_5').text() != '' && $('#lblBPT_SchA_6').text() != '') {
                if (PrepForMath($('#lblBPT_SchC1_12').text()) == 1 && $('#BPT_SchdA').css('display') == 'block') {
                    alert('Schedule C needs to be completed');
                } 	//if
                $('#lblBPT_SchA_6').text(parseFloat($('#lblBPT_SchC1_12').text()).toFixed(6));
            } 	//if
        } 	//CalcBPTlfSchdALine5

        function CalcBPTlfSchdALine7() {
            if ($('#lblBPT_SchA_5').text() != '' && $('#lblBPT_SchA_6').text() != '') {
                //chayan
                if ($('#lblBPT_SchA_6').text() != '' && PrepForMath($('#lblBPT_SchA_6').text()) == 0 &&
                        $('#BPT_SchdA').css('display') == 'block') {
                   
                }		//if
                $('#lblBPT_SchA_7').text(ispFormatMoney(PrepForMath($('#lblBPT_SchA_5').text()) *
                        PrepForMath($('#lblBPT_SchA_6').text()), 0));
            }		//if
        }		//CalcBPTlfSchdALine7

        function CalcBPTlfSchdALine9() {
            if ($('#lblBPT_SchA_7').text() != '' && $('#txtBPT_SchA_8').val() != '') {
                $('#lblBPT_SchA_9').text(ispFormatMoney(PrepForMath($('#lblBPT_SchA_7').text()) +
                        PrepForMath($('#txtBPT_SchA_8').val()), 0));
            }		//if
        }		//CalcBPTlfSchdALine9

        function CalcBPTlfSchdALine11() {
             
            if ($('#lblBPT_SchA_9').text() != '' && $('#lblBPT_SchA_10').text() != '') {
                $('#lblBPT_SchA_11').text(ispFormatMoney(PrepForMath($('#lblBPT_SchA_9').text()) -
                        PrepForMath($('#lblBPT_SchA_10').text()), 0));
                $('#lblBPT_SchA_12').text(ispFormatMoney(PrepForMath($('#lblBPT_SchA_11').text()) * dBPTNetRate, 0));
                if (PrepForMath($('#lblBPT_SchA_12').text()) < 0) {
                    $('#lblBPT_SchA_12').text(ispFormatMoney(0, 0));
                }		//if
            }		//if
        }		//CalcBPTlfSchdALine11

        function gotolcf_A() {
            Sch = 'A';
            $('#losscarryforward').css('display', 'block');
            $('#BPT_SchdA').css('display', 'none');
        }
    </script>
</head>


<body>
   <div id="BPT_SchdA" style="display: none;">
    <div class="col-lg-12 col-md-12">

                                <div class="row">
                                    <div class="table-responsive">

                                        <table class="table table-condensed table-striped custom_table03 wage-table-print">

                                            <thead>
                                                <tr>
                                                    <th colspan="3" width="100%" class="slim-headings"><u>2012 BIRT Schedule A: Computation of Tax On Net Income(Method I)</u></th>

                                                </tr>

                                            </thead>

                                            <tbody>

                                                <tr>
                                                    <td width="5%">1.</td>
                                                    <td width="70%" class="text-left">Net Income (Loss) per accounting system used plus income taxes
				deducted in arriving at Net Income, less total nonbusiness income</td>
                                                    <td width="25%" class="text-left">
                                                        <form class="form-horizontal">

                                                            <div class="form-group no-margin">
                                                                <div class="">
                                                                    <input class="form-control input-sm" id="txtBPT_SchA_1" type="text" style="width: 100%"
                                                                        onfocus="SetFocus()" onchange="ValidateWorksheet('BPT_SchdA')">
                                                                </div>
                                                            </div>

                                                        </form>
                                                    </td>
                                                </tr>

                                                <tr class="odd">
                                                    <td width="5%">2.</td>
                                                    <td width="70%" class="text-left">Net Income (Loss) from certain port related activities.</td>
                                                    <td width="25%" class="text-left">
                                                        <form class="form-horizontal">

                                                            <div class="form-group no-margin">
                                                                <div class="">
                                                                    <input class="form-control input-sm" id="txtBPT_SchA_2" type="text" style="width: 100%"
                                                                        onfocus="SetFocus()" onchange="ValidateWorksheet('BPT_SchdA')">
                                                                </div>
                                                            </div>

                                                        </form>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="5%">3.</td>
                                                    <td width="70%" class="text-left">Net Income (Loss) from specific PUC and ICC business activities. </td>

                                                    <td width="25%" class="text-left">
                                                        <form class="form-horizontal">

                                                            <div class="form-group no-margin">
                                                                <div class="">
                                                                    <input class="form-control input-sm" id="txtBPT_SchA_3" type="text" style="width: 100%"
                                                                        onfocus="SetFocus()" onchange="ValidateWorksheet('BPT_SchdA')">
                                                                </div>
                                                            </div>

                                                        </form>
                                                    </td>
                                                </tr>
                                                <tr class="odd">
                                                    <td width="5%">4.</td>
                                                    <td width="70%" class="text-left">Net Income (Loss) from Public Law 86-272 activities</td>
                                                    <td width="25%" class="text-left">
                                                        <form class="form-horizontal">

                                                            <div class="form-group no-margin">
                                                                <div class="">
                                                                    <input class="form-control input-sm" id="txtBPT_SchA_4" type="text" style="width: 100%"
                                                                        onfocus="SetFocus()" onchange="ValidateWorksheet('BPT_SchdA')">
                                                                </div>
                                                        </form>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="5%">5.</td>
                                                    <td width="70%" class="text-left">Income (Loss) to be apportioned [Calculated - Line 1 minus 2, 3, and 4]</td>
                                                    <td width="25%" class="text-left">
                                                        <form class="form-horizontal">

                                                            <div class="form-group no-margin">
                                                                <div class="">
                                                                    <label id="lblBPT_SchA_5" class="form-control input-sm"></label>
                                                                </div>
                                                            </div>

                                                        </form>
                                                    </td>
                                                </tr>

                                                <tr class="odd">
                                                    <td width="5%">6.</td>
                                                    <td width="70%" class="text-left">Average of Apportionment Factors (from
                                                <label id="lnkSchC1" class="lblLink" style="width: 100%"
                                                    onclick="ShowPage('SchdC1')">
                                                    Click here for Schedule C-1, Line 12</label>)</td>
                                                    <td width="25%" class="text-left">
                                                        <form class="form-horizontal">

                                                            <div class="form-group no-margin">
                                                                <div class="">
                                                                    <label id="lblBPT_SchA_6" class="form-control input-sm"></label>
                                                                </div>
                                                            </div>

                                                        </form>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="5%">7.</td>
                                                    <td width="70%" class="text-left">Income (Loss) apportioned to Philadelphia[Calculated - Multiply Line 5 by Line 6] </td>
                                                    <td width="25%" class="text-left">
                                                        <form class="form-horizontal">

                                                            <div class="form-group no-margin">
                                                                <div class="">

                                                                    <label id="lblBPT_SchA_7" class="form-control input-sm"></label>
                                                                </div>
                                                            </div>

                                                        </form>
                                                    </td>
                                                </tr>
                                                <tr class="odd">
                                                    <td width="5%">8.</td>
                                                    <td width="70%" class="text-left">Nonbusiness Income (Loss) allocated to Philadelphia</td>
                                                    <td width="25%" class="text-left">
                                                        <form class="form-horizontal">

                                                            <div class="form-group no-margin">
                                                                <div class="">

                                                                    <input class="form-control input-sm" id="txtBPT_SchA_8" type="text" style="width: 100%"
                                                                        onfocus="SetFocus()" maxlength="10" onchange="ValidateWorksheet('BPT_SchdA')">
                                                                </div>
                                                            </div>

                                                        </form>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="5%">9.</td>
                                                    <td width="70%" class="text-left">Current year Income (Loss)[Calculated - Line 7 plus Line 8]</td>
                                                    <td width="25%" class="text-left">
                                                        <form class="form-horizontal">

                                                            <div class="form-group no-margin">
                                                                <div class="">
                                                                    <label id="lblBPT_SchA_9" class="form-control input-sm"></label>
                                                                </div>
                                                            </div>

                                                        </form>

                                                    </td>
                                                </tr>

                                                
                                                <tr>
                                                    <td width="5%">10.</td>
                                                    <td width="70%" class="text-left">Loss Carry Forward, if any (<u><font>see LCF on side menu bar</font></u>)</td>
                                                    <td width="25%" class="text-left">
                                                        <form class="form-horizontal">

                                                            <div class="form-group no-margin">
                                                                <div class="">
                                                                    <%--<input class="form-control input-sm" id="lblBPT_SchA_10" type="text" style="width: 100%" onfocus="SetFocus()" maxlength="10" onchange="ValidateWorksheet('BPT_SchdA')">--%>
                                                                    <label id="lblBPT_SchA_10" class="form-control input-sm pull-right"></label>
                                                                </div>
                                                            </div>

                                                        </form>
                                                    </td>
                                                </tr>
                                                <tr class="odd">
                                                    <td width="5%">11.</td>
                                                    <td width="70%" class="text-left">Taxable Income (Loss)[Calculated -Line 9 minus Line 10].</td>
                                                    <td width="25%" class="text-left">
                                                        <form class="form-horizontal">

                                                            <div class="form-group no-margin">
                                                                <div class="">
                                                                    <label id="lblBPT_SchA_11" class="form-control input-sm"></label>
                                                                </div>
                                                            </div>

                                                        </form>
                                                    </td>
                                                </tr>
                                                 <tr>
                                        <td width="5%">12.</td>
                                        <td width="70%" class="text-left">
                                            <label id="msgBPT_SchA_13" class=""><b>TAX DUE</b> (Multiply Line 11 by  ###) If Line 11 is a loss, enter zero</label></td>
                                        <td width="25%" class="text-left">
                                            <form class="form-horizontal">

                                                <div class="form-group no-margin">
                                                    <div class="">
                                                        <label id="lblBPT_SchA_12" class="form-control input-sm pull-right"></label>
                                                    </div>
                                                </div>

                                            </form>

                                        </td>
                                    </tr>

                                                <tr class="odd">
                                                    <td width="5%"></td>
                                                    <td width="70%" class="text-left"></td>
                                                    <td width="25%" class="text-left">
                                                        <form class="form-horizontal">

                                                            <div class="form-group no-margin">
                                                                <div class="">
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
         <div class="lets-split"></div>         
</body>
</html>
