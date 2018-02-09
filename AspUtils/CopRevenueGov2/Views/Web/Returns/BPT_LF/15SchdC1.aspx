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

        //function DisplaySchC1() {

        //    parent.sNew = false;
        //    $('#BPT_SchdC1').css('display', 'block');
        //}
        function LoadErrorBPTlfSchdC1() {

            var txtBPT_SchC1_1 = document.getElementById('txtBPT_SchC1_1');
            var txtBPT_SchC1_2 = document.getElementById('txtBPT_SchC1_2');
            var lblBPT_SchC1_3 = document.getElementById('lblBPT_SchC1_3');
           
            

            var i = 0;
            arrSchdC1Err[i++] = [txtBPT_SchC1_1, txtBPT_SchC1_1.value == "", 'Answer Question 1'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_1, ispValue(txtBPT_SchC1_1.value) == false, 'Value for Question 1,must be numeric'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_1, ispNegativeNumber(txtBPT_SchC1_1.value) == false, 'Value for Question 1, must NOT be negative'];;
            arrSchdC1Err[i++] = [txtBPT_SchC1_2, txtBPT_SchC1_2.value == "", 'Answer Question 1'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_2, ispValue(txtBPT_SchC1_2.value) == false, 'Value for Question 1, must be numeric'];
            arrSchdC1Err[i++] = [txtBPT_SchC1_2, ispNegativeNumber(txtBPT_SchC1_2.value) == false, 'Value for Question 1, must NOT be negative'];
            arrSchdC1Err[i++] = [lblBPT_SchC1_3, ispValue(lblBPT_SchC1_3.value) == false, 'Value for Question 2, must be numeric'];
           
        }		//LoadErrorBPTlfSchdC1

        function ClearBPTlfSchdC1() {
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScC1TbLi1CoA, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScC1TbLi1CoB, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, 0, xFldScC1TbLi2CoA, '', 0);
          }		//ClearBPTlfSchdC1

        function PopulateXmlBPTlfSchdC1() {

            var txtBPT_SchC1_1 = document.getElementById('txtBPT_SchC1_1');
            var txtBPT_SchC1_2 = document.getElementById('txtBPT_SchC1_2');
            var lblBPT_SchC1_3 = document.getElementById('lblBPT_SchC1_3');
          

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchC1_1.value), xFldScC1TbLi1CoA, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(txtBPT_SchC1_2.value), xFldScC1TbLi1CoB, '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlBPTlf, stripCurrency(lblBPT_SchC1_3.value), xFldScC1TbLi2CoA, '', 0);
         
        }		//PopulateXmlBPTlfSchdC1

        function PopulateBPTlfSchdC1() {

            var txtBPT_SchC1_1 = document.getElementById('txtBPT_SchC1_1');
            var txtBPT_SchC1_2 = document.getElementById('txtBPT_SchC1_2');
            var lblBPT_SchC1_3 = document.getElementById('lblBPT_SchC1_3');
           

            txtBPT_SchC1_1.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScC1TbLi1CoA, '', 0), 0);
            txtBPT_SchC1_2.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScC1TbLi1CoB, '', 0), 0);
            lblBPT_SchC1_3.value = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTlf, xFldScC1TbLi2CoA, '', 0), 0);
         
        }		//PopulateBPTlfSchdC1

        function FieldLockBPTlfSchdC1(bDisabled) {
            $('#txtBPT_SchC1_1').attr('disabled', bDisabled);
            $('#txtBPT_SchC1_2').attr('disabled', bDisabled);//.disabled = bDisabled;
            $('#lblBPT_SchC1_3').attr('disabled', bDisabled);//.disabled = bDisabled
         
        }		//FieldLockBPTlfSchdC1

        function PerformCalcsBPTlfSchdC1() {

            var txtBPT_SchC1_1 = document.getElementById('txtBPT_SchC1_1');
            var txtBPT_SchC1_2 = document.getElementById('txtBPT_SchC1_2');
            var lblBPT_SchC1_3 = document.getElementById('lblBPT_SchC1_3');
          
            CalcSchdC1Line3();		//Calculate lines 3 
         
        }		//PerformCalcsBPTlfSchdC1

        function CalcSchdC1Line3() {
            var txtBPT_SchC1_1 = document.getElementById('txtBPT_SchC1_1');
            var txtBPT_SchC1_2 = document.getElementById('txtBPT_SchC1_2');
            var lblBPT_SchC1_3 = document.getElementById('lblBPT_SchC1_3');
        
            if (txtBPT_SchC1_1.value != '' && txtBPT_SchC1_2.value != '') {
                //alert(txtBPT_SchC1_1.value);
                var total_3 = PrepForMath(txtBPT_SchC1_1.value) /
                            PrepForMath(txtBPT_SchC1_2.value);
                //alert(total_3);
                lblBPT_SchC1_3.value = total_3;

               
            }		//if
        
        }		//CalcSchdC1Line3

   
