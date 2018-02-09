<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
       <title></title>
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

            //var txtBPT_SchC1_1 = document.getElementById('txtBPT_SchC1_1');
            //var txtBPT_SchC1_2 = document.getElementById('txtBPT_SchC1_2');             
            
            //var i = 0;
            //arrSchdC1Err[i++] = [txtBPT_SchC1_1, '$(\'#txtBPT_SchC1_1\').val() == ""', 'Answer question 1'];
            //arrSchdC1Err[i++] = [txtBPT_SchC1_1, 'ispValue($(\'#txtBPT_SchC1_1\').val()) == false', 'Value for question 1 must be numeric'];
            //arrSchdC1Err[i++] = [txtBPT_SchC1_1, 'ispNegativeNumber($(\'#txtBPT_SchC1_1\').val()) == false', 'Value for question 1 must not be negative'];

            //arrSchdC1Err[i++] = [txtBPT_SchC1_2, '$(\'#txtBPT_SchC1_2\').val() == ""', 'Answer question 2'];
            //arrSchdC1Err[i++] = [txtBPT_SchC1_2, 'ispValue($(\'#txtBPT_SchC1_2\').val()) == false', 'Value for question 2 must be numeric'];
            //arrSchdC1Err[i++] = [txtBPT_SchC1_2, 'ispNegativeNumber($(\'#txtBPT_SchC1_2\').val()) == false', 'Value for question 2 must not be negative'];           
           
        }		//LoadErrorBPTlfSchdC1

        function ClearBPTlfSchdC1() {
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldScCLi10a, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldScCLi10b, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, 0, xFldScCLi10c, '', 0);
          }		//ClearBPTlfSchdC1

        function RightAlignText_C1() {//Added 
            $('#lblBPT_SchC1_1').css('text-align', 'right');
            $('#lblBPT_SchC1_2').css('text-align', 'right');
            $('#lblBPT_SchC1_3').css('text-align', 'right');         

        }
        function PopulateXmlBPTlfSchdC1() {
            // 
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#lblBPT_SchC1_1').text()), xFldScCLi10a, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, stripCurrency($('#lblBPT_SchC1_2').text()), xFldScCLi10b, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf_2015, $('#lblBPT_SchC1_3').text(), xFldScCLi10c, '', 0);
         
        }		//PopulateXmlBPTlfSchdC1

        function PopulateBPTlfSchdC1() {
            // 
            $('#lblBPT_SchC1_1').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScCLi10a, '', 0), 0));
            $('#lblBPT_SchC1_2').text(ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScCLi10b, '', 0), 0));
           
            PrepForMath(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScCLi10c, '', 0)) == 0 ? $('#lblBPT_SchC1_3').text(parseFloat(0).toFixed(6)) : $('#lblBPT_SchC1_3').text(parseFloat(ispRemoveMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf_2015, xFldScCLi10c, '', 0)) / 10000).toFixed(6));//SumanG
            if ($('#lblBPT_SchC1_3').text() == '') {
                $('#lblBPT_SchC1_3').text(parseFloat(0).toFixed(6));
            }
            

        }		//PopulateBPTlfSchdC1

        function FieldLockBPTlfSchdC1(bDisabled) {
            $('#lblBPT_SchC1_1').attr('disabled', bDisabled);
            $('#lblBPT_SchC1_2').attr('disabled', bDisabled);
            $('#lblBPT_SchC1_3').attr('disabled', bDisabled);
         
        }		//FieldLockBPTlfSchdC1

        function PerformCalcsBPTlfSchdC1() {         
          
            CalcSchdC1Line3();		//Calculate lines 3 
         
        }		//PerformCalcsBPTlfSchdC1

        function CalcSchdC1Line3() {
         
            if ($('#lblBPT_SchC1_1').text() != '' && $('#lblBPT_SchC1_2').text() != '') {
                if (PrepForMath($('#lblBPT_SchC1_1').text()) == 0 && PrepForMath($('#lblBPT_SchC1_2').text()) == 0) {		
                    $('#lblBPT_SchC1_3').text(parseFloat(1).toFixed(6));
                }
                else if (PrepForMath($('#lblBPT_SchC1_2').text()) >= PrepForMath($('#lblBPT_SchC1_1').text())) {
                    $('#lblBPT_SchC1_3').text(parseFloat(PrepForMath($('#lblBPT_SchC1_1').text()) /
                            PrepForMath($('#lblBPT_SchC1_2').text())).toFixed(6));
                    
                } else {
                    

                }		//if
                if (sPrevWrkSht == 'SCHDA') {
                    $('#lblBPT_SchA_6').text(parseFloat($('#lblBPT_SchC1_3').text()).toFixed(6));
                    PerformCalcsBPTlfSchdA();
                } else if (sPrevWrkSht == 'SCHDB') {
                    $('#lblBPT_SchB_6').text(parseFloat($('#lblBPT_SchC1_3').text()).toFixed(6));
                    PerformCalcsBPTlfSchdB();
                } 	//if
            }		//if
        }

        function ShowPageC1_AB() {

            if (scheduleC1_AB == 'SCHDB') {
                ShowPage("SchdB");


            }
            else if (scheduleC1_AB == 'SCHDA') {
                ShowPage("SchdA");
            }

        }
</script>

       </head>
