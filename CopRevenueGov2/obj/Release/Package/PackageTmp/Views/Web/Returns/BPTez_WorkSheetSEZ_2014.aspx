<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width" />
    <script>
        $(document).ready(function () {
            LoadBPTezError();
            PopulateBPTez_WorkSheetData();
        });
        function PopulateBPTez_WorkSheetData() {

            $('#txt_BPT_WSEZ1').val('$0');
            PerformCalcsBPTezWrkShtN();
        }
        function DisplayWrkShtN() {
            PerformCalcsBPTezWrkShtN()
            $('#BPTez_WrkShtNE').css('display', 'block')
        }
        function PerformCalcsBPTezWrkShtN() {          
           GetPage2Line1or2();
            GetPage2Line8();
            GetS2byS3();
            CalcWorkSheetSLine5();           
        } 	//PerformCalcsBPTlfWrkShtN

        function GetPage2Line1or2() {
            
            
            if ($('#radBPTez2_1_2_m2').is(":checked") == true) {
                if (cCur(txtBPTez2_1.value) < 0) {
                    $('#lbl_BPT_WSEZ2').text(ispFormatMoney(0, 0));
                }
                else
                $('#lbl_BPT_WSEZ2').text(txtBPTez2_1.value);
            }
            if ($('#radBPTez2_1_2_m1').is(":checked") == true) {
                if (cCur(txtBPTez2_2.value) < 0) {
                    $('#lbl_BPT_WSEZ2').text(ispFormatMoney(0, 0));
                }
                else
                $('#lbl_BPT_WSEZ2').text(txtBPTez2_2.value);
            }
            var BPTez2_1or2 = $('#lbl_BPT_WSEZ2').text();
            if (cCur(BPTez2_1or2) == 0) {
               
                $('#lbl_BPT_WSEZ2').text(ispFormatMoney(0, 0));
            } 	//if
        } 	//GetPage2Line1or2

        function GetPage2Line8() {
            if (cCur($('#lblBPTez2_8').text()) != 0) {
                debugger;
                if (cCur($('#lblBPTez2_8').text(), 0) > 50000) {
                    $('#txt_BPT_WSEZ1').val(ispFormatMoney(50000, 0));
                }
                else
                    $('#txt_BPT_WSEZ1').val($('#lblBPTez2_8').text());
                $('#lbl_BPT_WSEZ3').text($('#lblBPTez2_8').text());
            } else {
                $('#lbl_BPT_WSEZ3').text(ispFormatMoney(0, 0));

            }
        } 	//GetPage2Line8

        function GetS2byS3() {
            var lbl_BPT_WSEZ;
         
            if ($('#lbl_BPT_WSEZ3').text() != '' && $('#lbl_BPT_WSEZ2').text() != '') {
               
                var calculationvar1 = (cCur($('#lbl_BPT_WSEZ2').text()) / cCur($('#lbl_BPT_WSEZ3').text())) ;

               
                if (isNaN((cCur($('#lbl_BPT_WSEZ2').text()) / cCur($('#lbl_BPT_WSEZ3').text())) ) || calculationvar1 == 'Infinity' || calculationvar1 == 'NAN') {

                    lbl_BPT_WSEZ = '$' + 0 + '.';
                    $('#lbl_BPT_WSEZ4').text(00);
                }
                else {

                    calculationvar1 = calculationvar1.toFixed(6);
                    lbl_BPT_WSEZ = ispFormatMoney(calculationvar1.toString().split(".")[0], 0) + '.';
                    $('#lbl_BPT_WSEZ4').text(lbl_BPT_WSEZ + calculationvar1.toString().split(".")[1]);
                }

            }
        }

        function CalcWorkSheetSLine5() {
            if ($('#txt_BPT_WSEZ1').val() != '' && $('#lbl_BPT_WSEZ4').text() != '') {

                var totamount = cCur($('#lbl_BPT_WSEZ4').text());
                $('#lbl_BPT_WSEZ5').text(ispFormatMoney((cCur($('#txt_BPT_WSEZ1').val()) * totamount), 0));
                $('#lbl_BPTez2_3').text($('#lbl_BPT_WSEZ5').text());
            }
            CalcPage2Line5();
            CalcPage2Line6(dBPTezNetRate);
        }

    </script>
    <title></title>
