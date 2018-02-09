<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
    <title></title>
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
            var i = 0;
            arrSchdEErr[i++] = [txtBPT_SchE_1, 'txtBPT_SchE_1.value == ""', 'Answer Question 1'];
            arrSchdEErr[i++] = [txtBPT_SchE_1, 'ispValue(txtBPT_SchE_1.value) == false', 'Value for Question 1 must be numeric'];
            arrSchdEErr[i++] = [txtBPT_SchE_1, 'ispNegativeNumber(txtBPT_SchE_1.value) == false', 'Value for Question 1 must NOT be negative'];
            arrSchdEErr[i++] = [txtBPT_SchE_2, 'txtBPT_SchE_2.value == ""', 'Answer Question 2'];
            arrSchdEErr[i++] = [txtBPT_SchE_2, 'ispValue(txtBPT_SchE_2.value) == false', 'Value for Question 2 must be numeric'];
            arrSchdEErr[i++] = [txtBPT_SchE_2, 'ispNegativeNumber(txtBPT_SchE_2.value) == false', 'Value for Question 2 must NOT be negative'];
            arrSchdEErr[i++] = [txtBPT_SchE_5, 'txtBPT_SchE_5.value == ""', 'Answer Question 5'];
            arrSchdEErr[i++] = [txtBPT_SchE_5, 'ispValue(txtBPT_SchE_5.value) == false', 'Value for Question 5 must be numeric'];
            arrSchdEErr[i++] = [txtBPT_SchE_5, 'ispNegativeNumber(txtBPT_SchE_5.value) == false', 'Value for Question 5 must NOT be negative'];
            arrSchdEErr[i++] = [txtBPT_SchE_6A, 'txtBPT_SchE_6A.value == ""', 'Answer Question 6a'];
            arrSchdEErr[i++] = [txtBPT_SchE_6A, 'ispValue(txtBPT_SchE_6A.value) == false', 'Value for Question 6a must be numeric'];
            arrSchdEErr[i++] = [txtBPT_SchE_6A, 'ispNegativeNumber(txtBPT_SchE_6A.value) == false', 'Value for Question 6a must NOT be negative'];
            arrSchdEErr[i++] = [txtBPT_SchE_6B, 'txtBPT_SchE_6B.value == ""', 'Answer Question 6b'];
            arrSchdEErr[i++] = [txtBPT_SchE_6B, 'ispValue(txtBPT_SchE_6B.value) == false', 'Value for Question 6b must be numeric'];
            arrSchdEErr[i++] = [txtBPT_SchE_6B, 'ispNegativeNumber(txtBPT_SchE_6B.value) == false', 'Value for Question 6b must NOT be negative'];
            arrSchdEErr[i++] = [txtBPT_SchE_10, 'txtBPT_SchE_10.value == ""', 'Answer Question 10']
            arrSchdEErr[i++] = [txtBPT_SchE_10, 'ispValue(txtBPT_SchE_10.value) == false', 'Value for Question 10 must be numeric'];
            arrSchdEErr[i++] = [txtBPT_SchE_10, 'ispNegativeNumber(txtBPT_SchE_10.value) == false', 'Value for Question 10 must NOT be negative'];
            arrSchdEErr[i++] = [txtBPT_SchE_11A, 'txtBPT_SchE_11A.value == ""', 'Answer Question 11a'];
            arrSchdEErr[i++] = [txtBPT_SchE_11A, 'ispValue(txtBPT_SchE_11A.value) == false', 'Value for Question 11a must be numeric'];
            arrSchdEErr[i++] = [txtBPT_SchE_11A, 'ispNegativeNumber(txtBPT_SchE_11A.value) == false', 'Value for Question 11a must NOT be negative'];
            arrSchdEErr[i++] = [txtBPT_SchE_11B, 'txtBPT_SchE_11B.value == ""', 'Answer Question 11b'];
            arrSchdEErr[i++] = [txtBPT_SchE_11B, 'ispValue(txtBPT_SchE_11B.value) == false', 'Value for Question 11b must be numeric'];
            arrSchdEErr[i++] = [txtBPT_SchE_11B, 'ispNegativeNumber(txtBPT_SchE_11B.value) == false', 'Value for Question 11b must NOT be negative'];
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

        function PopulateBPTlfSchdE() {
            //clipboardData.setData ('Text', parent.$g.xmlBPTlf.xml.xml);
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

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchE_1.value), xFldScELi1, '', 0)
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
            $('#lblBPT_SchE_A').attr('disabled', bDisabled);
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
            if (txtBPT_SchE_1.value != '' && txtBPT_SchE_2.value != '') {
                $('#lblBPT_SchE_3').text(ispFormatMoney(PrepForMath(txtBPT_SchE_1.value) - PrepForMath(txtBPT_SchE_2.value), 0));
            }		//if

            if (PrepForMath($('#lblBPT_SchE_3').text()) < 0) {
                $('#lblBPT_SchE_4').text(ispFormatMoney(0, 0));
            } else {
                $('#lblBPT_SchE_4').text(ispFormatMoney(PrepForMath($('#lblBPT_SchE_3').text()) * dBPTManufacturerRate, 0));
            }		//if
        }		//CalcSchdELine4

        function CalcSchdELine9() {
            if (txtBPT_SchE_5.value != '' && txtBPT_SchE_6A.value != '' && txtBPT_SchE_6B.value != '') {
                $('#lblBPT_SchE_7').text(ispFormatMoney(PrepForMath(txtBPT_SchE_6A.value) + PrepForMath(txtBPT_SchE_6B.value), 0));
                $('#lblBPT_SchE_8').text(ispFormatMoney(PrepForMath(txtBPT_SchE_5.value) - PrepForMath($('#lblBPT_SchE_7').text()), 0));
            }		//if

            if (PrepForMath($('#lblBPT_SchE_8').text()) < 0) {
                $('#lblBPT_SchE_9').text(ispFormatMoney(0, 0));
            } else {
                $('#lblBPT_SchE_9').text(ispFormatMoney(PrepForMath($('#lblBPT_SchE_8').text()) * dBPTWholesaleRate, 0));
            }		//if
        }		//CalcSchdELine9

        function CalcSchdELine14() {
            if (txtBPT_SchE_10.value != '' && txtBPT_SchE_11A.value != '' && txtBPT_SchE_11B.value != '') {
                $('#lblBPT_SchE_12').text(ispFormatMoney(PrepForMath(txtBPT_SchE_11A.value) + PrepForMath(txtBPT_SchE_11B.value), 0));
                $('#lblBPT_SchE_13').text(ispFormatMoney(PrepForMath(txtBPT_SchE_10.value) - PrepForMath($('#lblBPT_SchE_12').text()), 0));
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
            //	if (BPT_SchdE.style.display != 'none') {
            //alert(sSchd)
            if ($('#lblBPT_SchE_A').text() != '' && txtBPT_SchE_1.value != '' && txtBPT_SchE_5.value != ''
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
            }		//if
            //	}		//if
        }		//VerifyTaxBasis
</script>
</head>
<body>
   <div class="form_segment" id="BPT_SchdE" style="DISPLAY: none;">

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
                                            <td>A.  Total Tax Basis (from Schedule D, Line 7)</td>
                                            <td align="center" class="no_border_right">
                                              <LABEL id=lblBPT_SchE_A style="WIDTH: 100%"></LABEL>
                                               </td>
                                        </tr>
                                         <tr class="odd">
                                            <td><B>Manufacturers:</B></td>
                                            <td align="center" class="no_border_right">
                                             
                                               </td>
                                        </tr>
                                        <tr >
                                            <td width="70%">1.  Receipts on which tax is to be computed by the Alternate 
    Method
                                            </td>
                                            <td align="center" class="no_border_right">
                                             <INPUT class="" id=txtBPT_SchE_1 style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange='ValidateWorksheet("BPT_SchdE")'></td>
                                        </tr>
                                        <tr class="odd">
                                            <td>2.  Cost of goods solds</td>
                                            <td align="center" class="no_border_right">
                                            <INPUT class="" id=txtBPT_SchE_2 style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange='ValidateWorksheet("BPT_SchdE")'></td>
                                        </tr>
                                        <tr >
                                            <td width="70%">3. TAX BASE[Calculated - Line 1 minus Line 2]</td>
                                            <td align="center" class="no_border_right">
                                           <LABEL id=lblBPT_SchE_3 style="WIDTH: 100%"></LABEL></td>
                                        </tr>
                                        <tr class="odd">
                                            <td>4.  <b>TAX DUE</b><LABEL id=msgBPT_SchE_4 class="" style="width:100%">[Calculated - Multiply Line 3 by ###]&nbsp;</LABEL></td>
                                            <td align="center" class="no_border_right">
                                             <LABEL id=lblBPT_SchE_4 style="WIDTH: 100%"></LABEL>
                                               </td>
                                        </tr>
                                        <tr >
                                            <td width="70%"><B>Wholesalers:</B>
                                            </td>
                                            <td align="center" class="no_border_right">
                                              
                                              </td>
                                        </tr>
                                        <tr class="odd">
                                            <td>5.  Receipts on which tax is to be computed by the Alternate 
    Method</td>
                                            <td align="center" class="no_border_right">
                                             <INPUT class="" id=txtBPT_SchE_5 style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange='ValidateWorksheet("BPT_SchdE")'></td>
                                        </tr>
                                        <tr >
                                            <td >Applicable Cost of Goods:</td>
                                            <td align="center" class="no_border_right">
                                            
                                            </td>
                                        </tr>
                                        <tr class="odd">
                                            <td>6a.  Cost of material</td>
                                            <td align="center" class="no_border_right">
                                              <INPUT class="" id=txtBPT_SchE_6A style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange='ValidateWorksheet("BPT_SchdE")'></td>
                                        </tr>
                                        <tr >
                                            <td width="70%">6b. Cost of labor</td>
                                            <td align="center" class="no_border_right">
                                        <INPUT class="" id=txtBPT_SchE_6B style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange='ValidateWorksheet("BPT_SchdE")'>
                                            </td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">7.  TOTAL APPLICABLE COST OF GOODS[Calculated - Line 6a plus Line 6b]</td>
                                            <td align="center" class="no_border_right">
                                          <LABEL id=lblBPT_SchE_7 style="WIDTH: 100%"></LABEL>
                                            </td>
                                        </tr>
                                        <tr >
                                            <td>8.  TAX BASE[Calculated - Line 5 minus Line 7]</td>
                                            <td align="center" class="no_border_right">
                                              <LABEL id=lblBPT_SchE_8 style="WIDTH: 100%"></LABEL></td>
                                        </tr>
                                         <tr class="odd">
                                            <td width="70%">9.  <b>TAX DUE</b><LABEL id=msgBPT_SchE_9 class="" style="width:100%">[Calculated - Multiply Line 8 by ###]&nbsp;</LABEL></td>
                                            <td align="center" class="no_border_right">
                                         <LABEL id=lblBPT_SchE_9 style="WIDTH: 100%"></LABEL>
                                            </td>
                                        </tr>
                                      
                                          <tr >
                                            <td width="70%"><B>Retailers:</B></td>
                                            <td align="center" class="no_border_right">
                                       
                                            </td>
                                        </tr>

                                         <tr class="odd">
                                            <td width="70%">10.  Receipts on which tax is to be computed by the Alternate 
    Method</td>
                                            <td align="center" class="no_border_right">
                                      <INPUT class="" id=txtBPT_SchE_10 style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange='ValidateWorksheet("BPT_SchdE")'>
                                            </td>
                                        </tr>

                                         <tr >
                                            <td width="70%">Applicable Cost of Goods:</td>
                                            <td align="center" class="no_border_right">
                                       
                                            </td>
                                        </tr>
                                          <tr class="odd">
                                            <td width="70%">11a.  Cost of material</td>
                                            <td align="center" class="no_border_right">
                                       <INPUT class="" id=txtBPT_SchE_11A style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange='ValidateWorksheet("BPT_SchdE")'>
                                            </td>
                                        </tr>
                                          <tr >
                                            <td width="70%">11b.  Cost of labor</td>
                                            <td align="center" class="no_border_right">
                                       <INPUT class="" id=txtBPT_SchE_11B style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange='ValidateWorksheet("BPT_SchdE")'>
                                            </td>
                                        </tr>
                                      
                                         <tr class="odd">
                                            <td width="70%">12.  TOTAL APPLICABLE COST OF GOODS[Calculated - Line 11a plus Line 11b]</td>
                                            <td align="center" class="no_border_right">
                                      <LABEL id=lblBPT_SchE_12 style="WIDTH: 100%"></LABEL>
                                            </td>
                                        </tr>
                                          <tr >
                                            <td width="70%">13.  TAX BASE[Calculated - Line 10 minus Line 12]</td>
                                            <td align="center" class="no_border_right">
                                      <LABEL id=lblBPT_SchE_13 style="WIDTH: 100%"></LABEL>
                                            </td>
                                        </tr>

                                          <tr class="odd">
                                            <td width="70%">14.  <b>TAX DUE</b><LABEL id=msgBPT_SchE_14 class="">[Calculated - Multiply Line 13 by ###]&nbsp;</LABEL></td>
                                            <td align="center" class="no_border_right">
                                    <LABEL id=lblBPT_SchE_14 style="WIDTH: 100%"></LABEL>
                                            </td>
                                        </tr>
                                          <tr >
                                            <td width="70%">15.  <b>TOTAL TAX DUE</b>[Calculated - Sum Lines 4, 9 and 14]</td>
                                            <td align="center" class="no_border_right">
                                   <LABEL id=lblBPT_SchE_15 style="WIDTH: 100%"></LABEL>
                                            </td>
                                        </tr>

                                        <tr class="odd">
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

                            </div>
</body>
</html>
