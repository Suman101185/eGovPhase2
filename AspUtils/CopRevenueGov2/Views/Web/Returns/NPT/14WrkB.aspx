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
        <table summary="Employee Pay Sheet" class="table table-condensed table-striped custom_table03">

            <tbody>

                <tr class="odd">
                    <td width="70%"><U>Worksheet B: Business Income (Loss) for Non-Residents</U>
    <br>Nonresidents of Philadelphia may apportion all or part of their net income to their places of business located outside of Philadelphia on Line 5, using <b>Worksheet NR-3</b> 
                                                The apportionment is based on a three factor formula consisting of an average of the property owned, the salaries and
wages paid, and the receipts earned during the tax year.
                                                
                    </td>
                    <td align="center" class="no_border_right">
                                               
                        </td>
                </tr>
                <tr>
                    <td>1.  Net Income (Loss)</td>
                    <td style="width:25%">                           
                         <div class="form-horizontal">
                    <div class="form-group no-margin">
                        <div class="">
                            <INPUT  id=txtNPT_WrkB_1 class="form-control input-sm" onfocus=SetFocus() maxLength=10 onchange="ValidateWorksheet('WrkB')">
                        </div>
                   </div>
                </div>
                    </td>
                </tr>
                <tr class="odd">
                    <td width="70%">2.  Federal Form 1065, Schedule K-1 and other adjustments
                                               
                    </td>
                    <td style="width:25%">                           
                          <div class="form-horizontal">
                    <div class="form-group no-margin">
                        <div class="">
                             <INPUT  id=txtNPT_WrkB_2 class="form-control input-sm"  onfocus=SetFocus() maxLength=10 onchange="ValidateWorksheet('WrkB')">
                        </div>
                   </div>
                </div>
                        </td>
                </tr>
                <tr>
                    <td>3.  Other taxable income</td>
                    <td style="width:25%">                       
                      <div class="form-horizontal">
                       <div class="form-group no-margin">
                        <div class="">
                             <INPUT  id=txtNPT_WrkB_3 class="form-control input-sm"  onfocus=SetFocus() maxLength=10 onchange="ValidateWorksheet('WrkB')">
                        </div>
                   </div>
                </div>
                    </td>
                </tr>

                    <tr class="odd">
                    <td width="70%">4.  Total Net Income (Loss) [Calculated - Add lines 1 through 3]
                                               
                    </td>
                    <td style="width:25%">                      
                     <div class="form-horizontal">
                     <div class="form-group no-margin">
                        <div class="">
                              <LABEL style="WIDTH: 100%" id=lblNPT_WrkB_4 style="WIDTH: 100%"></LABEL>
                        </div>
                   </div>
                </div>
                  </td>
                </tr>
                <tr <%--style="DISPLAY: none; VISIBILTY: hidden"--%>>
                    <td>5.  Net Income apportioned outside Philadelphia from Page 4, Line 12,
    Worksheet NR-3
 <label class="lblLink label_NoLeft" onclick='ShowPage("Page4")'>Click here for Worksheet NR-3</label>
                    </td>
                    <td style="width:25%">                       
                        <div class="form-horizontal">
                     <div class="form-group no-margin">
                        <div class="">
                              <LABEL style="WIDTH: 100%" id=lblNPT_WrkB_5 ></LABEL>
                        </div>
                   </div>
                </div>
                    </td>
                </tr>

                    <tr class="odd" <%--style="DISPLAY: none; VISIBILTY: hidden"--%>>
                    <td width="70%">6.  Taxable Non-Residents Net Income (Loss)[Calculated - Subtract Line 5 from Line 4]
                                               
                    </td>
                    <td style="width:25%">                       
                           <div class="form-horizontal">
                     <div class="form-group no-margin">
                        <div class="">
                              <LABEL  id=lblNPT_WrkB_6 style="WIDTH: 100%"></LABEL>
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
                          <INPUT  id=btnBGoToPage1 class="btn btn-default submit_button" onclick="ShowPage('Page1', 'WrkB')" type="button"  value="Return to Page 1">
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
