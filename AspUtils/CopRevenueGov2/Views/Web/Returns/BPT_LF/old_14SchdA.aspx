<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head >
  
    <title></title>
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
            var i = 0;
            arrSchdAErr[i++] = [txtBPT_SchA_1, 'txtBPT_SchA_1.value == ""', 'Answer Question 1'];
            arrSchdAErr[i++] = [txtBPT_SchA_1, 'ispValue(txtBPT_SchA_1.value) == false', 'Value for Question 1 must be numeric'];
            arrSchdAErr[i++] = [txtBPT_SchA_2, 'txtBPT_SchA_2.value == ""', 'Answer Question 2'];
            arrSchdAErr[i++] = [txtBPT_SchA_2, 'ispValue(txtBPT_SchA_2.value) == false', 'Value for Question 2 must be numeric'];
            arrSchdAErr[i++] = [txtBPT_SchA_3, 'txtBPT_SchA_3.value == ""', 'Answer Question 3'];
            arrSchdAErr[i++] = [txtBPT_SchA_3, 'ispValue(txtBPT_SchA_3.value) == false', 'Value for Question 3 must be numeric'];
            arrSchdAErr[i++] = [txtBPT_SchA_4, 'txtBPT_SchA_4.value == ""', 'Answer Question 4'];
            arrSchdAErr[i++] = [txtBPT_SchA_4, 'ispValue(txtBPT_SchA_4.value) == false', 'Value for Question 4 must be numeric'];
            arrSchdAErr[i++] = [txtBPT_SchA_8, 'txtBPT_SchA_8.value == ""', 'Answer Question 8'];
            arrSchdAErr[i++] = [txtBPT_SchA_8, 'ispValue(txtBPT_SchA_8.value) == false', 'Value for Question 8 must be numeric'];
            arrSchdAErr[i++] = [txtBPT_SchA_11, 'txtBPT_SchA_11.value == ""', 'Answer Question 11'];
            arrSchdAErr[i++] = [txtBPT_SchA_11, 'ispValue(txtBPT_SchA_11.value) == false', 'Value for Question 11 must be numeric'];
            arrSchdAErr[i++] = [txtBPT_SchA_11, 'ispNegativeNumber(txtBPT_SchA_11.value) == false', 'Value for Question 11 must NOT be negative'];
        }		//LoadErrorBPTlfSchdA

        function ClearBPTlfSchdA() {

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScALi1, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScALi2, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScALi3, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScALi4, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScALi5, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScALi6, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScALi7, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScALi8, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScALi9, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScALi10, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScALi11, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScALi12, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, 0, xFldScALi13, '', 0);

        }		//ClearBPTlfSchdA

        function PopulateXmlBPTlfSchdA() {

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency(txtBPT_SchA_1.value), xFldScALi1, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency(txtBPT_SchA_2.value), xFldScALi2, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency(txtBPT_SchA_3.value), xFldScALi3, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency(txtBPT_SchA_4.value), xFldScALi4, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency($('#lblBPT_SchA_5').text()), xFldScALi5, '', 0);
            //EGOVWEB-63
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, parseFloat($('#lblBPT_SchA_6').text()).toFixed(6), xFldScALi6, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency($('#lblBPT_SchA_7').text()), xFldScALi7, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency(txtBPT_SchA_8.value), xFldScALi8, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency($('#lblBPT_SchA_9').text()), xFldScALi9, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency($('#lblBPT_SchA_10').text()), xFldScALi10, '', 0);
            
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency($('#txtBPT_SchA_11').value), xFldScALi11, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency($('#lblBPT_SchA_12').text()), xFldScALi12, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency($('#lblBPT_SchA_13').text()), xFldScALi13, '', 0);
            //Carry to Page 1
            //parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2014, stripCurrency($('#lblBPT_SchA_12').text()), 'BPT_PG1 NET_INCOME', '', 0);

        }		//PopulateBPTlfXMLSchdA

        function PopulateBPTlfSchdA() {

            txtBPT_SchA_1.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScALi1, '', 0), 0);
            txtBPT_SchA_2.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScALi2, '', 0), 0);
            txtBPT_SchA_3.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScALi3, '', 0), 0);
            txtBPT_SchA_4.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScALi4, '', 0), 0);

            //alert('before change : ' + ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScALi5, '', 0), 0));

            $('#lblBPT_SchA_5').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScALi5, '', 0), 0));

            //alert('after set : ' + $('#lblBPT_SchA_5').text());

            $('#lblBPT_SchA_6').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScALi6, '', 0) * 100);
            $('#lblBPT_SchA_7').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScALi7, '', 0), 0));
            txtBPT_SchA_8.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScALi8, '', 0), 0);
            $('#lblBPT_SchA_9').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScALi9, '', 0), 0));
            //EGOVWEB-131 EHD 03/25/2013 Always populate from BPT_INFO(xFldInfLossCarry) not BPT_SCH_A(xFldScALi10)
            $('#lblBPT_SchA_10').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScALi10, '', 0), 0));
            txtBPT_SchA_11.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldInfLossCarry, '', 0), 0);
            $('#lblBPT_SchA_12').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScALi12, '', 0), 0));
            $('#lblBPT_SchA_13').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2014, xFldScALi13, '', 0), 0));

            //alert(dBPTNetRate)
            $('#msgBPT_SchA_13').text($('#msgBPT_SchA_13').text().replace('###', dBPTNetRate));
        }		//PopulateBPTlfSchdA

        function ResetBPTlfSchdA() {
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
            txtBPT_SchA_11.value = ispFormatMoney(0, 0);         
            $('#lblBPT_SchA_12').text(ispFormatMoney(0, 0));
            $('#lblBPT_SchA_13').text(ispFormatMoney(0, 0));


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
            $('#txtBPT_SchA_11').attr('disabled', 'disabled');
            $('#lblBPT_SchA_12').attr('disabled', bDisabled);
            $('#lblBPT_SchA_13').attr('disabled', bDisabled);
        }		//FieldLockBPTlfSchdA

        function PerformCalcsBPTlfSchdA() {
            if (getActiveElement().id == 'txtBPT_SchA_1' && PrepForMath(txtBPT_SchB_1.value) != 0) {
                ResetBPTlfSchdB();
            }		//if
            if ($(parent.AppError).text() == "") {
                CalcBPTlfSchdALine5();
                CalcBPTlfSchdALine7();
                CalcBPTlfSchdALine9();
               
                CalcBPTlfSchdALine12();
            }		//if
        }		//PerformCalcsBPTlfSchdA

        function CalcBPTlfSchdALine5() {
            if (txtBPT_SchA_1.value != '' && txtBPT_SchA_2.value != '' &&
                    txtBPT_SchA_3.value != '' && txtBPT_SchA_4.value != '') {
                $('#lblBPT_SchA_5').text(ispFormatMoney(PrepForMath(txtBPT_SchA_1.value) -
                        (PrepForMath(txtBPT_SchA_2.value) + PrepForMath(txtBPT_SchA_3.value) + PrepForMath(txtBPT_SchA_4.value)), 0));
            }		//if
            //EGOVWEB-63
            //EGOVWEB-102
            //	if (PrepForMath(lblBPT_SchC1_12.innerText) != '0') {
            $('#lblBPT_SchA_6').text(parseFloat($('#lblBPT_SchC1_12').text()).toFixed(6));
            //		if (lblBPT_SchA_6.text == '' || PrepForMath(lblBPT_SchA_6.text) == '0') {
            //			lblBPT_SchA_6.text = '1.0'
            //		}		//if
            //	} else {
            //		if (PrepForMath(lblBPT_SchA_5.text) < 0) {
            //			lblBPT_SchA_6.text = '0.0'
            //		} else {
            //			lblBPT_SchA_6.text = '1.0'
            //		}		//if
            //	}		//if
        }		//CalcBPTlfSchdALine5

        function CalcBPTlfSchdALine7() {
            if ($('#lblBPT_SchA_5').text() != '' && $('#lblBPT_SchA_6').text() != '') {
                //chayan
                if ($('#lblBPT_SchA_6').text() != '' && PrepForMath($('#lblBPT_SchA_6').text()) == 0 &&
                        $('#BPT_SchdA').css('display') == 'block') {
                    alert('Schedule C needs to be completed');
                }		//if
                $('#lblBPT_SchA_7').text(ispFormatMoney(PrepForMath($('#lblBPT_SchA_5').text()) *
                        PrepForMath($('#lblBPT_SchA_6').text()), 0));
            }		//if
        }		//CalcBPTlfSchdALine7

        function CalcBPTlfSchdALine9() {
            if ($('#lblBPT_SchA_7').text() != '' && txtBPT_SchA_8.value != '') {
                $('#lblBPT_SchA_9').text(ispFormatMoney(PrepForMath($('#lblBPT_SchA_7').text()) +
                        PrepForMath(txtBPT_SchA_8.value), 0));
               
                if ((ispFormatMoney(PrepForMath($('#lblBPT_SchA_7').text()) + PrepForMath(txtBPT_SchA_8.value), 0)) < 0 ) {
                    $('#lbl_BPT_WS2').text('$' + 0);
                    
                }
                else {
                    $('#lbl_BPT_WS2').text($('#lblBPT_SchB_9').text());
                   
                }
                Performvalidationandload();
            }		//if
        }		//CalcBPTlfSchdALine9

        function CalcBPTlfSchdALine12() {
            if (PrepForMath($('#lblBPT_SchA_9').text()) < 0) {
                $('#lblBPT_SchA_10').text(ispFormatMoney(0, 0));
            }
           
            if ($('#lblBPT_SchA_9').text() != '' && txtBPT_SchA_11.value != '') {
                $('#lblBPT_SchA_12').text(ispFormatMoney(PrepForMath($('#lblBPT_SchA_9').text()) -
                        PrepForMath($('#lblBPT_SchA_10').text()) - PrepForMath($('#txtBPT_SchA_11').value), 0));
                $('#lblBPT_SchA_13').text(ispFormatMoney(PrepForMath($('#lblBPT_SchA_12').text()) * dBPTNetRate, 0));
                if (PrepForMath($('#lblBPT_SchA_13').text()) < 0) {
                    $('#lblBPT_SchA_13').text(ispFormatMoney(0, 0));
                }

                $('#lblBPT1_1').text($('#lblBPT_SchA_13').text());
                //if
            }		//if
        }		//CalcBPTlfSchdALine11
