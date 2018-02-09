<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
     <script language="javascript" type="text/javascript">

         function gotoPage1() {
             PerformCalcs("WrkE");
             if ($(parent.AppError).text() == '') {
                 ShowPage("Page1", "WrkE");
             }
             else {
             }
         }
         $(document).ready(function () {
             LoadError("WrkE");
         });

</script>
  
    <title></title>
</head>
<body>
  <div class="form-group" id=NPT_WrkE style="DISPLAY: none;">
      <div class="row table-responsive">
       <div class="col-lg-12" >

        <table summary="Employee Pay Sheet" class="table table-condensed table-striped custom_table03">

            <tbody>

                <tr class="odd">
                    <td width="70%"><u>Worksheet E: Summary of Payments and Other Credits</u>
                                                
                    </td>
                    <td style="width:25%">
                                               
                        </td>
                </tr>
                <tr>
                    <td>1.  2012 Estimated Net Profits Tax Payments</td>
                    <td style="width:25%">                       
                         <div class="form-horizontal">
                      <div class="form-group no-margin">
                        <div class="">
                   <input class="form-control input-sm" id="txtNPT_WrkE_1"  onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("WrkE")'>
                        </div>
                   </div>
                </div>
                    </td>
                </tr>
                <tr class="odd">
                    <td width="70%">2.  Payments of 2012 Net Profits Tax made with Application for Extension of Time to File
                                               
                    </td>
                    <td style="width:25%">                           
                          <div class="form-horizontal">
                      <div class="form-group no-margin">
                        <div class="">
                   <input class="form-control input-sm" id="txtNPT_WrkE_2"  onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("WrkE")'>
                        </div>
                   </div>
                </div>
                        </td>
                </tr>
                <tr>
                    <td>3.   Overpayment of 2012 Business Income & Receipts Tax or 2011 Net Profits Tax to be applied to this tax return</td>
                    <td style="width:25%">                       
                         <div class="form-horizontal">
                      <div class="form-group no-margin">
                        <div class="">
                   <input class="form-control input-sm" id="txtNPT_WrkE_3" onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("WrkE")'>
                        </div>
                   </div>
                </div>
                    </td>
                </tr>
                    <tr class="odd">
                    <td width="70%">4.  Total of lines 1 through 3. Enter here and on Page 1, Line 6b [Calculated - Add lines 1 through 3]
                                               
                    </td>
                    <td style="width:25%">                           
                       <div class="form-horizontal">
                      <div class="form-group no-margin">
                        <div class="">
                  <label style="width:100%" id="lblNPT_WrkE_4" />
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
                        
                         <INPUT  id="btnWrkEGoToPage1" class="btn btn-default submit_button" onclick='gotoPage1()' type="button"  value="Return to Page 1">
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
