<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>   
     <script language="javascript" type="text/javascript">
         $(document).ready(function () {
             LoadError("WrkExtension");
         });
        </script>
    <title></title>
</head>
<body>
    <div class="form-group" id='NPT_WrkExtension' style="DISPLAY: none;">
        <div class="row table-responsive">
      <div class="col-lg-12" >
        <table summary="Employee Pay Sheet" class="table table-condensed table-striped custom_table03">
            <tbody>
                <tr class="odd">
                     <td width="5%"></td>
                    <td width="70%"><b><u>EXTENSION WORKSHEET</u></b>
                    </td>
                    <td style="width:25%">
                                               
                        </td>
                </tr>
                <tr>
                      <td width="5%">1.</td>
                    <td width="70%">100% of estimated 2013 NET PROFITS tax due</td>
                    <td style="width:25%">                        
                   <div class="form-horizontal">
                    <div class="form-group no-margin">
                        <div class="">                          
                             <input type="text" class="form-control input-sm pull-right" style="WIDTH: 70%;" id="txtNPT_WrkExtension_1" onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("WrkExtension")'>
                        </div>
                   </div>
                </div>
                    </td>
                </tr>               
                <tr>
                     <td width="5%">2.</td>
                    <td width="70%">Other payments and credits you expect to report on the NPT return.
                    </td>
                    <td style="width:25%">                       
                    <div class="form-horizontal">
                    <div class="form-group no-margin">
                        <div class="">
                            <input type="text" class="form-control input-sm pull-right" style="WIDTH: 70%;" id="txtNPT_WrkExtension_2" onfocus="SetFocus()" maxlength="10" onchange='ValidateWorksheet("WrkExtension")'>
                        </div>
                   </div>
                </div>
                    </td>
                </tr>
                    <tr class="odd">
                         <td width="5%">3.</td>
                    <td width="70%">Tax Balance Due (Line 1 minus Line 2).
                                               
                    </td>
                    <td style="width:25%">                           
                         <div class="form-horizontal">
                    <div class="form-group no-margin">
                        <div class="">
                              <label id="lblWrkExtension_3" class="form-control input-sm pull-right" style="WIDTH: 70%;"></label>
                        </div>
                    </div>
                   </div>
                    </td>
                    </tr>                   
               
            </tbody>
            </table>
      
       </div>
       </div>  
         <form class="form-horizontal school_form">
        <div class="form-group">
            <div class="col-sm-offset-3 col-sm-9  text-right">
                 <INPUT  id=btnWrkExtGoToPage1 class="btn btn-default submit_button" onclick="ShowPage('WrkE', 'WrkExtension')" type="button"  value="Return to WorkSheet E">
            </div>
        </div>

    </form>                             
    </div>

                               

</body>

</html>