</script>
</head>

<body>
    <div class="form_segment" id="BPT_SchdA" style="DISPLAY: block;">

                                <table summary="Employee Pay Sheet" class="hor-zebra">

                                    <tbody>

                                        <tr class="odd">
                                            <td width="70%"><B><U>2014 BIRT Schedule A: Computation of Tax On Net Income(Method I)</U></B></td>
                                            <td align="center" class="no_border_right">
                                                
                                               </td>
                                        </tr>
                                        <tr>
                                            <td>1.  Net Income (Loss) per accounting system used plus income taxes
				deducted in arriving at Net Income, less total nonbusiness income.</td>
                                            <td align="center" class="no_border_right">
                                                <INPUT class="" id=txtBPT_SchA_1 style="WIDTH: 100%" 
				onfocus="SetFocus()" maxLength=10 onchange="ValidateWorksheet('BPT_SchdA')">
                                               </td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">2.  Net Income (Loss) from certain port related activities.
                                            </td>
                                            <td align="center" class="no_border_right">
                                               <INPUT class="" id=txtBPT_SchA_2 style="WIDTH: 100%" 
				onfocus="SetFocus()" maxLength=10 onchange="ValidateWorksheet('BPT_SchdA')"></td>
                                        </tr>
                                        <tr>
                                            <td>3. Net Income (Loss) from specific PUC and ICC business
				activities.</td>
                                            <td align="center" class="no_border_right">
                                              <INPUT class="" id=txtBPT_SchA_3 style="WIDTH: 100%" 
				onfocus="SetFocus()" maxLength=10 onchange="ValidateWorksheet('BPT_SchdA')"></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">4. Net Income (Loss) from Public Law 86-272 activities</td>
                                            <td align="center" class="no_border_right">
                                              <INPUT class="" id=txtBPT_SchA_4 style="WIDTH: 100%" 
				onfocus="SetFocus()" maxLength=10 onchange="ValidateWorksheet('BPT_SchdA')"></td>
                                        </tr>
                                        <tr>
                                            <td>5. Income (Loss) to be apportioned [Calculated - Line 1 minus 2, 3, and 4]</td>
                                            <td align="center" class="no_border_right">
                                             <LABEL id=lblBPT_SchA_5 style="WIDTH: 100%"></LABEL>
                                               </td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">6.  Average of Apportionment Factors (from
                                                <label id="lnkSchC1" class="lblLink" style="WIDTH: 100%" 
				onclick="ShowPage('SchdC1')">Click here for Schedule C-1, Line 12</label>
				).
                                            </td>
                                            <td align="center" class="no_border_right">
                                                <LABEL id=lblBPT_SchA_6 style="WIDTH: 100%"></LABEL>
                                              </td>
                                        </tr>
                                        <tr>
                                            <td>7.  Income (Loss) apportioned to Philadelphia[Calculated - Multiply Line 5 by Line 6]</td>
                                            <td align="center" class="no_border_right">
                                               <LABEL  id=lblBPT_SchA_7	style="WIDTH: 100%"></LABEL></td>
                                        </tr>
                                        <tr class="odd">
                                            <td >8.  Nonbusiness Income (Loss) allocated to Philadelphia</td>
                                            <td align="center" class="no_border_right">
                                             <INPUT class="" id=txtBPT_SchA_8 style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=10 onchange="ValidateWorksheet('BPT_SchdA')">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>9.  Current year Income (Loss)[Calculated - Line 7 plus Line 8]</td>
                                            <td align="center" class="no_border_right">
                                               <LABEL id=lblBPT_SchA_9 style="WIDTH: 100%"></LABEL></td>
                                        </tr>
                                         <tr class="odd">
                                            <td width="70%">10. Statutory Net Income Deduction  (from 
                                        <label id="lblLnkWRKS" class="lblLink label_NoLeft" style="width:100%" onclick="ShowPage('WRKSA')">Worksheet S, Line S5</label>
                                        
			                                ).</td>
                                            <td align="center" class="no_border_right">
                                            <label class="" id=lblBPT_SchA_10 style="WIDTH: 100%" onfocus="SetFocus()" maxLength=10 ></label>
                                            </td>
                                        </tr>
                                        <tr >
                                            <td width="70%">11. Loss Carry Forward, if any. (<u><font style="cursor:pointer;" onclick="parent.InstructionLinks()">See Instruction Sheet IV</font></u>)</td>
                                            <td align="center" class="no_border_right">
                                            <INPUT class="" id=txtBPT_SchA_11 style="WIDTH: 100%" onfocus="SetFocus()" maxLength=10 onchange="ValidateWorksheet('BPT_SchdA')">
                                            </td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">12.  Taxable Income (Loss)[Calculated -Line 9 minus Line 10 minus Line 11].</td>
                                            <td align="center" class="no_border_right">
                                             <LABEL id=lblBPT_SchA_12 style="WIDTH: 100%"></LABEL>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="70%">13.  <LABEL id=msgBPT_SchA_13 class="" style="width:100%"><B>TAX DUE</B> (Multiply Line 12 by ###)</LABEL></td>
                                            <td align="center" class="no_border_right">
                                               <LABEL id=lblBPT_SchA_13 style="WIDTH: 100%"></LABEL></td>
                                        </tr>
                                     
                                        <tr class="odd">
                                            <td></td>
                                            <td align="center" class="no_border_right">
                                               <input type="button" value="Return to Page 1" class="submit_button2" id="btnGoToPage1" onclick="ShowPage('Pg1')" /></td>
                                        </tr>

                                         
                                    </tbody>
                                </table>
                                <div class="clear"></div>

                            </div>
</body>
</html>
