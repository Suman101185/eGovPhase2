<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
   <script language="javascript" type="text/javascript">
       $(document).ready(function () {
           LoadError("WrkB");
       });
        </script>
    
    <title></title>
</head>
    <body>
<%--<BODY onload="LoadError('WrkB')">--%>   

 <div class="form_segment" id="NPT_WrkB" <%--style="DISPLAY: none;"--%>>

                                <table summary="Employee Pay Sheet" class="hor-zebra">

                                    <tbody>

                                        <tr class="odd">
                                            <td width="70%"><U>Worksheet B: Business Income (Loss) for Non-Residents</U>
    <br>Non-residents of Philadelphia that need to apportion their income on <b>Worksheet NR-3</b> cannot
    file electronically
                                                
                                            </td>
                                            <td align="center" class="no_border_right">
                                               
                                               </td>
                                        </tr>
                                        <tr>
                                            <td>1.  Net Income (Loss)</td>
                                            <td align="center" class="no_border_right">
                                                 <INPUT class=inpNormal id=txtNPT_WrkB_1 style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange="ValidateWorksheet('WrkB')"></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">2.  Federal Form 1065, Schedule K-1 and other adjustments
                                               
                                            </td>
                                            <td align="center" class="no_border_right">
                                                  <INPUT class=inpNormal id=txtNPT_WrkB_2 style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange="ValidateWorksheet('WrkB')">
                                               </td>
                                        </tr>
                                        <tr>
                                            <td>3.  Other taxable income</td>
                                            <td align="center" class="no_border_right">
                                               <INPUT class=inpNormal id=txtNPT_WrkB_3 style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange="ValidateWorksheet('WrkB')"></td>
                                        </tr>

                                         <tr class="odd">
                                            <td width="70%">4.  Total Net Income (Loss) [Calculated - Add lines 1 through 3]
                                               
                                            </td>
                                            <td align="center" class="no_border_right">
                                                <LABEL class="" id=lblNPT_WrkB_4 
      style="WIDTH: 100%"></LABEL>
                                               </td>
                                        </tr>
                                        <tr style="DISPLAY: none; VISIBILTY: hidden">
                                            <td>5.  Net Income apportioned outside Philadelphia from Page 4, Line 14,
    Worksheet NR-3</td>
                                            <td align="center" class="no_border_right">
                                               <LABEL class="" id=lblNPT_WrkB_5 style="WIDTH: 100%"></LABEL></td>
                                        </tr>

                                         <tr class="odd" style="DISPLAY: none; VISIBILTY: hidden">
                                            <td width="70%">6.  Taxable Non-Residents Net Income (Loss)[Calculated - Subtract Line 5 from Line 4]
                                               
                                            </td>
                                            <td align="center" class="no_border_right">
                                               <LABEL class=inpReadOnlyRt id=lblNPT_WrkB_6 
      style="WIDTH: 100%"></LABEL>
                                               </td>
                                        </tr>
                                        
                                 </tbody>
                                    </table>
                             <div class="form_segment here_input_table" align="right">
                                 <INPUT  id=btnGoToPage1 class="submit_button2" onclick="ShowPage('Page1', 'WrkB')" type="button"  value="Return to Page 1">
                               
                            </div>
                             
                          </div>

                               

</body>
</html>
