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
<div class="container-fluid no-padding" id="NPT_2010" style="DISPLAY: none;">
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
                           
                    <div class="clearfix"></div>

                </div>  
            <%--  Adress End--%>     
               <div class="row">
               <div class="col-lg-12 templateclass">     
                    <div id="NPT_BPT_msg" style="DISPLAY: none;" VISIBILTY: visible" name="NPT_BPT_msg" align="center">
                                <br>
                                <br>
                                <br>
                                Your 2011 BIRT return must be filed prior to filing your 2011 NPT Return.<br>
                                To fill out your 2011 BIRT form, Please select BIRT from the side menu.
                            </div>
                    <div id="NPT_Page1" style="DISPLAY: none;" VISIBILTY: visible" name="NPT_Page1">
                 
                    <form class="form-horizontal school_form">                     
                        <div class="row">
                            <div class="col-lg-12">
                        <div class="col-lg-3 newtop_padding col-sm-12">
                            <label class="radio no-padding" style="font-weight: bold;">
                                <input id=chkAmended type=checkbox onclick="chkAmended_onclick()" />
                                            Check if amended return.</label>
                        </div>
                        <div class="col-lg-6 col-sm-12">
                            <label class="control-label text-custom-left2 no-padding pull-right" for="inputEmail3">
                                <span class="custom_padding_span"> If your business terminated in <script>document.write(sCurrYear - 1)</script>, enter the termination date here:  
                                 </span>
                                </label>
                        </div>
                        <div class="col-lg-3 col-sm-12 no-padding">
                            <input class="form-control input-sm " id="txtTermDate" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="10"
                        onblur="return txtTermDate_onblur()">
                        </div>
                                </div>
                        </div>
                        <div class="row" style="margin-bottom:15px;margin-top:15px;">
                            <div class="col-lg-12">
                        <div class="col-lg-9">
                            <label class="control-label text-custom-left2" for="inputEmail3">
                                <span class="pull-left">Enter the termination date if business is terminated in previous financial year 
                                    <label id="lnkWrkD" class="lblLink label_NoLeft" onclick="if($(this).attr('disabled')!='disabled'){ShowPage('WrkD')}">Click here for Worksheet D</label></span>
                                                                   
                            </label>
                        </div>
                        <div class="col-lg-3 no-padding">
                            <input class="form-control input-sm" id="txtPercentage" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="3">
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
                                <td width="70%" class="text-left"><b>1. Residents Taxable Income or Loss from Page 2, Worksheet A, Line 4</b>
                                        <label id="lnkWrkA" class="lblLink label_NoLeft" onclick="if($(this).attr('disabled')!='disabled'){ShowPage('WrkA')}">Click here for Worksheet A</label>
                                </td>
                                <td style="width:25%;" class="text-left">                                   
                                    <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                             <input class="form-control input-sm"  id="txtNPT1" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="10" >
                                                            </div>
                                                          </div>
                                            
                                            		</div>
                                    </td>
                            </tr>
                            <tr>
                                <td class="text-left">2.  <label class="" id="msgNPT1_2" style="float:none;">Line 1 X ###</label></td>
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
                                <td width="70%" class="text-left">3.  Non-Residents Taxable Income or Loss from Page 2, Worksheet B, Line 6 
                                        <label id="lnkWrkB" class="lblLink label_NoLeft"  onclick="if($(this).attr('disabled')!='disabled'){ShowPage('WrkB')}">Click here for Worksheet B</label>
                                </td>
                                <td style="width:25%;" class="text-left">
                                      
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                               <input class="form-control input-sm" id="txtNPT3" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="10" >
                                                            </div>
                                                          </div>
                                            
                                            		</div>
                                    </td>
                            </tr>
                            <tr>
                                <td class="text-left">4.   <label class="" id="msgNPT1_4" style="float:none;">Line 3 X ###</label>&nbsp;</td>
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
                                <td width="70%" class="text-left">5.  Tax Due(Line 2 plus Line 4)</td>
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
                                <td class="text-left"><b>6a.  60% Business Income & Receipts Tax credit from Page 3, Worksheet K, Line 4</b>
                                    <label id="Label1" class="lblLink label_NoLeft"  onclick="if($(this).attr('disabled')!='disabled'){ShowPage('WrkK')}">Click here for Worksheet K</label></td>
                                <td style="width:25%;" class="text-left">
                                   
                                       <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                             <label id="lblNPT6a" style="WIDTH: 100%"> </label>
                                                            </div>
                                                          </div>
                                            
                                            		</div>
                                    </td>
                            </tr>
                            <tr class="odd">
                                <td width="70%" class="text-left">6b.  Estimated payments and other credits from 	Worksheet E, Line 4
                                    <label id="lnkWrkE" class="lblLink label_NoLeft"  onclick="if($(this).attr('disabled')!='disabled'){ShowPage('WrkE')}">Click here for Worksheet E</label>
                                </td>
                                <td style="width:25%;" class="text-left">
                                   
                                    <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                            <input class="form-control input-sm" id="txtNPT6b" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="10" >
                                                            </div>
                                                          </div>
                                            
                                            		</div>
                                </td>
                            </tr>
                            <tr>
                                <td class="text-left">6c.  Total payments and credits(Line 6a plus Line 6b)</td>
                                <td style="width:25%;" class="text-left">
                                       
                                      <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                           <label id="lblNPT6c" style="WIDTH: 100%"></label>
                                                            </div>
                                                          </div>
                                            
                                            		</div>
                                </td>
                            </tr>
                            <tr class="odd">
                                <td width="70%" class="text-left">7.  Net Tax Due(Line 5 minus Line 6c) </td>
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
                                <td class="text-left">8.  Interest and Penalty ( Refer to web site for current percentage )</td>
                                <td style="width:25%;" class="text-left">
                                   
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                          <input class="form-control input-sm" id="txtNPT8" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="10" >
                                                            </div>
                                                          </div>
                                            
                                            		</div>
                                </td>
                            </tr>
                            <tr class="odd">
                                <td width="70%" class="text-left">9.  <u>TOTAL DUE</u> including Interest and Penalty (Line 7 plus Line 8)</td>
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
                                <td width="70%" class="text-left">10.  Tax Overpaid. If Line 6c is greater than Line 5, enter difference here and on the Estimated Tax Coupon (ENP-1), Line 2</td>
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
                                <td class="text-left">11.   Enter 50% of Worksheet C, Line 3.<br><b>This line is <u>not</u> used to remit estimated payments</b>
                                    <label id="lnkWrkC" class="lblLink label_NoLeft"  onclick="if($(this).attr('disabled')!='disabled'){ShowPage('WrkC')}">Click here for Worksheet C</label>
                                </td>
                                <td style="width:25%;" class="text-left">
                                    
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                          <input class="form-control input-sm table_custom_input" id="txtNPT11" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="10">
                                                            </div>
                                                          </div>
                                            
                                            		</div> 
                                </td>
                            </tr>
                            <tr >
                                <td width="70%" class="text-left">12.    <u>OVERPAYMENT OPTIONS</u> If Line 10 is greater than Line 11,enter the amount to be:</td>
                                <td style="width:25%;">
                                               	
                                </td>
                            </tr>
                            <tr class="odd">
                                <td class="text-left"><label  id=msgTobaccoNo3d style="WIDTH: 100%"/>A. Refunded. Do not file a separate refund petition</td>
                                <td style="width:25%;" class="text-left">
                                   
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                          <input class="form-control input-sm table_custom_input" id="txtNPT12a" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="10" >
                                                            </div>
                                                          </div>
                                            
                                            		</div> 
                                </td>
                            </tr>
                            <tr>
                                <td width="70%" class="text-left">B.  Applied, up to the tax due, to the <script>document.write(sCurrYear - 1)</script>Business Income & Receipts Tax Return</td>
                                <td style="width:25%;" class="text-left">
                                   
                                     <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                         <input class="form-control input-sm table_custom_input" id="txtNPT12b" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="10" >
                                                            </div>
                                                          </div>
                                            
                                            		</div> 
                                </td>
                            </tr>
                            <tr class="odd">
                                <td class="text-left">C. Applied to the <script>document.write(sCurrYear)</script>Net Profits Tax</td>
                                <td style="width:25%;" class="text-left">
                                       
                                      <div class="form-horizontal">
                                                        <div class="form-group no-margin">
                                                            <div class="">
                                                        <input class="form-control input-sm table_custom_input"  id="txtNPT12c" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="10" >
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

                            <%Html.RenderAction("_10WrkA", "NPT"); %> 
                              <%Html.RenderAction("_10WrkB", "NPT"); %> 
                              <%Html.RenderAction("_10WrkC", "NPT"); %> 
                              <%Html.RenderAction("_10WrkD", "NPT"); %> 
                              <%Html.RenderAction("_10WrkE", "NPT"); %> 
                              <%Html.RenderAction("_10WrkK", "NPT"); %> 
                              <%Html.RenderAction("_10Page4", "NPT");%>
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
    <%-- <div class="quicklink_btm_gen"></div>--%>
</div>

</div>
   
</body>
</html>
