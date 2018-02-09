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
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script language="javascript">
        $(document).ready(function () {
            DisplayNPTReturn();
        });
        </script>
    <title></title>
</head>
    <body>
<%--<body onload="DisplayNPTReturn()">--%>
<div class="container-fluid no-padding" id="NPT_2015" style="DISPLAY: none;">
<div class="block3">
 <div class="container-fluid">
   <div class="row">
    <div class="col-lg-12 col-md-12">
    <div style="display: block;" id="tab1" class="blue_base_box">
    <h2 id="AppHeader">  </h2>

     <div class="inner_white-panel">
          <div class="contentsection">
        <h4 id="AppMessage">&nbsp;</h4>
         <div class="clearfix"></div>
          <br>
         <div class="row">

           <div class="col-lg-12">
                         
            <%-- Address Start--%>
                <div class="well"  id="NPT" style="DISPLAY: none;">

                    <div class="row">                                                   
                            <div class="col-lg-4">
                                <p><strong>Name :</strong>
                                    <label id="id=lblName_08" class="lblTextBlack"></label>
                                </p>
                            </div>

                            <div class="col-lg-4">
                                <p><strong><font id="lblAccountType">Account No.:</font></strong>
                                    <label id="lblAccountId" class="lblTextBlack"></label>
                                </p>
                            </div>                                                   
                    </div>
                    <div class="row">
                        <div class="col-lg-4">
                            <p><strong>Address :</strong>
                                <label id="lblAddress" class="lblTextBlack"></label>
                            </p>
                        </div>
                            <div class="col-lg-4">
                                <p><strong><font id="lblEntityType">EIN :</font></strong>
                                    <label id="lblEntityId" class="lblTextBlack"></label>
                                </p>
                            </div>
                    </div>
                          <div class="row">
                            <div class="col-lg-8">
                                <p><strong>Taxpayer E-mail Address :</strong>
                                    <label id="lblEmaillAddress" class="lblTextBlack"></label>
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
                                Your 2015 BIRT return must be filed prior to filing your 2015 NPT Return.<br>
                                To fill out your 2015 BIRT form, Please select BIRT from the side menu.
                            </div>
                    <div id="NPT_Page1" style="DISPLAY: none;" VISIBILTY: visible" name="NPT_Page1">
                 
                    <form class="form-horizontal school_form">   
                         <div class="row">
                            <div class="col-lg-12">
                        <div class="col-lg-4 newtop_padding col-sm-12">
                            <label class="radio no-padding" style="font-weight: bold;">
                               <input id=chkChangeAddress type="checkbox"> &nbsp;If this is a change of address, check this box.</label>
                        </div>                      
                       
                         </div>
                        </div>
                             
                        <div class="row">
                            <div class="col-lg-12">
                        <div class="col-lg-3 newtop_padding col-sm-12">
                            <label class="radio no-padding" style="font-weight: bold;">
                                <input id=chkAmended type=checkbox onclick="chkAmended_onclick()" />
                                            Check if amended return.</label>
                        </div>
                        <div class="col-lg-6 col-sm-12">
                            <label class="control-label text-custom-left2 no-padding pull-right" for="inputEmail3">
                                <span class="custom_padding_span"> Percentage from Page 3, Worksheet D, Line 3, if applicable.  
                                    <label id="lnkWrkD" class="lblLink label_NoLeft" onclick="if($(this).attr('disabled')!='disabled'){ShowPage('WrkD')}">Click for Worksheet D</label>
                                 </span>
                                </label>
                        </div>
                        <div class="col-lg-3 col-sm-12 no-padding">
                             <input class="form-control input-sm" id="txtPercentage" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="3">                           
                        </div>
                                </div>
                        </div>
                        <div class="row" style="margin-bottom:15px; margin-top:15px;">
                            <div class="col-lg-12">
                        <div class="col-lg-9">
                            <label class="control-label text-custom-left2" for="inputEmail3">
                                <span class="pull-left">If your business terminated in 2015, enter the termination date AND file a CHANGE FORM. </span>
                                                                   
                            </label>
                        </div>
                        <div class="col-lg-3 no-padding">
                           <input class="form-control input-sm" id="txtTermDate" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="10" onblur="return txtTermDate_onblur()">
                        </div>
                        </div>
                        </div>
                         
                </form>            

                     <div class="row">
                      <div class="col-lg-12" >
                          <div class="table-responsive">
                    <table summary="Employee Pay Sheet" class="table table-condensed table-striped custom_table03">

                        <tbody>
                           
                            <tr class="odd">
                                <td width="70%" class="text-left"><b>1. Pro Rata Resident taxable income/loss NOT eligible for Income Based Rate from Page 2, Worksheet A, Line 5</b>
                                        <label id="lnkWrkA" class="lblLink label_NoLeft" onclick="if($(this).attr('disabled')!='disabled'){ShowPage('WrkA')}">Click here for Worksheet A</label>
                                </td>
                                <td style="width:25%;" class="text-left">                                   
                                    <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                             <input class="form-control input-sm table_custom_input"  id="txtNPT1" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="10" >
                                                            </div>
                                                          </div>
                                            
                                            		</div>
                                    </td>
                            </tr>
                            <tr>
                                <td class="text-left">2.  <label class="" id="msgNPT1_2" style="float:none;">Line 1 X .039102. If Line 1 is a loss, enter "0"</label></td>
                                <td style="width:25%;" class="text-left">
                                      
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                              <label id="lblNPT2" style="WIDTH: 100%"></label>
                                                            </div>
                                                          </div>
                                            
                                            		</div>
                                </td>
                            </tr>
                            <tr class="odd">
                                
                                <td width="70%" class="text-left">3.Pro Rata Resident taxable income/loss eligible for Income Based Rate from Page 2, Worksheet A, Line 6
                                        <label id="lnkWrkB" class="lblLink label_NoLeft"  onclick="if($(this).attr('disabled')!='disabled'){ShowPage('WrkA')}">Click here for Worksheet A</label>
                                </td>
                                <td style="width:25%;" class="text-left">
                                      
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                               <input class="form-control input-sm table_custom_input" id="txtNPT3" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="10" >
                                                            </div>
                                                          </div>
                                            
                                            		</div>
                                    </td>
                            </tr>
                            <tr>
                                <td class="text-left">4.   <label class="" id="msgNPT1_4" style="float:none;">Line 3 X .034102. If Line 3 is a loss, enter "0"</label>&nbsp;</td>
                                <td style="width:25%;" class="text-left">
                                   
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                              <label id="lblNPT4" style="WIDTH: 100%"></label>
                                                            </div>
                                                          </div>
                                            
                                            		</div>
                                </td>
                            </tr>
                            <tr class="odd">
                                <td width="70%" class="text-left">5. Total Resident Tax Due (Line 2 plus Line 4)</td>
                                <td style="width:25%;" class="text-left">
                                   
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                             <label id="lblNPT5" style="WIDTH: 100%"></label>
                                                            </div>
                                                          </div>
                                            
                                            		</div>
                                </td>
                            </tr>
                            <tr>
                                <td class="text-left"><b>6. Pro Rata Non-Resident taxable income/loss NOT eligible for Income Based Rate from Page 2, Worksheet B, Line 7</b>
                                    <label id="Label1" class="lblLink label_NoLeft"  onclick="if($(this).attr('disabled')!='disabled'){ShowPage('WrkB')}">Click here for Worksheet B</label></td>
                                <td style="width:25%;" class="text-left">
                                   
                                       <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                             <label id="lblNPT6" style="WIDTH: 100%"> </label>
                                                            </div>
                                                          </div>
                                            
                                            		</div>
                                    </td>
                            </tr>                         
                            <tr class="odd">
                                <td width="70%" class="text-left">7. Line 6 X .034828. If Line 6 is a loss, enter "0" </td>
                                <td style="width:25%;" class="text-left">
                               
                                      <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                           <label id="lblNPT7" style="WIDTH: 100%"></label>
                                                            </div>
                                                          </div>
                                            
                                            		</div>
                                </td>
                            </tr>
                            <tr>
                                <td class="text-left">8. Pro Rata Non-Resident taxable income/loss eligible for Income Based Rate from Page 2, Worksheet B, Line 8
                                    <label  class="lblLink label_NoLeft"  onclick="if($(this).attr('disabled')!='disabled'){ShowPage('WrkB')}">Click here for Worksheet B</label>
                                </td>
                                <td style="width:25%;" class="text-left">
                                   
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                        <%--  <input class="form-control input-sm" id="txtNPT8" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="10" >--%>
                                                                  <label id="lblNPT8" style="WIDTH: 100%"></label>
                                                            </div>
                                                          </div>
                                            
                                            		</div>
                                </td>
                            </tr>
                            <tr class="odd">
                                <td width="70%" class="text-left">9. Line 8 X .029828.<b>If Line 8 is a loss, enter "0"</b></td>
                                <td style="width:25%;" class="text-left">
                                  
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                           <label id="lblNPT9" style="WIDTH: 100%"></label>
                                                            </div>
                                                          </div>
                                            
                                            		</div> 
                                </td>
                            </tr>
                            <tr >
                                <td width="70%" class="text-left">10. Total Non-Resident Tax Due (Line 7 plus Line 9)</td>
                                <td style="width:25%;" class="text-left">
                                       
                                    <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                           <label id="lblNPT10" style="WIDTH: 100%"></label>
                                                            </div>
                                                          </div>
                                            
                                            		</div> 
                                </td>
                            </tr>
                            <tr class="odd">
                                <td class="text-left">11. Total Tax Due (Line 5 plus Line 10)</td>
                                <td style="width:25%;" class="text-left">
                                    
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                                 <label id="lblNPT11" style="WIDTH: 100%"></label>
                                                         <%-- <input class="form-control input-sm" id="txtNPT11" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="10">--%>
                                                            </div>
                                                          </div>
                                            
                                            		</div> 
                                </td>
                            </tr>
                             <tr class="odd">
                                <td class="text-left">12a. 60% BIRT credit from Page 3, Worksheet K, Line 4 or Worksheet D, Line 8
                                    <label  class="lblLink label_NoLeft"  onclick="if($(this).attr('disabled')!='disabled'){ShowPage('WrkK')}">Click here for Worksheet K</label> /
                                    <label  class="lblLink label_NoLeft" onclick="if($(this).attr('disabled')!='disabled'){ShowPage('WrkD')}">Click here for Worksheet D</label>
                                </td>
                                <td style="width:25%;" class="text-left">
                                    
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                                <label id="lblNPT12a" style="WIDTH: 100%"></label>
                                                         <%-- <input class="form-control input-sm" id="txtNPT12a" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="10">--%>
                                                            </div>
                                                          </div>
                                            
                                            		</div> 
                                </td>
                            </tr>
                             <tr class="odd">
                                <td class="text-left">12b. Estimated payments and other credits from Page 3, Worksheet E, Line 4
                                    <label id="lnkWrkE" class="lblLink label_NoLeft"  onclick="if($(this).attr('disabled')!='disabled'){ShowPage('WrkE')}">Click here for Worksheet E</label>
                                </td>
                                <td style="width:25%;" class="text-left">
                                    
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                                <label id="lblNPT12b" style="WIDTH: 100%"></label>
                                                          <%--<input class="form-control input-sm" id="txtNPT12b" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="10">--%>
                                                            </div>
                                                          </div>
                                            
                                            		</div> 
                                </td>
                            </tr>
                             <tr class="odd">
                                <td class="text-left">12c. Total payments and credits. (Line 12a plus Line 12b)</td>
                                <td style="width:25%;" class="text-left">
                                    
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                                <label id="lblNPT12c" style="WIDTH: 100%"></label>
                                                          <%--<input class="form-control input-sm" id="txtNPT12c" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="10">--%>
                                                            </div>
                                                          </div>
                                            
                                            		</div> 
                                </td>
                            </tr>
                             <tr class="odd">
                                <td class="text-left">13.Net Tax Due: (Line 11 less Line 12c. If less than 0 enter the difference on Line 16</td>
                                <td style="width:25%;" class="text-left">
                                    
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                                <label id="lblNPT13" style="WIDTH: 100%"></label>
                                                          <%--<input class="form-control input-sm" id="txtNPT13" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="10">--%>
                                                            </div>
                                                          </div>
                                            
                                            		</div> 
                                </td>
                            </tr>
                             <tr class="odd">
                                <td class="text-left">14. Interest and Penalty. Refer to web site for current percentage</td>
                                <td style="width:25%;" class="text-left">
                                    
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                          <input class="form-control input-sm table_custom_input" id="txtNPT14" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="10">
                                                            </div>
                                                          </div>
                                            
                                            		</div> 
                                </td>
                            </tr>
                             <tr class="odd">
                                <td class="text-left">15. <b><u>TOTAL DUE</u></b> including Interest and Penalty (Line 13 plus Line 14).<br />
<b>Use payment coupon. Make check payable to: "City of Philadelphia"</b></td>
                                <td style="width:25%;" class="text-left">
                                    
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                                <label id="lblNPT15" style="WIDTH: 100%"></label>
                                                          <%--<input class="form-control input-sm" id="txtNPT15" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="10">--%>
                                                            </div>
                                                          </div>
                                            
                                            		</div> 
                                </td>
                            </tr>
                             <tr class="odd">
                                <td class="text-left">16. Tax Overpaid. If Line 12c is greater than Line 11, enter difference here and on the<br />
Estimated Tax Coupon (ENP-1), Line 2</td>
                                <td style="width:25%;" class="text-left">
                                    
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                                <label id="lblNPT16" style="WIDTH: 100%"></label>
                                                          <%--<input class="form-control input-sm" id="txtNPT16" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="10">--%>
                                                            </div>
                                                          </div>
                                            
                                            		</div> 
                                </td>
                            </tr>
                             <tr class="odd">
                                <td class="text-left">17. Enter 50% of Page 2, Worksheet C, Line 3.<label id="lnkWrkC" class="lblLink label_NoLeft"  onclick="if($(this).attr('disabled')!='disabled'){ShowPage('WrkC')}">Click here for Worksheet C</label><br />
<b>Do not use this line to remit estimated payments</b>
            
                                </td>
                                <td style="width:25%;" class="text-left">
                                    
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                                <label id="lblNPT17" style="WIDTH: 100%"></label>
                                                          <%--<input class="form-control input-sm" id="txtNPT17" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="10">--%>
                                                            </div>
                                                          </div>
                                            
                                            		</div> 
                                </td>
                            </tr>
                             <tr class="odd">
                                <td class="text-left">18.<b> Balance Available. Line 16 minus Line 17. If greater than 0 proceed to Overpayment Options</b></td>
                                <td style="width:25%;" class="text-left">
                                    
                                     <div class="form-horizontal">
                                    <div class="form-group no-margin">
                                        <div class="">
                                            <label id="lblNPT18" style="WIDTH: 100%"></label>
                                        <%--<input class="form-control input-sm" id="txtNPT18" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="10">--%>
                                        </div>
                                        </div>
                                            
                                </div> 
                                </td>
                            </tr>
                            <tr >
                                <td width="70%" class="text-left"><b><u>OVERPAYMENT OPTIONS</u> Only available if Line 18 is greater than 0. Enter the amount to be:</b></td>
                                <td style="width:25%;">
                                               	
                                </td>
                            </tr>
                            <tr class="odd">
                                <td class="text-left"><label  id=msgTobaccoNo3d style="WIDTH: 100%"/>19a. Refunded. Do not file a separate refund petition</td>
                                <td style="width:25%;" class="text-left">
                                   
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                          <input class="form-control input-sm table_custom_input" id="txtNPT19a" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="10" >
                                                            </div>
                                                          </div>
                                            
                                            		</div> 
                                </td>
                            </tr>
                            <tr>
                                <td width="70%" class="text-left">19b.  Applied, up to the tax due, to the <script>document.write(sCurrYear - 1)</script>Business Income & Receipts Tax Return</td>
                                <td style="width:25%;" class="text-left">
                                   
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                         <input class="form-control input-sm table_custom_input" id="txtNPT19b" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="10" >
                                                            </div>
                                                          </div>
                                            
                                            		</div> 
                                </td>
                            </tr>
                            <tr class="odd">
                                <td class="text-left">19c. Applied to the <script>document.write(sCurrYear)</script>Net Profits Tax</td>
                                <td style="width:25%;" class="text-left">
                                       
                                      <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                        <input class="form-control input-sm table_custom_input" id="txtNPT19c" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="10" >
                                                            </div>
                                                          </div>
                                            
                                            		</div> 
                                </td>
                            </tr>

                                        
                        </tbody>
                    </table>
                              </div>
                    <div class="clear"></div>
                    </div>
                     </div>
                    <div> 
                        <%Html.RenderAction("PreparerSection", "INC");%>
                    </div>
                     <div class="form-group">
                      <div class="col-sm-offset-3 col-sm-9  text-right">
                    <input id="btnNPTPrint" type="button" value="Print" class="btn btn-default submit_button_light" onclick="return btnNPTPrint_onclick()"<%--onclick="parent.doPrintDocWin()"--%> />
                    <input type="button" value="Submit" class="btn btn-default submit_button" id="btnNPTSubmit" onclick="return btnNPTSubmit_onclick()" />
                    </div>
                  </div>                    
                         

                </div>

                <% Html.RenderAction("_15WrkA", "NPT"); %>
                <%Html.RenderAction("_15WrkB", "NPT"); %>
                <%Html.RenderAction("_15WrkC", "NPT"); %> 
                <% Html.RenderAction("_15WrkD", "NPT");%>
                <%Html.RenderAction("_15WrkE", "NPT"); %>
                <%  Html.RenderAction("_15WrkK", "NPT");%>
                <% Html.RenderAction("_15Page4", "NPT");%>
                <%Html.RenderAction("_NPT_ExemptedMsg", "NPT"); %>
                <%-- <% Html.RenderAction("NPTThankYou", "NPT"); %>--%>
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
    <%-- <div class="quicklink_btm_gen"></div>--%>
</div>

</div>
   
</body>
</html>

