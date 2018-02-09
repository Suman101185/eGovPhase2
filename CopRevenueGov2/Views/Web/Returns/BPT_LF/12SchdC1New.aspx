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
    <!-- WARNING: Respond.js doesn't work if you view the page via file -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script language='javascript' type="text/javascript">
        //EGOVWEB-72 - Change MaxLength from 10 to 13 on textboxes for currency fields
        var arrSchdC1Err = new Array();
        var xSecScTblC1 = 'BPT_TBL_C1 ';
        var xFldScC1TbLi1CoA = xSecScTblC1 + 'INVENTORIES_PHILA';
        var xFldScC1TbLi1CoB = xSecScTblC1 + 'INVENTORIES_ALL';
        var xFldScC1TbLi2CoA = xSecScTblC1 + 'LAND_BLDGS_PHILA';
        var xFldScC1TbLi2CoB = xSecScTblC1 + 'LAND_BLDGS_ALL';
        var xFldScC1TbLi3CoA = xSecScTblC1 + 'MACHINERY_PHILA';
        var xFldScC1TbLi3CoB = xSecScTblC1 + 'MACHINERY_ALL';
        var xFldScC1TbLi4CoA = xSecScTblC1 + 'OTHER_ASSESTS_PHILA';
        var xFldScC1TbLi4CoB = xSecScTblC1 + 'OTHER_ASSESTS_ALL';
        var xFldScC1TbLi5CoA = xSecScTblC1 + 'RENTED_PROPERTY_PHILA';
        var xFldScC1TbLi5CoB = xSecScTblC1 + 'RENTED_PROPERTY_ALL';
        var xFldScC1TbLi6CoA = xSecScTblC1 + 'TOTAL_AVG_PHILA';
        var xFldScC1TbLi7CoB = xSecScTblC1 + 'TOTAL_AVG_ALL';

        var xSecScC1 = 'BPT_SCH_C1 ';
        var xFldScCLi8a = xSecScC1 + 'TOTAL_AVG_PHILA';
        var xFldScCLi8b = xSecScC1 + 'TOTAL_AVG_ALL';
        var xFldScCLi8c = xSecScC1 + 'PROPERTY_FACTOR_PHILA';
        var xFldScCLi9a = xSecScC1 + 'PAYROLL_PHILA';
        var xFldScCLi9b = xSecScC1 + 'PAYROLL_ALL';
        var xFldScCLi9c = xSecScC1 + 'PAYROLL_FACTOR_PHILA';
        var xFldScCLi10a = xSecScC1 + 'RECEIPTS_PHILA';
        var xFldScCLi10b = xSecScC1 + 'RECEIPTS_ALL';
        var xFldScCLi10c = xSecScC1 + 'RECEIPTS_FACTOR_PHILA';
        var xFldScCLi11 = xSecScC1 + 'TOTAL_FACTORS';
        var xFldScCLi12 = xSecScC1 + 'AVERAGE_FACTORS';

       
        function LoadErrorBPTlfSchdC1() {

            var txtBPT_SchC1_1A = document.getElementById('txtBPT_SchC1_1A');
            var txtBPT_SchC1_1B = document.getElementById('txtBPT_SchC1_1B');
            var txtBPT_SchC1_2A = document.getElementById('txtBPT_SchC1_2A');
            var txtBPT_SchC1_2B = document.getElementById('txtBPT_SchC1_2B');
            var txtBPT_SchC1_3A = document.getElementById('txtBPT_SchC1_3A');
            var txtBPT_SchC1_3B = document.getElementById('txtBPT_SchC1_3B');
            var txtBPT_SchC1_4A = document.getElementById('txtBPT_SchC1_4A');
            var txtBPT_SchC1_4B = document.getElementById('txtBPT_SchC1_4B');
            var txtBPT_SchC1_5A = document.getElementById('txtBPT_SchC1_5A');
            var txtBPT_SchC1_5B = document.getElementById('txtBPT_SchC1_5B');
            var lblBPT_SchC1_6A = document.getElementById('lblBPT_SchC1_6A');
            var lblBPT_SchC1_7B = document.getElementById('lblBPT_SchC1_7B');
            var lblBPT_SchC1_8A = document.getElementById('lblBPT_SchC1_8A');
            var lblBPT_SchC1_8B = document.getElementById('lblBPT_SchC1_8B');
            var lblBPT_SchC1_8C = document.getElementById('lblBPT_SchC1_8C');
            var txtBPT_SchC1_9A = document.getElementById('txtBPT_SchC1_9A');
            var txtBPT_SchC1_9B = document.getElementById('txtBPT_SchC1_9B');
            var lblBPT_SchC1_9C = document.getElementById('lblBPT_SchC1_9C');
            var txtBPT_SchC1_10A = document.getElementById('txtBPT_SchC1_10A');
            var txtBPT_SchC1_10B = document.getElementById('txtBPT_SchC1_10B');
            var lblBPT_SchC1_10c = document.getElementById('lblBPT_SchC1_10C');
            var lblBPT_SchC1_10D = document.getElementById('lblBPT_SchC1_10D');
            var lblBPT_SchC1_11 = document.getElementById('lblBPT_SchC1_11');
            var lblBPT_SchC1_12 = document.getElementById('lblBPT_SchC1_12');


            var i = 0;
            arrSchdC1Err[i++] = [txtBPT_SchC1_1A, '$(\'#txtBPT_SchC1_1A\').val() == ""', 'Answer Question 1, Column A'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_1A, 'ispValue($(\'#txtBPT_SchC1_1A\').val()) == false', 'Value for Question 1, Column A must be numeric'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_1A, 'ispNegativeNumber($(\'#txtBPT_SchC1_1A\').val()) == false', 'Value for Question 1, Column A must NOT be negative'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_1B, '$(\'#txtBPT_SchC1_1B\').val() == ""', 'Answer Question 1, Column B'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_1B, 'ispValue($(\'#txtBPT_SchC1_1B\').val()) == false', 'Value for Question 1, Column B must be numeric'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_1B, 'ispNegativeNumber($(\'#txtBPT_SchC1_1B\').val()) == false', 'Value for Question 1, Column B must NOT be negative'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_1B, 'PrepForMath($(\'#txtBPT_SchC1_1B\').val()) < PrepForMath($(\'#txtBPT_SchC1_1A\').val()) == true', 'Value for Question 1b must be equal to or greater than Question 1a'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_2A, '$(\'#txtBPT_SchC1_2A\').val() == ""', 'Answer Question 2, Column A'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_2A, 'ispValue($(\'#txtBPT_SchC1_2A\').val()) == false', 'Value for Question 2, Column A must be numeric'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_2A, 'ispNegativeNumber($(\'#txtBPT_SchC1_2A\').val()) == false', 'Value for Question 2, Column A must NOT be negative'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_2B, '$(\'#txtBPT_SchC1_2B\').val() == ""', 'Answer Question 2, Column B'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_2B, 'ispValue($(\'#txtBPT_SchC1_2B\').val()) == false', 'Value for Question 2, Column B must be numeric'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_2B, 'ispNegativeNumber($(\'#txtBPT_SchC1_2B\').val()) == false', 'Value for Question 2, Column B must NOT be negative'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_2B, 'PrepForMath($(\'#txtBPT_SchC1_2B\').val()) < PrepForMath($(\'#txtBPT_SchC1_2A\').val()) == true', 'Value for Question 2b must be equal to or greater than Question 2a'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_3A, '$(\'#txtBPT_SchC1_3A\').val() == ""', 'Answer Question 3, Column A'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_3A, 'ispValue($(\'#txtBPT_SchC1_3A\').val()) == false', 'Value for Question 3, Column A must be numeric'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_3A, 'ispNegativeNumber($(\'#txtBPT_SchC1_3A\').val()) == false', 'Value for Question 3, Column A must NOT be negative'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_3B, '$(\'#txtBPT_SchC1_3B\').val() == ""', 'Answer Question 3, Column B'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_3B, 'ispValue($(\'#txtBPT_SchC1_3B\').val()) == false', 'Value for Question 3, Column B must be numeric'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_3B, 'ispNegativeNumber($(\'#txtBPT_SchC1_3B\').val()) == false', 'Value for Question 3, Column B must NOT be negative'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_3B, 'PrepForMath($(\'#txtBPT_SchC1_3B\').val()) < PrepForMath($(\'#txtBPT_SchC1_3A\').val()) == true', 'Value for Question 3b must be equal to or greater than Question 3a'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_4A, '$(\'#txtBPT_SchC1_4A\').val() == ""', 'Answer Question 4, Column A'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_4A, 'ispValue($(\'#txtBPT_SchC1_4A\').val()) == false', 'Value for Question 4, Column A must be numeric'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_4A, 'ispNegativeNumber($(\'#txtBPT_SchC1_4A\').val()) == false', 'Value for Question 4, Column A must NOT be negative'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_4B, '$(\'#txtBPT_SchC1_4B\').val() == ""', 'Answer Question 4, Column B'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_4B, 'ispValue($(\'#txtBPT_SchC1_4B\').val()) == false', 'Value for Question 4, Column B must be numeric'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_4B, 'ispNegativeNumber($(\'#txtBPT_SchC1_4B\').val()) == false', 'Value for Question 4, Column B must NOT be negative'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_4B, 'PrepForMath($(\'#txtBPT_SchC1_4B\').val()) < PrepForMath($(\'#txtBPT_SchC1_4A\').val()) == true', 'Value for Question 4b must be equal to or greater than Question 4a'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_5A, '$(\'#txtBPT_SchC1_5A\').val() == ""', 'Answer Question 5, Column A'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_5A, 'ispValue($(\'#txtBPT_SchC1_5A\').val()) == false', 'Value for Question 5, Column A must be numeric'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_5A, 'ispNegativeNumber($(\'#txtBPT_SchC1_5A\').val()) == false', 'Value for Question 5, Column A must NOT be negative'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_5B, '$(\'#txtBPT_SchC1_5B\').val() == ""', 'Answer Question 5, Column B'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_5B, 'ispValue($(\'#txtBPT_SchC1_5B\').val()) == false', 'Value for Question 5, Column B must be numeric'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_5B, 'ispNegativeNumber($(\'#txtBPT_SchC1_5B\').val()) == false', 'Value for Question 5, Column B must NOT be negative'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_5B, 'PrepForMath($(\'#txtBPT_SchC1_5B\').val()) < PrepForMath($(\'#txtBPT_SchC1_5A\').val()) == true', 'Value for Question 5b must be equal to or greater than Question 5a'];
            arrSchdC1Err[i++] = [lblBPT_SchC1_8B, 'PrepForMath($(\'lblBPT_SchC1_8B\').text()) < PrepForMath($(\'lblBPT_SchC1_8A\').text()) == true', 'Value 8b must be equal to or greater than the value of 8a'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_9A, '$(\'#txtBPT_SchC1_9A\').val() == ""', 'Answer Question 9a'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_9A, 'ispValue($(\'#txtBPT_SchC1_9A\').val()) == false', 'Value for Question 9a must be numeric'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_9A, 'ispNegativeNumber($(\'#txtBPT_SchC1_9A\').val()) == false', 'Value for Question 9a must NOT be negative'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_9B, '$(\'#txtBPT_SchC1_9B\').val() == ""', 'Answer Question 9b'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_9B, 'ispValue($(\'#txtBPT_SchC1_9B\').val()) == false', 'Value for Question 9b must be numeric'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_9B, 'ispNegativeNumber($(\'#txtBPT_SchC1_9B\').val()) == false', 'Value for Question 9b must NOT be negative'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_9B, 'PrepForMath($(\'#txtBPT_SchC1_9B\').val()) < PrepForMath($(\'#txtBPT_SchC1_9A\').val()) == true', 'Value for Question 9b must be equal to or greater than Question 9a'];

            arrSchdC1Err[i++] = [txtBPT_SchC1_10A, '$(\'#txtBPT_SchC1_10A\').val() == ""', 'Answer Question 10a'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_10A, 'ispValue($(\'#txtBPT_SchC1_10A\').val()) == false', 'Value for Question 10a must be numeric'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_10A, 'ispNegativeNumber($(\'#txtBPT_SchC1_10A\').val()) == false', 'Value for Question 10a must NOT be negative'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_10B, '$(\'#txtBPT_SchC1_10B\').val() == ""', 'Answer Question 10b'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_10B, 'ispValue($(\'#txtBPT_SchC1_10B\').val()) == false', 'Value for Question 10b must be numeric'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_10B, 'ispNegativeNumber($(\'#txtBPT_SchC1_10B\').val()) == false', 'Value for Question 10b must NOT be negative'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_10B, 'PrepForMath($(\'#txtBPT_SchC1_10B\').val()) < PrepForMath($(\'#txtBPT_SchC1_10A\').val()) == true', 'Value for Question 10b must be equal to or greater than Question 10a'];
        }		//LoadErrorBPTlfSchdC1

        function ClearBPTlfSchdC1() {
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScC1TbLi1CoA, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScC1TbLi1CoB, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScC1TbLi2CoA, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScC1TbLi2CoB, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScC1TbLi3CoA, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScC1TbLi3CoB, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScC1TbLi4CoA, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScC1TbLi4CoB, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScC1TbLi5CoA, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScC1TbLi5CoB, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScC1TbLi6CoA, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScC1TbLi7CoB, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScCLi8a, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScCLi8b, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScCLi8c, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScCLi9a, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScCLi9b, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScCLi9c, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScCLi10a, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScCLi10b, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScCLi10c, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScCLi11, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScCLi12, '', 0);
        }		//ClearBPTlfSchdC1

        function PopulateXmlBPTlfSchdC1() {

            var txtBPT_SchC1_1A = document.getElementById('txtBPT_SchC1_1A');
            var txtBPT_SchC1_1B = document.getElementById('txtBPT_SchC1_1B');
            var txtBPT_SchC1_2A = document.getElementById('txtBPT_SchC1_2A');
            var txtBPT_SchC1_2B = document.getElementById('txtBPT_SchC1_2B');
            var txtBPT_SchC1_3A = document.getElementById('txtBPT_SchC1_3A');
            var txtBPT_SchC1_3B = document.getElementById('txtBPT_SchC1_3B');
            var txtBPT_SchC1_4A = document.getElementById('txtBPT_SchC1_4A');
            var txtBPT_SchC1_4B = document.getElementById('txtBPT_SchC1_4B');
            var txtBPT_SchC1_5A = document.getElementById('txtBPT_SchC1_5A');
            var txtBPT_SchC1_5B = document.getElementById('txtBPT_SchC1_5B');
            var lblBPT_SchC1_6A = document.getElementById('lblBPT_SchC1_6A');
            var lblBPT_SchC1_7B = document.getElementById('lblBPT_SchC1_7B');
            var lblBPT_SchC1_8A = document.getElementById('lblBPT_SchC1_8A');
            var lblBPT_SchC1_8B = document.getElementById('lblBPT_SchC1_8B');
            var lblBPT_SchC1_8C = document.getElementById('lblBPT_SchC1_8C');
            var txtBPT_SchC1_9A = document.getElementById('txtBPT_SchC1_9A');
            var txtBPT_SchC1_9B = document.getElementById('txtBPT_SchC1_9B');
            var lblBPT_SchC1_9C = document.getElementById('lblBPT_SchC1_9C');
            var txtBPT_SchC1_10A = document.getElementById('txtBPT_SchC1_10A');
            var txtBPT_SchC1_10B = document.getElementById('txtBPT_SchC1_10B');
            var lblBPT_SchC1_10c = document.getElementById('lblBPT_SchC1_10C');
            var lblBPT_SchC1_10D = document.getElementById('lblBPT_SchC1_10D');
            var lblBPT_SchC1_11 = document.getElementById('lblBPT_SchC1_11');
            var lblBPT_SchC1_12 = document.getElementById('lblBPT_SchC1_12');

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchC1_1A.value), xFldScC1TbLi1CoA, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchC1_1B.value), xFldScC1TbLi1CoB, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchC1_2A.value), xFldScC1TbLi2CoA, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchC1_2B.value), xFldScC1TbLi2CoB, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchC1_3A.value), xFldScC1TbLi3CoA, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchC1_3B.value), xFldScC1TbLi3CoB, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchC1_4A.value), xFldScC1TbLi4CoA, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchC1_4B.value), xFldScC1TbLi4CoB, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchC1_5A.value), xFldScC1TbLi5CoA, '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchC1_5B.value), xFldScC1TbLi5CoB, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchC1_6A').text()), xFldScCLi8a, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchC1_7B').text()), xFldScCLi8b, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchC1_8A').text()), xFldScCLi8a, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchC1_8B').text()), xFldScCLi8b, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, $('#lblBPT_SchC1_8C').text(), xFldScCLi8c, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchC1_9A.value), xFldScCLi9a, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchC1_9B.value), xFldScCLi9b, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, $('#lblBPT_SchC1_9C').text(), xFldScCLi9c, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchC1_10A.value), xFldScCLi10a, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchC1_10B.value), xFldScCLi10b, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, $('#lblBPT_SchC1_10C').text(), xFldScCLi10c, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, $('#lblBPT_SchC1_11').text(), xFldScCLi11, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, $('#lblBPT_SchC1_12').text(), xFldScCLi12, '', 0);
        }		//PopulateXmlBPTlfSchdC1
          function RightAlignText_C1() {//Added 
            $('#txtBPT_SchC1_1A').css('text-align', 'right');
            $('#txtBPT_SchC1_1B').css('text-align', 'right');
            $('#txtBPT_SchC1_2A').css('text-align', 'right');
            $('#txtBPT_SchC1_2B').css('text-align', 'right');
            $('#txtBPT_SchC1_3A').css('text-align', 'right');
            $('#txtBPT_SchC1_3B').css('text-align', 'right');
            $('#txtBPT_SchC1_4A').css('text-align', 'right');
            $('#txtBPT_SchC1_4B').css('text-align', 'right');
            $('#txtBPT_SchC1_5A').css('text-align', 'right');
            $('#txtBPT_SchC1_5B').css('text-align', 'right');
            $('#txtBPT_SchC1_9A').css('text-align', 'right');
            $('#txtBPT_SchC1_9B').css('text-align', 'right');
            $('#txtBPT_SchC1_10A').css('text-align', 'right');
            $('#txtBPT_SchC1_10B').css('text-align', 'right');


            $('#lblBPT_SchC1_6A').parent().css("text-align", "right");
            $('#lblBPT_SchC1_7B').parent().css("text-align", "right");
            $('#lblBPT_SchC1_8A').parent().css("text-align", "right");
            $('#lblBPT_SchC1_8B').parent().css("text-align", "right");
            $('#lblBPT_SchC1_8C').parent().css("text-align", "right");
            $('#lblBPT_SchC1_9C').parent().css("text-align", "right");
            $('#lblBPT_SchC1_10C').parent().css("text-align", "right");
            $('#lblBPT_SchC1_10D').parent().css("text-align", "right");
            $('#lblBPT_SchC1_11').parent().css("text-align", "right");
            $('#lblBPT_SchC1_12').parent().css("text-align", "right");
        }
        function PopulateBPTlfSchdC1() {

            var txtBPT_SchC1_1A = document.getElementById('txtBPT_SchC1_1A');
            var txtBPT_SchC1_1B = document.getElementById('txtBPT_SchC1_1B');
            var txtBPT_SchC1_2A = document.getElementById('txtBPT_SchC1_2A');
            var txtBPT_SchC1_2B = document.getElementById('txtBPT_SchC1_2B');
            var txtBPT_SchC1_3A = document.getElementById('txtBPT_SchC1_3A');
            var txtBPT_SchC1_3B = document.getElementById('txtBPT_SchC1_3B');
            var txtBPT_SchC1_4A = document.getElementById('txtBPT_SchC1_4A');
            var txtBPT_SchC1_4B = document.getElementById('txtBPT_SchC1_4B');
            var txtBPT_SchC1_5A = document.getElementById('txtBPT_SchC1_5A');
            var txtBPT_SchC1_5B = document.getElementById('txtBPT_SchC1_5B');
            var lblBPT_SchC1_6A = document.getElementById('lblBPT_SchC1_6A');
            var lblBPT_SchC1_7B = document.getElementById('lblBPT_SchC1_7B');
            var lblBPT_SchC1_8A = document.getElementById('lblBPT_SchC1_8A');
            var lblBPT_SchC1_8B = document.getElementById('lblBPT_SchC1_8B');
            var lblBPT_SchC1_8C = document.getElementById('lblBPT_SchC1_8C');
            var txtBPT_SchC1_9A = document.getElementById('txtBPT_SchC1_9A');
            var txtBPT_SchC1_9B = document.getElementById('txtBPT_SchC1_9B');
            var lblBPT_SchC1_9C = document.getElementById('lblBPT_SchC1_9C');
            var txtBPT_SchC1_10A = document.getElementById('txtBPT_SchC1_10A');
            var txtBPT_SchC1_10B = document.getElementById('txtBPT_SchC1_10B');
            var lblBPT_SchC1_10c = document.getElementById('lblBPT_SchC1_10C');
            var lblBPT_SchC1_10D = document.getElementById('lblBPT_SchC1_10D');
            var lblBPT_SchC1_11 = document.getElementById('lblBPT_SchC1_11');
            var lblBPT_SchC1_12 = document.getElementById('lblBPT_SchC1_12');

            txtBPT_SchC1_1A.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScC1TbLi1CoA, '', 0), 0);
            txtBPT_SchC1_1B.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScC1TbLi1CoB, '', 0), 0);
            txtBPT_SchC1_2A.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScC1TbLi2CoA, '', 0), 0);
            txtBPT_SchC1_2B.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScC1TbLi2CoB, '', 0), 0);
            txtBPT_SchC1_3A.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScC1TbLi3CoA, '', 0), 0);
            txtBPT_SchC1_3B.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScC1TbLi3CoB, '', 0), 0);
            txtBPT_SchC1_4A.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScC1TbLi4CoA, '', 0), 0);
            txtBPT_SchC1_4B.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScC1TbLi4CoB, '', 0), 0);
            txtBPT_SchC1_5A.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScC1TbLi5CoA, '', 0), 0);
            txtBPT_SchC1_5B.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScC1TbLi5CoB, '', 0), 0);
            $('#lblBPT_SchC1_6A').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScCLi8a, '', 0), 0));
            $('#lblBPT_SchC1_7B').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScCLi8b, '', 0), 0));
            $('#lblBPT_SchC1_8A').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScCLi8a, '', 0), 0));
            $('#lblBPT_SchC1_8B').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScCLi8b, '', 0), 0));
            $('#lblBPT_SchC1_8C').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScCLi8c, '', 0));
            txtBPT_SchC1_9A.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScCLi9a, '', 0), 0);
            txtBPT_SchC1_9B.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScCLi9b, '', 0), 0);
            $('#lblBPT_SchC1_9C').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScCLi9c, '', 0));
            txtBPT_SchC1_10A.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScCLi10a, '', 0), 0);
            txtBPT_SchC1_10B.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScCLi10b, '', 0), 0);
            $('#lblBPT_SchC1_10C').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScCLi10c, '', 0));
            $('#lblBPT_SchC1_10D').text($('#lblBPT_SchC1_10C').text());
            $('#lblBPT_SchC1_11').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScCLi11, '', 0));
            //EGOVWEB-63
            if (PrepForMath($('#lblBPT_SchC1_11').text()) == 0) {
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScCLi12, '', 0);
            }		//if
            $('#lblBPT_SchC1_12').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScCLi12, '', 0));

            if ($('#lblBPT_SchC1_8C').text() == '') {
                $('#lblBPT_SchC1_8C').text(parseFloat(0).toFixed(6));
            }
            else {
                $('#lblBPT_SchC1_8C').text(parseFloat($('#lblBPT_SchC1_8C').text()).toFixed(6));
            }
            if ($('#lblBPT_SchC1_9C').text() == '') { $('#lblBPT_SchC1_9C').text(parseFloat(0).toFixed(6)); }
            else { $('#lblBPT_SchC1_9C').text(parseFloat($('#lblBPT_SchC1_9C').text()).toFixed(6)); }
            if ($('#lblBPT_SchC1_10C').text() == '') { $('#lblBPT_SchC1_10C').text(parseFloat(0).toFixed(6)); }
            else { $('#lblBPT_SchC1_10C').text(parseFloat($('#lblBPT_SchC1_10C').text()).toFixed(6)); }
            if ($('#lblBPT_SchC1_10D').text() == '') { $('#lblBPT_SchC1_10D').text(parseFloat(0).toFixed(6)); }
            else { $('#lblBPT_SchC1_10D').text(parseFloat($('#lblBPT_SchC1_10D').text()).toFixed(6)); }
            if ($('#lblBPT_SchC1_11').text() == '') { $('#lblBPT_SchC1_11').text(parseFloat(0).toFixed(6)); }
            else { $('#lblBPT_SchC1_11').text(parseFloat($('#lblBPT_SchC1_11').text()).toFixed(6)); }
            if ($('#lblBPT_SchC1_12').text() == '') { $('#lblBPT_SchC1_12').text(parseFloat(0).toFixed(6)); }
            else { $('#lblBPT_SchC1_12').text(parseFloat($('#lblBPT_SchC1_12').text()).toFixed(6)); }
        }		//PopulateBPTlfSchdC1

        function FieldLockBPTlfSchdC1(bDisabled) {
            $('#txtBPT_SchC1_1A').attr('disabled', bDisabled);
            $('#txtBPT_SchC1_1B').attr('disabled', bDisabled);//.disabled = bDisabled;
            $('#txtBPT_SchC1_2A').attr('disabled', bDisabled);//.disabled = bDisabled
            $('#txtBPT_SchC1_2B').attr('disabled', bDisabled);//.disabled = bDisabled
            $('#txtBPT_SchC1_3A').attr('disabled', bDisabled);//.disabled = bDisabled
            $('#txtBPT_SchC1_3B').attr('disabled', bDisabled);//.disabled = bDisabled
            $('#txtBPT_SchC1_4A').attr('disabled', bDisabled);//.disabled = bDisabled
            $('#txtBPT_SchC1_4B').attr('disabled', bDisabled);//.disabled = bDisabled
            $('#txtBPT_SchC1_5A').attr('disabled', bDisabled);//.disabled = bDisabled
            $('#txtBPT_SchC1_5B').attr('disabled', bDisabled);//.disabled = bDisabled
            $('#lblBPT_SchC1_6A').attr('disabled', bDisabled);//.disabled = bDisabled
            $('#lblBPT_SchC1_7B').attr('disabled', bDisabled);//.disabled = bDisabled
            $('#lblBPT_SchC1_8A').attr('disabled', bDisabled);//.disabled = bDisabled
            $('#lblBPT_SchC1_8B').attr('disabled', bDisabled);//.disabled = bDisabled
            $('#lblBPT_SchC1_8C').attr('disabled', bDisabled);//.disabled = bDisabled
            $('#txtBPT_SchC1_9A').attr('disabled', bDisabled);//.disabled = bDisabled
            $('#txtBPT_SchC1_9B').attr('disabled', bDisabled);//.disabled = bDisabled
            $('#lblBPT_SchC1_9C').attr('disabled', bDisabled);//.disabled = bDisabled
            $('#txtBPT_SchC1_10A').attr('disabled', bDisabled);//.disabled = bDisabled
            $('#txtBPT_SchC1_10B').attr('disabled', bDisabled);//.disabled = bDisabled
            $('#lblBPT_SchC1_10C').attr('disabled', bDisabled);//.disabled = bDisabled
            $('#lblBPT_SchC1_10D').attr('disabled', bDisabled);//.disabled = bDisabled
            $('#lblBPT_SchC1_11').attr('disabled', bDisabled);//.disabled = bDisabled
            $('#lblBPT_SchC1_12').attr('disabled', bDisabled);//.disabled = bDisabled
        }		//FieldLockBPTlfSchdC1

        function PerformCalcsBPTlfSchdC1() {

            var txtBPT_SchC1_1A = document.getElementById('txtBPT_SchC1_1A');
            var txtBPT_SchC1_1B = document.getElementById('txtBPT_SchC1_1B');
            var txtBPT_SchC1_2A = document.getElementById('txtBPT_SchC1_2A');
            var txtBPT_SchC1_2B = document.getElementById('txtBPT_SchC1_2B');
            var txtBPT_SchC1_3A = document.getElementById('txtBPT_SchC1_3A');
            var txtBPT_SchC1_3B = document.getElementById('txtBPT_SchC1_3B');
            var txtBPT_SchC1_4A = document.getElementById('txtBPT_SchC1_4A');
            var txtBPT_SchC1_4B = document.getElementById('txtBPT_SchC1_4B');
            var txtBPT_SchC1_5A = document.getElementById('txtBPT_SchC1_5A');
            var txtBPT_SchC1_5B = document.getElementById('txtBPT_SchC1_5B');
            var lblBPT_SchC1_6A = document.getElementById('lblBPT_SchC1_6A');
            var lblBPT_SchC1_7B = document.getElementById('lblBPT_SchC1_7B');
            var lblBPT_SchC1_8A = document.getElementById('lblBPT_SchC1_8A');
            var lblBPT_SchC1_8B = document.getElementById('lblBPT_SchC1_8B');
            var lblBPT_SchC1_8C = document.getElementById('lblBPT_SchC1_8C');
            var txtBPT_SchC1_9A = document.getElementById('txtBPT_SchC1_9A');
            var txtBPT_SchC1_9B = document.getElementById('txtBPT_SchC1_9B');
            var lblBPT_SchC1_9C = document.getElementById('lblBPT_SchC1_9C');
            var txtBPT_SchC1_10A = document.getElementById('txtBPT_SchC1_10A');
            var txtBPT_SchC1_10B = document.getElementById('txtBPT_SchC1_10B');
            var lblBPT_SchC1_10c = document.getElementById('lblBPT_SchC1_10C');
            var lblBPT_SchC1_10D = document.getElementById('lblBPT_SchC1_10D');
            var lblBPT_SchC1_11 = document.getElementById('lblBPT_SchC1_11');
            var lblBPT_SchC1_12 = document.getElementById('lblBPT_SchC1_12');

            CalcSchdC1Line7b();		//Calculate lines 6a and 7a
            CalcSchdC1Line8c();
            CalcSchdC1Line9c();
            CalcSchdC1Line10c();
            CalcSchdC1Line12();		//Calculate lines 11 and 12
        }		//PerformCalcsBPTlfSchdC1

        function CalcSchdC1Line7b() {
            var txtBPT_SchC1_1A = document.getElementById('txtBPT_SchC1_1A');
            var txtBPT_SchC1_1B = document.getElementById('txtBPT_SchC1_1B');
            var txtBPT_SchC1_2A = document.getElementById('txtBPT_SchC1_2A');
            var txtBPT_SchC1_2B = document.getElementById('txtBPT_SchC1_2B');
            var txtBPT_SchC1_3A = document.getElementById('txtBPT_SchC1_3A');
            var txtBPT_SchC1_3B = document.getElementById('txtBPT_SchC1_3B');
            var txtBPT_SchC1_4A = document.getElementById('txtBPT_SchC1_4A');
            var txtBPT_SchC1_4B = document.getElementById('txtBPT_SchC1_4B');
            var txtBPT_SchC1_5A = document.getElementById('txtBPT_SchC1_5A');
            var txtBPT_SchC1_5B = document.getElementById('txtBPT_SchC1_5B');
            var lblBPT_SchC1_6A = document.getElementById('lblBPT_SchC1_6A');
            var lblBPT_SchC1_7B = document.getElementById('lblBPT_SchC1_7B');
            var lblBPT_SchC1_8A = document.getElementById('lblBPT_SchC1_8A');
            var lblBPT_SchC1_8B = document.getElementById('lblBPT_SchC1_8B');
            var lblBPT_SchC1_8C = document.getElementById('lblBPT_SchC1_8C');
            var txtBPT_SchC1_9A = document.getElementById('txtBPT_SchC1_9A');
            var txtBPT_SchC1_9B = document.getElementById('txtBPT_SchC1_9B');
            var lblBPT_SchC1_9C = document.getElementById('lblBPT_SchC1_9C');
            var txtBPT_SchC1_10A = document.getElementById('txtBPT_SchC1_10A');
            var txtBPT_SchC1_10B = document.getElementById('txtBPT_SchC1_10B');
            var lblBPT_SchC1_10c = document.getElementById('lblBPT_SchC1_10C');
            var lblBPT_SchC1_10D = document.getElementById('lblBPT_SchC1_10D');
            var lblBPT_SchC1_11 = document.getElementById('lblBPT_SchC1_11');
            var lblBPT_SchC1_12 = document.getElementById('lblBPT_SchC1_12');

            //20100415 EHD - Removed the averaging for line 6A and 7B it is just a sum of the fields
            var temp = 0;
            //Column A
            if (txtBPT_SchC1_1A.value != '' && txtBPT_SchC1_2A.value != '' && txtBPT_SchC1_3A.value != '' &&
                    txtBPT_SchC1_4A.value != '' && txtBPT_SchC1_5A.value != '') {
                if (PrepForMath(txtBPT_SchC1_1A.value) > 0){temp = temp + 1}
                if (PrepForMath(txtBPT_SchC1_2A.value) > 0){temp = temp + 1}
                if (PrepForMath(txtBPT_SchC1_3A.value) > 0){temp = temp + 1}
                if (PrepForMath(txtBPT_SchC1_4A.value) > 0){temp = temp + 1}
                if (PrepForMath(txtBPT_SchC1_5A.value) > 0){temp = temp + 1}
                
                if (temp == 0) {
                    $('#lblBPT_SchC1_6A').html($('#lblBPT_SchC1_6A').html());
                }
                else
                {
                    var total_6a = PrepForMath(txtBPT_SchC1_1A.value) +
                                PrepForMath(txtBPT_SchC1_2A.value) + PrepForMath(txtBPT_SchC1_3A.value) +
                                PrepForMath(txtBPT_SchC1_4A.value) + PrepForMath(txtBPT_SchC1_5A.value);

                    $('#lblBPT_SchC1_6A').html(ispFormatMoney(total_6a, 0));
                }

                //		}		//if
            }		//if
            //Column B
            temp = 0;
            if (txtBPT_SchC1_1B.value != '' && txtBPT_SchC1_2B.value != '' && txtBPT_SchC1_3B.value != '' &&
                    txtBPT_SchC1_4B.value != '' && txtBPT_SchC1_5B.value != '') {
               
                if (PrepForMath(txtBPT_SchC1_1B.value) > 0){temp = temp + 1}
                if (PrepForMath(txtBPT_SchC1_2B.value) > 0){temp = temp + 1}
                if (PrepForMath(txtBPT_SchC1_3B.value) > 0){temp = temp + 1}
                if (PrepForMath(txtBPT_SchC1_4B.value) > 0){temp = temp + 1}
                if (PrepForMath(txtBPT_SchC1_5B.value) > 0){temp = temp + 1}
                if (temp == 0) {
                    $('#lblBPT_SchC1_7B').html($('#lblBPT_SchC1_7B').html());;
                }
                else
                {
                    var total_7b = PrepForMath(txtBPT_SchC1_1B.value) +
                                PrepForMath(txtBPT_SchC1_2B.value) + PrepForMath(txtBPT_SchC1_3B.value) +
                                PrepForMath(txtBPT_SchC1_4B.value) + PrepForMath(txtBPT_SchC1_5B.value);

                    $('#lblBPT_SchC1_7B').html(ispFormatMoney(total_7b, 0));
                }
                //		}		//if
            }		//if
        }		//CalcSchdC1Line7b

        function CalcSchdC1Line8c() {

            var txtBPT_SchC1_1A = document.getElementById('txtBPT_SchC1_1A');
            var txtBPT_SchC1_1B = document.getElementById('txtBPT_SchC1_1B');
            var txtBPT_SchC1_2A = document.getElementById('txtBPT_SchC1_2A');
            var txtBPT_SchC1_2B = document.getElementById('txtBPT_SchC1_2B');
            var txtBPT_SchC1_3A = document.getElementById('txtBPT_SchC1_3A');
            var txtBPT_SchC1_3B = document.getElementById('txtBPT_SchC1_3B');
            var txtBPT_SchC1_4A = document.getElementById('txtBPT_SchC1_4A');
            var txtBPT_SchC1_4B = document.getElementById('txtBPT_SchC1_4B');
            var txtBPT_SchC1_5A = document.getElementById('txtBPT_SchC1_5A');
            var txtBPT_SchC1_5B = document.getElementById('txtBPT_SchC1_5B');
            var lblBPT_SchC1_6A = document.getElementById('lblBPT_SchC1_6A');
            var lblBPT_SchC1_7B = document.getElementById('lblBPT_SchC1_7B');
            var lblBPT_SchC1_8A = document.getElementById('lblBPT_SchC1_8A');
            var lblBPT_SchC1_8B = document.getElementById('lblBPT_SchC1_8B');
            var lblBPT_SchC1_8C = document.getElementById('lblBPT_SchC1_8C');
            var txtBPT_SchC1_9A = document.getElementById('txtBPT_SchC1_9A');
            var txtBPT_SchC1_9B = document.getElementById('txtBPT_SchC1_9B');
            var lblBPT_SchC1_9C = document.getElementById('lblBPT_SchC1_9C');
            var txtBPT_SchC1_10A = document.getElementById('txtBPT_SchC1_10A');
            var txtBPT_SchC1_10B = document.getElementById('txtBPT_SchC1_10B');
            var lblBPT_SchC1_10c = document.getElementById('lblBPT_SchC1_10C');
            var lblBPT_SchC1_10D = document.getElementById('lblBPT_SchC1_10D');
            var lblBPT_SchC1_11 = document.getElementById('lblBPT_SchC1_11');
            var lblBPT_SchC1_12 = document.getElementById('lblBPT_SchC1_12');

            if ($('#lblBPT_SchC1_6A').text() != '' && $('#lblBPT_SchC1_7B').text() != '') {
                $('#lblBPT_SchC1_8A').text($('#lblBPT_SchC1_6A').text());
                $('#lblBPT_SchC1_8B').text($('#lblBPT_SchC1_7B').text());
                if (PrepForMath($('#lblBPT_SchC1_8A').text()) == 0 && PrepForMath($('#lblBPT_SchC1_8B').text()) == 0 || PrepForMath($('#lblBPT_SchC1_8B').text()) == 0) {
                    $('#lblBPT_SchC1_8C').text(parseFloat(0).toFixed(6));
                } else {
                    $('#lblBPT_SchC1_8C').text(parseFloat(PrepForMath($('#lblBPT_SchC1_8A').text()) /
                            PrepForMath($('#lblBPT_SchC1_8B').text())).toFixed(6));
                }		//if
            }		//if
        }		//CalcSchdC1Line8c

        function CalcSchdC1Line9c() {

            var txtBPT_SchC1_1A = document.getElementById('txtBPT_SchC1_1A');
            var txtBPT_SchC1_1B = document.getElementById('txtBPT_SchC1_1B');
            var txtBPT_SchC1_2A = document.getElementById('txtBPT_SchC1_2A');
            var txtBPT_SchC1_2B = document.getElementById('txtBPT_SchC1_2B');
            var txtBPT_SchC1_3A = document.getElementById('txtBPT_SchC1_3A');
            var txtBPT_SchC1_3B = document.getElementById('txtBPT_SchC1_3B');
            var txtBPT_SchC1_4A = document.getElementById('txtBPT_SchC1_4A');
            var txtBPT_SchC1_4B = document.getElementById('txtBPT_SchC1_4B');
            var txtBPT_SchC1_5A = document.getElementById('txtBPT_SchC1_5A');
            var txtBPT_SchC1_5B = document.getElementById('txtBPT_SchC1_5B');
            var lblBPT_SchC1_6A = document.getElementById('lblBPT_SchC1_6A');
            var lblBPT_SchC1_7B = document.getElementById('lblBPT_SchC1_7B');
            var lblBPT_SchC1_8A = document.getElementById('lblBPT_SchC1_8A');
            var lblBPT_SchC1_8B = document.getElementById('lblBPT_SchC1_8B');
            var lblBPT_SchC1_8C = document.getElementById('lblBPT_SchC1_8C');
            var txtBPT_SchC1_9A = document.getElementById('txtBPT_SchC1_9A');
            var txtBPT_SchC1_9B = document.getElementById('txtBPT_SchC1_9B');
            var lblBPT_SchC1_9C = document.getElementById('lblBPT_SchC1_9C');
            var txtBPT_SchC1_10A = document.getElementById('txtBPT_SchC1_10A');
            var txtBPT_SchC1_10B = document.getElementById('txtBPT_SchC1_10B');
            var lblBPT_SchC1_10c = document.getElementById('lblBPT_SchC1_10C');
            var lblBPT_SchC1_10D = document.getElementById('lblBPT_SchC1_10D');
            var lblBPT_SchC1_11 = document.getElementById('lblBPT_SchC1_11');
            var lblBPT_SchC1_12 = document.getElementById('lblBPT_SchC1_12');

            if (txtBPT_SchC1_9A.value != '' && txtBPT_SchC1_9B.value != '') {
                if (PrepForMath(txtBPT_SchC1_9A.value) == 0 && PrepForMath(txtBPT_SchC1_9B.value) == 0 || PrepForMath(txtBPT_SchC1_9B.value) == 0) {
                    $('#lblBPT_SchC1_9C').text(parseFloat(0).toFixed(6));
                }
                else if (PrepForMath(txtBPT_SchC1_9B.value) >= PrepForMath(txtBPT_SchC1_9A.value)) {
                    $('#lblBPT_SchC1_9C').text(parseFloat(PrepForMath(txtBPT_SchC1_9A.value) /
                            PrepForMath(txtBPT_SchC1_9B.value)).toFixed(6));
                }
                else {
                   
                }		//if
            }		//if
        }		//CalcSchdC1Line9c

        function CalcSchdC1Line10c() {

            var txtBPT_SchC1_1A = document.getElementById('txtBPT_SchC1_1A');
            var txtBPT_SchC1_1B = document.getElementById('txtBPT_SchC1_1B');
            var txtBPT_SchC1_2A = document.getElementById('txtBPT_SchC1_2A');
            var txtBPT_SchC1_2B = document.getElementById('txtBPT_SchC1_2B');
            var txtBPT_SchC1_3A = document.getElementById('txtBPT_SchC1_3A');
            var txtBPT_SchC1_3B = document.getElementById('txtBPT_SchC1_3B');
            var txtBPT_SchC1_4A = document.getElementById('txtBPT_SchC1_4A');
            var txtBPT_SchC1_4B = document.getElementById('txtBPT_SchC1_4B');
            var txtBPT_SchC1_5A = document.getElementById('txtBPT_SchC1_5A');
            var txtBPT_SchC1_5B = document.getElementById('txtBPT_SchC1_5B');
            var lblBPT_SchC1_6A = document.getElementById('lblBPT_SchC1_6A');
            var lblBPT_SchC1_7B = document.getElementById('lblBPT_SchC1_7B');
            var lblBPT_SchC1_8A = document.getElementById('lblBPT_SchC1_8A');
            var lblBPT_SchC1_8B = document.getElementById('lblBPT_SchC1_8B');
            var lblBPT_SchC1_8C = document.getElementById('lblBPT_SchC1_8C');
            var txtBPT_SchC1_9A = document.getElementById('txtBPT_SchC1_9A');
            var txtBPT_SchC1_9B = document.getElementById('txtBPT_SchC1_9B');
            var lblBPT_SchC1_9C = document.getElementById('lblBPT_SchC1_9C');
            var txtBPT_SchC1_10A = document.getElementById('txtBPT_SchC1_10A');
            var txtBPT_SchC1_10B = document.getElementById('txtBPT_SchC1_10B');
            var lblBPT_SchC1_10c = document.getElementById('lblBPT_SchC1_10C');
            var lblBPT_SchC1_10D = document.getElementById('lblBPT_SchC1_10D');
            var lblBPT_SchC1_11 = document.getElementById('lblBPT_SchC1_11');
            var lblBPT_SchC1_12 = document.getElementById('lblBPT_SchC1_12');


            if (txtBPT_SchC1_10A.value != '' && txtBPT_SchC1_10B.value != '') {
                if (PrepForMath(txtBPT_SchC1_10A.value) == 0 && PrepForMath(txtBPT_SchC1_10B.value) == 0 || PrepForMath(txtBPT_SchC1_10B.value) == 0) {
                    $('#lblBPT_SchC1_10C').text(parseFloat(0).toFixed(6));
                } else if (PrepForMath(txtBPT_SchC1_10B.value) >= PrepForMath(txtBPT_SchC1_10A.value)) {
                    $('#lblBPT_SchC1_10C').text(parseFloat(PrepForMath(txtBPT_SchC1_10A.value) /
                            PrepForMath(txtBPT_SchC1_10B.value)).toFixed(6));
                    $('#lblBPT_SchC1_10D').text($('#lblBPT_SchC1_10C').text());
                } else {
                    

                }		//if
            }		//if
        }		//CalcSchdC1Line10c

        function CalcSchdC1Line12() {
             
            var txtBPT_SchC1_1A = document.getElementById('txtBPT_SchC1_1A');
            var txtBPT_SchC1_1B = document.getElementById('txtBPT_SchC1_1B');
            var txtBPT_SchC1_2A = document.getElementById('txtBPT_SchC1_2A');
            var txtBPT_SchC1_2B = document.getElementById('txtBPT_SchC1_2B');
            var txtBPT_SchC1_3A = document.getElementById('txtBPT_SchC1_3A');
            var txtBPT_SchC1_3B = document.getElementById('txtBPT_SchC1_3B');
            var txtBPT_SchC1_4A = document.getElementById('txtBPT_SchC1_4A');
            var txtBPT_SchC1_4B = document.getElementById('txtBPT_SchC1_4B');
            var txtBPT_SchC1_5A = document.getElementById('txtBPT_SchC1_5A');
            var txtBPT_SchC1_5B = document.getElementById('txtBPT_SchC1_5B');
            var lblBPT_SchC1_6A = document.getElementById('lblBPT_SchC1_6A');
            var lblBPT_SchC1_7B = document.getElementById('lblBPT_SchC1_7B');
            var lblBPT_SchC1_8A = document.getElementById('lblBPT_SchC1_8A');
            var lblBPT_SchC1_8B = document.getElementById('lblBPT_SchC1_8B');
            var lblBPT_SchC1_8C = document.getElementById('lblBPT_SchC1_8C');
            var txtBPT_SchC1_9A = document.getElementById('txtBPT_SchC1_9A');
            var txtBPT_SchC1_9B = document.getElementById('txtBPT_SchC1_9B');
            var lblBPT_SchC1_9C = document.getElementById('lblBPT_SchC1_9C');
            var txtBPT_SchC1_10A = document.getElementById('txtBPT_SchC1_10A');
            var txtBPT_SchC1_10B = document.getElementById('txtBPT_SchC1_10B');
            var lblBPT_SchC1_10c = document.getElementById('lblBPT_SchC1_10C');
            var lblBPT_SchC1_10D = document.getElementById('lblBPT_SchC1_10D');
            var lblBPT_SchC1_11 = document.getElementById('lblBPT_SchC1_11');
            var lblBPT_SchC1_12 = document.getElementById('lblBPT_SchC1_12');
            var temp = 0;
            if ($('#lblBPT_SchC1_8C').text() != '' && $('#lblBPT_SchC1_9C').text() != '' &&
                    $('#lblBPT_SchC1_10C').text() != '' && $('#lblBPT_SchC1_10D').text()) {
                if (PrepForMath($('#lblBPT_SchC1_8C').text()) == 0 && PrepForMath($('#lblBPT_SchC1_9C').text()) == 0 &&
                        PrepForMath($('#lblBPT_SchC1_10C').text()) == 0 && PrepForMath($('#lblBPT_SchC1_10D').text()) == 0) {
                    $('#lblBPT_SchC1_11').text(parseFloat(0).toFixed(6));
                    $('#lblBPT_SchC1_12').text(parseFloat(1).toFixed(6));
                } else {
                    $('#lblBPT_SchC1_11').text(parseFloat(PrepForMath($('#lblBPT_SchC1_8C').text()) +
                            PrepForMath($('#lblBPT_SchC1_9C').text()) + PrepForMath($('#lblBPT_SchC1_10C').text()) +
                            PrepForMath($('#lblBPT_SchC1_10D').text())).toFixed(6));
                    //20100415 EHD - Changed the method to calc factors
                    

                    if (PrepForMath($('#lblBPT_SchC1_8A').text()) + PrepForMath($('#lblBPT_SchC1_8B').text()) > 0) { temp = temp + 1 }
                    if (PrepForMath(txtBPT_SchC1_9A.value) + PrepForMath(txtBPT_SchC1_9B.value) > 0) { temp = temp + 1 }
                    
                    if (PrepForMath(txtBPT_SchC1_10B.value) > 0) { temp = temp + 2; }

                    $('#lblBPT_SchC1_12').text(parseFloat($('#lblBPT_SchC1_11').text() / temp).toFixed(6));	//temp
                }		//if
                if (sPrevWrkSht == 'SCHDA') {
                    $('#lblBPT_SchA_6').text(parseFloat($('#lblBPT_SchC1_12').text()).toFixed(6));
                    PerformCalcsBPTlfSchdA();
                } else if (sPrevWrkSht == 'SCHDB') {
                    $('#lblBPT_SchB_6').text(parseFloat($('#lblBPT_SchC1_12').text()).toFixed(6));
                    PerformCalcsBPTlfSchdB();
                }		//if
            }		//if
        }		//CalcSchdC1Line10c
