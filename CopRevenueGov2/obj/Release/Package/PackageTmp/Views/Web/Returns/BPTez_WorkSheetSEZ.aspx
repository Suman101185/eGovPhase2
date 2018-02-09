<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width" />
    <title></title>
</head>
<body>
    <div class="form_segment" id="BPT_WorkSheetS" style="DISPLAY: none;">

                                <table summary="Employee Pay Sheet" class="hor-zebra" id="tblBPTEZWS">

                                    <tbody>

                                        <tr class="odd">
                                            <td width="70%"><B><U>Worksheet S - Use to calculate Statutory Net Income Deduction</U></b>
                                            <td colspan="2" align="center" class="no_border_right">
                                                
                                               </td>
                                        </tr>                                        
                                         <tr>
                                            <td>S1. Enter the lower of <label id="Label2" class="lblLink label_NoLeft" style="width:100%" onclick="ShowPage('SchdD')"> Line 6 of Schedule D </label> or $50,000 </td>
                                            <td colspan="2" align="center" class="no_border_right">
                                             <INPUT class="" id="txt_BPT_WS1" style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange='ValidateWorksheet("BPT_WorkSheetS")'>
                                               </td>
                                        </tr>
                                        <tr  class="odd">
                                            <td width="70%">S2. Current Year Income (from Line 9 of <label id="lblLnksA" class="lblLink label_NoLeft" style="width:100%" onclick="ShowPage('SchdA')"> Schedule A </label>or <label id="lblLnksB" class="lblLink label_NoLeft" style="width:100%" onclick="ShowPage('SchdB')">Schedule B.</label> ) 
                                            </td>
                                            <td colspan="2" align="center" class="no_border_right">
                                                <label class="" id="lbl_BPT_WS2" style="WIDTH:100%" ></label>
                                             </td>
                                        </tr>
                                        <tr >
                                            <td>S3. Enter Net Taxable Receipts (from Line 6 of <label id="lblLnksD" class="lblLink label_NoLeft" style="width:100%" onclick="ShowPage('SchdD')"> Schedule D </label>)</td>
                                            <td colspan="2" align="center" class="no_border_right">
                                                <label class="" id="lbl_BPT_WS3" style="WIDTH:100%"></label>
                                            </td>
                                        </tr>
                                        <tr class="odd">
                                            <td>S4. Divide Line S2 by Line S3 and enter percentage as a decimal (two places)</td>
                                            <td style="width:80%"  align="right" class="no_border_right">
                                             <label class="" id="lbl_BPT_WS4" /> .  </td>
                                            <td><INPUT class="" id="txt_BPT_WS4" style="WIDTH:100%" 
      onfocus=SetFocus() maxLength=10 onchange='checkWS4()'/></td>
                                        </tr>
                                        <tr >
                                            <td>S5. Statutory Net Income Deduction (Line S1 times Line S4)</td>
                                            <td colspan="2" align="center" class="no_border_right">
                                                <label class="" id="lbl_BPT_WS5" style="WIDTH:100%"  ></label>
                                             
                                               </td>
                                        </tr>                               
                                         
                                        <tr >
                                            <td  ></td>
                                            <td colspan="2"  align="center" class="no_border_right">
                                                <div class="form_segment here_input_table" align="right"><label>.   </label>
                                               <input type="button" value="Return to Schedule"  class="submit_button2" id="btnGoToPageWS1" onclick="ShowPagefun()" />
                                                    </div>
                                                    </td>
                                        </tr>

                                         
                                    </tbody>
                                </table>
                                <div class="clear"></div>

                            </div>
</body>
</html>
