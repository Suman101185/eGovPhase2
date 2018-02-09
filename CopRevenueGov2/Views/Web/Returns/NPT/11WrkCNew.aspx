<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
    <script language="javascript" type="text/javascript">
        $(document).ready(function () {
            LoadError("WrkC");
        });
        </script>
 
    <title></title>
</head>
<body>
   <div class="form-group" id=NPT_WrkC style="DISPLAY: none;">
        <div class="row table-responsive">
      <div class="col-lg-12" >
        <table summary="Employee Pay Sheet" class="table table-condensed table-striped custom_table03">

            <tbody>

                <tr class="odd">
                     <td width="5%"></td>
                    <td width="70%"><b> <u>Worksheet C: Computation Of Estimated Tax Base</u></b>
<br>
If the amount on Line 3 is $100 or less, estimated payments are NOT required. If the amount on Line 3
is greater than $100, enter 25% of the amount on Line 3 on the first estimated coupon (ENP-1), Line 1 and
the second estimated coupon (ENP-2), Line 1. If Net Profits Tax estimated payments are required, there
are two payments due. The 1st estimated tax payment is due April 17, 2012 and the 2nd estimated tax payment is due June 15, 2012. <b>Estimated tax payments are not required on September 15, 2012 or January 15, 2015.</b>
                                                
                    </td>
                    <td style="width:25%">
                                               
                        </td>
                </tr>
                <tr>
                      <td width="5%">1.</td>
                    <td width="70%">Net Profits Liability from Page 1, Line 5</td>
                    <td style="width:25%">                       
                         <div class="form-horizontal">
                      <div class="form-group no-margin">
                        <div class="">
                       <label class="form-control input-sm pull-right" style="WIDTH: 70%;" id="lblNPT_WrkC_1"></label>
                        </div>
                   </div>
                </div>
                    </td>
                </tr>
                <tr class="odd">
                      <td width="5%">2.</td>
                    <td width="70%">Business Income & Receipts Tax Credit from Page 1, Line 6a 
Worksheet D, Line 8
                                               
                    </td>
                    <td style="width:25%">                       
                        <div class="form-horizontal">
                      <div class="form-group no-margin">
                        <div class="">
                       <label class="form-control input-sm pull-right" style="WIDTH: 70%;" id="lblNPT_WrkC_2" ></label>
                        </div>
                   </div>
                </div>
                   </td>
                </tr>
                <tr>
                      <td width="5%">3.</td>
                    <td width="70%">Estimated Payment Base[Calculated - Subtract Line 2 from Line 1]</td>
                    <td style="width:25%">                       
                        <div class="form-horizontal">
                      <div class="form-group no-margin">
                        <div class="">
                       <label class="form-control input-sm pull-right" style="WIDTH: 70%;" id="lblNPT_WrkC_3" />
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
                 <INPUT  id=btnCGoToPage1 class="btn btn-default submit_button" onclick="ShowPage('Page1', 'WrkC')" type="button"  value="Return to Page 1">
            </div>
        </div>

    </form>                              
    </div>
</body>
</html>
