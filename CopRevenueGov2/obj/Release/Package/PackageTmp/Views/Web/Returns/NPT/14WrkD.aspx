<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
  
    <title>cop</title>
</head>
<body onload='LoadError("WrkD")'>
    <div class="form-group" id="NPT_WrkD" style="DISPLAY: none;">
     <div class="row table-responsive">
      <div class="col-lg-12" >
        <table summary="Employee Pay Sheet" class="table table-condensed table-striped custom_table03 wage-table-print">

            <tbody>

                <tr class="odd">
                     <td width="5%"></td>
                    <td width="70%"> <b> <u>Worksheet D:</u> Allocation of Business Income & Receipts Tax credit for partnerships, etc., with corporate members (this schedule is to be used only by partnerships, joint ventures and associations which are composed of one or more corporate partners, corporate joint ventures, or corporate associates.)</b>
                    </td>
                    <td style="width:25%">
                                               
                        </td>
                </tr>
                <tr>
                     <td width="5%">1.</td>
                    <td width="70%">Enter the portion of taxable income on which 2014 Business Income & Receipts Tax has been paid, AND which represents the distributive shares of ALL CORPORATE MEMBERS</td>
                    <td style="width:25%">                           
                    <div class="form-horizontal">
                    <div class="form-group no-margin">
                        <div class="">
                            <input type="text" class="form-control input-sm pull-right" style="WIDTH: 70%;" id="txtNPT_WrkD_1"  onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("WrkD")'>
                        </div>
                   </div>
                </div>
                    </td>
                </tr>
                <tr class="odd">
                     <td width="5%">2.</td>
                    <td width="70%">Enter the total taxable income of the taxpayer on which 2014 BIRT has been paid
                                               
                    </td>
                    <td style="width:25%">                            
                    <div class="form-horizontal">
                    <div class="form-group no-margin">
                        <div class="">
                           <input type="text" class="form-control input-sm pull-right" style="WIDTH: 70%;" id="txtNPT_WrkD_2" onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("WrkD")'>
                        </div>
                   </div>
                </div>
                        </td>
                </tr>
                <tr>
                     <td width="5%">3.</td>
                    <td width="70%">Divide Line 1 by 2 and enter the percentage here and on Page 1</td>
                    <td style="width:25%">                        
                     <div class="form-horizontal">
                      <div class="form-group no-margin">
                        <div class="">
                          <label class="form-control input-sm pull-right" style="WIDTH: 70%;" id="lblNPT_WrkD_3" />
                        </div>
                   </div>
                </div>
                     </td>
                </tr>

                    <tr class="odd">
                         <td width="5%">4.</td>
                    <td width="70%">Enter the amount from Page 3, Worksheet K, Line 2
                            <label class="lblLink label_NoLeft" onclick='ShowPage("WrkK")'>Click here for Worksheet K</label>
                    </td>
                    <td style="width:25%">                        
                      <div class="form-horizontal">
                      <div class="form-group no-margin">
                        <div class="">
                        <label class="form-control input-sm pull-right" style="WIDTH: 70%;" id="lblNPT_WrkD_4" ></label>
                        </div>
                   </div>
                </div>
                     </td>
                </tr>
                <tr >
                     <td width="5%">5.</td>
                    <td width="70%">Multiply the amount on Line 4 by the percentage on Line 3</td>
                    <td style="width:25%">                       
                      <div class="form-horizontal">
                      <div class="form-group no-margin">
                        <div class="">
                        <label class="form-control input-sm pull-right" style="WIDTH: 70%;" id="lblNPT_WrkD_5" ></label>
                        </div>
                   </div>
                </div>
                      </td>
                </tr>

                    <tr class="odd" >
                         <td width="5%">6.</td>
                    <td width="70%">Subtract Line 5 from Line 4
                                               
                    </td>
                    <td style="width:25%">                       
                     <div class="form-horizontal">
                      <div class="form-group no-margin">
                        <div class="">
                        <label class="form-control input-sm pull-right" style="WIDTH: 70%;" id="lblNPT_WrkD_6" />
                        </div>
                   </div>
                </div>
                     </td>
                </tr>

                <tr >
                     <td width="5%">7.</td>
                    <td width="70%">Enter the amount from Page 1, Line 5</td>
                    <td style="width:25%">                       
                     <div class="form-horizontal">
                      <div class="form-group no-margin">
                        <div class="">
                        <label class="form-control input-sm pull-right" style="WIDTH: 70%;" id="lblNPT_WrkD_7" />
                        </div>
                   </div>
                </div>
                    </td>
                </tr>

                    <tr class="odd" >
                         <td width="5%">8.</td>
                    <td width="70%"><b>Business Income & Receipts Tax Credit allowed.</b> Enter
the lesser of Line 6 or Line 7 here, and on Page 1, Line 6a
                                               
                    </td>
                    <td style="width:25%">                       
                     <div class="form-horizontal">
                      <div class="form-group no-margin">
                        <div class="">
                         <label class="form-control input-sm pull-right" style="WIDTH: 70%;" id="lblNPT_WrkD_8" > </label>
                        </div>
                   </div>
                </div>
                  </td>
                </tr>
                    <div style="height:80px;">&nbsp;</div>
            </tbody>
            </table>
      
      </div>
       </div>  
         <form class="form-horizontal school_form">
        <div class="form-group">
            <div class="col-sm-offset-3 col-sm-9  text-right">
               <INPUT  id=btnDGoToPage1 class="btn btn-default submit_button" onclick="ShowPage('Page1', 'WrkD')" type="button"  value="Return to Page 1">
            </div>
        </div>

    </form>                                
       </div>                       

</body>
</html>
