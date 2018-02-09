<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
    <script src="../../Content/Scripts/JqueryMin.js" type="text/javascript"></script>
    <script src="../../Content/Scripts/bootstrap.min.js" type="text/javascript"></script>
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
    <body style="margin:0 !important; padding:0 !important;">

<div class="container-fluid no-padding" id="NPT_2016" style="DISPLAY: none;">
<div class="block3">
 <div class="container-fluid">
   <div class="row">
    <div class="col-lg-12 col-md-12" style="display: block;" id="tab">
    <div  class="blue_base_box">
  
         <h2>Taxpayer Information  |   <span id="AppHeader"></span>  </h2>
     <div class="inner_white-panel top-padding-print">
          <div class="col-lg-12 col-lg-offset-0 no-padding-left">
                                                  <div id="AppError" class="errormsg no-padding" style="display:block; margin-bottom:2px; height:1px;">
                                                   </div>
                                                     </div> 
          <div class="contentsection">

        <h4 id="AppMessage">&nbsp;</h4>
         <div class="clearfix"></div>
          
         <div class="row">

           <div class="col-lg-12">
                       
            <%-- Address Start--%>
                <div class="well"  id="NPT" style="DISPLAY: none; padding:0px5px !important; margin-bottom:0px !important;">
                     <div class="row">
                        <form>
                            <div class="col-lg-9 col-md-8 col-sm-9 col-xs-8">
                                <p style="margin-bottom:0 !important;"><span>Name:</span>
                                <span id="lblName" ></span>
                            </p>
                            
                            </div>

                            <div class="col-lg-3 col-md-4 col-sm-3 col-xs-4">
                                <p style="margin-bottom:0 !important;">
                                     <span id="lblAccountType">Account No.:</span>
                                     <span id="lblAccountId" class=""></span>
                                </p>
                               
                            </div>

                        </form>
                    </div>
                  
                    <div class="row">
                        <div class="col-lg-9 col-md-8 col-sm-9 col-xs-8">
                            <p style="margin-bottom:0 !important;"><span>Address:</span>
                                    <span id="lblAddress" ></span>
                                </p>
                        </div>
                            <div class="col-lg-3 col-md-4 col-sm-3 col-xs-4">
                                <p style="margin-bottom:0 !important;">
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
                                
                                
                                Your 2017 BIRT return must be filed prior to filing your 2017 NPT Return.<br>
                                To fill out your 2017 BIRT form, Please select BIRT from the side menu.
                            </div>
                    <div id="NPT_Page1" style="DISPLAY: none;" VISIBILTY: visible" name="NPT_Page1">
                 
                    <form class="form-horizontal">   
                       
                         <div class="row" style="display:none">
                            <div class="col-lg-12 no-padding">
                        <div class="col-lg-4 newtop_padding col-sm-12">
                            <label class="no-padding" style="font-weight: normal;">
                               <input id=chkChangeAddress type="checkbox"> &nbsp;If this is a change of address, check this box.</label>
                        </div>                      
                       
                         </div>
                        </div>
                             
                        <div class="row">
                            <div class="col-lg-12 no-padding">
                        <div class="col-lg-3 newtop_padding col-md-3 col-sm-3 col-xs-3">
                            <label class="no-padding" style="font-weight: normal;">
                                <input id=chkAmended type=checkbox onclick="chkAmended_onclick()" />
                                            Check if amended return.</label>
                        </div>
                                
                             
                        <div class="col-sm-7 col-md-7 col-xs-7 newtop_padding">
                                <label class="control-label text-custom-left2" for="inputEmail3">
                                    <span class="pull-left">If your business terminated in 2017, enter the termination date AND file a CHANGE FORM.</span>
                                                                   
                                </label>
                            </div>
                            <div class="col-sm-2 col-md-2 col-xs-2 newtop_padding custom-margin-npt" style="padding-left:0;">
                                 <input  class="inpNormal_custom date-input  date-field-design pull-right" id="txtTermDate" placeholder="MM/DD/YYYY" maxlength="10" style="WIDTH: 100%; padding:1px!important;"
                                        onfocus="SetFocus()" onblur="return txtTermDate_onblur()"></div>                                                             
                        <br />
                                <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3"></div>
                        <div class="col-lg-7 col-md-7 col-sm-7 col-xs-7" style="padding-right:0 !important;">
                            <label class="control-label text-custom-left2 no-padding pull-left" for="inputEmail3">
                                <span class="custom_padding_span" style="font-weight: normal;">If applicable,enter percentage from Worksheet D, Line 3: 
                                    <label id="lnkWrkD" style="font-weight: normal;" class="lblLink label_NoLeft" onclick="if($(this).attr('disabled')!='disabled'){ShowPage('WrkD')}">Click here for Worksheet D</label>
                                 </span>
                                </label>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-2 col-xs-2">
                                                    
                             <label id="lblPercentage" class="form-control input-sm pull-right" style="WIDTH: 70%; padding: 1px !important; height: 22px; margin-bottom: 2px;"></label>
                        </div>
                                </div>
                        </div>
                        
                       
                    
                </form>     
                        
                              
                         <!-- Return Form -->
                         <div class="row ">
                        <div class="col-lg-12 templateclass print-no-padding">
                     <div class="row table-responsive">
                      <div class="col-lg-12" >
                        
                    <table summary="Employee Pay Sheet" class="table table-condensed table-striped custom_table03 wage-table-print npt-table-print-font no-mb">

                        <tbody>
                           
                            <tr class="odd">
                                <td width="5%">1.</td>
                                <td width="70%" class="text-left"> Pro Rata Resident taxable income/loss NOT eligible for Income Based Rate from Page 2, Worksheet A, Line 5.
                                        <label id="lnkWrkA" class="lblLink label_NoLeft" style="font-size:11px;" onclick="if($(this).attr('disabled')!='disabled'){ShowPage('WrkA')}">Click here for Worksheet A</label>
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
                                <td width="70%" class="text-left"> <label class="" id="msgNPT1_2" style="float:none;"></label>Line 1 X 0.038907</td>
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
                                <td width="70%" class="text-left"> Pro Rata Resident taxable income/loss eligible for Income Based Rate from Page 2, Worksheet A, Line 6.
                                        <label id="lnkWrkA1" class="lblLink label_NoLeft" style="font-size:11px;"  onclick="if($(this).attr('disabled')!='disabled'){ShowPage('WrkA')}">Click here for Worksheet A</label>
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
                                <td width="70%" class="text-left">  <label class="" id="msgNPT1_4" style="float:none;"></label>Line 3 X 0.033907</td>
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
                                <td width="70%" class="text-left"> Total Resident Tax Due (Line 2 plus Line 4)</td>
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
                                <td width="5%">6.</td>
                                <td width="70%" class="text-left"> Pro Rata Non-Resident taxable income/loss NOT eligible for Income Based Rate from Page 2, Worksheet B, Line 5
                                    <label id="lnkWrkB" class="lblLink label_NoLeft" style="font-size:11px;"  onclick="if($(this).attr('disabled')!='disabled'){ShowPage('WrkB')}">Click here for Worksheet B</label></td>
                                <td style="width:25%;" class="text-left">
                                   
                                       <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                             <label id="lblNPT6" class="form-control input-sm pull-right" style="WIDTH: 70%;"> </label>
                                                            </div>
                                                          </div>
                                            
                                            		</div>
                                    </td>
                            </tr>                         
                            <tr class="odd">
                                <td width="5%">7.</td>
                                <td width="70%" class="text-left"> Line 6 X 0.034654</td>
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
                                <td width="70%" class="text-left"> Pro Rata Non-Resident Taxable income/loss eligible for Income Based Rate from Page 2, Worksheet B, Line 6.
                                    <label id="lnkWrkB1" class="lblLink label_NoLeft" style="font-size:11px;"  onclick="if($(this).attr('disabled')!='disabled'){ShowPage('WrkB')}">Click here for Worksheet B</label>
                                </td>
                                <td style="width:25%;" class="text-left">
                                   
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                      <label id="lblNPT8" class="form-control input-sm pull-right" style="WIDTH: 70%;"></label>
                                                            </div>
                                                          </div>
                                            
                                            		</div>
                                </td>
                            </tr>
                            <tr class="odd">
                                <td width="5%">9.</td>
                                <td width="70%" class="text-left"> Line 8 X 0.029654</td>
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
                                <td width="70%" class="text-left"> Total Non-Resident Tax Due (Line 7 plus Line 9)</td>
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
                                <td width="70%" class="text-left"> Total Tax Due (Line 5 plus Line 10)</td>
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
                             <tr class="odd">
                                 <td width="5%">12a.</td>
                                <td  width="70%" class="text-left"> 60% Business Income & Receipts Tax credit from Worksheet K, Line 4
                                    <label id="lnkWrkk" class="lblLink label_NoLeft" style="font-size:11px;"  onclick="if($(this).attr('disabled')!='disabled'){ShowPage('WrkK')}">Click here for Worksheet K</label>
                                </td>
                                <td style="width:25%;" class="text-left">
                                    
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                                <label id="lblNPT12a" class="form-control input-sm pull-right" style="WIDTH: 70%;"></label>
                                                        </div>
                                                          </div>
                                            
                                            		</div> 
                                </td>
                            </tr>
                             <tr class="odd">
                                 <td width="5%">12b.</td>
                                <td  width="70%" class="text-left">Estimated payments and other credits from Worksheet E, Line 4
                                    <label id="lnkWrkE" class="lblLink label_NoLeft" style="font-size:11px;"  onclick="if($(this).attr('disabled')!='disabled'){ShowPage('WrkE')}">Click here for Worksheet E</label>
                                </td>
                                <td style="width:25%;" class="text-left">
                                    
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                                <label id="lblNPT12b" class="form-control input-sm pull-right" style="WIDTH: 70%;"></label>
                                                          </div>
                                                          </div>
                                            
                                            		</div> 
                                </td>
                            </tr>
                             <tr class="odd">
                                 <td width="5%">12c.</td>
                                <td width="70%" class="text-left"> Total payments and credits. (Line 12a plus Line 12b)</td>
                                <td style="width:25%;" class="text-left">
                                    
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                                <label id="lblNPT12c" class="form-control input-sm pull-right" style="WIDTH: 70%;"></label>
                                                           </div>
                                                          </div>
                                            
                                            		</div> 
                                </td>
                            </tr>
                             <tr class="odd">
                                 <td width="5%">13.</td>
                                <td width="70%" class="text-left"> Net Tax Due: (Line 11 minus Line 12c)</td>
                                <td style="width:25%;" class="text-left">
                                    
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                                <label id="lblNPT13" class="form-control input-sm pull-right" style="WIDTH: 70%;"></label>
                                                           </div>
                                                          </div>
                                            
                                            		</div> 
                                </td>
                            </tr>
                             <tr class="odd">
                                 <td width="5%">14.</td>
                                <td  width="70%" class="text-left"> Interest and Penalty <a href="https://beta.phila.gov/services/payments-assistance-taxes/paying-city-taxes/interest-penalties-and-fees/" target="_blank" style="color:red">(see Instruction)</a></td>
                                <td style="width:25%;" class="text-left">
                                    
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                          <input class="form-control input-sm pull-right" style="WIDTH: 70%;" id="txtNPT14" />
                                                            </div>
                                                          </div>
                                            
                                            		</div> 
                                </td>
                            </tr>
                             <tr class="odd">
                                 <td width="5%">15.</td>
                                <td width="70%" class="text-left"> <b><u>TOTAL DUE</u></b> including Interest and Penalty (Line 13 plus Line 14).
