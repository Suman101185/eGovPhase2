<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width" />
    <title></title>
</head>
<body onload='LoadError("WrkD")'>
    <div class="form_segment" id="NPT_WrkD" style="DISPLAY: none;">

                                <table summary="Employee Pay Sheet" class="hor-zebra">

                                    <tbody>

                                        <tr class="odd">
                                            <td width="70%">  <u><b>Worksheet D:</u> Allocation of Business Income & Receipts Tax credit for partnerships, etc., with corporate members (this schedule is to be used only by partnerships, joint ventures and associations which are composed of one or more corporate partners, corporate joint ventures, or corporate associates.)</b>
                                            </td>
                                            <td align="center" class="no_border_right">
                                               
                                               </td>
                                        </tr>
                                        <tr>
                                            <td>1.  Enter the portion of taxable income on which 2014 Business Income & Receipts Tax has been paid, AND which represents the distributive shares of ALL CORPORATE MEMBERS</td>
                                            <td align="center" class="no_border_right">
                                                  <input class="inpNormal" id="txtNPT_WrkD_1" style="WIDTH: 100%"
                            onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("WrkD")'></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">2.  Enter the total taxable income of the taxpayer on which 2014 BIRT has been paid
                                               
                                            </td>
                                            <td align="center" class="no_border_right">
                                                 <input class="inpNormal" id="txtNPT_WrkD_2" style="WIDTH: 100%"
                        onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("WrkD")'>
                                               </td>
                                        </tr>
                                        <tr>
                                            <td>3.  Divide Line 1 by 2 and enter the percentage here</td>
                                            <td align="center" class="no_border_right">
                                               <label class="inpReadOnlyRt" id="lblNPT_WrkD_3"
                        style="WIDTH: 100%"></td>
                                        </tr>

                                         <tr class="odd">
                                            <td width="70%">4.  Enter the amount from Page 3, Worksheet K, Line 2
                                                 <label class="lblLink label_NoLeft" onclick='ShowPage("WrkK")'>Click here for Worksheet K</label>
                                            </td>
                                            <td align="center" class="no_border_right">
                                               <label class="" id="lblNPT_WrkD_4"
                        style="WIDTH: 100%">
                    </label>
                                               </td>
                                        </tr>
                                        <tr >
                                            <td>5.  Multiply the amount on Line 4 by the percentage on Line 3</td>
                                            <td align="center" class="no_border_right">
                                               <label class="" id="lblNPT_WrkD_5"
                        style="WIDTH: 100%"></td>
                                        </tr>

                                         <tr class="odd" >
                                            <td width="70%">6.  Subtract Line 5 from Line 4
                                               
                                            </td>
                                            <td align="center" class="no_border_right">
                                                <label class="" id="lblNPT_WrkD_6"
                        style="WIDTH: 100%">
                                               </td>
                                        </tr>

                                        <tr >
                                            <td>7.  Enter the amount from Page 1, Line 5</td>
                                            <td align="center" class="no_border_right">
                                              <label class="" id="lblNPT_WrkD_7"
                        style="WIDTH: 100%"></td>
                                        </tr>

                                         <tr class="odd" >
                                            <td width="70%">8.  <b>Business Income & Receipts Tax Credit allowed.</b> Enter
    the lesser of Line 6 or Line 7 here, and on Page 1, Line 6a
                                               
                                            </td>
                                            <td align="center" class="no_border_right">
                                               <%-- <label class="" id="lblNPT_WrkD_8"
                        style="WIDTH: 100%">
                    </label>--%>
                                                <input class="inpNormal" id="txtNPT_WrkD_8" style="WIDTH: 100%"
                            onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("WrkD")'>
                                               </td>
                                        </tr>
                                        
                                 </tbody>
                                    </table>
                             <div class="form_segment here_input_table" align="right">
                                 <INPUT  id=btnGoToPage1 class="submit_button2" onclick="ShowPage('Page1', 'WrkD')" type="button"  value="Return to Page 1">
                               
                            </div>
                             
                          </div>
</body>
</html>
