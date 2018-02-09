<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>   
     <script language="javascript" type="text/javascript">
         $(document).ready(function () {
             LoadError("WrkK");
         });
        </script>
    <title></title>
</head>
<body>
<%--<BODY onload='LoadError("WrkK")'>--%>
    <div class="form-group" id='NPT_WrkK' style="DISPLAY: none;">
        <div class="row table-responsive">
      <div class="col-lg-12" >
        <table summary="Employee Pay Sheet" class="table table-condensed table-striped custom_table03">
            <tbody>
                <tr class="odd">
                    <td width="70%"><u>Worksheet K: 60% Business Income & Receipts Tax Credit</u>
                    </td>
                    <td style="width:25%">
                                               
                        </td>
                </tr>
                <tr>
                    <td>1.   Enter the amount from Page 1, Line 1 of the 2013 BIRT-EZ return or
the Summary Page, Line 1 of the 2013 Business Income & Receipts Tax return</td>
                    <td style="width:25%">                        
                   <div class="form-horizontal">
                    <div class="form-group no-margin">
                        <div class="">
                           <input class="form-control input-sm" id="txtNPT_WrkK_1" onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("WrkK")'>
                        </div>
                   </div>
                </div>
                    </td>
                </tr>
                <tr class="odd">
                    <td width="70%">
                        <input id="chkCorpMembers" type="checkbox" onclick="chkCorpMembers_onclick()">
                        Check if entity has Corporate Members
                    </td>
                    <td style="width:25%">
                                                 
                        </td>
                </tr>
                <tr>
                    <td>2.   Enter 60% of the amount on Line 1. If your entity has corporate members <b>Stop Here</b> and go to Page 3, Worksheet D - 
                        <label class="lblLink label_NoLeft"  onclick='ShowPage("WrkD")'>Click here Worksheet D</label>
                    </td>
                    <td style="width:25%">                       
                    <div class="form-horizontal">
                    <div class="form-group no-margin">
                        <div class="">
                           <label style="WIDTH: 100%" id="lblNPT_WrkK_2" ></label>
                        </div>
                   </div>
                </div>
                    </td>
                </tr>
                    <tr class="odd" id="CorpMembers_1"  style="DISPLAY: block; VISIBILTY: visible">
                    <td width="70%">3.  Enter the amount from Page 1, Line 5 of the 2013 Net Profits Tax Return
                                               
                    </td>
                    <td style="width:25%">                           
                         <div class="form-horizontal">
                    <div class="form-group no-margin">
                        <div class="">
                           <label style="WIDTH: 100%" id="lblNPT_WrkK_3" ></label>
                        </div>
                   </div>
                </div>
                        </td>
                    </tr>
                    <tr id="CorpMembers_2"  style="DISPLAY: block; VISIBILTY: visible">
                    <td>4.   Business Income & Receipts Tax credit allowed. Enter the lesser of Line 2 or Line 3 here and on Page 1, Line 6a
                        </td>
                    <td style="width:25%">                    
                        <div class="form-horizontal">
                    <div class="form-group no-margin">
                        <div class="">
                          <label  id="lblNPT_WrkK_4" style="WIDTH: 100%"></label>
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
                   <INPUT  id=btnKGoToPage1 class="btn btn-default submit_button" onclick="ShowPage('Page1', 'WrkK')" type="button"  value="Return to Page 1">
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