</script>

</head>
<body>
 
     <div id="BPT_SchdC1" style="DISPLAY: none;">
     <div class="col-lg-12 col-md-12">   
    
            	<div class="row ">
                    <div class="col-lg-12 templateclass">
                      
                	
                   <div class="table-responsive">
                                <h3> <p><strong>2012 BIRT Schedule C-1: Computation Of Apportionment Factors</strong>

Computation of apportionment factors to be applied to apportionable Net Income. 
    You must complete Schedule C-1 if you are apportioning your income. Failure to include this schedule
    with your return may result in the disallowance of your apportionment and you may be billed. </p>		
                                     <p>
             Persons subject to a tax inposed pursant to Article VII, VIII, IX or XV of the Tax Reform Code of
    1971 (Banks, Title Insurance Companies, Trust Companies, Insurance Companies and Mutual Thirft
    Institutions), complete Lines 10a, 10b and 10c ONLY. ALL OTHER TAXPAYERS, complete Lines 1 through 12. </p></h3>
                	
                                	<table class="table table-condensed table-striped custom_table03 wage-table-prynt">
                                    
                                    	<thead>
                                        	
                                            <tr>
                                            	<th colspan="2" class="odd">Calculations of Average Values of Real and Tangible Property Used in Business</th>
                                                <th width="37%" class="text-center">Column A<br>Within Philadelphia</th>
                                                <th width="21%" class="text-center">Column B<br>Total Everywhere</th>
                                            </tr>
                                            
                                        
                                        </thead>
                                        
                                        <tbody>
                                        	
                                            <tr>
                                            	<td width="4%">1.</td>
                                                <td width="38%" class="text-left">Inventories of Raw Materials, Work in Process and Finished Goods </td>
                                                <td width="37%" class="text-left">
                                               		<form class="form-horizontal">
                                
                                             <div class="form-group no-margin">
                                                    <div class="">
                                                     
                                                        <INPUT class="form-control input-sm" id=txtBPT_SchC1_1A type="text"style="WIDTH: 100%" 
				                                         onfocus=SetFocus() onchange="ValidateWorksheet('BPT_SchdC1')">
                                                    </div>
                                                  </div>
                                            
                                            </form>
                                                </td>
                                                <td width="21%">
                                                    <form class="form-horizontal">
                                
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                    <INPUT class="form-control input-sm" id=txtBPT_SchC1_1B type="text" style="WIDTH: 100%" 
				  onfocus=SetFocus() onchange="ValidateWorksheet('BPT_SchdC1')">   </div>
                                                  </div>
                                            
                                            </form>
                                                </td>
                                                </tr>
                                     		<tr class="odd">
                                            	<td width="4%">2.</td>
                                                <td width="38%" class="text-left">Land and Buildings Owned (at average orginal cost)</td>
                                                <td width="37%" class="text-left">
                                               		<form class="form-horizontal">
                                
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                    
                                                        <INPUT class="form-control input-sm" id=txtBPT_SchC1_2A type="text" style="WIDTH: 100%" 
				onfocus=SetFocus() onchange="ValidateWorksheet('BPT_SchdC1')">
                                                    </div>
                                                  </div>
                                            
                                            </form>
                                                </td>
                                                <td width="21%">
                                                    <form class="form-horizontal">
                                
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                     <INPUT class="form-control input-sm" id=txtBPT_SchC1_2B type="text" style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=13 onchange="ValidateWorksheet('BPT_SchdC1')"></div>
                                                  </div>
                                            
                                            </form>
                                                </td>
                                            </tr>
                                            <tr>
                                            	<td width="4%">3.</td>
                                                <td width="38%" class="text-left">Machinery and Equipment Owned (at average orginal cost) Finished Goods</td>
                                                <td width="37%" class="text-left">
                                               		<form class="form-horizontal">
                                
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                     
                                                        <INPUT class="form-control input-sm" id=txtBPT_SchC1_3A type="text" style="WIDTH: 100%" 
				onfocus=SetFocus() onchange="ValidateWorksheet('BPT_SchdC1')">
                                                    </div>
                                                  </div>
                                            
                                            </form>
                                                </td>
                                                <td width="21%">
                                                    <form class="form-horizontal">
                                
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                    
                                                        <INPUT class="form-control input-sm" id=txtBPT_SchC1_3B type="text" style="WIDTH: 100%" 
				onfocus=SetFocus() onchange="ValidateWorksheet('BPT_SchdC1')">
                                                    </div>
                                                  </div>
                                            
                                            </form>
                                                </td>
                                                </tr>
                                     		<tr class="odd">
                                            	<td width="4%">4.</td>
                                                <td width="38%" class="text-left">Other Tangiable Assets Owned (at average orginal cost) </td>
                                                <td width="37%" class="text-left">
                                               		<form class="form-horizontal">
                                
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                     <INPUT class="form-control input-sm" id=txtBPT_SchC1_4A type="text" style="WIDTH: 100%" 
				onfocus=SetFocus() onchange="ValidateWorksheet('BPT_SchdC1')" /></div>
                                                  </div>
                                            
                                            </form>
                                                </td>
                                                <td width="21%">
                                                    <form class="form-horizontal">
                                
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                    <INPUT class="form-control input-sm" id=txtBPT_SchC1_4B type="text" style="WIDTH: 100%" 
				onfocus=SetFocus() onchange="ValidateWorksheet('BPT_SchdC1')"> </div>
                                                  </div>
                                            
                                            </form>
                                                </td>
                                            </tr>
                                            <tr>
                                            	<td width="4%">5.</td>
                                                <td width="38%" class="text-left">Rented Property (at 8 times the net annual rental)</td>
                                                <td width="37%" class="text-left">
                                               		<form class="form-horizontal">
                                
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                     <INPUT class="form-control input-sm" id=txtBPT_SchC1_5A type="text" style="WIDTH: 100%" 
				onfocus=SetFocus() onchange="ValidateWorksheet('BPT_SchdC1')">  </div>
                                                  </div>
                                            
                                            </form>
                                                </td>
                                                <td width="21%">
                                                    <form class="form-horizontal">
                                
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                     <INPUT class="form-control input-sm" id=txtBPT_SchC1_5B type="text" style="WIDTH: 100%" 
				onfocus=SetFocus() onchange="ValidateWorksheet('BPT_SchdC1')"> </div>
                                                  </div>
                                            
                                            </form>
                                                </td>
                                                </tr>
                                     		<tr class="odd">
                                            	<td width="4%">6.</td>
                                                <td width="38%" class="text-left">Total average value of Property used WITHIN PHILADELPHIA </td>
                                                <td width="37%" class="text-left">
                                               		<form class="form-horizontal">
                                
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                     <LABEL id=lblBPT_SchC1_6A style="WIDTH: 100%" class="form-control input-sm"></LABEL>   </div>
                                                  </div>
                                            
                                            </form>
                                                </td>
                                                <td width="21%">
                                                    <form class="form-horizontal">
                                
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                    </div>
                                                  </div>
                                            
                                            </form>
                                                </td>
                                            </tr>
                                            <tr>
                                            	<td width="4%">7.</td>
                                                <td width="38%" class="text-left">Total average value of Property used EVERYWHERE</td>
                                                <td width="37%" class="text-left">
                                               		<form class="form-horizontal">
                                
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                     <LABEL id=lblBPT_SchC1_7B style="WIDTH: 100%"  class="form-control input-sm"></LABEL> </div>
                                                  </div>
                                            
                                            </form>
                                                </td>
                                                <td width="21%">
                                                    <form class="form-horizontal">
                                
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                     &nbsp;</div>
                                                  </div>
                                            
                                            </form>
                                                </td>
                                                </tr>
                                        
                                        </tbody>
                                        
                                        <thead>
                                        	
                                            <tr>
                                            	<th colspan="4"><strong>Computation of Apportionment Factors: </strong></th>
                                       
                                            </tr>
                                            
                                        
                                        </thead>
                                        
                                        <tbody>
                                        	
                                            <tr>
                                            	<td width="4%">8a.</td>
                                                <td width="75%" class="text-left" colspan="2">Total Average Value of Philadelphia Property from Column A, Line 6 above</td>
                                                
                                                <td width="21%">
                                                    <form class="form-horizontal">
                                
                                                        <div class="form-group no-margin">
                                                                <LABEL id="lblBPT_SchC1_8A" style="WIDTH: 100%" class="form-control input-sm">
                                                                </LABEL>
                                                                
                                                            </div>
                                                            
                                                         
                                                         
                                                    
                                                    </form>
                                                </td>
                                                </tr>
                                     		<tr class="odd">
                                            	<td width="4%">8b.</td>
                                                <td width="75%" class="text-left" colspan="2">Total Average Value of Property Everywhere from Column B, Line 7 above </td>
                                               
                                                <td width="21%">
                                                    <form class="form-horizontal">
                                
                                                <div class="form-group no-margin">
                                                
                                                   
                                                    <LABEL id="lblBPT_SchC1_8B" style="WIDTH: 100%" class="form-control input-sm"></LABEL>
                                                     </div>
                                                     
                                                 
                                            
                                            </form>
                                                </td>
                                            </tr>
                                            <tr>
                                            	<td width="4%">8c.</td>
                                                <td width="75%" class="text-left" colspan="2">Philadelphia Property Factor [Calculated - Line 8a Divided by Line 8b]</td>
                                                
                                                <td width="21%">
                                                    <form class="form-horizontal">
                                
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                     
                                                        <LABEL id=lblBPT_SchC1_8C style="WIDTH: 100%" class="form-control input-sm"></LABEL>
                                                    </div>
                                                  </div>
                                            
                                            </form>
                                                </td>
                                                </tr>
                                     		<tr class="odd">
                                            	<td width="4%">9a.</td>
                                                <td width="75%" class="text-left" colspan="2">Philadelphia Payroll</td>
                                               
                                                <td width="21%">
                                                    <form class="form-horizontal">
                                
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                    
                                                        <INPUT class="form-control input-sm" id=txtBPT_SchC1_9A type="text" style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=13 onchange="ValidateWorksheet('BPT_SchdC1')">
                                                    </div>
                                                  </div>
                                            
                                            </form>
                                                </td>
                                            </tr>
                                            <tr>
                                            	<td width="4%">9b.</td>
                                                <td width="75%" class="text-left" colspan="2">Payroll Everywhere</td>
                                                
                                                <td width="21%">
                                                    <form class="form-horizontal">
                                
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                     
                                                        <INPUT class="form-control input-sm" id=txtBPT_SchC1_9B type="text" style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=13 onchange="ValidateWorksheet('BPT_SchdC1')">
                                                    </div>
                                                  </div>
                                            
                                            </form>
                                                </td>
                                                </tr>
                                     		<tr class="odd">
                                            	<td width="4%">9c.</td>
                                                <td width="75%" class="text-left" colspan="2">Philadelphia Payroll Factor [Calculated - Line 9a Divided by Line 9b] </td>
                                                
                                                <td width="21%">
                                                    <form class="form-horizontal">
                                
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                     
                                                        <LABEL id=lblBPT_SchC1_9C style="WIDTH: 100%" class="form-control input-sm"></LABEL>
                                                    </div>
                                                  </div>
                                            
                                            </form>
                                                </td>
                                            </tr>
                                            <tr>
                                            	<td width="4%">10a.</td>
                                                <td width="75%" class="text-left" colspan="2">Philadelphia Receipts </td>
                                              
                                                <td width="21%">
                                                    <form class="form-horizontal">
                                
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                    <INPUT class="form-control input-sm" id=txtBPT_SchC1_10A type="text" style="WIDTH: 100%" 
				onfocus=SetFocus() onchange="ValidateWorksheet('BPT_SchdC1')"> 
                                                    
                                                  </div>
                                                  </div>
                                            
                                            </form>
                                                </td>
                                                </tr>

                                            <tr>
                                            	<td width="4%">10b.</td>
                                                <td width="75%" class="text-left" colspan="2">Gross Receipts Everywhere </td>
                                               
                                                <td width="21%">
                                                    <form class="form-horizontal">
                                
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                    <INPUT class="form-control input-sm" id=txtBPT_SchC1_10B type="text" style="WIDTH: 100%" 
				onfocus=SetFocus() onchange="ValidateWorksheet('BPT_SchdC1')"> 
                                                    
                                                  </div>
                                                  </div>
                                            
                                            </form>
                                                </td>
                                                </tr>

                                            <tr>
                                            	<td width="4%">10c.</td>
                                                <td width="75%" class="text-left" colspan="2">Philadelphia Receipts Factor 	[Calculated - Line 10a Divided by Line 10b] </td>
                                               
                                                <td width="21%">
                                                    <form class="form-horizontal">
                                
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                   <LABEL id=lblBPT_SchC1_10C style="WIDTH: 100%" class="form-control input-sm"></LABEL>  
                                                  </div>
                                                  </div>
                                            
                                            </form>
                                                </td>
                                                </tr>

                                            <tr>
                                            	<td width="4%">10d.</td>
                                                <td width="75%" class="text-left" colspan="2">Repeat Line 10c</td>
                                              
                                                <td width="21%">
                                                    <form class="form-horizontal">
                                
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                    <LABEL id="lblBPT_SchC1_10D" style="WIDTH: 100%" class="form-control input-sm"> </LABEL>
                                                  </div>
                                                  </div>
                                            
                                            </form>
                                                </td>
                                                </tr>
                                                                                        
                                            <tr>
                                            	<td width="4%">11.</td>
                                                <td width="75%" class="text-left" colspan="2">TOTAL FACTORS   [Calculated - Sum Lines 8c, 9c, 10c and 10d]</td>
                                               
                                                <td width="21%">
                                                    <form class="form-horizontal">
                                
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                   <LABEL id=lblBPT_SchC1_11 style="WIDTH: 100%" class="form-control input-sm"></LABEL>  
                                                  </div>
                                                  </div>
                                            
                                            </form>
                                                </td>
                                                </tr>

                                            <tr>
                                            	<td width="4%">12.</td>
                                                <td width="75%" class="text-left" colspan="2">AVERAGE OF FACTORS  [Calculated - Line 11 Divided by applicable number of factors] </td>
                                                
                                                <td width="21%">
                                                    <form class="form-horizontal">
                                
                                                <div class="form-group no-margin">
                                                    <div class="">
                                                   <LABEL id=lblBPT_SchC1_12 style="WIDTH: 100%" class="form-control input-sm"></LABEL>  
                                                  </div>
                                                  </div>
                                            
                                            </form>
                                                </td>
                                                </tr>
                                        </tbody>
                                    
                                    </table>

                                </div>
                                
                                
                                <form class="form-horizontal">
                                
                                	<div class="form-group page-print-wage-section">
                                        <div class="col-sm-offset-3 col-sm-9  text-right">
                                         <input type="button" value="Return to Page 1" class="submit_button2" id="btnC1GoTo" onclick=ShowPage("Pg1") />  </div>
                                      </div>
                                
                                </form>
                                
                       
             </div>
                	
          </div>
     </div>
         </div>
    
   
</body>
</html>

