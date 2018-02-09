<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head runat="server">
     <script language="javascript" type="text/javascript">
         $(document).ready(function () {
             LoadError("WrkExtension");
         });
        </script>
    <title></title>
</head>
<body>
   <div class="form_segment" id='NPT_WrkExtension' <%--style="DISPLAY: none;"--%>>

                                <table summary="Employee Pay Sheet" class="hor-zebra">

                                    <tbody>

                                        <tr class="odd">
                                            <td width="70%"><u>Worksheet K: 60% Business Income & Receipts Tax Credit</u>
                                            </td>
                                            <td align="center" class="no_border_right">
                                               
                                               </td>
                                        </tr>
                                        <tr>
                                            <td>1.   100% of estimated 2014 NET PROFITS tax due</td>
                                            <td align="center" class="no_border_right">
                                               <input class="inpNormal" id="txtNPT_WrkExtension_1" style="WIDTH: 100%"
                            onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("WrkExtension")'></td>
                                        </tr>
                                        
                                        <tr class="odd">
                                            <td>2.   Other payments and credits you expect to report on the NPT return
                                                
                                            </td>
                                            <td align="center" class="no_border_right">
                                              <input class="inpNormal" id="txtNPT_WrkExtension_2" style="WIDTH: 100%"
                            onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("WrkExtension")'></td>
                    
                                        </tr>
                                         <tr >
                                            <td width="70%">3.  Tax Balance Due (Line 1 minus Line 2).
                                               
                                            </td>
                                            <td align="center" class="no_border_right">
                                                <label id="lblWrkExtension_3" style="WIDTH: 100%"></label>
                                                <%-- <input class="inpNormal" id="txtNPT_WrkExtension_3" style="WIDTH: 100%"
                            onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("WrkExtension")'>--%>
                                               </td>
                                        </tr>
                                          
                                 </tbody>
                                    </table>
                             <div class="form_segment here_input_table" align="right">
                                 <INPUT  id=btnWrkEGoToPage1 class="submit_button2" onclick="ShowPage('Page1', 'WrkExtension')" type="button"  value="Return to WorkSheet E">
                               
                            </div>
                             
                          </div>
</body>
</html>
