<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>

<html>
<head>   
     <script language="javascript" type="text/javascript">
         $(document).ready(function () {
             LoadError("WrkExtension");
         });
        </script>
    <title></title>
</head>
<body>
    <div class="form-group" id='NPT_WrkExtension' style="DISPLAY: none;">
        <div class="row table-responsive">
      <div class="col-lg-12" >
        <table summary="Employee Pay Sheet" class="table table-condensed table-striped custom_table03">
            <tbody>
                <tr class="odd">
                     <td width="5%"></td>
                    <td width="70%"><b><u>EXTENSION WORKSHEET</u></b>
                        <br>
This is an extension worksheet to be used when figuring the amount of Net Profits tax you owe. You must file an actual return by the extension due date
to satisfy your filing requirements. If an extension of time has been obtained from the Internal Revenue Service for filing your corporate, partnership or
individual tax returns, the corresponding returns are due on or before the due date of the federal extension(s).<b> You must pay 100% of the estimated
tax due by April 18, 2016. Filing an extension coupon does not extend the time to pay the tax.</b> Interest and penalty shall be added to the amount
of tax not paid by the statutory due date. You will not receive written confirmation of your extension request. <b>NOTE: If you have filed for an
automatic federal extension but do not believe you will owe any tax, you do not need to file an extension coupon</b>
                    </td>
                    <td style="width:25%">
                                               
                        </td>
                </tr>
                <tr>
                      <td width="5%">1.</td>
                    <td width="70%">100% of estimated <b><u>2015 NET PROFITS</u></b> tax due</td>
                    <td style="width:25%">                        
                   <div class="form-horizontal">
                    <div class="form-group no-margin">
                        <div class="">                          
                             <input type="text" class="form-control input-sm pull-right" style="WIDTH: 70%;" id="txtNPT_WrkExtension_1" onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("WrkExtension")'>
                        </div>
                   </div>
                </div>
                    </td>
                </tr>               
                <tr>
                     <td width="5%">2.</td>
                    <td width="70%">Other payments and credits you expect to report on the NPT return.
                    </td>
                    <td style="width:25%">                       
                    <div class="form-horizontal">
                    <div class="form-group no-margin">
                        <div class="">
                            <input type="text" class="form-control input-sm pull-right" style="WIDTH: 70%;" id="txtNPT_WrkExtension_2" onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("WrkExtension")'>
                        </div>
                   </div>
                </div>
                    </td>
                </tr>
                    <tr class="odd">
                         <td width="5%">3.</td>
                    <td width="70%"><b>Tax Balance Due</b> (Line 1 minus Line 2). Enter on the Extension Coupon. If Line 2 is greater than Line 1, no extension coupon is needed
                                               
                    </td>
                    <td style="width:25%">                           
                         <div class="form-horizontal">
                    <div class="form-group no-margin">
                        <div class="">
                              <label id="lblWrkExtension_3" class="form-control input-sm pull-right" style="WIDTH: 70%;"></label>
                        </div>
                    </div>
                   </div>
                    </td>
                    </tr>                   
               
            </tbody>
            </table>
      
       </div>
       </div>  
         <form class="form-horizontal school_form">
        <div class="form-group">
            <div class="col-sm-offset-3 col-sm-9  text-right">
                 <INPUT  id=btnWrkExtGoToPage1 class="btn btn-default submit_button" onclick="ShowPage('WrkE', 'WrkExtension')" type="button"  value="Return to WorkSheet E">
            </div>
        </div>

    </form>                             
    </div>

                               

</body>

</html>
