<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head runat="server">
   <script language="javascript" type="text/javascript">
       //$(document).ready(function () {
       //    LoadError("WrkC");
       //});
        </script>
    <title></title>
</head>
<body>
<%--<BODY onload="LoadError('WrkC')">--%>
    


                            <div class="form_segment" id=NPT_WrkC style="DISPLAY: none;">

                                <table summary="Employee Pay Sheet" class="hor-zebra">

                                    <tbody>

                                        <tr class="odd">
                                            <td width="70%"> <u>Worksheet C: Computation Of Estimated Tax Base</u>
                        <br>
                        If the amount on Line 3 is $100 or less, estimated payments are NOT required. If the amount on Line 3
    is greater than $100, enter 25% of the amount on Line 3 on the first estimated coupon (ENP-1), Line 1 and
    the second estimated coupon (ENP-2), Line 1. If Net Profits Tax estimated payments are required, there
    are two payments due. The 1st estimated tax payment is due April 15, 2015 and the 2nd estimated tax payment is due June 15, 2015. <b>Estimated tax payments are not required on September 15, 2015 or January 15, 2016.</b>
                                                
                                            </td>
                                            <td align="center" class="no_border_right">
                                               
                                               </td>
                                        </tr>
                                        <tr>
                                            <td>1.  Net Profits Liability from Page 1, Line 5</td>
                                            <td align="center" class="no_border_right">
                                                <label class="" id="lblNPT_WrkC_1" style="WIDTH: 100%"></label></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">2.   Business Income & Receipts Tax Credit from <label id="lnkWrkA" class="lblLink label_NoLeft" onclick="if($(this).attr('disabled')!='disabled'){ShowPage('Page1')}"> Page 1, Line 6a</label> or Page 3, Worksheet D, Line 8 
    Worksheet D, Line 8
                                               
                                            </td>
                                            <td align="center" class="no_border_right">
                                                <label class="inpReadOnlyRt" id="lblNPT_WrkC_2" style="WIDTH: 100%"></label>
                                               </td>
                                        </tr>
                                        <tr>
                                            <td>3.   Estimated Payment Base[Calculated - Subtract Line 2 from Line 1]</td>
                                            <td align="center" class="no_border_right">
                                               <label class="" id="lblNPT_WrkC_3"
                        style="WIDTH: 100%"></td>
                                        </tr>
                                      
                                 </tbody>
                                    </table>
                             <div class="form_segment here_input_table" align="right">
                                 <INPUT  id=btnGoToPage1 class="submit_button2" onclick="ShowPage('Page1', 'WrkC')" type="button"  value="Return to Page 1">
                               
                            </div>
                             
                          </div>

                               

</BODY>
</html>
