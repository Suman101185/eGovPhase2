<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

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

            txt_BPT_WSEZ1.value = '$0';
            PerformCalcsBPTezWrkShtN();
        }
        function DisplayWrkShtN() {
            PerformCalcsBPTezWrkShtN()
            $('#BPTez_WrkShtNE').css('display', 'block')
        }
        function PerformCalcsBPTezWrkShtN() {
            //		if (b3800val == true) {
            GetPage2Line1or2();
            GetPage2Line8();
            GetS2byS3();
            CalcWorkSheetSLine5();
            //if ($('#btnYes').is(':checked') == true) {
            //    $('#lblWrkShtN_2').text('$0');
            //    $('#lblWrkShtN_4').text('$0');
            //} else {
            //    $('#lblWrkShtN_2').text($('#lblBPTez2_5').text());
            //    $('#lblWrkShtN_4').text($('#lblBPTez2_8').text());
            //} 	//if
        } 	//PerformCalcsBPTlfWrkShtN

        function GetPage2Line1or2() {


            if ($('#radBPTez2_1_2_m2').is(":checked") == true) {
                $('#lbl_BPT_WSEZ2').text($('#txtBPTez2_1').val());
            }
            if ($('#radBPTez2_1_2_m1').is(":checked") == true) {
                $('#lbl_BPT_WSEZ2').text($('#txtBPTez2_2').val());
            }
            var BPTez2_1or2 = $('#lbl_BPT_WSEZ2').text();
            if (cCur(BPTez2_1or2) == 0) {

                $('#lbl_BPT_WSEZ2').text(ispFormatMoney(0, 0));
            } 	//if
        } 	//GetPage2Line1or2

        function GetPage2Line8() {
            if (cCur($('#lblBPTez2_8').text()) != 0) {
                $('#lbl_BPT_WSEZ3').text($('#lblBPTez2_8').text());
            } else {
                $('#lbl_BPT_WSEZ3').text(ispFormatMoney(0, 0));

            } 	//if
        } 	//GetPage2Line8

        function GetS2byS3() {
            //  alert($('#lbl_BPT_WSEZ3').text() + " Z2  " + $('#lbl_BPT_WSEZ2').text());
            if ($('#lbl_BPT_WSEZ3').text() != '' && $('#lbl_BPT_WSEZ2').text() != '') {

                var calculationvar1 = (cCur($('#lbl_BPT_WSEZ2').text()) / cCur($('#lbl_BPT_WSEZ3').text())) * 100;


                if (isNaN((cCur($('#lbl_BPT_WSEZ2').text()) / cCur($('#lbl_BPT_WSEZ3').text())) * 100) || calculationvar1 == 'Infinity' || calculationvar1 == 'NAN') {

                    $('#lbl_BPT_WSEZ4').text('$' + 0 + '.');
                    $('#txt_BPT_WSEZ4').val(00);
                }
                else {

                    calculationvar1 = calculationvar1.toFixed(2);
                    $('#lbl_BPT_WSEZ4').text(ispFormatMoney(calculationvar1.toString().split(".")[0], 0) + '.');
                    $('#txt_BPT_WSEZ4').val(calculationvar1.toString().split(".")[1]);
                }

            }
        }

        function CalcWorkSheetSLine5() {
            if ($('#txt_BPT_WSEZ1').val() != '' && $('#txt_BPT_WSEZ4').val() != '') {

                var totamount = cCur($('#lbl_BPT_WSEZ4').text()) + '.' + txt_BPT_WSEZ4.value;
                $('#lbl_BPT_WSEZ5').text(ispFormatMoney((cCur(txt_BPT_WSEZ1.value) * totamount), 0));
                $('#lbl_BPTez2_3').text($('#lbl_BPT_WSEZ5').text());
            }
        }

    </script>
    <title></title>
