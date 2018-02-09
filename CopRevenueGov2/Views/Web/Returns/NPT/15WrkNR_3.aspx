﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>   
   <script language="javascript" type="text/javascript">
       $(document).ready(function () {
           LoadError("Page4");
       });
        </script> 
    <title></title>
</head>
<body>
    <div id="NPT_Page4" class="form-group" style="DISPLAY: none;  VISIBILTY: hidden"  Name="NPT_Page4">
        <div class="well">
   <div class="row">
                    <div class="col-lg-12 templateclass">
                	<h3> 		
                <p>
          <b> <U>Worksheet NR-3:</U> Computation of apportionment factors to be
    applied to apportionable net income of certain <u>non-residents</u> of Philadelphia. </b></p></h3>
                	
                   <div class="table-responsive">
                                
                    <table class="table table-condensed table-striped custom_table03 wage-table-print">
                                    
                        <thead>
                                        	
                            <tr>
                                <th colspan="2" width="60%" class="odd">Calculation of Average Values of Real and Tangible Property
Used in Business:</th>
                                <th width="20%" class="text-center">Column A<br> Philadelphia</th>
                                <th width="20%" class="text-center">Column B<br>Total Everywhere</th>
                            </tr>
                                            
                                        
                        </thead>
                                        
                        <tbody>
                                        	
                            <tr>
                                <td width="5%">1.</td>
                                <td width="45%" class="text-left">Inventories of Raw Materials, Work in Process and Finished Goods.</td>
                                <td width="25%" class="text-left">
                                    <form class="form-horizontal">
                                
                                <div class="form-group no-margin">
                                    <div class="">
                                                     
                                    <input type="text" class="form-control input-sm pull-right" style="WIDTH: 70%;" id="txtNPT_Page4_1a" onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("Page4")'/>
                                    </div>
                                    </div>
                                            
                            </form>
                                </td>
                                <td width="25%">
                                    <form class="form-horizontal">
                                
                                <div class="form-group no-margin">
                                    <div class="">
                                    <input type="text" class="form-control input-sm pull-right" style="WIDTH: 70%;" id="txtNPT_Page4_1b" onfocus="SetFocus()" maxLength=10  onchange='ValidateWorksheet("Page4")'/>  </div>
                                    </div>
                                            
                            </form>
                                </td>
                                </tr>
                            <tr class="odd">
                                <td width="5%">2.</td>
                                <td width="45%" class="text-left">Land & Building Owned (At average original cost).</td>
                                <td width="25%" class="text-left">
                                    <form class="form-horizontal">
                                
                                <div class="form-group no-margin">
                                    <div class="">
                                                    
                                        <input type="text" class="form-control input-sm pull-right" style="WIDTH: 70%;" id="txtNPT_Page4_2a"  onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("Page4")'/>
                                    </div>
                                    </div>
                                            
                            </form>
                                </td>
                                <td width="25%">
                                    <form class="form-horizontal">
                                
                                <div class="form-group no-margin">
                                    <div class="">
                                        <input type="text" class="form-control input-sm pull-right" style="WIDTH: 70%;" id="txtNPT_Page4_2b"  onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("Page4")'/>

                                    </div>
                                    </div>
                                            
                            </form>
                                </td>
                            </tr>
                            <tr>
                                <td width="5%">3.</td>
                                <td width="45%" class="text-left">Machinery & Equipment Owned (At average original cost).</td>
                                <td width="25%" class="text-left">
                                    <form class="form-horizontal">
                                
                                <div class="form-group no-margin">
                                    <div class="">
                                                     
                                        <input type="text" class="form-control input-sm pull-right" style="WIDTH: 70%;" id="txtNPT_Page4_3a"  onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("Page4")'/>
                                    </div>
                                    </div>
                                            
                            </form>
                                </td>
                                <td width="25%">
                                    <form class="form-horizontal">
                                
                                <div class="form-group no-margin">
                                    <div class="">
                                                    
                                        <input type="text" class="form-control input-sm pull-right" style="WIDTH: 70%;" id="txtNPT_Page4_3b"  onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("Page4")'/>
                                    </div>
                                    </div>
                                            
                            </form>
                                </td>
                                </tr>
                            <tr class="odd">
                                <td width="5%">4.</td>
                                <td width="45%" class="text-left">Other Tangible Assets Owned (At average original cost). </td>
                                <td width="25%" class="text-left">
                                    <form class="form-horizontal">
                                
                                <div class="form-group no-margin">
                                    <div class="">
                                    <input type="text" class="form-control input-sm pull-right" style="WIDTH: 70%;" id="txtNPT_Page4_4a"  onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("Page4")'/>

                                    </div>
                                    </div>
                                            
                            </form>
                                </td>
                                <td width="25%">
                                    <form class="form-horizontal">
                                
                                <div class="form-group no-margin">
                                    <div class="">
                                    <input type="text" class="form-control input-sm pull-right" style="WIDTH: 70%;" id="txtNPT_Page4_4b"  onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("Page4")'/>

                                    </div>
                                    </div>
                                            
                            </form>
                                </td>
                            </tr>
                            <tr>
                                <td width="5%">5.</td>
                                <td width="45%" class="text-left">Rented Property (At 8 times the net annual rental).</td>
                                <td width="25%" class="text-left">
                                    <form class="form-horizontal">
                                
                                <div class="form-group no-margin">
                                    <div class="">
                                    <input type="text" class="form-control input-sm pull-right" style="WIDTH: 70%;" id="txtNPT_Page4_5a"  onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("Page4")'/>

                                    </div>
                                    </div>
                                            
                            </form>
                                </td>
                                <td width="25%">
                                    <form class="form-horizontal">
                                
                                <div class="form-group no-margin">
                                    <div class="">
                                        <input type="text" class="form-control input-sm pull-right" style="WIDTH: 70%;" id="txtNPT_Page4_5b"  onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("Page4")'/>

                                    </div>
                                    </div>
                                            
                            </form>
                                </td>
                                </tr>
                            <tr class="odd">
                                <td width="5%">6.</td>
                                <td width="45%" class="text-left">Total average value of property used <b>WITHIN PHILADELPHIA</b>. </td>
                                <td width="25%" class="text-left">
                                    <form class="form-horizontal">
                                
                                <div class="form-group no-margin">
                                    <div class="">                                                    
                                        <LABEL class="form-control input-sm pull-right" style="WIDTH: 70%;" id="lblNPT_Page4_6a" ></LABEL>
                                    </div>
                                    </div>
                                            
                            </form>
                                </td>
                                <td width="25%">
                                    <form class="form-horizontal">
                                
                                <div class="form-group no-margin">
                                    <div class="">
                                        <LABEL class="pull-right" id="lblNPT_Page4_6b" >XXXXXXXXXX</LABEL>
                                    </div>
                                    </div>
                                            
                            </form>
                                </td>
                            </tr>
                            <tr>
                                <td width="5%">7.</td>
                                <td width="45%" class="text-left">Total average value of property used <b>EVERYWHERE</b>.</td>
                                <td width="25%" class="text-left">
                                    <form class="form-horizontal">
                                
                                <div class="form-group no-margin">
                                    <div class="">                                                    
                                        <LABEL class="pull-right" id="lblNPT_Page4_7a" >XXXXXXXXXX</LABEL>
                                    </div>
                                    </div>
                                            
                            </form>
                                </td>
                                <td width="25%">
                                    <form class="form-horizontal">
                                
                                <div class="form-group no-margin">
                                    <div class="">
                                    <LABEL class="form-control input-sm pull-right" style="WIDTH: 70%;" id="lblNPT_Page4_7b" ></LABEL>

                                    </div>
                                    </div>
                                            
                            </form>
                                </td>
                                </tr>
                                        
                        </tbody>
                                        
                        <thead>
                                        	
                            <tr>
                                <th colspan="4" width="100%" ><strong>Computation of Apportionment Factors: </strong></th>
                                       
                            </tr>
                                            
                                        
                        </thead>
                                        
                        <tbody>
                                        	
                            <tr>
                                <td width="5%">8a.</td>
                                <td width="70%" class="text-left">Total Average Value of Philadelphia Property from Column A, Line 6 above</td>
                                
                                <td width="25%">
                                    <form class="form-horizontal">
                                
                                <div class="form-group no-margin">
                                    <div class="">
                                                  
                                        <LABEL id="lblNPT_Page4_8a" class="form-control input-sm pull-right" style="WIDTH: 70%;"></LABEL>
                                    </div>
                                    </div>
                                            
                            </form>
                                </td>
                                </tr>
                            <tr class="odd">
                                <td width="5%">8b.</td>
                                <td width="70%" class="text-left">Total Average Value of Property Everywhere from Column B, Line 7 above </td>
                               
                                <td width="25%">
                                    <form class="form-horizontal">
                                
                                <div class="form-group no-margin">
                                    <div class="">
                                    <LABEL id="lblNPT_Page4_8b" class="form-control input-sm pull-right" style="WIDTH: 70%;"></LABEL> </div>
                                    </div>
                                            
                            </form>
                                </td>
                            </tr>
                            <tr>
                                <td width="5%">8c.</td>
                                <td width="70%" class="text-left">Philadelphia Property Factor   [Calculated - Line 8a Divided by Line 8b] </td>
                                
                                <td width="25%">
                                    <form class="form-horizontal">
                                
                                <div class="form-group no-margin">
                                    <div class="">
                                                     
                                        <LABEL id="lblNPT_Page4_8c" class="form-control input-sm pull-right" style="WIDTH: 70%;"></LABEL>
                                    </div>
                                    </div>
                                            
                            </form>
                                </td>
                                </tr>
                            <tr class="odd">
                                <td width="5%">9a.</td>
                                <td width="70%" class="text-left">Philadelphia Payroll</td>
                                
                                <td width="25%">
                                    <form class="form-horizontal">
                                
                                <div class="form-group no-margin">
                                    <div class="">                                                    
                                        <input  type="text" class="form-control input-sm pull-right" style="WIDTH: 70%;" id="txtNPT_Page4_9a"  onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("Page4")'/>
                                    </div>
                                    </div>
                                            
                            </form>
                                </td>
                            </tr>
                            <tr>
                                <td width="5%">9b.</td>
                                <td width="70%" class="text-left">Payroll Everywhere</td>
                                
                                <td width="25%">
                                    <form class="form-horizontal">
                                
                                <div class="form-group no-margin">
                                    <div class="">                                                     
                                            <input type="text" class="form-control input-sm pull-right" style="WIDTH: 70%;" id="txtNPT_Page4_9b"  onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("Page4")'/>
                                    </div>
                                    </div>
                                            
                            </form>
                                </td>
                                </tr>
                            <tr class="odd">
                                <td width="5%">9c.</td>
                                <td width="70%" class="text-left">Philadelphia Payroll Factor   [Calculated - Line 9a Divided by Line 9b] </td>
                                
                                <td width="25%">
                                    <form class="form-horizontal">
                                
                                <div class="form-group no-margin">
                                    <div class="">                                                   
                                                       
                                        <LABEL class="form-control input-sm pull-right" style="WIDTH: 70%;" id="lblNPT_Page4_9c" ></LABEL>
                                    </div>
                                    </div>
                                            
                            </form>
                                </td>
                            </tr>
                            <tr>
                                <td width="5%">10a.</td>
                                <td width="70%" class="text-left">Philadelphia Receipts before BIR Statutory Exclusion </td>
                                
                                <td width="25%">
                                    <form class="form-horizontal">
                                
                                <div class="form-group no-margin">
                                    <div class="">
                                    <input type="text" class="form-control input-sm pull-right" style="WIDTH: 70%;" id="txtNPT_Page4_10a"  onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("Page4")'/>
                                                    
                                    </div>
                                    </div>
                                            
                            </form>
                                </td>
                                </tr>                                   
                                         

                            <tr>
                                <td width="5%">10b.</td>
                                <td width="70%" class="text-left">Gross Receipts Everywhere </td>
                                
                                <td width="25%">
                                    <form class="form-horizontal">
                                
                                <div class="form-group no-margin">
                                    <div class="">
                                        <input type="text" class="form-control input-sm pull-right" style="WIDTH: 70%;" id="txtNPT_Page4_10b"  onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("Page4")'/>
                                                    
                                    </div>
                                    </div>
                                            
                            </form>
                                </td>
                                </tr>

                            <tr>
                                <td width="5%">10c.</td>
                                <td width="70%" class="text-left">Philadelphia Receipts Factor   [Calculated - Line 10a Divided by Line 10b]  </td>
                                
                                <td width="25%">
                                    <form class="form-horizontal">
                                
                                <div class="form-group no-margin">
                                    <div class="">
                                    <LABEL id="lblNPT_Page4_10c" class="form-control input-sm pull-right" style="WIDTH: 70%;"></LABEL>  
                                    </div>
                                    </div>
                                            
                            </form>
                                </td>
                                </tr>                                                                    
                            <tr>
                                <td width="5%">11.</td>
                                <td width="70%" class="text-left">TOTAL FACTORS    [Calculated - Sum Lines 8c, 9c, 10c ]</td>
                                
                                <td width="25%">
                                    <form class="form-horizontal">
                                
                                <div class="form-group no-margin">
                                    <div class="">
                                    <LABEL id="lblNPT_Page4_11" class="form-control input-sm pull-right" style="WIDTH: 70%;"></LABEL>  
                                    </div>
                                    </div>
                                            
                            </form>
                                </td>
                                </tr>

                            <tr>
                                <td width="5%">12.</td>
                                <td width="70%" class="text-left">Philadelphia apportionment factor<br /> Enter factor on Worksheet B, Line 5 [Calculated - Line 11 Divided by applicable number of factors] </td>
                                
                                <td width="25%">
                                    <form class="form-horizontal">
                                
                                <div class="form-group no-margin">
                                    <div class="">
                                    <LABEL id="lblNPT_Page4_12" class="form-control input-sm pull-right" style="WIDTH: 70%;"></LABEL>  
                                    </div>
                                    </div>
                                            
                            </form>
                                </td>
                                </tr>
                            
                        </tbody>
                                    
                    </table>

                </div>                               
                                
                <form class="form-horizontal">
                                
                    <div class="form-group">
                        <div class="col-sm-offset-3 col-sm-9  text-right">                                     
                                <input  id="btnNRGoToPage1" onclick="ShowPage('WrkB', 'Page4')" class="btn btn-default submit_button" type="button" value="Return to Worksheet B">
                            </div>
                        </div>
                                
                </form>
                                
  </div>
                	
                   
                    
            
            </div>          
            
</div>
    </div>
</body>
</html>
