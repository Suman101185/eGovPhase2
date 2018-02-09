<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>   
     <script language="javascript" type="text/javascript">
         $(document).ready(function () {
             LoadError("WrkK");
         });
        </script>
    <title></title>
</head>
<body>

     <div id='NPT_WrkK' style="DISPLAY: none;">
    <div class="form-group">
        <div class="row table-responsive">
      <div class="col-lg-12" >
        <table summary="Employee Pay Sheet" class="table table-condensed table-striped custom_table03 wage-table-print">
            <tbody>
                <tr class="odd">
                      <td width="5%"></td>
                    <td width="70%"><b><u>Worksheet K: 60% Business Income & Receipts Tax Credit</u></b>
                    </td>
                    <td style="width:25%">
                                               
                        </td>
                </tr>
                <tr>
                      <td width="5%">1.</td>
                    <td> Enter the amount from Page 1, Line 1 of the 2017 Business Income & Receipts Tax or
BIRT-EZ return</td>
                    <td style="width:25%">                        
                   <div class="form-horizontal">
                    <div class="form-group no-margin">
                        <div class="">
                           <input type="text" class="form-control input-sm pull-right" style="WIDTH: 70%;" id="txtNPT_WrkK_1" onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("WrkK")'>
                        </div>
                   </div>
                </div>
                    </td>
                </tr>
              
                <tr>
                      <td width="5%">2.</td>
                    <td> Enter 60% of the amount on Line 1. If your entity has corporate members <b>Stop Here</b> and enter the amount on Worksheet D, Line 4 <br />
                        <label class="lblLink label_NoLeft"  onclick='ShowPage("WrkD")'>Click here for Worksheet D</label>
                    </td>
                    <td style="width:25%">                       
                    <div class="form-horizontal">
                    <div class="form-group no-margin">
                        <div class="">
                           <label class="form-control input-sm pull-right" style="WIDTH: 70%;" id="lblNPT_WrkK_2" ></label>
                        </div>
                   </div>
                </div>
                    </td>
                </tr>
                    <tr class="odd">
                          <td width="5%">3.</td>
                    <td width="70%"> Enter the amount from Page 1, Line 11 of the 2017 Net Profits Tax Return
                                               
                    </td>
                    <td style="width:25%">                           
                         <div class="form-horizontal">
                    <div class="form-group no-margin">
                        <div class="">
                           <label class="form-control input-sm pull-right" style="WIDTH: 70%;" id="lblNPT_WrkK_3" ></label>
                        </div>
                   </div>
                </div>
                        </td>
                    </tr>
                    <tr>
                          <td width="5%">4.</td>
                    <td>  Business Income & Receipts Tax credit allowed. Enter the lesser of Line 2 or Line 3 here and on Page 1, Line 12a
                        </td>
                    <td style="width:25%">                    
                        <div class="form-horizontal">
                    <div class="form-group no-margin">
                        <div class="">
                          <label  id="lblNPT_WrkK_4" class="form-control input-sm pull-right" style="WIDTH: 70%;"></label>
                        </div>
                   </div>
                </div>
                    </td>
                </tr>
                 
            </tbody>
            </table>
          <div style="height:100px !important;">&nbsp;</div>
      
       </div>
       </div>    
         <form class="form-horizontal school_form">
        <div class="form-group">
            <div class="col-sm-offset-3 col-sm-9  text-right">
               <INPUT  id=btnKGoToPage1 class="btn btn-default submit_button" onclick="ShowPage('Page1', 'WrkK')" type="button"  value="Return to Page 1">
            </div>
        </div>

    </form>                         
    </div>
         </div>

        <div class="lets-split"></div>                       

</body>

</html>

