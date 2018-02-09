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

            var txt_BPT_WS1 = document.getElementById('txt_BPT_WS1');
            var lbl_BPT_WS2 = document.getElementById('lbl_BPT_WS2');
            var lbl_BPT_WS3 = document.getElementById('lbl_BPT_WS3');
            var txt_BPT_WS4 = document.getElementById('txt_BPT_WS4');
            var lbl_BPT_WS5 = document.getElementById('lbl_BPT_WS5');
         
            $(parent.AppError).text(ispSetInputErr(arrWorkSheetSErr));
            CalcWorkSheetSLine5();
        }

        function PopulateBPTlfWorkSheetS() {

            var txt_BPT_WS1 = document.getElementById('txt_BPT_WS1');
            var lbl_BPT_WS2 = document.getElementById('lbl_BPT_WS2');
            var lbl_BPT_WS3 = document.getElementById('lbl_BPT_WS3');
            var txt_BPT_WS4 = document.getElementById('txt_BPT_WS4');
            var lbl_BPT_WS5 = document.getElementById('lbl_BPT_WS5');

            txt_BPT_WS1.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScWSLi1, '', 0), 0);
            $('#lbl_BPT_WS2').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScWSLi2, '', 0), 0));

            $('#lbl_BPT_WS3').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScWSLi3, '', 0), 0));

            var cal_load = parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScWSLi4, '', 0);
            $('#lbl_BPT_WS4').text(ispFormatMoney(cal_load.toString().split(".")[0], 0));
            txt_BPT_WS4.value = cal_load.toString().split(".")[1];
            $('#lbl_BPT_WS5').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScWSLi5, '', 0), 0));

        }

        function PopulateXmlWorkSheetS() {

            var txt_BPT_WS1 = document.getElementById('txt_BPT_WS1');
            var lbl_BPT_WS2 = document.getElementById('lbl_BPT_WS2');
            var lbl_BPT_WS3 = document.getElementById('lbl_BPT_WS3');
            var txt_BPT_WS4 = document.getElementById('txt_BPT_WS4');
            var lbl_BPT_WS5 = document.getElementById('lbl_BPT_WS5');

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchD_1.value), xFldScWSLi1, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lbl_BPT_WS2').text()), xFldScWSLi2, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lbl_BPT_WS3').text()), xFldScWSLi3, '', 0);
            var cal_xml = $('#lbl_BPT_WS4').text() + '.' + txt_BPT_WS4.value;
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(cal_xml), xFldScWSLi4, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lbl_BPT_WS5').text()), xFldScWSLi5, '', 0);
        }

        function ClearBPTlfWorkSheetS() {


            var txt_BPT_WS1 = document.getElementById('txt_BPT_WS1');
            var lbl_BPT_WS2 = document.getElementById('lbl_BPT_WS2');
            var lbl_BPT_WS3 = document.getElementById('lbl_BPT_WS3');
            var txt_BPT_WS4 = document.getElementById('txt_BPT_WS4');
            var lbl_BPT_WS5 = document.getElementById('lbl_BPT_WS5');

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScWSLi1, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScWSLi2, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScWSLi3, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScWSLi4, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScWSLi5, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScDLi6, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScDLi9, '', 0);
        }
        function CalcWorkSheetSLine1() {
            var txt_BPT_WS1 = document.getElementById('txt_BPT_WS1');
            //if (isNaN(txt_BPT_WS1.value != '')) {
            //    //if(PrepForMath(txtBPT_SchD_1.value)>PrepForMath($('#lblBPT_SchD_6').text()))
            //    //{
            //    //    txtBPT_SchD_1.value = ispFormatMoney(50000, 0);
            //    //}

            //}
        }
        function CalcWorkSheetSLine2() {

            var txt_BPT_WS1 = document.getElementById('txt_BPT_WS1');
            var lbl_BPT_WS2 = document.getElementById('lbl_BPT_WS2');
            var lbl_BPT_WS3 = document.getElementById('lbl_BPT_WS3');
            var txt_BPT_WS4 = document.getElementById('txt_BPT_WS4');
            var lbl_BPT_WS5 = document.getElementById('lbl_BPT_WS5');

            if ($('#lbl_BPT_WS2').text() == '') {
                if (scheduletype == 'WRKSB')
                    $('#lbl_BPT_WS2').text(ispFormatMoney(PrepForMath($('#lblBPT_SchB_9').text()), 0));

                if (scheduletype == 'WRKSA')
                    $('#lbl_BPT_WS2').text(ispFormatMoney(PrepForMath($('#lblBPT_SchA_9').text()), 0));
            }
        }
        function CalcWorkSheetSLine3() {
            if ($('#lbl_BPT_WS3').text() == '') {
                $('#lbl_BPT_WS3').text(ispFormatMoney(PrepForMath($('#lblBPT_SchD_6').text()), 0));
            }
        }
        function CalcWorkSheetSLine4() {

            var txt_BPT_WS1 = document.getElementById('txt_BPT_WS1');
            var lbl_BPT_WS2 = document.getElementById('lbl_BPT_WS2');
            var lbl_BPT_WS3 = document.getElementById('lbl_BPT_WS3');
            var txt_BPT_WS4 = document.getElementById('txt_BPT_WS4');
            var lbl_BPT_WS5 = document.getElementById('lbl_BPT_WS5');

            if ($('#lbl_BPT_WS3').text() != '' && $('#lbl_BPT_WS2').text() != '') {
                var calculationvar1 = (PrepForMath($('#lbl_BPT_WS2').text()) / PrepForMath($('#lbl_BPT_WS3').text())) * 100;

                if (calculationvar1 == "Infinity" || calculationvar1 == "NAN") {

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

            var txt_BPT_WS1 = document.getElementById('txt_BPT_WS1');
            var lbl_BPT_WS2 = document.getElementById('lbl_BPT_WS2');
            var lbl_BPT_WS3 = document.getElementById('lbl_BPT_WS3');
            var txt_BPT_WS4 = document.getElementById('txt_BPT_WS4');
            var lbl_BPT_WS5 = document.getElementById('lbl_BPT_WS5');

            if ($("#txt_BPT_WS1.value").value != '' && $("#txt_BPT_WS4.value").value != '') {

                var totamount = PrepForMath($('#lbl_BPT_WS4').text()) + '.' + txt_BPT_WS4.value;
                $('#lbl_BPT_WS5').text(ispFormatMoney((PrepForMath($("#txt_BPT_WS1.value").value) * totamount), 0));

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


            var txt_BPT_WS1 = document.getElementById('txt_BPT_WS1');
            var lbl_BPT_WS2 = document.getElementById('lbl_BPT_WS2');
            var lbl_BPT_WS3 = document.getElementById('lbl_BPT_WS3');
            var txt_BPT_WS4 = document.getElementById('txt_BPT_WS4');
            var lbl_BPT_WS5 = document.getElementById('lbl_BPT_WS5');

            CalcWorkSheetSLine1();
            CalcWorkSheetSLine2();
            CalcWorkSheetSLine3();
            CalcWorkSheetSLine4();
            CalcWorkSheetSLine5();


        }

        function PerformloadingWorkSheetSb() {

            var txt_BPT_WS1 = document.getElementById('txt_BPT_WS1');
            var lbl_BPT_WS2 = document.getElementById('lbl_BPT_WS2');
            var lbl_BPT_WS3 = document.getElementById('lbl_BPT_WS3');
            var txt_BPT_WS4 = document.getElementById('txt_BPT_WS4');
            var lbl_BPT_WS5 = document.getElementById('lbl_BPT_WS5');

            scheduletype = 'WRKSB';

            CalcWorkSheetSLine1();
            CalcWorkSheetSLine2();
            CalcWorkSheetSLine3();
            CalcWorkSheetSLine4();
            CalcWorkSheetSLine5();



        }
        function PerformloadingWorkSheetSa() {

            var txt_BPT_WS1 = document.getElementById('txt_BPT_WS1');
            var lbl_BPT_WS2 = document.getElementById('lbl_BPT_WS2');
            var lbl_BPT_WS3 = document.getElementById('lbl_BPT_WS3');
            var txt_BPT_WS4 = document.getElementById('txt_BPT_WS4');
            var lbl_BPT_WS5 = document.getElementById('lbl_BPT_WS5');

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

            var txt_BPT_WS1 = document.getElementById('txt_BPT_WS1');
            var lbl_BPT_WS2 = document.getElementById('lbl_BPT_WS2');
            var lbl_BPT_WS3 = document.getElementById('lbl_BPT_WS3');
            var txt_BPT_WS4 = document.getElementById('txt_BPT_WS4');
            var lbl_BPT_WS5 = document.getElementById('lbl_BPT_WS5');


            if (scheduletype == 'WRKSB') {
                ShowPage("SchdB");
            }
            else if (scheduletype == 'WRKSA') {
                ShowPage("SchdA");
            }
        }

        function LoadErrorBPTlfWorkSheetS() {

            var txt_BPT_WS1 = document.getElementById('txt_BPT_WS1');
            var lbl_BPT_WS2 = document.getElementById('lbl_BPT_WS2');
            var lbl_BPT_WS3 = document.getElementById('lbl_BPT_WS3');
            var txt_BPT_WS4 = document.getElementById('txt_BPT_WS4');
            var lbl_BPT_WS5 = document.getElementById('lbl_BPT_WS5');

            var i = 0;

            arrWorkSheetSErr[i++] = [txt_BPT_WS1, txt_BPT_WS1.value == "", 'Answer Question 1'];
            arrWorkSheetSErr[i++] = [txt_BPT_WS1, ispValue(txt_BPT_WS1.value) == false, 'Value for Question 1 must be numeric'];
            //arrWorkSheetSErr[i++] = [txt_BPT_WS1, '(PrepForMath(txt_BPT_WS1.value)!=50000) || PrepForMath(txt_BPT_WS1.value) > PrepForMath($("#lblBPT_SchD_6").text()) ', 'S1 value must be lower of Line 6 of Schedule D or $50,000'];

            arrWorkSheetSErr[i++] = [txt_BPT_WS4, txt_BPT_WS4.value == "", 'Answer Question 3'];
            arrWorkSheetSErr[i++] = [txt_BPT_WS4, ispValue(txt_BPT_WS4.value) == false, 'Value for Question 3 must be numeric'];
            //arrWorkSheetSErr[i++] = [txt_BPT_WS4, 'tempcal > PrepForMath(txt_BPT_WS1.value)', 'Value for Line 4 cannot be greater than line1'];

        }

    </script>
</head>
<body>
  
     <div class="col-lg-12 col-md-12" id="BPT_WorkSheetS" style="DISPLAY: none;">   
     

            	<div class="row">
                    
                	
                    <!-- Schedule A Form -->
                    
                	<div class="col-lg-12 templateclass">
                                                           
                                <div class="table-responsive">
                                
                                	<table class="table table-condensed table-striped custom_table03">
                                    
                                    	                                        
                                        <tbody>
                                        	
                                           <tr class="">
                                            <td width="5%"></td>
                                            <td width="70%"><B><U>Worksheet S - Use to calculate Statutory Net Income Deduction</U></b>
                                            <td colspan="2" align="center" class="no_border_right">
                                                
                                               </td>
                                        </tr>       
                                           
                                     		<tr class="odd">
                                            	<td width="5%">S1.</td>
                                                <td width="70%" class="text-left">Enter the lower of<label id="Label2" class="lblLink label_NoLeft" style="width:100%" onclick="ShowPage('SchdD')"> Line 6 of Schedule D </label> or $50,000 </td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                             <Label id=lblBPT_SchE_1 style="WIDTH: 100%"   />
                                                                  <INPUT id="txt_BPT_WS1" style="WIDTH: 100%" 
      onfocus=SetFocus() class="form-control input-sm" onchange='ValidateWorksheet("BPT_WorkSheetS")'>
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                            <tr>
                                            	<td width="5%">S2.</td>
                                                <td width="70%" class="text-left"> Current Year Income (from Line 9 of <label id="lblLnksA" class="lblLink label_NoLeft" style="width:100%" onclick="ShowPage('SchdA')"> Schedule A </label>or <label id="lblLnksB" class="lblLink label_NoLeft" style="width:100%" onclick="ShowPage('SchdB')">Schedule B.</label> ) </td>
				
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                          
                                                                       <label class="form-control input-sm" id="lbl_BPT_WS2" style="WIDTH:100%" ></label>
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                     		<tr class="odd">
                                            	<td width="5%">S3.</td>
                                                <td width="70%" class="text-left"> Net Taxable Receipts (from Line 6 of <label id="lblLnksD" class="lblLink label_NoLeft" style="width:100%" onclick="ShowPage('SchdD')"> Schedule D </label>)</td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                                <LABEL id=lbl_BPT_WS3 style="WIDTH: 100%" class="form-control input-sm"></LABEL>
                                                          </div>
                                                       </div>
                                            		</form>
                                                </td>
                                            </tr>
                                          
                                            <tr>
                                            	<td width="5%">S4.</td>
                                                <td width="70%" class="text-left">Divide Line S2 by Line S3 and enter percentage as a decimal (two places)</td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                              
                                                                <INPUT class="form-control input-sm" id="txt_BPT_WS4" style="WIDTH:100%" 
      onfocus=SetFocus() onchange='checkWS4()'/>
                                                               
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                           
                                            <tr class="odd">
                                            	<td width="5%">B.</td>
                                                <td width="70%" class="text-left"><b>Wholesalers:</b>
                                               </td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                           </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                            <tr>
                                            	<td width="5%">S5.</td>
                                                <td width="70%" class="text-left"> Statutory Net Income Deduction (Line S1 times Line S4)</td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                              <Label id=lbl_BPT_WS5 style="WIDTH: 100%" class="form-control input-sm" />
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                                                         
                                        </tbody>
                                        
                                      
                                    </table>

                                </div>
                                                                
                                
                               <form class="form-horizontal school_form">

                                
                                	<div class="">
                                        <div class="col-sm-offset-3 col-sm-9  text-right">
                                       <%--  <button class="btn btn-default submit_button" type="submit">Print</button>--%>
                                        <input type="button" value="Return to Schedule"  class="submit_button2" id="btnGoToPageWS1" onclick="ShowPagefun()" />
                                        </div>
                                  </div>
                                
                                </form>
                                
                                 <!--  <!-- Schedule A Form  END -->
   
                                </div>
                         
                        </div>
                        
                    	
                 
            
            </div>

</body>
</html>
