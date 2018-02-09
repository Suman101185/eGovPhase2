<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
   
    <title></title>
<link type="text/css" rel="Stylesheet" href="../Content/Styles/framestyle.css" />

<script type="text/javascript" language="javascript" src="../Content/Scripts/JqueryMin.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/ispFunctions.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/ispXmlProc.js"></script>


   <script  language="javascript" type="text/javascript">
       var txtHeader = 'Taxpayer Information';
       var HasUOAccounts = true;

       var sFreq = "";
       //function loadXmlSync(url, ResponseFunction) {
       //    $.ajax({
       //        type: "GET",
       //        cache:false,
       //        url: url,
       //        dataType: "xml",
       //        async: false,
       //        beforeSend: beforSend,
       //        success: ResponseFunction,
       //        error: test()


       //    });
       //}


       function parseXml_xmlUOForm1(xml) {
           parent.$g.oUOForm.loadXML(xml);
       }
       function parseXml_xmlUOFormNew1(xml) {
           parent.$g.oUOFormNew.loadXML(xml);
       }
       function Reload() {
           parent.$g.loadXmlSync('XML/UOFormNew', parseXml_xmlUOFormNew1);
           parent.$g.loadXmlSync('XML/UOForm', parseXml_xmlUOForm1);

       }
       function DisplayUOList() {          
           Reload();

           //ispXmlSetFieldVal(parent.$g.oUOList,ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ACCOUNT_ID', '', 0), 'UO_INFO ACCOUNT_ID', '', 0);
           parent.$x.ispXmlSetFieldVal(parent.$g.oUOList, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ACCOUNT_ID', '', 0), 'UO_INFO ACCOUNT_ID', '', 0);



           parent.$x.ispXmlSetFieldVal(parent.$g.oUOList, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ENTITY_ID', '', 0), 'UO_INFO ENTITY_ID', '', 0)

           ispCallXMLForm(parent.$g.oUOList, parent.$g.oUOList, "UO/UOListCall", "");
           //alert(parent.$g.oUOList);
           $('#AppHeader').html(txtHeader + '<Font class=hdrMedium>|U&O Account Request</Font>');
           $('#AppMessage').html('<BR>Enter the U&O account number and Select the submit button to retrieve a list of tax filings for that account');

           if (parent.$x.ispXmlGetRecCount(parent.$g.oUOList, 'UO_ACCT', 'n') != 0) {

               UOList_PopAccounts();
               UOList_SetUOYears();
           }

       } //DisplayUOList

       function UOList_PopAccounts() {
           if (HasUOAccounts) {
               //Load dropdown with UO accounts
               var iCount = parent.$x.ispXmlGetRecCount(parent.$g.oUOList, 'UO_ACCT', 'n');
               //alert("iCount:   " +  iCount);
               ddlUOAccount.options.length = iCount
               for (i = 0; i < iCount; i++) {
                   //alert(ispXmlGetFieldVal(oUOList, 'UO_ACCT ACCOUNT_ID', '', i));
                   //alert(ispXmlGetFieldVal(oUOList, 'UO_ACCT START_DATE', '', i));
                   $(ddlUOAccount.options[i]).text(parent.$x.ispXmlGetFieldVal(parent.$g.oUOList, 'UO_ACCT ACCOUNT_ID', '', i));
                   // ddlUOAccount.options(i).STARTDATE = ispXmlGetFieldVal(oUOList, 'UO_ACCT START_DATE', '', i);
                   $(ddlUOAccount.options[i]).attr("STARTDATE", parent.$x.ispXmlGetFieldVal(parent.$g.oUOList, 'UO_ACCT START_DATE', '', i));
               }
           }
       } //UOList_PopAccounts

       function GetOUAccounts() {
       } //GetOUAccounts

       function GetList() {
           $('#divList').css("display", "block");
       }

       function GotoUO1(a) {

           var yy = parseInt($(ddlUOYears.options[ddlUOYears.selectedIndex]).text());
          
           var mm = ispGetNumaricMonth($(a).attr("value"));
           // var tempXML = parent.$g.getXmlDocObj(); //new ActiveXObject("MSXML.DOMDocument")	
           var page = "";
           
           if (yy >= 2013 && mm > 6) {
               page = "new";
               parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, 'INQ', 'UO_ACCT RETURN_STATUS', '', 0);
               parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, $(ddlUOAccount.options[ddlUOAccount.selectedIndex]).text(), 'UO_ACCT ACCOUNT_ID', '', 0);

               if ($(a).text() == 'February' && ispCheckLeapYear($(ddlUOYears.options[ddlUOYears.selectedIndex]).text())) {
                   parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, $(ddlUOYears.options[ddlUOYears.selectedIndex]).text() + '0229', 'UO_ACCT PERIOD', '', 0);
                   //	alert($(ddlUOYears.options[ddlUOYears.selectedIndex]).text());
               } else {

                   parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, $(ddlUOYears.options[ddlUOYears.selectedIndex]).text() + $(a).attr('period'), 'UO_ACCT PERIOD', '', 0);

                   //clipboardData.setData ('Text', parent.$g.oUOForm.xml.xml);
               }
               //alert(parent.$g.oUOForm.xml.xml);
               //clipboardData.setData ('Text', parent.$g.oUOFormNew.xml.xml);

               ispCallXMLForm(parent.$g.oUOFormNew, parent.$g.oUOFormNew, "UO/UOFormCallNew", "");
               /*ispCallXMLForm(parent.$g.oUOFormNew, tempXML, "UOFormCallNew.asp", "");      
               parent.$g.oUOFormNew.loadXML(tempXML.xml);*/

           }
           else {
               page = "old";
               parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, 'INQ', 'UO_ACCT RETURN_STATUS', '', 0);
               parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, $(ddlUOAccount.options[ddlUOAccount.selectedIndex]).text(), 'UO_ACCT ACCOUNT_ID', '', 0);

               if ($(a).text() == 'February' && ispCheckLeapYear($(ddlUOYears.options[ddlUOYears.selectedIndex]).text())) {
                   parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, $(ddlUOYears.options[ddlUOYears.selectedIndex]).text() + '0229', 'UO_ACCT PERIOD', '', 0);
                   //	alert($(ddlUOYears.options[ddlUOYears.selectedIndex]).text());

               } else {
                   // ispXmlSetFieldVal(oUOForm, ddlUOYears.options(ddlUOYears.selectedIndex).innerText + a.getAttribute('period'), 'UO_ACCT PERIOD', '', 0);
                   // alert('value to set' + $(ddlUOYears.options[ddlUOYears.selectedIndex]).text() + $(a).attr('period'));
                   parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, $(ddlUOYears.options[ddlUOYears.selectedIndex]).text() + $(a).attr('period'), 'UO_ACCT PERIOD', '', 0);
                   //clipboardData.setData ('Text', parent.$g.oUOForm.xml.xml);

               }

               ispCallXMLForm(parent.$g.oUOForm, parent.$g.oUOForm, "UO/UOFormCall", "");

               //parent.$g.oUOForm.loadXML(tempXML.xml);

           }

           //parent.DocWin.location.href = 'UO?f=' + sFreq + "&page=" + page;
           parent.setFrameUrl('UO/UO?f=' + sFreq + '&page=' + page);

       }
       function ispGetNumaricMonth(mm) {
           if (mm == "January") {
               return 1;
           }
           if (mm == "February") {
               return 2;
           }
           if (mm == "March") {
               return 3;
           }
           if (mm == "April") {
               return 4;
           }
           if (mm == "May") {
               return 5;
           }
           if (mm == "June") {
               return 6;
           }
           if (mm == "July") {
               return 7;
           }
           if (mm == "August") {
               return 8;
           }
           if (mm == "September") {
               return 9;
           }
           if (mm == "October") {
               return 10;
           }
           if (mm == "November") {
               return 11;
           }
           if (mm == "December") {
               return 12;
           }


       }
       function ispCheckLeapYear(lYear) {
           lYear = parseInt(lYear);
           if (lYear % 4 == 0) {
               if (lYear % 100 != 0) {
                   return true;
               } else {
                   if (lYear % 400 == 0) {
                       return true;
                   } else {
                       return false;
                   }
               }
           }
           return false;
       } //ispCheckLeapYear

       function UOList_SetUOYears() {
           divList.style.display = 'none';
           divNoList.style.display = 'none';
           var iMaxYears = 10;
           var idx = ddlUOAccount.selectedIndex;
           var iStartYear = parent.$x.ispXmlGetFieldVal(parent.$g.oUOList, 'UO_ACCT START_DATE', '', idx).substring(6);
           var iEndYear = parent.$x.ispXmlGetFieldVal(parent.$g.oUOList, 'UO_ACCT END_DATE', '', idx).substring(6);

           if (iEndYear == '') {
               iEndYear = new Date().getFullYear();
           }

           if (iStartYear != '') {
               var iNumOfYears = iEndYear - iStartYear + 1;
               if (iNumOfYears < iMaxYears) {
                   iMaxYears = iNumOfYears;
               }
               ddlUOYears.options.length = iMaxYears;
               for (i = 0; i < iMaxYears; i++) {
                   if (parent.$x.ispXmlGetFieldVal(parent.$g.oUOList, 'UO_ACCT FREQ_YEAR' + i, '', idx).toUpperCase() != 'X') {
                       $(ddlUOYears.options[i]).text(iEndYear - i);
                   } else {
                       ddlUOYears.remove(0);
                   }
               }
           } else {
               ddlUOYears.options.length = 0;
               ddlUOYears.remove(0);
           }
           if (ddlUOYears.options.length != 0) {
               $('#divList').css("display", "block");
               UOList_DisplayButtons();
           } else {
               //divNoList.style.display = 'block';
               $('#divNoList').css("display", "block");
           }

           $('#lblPropLoc').html(parent.$x.ispXmlGetFieldVal(parent.$g.oUOList, 'UO_ACCT LOCATION', '', ddlUOAccount.selectedIndex));
           $('#lblStartDate').html(parent.$x.ispXmlGetFieldVal(parent.$g.oUOList, 'UO_ACCT START_DATE', '', ddlUOAccount.selectedIndex));
           $('#lblEndDate').html(parent.$x.ispXmlGetFieldVal(parent.$g.oUOList, 'UO_ACCT END_DATE', '', ddlUOAccount.selectedIndex));
       } //UOList_SetUOYears

       function UOList_DisplayButtons() {
           $('#rowJan').css("display", "none"); btnJan.setAttribute('period', '0131');
           $('#rowFeb').css("display", "none"); btnFeb.setAttribute('period', '0228');
           $('#rowMar').css("display", "none"); btnMar.setAttribute('period', '0331');
           $('#rowApr').css("display", "none"); btnApr.setAttribute('period', '0430');
           $('#rowMay').css("display", "none"); btnMay.setAttribute('period', '0531');
           $('#rowJun').css("display", "none"); btnJun.setAttribute('period', '0630');
           $('#rowJul').css("display", "none"); btnJul.setAttribute('period', '0731');
           $('#rowAug').css("display", "none"); btnAug.setAttribute('period', '0831');
           $('#rowSep').css("display", "none"); btnSep.setAttribute('period', '0930');
           $('#rowOct').css("display", "none"); btnOct.setAttribute('period', '1031');
           $('#rowNov').css("display", "none"); btnNov.setAttribute('period', '1130');
           $('#rowDec').css("display", "none"); btnDec.setAttribute('period', '1231');

           sFreq = parent.$x.ispXmlGetFieldVal(parent.$g.oUOList, 'UO_ACCT FREQ_YEAR' + ddlUOYears.selectedIndex, '', ddlUOAccount.selectedIndex);

           if (sFreq.toUpperCase() == "M") {
               $('#rowJan').css("display", "block");
               $('#rowFeb').css("display", "block");
               $('#rowMar').css("display", "block");
               $('#rowApr').css("display", "block");
               $('#rowMay').css("display", "block");
               $('#rowJun').css("display", "block");
               $('#rowJul').css("display", "block");
               $('#rowAug').css("display", "block");
               $('#rowSep').css("display", "block");
               $('#rowOct').css("display", "block");
               $('#rowNov').css("display", "block");
               $('#rowDec').css("display", "block");

           } else if (sFreq.toUpperCase() == "Q") {
               $('#rowMar').css("display", "block");
               $('#rowJun').css("display", "block");
               $('#rowSep').css("display", "block");
               $('#rowDec').css("display", "block");
           } else if (sFreq.toUpperCase() == "H") {
               $('#rowJun').css("display", "block");
               $('#rowDec').css("display", "block");
           }
           /*if($(ddlUOYears.options[ddlUOYears.selectedIndex]).text() == "2013")
           {
                       $('#rowJul').css("display","none");
                       $('#rowAug').css("display","none");
                       $('#rowSep').css("display","none");
                       $('#rowOct').css("display","none");
                       $('#rowNov').css("display","none");
                       $('#rowDec').css("display","none");
   
           }*/
       } //UOList_DisplayButtons
