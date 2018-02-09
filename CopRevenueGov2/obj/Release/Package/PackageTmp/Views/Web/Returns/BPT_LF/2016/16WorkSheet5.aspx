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
          
            $('#txt_BPT_WS1').val(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScWSLi1, '', 0), 0));
            $('#lbl_BPT_WS2').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScWSLi2, '', 0), 0));
            $('#lbl_BPT_WS3').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScWSLi3, '', 0), 0));
            var cal_load = parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScWSLi4, '', 0);
            $('#lbl_BPT_WS4').text(ispFormatMoney(cal_load.toString().split(".")[0], 0));
            $('#txt_BPT_WS4').val(cal_load.toString().split(".")[1]);
            $('#lbl_BPT_WS5').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScWSLi5, '', 0), 0));
        }

        function PopulateXmlWorkSheetS() {

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#txtBPT_SchD_1').val()), xFldScWSLi1, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lbl_BPT_WS2').text()), xFldScWSLi2, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency($('#lbl_BPT_WS3').text()), xFldScWSLi3, '', 0);
            var cal_xml = $('#lbl_BPT_WS4').text() + '.' + $('#txt_BPT_WS4').val();
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
        
        function CalcWorkSheetSLine2() {
           
            if ($('#lbl_BPT_WS2').text() == '') {
                if (scheduletype == 'WRKSB')
                    //alert(ispFormatMoney(PrepForMath($('#lblBPT_SchB_9').text()), 0));
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

            if ($('#lbl_BPT_WS3').text() != '' && $('#lbl_BPT_WS2').text() != '') {
                var calculationvar1 = (PrepForMath($('#lbl_BPT_WS2').text()) / PrepForMath($('#lbl_BPT_WS3').text())) * 100;

                if (calculationvar1 == "Infinity" || calculationvar1 == "NAN") {

                    $('#lbl_BPT_WS4').text('$' + 0 + '.');
                    $('#txt_BPT_WS4').val('00');
                }
                else {

                    calculationvar1 = calculationvar1.toFixed(2);
                    $('#lbl_BPT_WS4').text(ispFormatMoney(calculationvar1.toString().split(".")[0], 0) + '.');
                    $('#txt_BPT_WS4').val(calculationvar1.toString().split(".")[1]);
                }

            }
        }
        function CalcWorkSheetSLine5() {
           
            if ($('#txt_BPT_WS1').val() != '' && $('#txt_BPT_WS4').val() != '')
            {

                var totamount = PrepForMath($('#lbl_BPT_WS4').text()) + '.' + $('#txt_BPT_WS4').val();
                
                $('#lbl_BPT_WS5').text(ispFormatMoney(PrepForMath($('#txt_BPT_WS1').val()) * totamount, 0));

                if (scheduletype == 'WRKSB') {
                    
                    $('#lblBPT_SchB_10').text($('#lbl_BPT_WS5').text());
                }
                else if (scheduletype == 'WRKSA') {
                   
                    $('#lblBPT_SchA_10').text($('#lbl_BPT_WS5').text());
                }

            }
        }
        function RightAlignText_Ws() {//Added 
            $('#txt_BPT_WS1').css('text-align', 'right');
            $('#txt_BPT_WS4').css('text-align', 'right');
           
            $('#lbl_BPT_WS2').parent().css("text-align", "right");
            $('#lbl_BPT_WS3').parent().css("text-align", "right");
            $('#lbl_BPT_WS5').parent().css("text-align", "right");    

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
                PerformCalcsBPTlfSchdB();
            }
            else if (scheduletype == 'WRKSA') {
                PerformCalcsBPTlfSchdA();
                ShowPage("SchdA");
            }
        }

        function LoadErrorBPTlfWorkSheetS() {

            var txt_BPT_WS1 = document.getElementById('txt_BPT_WS1');          
            var txt_BPT_WS4 = document.getElementById('txt_BPT_WS4');          

            var i = 0;

            arrWorkSheetSErr[i++] = [txt_BPT_WS1, '$(\'#txt_BPT_WS1\').val() == ""', 'Answer question S1'];
            arrWorkSheetSErr[i++] = [txt_BPT_WS1, 'ispValue($(\'#txt_BPT_WS1\').val()) == false', 'Value for question S1 must be numeric'];
            arrWorkSheetSErr[i++] = [txt_BPT_WS1, 'ispNegativeNumber($(\'#txt_BPT_WS1\').val()) == false', 'Value for question S1 must not be negative'];
            

            arrWorkSheetSErr[i++] = [txt_BPT_WS4, '$(\'#txt_BPT_WS4\').val() == ""', 'Answer question S4'];
            arrWorkSheetSErr[i++] = [txt_BPT_WS4, 'ispValue($(\'#txt_BPT_WS4\').val()) == false', 'Value for question S4 must be numeric'];
            arrWorkSheetSErr[i++] = [txt_BPT_WS4, 'ispNegativeNumber($(\'#txt_BPT_WS4\').val()) == false', 'Value for question S4 must not be negative'];
            

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
                                                <td width="70%" class="text-left">Enter the lower of<label id="Label2" class="lblLink label_NoLeft" style="width:100%" onclick="ShowPage('SchdD')"> Line 6 of Schedule D </label> or $75,000 </td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                          
                                                                  <INPUT id="txt_BPT_WS1" type="text" type="text" style="WIDTH: 70%" onfocus=SetFocus() class="form-control input-sm pull-right" onchange="ValidateWorksheet('BPT_WorkSheetS')" />
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                            <tr>
                                            	<td width="5%">S2.</td>
                                                <td width="70%" class="text-left"> Enter Current Year Income from Line 11 of Schedule A or Line 9 of Schedule B.</td>
				
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                          
                                                                       <label class="form-control input-sm pull-right" id="lbl_BPT_WS2" style="WIDTH:70%" ></label>
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                     		<tr class="odd">
                                            	<td width="5%">S3.</td>
                                                <td width="70%" class="text-left"> Enter Net Taxable Receipts from Line 6 above</td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                                <LABEL id="lbl_BPT_WS3" style="WIDTH: 70%" class="form-control input-sm pull-right"></LABEL>
                                                          </div>
                                                       </div>
                                            		</form>
                                                </td>
                                            </tr>
                                          
                                            <tr>
                                            	<td width="5%">S4.</td>
                                                <td width="70%" class="text-left">Divide Line S2 by Line S3. (Cannot be greater than 1.0000)</td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                              
                                                                <INPUT class="form-control input-sm pull-right" id="txt_BPT_WS4" type="text" style="WIDTH:70%" onfocus="SetFocus()" onchange="ValidateWorksheet('BPT_WorkSheetS')" <%--onchange="checkWS4()"--%>/>
                                                               
                                                            </div>
                                                          </div>
                                            
                                            		</form>
                                                </td>
                                            </tr>
                                           
                                           
                                            <tr>
                                            	<td width="5%">S5.</td>
                                                <td width="70%" class="text-left"> Statutory Net Income Deduction (Line S1 times Line S4. Cannot exceed $75,000)</td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">

                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                              <Label id="lbl_BPT_WS5" style="WIDTH: 70%" class="form-control input-sm pull-right" />
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
