<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
  <%--  <meta name="viewport" content="width=device-width" />--%>
     <script language="javascript" type="text/javascript">
         $(document).ready(function () {
             LoadError("WrkA");
         });
        </script>
    <title></title>
</head>
<body>
<%--<BODY onload='LoadError("WrkK")'>--%>
    <div class="form-group" id="NPT_WrkA" style="DISPLAY: none;">
         <div class="row table-responsive">
       <div class="col-lg-12" >
        <table summary="Employee Pay Sheet" class="table table-condensed table-striped custom_table03">
        <tbody>
              <tr class="odd">
                    <td width="70%"><U>Worksheet A: Business Income (Loss) for Residents</U>  
                                                
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
             <tr>
                <td>5.  Taxable Pro Rata Resident portion of Net Income/Loss NOT eligible for Income-based rate.<br />
Enter here and on Page 1, Line 1
                     <%--<label  class="lblLink label_NoLeft"  onclick="if($(this).attr('disabled')!='disabled'){ShowPage('Page1', 'WrkA')}">Click for Page1</label>--%>
                </td>
                <td style="width:25%">                   
                      <div class="form-horizontal">
                      <div class="form-group no-margin">
                        <div class="">
                   <INPUT  id=txtNPT_WrkA_5 class="form-control input-sm"  onfocus=SetFocus() maxLength=10 onchange="ValidateWorksheet('WrkA')">
                        </div>
                   </div>
                </div>
                </td>
            </tr>
             <tr>
                <td>6. Taxable Pro Rata Resident portion of Net Income/Loss eligible for Income-based rate.<br />
Enter here and on Page 1, Line 3
                     <%--<label  class="lblLink label_NoLeft"  onclick="if($(this).attr('disabled')!='disabled'){ShowPage('Page1', 'WrkA')}">Click for Page1</label>--%>
                </td>
                <td style="width:25%">                   
                      <div class="form-horizontal">
                      <div class="form-group no-margin">
                        <div class="">
                    <INPUT  id=txtNPT_WrkA_6 class="form-control input-sm"  onfocus=SetFocus() maxLength=10 onchange="ValidateWorksheet('WrkA')">
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