<body>
  
 
    <div id="BPT_SchdC1" style="DISPLAY: none;">
     <div class="col-lg-12 col-md-12 bptlf-sched-for-print">
    
                <div class="row">
                	<h3 class="slim-headings">2017 BIRT SCHEDULE C-1: For business conducted in and out of Philadelphia</h3>
                	<div class="col-lg-12 templateclass">            
                         
                            <div class="well" style="display:none; padding:0 5px; margin:0;">
                            <div class="row">
                                
                                <div class="col-lg-12 templateclass">
                               	<h5 class="text-center">Market-Based Sourcing of Service/Sales for Software Companies</h5>
                                
                                <p>A Software Company (as defined by BIRT Regulations Section 101DD) is to source sales/receipts (for both the Receipts and Net Income bases) in accordance with Market-based sourcing. That is, the sale of products and the performance of services will be deemed to be the location where the recipient receives the benefit of the products and services.</p>
                                                 
                               </div>
							</div>
                            </div>
                            
                            <div class="well" style="display:none; padding:0 5px; margin:0;">
                            <div class="row">
                                
                                <div class="col-lg-12 templateclass">
                               	<h5 class="text-center">This schedule must be completed in order to receive the deduction from Worksheet S.</h5>
                                                                                 
                               </div>
							</div>
                            </div>
                            
                             <div class="well" style="padding:0 5px; margin:0;">
                            <div class="row">
                                
                                <div class="col-lg-12 templateclass">
                               	<p>COMPUTATION OF APPORTIONMENT FACTOR TO BE APPLIED TO APPORTIONABLE NET INCOME. YOU MUST COMPLETE SCHEDULE C-1 IF YOU ARE APPORTIONING YOUR INCOME. FAILURE TO INCLUDE THIS SCHEDULE WITH YOUR RETURN MAY RESULT IN THE DISALLOWANCE OF YOUR APPORTIONMENT AND YOU MAY BE BILLED.</p>
                                                                                 
                               </div>
							</div>
                            </div>
                                
                            <div class="well" style="padding:0 5px; margin:0;">
                            <div class="row">
                            <div class="col-lg-12 templateclass">
                            <!-- Schedule C 1 Form -->
                        
                                <div class="">
                                
                                	<table class="table table-condensed table-striped custom_table03 wage-table-print bptlf-sched-page-table bptlf-inner-page-print">                                
                                    	
                                        <tbody>
                                        	
                                            <tr>
                                            	<td width="5%">1</td>
                                                <td width="70%" class="text-left">Philadelphia Sales/Receipts (From Schedule D line 6) </td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">
                                
                                                        <div class="form-group no-margin">
                                                            <div class="">                                                            
                                                                 <label class="form-control input-sm pull-right" id="lblBPT_SchC1_1" style="WIDTH: 100%" 
				                                                onfocus="SetFocus()"/>  
                                                          	</div>
                                                          </div>
                                                    
                                                    </form>
                                                </td>
                                               
                                             </tr>
                                     		 <tr class="odd">
                                            	<td width="5%">2</td>
                                                <td width="70%" class="text-left">Gross Sales/Receipts Everywhere (From Schedule D line 4)</td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">
                                
                                                        <div class="form-group no-margin">
                                                            <div class="">                                                          
                                                                 <label class="form-control input-sm pull-right" id="lblBPT_SchC1_2" style="WIDTH: 100%" 
				                                                onfocus="SetFocus()" />
                                                          	</div>
                                                          </div>
                                                    
                                                    </form>
                                                </td>
                                                
                                             </tr>
                                              <tr>
                                            	<td width="5%">3</td>
                                                <td width="70%" class="text-left">Single Sales/Receipts Factor Apportionment Precentage [Calculated - Line 1 Divided by Line 2]</td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">
                                
                                                        <div class="form-group no-margin">
                                                            <div class="">                                                            
                                                                 <LABEL id="lblBPT_SchC1_3" style="WIDTH: 100%" class="form-control input-sm pull-right"></LABEL>                                                                
                                                          	</div>
                                                          </div>
                                                    
                                                    </form>
                                                </td>
                                                
                                             </tr>
                                             
                                        </tbody>
                                        
                                       
                                    
                                    </table>

                                </div>
                                
                                </div>
                                
                         </div>
                            </div>

                            <div class="well">
                            <div class="row" style="display:none;">
                                
                                <div class="col-lg-12 templateclass">
                               	<p>ENTER THE PHILADELPHIA RECEIPTS FACTOR APPORTIONMENT PERCENTAGE ON SCHEDULE A, LINE 8 OR SCHEDULE B, LINE 6.</p>
                                 <h5>DO NOT FILE THIS RETURN if Line 3 is equal to 100%. Use the BIRT-EZ return which is available at <a href="#">www.phila.gov/revenue.</a></h5>   
                                 <h5>Do not submit Schedule C-1 with the BIRT-EZ return.</h5>                                             
                               </div>
							</div>
                            </div>
                                
                                <form class="form-horizontal">
                                 
                                	<div class="form-group page-print-wage-section">
                                        <div class="col-sm-offset-3 col-sm-9  text-right">
                                         <input type="button" value="Return to Page 1" class="submit_button2" id="btnC1GoTo" onclick="ShowPageC1_AB()" />  </div>
                                      </div>
                                
                                </form>
                                <!-- Schedule C 1 Form END-->
                            </div>
                                
                           
             
                	
                    <div class="clearfix"></div>
                    
               
            
            </div>
             
       </div>
        </div>
    <div class="lets-split"></div>


</body>
</html>
