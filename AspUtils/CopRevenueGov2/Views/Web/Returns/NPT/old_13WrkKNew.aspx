<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head >
   <script language="javascript" type="text/javascript">
       $(document).ready(function () {
           LoadError("WrkK");
       });
        </script>
    
    <title></title>
</head>
    <body>
<%--<BODY onload='LoadError("WrkK")'>--%>
    


                            <div class="form_segment" id='NPT_WrkK' style="DISPLAY: none;">

                                <table summary="Employee Pay Sheet" class="hor-zebra">

                                    <tbody>

                                        <tr class="odd">
                                            <td width="70%"><u>Worksheet K: 60% Business Income & Receipts Tax Credit</u>
                                            </td>
                                            <td align="center" class="no_border_right">
                                               
                                               </td>
                                        </tr>
                                        <tr>
                                            <td>1.   Enter the amount from Page 1, Line 1 of the 2012 BIRT-EZ return or
    the Summary Page, Line 1 of the 2012 Business Income & Receipts Tax return</td>
                                            <td align="center" class="no_border_right">
                                               <input class="inpNormal" id="txtNPT_WrkK_1" style="WIDTH: 100%"
                            onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("WrkK")'></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">
                                                <input id="chkCorpMembers" type="checkbox" onclick="chkCorpMembers_onclick()">
                                             Check if entity has Corporate Members
                                            </td>
                                            <td align="center" class="no_border_right">
                                                 
                                               </td>
                                        </tr>
                                        <tr>
                                            <td>2.   Enter 60% of the amount on Line 1. If your entity has corporate members <b>Stop Here</b> and go to Page 3, Worksheet D - 
                                                <label class="lblLink label_NoLeft"  onclick='ShowPage("WrkD")'>Click here Worksheet D</label>
                                            </td>
                                            <td align="center" class="no_border_right">
                                             <label class="" id="lblNPT_WrkK_2"
                        style="WIDTH: 100%">
                    </label></td>
                                        </tr>
                                         <tr class="odd">
                                            <td width="70%">3.  Enter the amount from Page 1, Line 5 of the 2012 Net Profits Tax Return
                                               
                                            </td>
                                            <td align="center" class="no_border_right">
                                                 <label class="" id="lblNPT_WrkK_3" style="WIDTH: 100%"></label>
                                               </td>
                                        </tr>
                                           <tr>
                                            <td>4.   Business Income & Receipts Tax credit allowed. Enter the lesser of Line 2 or Line 3 here and on Page 1, Line 6a
                                               </td>
                                            <td align="center" class="no_border_right">
                                            <label class="" id="lblNPT_WrkK_4" style="WIDTH: 100%"></label>
                   </td>
                                        </tr>
                                 </tbody>
                                    </table>
                             <div class="form_segment here_input_table" align="right">
                                 <INPUT  id=btnWrkEGoToPage1 class="submit_button2" onclick="ShowPage('Page1', 'WrkK')" type="button"  value="Return to Page 1">
                               
                            </div>
                             
                          </div>

                               

</body>
</html>
