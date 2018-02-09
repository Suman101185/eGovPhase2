<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
     <script language="javascript" type="text/javascript">

         function gotoPage1() {           
            
             PerformCalcs("WrkE");            
             if ($("#AppError").text() == '') {
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

        <table summary="Employee Pay Sheet" class="table table-condensed table-striped custom_table03 wage-table-print">

            <tbody>

                <tr class="odd">
                     <td width="5%"></td>
                    <td width="70%"><b><u>Worksheet E: Summary of Payments and Other Credits</u></b>
                                                
                    </td>
                    <td style="width:25%">
                                               
                        </td>
                </tr>
                <tr>
                     <td width="5%">1.</td>
                    <td width="70%">2014 Estimated Net Profits Tax Payments</td>
                    <td style="width:25%">                       
                         <div class="form-horizontal">
                      <div class="form-group no-margin">
                        <div class="">
                   <input type="text" class="form-control input-sm pull-right" style="WIDTH: 70%;" id="txtNPT_WrkE_1"  onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("WrkE")'>
                        </div>
                   </div>
                </div>
                    </td>
                </tr>
                <tr class="odd">
                     <td width="5%">2.</td>
                  <%--  <td width="70%">Payments of 2014 Net Profits Tax made with <label class="lblLink label_NoLeft" onclick='ShowPage("WrkExtension")'> Application for Extension </label> of Time to File.--%>
                        <td style="width:70%">Payments of 2014 Net Profits Tax made with  Application for Extension of Time to File.                       
                    </td>
                    <td style="width:25%">                           
                          <div class="form-horizontal">
                      <div class="form-group no-margin">
                        <div class="">
                   <input class="form-control input-sm pull-right" style="WIDTH: 70%;" id="txtNPT_WrkE_2"  onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("WrkE")'>
                            <%-- <label class="form-control input-sm pull-right" style="WIDTH: 70%;" id="lblNPT_WrkE_2" />--%>
                        </div>
                   </div>
                </div>
                        </td>
                </tr>
                <tr>
                     <td width="5%">3.</td>
                    <td width="70%">Overpayment of 2014 Business Income & Receipts Tax or 2013 Net Profits Tax to be applied to this tax return</td>
                    <td style="width:25%">                       
                         <div class="form-horizontal">
                      <div class="form-group no-margin">
                        <div class="">
                   <input type="text" class="form-control input-sm pull-right" style="WIDTH: 70%;" id="txtNPT_WrkE_3" onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("WrkE")'>
                        </div>
                   </div>
                </div>
                    </td>
                </tr>
                    <tr class="odd">
                         <td width="5%">4.</td>
                    <td width="70%">Total of lines 1 through 3. Enter here [Calculated - Add lines 1 through 3]
                                               
                    </td>
                    <td style="width:25%">                           
                       <div class="form-horizontal">
                      <div class="form-group no-margin">
                        <div class="">
                  <label class="form-control input-sm pull-right" style="WIDTH: 70%;" id="lblNPT_WrkE_4" />
                        </div>
                   </div>
                </div>
                    </td>
                </tr>
                <div style="height:80px !important;">&nbsp;</div>
            </tbody>
            </table> <div style="height:80px !important;">&nbsp;</div>   
       </div>
       </div> 
      <form class="form-horizontal school_form">
        <div class="form-group">
            <div class="col-sm-offset-3 col-sm-9  text-right">
                <INPUT  id="btnWrkEGoToPage1" class="btn btn-default submit_button" onclick='gotoPage1()' type="button"  value="Return to Page 1">
            </div>
        </div>

    </form>                             
    </div>
</body>
</html>
