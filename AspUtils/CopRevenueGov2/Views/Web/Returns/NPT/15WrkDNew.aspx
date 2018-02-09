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
        <table summary="Employee Pay Sheet" class="table table-condensed table-striped custom_table03">

            <tbody>

                <tr class="odd">
                    <td width="70%">  <u><b>Worksheet D:</u> Allocation of Business Income & Receipts Tax credit for partnerships, etc., with corporate members (this schedule is to be used only by partnerships, joint ventures and associations which are composed of one or more corporate partners, corporate joint ventures, or corporate associates.)</b>
                    </td>
                    <td style="width:25%">
                                               
                        </td>
                </tr>
                <tr>
                    <td>1.  Enter the portion of taxable income on which 2015 Business Income & Receipts Tax has been paid, AND which represents the distributive shares of ALL CORPORATE MEMBERS</td>
                    <td style="width:25%">                           
                    <div class="form-horizontal">
                    <div class="form-group no-margin">
                        <div class="">
                            <input class="form-control input-sm"  id="txtNPT_WrkD_1"  onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("WrkD")'>
                        </div>
                   </div>
                </div>
                    </td>
                </tr>
                <tr class="odd">
                    <td width="70%">2.  Enter the total taxable income of the taxpayer on which 2015 BIRT has been paid
                                               
                    </td>
                    <td style="width:25%">                            
                    <div class="form-horizontal">
                    <div class="form-group no-margin">
                        <div class="">
                           <input class="form-control input-sm" id="txtNPT_WrkD_2" onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("WrkD")'>
                        </div>
                   </div>
                </div>
                        </td>
                </tr>
                <tr>
                    <td>3. Divide Line 1 by Line 2 and enter the percentage here and on Page 1 of the return</td>
                    <td style="width:25%">                        
                     <div class="form-horizontal">
                      <div class="form-group no-margin">
                        <div class="">
                          <label style="width:100%" id="lblNPT_WrkD_3" />
                        </div>
                   </div>
                </div>
                     </td>
                </tr>

                    <tr class="odd">
                    <td width="70%">4.  Enter the amount from Page 3, Worksheet K, Line 2
                            <label class="lblLink label_NoLeft" onclick='ShowPage("WrkK")'>Click here for Worksheet K</label>
                    </td>
                    <td style="width:25%">                        
                      <div class="form-horizontal">
                      <div class="form-group no-margin">
                        <div class="">
                        <label style="width:100%" id="lblNPT_WrkD_4" ></label>
                        </div>
                   </div>
                </div>
                     </td>
                </tr>
                <tr >
                    <td>5.  Multiply the amount on Line 4 by the percentage on Line 3</td>
                    <td style="width:25%">                       
                      <div class="form-horizontal">
                      <div class="form-group no-margin">
                        <div class="">
                        <label style="width:100%" id="lblNPT_WrkD_5" ></label>
                        </div>
                   </div>
                </div>
                      </td>
                </tr>

                    <tr class="odd" >
                    <td width="70%">6.  Subtract Line 5 from Line 4
                                               
                    </td>
                    <td style="width:25%">                       
                     <div class="form-horizontal">
                      <div class="form-group no-margin">
                        <div class="">
                        <label style="width:100%" id="lblNPT_WrkD_6" />
                        </div>
                   </div>
                </div>
                     </td>
                </tr>

                <tr >
                    <td>7.  Enter the amount from Page 1, Line 11</td>
                    <td style="width:25%">                       
                     <div class="form-horizontal">
                      <div class="form-group no-margin">
                        <div class="">
                        <label style="width:100%" id="lblNPT_WrkD_7" />
                        </div>
                   </div>
                </div>
                    </td>
                </tr>

                    <tr class="odd" >
                    <td width="70%">8.  <b>Business Income & Receipts Tax Credit allowed.</b> Enter
the lesser of Line 6 or Line 7 here, and on Page 1, Line 12a
                                               
                    </td>
                    <td style="width:25%">                       
                     <div class="form-horizontal">
                      <div class="form-group no-margin">
                        <div class="">
                         <label style="width:100%" id="lblNPT_WrkD_8" > </label>
                        </div>
                   </div>
                </div>
                  </td>
                </tr>
                   <tr >
                    <td  ></td>
                    <td  style="width:25%">
                    <div class="form-group">
                    <div class="col-sm-offset-3 col-sm-9  text-right">
                    <INPUT  id=btnDGoToPage1 class="btn btn-default submit_button" onclick="ShowPage('Page1', 'WrkD')" type="button"  value="Return to Page 1">
                        </div>
                        </div>
                        </td>
                   </tr>                      
            </tbody>
            </table>
      
      </div>
       </div>                      
       </div>                       

</body>
</html>
