<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
 <script language="javascript" type="text/javascript">
     $(document).ready(function () {
         LoadError("WrkA");
     });
        </script>
    
    <title></title>
</head>
    <body>
<%--<BODY onload=LoadError("WrkA")>--%>
    


                            <div class="form_segment" id=NPT_WrkA <%--style="DISPLAY: none;"--%>>

                                <table summary="Employee Pay Sheet" class="hor-zebra">

                                    <tbody>

                                        <tr class="odd">
                                            <td width="70%">1. Net Income (Loss)
                                                
                                            </td>
                                            <td align="center" class="no_border_right">
                                                <INPUT class=inpNormal id=txtNPT_WrkA_1 style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange="ValidateWorksheet('WrkA')">
                                               </td>
                                        </tr>
                                        <tr>
                                            <td>2.  Federal Form 1065, Schedule K-1 and other adjustments</td>
                                            <td align="center" class="no_border_right">
                                                 <INPUT class=inpNormal id=txtNPT_WrkA_2 style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange="ValidateWorksheet('WrkA')"></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">3.  Other taxable income
                                               
                                            </td>
                                            <td align="center" class="no_border_right">
                                                  <INPUT class=inpNormal id=txtNPT_WrkA_3 style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange="ValidateWorksheet('WrkA')">
                                               </td>
                                        </tr>
                                        <tr>
                                            <td>4.   Taxable Resident Net Income (Loss)[Calculated - Add lines 1 through 3]</td>
                                            <td align="center" class="no_border_right">
                                               <LABEL id=lblNPT_WrkA_4 
      style="WIDTH: 100%"></LABEL></td>
                                        </tr>
                                 </tbody>
                                    </table>
                             <div class="form_segment here_input_table" align="right">
                                 <INPUT  id=btnGoToPage1 class="submit_button2" onclick="ShowPage('Page1','WrkA')" type="button"  value="Return to Page 1">
                               
                            </div>
                             
                          </div>

                               

</body>
</html>
