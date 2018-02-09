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
    <div class="form-group" id=NPT_WrkA style="DISPLAY: none;">
         <div class="row table-responsive">
       <div class="col-lg-12" >
        <table summary="Employee Pay Sheet" class="table table-condensed table-striped custom_table03">
        <tbody>
             <tr class="odd">
                    <td width="70%"><p><U>WORKSHEET A: Business Income (Loss) for Residents</U>  <br />

                        Enter on Line 1 the net income or loss from the appropriate Federal Tax return(s) or if applicable, the Profit and Loss Statement.<br /><br />

         Examples of Line 2 adjustments (not all inclusive): Federal Form 1040, Schedule "C" filers - add back to net income any taxes based on net income which
have been deducted in arriving at reported net income, e.g., prior year Net Profits Tax (the Business Income & Receipts Tax paid is deductible).
Federal Form 1065 filers - add back to net income any taxes based on net income, capital gains, and guaranteed payments to partners; deduct from net
income IRC section 179 expense. Nonresidents may take an income exclusion for Public Law 86-272 activity.<br /> <br />

         Line 3 includes taxable income from the sale of business capital assets, income from estates or trusts, and income from patents and royalties.</p>
                                                
                    </td>
                    <td align="center" class="no_border_right">
                                               
                        </td>
                </tr>
            <tr class="odd">
                <td width="70%">1. Net Income (Loss)
                                                
                </td>
                <td style="width:25%">                    
                     <div class="form-horizontal">
                      <div class="form-group no-margin">
                        <div class="">
                    <INPUT  id=txtNPT_WrkA_1 class="form-control input-sm"  onfocus=SetFocus() maxLength=10 onchange="ValidateWorksheet('WrkA')">
                        </div>
                   </div>
                </div>
                </td>
            </tr>
            <tr>
                <td>2.  Federal Form 1065, Schedule K-1 and other adjustments</td>
                <td style="width:25%">                       
                     <div class="form-horizontal">
                      <div class="form-group no-margin">
                        <div class="">
                    <INPUT  id=txtNPT_WrkA_2 class="form-control input-sm"  onfocus=SetFocus() maxLength=10 onchange="ValidateWorksheet('WrkA')">
                        </div>
                   </div>
                </div>
                </td>
            </tr>
            <tr class="odd">
                <td width="70%">3.  Other taxable income
                                               
                </td>
                <td style="width:25%">                       
                     <div class="form-horizontal">
                      <div class="form-group no-margin">
                        <div class="">
                    <INPUT  id=txtNPT_WrkA_3 class="form-control input-sm"  onfocus=SetFocus() maxLength=10 onchange="ValidateWorksheet('WrkA')">
                        </div>
                   </div>
                </div>
               </td>
            </tr>
            <tr>
                <td>4.   Taxable Resident Net Income (Loss)[Calculated - Add lines 1 through 3]</td>
                <td style="width:25%">                   
                      <div class="form-horizontal">
                      <div class="form-group no-margin">
                        <div class="">
                   <LABEL id=lblNPT_WrkA_4 style="width:100%"></LABEL>
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
                        
                         <INPUT  id=btnGoToPage1 class="btn btn-default submit_button" onclick="ShowPage('Page1', 'WrkA')" type="button"  value="Return to Page 1">
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