</script>

       </head>
<body>
  <%-- <div class="account_greybox_new" id="BPT_SchdC1" style="DISPLAY: none;">
         <p><strong>2014 BIRT Schedule C-1: Computation Of Apportionment Factors</strong><br /><br />

Computation of apportionment factors to be applied to apportionable Net Income. 
    You must complete Schedule C-1 if you are apportioning your income. Failure to include this schedule
    with your return may result in the disallowance of your apportionment and you may be billed. </p>		
                <p>
             Persons subject to a tax inposed pursant to Article VII, VIII, IX or XV of the Tax Reform Code of
    1971 (Banks, Title Insurance Companies, Trust Companies, Insurance Companies and Mutual Thirft
    Institutions), complete Lines 10a, 10b and 10c ONLY. ALL OTHER TAXPAYERS, complete Lines 1 through 12. </p>
                <div class="clear"></div>
                                <table id="hor-zebra" summary="Employee Pay Sheet" class="no_magin_bothside">
                   
                    <tbody>
                        
                        <tr class="even">
                        	<td colspan="2"><strong>Calculations of Average Values of Real and Tangible Property Used in Business</strong></td>
                            <td width="20%" align="center"><strong>Column A<br />
                            Within Philadelphia</strong></td>
                            <td width="20%" align="center"><strong>Column B<br />
							Total Everywhere</strong></td>
                        </tr>
                        
                        
                        <tr class="odd">
                        	<td width="4%">1.</td>
                            <td width="56%">Inventories of Raw Materials, Work in Process and Finished Goods </td>
                            <td width="20%" align="center"><INPUT class="" id=txtBPT_SchC1_1A style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=13 onchange=ValidateWorksheet("BPT_SchdC1")></td>
                            <td width="20%" class="no_border_right" align="center"><INPUT class="" id=txtBPT_SchC1_1B style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=13 onchange=ValidateWorksheet("BPT_SchdC1")></td>
                        	
                        </tr>
                        <tr class="even">
                            <td width="4%">2.</td>
                            <td width="56%">Land and Buildings Owned (at average orginal cost)  </td>
                            <td width="20%" align="center"><INPUT class="" id=txtBPT_SchC1_2A style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=13 onchange=ValidateWorksheet("BPT_SchdC1")></td>
                            <td width="20%" class="no_border_right" align="center"><INPUT class="" id=txtBPT_SchC1_2B style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=13 onchange=ValidateWorksheet("BPT_SchdC1")></td>
                        </tr>
                        <tr class="odd">
                          <td>3.</td>
                          <td>Machinery and Equipment Owned (at average orginal cost) Finished Goods</td>
                          <td width="20%" align="center"><INPUT class="" id=txtBPT_SchC1_3A style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=13 onchange=ValidateWorksheet("BPT_SchdC1")></td>
                          <td width="20%" class="no_border_right" align="center"><INPUT class="" id=txtBPT_SchC1_3B style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=13 onchange=ValidateWorksheet("BPT_SchdC1")></td>
                        </tr>
                        <tr class="even">
                          <td>4.</td>
                          <td>Other Tangiable Assets Owned (at average orginal cost) </td>
                          <td width="20%" align="center"><INPUT class="" id=txtBPT_SchC1_4A style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=13 onchange=ValidateWorksheet("BPT_SchdC1")></td>
                          <td width="20%" class="no_border_right" align="center"><INPUT class="" id=txtBPT_SchC1_4B style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=13 onchange=ValidateWorksheet("BPT_SchdC1")></td>
                        </tr>
                        <tr class="odd">
                          <td>5.</td>
                          <td>Rented Property (at 8 times the net annual rental)</td>
                          <td width="20%" align="center"><INPUT class="" id=txtBPT_SchC1_5A style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=13 onchange=ValidateWorksheet("BPT_SchdC1")></td>
                          <td width="20%" class="no_border_right" align="center"><INPUT class="" id=txtBPT_SchC1_5B style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=13 onchange=ValidateWorksheet("BPT_SchdC1")></td>
                        </tr>
                        <tr class="even">
                          <td>6.</td>
                          <td>Total average value of Property used WITHIN PHILADELPHIA</td>
                          <td width="20%" align="center"><LABEL id=lblBPT_SchC1_6A style="WIDTH: 100%"></LABEL></td>
                          <td width="20%" class="no_border_right" align="center"></td>
                        </tr>
                        <tr class="odd">
                          <td>7.</td>
                          <td>Total average value of Property used EVERYWHERE</td>
                          <td width="20%" align="center"></td>
                          <td width="20%" class="no_border_right" align="center"><LABEL id=lblBPT_SchC1_7B style="WIDTH: 100%"></LABEL></td>
                        </tr>
                        
                         <tr class="even">
                        	<td colspan="4"><strong>Computation of Apportionment Factors: </strong></td>
                        </tr>
                        
                        <tr class="odd">
                          <td>8a.</td>
                          <td colspan="2"> Total Average Value of Philadelphia Property from Column A, Line 6 above <span class="text_right"></span></td>
                          <td width="20%" class="no_border_right" align="center"><LABEL id=lblBPT_SchC1_8A style="WIDTH: 100%"></LABEL>
                          <div class="clear"></div></td>
                   
                        </tr>
                        <tr class="even">
                          <td>8b.</td>
                          <td colspan="2">Total Average Value of Property Everywhere from Column B, Line 7 above<span class="text_right">&nbsp;</span></td>
                          <td width="20%" class="no_border_right" align="center"><LABEL id=lblBPT_SchC1_8B style="WIDTH: 100%"></LABEL>
                          <div class="clear"></div></td>
                        </tr>
                        <tr class="odd">
                          <td>8c.</td>
                          <td colspan="2">Philadelphia Property Factor <span class="text_right">[Calculated - Line 8a Divided by Line 8b]</span></td>
                          <td width="20%" class="no_border_right" align="center"><LABEL id=lblBPT_SchC1_8C style="WIDTH: 100%"></LABEL>
                          <div class="clear"></div></td>
                        </tr>
                        <tr class="even">
                          <td>9a.</td>
                          <td colspan="2">Philadelphia Payroll <span class="text_right">&nbsp;</span></td>
                          <td width="20%" class="no_border_right" align="center"><INPUT class="" id=txtBPT_SchC1_9A style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=13 onchange=ValidateWorksheet("BPT_SchdC1")>
                          <div class="clear"></div></td>
                        </tr>
                        <tr class="odd">
                          <td>9b.</td>
                          <td colspan="2">Payroll Everywhere <span class="text_right">&nbsp;</span></td>
                          <td width="20%" class="no_border_right" align="center"><INPUT class="" id=txtBPT_SchC1_9B style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=13 onchange=ValidateWorksheet("BPT_SchdC1")>
                          <div class="clear"></div></td>
                        </tr>
                      <tr class="even">
                          <td>9c.</td>
                          <td colspan="2">Philadelphia Payroll Factor  <span class="text_right">[Calculated - Line 9a Divided by Line 9b]</span></td>
                          <td width="20%" class="no_border_right" align="center"><LABEL id=lblBPT_SchC1_9C style="WIDTH: 100%"></LABEL>
                          <div class="clear"></div></td>
                        </tr>
                      <tr class="odd">
                        <td>10a.</td>
                        <td colspan="2">Philadelphia Receipts </td>
                        <td class="no_border_right" align="center">     <INPUT class="" id=txtBPT_SchC1_10A style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=13 onchange=ValidateWorksheet("BPT_SchdC1")>    </td>        
                      </tr>
                      <tr class="even">
                        <td>10b.</td>
                        <td colspan="2">Gross Receipts Everywhere</td>
                        <td class="no_border_right" align="center">    <INPUT class="" id=txtBPT_SchC1_10B style="WIDTH: 100%" 
				onfocus=SetFocus() maxLength=13 onchange=ValidateWorksheet("BPT_SchdC1")>  </td>            
                      </tr>
                      <tr class="odd">
                        <td>10c.</td>
                        <td colspan="2">Philadelphia Receipts Factor <span class="text_right">[Calculated - Line 10a Divided by Line 10b]</span></td>
                        <td class="no_border_right" align="center">  <LABEL id=lblBPT_SchC1_10C style="WIDTH: 100%"></LABEL>   </td>               
                      </tr>
                      <tr class="even">
                        <td>10d.</td>
                        <td colspan="2">Repeat Line 10c</td>
                        <td class="no_border_right" align="center">   <LABEL id=lblBPT_SchC1_10D style="WIDTH: 100%"> </td>                
                      </tr>
                      <tr class="odd">
                        <td>11.</td>
                        <td colspan="2">TOTAL FACTORS <span class="text_right">[Calculated - Sum Lines 8c, 9c, 10c and 10d]</span></td>
                        <td width="20%" class="no_border_right" align="center"><LABEL id=lblBPT_SchC1_11 style="WIDTH: 100%"></LABEL>
                          <div class="clear"></div></td>          
                      </tr>
                      <tr class="even">
                        <td>12.</td>
                        <td colspan="2">AVERAGE OF FACTORS <span class="text_right">[Calculated - Line 11 Divided by applicable number of factors] </span></td>
                        <td width="20%" class="no_border_right" align="center"><LABEL id=lblBPT_SchC1_12 style="WIDTH: 100%"></LABEL>
                          <div class="clear"></div></td>              
                      </tr>
                      <tr class="odd">
                          <tr >
                                            <td></td>
                                            <td colspan="3" align="right" class="no_border_right">
                                              
                               
                                 <input type="button" value="Return to Page 1" class="submit_button2" id="btnC1GoTo" onclick=ShowPage("Pg1") />
                       
                                             </td>
                                        </tr>

                    </tbody>
                </table>
                                <div class="clear"></div>

                            </div>--%>
   <%-- <div class="container-fluid no-padding">
    <div class="block3">
        
     <div class="container-fluid">--%>
     
    <%-- <div class="row">--%>

     <div class="col-lg-12 col-md-12" id="BPT_SchdC1" style="DISPLAY: none;">   
    
    
                <div class="row">
                	<h3>2015 BIRT SCHEDULE C-1: For business conducted in and out of Philadelphia</h3>
                	<div class="col-lg-12 templateclass">
                    
                        <%--<div class="well">
                            <div class="row">
                                
                                <div class="col-lg-12 templateclass">
                               	<h5 class="text-center">Important Change for Tax Year 2015</h5>
                                
                                <p>The Department has adopted a Single Sales/Receipts Factor Apportionment methodology for BIRT Tax Year 2015. The Property and Payroll Factors are no longer used in the calculation of the Philadelphia Apportionment percentage. The Single Sales/Receipts Factor Apportionment percentage is the ratio of Philadelphia Sales/Receipts to Total Sales/Receipts everywhere.</p>
                                <br>
                                <p>
                                The sourcing of sales/receipts is the same as it has been in prior years. Receipts and Taxable Receipts are defined at Philadelphia Code § 19-2601 and explained in Article III of the BIRT Regulations. 
                                </p>
                                <br>
                               
                                	<a href="#">http://www.phila.gov/Revenue/Regulations/BIRT%20Regulations%20Compilation.pdf</a>
                               
                                                                
                               </div>
							</div>
                            </div>--%>
                            
                            <div class="well">
                            <div class="row">
                                
                                <div class="col-lg-12 templateclass">
                               	<h5 class="text-center">Market-Based Sourcing of Service/Sales for Software Companies</h5>
                                
                                <p>A Software Company (as defined by BIRT Regulations Section 101DD) is to source sales/receipts (for both the Receipts and Net Income bases) in accordance with Market-based sourcing. That is, the sale of products and the performance of services will be deemed to be the location where the recipient receives the benefit of the products and services.</p>
                                                 
                               </div>
							</div>
                            </div>
                            
                            <div class="well">
                            <div class="row">
                                
                                <div class="col-lg-12 templateclass">
                               	<h5 class="text-center">This schedule must be completed in order to receive the deduction from Worksheet S.</h5>
                                                                                 
                               </div>
							</div>
                            </div>
                            
                             <div class="well">
                            <div class="row">
                                
                                <div class="col-lg-12 templateclass">
                               	<p>COMPUTATION OF APPORTIONMENT FACTOR TO BE APPLIED TO APPORTIONABLE NET INCOME. YOU MUST COMPLETE SCHEDULE C-1 IF YOU ARE APPORTIONING YOUR INCOME. FAILURE TO INCLUDE THIS SCHEDULE WITH YOUR RETURN MAY RESULT IN THE DISALLOWANCE OF YOUR APPORTIONMENT AND YOU MAY BE BILLED.</p>
                                                                                 
                               </div>
							</div>
                            </div>
                                
                            <div class="well">
                            <div class="row">
                            <div class="col-lg-12 templateclass">
                            <!-- Schedule C 1 Form -->
                        
                                <div class="table-responsive">
                                
                                	<table class="table table-condensed table-striped custom_table03">
                                    
                                    	
                                        
                                        <tbody>
                                        	
                                            <tr>
                                            	<td width="5%">1</td>
                                                <td width="70%" class="text-left">Philadelphia Sales/Receipts </td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">
                                
                                                        <div class="form-group no-margin">
                                                            <div class="input-group">
                                                             <input class="form-control input-sm" type="text" id="txtBPT_SchC1_1">  
                                                          	</div>
                                                          </div>
                                                    
                                                    </form>
                                                </td>
                                               
                                             </tr>
                                     		 <tr class="odd">
                                            	<td width="5%">2</td>
                                                <td width="70%" class="text-left">Gross Sales/Receipts Everywhere</td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">
                                
                                                        <div class="form-group no-margin">
                                                            <div class="input-group">
                                                             <input class="form-control input-sm" type="text" id="txtBPT_SchC1_2" onchange=ValidateWorksheet("BPT_SchdC1")> 
                                                          	</div>
                                                          </div>
                                                    
                                                    </form>
                                                </td>
                                                
                                             </tr>
                                              <tr>
                                            	<td width="5%">3</td>
                                                <td width="70%" class="text-left">Single Sales/Receipts Factor Apportionment Percentage (Line 1 divided by 2) </td>
                                                <td width="25%" class="text-left">
                                               		<form class="form-horizontal">
                                
                                                        <div class="form-group no-margin">
                                                            <div class="input-group">
                                                             <input class="form-control input-sm" type="text" id="lblBPT_SchC1_3" >  
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
                            <div class="row">
                                
                                <div class="col-lg-12 templateclass">
                               	<p>ENTER THE PHILADELPHIA RECEIPTS FACTOR APPORTIONMENT PERCENTAGE ON SCHEDULE A, LINE 8 OR SCHEDULE B, LINE 6.</p>
                                 <h5>DO NOT FILE THIS RETURN if Line 3 is equal to 100%. Use the BIRT-EZ return which is available at <a href="#">www.phila.gov/revenue.</a></h5>   
                                 <h5>Do not submit Schedule C-1 with the BIRT-EZ return.</h5>                                             
                               </div>
							</div>
                            </div>
                                
                                <form class="form-horizontal">
                                
                                	<div class="form-group">
                                        <div class="col-sm-offset-3 col-sm-9  text-right">
                                         <input type="button" value="Return to Page 1" class="submit_button2" id="btnC1GoTo" onclick=ShowPage("Pg1") />  </div>
                                      </div>
                                
                                </form>
                                <!-- Schedule C 1 Form END-->
                            </div>
                                
                           
             
                	
                    <div class="clearfix"></div>
                    
               
            
            </div>
             
 </div>
</body>
</html>