</head>
<body>
   <div class="form-group" id="BPTez_WrkShtNE" style="DISPLAY: none;">
        <div class="row table-responsive">
     <div class="col-lg-12" >

    <table summary="Employee Pay Sheet" class="table table-condensed table-striped custom_table03 wage-table-print" id="tblBptSchE">

    <tbody>

        <tr>   
             <td width="5%"></td>             
            <td width="70%"><B><U>Worksheet S-EZ - Use to calculate Statutory Net Income Deduction</U></b>
            <td colspan="2" width="25%">
                                              
                </td>
        </tr>                                        
            <tr>      
                 <td width="5%">S1.</td>             
            <td width="70%" class="text-left"> Enter the lower of <label id="Label2" class="lblLink label_NoLeft"  onclick=ShowPage(2) > Line 8 of Page 2 </label> or $50,000 </td>
            <td colspan="2" align="center" width="25%">                
                <div class="form-horizontal">
                    <div class="form-group no-margin">
                        <div class="">
                            <INPUT type="text" class="form-control input-sm pull-right" style="WIDTH:100%" id="txt_BPT_WSEZ1"  onfocus="SetFocus()" maxLength="10" onchange="ValidateBPTezReturn()"/>
                        </div>
                   </div>
                </div>
                </td>
        </tr>
        <tr  class="odd">
             <td width="5%">S2.</td>  
            <td width="70%" class="text-left"> Net Taxable Receipts (from Line 1 or Line 2 of <label id="Label1" class="lblLink label_NoLeft"  onclick=ShowPage(2)> Page 2 </label>)</td>
            <td colspan="2" align="center" width="25%">               
                <div class="form-horizontal">
                    <div class="form-group no-margin">
                        <div class="">
                             <label class="form-control input-sm pull-right" id="lbl_BPT_WSEZ2" style="WIDTH:100%" ></label>
                        </div>
                   </div>
                </div>
                </td>
        </tr>
        <tr >
             <td width="5%">S3.</td>  
            <td width="70%" class="text-left"> Taxable Gross Receipts (from Line 8 of <label id="lblLnksD" class="lblLink label_NoLeft"  onclick=ShowPage(2)>  Page 2 </label>)</td>
            <td colspan="2" align="center" width="25%">               
                <div class="form-horizontal">
                    <div class="form-group no-margin">
                        <div class="">
                             <label class="form-control input-sm pull-right" id="lbl_BPT_WSEZ3" style="WIDTH:100%"></label>
                        </div>
                   </div>
                </div>
            </td>
        </tr>
        <tr class="odd">
             <td width="5%">S4.</td>  
            <td width="70%" class="text-left"> Divide Line S2 by Line S3 and enter percentage as a decimal (four places)</td>
          
            <td style="width:25%" class="text-left">               
                 <div class="form-horizontal">
                    <div class="form-group no-margin">
                        <div class="">                    
                             <label class="form-control input-sm pull-right" id="lbl_BPT_WSEZ4" style="WIDTH:100%"></label>
                        </div>
                   </div>
                </div>
            </td>
        </tr>
        <tr >
             <td width="5%">S5.</td>  
            <td width="70%" class="text-left"> Statutory Net Income Deduction (Line S1 times Line S4)</td>
            <td colspan="2" align="center" style="width:25%">               
                      <div class="form-horizontal">
                    <div class="form-group no-margin">
                        <div class="">
                              <label class="form-control input-sm pull-right" id="lbl_BPT_WSEZ5" style="WIDTH:100%"></label>
                        </div>
                   </div>
                </div>                       
                </td>
        </tr>                            
                                         
                      
    </tbody>
    </table>
    <div class="clear"></div>
</div>
      </div>
        <form class="form-horizontal school_form">
        <div class="form-group">
            <div class="col-sm-offset-3 col-sm-9  text-right">
                  <input type="button" value="Return to Page 2"  class="btn btn-default submit_button" id="btnGoToPageWS1" onclick=ShowPage(2) />
            </div>
        </div>

    </form>       
   </div>
</body>
</html>
