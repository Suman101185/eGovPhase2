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
   <div class="form-group" id="NPT_WrkB" style="DISPLAY: none;">
       <div class="row table-responsive">
      <div class="col-lg-12" >
        <table summary="Employee Pay Sheet" class="table table-condensed table-striped custom_table03 wage-table-print">

            <tbody>

                <tr class="odd">
                    <td width="5%"></td>
                    <td width="70%"><b><U>Worksheet B: Business Income (Loss) for Non-Residents</U>
    <br>Non-residents of Philadelphia that need to apportion their income on Worksheet NR-3 cannot
    file electronically</b>
                                                
                    </td>
                    <td align="center" class="no_border_right">
                                               
                        </td>
                </tr>
                <tr>
                     <td width="5%">1.</td>
                    <td width="70%">Net Income (Loss)</td>
                    <td style="width:25%">                           
                         <div class="form-horizontal">
                    <div class="form-group no-margin">
                        <div class="">
                            <INPUT type="text" id="txtNPT_WrkB_1" class="form-control input-sm pull-right" style="WIDTH: 70%;" onfocus=SetFocus() maxLength=10 onchange="ValidateWorksheet('WrkB')">
                        </div>
                   </div>
                </div>
                    </td>
                </tr>
                <tr class="odd">
                     <td width="5%">2.</td>
                    <td width="70%">Federal Form 1065, Schedule K-1 and other adjustments
                                               
                    </td>
                    <td style="width:25%">                           
                          <div class="form-horizontal">
                    <div class="form-group no-margin">
                        <div class="">
                             <INPUT type="text" id="txtNPT_WrkB_2" class="form-control input-sm pull-right" style="WIDTH: 70%;"  onfocus=SetFocus() maxLength=10 onchange="ValidateWorksheet('WrkB')">
                        </div>
                   </div>
                </div>
                        </td>
                </tr>
                <tr>
                     <td width="5%">3.</td>
                    <td width="70%">Other taxable income</td>
                    <td style="width:25%">                       
                      <div class="form-horizontal">
                       <div class="form-group no-margin">
                        <div class="">
                             <INPUT type="text" id="txtNPT_WrkB_3" class="form-control input-sm pull-right" style="WIDTH: 70%;"  onfocus=SetFocus() maxLength=10 onchange="ValidateWorksheet('WrkB')">
                        </div>
                   </div>
                </div>
                    </td>
                </tr>

                <tr class="odd">
                         <td width="5%">4.</td>
                    <td width="70%">Total Net Income (Loss) [Calculated - Add lines 1 through 3]
                                               
                    </td>
                    <td style="width:25%">                      
                     <div class="form-horizontal">
                     <div class="form-group no-margin">
                        <div class="">
                              <LABEL class="form-control input-sm pull-right" style="WIDTH: 70%;" id="lblNPT_WrkB_4" ></LABEL>
                        </div>
                   </div>
                </div>
                  </td>
                </tr>
                <tr style="display:none">
                     <td width="5%">5.</td>
                    <td width="70%">Net Income apportioned outside Philadelphia from Page 4, Line 12,
    Worksheet NR-3
 <label class="lblLink label_NoLeft" onclick='ShowPage("Page4")'>Click for Worksheet NR-3</label>
                    </td>
                    <td style="width:25%">                       
                        <div class="form-horizontal">
                     <div class="form-group no-margin">
                        <div class="">
                              <LABEL class="form-control input-sm pull-right" style="WIDTH: 70%;" id="lblNPT_WrkB_5" ></LABEL>
                        </div>
                   </div>
                </div>
                    </td>
                </tr>

                <tr class="odd" style="display:none">
                         <td width="5%">6.</td>
                    <td width="70%">Taxable Non-Residents Net Income (Loss)[Calculated - Subtract Line 5 from Line 4]
                                               
                    </td>
                    <td style="width:25%">                       
                           <div class="form-horizontal">
                     <div class="form-group no-margin">
                        <div class="">
                              <LABEL  id="lblNPT_WrkB_6" class="form-control input-sm pull-right" style="WIDTH: 70%;"></LABEL>
                        </div>
                   </div>
                </div>
                     </td>
                </tr>
                
                <div style="height:80px;">&nbsp;</div>         
            </tbody>
            </table>
                      <div style="height:80px !important;">&nbsp;</div>

          </div>
           </div>
        <form class="form-horizontal school_form">
        <div class="form-group">
            <div class="col-sm-offset-3 col-sm-9  text-right">
                  <INPUT  id=btnBGoToPage1 class="btn btn-default submit_button" onclick="ShowPage('Page1', 'WrkB')" type="button"  value="Return to Page 1">
            </div>
        </div>

    </form>                                   
    </div>
</body>
</html>
