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
                    <td width="70%"> <u>Worksheet C: Computation Of Estimated Tax Base</u>
<br>
If the amount on Line 3 is $100 or less, estimated payments are NOT required. If the amount on Line 3
is greater than $100, enter 25% of the amount on Line 3 on the first estimated coupon (ENP-1), Line 1 and
the second estimated coupon (ENP-2), Line 1. If Net Profits Tax estimated payments are required, there
are two payments due. The 1st estimated tax payment is due April 15, 2016 and the 2nd estimated tax payment is due June 15, 2016. <b>Estimated tax payments are not required on September 15, 2016 or January 15, 2017.</b>
                                                
                    </td>
                    <td style="width:25%">
                                               
                        </td>
                </tr>
                <tr>
                    <td>1.  Net Profits Liability from Page 1, Line 11
                        <%-- <label  class="lblLink label_NoLeft"  onclick="if($(this).attr('disabled')!='disabled'){ShowPage('Page1', 'WrkC')}">Click for Page1</label>--%>
                    </td>
                    <td style="width:25%">                       
                         <div class="form-horizontal">
                      <div class="form-group no-margin">
                        <div class="input-group">
                       <label style="WIDTH: 100%" id="lblNPT_WrkC_1"></label>
                        </div>
                   </div>
                </div>
                    </td>
                </tr>
                <tr class="odd">
                    <td width="70%">2.   Business Income & Receipts Tax Credit from Page 1, Line 12a 
                         <label  class="lblLink label_NoLeft"  onclick="if($(this).attr('disabled')!='disabled'){ShowPage('Page1', 'WrkC')}">Click for Page1</label>
Or Worksheet D, Line 8
                     <label  class="lblLink label_NoLeft" onclick="if($(this).attr('disabled')!='disabled'){ShowPage('WrkD')}">Click here for Worksheet D</label>                          
                    </td>
                    <td style="width:25%">                       
                        <div class="form-horizontal">
                      <div class="form-group no-margin">
                        <div class="input-group">
                       <label style="WIDTH: 100%" id="lblNPT_WrkC_2" ></label>
                        </div>
                   </div>
                </div>
                   </td>
                </tr>
                <tr>
                    <td>3.   Estimated Payment Base[Calculated - Subtract Line 2 from Line 1]<br />
                        If Line 2 is greater than Line 1, no Estimate coupon is needed
                    </td>
                    <td style="width:25%">                       
                        <div class="form-horizontal">
                      <div class="form-group no-margin">
                        <div class="input-group">
                       <label style="WIDTH: 100%" id="lblNPT_WrkC_3" />
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
                         <INPUT  id=btnCGoToPage1 class="btn btn-default submit_button" onclick="ShowPage('Page1', 'WrkC')" type="button"  value="Return to Page 1">
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
