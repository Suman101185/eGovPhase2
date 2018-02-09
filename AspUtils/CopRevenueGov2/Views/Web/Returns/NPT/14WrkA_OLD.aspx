<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <script language="javascript" type="text/javascript">
        $(document).ready(function () {
            LoadError("WrkA");
        });
        </script>
    <title></title>
</head>
 <body>
<%--<BODY onload=LoadError("WrkA")>--%>
    
     <p><strong>WORKSHEET A: Business Income (Loss) for Residents</strong><br /><br />
Enter on Line 1 the net income or loss from the appropriate Federal Tax return(s) or if applicable, the Profit and Loss Statement.<br /><br />

         Examples of Line 2 adjustments (not all inclusive): Federal Form 1040, Schedule "C" filers - add back to net income any taxes based on net income which
have been deducted in arriving at reported net income, e.g., prior year Net Profits Tax (the Business Income & Receipts Tax paid is deductible).
Federal Form 1065 filers - add back to net income any taxes based on net income, capital gains, and guaranteed payments to partners; deduct from net
income IRC section 179 expense. Nonresidents may take an income exclusion for Public Law 86-272 activity.<br /> <br />

         Line 3 includes taxable income from the sale of business capital assets, income from estates or trusts, and income from patents and royalties.
     </p>		

                            <div class="form_segment" id=NPT_WrkA style="DISPLAY: none;">

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
                                 <INPUT  id=btnGoToPage1 class="submit_button2" onclick="ShowPage('Page1', 'WrkA')" type="button"  value="Return to Page 1">
                               
                            </div>
                             
                          </div>

                               

</body>

</html>
