<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head >
    
    <title></title>
    <script language='javascript' type="text/javascript">
        var scheduletype = '';
        var arrWorkSheetSErr = new Array();

        var xSecScS = 'WORKSHEET_S ';
        var xFldScWSLi1 = xSecScS + 'LOWERLINE_S1';
        var xFldScWSLi2 = xSecScS + 'LOWERLINE_S2';
        var xFldScWSLi3 = xSecScS + 'LOWERLINE_S3';
        var xFldScWSLi4 = xSecScS + 'LOWERLINE_S4';
        var xFldScWSLi5 = xSecScS + 'LOWERLINE_Statutory_Net_Income';

        var xSecScD = 'BPT_SCH_D ';
        var xFldScDLi6 = xSecScD + 'NET_TAXABLE_RECEIPTS';
        var xFldScDLi9 = xSecScD + 'TAXABLE_RECEIPTS';

        function checkWS4() {
            $(parent.AppError).text(ispSetInputErr(arrWorkSheetSErr));
            CalcWorkSheetSLine5();
        }

        function PopulateBPTlfWorkSheetS() {

            txt_BPT_WS1.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScWSLi1, '', 0), 0);
            $('#lbl_BPT_WS2').text( ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScWSLi2, '', 0), 0));
            
            $('#lbl_BPT_WS3').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScWSLi3, '', 0), 0));

            var cal_load =parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScWSLi4, '', 0);
            $('#lbl_BPT_WS4').text(ispFormatMoney( cal_load.toString().split(".")[0], 0));
            txt_BPT_WS4.value = cal_load.toString().split(".")[1];
            $('#lbl_BPT_WS5').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScWSLi5, '', 0), 0));
            
        }

        function PopulateXmlWorkSheetS() {
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchD_1.value), xFldScWSLi1, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency( $('#lbl_BPT_WS2').text()), xFldScWSLi2, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lbl_BPT_WS3').text()), xFldScWSLi3, '', 0);
            var cal_xml = $('#lbl_BPT_WS4').text() + '.' + txt_BPT_WS4.value;
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(cal_xml), xFldScWSLi4, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lbl_BPT_WS5').text()), xFldScWSLi5, '', 0);
        }

        function ClearBPTlfWorkSheetS() {

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScWSLi1, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScWSLi2, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScWSLi3, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScWSLi4, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScWSLi5, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScDLi6, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScDLi9, '', 0);
        }
        function CalcWorkSheetSLine1(){
            if (txt_BPT_WS1.value != '')
            {
                //if(PrepForMath(txtBPT_SchD_1.value)>PrepForMath($('#lblBPT_SchD_6').text()))
                //{
                //    txtBPT_SchD_1.value = ispFormatMoney(50000, 0);
                //}
              
            }
        }
        function CalcWorkSheetSLine2() {
            if ( $('#lbl_BPT_WS2').text() == '')
            { 
                if(scheduletype == 'WRKSB')
                    $('#lbl_BPT_WS2').text( ispFormatMoney(PrepForMath($('#lblBPT_SchB_9').text()), 0));

                if(scheduletype == 'WRKSA')
                    $('#lbl_BPT_WS2').text( ispFormatMoney(PrepForMath($('#lblBPT_SchA_9').text()), 0));
            }
        }
        function CalcWorkSheetSLine3() {
            if ($('#lbl_BPT_WS3').text() == '') {
                $('#lbl_BPT_WS3').text(ispFormatMoney(PrepForMath($('#lblBPT_SchD_6').text()), 0));
            }
        }
        function CalcWorkSheetSLine4() {
            if ($('#lbl_BPT_WS3').text() != '' &&  $('#lbl_BPT_WS2').text() != '') {
                var calculationvar1 = (PrepForMath($('#lbl_BPT_WS2').text()) / PrepForMath($('#lbl_BPT_WS3').text())) * 100;
               
                if (calculationvar1 == "Infinity" || calculationvar1=="NAN")
                {
                   
                    $('#lbl_BPT_WS4').text('$' + 0 + '.');
                    txt_BPT_WS4.value = 00;
                }
                else {
                    
                    calculationvar1 = calculationvar1.toFixed(2);
                    $('#lbl_BPT_WS4').text(ispFormatMoney(calculationvar1.toString().split(".")[0], 0) + '.');
                    txt_BPT_WS4.value = calculationvar1.toString().split(".")[1];
                }
               
            }
        }
        function CalcWorkSheetSLine5() {
            if (txt_BPT_WS1.value != '' && txt_BPT_WS4.value != '') {
                
                var totamount = PrepForMath($('#lbl_BPT_WS4').text()) + '.' + txt_BPT_WS4.value;
                $('#lbl_BPT_WS5').text(ispFormatMoney((PrepForMath(txt_BPT_WS1.value) * totamount), 0));

                if (scheduletype == 'WRKSB') {
                    if (PrepForMath($('#lblBPT_SchC1_12').text()) == 0) {
                        $('#lblBPT_SchB_10').text(ispFormatMoney(0, 0));

                    }
                    else {
                        $('#lblBPT_SchB_10').text($('#lbl_BPT_WS5').text());
                    }
                }
                else if (scheduletype == 'WRKSA') {
                    if (PrepForMath($('#lblBPT_SchC1_12').text()) == 0) {
                        $('#lblBPT_SchA_10').text(ispFormatMoney(0, 0));
                    }
                    else {
                        $('#lblBPT_SchA_10').text($('#lbl_BPT_WS5').text());
                    }
                }

            }
        }
        function Performvalidationandload() {
           
            CalcWorkSheetSLine1();
            CalcWorkSheetSLine2();
            CalcWorkSheetSLine3();
            CalcWorkSheetSLine4();
            CalcWorkSheetSLine5();
            
        
        }

        function PerformloadingWorkSheetSb() {
            scheduletype = 'WRKSB';
            
            CalcWorkSheetSLine1();
            CalcWorkSheetSLine2();
            CalcWorkSheetSLine3();
            CalcWorkSheetSLine4();
            CalcWorkSheetSLine5();
            
           
           
        }
        function PerformloadingWorkSheetSa() {
            scheduletype = 'WRKSA';
           
           
            CalcWorkSheetSLine1();
            CalcWorkSheetSLine2();
            CalcWorkSheetSLine3();
            CalcWorkSheetSLine4();
            CalcWorkSheetSLine5();
            
        }
        function FieldLockBPTlfWrkS(bDisabled) {
            $('#txt_BPT_WS1').attr('disabled', bDisabled);
            $('#txt_BPT_WS4').attr('disabled', bDisabled);
            
        }
        function ShowPagefun() {
            
            if (scheduletype == 'WRKSB') {
                ShowPage("SchdB");
            }
            else if (scheduletype == 'WRKSA') {
                ShowPage("SchdA");
            }
        }
        
        function LoadErrorBPTlfWorkSheetS() {
            var i = 0;
           
            arrWorkSheetSErr[i++] = [txt_BPT_WS1, 'txt_BPT_WS1.value == ""', 'Answer Question 1'];
            arrWorkSheetSErr[i++] = [txt_BPT_WS1, 'ispValue(txt_BPT_WS1.value) == false', 'Value for Question 1 must be numeric'];
            //arrWorkSheetSErr[i++] = [txt_BPT_WS1, '(PrepForMath(txt_BPT_WS1.value)!=50000) || PrepForMath(txt_BPT_WS1.value) > PrepForMath($("#lblBPT_SchD_6").text()) ', 'S1 value must be lower of Line 6 of Schedule D or $50,000'];
           
            arrWorkSheetSErr[i++] = [txt_BPT_WS4, 'txt_BPT_WS4.value == ""', 'Answer Question 3'];
            arrWorkSheetSErr[i++] = [txt_BPT_WS4, 'ispValue(txt_BPT_WS4.value) == false', 'Value for Question 3 must be numeric'];
            //arrWorkSheetSErr[i++] = [txt_BPT_WS4, 'tempcal > PrepForMath(txt_BPT_WS1.value)', 'Value for Line 4 cannot be greater than line1'];
           
        }

    </script>
