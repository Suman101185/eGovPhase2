<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
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
    <script language="javascript">
        $(document).ready(function () {
            $('input').keyup(function (e) {

                var key = e.charCode ? e.charCode : e.keyCode ? e.keyCode : 0;
                if (key == 13) {
                    e.preventDefault();
                    return false;
                }

            });

            $('input').keydown(function (e) {

                var key = e.charCode ? e.charCode : e.keyCode ? e.keyCode : 0;
                if (key == 13) {

                    e.preventDefault();
                    return false;
                }

            });
           DisplayNPTReturn();
           $('input[type=text]').bind('keypress', function (event) {
              
               if (event.charCode > 31 && event.charCode != 45 && (event.charCode < 48 || event.charCode > 57)) {
                   return false;
               }
           });
        });
        </script>

     <style type="text/css">
        .disable-link {
            color:#cfcfcf;
        }
    </style>
    <title></title>
</head>
    <body>

<div class="container-fluid no-padding" id="NPT_2012" style="DISPLAY: none;">
<div class="block3">
 <div class="container-fluid">
   <div class="row">
    <div class="col-lg-12 col-md-12" style="display: block;" id="tab">
    <div  class="blue_base_box">
   
         <h2>Taxpayer Information  |   <span id="AppHeader"></span>  </h2>
     <div class="inner_white-panel">
          <div class="col-lg-12 col-lg-offset-0 no-padding-left">
            <div id="AppError" class="errormsg no-padding" style="display:block;">
            </div>
                </div>   
          <div class="contentsection">
        <h4 id="AppMessage">&nbsp;</h4>
         <div class="clearfix"></div>
          <br>
         <div class="row">

           <div class="col-lg-12">
                         <div class="pagePrint">
            <%-- Address Start--%>
                <div class="well"  id="NPT" style="DISPLAY: none; padding:0 5px !important; margin-bottom:0px !important;">
                     <div class="row">
                        <form>
                            <div class="col-lg-9 col-md-9 col-sm-9 col-xs-8">
                                <p><span>Name:</span>
                                <span id="lblName" ></span>
                            </p>
                                
                            </div>

                            <div class="col-lg-3 col-md-3 col-sm-3 col-xs-4">
                                <p>
                                     <span id="lblAccountType">Account No.:</span>
                                     <span id="lblAccountId" class=""></span>
                                </p>
                               
                            </div>

                        </form>
                    </div>
                  
                    <div class="row">
                        <div class="col-lg-9 col-md-9 col-sm-9 col-xs-8">
                            <p><span>Address:</span>
                                    <span id="lblAddress" ></span>
                                </p>
                        </div>
                            <div class="col-lg-3 col-md-3 col-sm-3 col-xs-4">
                                <p>
                                    <span id="lblEntityType">EIN:</span>
                                    <span id="lblEntityId" ></span>
                                </p>
                            </div>
                    </div>
                          
                    <div class="clearfix"></div>

                </div>  
            <%--  Adress End--%>   
               <div class="row">
               <div class="col-lg-12 templateclass">     
                    <div id="NPT_BPT_msg" style="DISPLAY: none;" VISIBILTY: visible" name="NPT_BPT_msg" align="center">
                                <br>
                                <br>
                                <br>
                                Your 2012 BIRT return must be filed prior to filing your 2012 NPT Return.<br>
                                To fill out your 2012 BIRT form, Please select BIRT from the side menu.
                            </div>
                    <div id="NPT_Page1" style="DISPLAY: none;" VISIBILTY: visible" name="NPT_Page1">
                 
                    <form class="form-horizontal">                     
                       <div class="row" style="display:none">
                            <div class="col-lg-12 no-padding">
                        <div class="col-lg-4 newtop_padding col-sm-12">
                            <label class="no-padding" style="font-weight: bold;">
                               <input id=chkChangeAddress type="checkbox"> &nbsp;If this is a change of address, check this box.</label>
                        </div>                      
                       
                         </div>
                        </div>
                             
                        <div class="row">
                            <div class="col-lg-12 no-padding">
                        <div class="col-lg-3 newtop_padding col-md-3 col-sm-3 col-xs-3">
                            <label class="no-padding" style="font-weight: bold;">
                                <input id=chkAmended type=checkbox onclick="chkAmended_onclick()" />
                                            Check if amended return.</label>
                        </div>
                                 
                             
                        <div class="col-sm-7 col-md-7 col-xs-7 newtop_padding">
                                <label class="control-label text-custom-left2" for="inputEmail3">
                                    <span class="pull-right">If your business terminated in 2012, enter the termination date here:</span>
                                                                   
                                </label>
                            </div>
                            <div class="col-sm-2 col-md-2 col-xs-2 newtop_padding custom-margin-npt" style="padding-left:0;">
                                 <input  class="inpNormal_custom date-input  date-field-design pull-right" id="txtTermDate" placeholder="MM/DD/YYYY" maxlength="10" style="WIDTH:100%;"
                                        onfocus="SetFocus()" onblur="return txtTermDate_onblur()"></div>                                                             
                     
                                <br /><br />
                                <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3"></div>
                        <div class="col-lg-7 col-md-7 col-sm-7 col-xs-7" style="padding-right:0 !important;">
                            <label class="control-label text-custom-left2 no-padding pull-left" for="inputEmail3">
                                <span class="custom_padding_span">If applicable,enter percentage from Worksheet D, Line 3: 
                                    <label id="lnkWrkD" class="lblLink label_NoLeft" onclick="if($(this).attr('disabled')!='disabled'){ShowPage('WrkD')}">Click here for Worksheet D</label>
                                 </span>
                                </label>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-2 col-xs-2">
                           
                             <label id="lblPercentage" class="form-control input-sm pull-right" style="WIDTH: 98%;"></label>
                        </div>
                                </div>
                        </div>
                        
                    
                </form>            

                     <div class="row">
                      <div class="col-lg-12" >
                        
                    <table summary="Employee Pay Sheet" class="table table-condensed table-striped custom_table03 wage-table-print no-mb">

                        <tbody>

                            <tr class="odd">
                                 <td width="5%">1.</td>
                                <td width="70%" class="text-left">Residents Taxable Income or Loss from Page 2, Worksheet A, Line 4
                                        <label id="lnkWrkA" class="lblLink label_NoLeft" onclick="if($(this).attr('disabled')!='disabled'){ShowPage('WrkA')}">Click here for Worksheet A</label>
                                </td>
                                <td style="width:25%;" class="text-left">                                   
                                    <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                            <label id="lblNPT1" class="form-control input-sm pull-right" style="WIDTH: 70%;"></label>
                                                            </div>
                                                          </div>
                                            
                                            		</div>
                                    </td>
                            </tr>
                            <tr>
                                 <td width="5%">2.</td>
                                <td width="70%" class="text-left"><label class="" id="msgNPT1_2" style="float:none;">Line 1 X ###</label></td>
                                <td style="width:25%;" class="text-left">
                                      
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                              <label id="lblNPT2" class="form-control input-sm pull-right" style="WIDTH: 70%;"></label>
                                                            </div>
                                                          </div>
                                            
                                            		</div>
                                </td>
                            </tr>
                            <tr class="odd">
                                 <td width="5%">3.</td>
                                <td width="70%" class="text-left">Non-Residents Taxable Income or Loss from Page 2, Worksheet B, Line 4 
                                        <label id="lnkWrkB" class="lblLink label_NoLeft"  onclick="if($(this).attr('disabled')!='disabled'){ShowPage('WrkB')}">Click here for Worksheet B</label>
                                </td>
                                <td style="width:25%;" class="text-left">
                                      
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                                <label id="lblNPT3" class="form-control input-sm pull-right" style="WIDTH: 70%;"></label>
                                                            </div>
                                                          </div>
                                            
                                            		</div>
                                    </td>
                            </tr>
                            <tr>
                                 <td width="5%">4.</td>
                                <td width="70%" class="text-left"><label class="" id="msgNPT1_4" style="float:none;">Line 3 X ###</label>&nbsp;</td>
                                <td style="width:25%;" class="text-left">
                                   
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                              <label id="lblNPT4" class="form-control input-sm pull-right" style="WIDTH: 70%;"></label>
                                                            </div>
                                                          </div>
                                            
                                            		</div>
                                </td>
                            </tr>
                            <tr class="odd">
                                 <td width="5%">5.</td>
                                <td width="70%" class="text-left">Tax Due(Line 2 plus Line 4)</td>
                                <td style="width:25%;" class="text-left">
                                   
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                             <label id="lblNPT5" class="form-control input-sm pull-right" style="WIDTH: 70%;"></label>
                                                            </div>
                                                          </div>
                                            
                                            		</div>
                                </td>
                            </tr>
                            <tr>
                                 <td width="5%">6a.</td>
                               <td width="70%" class="text-left">60% Business Income & Receipts Tax credit  </td>
                                 <td style="width:25%;" class="text-left">
                                   
                                       <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                             <label id="lblNPT6a" class="form-control input-sm pull-right" style="WIDTH: 70%;"> </label>
                                                            </div>
                                                          </div>
                                            
                                            		</div>
                                    </td>
                            </tr>
                            <tr class="odd">
                                 <td width="5%">6b.</td>
                                <td width="70%" class="text-left">Estimated payments and other credits from Worksheet E, Line 4
                                    <label id="lnkWrkE" class="lblLink label_NoLeft"  onclick="if($(this).attr('disabled')!='disabled'){ShowPage('WrkE')}">Click here for Worksheet E</label>
                                </td>
                                <td style="width:25%;" class="text-left">
                                   
                                    <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                            <label id="lblNPT6b" class="form-control input-sm pull-right" style="WIDTH: 70%;"> </label>
                                                            </div>
                                                          </div>
                                            
                                            		</div>
                                </td>
                            </tr>
                            <tr>
                                 <td width="5%">6c.</td>
                                <td width="70%" class="text-left">Total payments and credits(Line 6a plus Line 6b)</td>
                                <td style="width:25%;" class="text-left">
                                       
                                      <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                           <label id="lblNPT6c" class="form-control input-sm pull-right" style="WIDTH: 70%;"></label>
                                                            </div>
                                                          </div>
                                            
                                            		</div>
                                </td>
                            </tr>
                            <tr class="odd">
                                 <td width="5%">7.</td>
                                <td width="70%" class="text-left">Net Tax Due(Line 5 minus Line 6c) </td>
                                <td style="width:25%;" class="text-left">
                               
                                      <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                           <label id="lblNPT7" class="form-control input-sm pull-right" style="WIDTH: 70%;"></label>
                                                            </div>
                                                          </div>
                                            
                                            		</div>
                                </td>
                            </tr>
                            <tr>
                                 <td width="5%">8.</td>
                                <td width="70%" class="text-left">Interest and Penalty <a href="https://beta.phila.gov/services/payments-assistance-taxes/paying-city-taxes/interest-penalties-and-fees/" target="_blank" style="color:red">(see Instruction)</a></td>
                                <td style="width:25%;" class="text-left">
                                   
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                          <input class="form-control input-sm pull-right" style="WIDTH: 70%;" id="txtNPT8"/>
                                                            </div>
                                                          </div>
                                            
                                            		</div>
                                </td>
                            </tr>
                            <tr class="odd">
                                 <td width="5%">9.</td>
                                <td width="70%" class="text-left"><u>TOTAL DUE</u> including Interest and Penalty (Line 7 plus Line 8)</td>
                                <td style="width:25%;" class="text-left">
                                  
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                           <label id="lblNPT9" class="form-control input-sm pull-right" style="WIDTH: 70%;"></label>
                                                            </div>
                                                          </div>
                                            
                                            		</div> 
                                </td>
                            </tr>
                            <tr >
                                 <td width="5%">10.</td>
                                <td width="70%" class="text-left">Tax Overpaid. (Line 6c is greater than Line 5)</td>
                                <td style="width:25%;" class="text-left">
                                       
                                    <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                           <label id="lblNPT10" class="form-control input-sm pull-right" style="WIDTH: 70%;"></label>
                                                            </div>
                                                          </div>
                                            
                                            		</div> 
                                </td>
                            </tr>
                            <tr class="odd">
                                 <td width="5%">11.</td>
                                <td width="70%" class="text-left">Enter 50% of Worksheet C, Line 3.<br><b>This line is <u>not</u> used to remit estimated payments</b>
                                    <label id="lnkWrkC" class="lblLink label_NoLeft"  onclick="if($(this).attr('disabled')!='disabled'){ShowPage('WrkC')}">Click here for Worksheet C</label>
                                </td>
                                <td style="width:25%;" class="text-left">
                                    
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                      <label id="lblNPT11" class="form-control input-sm pull-right" style="WIDTH: 70%;"></label>
                                                            </div>
                                                          </div>
                                            
                                            		</div> 
                                </td>
                            </tr>
                            <tr >
                                 <td width="5%">12.</td>
                                <td width="70%" class="text-left"><b><u>OVERPAYMENT OPTIONS</u></b> If Line 10 is greater than Line 11,enter the amount to be:</td>
                                <td style="width:25%;">
                                               	
                                </td>
                            </tr>
                            <tr class="odd">
                                 <td width="5%">A.</td>
                                <td width="70%" class="text-left"><label  id=msgTobaccoNo3d style="WIDTH: 100%"/>Refunded. Do not file a separate refund petition</td>
                                <td style="width:25%;" class="text-left">
                                   
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                          <input type="text" class="form-control input-sm pull-right" style="WIDTH: 70%;" id="txtNPT12a" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="10" >
                                                            </div>
                                                          </div>
                                            
                                            		</div> 
                                </td>
                            </tr>
                            <tr>
                                 <td width="5%">B.</td>
                                <td width="70%" class="text-left">Applied, up to the tax due, to the <script>document.write(sCurrYear - 1)</script> Business Income & Receipts Tax Return</td>
                                <td style="width:25%;" class="text-left">
                                   
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                         <input type="text" class="form-control input-sm pull-right" style="WIDTH: 70%;" id="txtNPT12b" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="10" >
                                                            </div>
                                                          </div>
                                            
                                            		</div> 
                                </td>
                            </tr>
                            <tr class="odd">
                                 <td width="5%">C.</td>
                                <td width="70%" class="text-left">Applied to the <script>document.write(sCurrYear)</script> Net Profits Tax</td>
                                <td style="width:25%;" class="text-left">
                                       
                                      <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                        <input type="text" class="form-control input-sm pull-right" style="WIDTH: 70%;"  id="txtNPT12c" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="10" >
                                                            </div>
                                                          </div>
                                            
                                            		</div> 
                                </td>
                            </tr>

                                        
                        </tbody>
                    </table>
                         
                    <div class="clear"></div>
                    </div>
                     </div>
                     <form class="form-horizontal form-year-background" style="padding:0 5px;">
                    <div> 
                        <%Html.RenderAction("PreparerSection", "INC");%>
                    </div>
                     <div class="form-group page-print-wage-section">
                      <div class="col-sm-offset-3 col-sm-9  text-right">
                    <input id="btnNPTPrint" type="button" value="Print" class="btn btn-default submit_button_light" onclick="return btnNPTPrint_onclick()" />
                    <input type="button" value="Submit" class="btn btn-default submit_button" id="btnNPTSubmit" onclick="return btnNPTSubmit_onclick()" />
                    </div>
                  </div> 
                         <div style="margin-left: 5px; margin-top:-8px; font-size:12px;" class="here_input_table">
                  <label style="margin-top:10px;">
                                                            Note: DO NOT FILE THIS RETURN if you have no taxable activity. If you registered for 
				this tax and you no longer have taxable activity, complete a 
				<a href="../PDF/Change_Form.pdf" target="_blank">Change Form</a> to cancel
				your account.</label>
                 </div>                         
                    </form>     

                </div>
                   </div>
                   </div></div>

                <div class="row">
                   <div class="col-lg-12 templateclass">

                <%Html.RenderAction("_12WrkA", "NPT"); %>
                <%Html.RenderAction("_12WrkB", "NPT"); %>
                <%Html.RenderAction("_12WrkC", "NPT"); %> 
                <%Html.RenderAction("_12WrkD", "NPT");%>
                <%Html.RenderAction("_12WrkE", "NPT"); %>
                <%Html.RenderAction("_12WrkK", "NPT");%>
                <%Html.RenderAction("_12Page4", "NPT");%>
                <%Html.RenderAction("_12WrkExtension", "NPT");%>
                <%Html.RenderAction("_NPT_ExemptedMsg", "NPT"); %>
                </div>
                </div>
              </div>
             <div class="clearfix"></div>
          </div>                  
                          
      </div>
     </div>
    </div>
     <div class="clearfix"></div>
    </div>
    </div>
  </div>            
   
</div>

</div>
   
</body>
</html>