</head>
<body>
   <div class="form-group" id="BPTez_WrkShtNE" style="DISPLAY: none;">
         <div class="row table-responsive">
     <div class="col-lg-12" >

    <table summary="Employee Pay Sheet" class="table table-condensed table-striped custom_table03" id="tblBptSchE">

    <tbody>

        <tr>            
            <td width="70%"><B><U>Worksheet S-EZ - Use to calculate Statutory Net Income Deduction</U></b>
            <td colspan="2" width="25%">
                                              
                </td>
        </tr>                                        
            <tr>               
            <td width="70%" class="text-left"><span><strong>S1.</strong></span> &nbsp;Enter the lower of <label id="Label2" class="lblLink label_NoLeft"  onclick=ShowPage(2) > Line 8 of Page 2 </label> or $75,000 </td>
            <td colspan="2" align="center" width="25%">                
                <div class="form-horizontal">
                    <div class="form-group no-margin">
                        <div class="">
                            <INPUT class="form-control input-sm" id="txt_BPT_WSEZ1"  onfocus=SetFocus() maxLength=10 onchange='ValidateBPTezReturn()'>
                        </div>
                   </div>
                </div>
                </td>
        </tr>
        <tr  class="odd">
            <td width="70%" class="text-left"><span><strong>S2.</strong></span> &nbsp; Enter Net Income (from Line 1 or Line 2 of <label id="Label1" class="lblLink label_NoLeft"  onclick=ShowPage(2)> Page 2 </label>)</td>
            <td colspan="2" align="center" width="25%">               
                <div class="form-horizontal">
                    <div class="form-group no-margin">
                        <div class="">
                             <label class="" id="lbl_BPT_WSEZ2" style="WIDTH:100%" ></label>
                        </div>
                   </div>
                </div>
                </td>
        </tr>
        <tr >
            <td class="text-left"><span><strong>S3.</strong></span> &nbsp; Enter Taxable Gross Receipts (from Line 8 of <label id="lblLnksD" class="lblLink label_NoLeft"  onclick=ShowPage(2)>  Page 2 </label>)</td>
            <td colspan="2" align="center" width="25%">               
                <div class="form-horizontal">
                    <div class="form-group no-margin">
                        <div class="">
                             <label class="" id="lbl_BPT_WSEZ3" style="WIDTH:100%"></label>
                        </div>
                   </div>
                </div>
            </td>
        </tr>
        <tr class="odd">
            <td class="text-left"><span><strong>S4.</strong></span> &nbsp; Divide Line S2 by Line S3 (Cannot be greater than 1.0000)</td>
            <td style="width:80%"  align="right" >                  
                 <div class="form-horizontal">
                    <div class="form-group no-margin">
                        <div class="">
                             <label class="" id="lbl_BPT_WSEZ4" style="WIDTH: 100%" /> .
                        </div>
                   </div>
                </div>
            </td>
            <td>               
                 <div class="form-horizontal">
                    <div class="form-group no-margin">
                        <div class="">
                              <INPUT class="form-control input-sm" id="txt_BPT_WSEZ4"  onfocus=SetFocus() maxLength=10 onchange='ValidateBPTezReturn()'/>
                        </div>
                   </div>
                </div>
            </td>
        </tr>
        <tr >
            <td class="text-left"><span><strong>S5.</strong></span> &nbsp; Statutory Net Income Deduction (Line S1 times Line S4, Cannot exceed $75,000)</td>
            <td colspan="2" align="center" style="width:25%">               
                      <div class="form-horizontal">
                    <div class="form-group no-margin">
                        <div class="">
                              <label class="" id="lbl_BPT_WSEZ5" style="WIDTH:100%"  ></label>
                        </div>
                   </div>
                </div>                       
                </td>
        </tr>                               
                                         
        <tr >
            <td  ></td>
            <td colspan="2"  align="center" style="width:25%">
               <div class="form-group">
                <div class="col-sm-offset-3 col-sm-9  text-right">
                <input type="button" value="Return to Page 2"  class="btn btn-default submit_button" id="btnGoToPageWS1" onclick=ShowPage(2) />
                 </div>
                    </div>
                    </td>
        </tr>

                                         
    </tbody>
    </table>
    <div class="clear"></div>
         </div>
      </div>

   </div>
</body>
</html>

