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
<%--<BODY onload='LoadError("WrkE")'>--%>
    


                            <div class="form_segment" id=NPT_WrkE style="DISPLAY: none;">

                                <table summary="Employee Pay Sheet" class="hor-zebra">

                                    <tbody>

                                        <tr class="odd">
                                            <td width="70%"><u>Worksheet E: Summary of Payments and Other Credits</u>
                                                
                                            </td>
                                            <td align="center" class="no_border_right">
                                               
                                               </td>
                                        </tr>
                                        <tr>
                                            <td>1.  2013 Estimated Net Profits Tax Payments</td>
                                            <td align="center" class="no_border_right">
                                                <input class="inpNormal" id="txtNPT_WrkE_1" style="WIDTH: 100%"
                            onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("WrkE")'></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">2.  Payments of 2013 Net Profits Tax made with Application for Extension of Time to File
                                               
                                            </td>
                                            <td align="center" class="no_border_right">
                                                 <input class="inpNormal" id="txtNPT_WrkE_2" style="WIDTH: 100%"
                        onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("WrkE")'>
                                               </td>
                                        </tr>
                                        <tr>
                                            <td>3.   Overpayment of 2013 Business Income & Receipts Tax or 2011 Net Profits Tax to be applied to this tax return</td>
                                            <td align="center" class="no_border_right">
                                              <input class="inpNormal" id="txtNPT_WrkE_3" style="WIDTH: 100%"
                        onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("WrkE")'></td>
                                        </tr>
                                         <tr class="odd">
                                            <td width="70%">4.  Total of lines 1 through 3. Enter here and on Page 1, Line 6b [Calculated - Add lines 1 through 3]
                                               
                                            </td>
                                            <td align="center" class="no_border_right">
                                                  <label class="" id="lblNPT_WrkE_4"
                        style="WIDTH: 100%">
                                               </td>
                                        </tr>
                                 </tbody>
                                    </table>
                             <div class="form_segment here_input_table" align="right">
                                 <INPUT  id="btnWrkEGoToPage1" class="submit_button2" onclick='gotoPage1()' type="button"  value="Return to Page 1">
                               
                            </div>
                             
                          </div>

                               

</body>
</html>