</td>
                                <td style="width:25%;" class="text-left">
                                    
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                                <label id="lblNPT15" class="form-control input-sm pull-right" style="WIDTH: 70%;"></label>
                                                         </div>
                                                          </div>
                                            
                                            		</div> 
                                </td>
                            </tr>
                             <tr class="odd">
                                 <td width="5%">16.</td>
                                <td width="70%" class="text-left">  Tax Overpaid. (If Line 12c is greater than Line 11)</td>
                                <td style="width:25%;" class="text-left">
                                    
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                                <label id="lblNPT16" class="form-control input-sm pull-right" style="WIDTH: 70%;"></label>
                                                           </div>
                                                          </div>
                                            
                                            		</div> 
                                </td>
                            </tr>
                             <tr class="odd">
                                 <td width="5%">17.</td>
                             
                                 <td width="70%" class="text-left">
                                     Enter 50% of Page 2, Worksheet C, Line 3. <b>Do not use this line to remit estimated payments </b>
              <label id="lnkWrkC" class="lblLink label_NoLeft" style="font-size:11px;"
                  onclick="if($(this).attr('disabled')!='disabled'){ShowPage('WrkC')}">Click here for Worksheet C

              </label>
              </td>
              
               <td style="width:25%;" class="text-left">
                                    
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                                <label id="lblNPT17" class="form-control input-sm pull-right" style="WIDTH: 70%;"></label>
                                                          </div>
                                                          </div>
                                            
                                            		</div> 
                                </td>
                            </tr>
                             <tr class="odd">
                                 <td width="5%" style="padding-bottom:0 !important;">18.</td>
                                <td  width="70%" class="text-left" style="padding-bottom:0 !important;"> Balance Available. Line 16 minus Line 17. If greater than 0 proceed to Overpayment Options</td>
                                <td style="width:25%; padding-bottom:0 !important;" class="text-left">
                                    
                                     <div class="form-horizontal">
                                    <div class="form-group no-margin">
                                        <div class="">
                                            <label id="lblNPT18" class="form-control input-sm pull-right" style="WIDTH: 70%;"></label>
                                       </div>
                                        </div>
                                            
                                </div> 
                                </td>
                            </tr>
                            <tr >
                                <td width="5%" style="padding-top:0 !important;"></td>
                                <td width="70%" style="padding-top:0 !important;" class="text-left"><b><u>OVERPAYMENT OPTIONS</u> </b>Only available if Line 18 is greater than 0. Enter the amount to be:</td>
                                <td style="width:25%; padding-top:0 !important;">
                                               	
                                </td>
                            </tr>
                            <tr class="odd">
                                <td width="5%">19a.</td>
                                <td width="70%" class="text-left"><label  id="msgTobaccoNo3d"  style="WIDTH: 100%;"/> Refunded. Do not file a separate refund petition</td>
                                <td style="width:25%;" class="text-left">
                                   
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                          <input type="text" class="form-control input-sm pull-right" style="WIDTH: 70%;" id="txtNPT19a" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="10" />
                                                            </div>
                                                          </div>
                                            
                                            		</div> 
                                </td>
                            </tr>
                            <tr>
                                <td width="5%">19b.</td>
                                <td width="70%" class="text-left"> Applied, up to the tax due, to the <script>document.write(sCurrYear - 1)</script> Business Income & Receipts Tax Return</td>
                                <td style="width:25%;" class="text-left">
                                   
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                         <input type="text" class="form-control input-sm pull-right" style="WIDTH: 70%;" id="txtNPT19b" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="10" />
                                                            </div>
                                                          </div>
                                            
                                            		</div> 
                                </td>
                            </tr>
                            <tr class="odd">
                                <td width="5%">19c.</td>
                                <td width="70%" class="text-left"> Applied to the <script>document.write(sCurrYear)</script> Net Profits Tax</td>
                                <td style="width:25%;" class="text-left">
                                       
                                      <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                        <input type="text" class="form-control input-sm pull-right" style="WIDTH: 70%;" id="txtNPT19c" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="10" />
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
                     </div>
                         <!-- Form End-->
                          <!-- Preperar Section Form -->
                     <form class="form-horizontal form-year-background" style="padding:0 5px;">
                    <div> 
                        <%Html.RenderAction("PreparerSection", "INC");%>
                    </div>
                     <div class="form-group page-print-wage-section">
                      <div class="col-sm-offset-3 col-sm-9  text-right">
                    <input id="btnNPTPrint" type="button" value="Print" class="btn btn-default submit_button_light" onclick="return btnNPTPrint_onclick()"/>
                    <input type="button" value="Submit" class="btn btn-default submit_button" id="btnNPTSubmit" onclick="return btnNPTSubmit_onclick()" />
                    </div>
                  </div>                    
                  <div style="margin-left: 5px; margin-top:-8px; font-size:12px;" class="here_input_table">
                    <label style="margin-top:2px;">
                                                            Note: DO NOT FILE THIS RETURN if you have no taxable activity. If you registered for 
				this tax and you no longer have taxable activity, complete a 
				<a href="https://beta.phila.gov/media/20170207132309/Change-Form.pdf" target="_blank">Change Form</a> to cancel
				your account.</label>
                   </div>    
                    </form>
                         <!-- Preperar Section Form END -->
                        </div>
                        </div>
                   
                    </div>
                    </div>
                        </div>
                    <div class="lets-split"></div>
                    
                <!--PRINT-->

               <div class="row">
               <div class="col-lg-12 templateclass">

                <% Html.RenderAction("_17WrkA", "NPT"); %>
                <%Html.RenderAction("_17WrkB", "NPT"); %>
                <%Html.RenderAction("_17WrkC", "NPT"); %> 
                <% Html.RenderAction("_17WrkD", "NPT");%>
                <%Html.RenderAction("_17WrkE", "NPT"); %>
                <%  Html.RenderAction("_17WrkK", "NPT");%>
                <% Html.RenderAction("_17Page4", "NPT");%>
                <%Html.RenderAction("_17WrkExtension", "NPT");%>
                <%Html.RenderAction("_NPT_ExemptedMsg", "NPT"); %>
             </div>
                </div>
                
              </div>
             <div class="clearfix"></div>
          </div>                  
                          
      </div>
     </div>
    </div>
     
    </div>
       <div class="clearfix"></div>
    </div>
  </div>            

</div>

</div>
   
</body>
</html>