</head>
<body>
    <div class="form_segment" id="BPT_WorkSheetS" style="DISPLAY: block;">

                                <table summary="Employee Pay Sheet" class="hor-zebra" id="tblBptSchE">

                                    <tbody>

                                        <tr class="odd">
                                            <td width="70%"><B><U>Worksheet S - Use to calculate Statutory Net Income Deduction</U></b>
                                            <td colspan="2" align="center" class="no_border_right">
                                                
                                               </td>
                                        </tr>                                        
                                         <tr>
                                            <td>S1. Enter the lower of <label id="Label2" class="lblLink label_NoLeft" style="width:100%" onclick="ShowPage('SchdD')"> Line 6 of Schedule D </label> or $50,000 </td>
                                            <td colspan="2" align="center" class="no_border_right">
                                             <INPUT class="" id="txt_BPT_WS1" style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange='ValidateWorksheet("BPT_WorkSheetS")'>
                                               </td>
                                        </tr>
                                        <tr  class="odd">
                                            <td width="70%">S2. Current Year Income (from Line 9 of <label id="lblLnksA" class="lblLink label_NoLeft" style="width:100%" onclick="ShowPage('SchdA')"> Schedule A </label>or <label id="lblLnksB" class="lblLink label_NoLeft" style="width:100%" onclick="ShowPage('SchdB')">Schedule B.</label> ) 
                                            </td>
                                            <td colspan="2" align="center" class="no_border_right">
                                                <label class="" id="lbl_BPT_WS2" style="WIDTH:100%" ></label>
                                             </td>
                                        </tr>
                                        <tr >
                                            <td>S3. Net Taxable Receipts (from Line 6 of <label id="lblLnksD" class="lblLink label_NoLeft" style="width:100%" onclick="ShowPage('SchdD')"> Schedule D </label>)</td>
                                            <td colspan="2" align="center" class="no_border_right">
                                                <label class="" id="lbl_BPT_WS3" style="WIDTH:100%"></label>
                                            </td>
                                        </tr>
                                        <tr class="odd">
                                            <td>S4. Divide Line S2 by Line S3 and enter percentage as a decimal (two places)</td>
                                            <td style="width:80%"  align="right" class="no_border_right">
                                             <label class="" id="lbl_BPT_WS4" /> .  </td>
                                            <td><INPUT class="" id="txt_BPT_WS4" style="WIDTH:100%" 
      onfocus=SetFocus() maxLength=10 onchange='checkWS4()'/></td>
                                        </tr>
                                        <tr >
                                            <td>S5. Statutory Net Income Deduction (Line S1 times Line S4)</td>
                                            <td colspan="2" align="center" class="no_border_right">
                                                <label class="" id="lbl_BPT_WS5" style="WIDTH:100%"  ></label>
                                             
                                               </td>
                                        </tr>                               
                                         
                                        <tr >
                                            <td  ></td>
                                            <td colspan="2"  align="center" class="no_border_right">
                                                <div class="form_segment here_input_table" align="right"><label>.   </label>
                                               <input type="button" value="Return to Schedule"  class="submit_button2" id="btnGoToPageWS1" onclick="ShowPagefun()" />
                                                    </div>
                                                    </td>
                                        </tr>

                                         
                                    </tbody>
                                </table>
                                <div class="clear"></div>

                            </div>
</body>
</html>
