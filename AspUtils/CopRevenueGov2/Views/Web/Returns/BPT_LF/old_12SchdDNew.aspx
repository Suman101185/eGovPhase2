﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

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
        var xFldScDLi7 = xSecScD + 'LE_TOTAL';
        var xFldScDLi8 = xSecScD + 'TAXABLE_RECEIPTS'
        var xFldScDLi9 = xSecScD + 'TAX_DUE';
        var xFldScDLi10 = xSecScD + 'TAX_DUE_ALT';
        var xFldScDLi11 = xSecScD + 'TOTAL_TAX_DUE';

        function LoadErrorBPTlfSchdD() {
            var i = 0;
            arrSchdDErr[i++] = [txtBPT_SchD_1, 'txtBPT_SchD_1.value == ""', 'Answer Question 1'];
            arrSchdDErr[i++] = [txtBPT_SchD_1, 'ispValue(txtBPT_SchD_1.value) == false', 'Value for Question 1 must be numeric'];
            arrSchdDErr[i++] = [txtBPT_SchD_1, 'ispNegativeNumber(txtBPT_SchD_1.value) == false', 'Value for Question 1 must NOT be negative'];
            arrSchdDErr[i++] = [txtBPT_SchD_2, 'txtBPT_SchD_2.value == ""', 'Answer Question 2'];
            arrSchdDErr[i++] = [txtBPT_SchD_2, 'ispValue(txtBPT_SchD_2.value) == false', 'Value for Question 2 must be numeric'];
            arrSchdDErr[i++] = [txtBPT_SchD_2, 'ispNegativeNumber(txtBPT_SchD_2.value) == false', 'Value for Question 2 must NOT be negative'];
            arrSchdDErr[i++] = [txtBPT_SchD_3, 'txtBPT_SchD_3.value == ""', 'Answer Question 3']
            arrSchdDErr[i++] = [txtBPT_SchD_3, 'ispValue(txtBPT_SchD_3.value) == false', 'Value for Question 3 must be numeric'];
            arrSchdDErr[i++] = [txtBPT_SchD_3, 'ispNegativeNumber(txtBPT_SchD_3.value) == false', 'Value for Question 3 must NOT be negative'];
            arrSchdDErr[i++] = [txtBPT_SchD_5A, 'txtBPT_SchD_5A.value == ""', 'Answer Question 5a'];
            arrSchdDErr[i++] = [txtBPT_SchD_5A, 'ispValue(txtBPT_SchD_5A.value) == false', 'Value for Question 5a must be numeric'];
            arrSchdDErr[i++] = [txtBPT_SchD_5A, 'ispNegativeNumber(txtBPT_SchD_5A.value) == false', 'Value for Question 5a must NOT be negative'];
            arrSchdDErr[i++] = [txtBPT_SchD_5B, 'txtBPT_SchD_5B.value == ""', 'Answer Question 5b'];;
            arrSchdDErr[i++] = [txtBPT_SchD_5B, 'ispValue(txtBPT_SchD_5B.value) == false', 'Value for Question 5b must be numeric'];
            arrSchdDErr[i++] = [txtBPT_SchD_5B, 'ispNegativeNumber(txtBPT_SchD_5B.value) == false', 'Value for Question 5b must NOT be negative'];
            arrSchdDErr[i++] = [txtBPT_SchD_5C, 'txtBPT_SchD_5C.value == ""', 'Answer Question 5c']
            arrSchdDErr[i++] = [txtBPT_SchD_5C, 'ispValue(txtBPT_SchD_5C.value) == false', 'Value for Question 5c must be numeric'];
            arrSchdDErr[i++] = [txtBPT_SchD_5C, 'ispNegativeNumber(txtBPT_SchD_5C.value) == false', 'Value for Question 5c must NOT be negative'];
            arrSchdDErr[i++] = [txtBPT_SchD_5D, 'txtBPT_SchD_5D.value == ""', 'Answer Question 5d'];
            arrSchdDErr[i++] = [txtBPT_SchD_5D, 'ispValue(txtBPT_SchD_5D.value) == false', 'Value for Question 5d must be numeric'];
            arrSchdDErr[i++] = [txtBPT_SchD_5D, 'ispNegativeNumber(txtBPT_SchD_5D.value) == false', 'Value for Question 5d must NOT be negative'];
            arrSchdDErr[i++] = [txtBPT_SchD_7, 'txtBPT_SchD_7.value == ""', 'Answer Question 7'];
            arrSchdDErr[i++] = [txtBPT_SchD_7, 'ispValue(txtBPT_SchD_7.value) == false', 'Value for Question 7 must be numeric'];
            arrSchdDErr[i++] = [txtBPT_SchD_7, 'ispNegativeNumber(txtBPT_SchD_7.value) == false', 'Value for Question 7 must NOT be negative'];
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

        }		//ClearBPTlfSchdD

        function PopulateXmlBPTlfSchdD() {

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
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchD_8').text()), xFldScDLi8, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchD_9').text()), xFldScDLi9, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchD_10').text()), xFldScDLi10, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lblBPT_SchD_11').text()), xFldScDLi11, '', 0);

        }		//PopulateXmlBPTlfSchdD

        function PopulateBPTlfSchdD() {

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
            $('#lblBPT_SchD_8').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScDLi8, '', 0), 0));
            $('#lblBPT_SchD_9').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScDLi9, '', 0), 0));
            $('#lblBPT_SchD_10').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScDLi10, '', 0), 0));
            $('#lblBPT_SchD_11').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScDLi11, '', 0), 0));

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
            $('#lblBPT_SchD_8').attr('disabled', bDisabled);
            $('#lblBPT_SchD_9').attr('disabled', bDisabled);
            $('#lblBPT_SchD_10').attr('disabled', bDisabled);
            $('#lblBPT_SchD_11').attr('disabled', bDisabled);
        }		//FieldLockBPTlfSchdD

        function PerformCalcsBPTlfSchdD() {
            CalcSchdDLine4();
            CalcSchdDLine6();
            CalcSchdDLine9();		//Calculate lines 8 and 9
            CalcSchdDLine11();

        }		//PerformCalcsBPTlfSchdD

        function CalcSchdDLine4() {
            if (txtBPT_SchD_1.value != '' && txtBPT_SchD_2.value != '' && txtBPT_SchD_3.value != '') {
                $('#lblBPT_SchD_4').text(ispFormatMoney(PrepForMath(txtBPT_SchD_1.value) + PrepForMath(txtBPT_SchD_2.value) +
                        PrepForMath(txtBPT_SchD_3.value), 0));
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
            var temp = 0;
            if (txtBPT_SchD_5A.value != '' && txtBPT_SchD_5B.value != '' && txtBPT_SchD_5C.value != '' &&
                    txtBPT_SchD_5D.value != '') {
                temp = PrepForMath(txtBPT_SchD_5A.value) + PrepForMath(txtBPT_SchD_5B.value) +
                        PrepForMath(txtBPT_SchD_5C.value) + PrepForMath(txtBPT_SchD_5D.value);
                $('#lblBPT_SchD_6').text(ispFormatMoney(PrepForMath($('#lblBPT_SchD_4').text()) - temp, 0));
            }		//if
        }		//CalcSchdDLine6

        function CalcSchdDLine9() {
            if ($('#lblBPT_SchD_6').text() != '' && txtBPT_SchD_7.value != '') {
                $('#lblBPT_SchD_8').text(ispFormatMoney(PrepForMath($('#lblBPT_SchD_6').text()) - PrepForMath(txtBPT_SchD_7.value), 0));
                $('#lblBPT_SchD_9').text(ispFormatMoney(PrepForMath($('#lblBPT_SchD_8').text()) * dBPTGrossRate, 0));
                //Fill in Schd E with info from this Schd
                $('#lblBPT_SchE_A').text(txtBPT_SchD_7.value);
                //		lblBPT_SchE_5.innerText =	txtBPT_SchD_7.value
                //		lblBPT_SchE_10.innerText =	txtBPT_SchD_7.value
                VerifyTaxBasis('SCHDD');
            }		//if
        }		//CalcSchdDLine9

        function CalcSchdDLine11() {
            if ($('#lblBPT_SchD_9').text() != '' && $('#lblBPT_SchD_10').text() != '') {
                $('#lblBPT_SchD_11').text(ispFormatMoney(PrepForMath($('#lblBPT_SchD_9').text()) + PrepForMath($('#lblBPT_SchD_10').text()), 0));
                if (PrepForMath($('#lblBPT_SchD_11').text()) < 0) {
                    $('#lblBPT_SchD_11').text(ispFormatMoney(0, 0));
                }		//if
                //		$('#lblBPT1_2').text( $('#lblBPT_SchD_11').text());
                //		PerformCalcsBPTlfPg1();
            }		//if
        }		//CalcSchdDLine11
</script>

</head>
<body>
   <div class="form_segment" id="BPT_SchdD" style="DISPLAY: none;">

                                <table summary="Employee Pay Sheet" class="hor-zebra">

                                    <tbody>

                                        <tr class="odd">
                                            <td width="70%"><B><U>2012 BIRT Schedule D: Computation Of Tax On Gross Receipts</U></B></td>
                                            <td align="center" class="no_border_right">
                                                
                                               </td>
                                        </tr>
                                        <tr>
                                            <td>1.  Gross Receipts from sales and/or rentals of tangible
    personal property, dividends, interest, royalties and gains on sale of stocks, bonds and
    business capital assests</td>
                                            <td align="center" class="no_border_right">
                                               <INPUT class="" id=txtBPT_SchD_1 style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange='ValidateWorksheet("BPT_SchdD")'>
                                               </td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">2.  Gross Receipts from services
                                            </td>
                                            <td align="center" class="no_border_right">
                                              <INPUT class="" id=txtBPT_SchD_2 style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange='ValidateWorksheet("BPT_SchdD")'></td>
                                        </tr>
                                        <tr>
                                            <td>3.Gross Receipts from rentals of real property</td>
                                            <td align="center" class="no_border_right">
                                             <INPUT class="" id=txtBPT_SchD_3 style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange='ValidateWorksheet("BPT_SchdD")'></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">4. Total Gross Receipts[Calculated - Sum Lines 1, 2 and 3]</td>
                                            <td align="center" class="no_border_right">
                                              <LABEL id=lblBPT_SchD_4 style="WIDTH: 100%"></LABEL></td>
                                        </tr>
                                        <tr>
                                            <td><B>Less Exclusions from:</B></td>
                                            <td align="center" class="no_border_right">
                                             
                                               </td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">5a.  Sales delivered outside of Philadelphia
                                            </td>
                                            <td align="center" class="no_border_right">
                                               <INPUT class=inpNormal id=txtBPT_SchD_5A style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange='ValidateWorksheet("BPT_SchdD")'>
                                              </td>
                                        </tr>
                                        <tr>
                                            <td>5b.  Services performed outside of Philadelphia</td>
                                            <td align="center" class="no_border_right">
                                              <INPUT class="" id=txtBPT_SchD_5B style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange='ValidateWorksheet("BPT_SchdD")'></td>
                                        </tr>
                                        <tr class="odd">
                                            <td >5c.  Rentals of real property outside of Philadelphia</td>
                                            <td align="center" class="no_border_right">
                                             <INPUT class="" id=txtBPT_SchD_5C style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange='ValidateWorksheet("BPT_SchdD")'>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>5d.  Other</td>
                                            <td align="center" class="no_border_right">
                                               <INPUT class="" id=txtBPT_SchD_5D style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange='ValidateWorksheet("BPT_SchdD")'></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">6. Net Taxable Receipts[Calculated - Line 4 minus Lines 5a through 5d]</td>
                                            <td align="center" class="no_border_right">
                                          <LABEL id=lblBPT_SchD_6 style="WIDTH: 100%"></LABEL>
                                            </td>
                                        </tr>
                                        <tr >
                                            <td width="70%">7.  Less Receipts on which tax is to be computed by the 
    Alternate Method</td>
                                            <td align="center" class="no_border_right">
                                           <INPUT class="" id=txtBPT_SchD_7 style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange='ValidateWorksheet("BPT_SchdD")'>
                                            </td>
                                        </tr>
                                        <tr class="odd">
                                            <td>8.  Receipts subject to tax at the regular rate[Calculated - Line 6 minus Line 7]</td>
                                            <td align="center" class="no_border_right">
                                               <LABEL id=lblBPT_SchD_8 style="WIDTH: 100%"></LABEL></td>
                                        </tr>
                                         <tr >
                                            <td width="70%">9.  <b>TAX DUE</b> at regular rate</td>
                                            <td align="center" class="no_border_right">
                                           <LABEL id=lblBPT_SchD_9 style="WIDTH: 100%"></LABEL>
                                            </td>
                                        </tr>
                                        <tr class="odd">
                                            <td>10.  <b>TAX DUE</b> using the Alternate Method (from
				<label class="lblLink"  onclick=ShowPage('SchdE')>Schedule E, Line 15</label>
				<LABEL class="">).</LABEL></td>
                                            <td align="center" class="no_border_right">
                                              <LABEL id=lblBPT_SchD_10 style="WIDTH: 100%"></LABEL></td>
                                        </tr>

                                          <tr >
                                            <td width="70%">11. <b>TOTAL TAX DUE</b>[Calculated - Sum Line 9 and Line 10]</td>
                                            <td align="center" class="no_border_right">
                                         <LABEL id=lblBPT_SchD_11 style="WIDTH: 100%"></LABEL>
                                            </td>
                                        </tr>
                                      
                                        <tr class="odd">
                                            <td></td>
                                            <td align="right" class="no_border_right">
                                               
                                               <input type="button" value="Return to Page 1" class="submit_button2" id="btnDGoTo" onclick='ShowPage("Pg1")' />
                                                  
                                                    </td>
                                        </tr>

                                         
                                    </tbody>
                                </table>
                                <div class="clear"></div>

                            </div>
</body>
</html>
