<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
    <script language="javascript">
     $(document).ready(function () {
        DisplayNPTReturn();
     });
        </script>
    <title></title>
</head>
    <body>
<%--<body onload="DisplayNPTReturn()">--%>
    <div class="tab_Tcontainer" id="NPT">
        <div class="tab_container">
            <div style="display: block;" id="tab1" class="tab_content">
               <h2 id="AppHeader">  </h2>

                <div class="thankyou">
                    <h4 id="AppMessage">&nbsp;</h4>

                    <div class="school_form">


                        <div class="school_page_form">

                         

                            <div class="account_greybox"  id="NPT" style="DISPLAY: none;">
                                 <p><strong>Name :</strong> <label id=lblName_08 class="lblTextBlack" ></label> </p>
                                 <p> <label id="lblAccountType" class="">Account No.: &nbsp;</label>
                                     <label id="lblAccountId" class=""></label></p>

                            

                                <div class="clear"></div>
                                <p><strong>Address :</strong>  <label id="lblAddress" class="lblTextBlack"></label> </p>
                                <p><label id="lblEntityType" class=""><strong>EIN: &nbsp;</strong></label>
                                    <label id="lblEntityId" class=""></label>
                                </p>
                                <div class="clear"></div>
                                
                            </div>

                             <div id="NPT_BPT_msg" style="DISPLAY: none; VISIBILTY: visible" name="NPT_BPT_msg" align="center">
        <br>
        <br>
        <br>
        Your 2013 BIRT return must be filed prior to filing your 2013 NPT Return.<br>
        To fill out your 2013 BIRT form, Please select BIRT from the side menu.
    </div>

                            <div id="NPT_Page1" style="DISPLAY: none; VISIBILTY: visible" name="NPT_Page1">


                                <div class="form_segment">


                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabularform">
                                    <tr>
                                        <th width="24%" scope="col" valign="middle" align="left" class="here_input_table">
                                            <input id=chkAmended type=checkbox onclick="chkAmended_onclick()" type="checkbox" />
                                            Check if amended return. </th>
                                        <th width="24%" scope="col" valign="middle" align="left" class="here_input_table">
                                          If your business terminated in 
				<script>document.write(sCurrYear - 1)</script>
                        ,
					enter the termination date here:   <input class="inpNormal"
                        id="txtTermDate" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="10"
                        onblur="return txtTermDate_onblur()"> 
                                        </th>
                                        </tr>
                                    <tr><th>   Enter the termination date if business is terminated in previous financial year<label id="lnkWrkD" class="lblLink label_NoLeft" onclick="if($(this).attr('disabled')!='disabled'){ShowPage('WrkD')}">Click here for Worksheet D</label>

                                        </th>
                                        <th><input class="inpNormal"
                        id="txtPercentage" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="3"></th>
                                    </tr>
                                   
                                </table>


                            </div>


                            <div class="form_segment">

                                <table summary="Employee Pay Sheet" class="hor-zebra">

                                    <tbody>

                                        <tr class="odd">
                                            <td width="70%"><b>1. Residents Taxable Income or Loss from Page 2, Worksheet A, Line 4</b>
                                                 <label id="lnkWrkA" class="lblLink label_NoLeft" onclick="if($(this).attr('disabled')!='disabled'){ShowPage('WrkA')}">Click here for Worksheet A</label>
                                            </td>
                                            <td align="center" class="no_border_right">
                                                <input class="inpNormal" id="txtNPT1" onchange='ValidateWorksheet("Page1")'
                onfocus="SetFocus()" maxlength="10" style="WIDTH: auto">
                                               </td>
                                        </tr>
                                        <tr>
                                            <td>2.  <label class="" id="msgNPT1_2" style="float:none;">Line 1 X ###</label></td>
                                            <td align="center" class="no_border_right">
                                                 <label id="lblNPT2" style="WIDTH: 100%"></label></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">3.  Non-Residents Taxable Income or Loss from Page 2, Worksheet B, Line 6 
                                                 <label id="lnkWrkB" class="lblLink label_NoLeft"  onclick="if($(this).attr('disabled')!='disabled'){ShowPage('WrkB')}">Click here for Worksheet B</label>
                                            </td>
                                            <td align="center" class="no_border_right">
                                                  <input class="inpNormal" id="txtNPT3" onchange='ValidateWorksheet("Page1")'
                        onfocus="SetFocus()" maxlength="10" style="WIDTH: auto">
                                               </td>
                                        </tr>
                                        <tr>
                                            <td>4.   <label class="" id="msgNPT1_4" style="float:none;">Line 3 X ###</label>&nbsp;</td>
                                            <td align="center" class="no_border_right">
                                                <label id="lblNPT4" style="WIDTH: 100%"></label></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">5.  Tax Due(Line 2 plus Line 4)</td>
                                            <td align="center" class="no_border_right">
                                               <label id="lblNPT5" style="WIDTH: 100%"></label></td>
                                        </tr>
                                        <tr>
                                            <td><b>6a.  60% Business Income & Receipts Tax credit from Page 3, Worksheet K, Line 4</b><label id="Label1" class="lblLink label_NoLeft"  onclick="if($(this).attr('disabled')!='disabled'){ShowPage('WrkK')}">Click here for Worksheet K</label></td>
                                            <td align="center" class="no_border_right">
                                                <label id="lblNPT6a" style="WIDTH: 100%"> </label>
                                               </td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">6b.  Estimated payments and other credits from 
						Worksheet E, Line 4
                                                <label id="lnkWrkE" class="lblLink label_NoLeft"  onclick="if($(this).attr('disabled')!='disabled'){ShowPage('WrkE')}">Click here for Worksheet E</label>
                                            </td>
                                            <td align="center" class="no_border_right">
                                              <input class="inpNormal" id="txtNPT6b" onchange='ValidateWorksheet("Page1")'
                        onfocus="SetFocus()" maxlength="10" style="WIDTH: auto"></td>
                                        </tr>
                                        <tr>
                                            <td>6c.  Total payments and credits(Line 6a plus Line 6b)</td>
                                            <td align="center" class="no_border_right">
                                                 <label id="lblNPT6c" style="WIDTH: 100%"></label></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">7.  Net Tax Due(Line 5 minus Line 6c) </td>
                                            <td align="center" class="no_border_right">
                                         <label id="lblNPT7" style="WIDTH: 100%"></label>

                                            </td>
                                        </tr>
                                        <tr>
                                            <td>8.  Interest and Penalty ( Refer to web site for current percentage )</td>
                                            <td align="center" class="no_border_right">
                                              <input class="inpNormal" id="txtNPT8" onchange='ValidateWorksheet("Page1")'
                onfocus="SetFocus()" maxlength="10" style="WIDTH: auto"></td>
                                        </tr>
                                        <tr class="odd">
                                            <td width="70%">9.  <u>TOTAL DUE</u> including Interest and Penalty (Line 7 plus Line 8)</td>
                                            <td align="center" class="no_border_right">
                                             <label id="lblNPT9" style="WIDTH: 100%"></label> 
                                            </td>
                                        </tr>
                                        <tr >
                                            <td width="70%">10.  Tax Overpaid. If Line 6c is greater than Line 5, enter difference here and on the