</script>

</head>
<body onload="DisplayUOList()">
   <div class="tab_Tcontainer">

   
    <div class="tab_container">
        <div style="display: block;" id="tab2" class="tab_content">
        <h2 id="AppHeader"></h2>
             <div class="taxpyer_address">
            	<h4 id="AppMessage"> </h4>
				
                
        		
                <div class="account_greybox_new no_border_atall">
                
                <table id="" summary="Employee Pay Sheet" class="no_magin_bothside no_border_atall hor-zebra">
                   
                    <tbody>
                        
                        <tr class="even" >
                        	<td width="31%"><strong>Select UO Account ID:</strong></td>
                            <td align="center" colspan="3" class="no_border_right">
                            <select class='inpNormal' id="ddlUOAccount" onchange="UOList_SetUOYears()" style="width:100px">
		                    <option></option>
	                        </select>
                            </td>
                        </tr>
                        
                        
                        <tr class="even">
                        	<td colspan="2" class="no_border_right">
                            <strong>Property Location:</strong><label class='inpNormal' id="lblPropLoc"></label> </td>
                            <td width="27%"  class="no_border_right">
                            <strong>Start Date:</strong> <label class='inpNormal' id="lblStartDate"></label> </td>
                            <td width="29%" class="no_border_right">
                            <strong>End Date:</strong><label class='inpNormal' id="lblEndDate"></label></td>
                        </tr>
                        <tr>
                            <td><div id="divNoList"	style="display:none; margin-left:30px; margin-top:20px">
		        <label style="color:Red;width:100%">No U&O return frequency found</label>
	                        </div></td>
                        </tr>
                        </tbody>
                    </table>
                    <table id="divList" style="display:none" class="no_magin_bothside no_border_atall hor-zebra">
                   
                    <tbody>
                        
                        <tr class="">
                            <td  style="padding-top:25px;"><strong>Select U&O Year:</strong></td>
                            <td  style="padding-top:25px;" align="center" colspan="3" class="no_border_right">
                           	<select class='inpNormal' id="ddlUOYears" onchange="UOList_SetUOYears()" style="width:60px">
						<option></option>
					</select>
                            </td>
                        </tr>
                        <tr class="">
                           <td colspan="4" class="no_border_right">
                           <div id="rowJan"><input type="button" class="calenders" value="January" id="btnJan" onclick="GotoUO1(this)" /></div> <div class="clear"></div>
                           <div id="rowFeb"> <input type="button" class="calenders" value="February" id="btnFeb" onclick="GotoUO1(this)" /></div><div class="clear"></div>
                           <div id="rowMar"><input type="button" class="calenders" value="March" id="btnMar" onclick="GotoUO1(this)" /></div><div class="clear"></div>
                           <div id="rowApr"> <input type="button" class="calenders" value="April" id="btnApr" onclick="GotoUO1(this)" /></div><div class="clear"></div>
                           <div id="rowMay"> <input type="button" class="calenders" value="May" id="btnMay"  onclick="GotoUO1(this)"/></div><div class="clear"></div>
                           <div id="rowJun"> <input type="button" class="calenders" value="June" id="btnJun"  onclick="GotoUO1(this)"/></div><div class="clear"></div>
                           <div id="rowJul"><input type="button" class="calenders" value="July" id="btnJul"  onclick="GotoUO1(this)"/></div><div class="clear"></div>
                           <div id="rowAug"> <input type="button" class="calenders" value="August" id="btnAug" onclick="GotoUO1(this)"/></div><div class="clear"></div>
                           <div id="rowSep"> <input type="button" class="calenders" value="September"  id="btnSep" onclick="GotoUO1(this)"/></div><div class="clear"></div>
                           <div id="rowOct"> <input type="button" class="calenders" value="October"  id="btnOct" onclick="GotoUO1(this)"/></div><div class="clear"></div>
                           <div id="rowNov"> <input type="button" class="calenders" value="November"  id="btnNov" onclick="GotoUO1(this)"/></div><div class="clear"></div>
                           <div id="rowDec"> <input type="button" class="calenders" value="December"  id="btnDec" onclick="GotoUO1(this)"/></div>
                            
                            </td>
                        </tr>
                     
                    </tbody>
                </table>
                <div class="clear"></div>
               </div>


			<div class="clear"></div>
            <br />
        <div class="quicklink_btm_gen"></div>
        </div>	
        </div>
     	
    </div>
</div>
</body>
</html>