Estimated Tax Coupon (ENP-1), Line 2</td>
                                            <td align="center" class="no_border_right">
                                                 <label id="lblNPT10" style="WIDTH: 100%"></label>
                                            </td>
                                        </tr>
                                        <tr class="odd">
                                            <td>11.   Enter 50% of Worksheet C, Line 3.<br>
                        <b>This line is <u>not</u> used to remit estimated payments</b>
                                                <label id="lnkWrkC" class="lblLink label_NoLeft"  onclick="if($(this).attr('disabled')!='disabled'){ShowPage('WrkC')}">Click here for Worksheet C</label>
                                            </td>
                                            <td align="center" class="no_border_right">
                                               <input class="inpNormal" id="txtNPT11" onchange='ValidateWorksheet("Page1")'
                        onfocus="SetFocus()" maxlength="10" style="WIDTH: auto"></td>
                                        </tr>
                                        <tr >
                                            <td width="70%">12.    <u>OVERPAYMENT OPTIONS</u> If Line 10 is greater than Line 11, 
					enter the amount to be:</td>
                                            <td align="center" class="no_border_right">
                                               	
                                            </td>
                                        </tr>
                                        <tr class="odd">
                                            <td><label class="" id=msgTobaccoNo3d style="WIDTH: 100%">A. Refunded. Do not file a separate refund petition</td>
                                            <td align="center" class="no_border_right">
                                                <input class="inpNormal" id="txtNPT12a" onchange='ValidateWorksheet("Page1")'
                        onfocus="SetFocus()" maxlength="10" style="WIDTH: auto"> </td>
                                        </tr>
                                        <tr>
                                            <td width="70%">B.  Applied, up to the tax due, to the 
				<script>document.write(sCurrYear - 1)</script>
                        Business Income & Receipts Tax Return</td>
                                            <td align="center" class="no_border_right">
                                                <input class="inpNormal" id="txtNPT12b" onchange='ValidateWorksheet("Page1")'
                        onfocus="SetFocus()" maxlength="10" style="WIDTH: auto"></td>
                                        </tr>
                                        <tr class="odd">
                                            <td>C. Applied to the
				<script>document.write(sCurrYear)</script>
                        Net Profits Tax</td>
                                            <td align="center" class="no_border_right">
                                                 <input class="inpNormal" id="txtNPT12c" onchange='ValidateWorksheet("Page1")'
                        onfocus="SetFocus()" maxlength="10" style="WIDTH: auto"></td>
                                        </tr>

                                        
                                    </tbody>
                                </table>
                                <div class="clear"></div>

                                <div> <%
                Html.RenderAction("PreparerSection", "INC");   
            %></div>
                             <div class="form_segment here_input_table" align="right">
                                <input id="btnNPTPrint" type="button" value="Print" class="submit_button_light" onclick="parent.doPrintDocWin()" />
                                <input type="button" value="Submit" class="submit_button" id="btnNPTSubmit" onclick="return btnNPTSubmit_onclick()" />
                            </div>
                             
                          </div>

                               

                            </div>

                            <% Html.RenderAction("_13WrkA", "NPT"); %>
                            <%Html.RenderAction("_13WrkB", "NPT"); %>
                            <%Html.RenderAction("_13WrkC", "NPT"); %> 
                            <% Html.RenderAction("_13WrkD", "NPT");%>
                           <%Html.RenderAction("_13WrkE", "NPT"); %>
                           <%  Html.RenderAction("_13WrkK", "NPT");%>
                           <% Html.RenderAction("_13Page4", "NPT");%>
                            <%Html.RenderAction("_13NPT_ExemptedMsg", "NPT"); %>
           
                            </div>
                            </div>
                   
                          

                    </div>

                </div>
            
                <div class="quicklink_btm_gen"></div>
            </div>

        </div>
   
</body>
</html>
