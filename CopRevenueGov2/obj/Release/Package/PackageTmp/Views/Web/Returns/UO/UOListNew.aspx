<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>   
    <title></title>
     <!-- Bootstrap Core CSS -->
    <link href="../Content/Styles/bootstrap.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="../Content/Styles/copegov.css" rel="stylesheet">
    <link href="../Content/Styles/style.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../Content/Styles/jPushMenu.css">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script type="text/javascript" language="javascript" src="../Content/Scripts/JqueryMin.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/ispFunctions.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/ispXmlProc.js"></script>


   <script  language="javascript" type="text/javascript">
       var txtHeader = 'Taxpayer Information';
       var HasUOAccounts = true;

       var sFreq = "";
       


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
           debugger;
           Reload();

           //ispXmlSetFieldVal(parent.$g.oUOList,ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ACCOUNT_ID', '', 0), 'UO_INFO ACCOUNT_ID', '', 0);
           parent.$x.ispXmlSetFieldVal(parent.$g.oUOList, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ACCOUNT_ID', '', 0), 'UO_INFO ACCOUNT_ID', '', 0);



           parent.$x.ispXmlSetFieldVal(parent.$g.oUOList, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ENTITY_ID', '', 0), 'UO_INFO ENTITY_ID', '', 0)


           var ReqXML = parent.$g.oUOList;
           $.ajax({
               type: 'POST',
               url: '../Returns/Log',
               data: '{ "OriginationFom" : "UOList","ServiceName" : "RTTIE034","RequestXML" : "' + btoa(ReqXML.toString()) + '"}',
               contentType: 'application/json; charset=utf-8',
               dataType: 'json',
               success: function (msg) {

               }
           });

           ispCallXMLForm(parent.$g.oUOList, parent.$g.oUOList, "UO/UOListCall", "");

           var ResXML = parent.$g.oUOList;
           $.ajax({
               type: 'POST',
               url: '../Returns/Log',
               data: '{ "OriginationFom" : "UOList","ServiceName" : "RTTIE034","ResponseXML" : "' + btoa(ResXML.toString()) + '"}',
               contentType: 'application/json; charset=utf-8',
               dataType: 'json',
               success: function (msg) {

               }
           });
           //alert(parent.$g.oUOList);
         
           $('#AppHeader').html('U&O Account Request');
           $('#AppMessage').html('<BR>Enter the U&O account number and Select the submit button to retrieve a list of tax filings for that account');

           if (parent.$x.ispXmlGetRecCount(parent.$g.oUOList, 'UO_ACCT', 'n') != 0) {

               UOList_PopAccounts();
               //UOList_SetUOYears();
               UOList_PopulateYears();
           }

       } //DisplayUOList

       function UOList_PopAccounts() {
           if (HasUOAccounts) {
               //Load dropdown with UO accounts
               var ddlUOAccount = document.getElementById('ddlUOAccount');
               var iCount = parent.$x.ispXmlGetRecCount(parent.$g.oUOList, 'UO_ACCT', 'n');
               //alert("iCount:   " +  iCount);
               ddlUOAccount.options.length = iCount;
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
           debugger;
           var ddlUOAccount = document.getElementById('ddlUOAccount');
           var ddlUOYears = document.getElementById('ddlUOYears');
           var yy = parseInt($(ddlUOYears.options[ddlUOYears.selectedIndex]).text());

           var mm = ispGetNumaricMonth($(a).attr("value"));
           // var tempXML = parent.$g.getXmlDocObj(); //new ActiveXObject("MSXML.DOMDocument")	
           var page = "";

           if (yy >= 2013) {
               if (mm >= 7) {
                   page = "new";
                   parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, 'INQ', 'UO_ACCT RETURN_STATUS', '', 0);
                   parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, $(ddlUOAccount.options[ddlUOAccount.selectedIndex]).text(), 'UO_ACCT ACCOUNT_ID', '', 0);

                   if ($(a).text() == 'February' && ispCheckLeapYear($(ddlUOYears.options[ddlUOYears.selectedIndex]).val()-1)) {
                       parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, $(ddlUOYears.options[ddlUOYears.selectedIndex]).val()-1 + '0229', 'UO_ACCT PERIOD', '', 0);
                       //	alert($(ddlUOYears.options[ddlUOYears.selectedIndex]).text());
                   } else {

                       parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, $(ddlUOYears.options[ddlUOYears.selectedIndex]).val()-1 + $(a).attr('period'), 'UO_ACCT PERIOD', '', 0);

                       //clipboardData.setData ('Text', parent.$g.oUOForm.xml.xml);
                   }
                   //alert(parent.$g.oUOForm.xml.xml);
                   //clipboardData.setData ('Text', parent.$g.oUOFormNew.xml.xml);
               }
               else {
                   page = "new";
                   parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, 'INQ', 'UO_ACCT RETURN_STATUS', '', 0);
                   parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, $(ddlUOAccount.options[ddlUOAccount.selectedIndex]).text(), 'UO_ACCT ACCOUNT_ID', '', 0);

                   if ($(a).text() == 'February' && ispCheckLeapYear($(ddlUOYears.options[ddlUOYears.selectedIndex]).val())) {
                       parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, $(ddlUOYears.options[ddlUOYears.selectedIndex]).val() + '0229', 'UO_ACCT PERIOD', '', 0);
                       //	alert($(ddlUOYears.options[ddlUOYears.selectedIndex]).text());
                   } else {

                       parent.$x.ispXmlSetFieldVal(parent.$g.oUOFormNew, $(ddlUOYears.options[ddlUOYears.selectedIndex]).val() + $(a).attr('period'), 'UO_ACCT PERIOD', '', 0);

                       //clipboardData.setData ('Text', parent.$g.oUOForm.xml.xml);
                   }
               }

               ispCallXMLForm(parent.$g.oUOFormNew, parent.$g.oUOFormNew, "UO/UOFormCallNew", "");
               /*ispCallXMLForm(parent.$g.oUOFormNew, tempXML, "UOFormCallNew.asp", "");      
               parent.$g.oUOFormNew.loadXML(tempXML.xml);*/

           }
           else {
               debugger;
               page = "old";
               if (mm >= 7) {
                   parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, 'INQ', 'UO_ACCT RETURN_STATUS', '', 0);
                   parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, $(ddlUOAccount.options[ddlUOAccount.selectedIndex]).text(), 'UO_ACCT ACCOUNT_ID', '', 0);

                   if ($(a).text() == 'February' && ispCheckLeapYear($(ddlUOYears.options[ddlUOYears.selectedIndex]).val()-1)) {
                       parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, $(ddlUOYears.options[ddlUOYears.selectedIndex]).val()-1 + '0229', 'UO_ACCT PERIOD', '', 0);
                       //	alert($(ddlUOYears.options[ddlUOYears.selectedIndex]).text());

                   } else {
                       // ispXmlSetFieldVal(oUOForm, ddlUOYears.options(ddlUOYears.selectedIndex).innerText + a.getAttribute('period'), 'UO_ACCT PERIOD', '', 0);
                       // alert('value to set' + $(ddlUOYears.options[ddlUOYears.selectedIndex]).text() + $(a).attr('period'));
                       parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, $(ddlUOYears.options[ddlUOYears.selectedIndex]).val()-1 + $(a).attr('period'), 'UO_ACCT PERIOD', '', 0);
                       //clipboardData.setData ('Text', parent.$g.oUOForm.xml.xml);

                   }
               }
               else {
                   parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, 'INQ', 'UO_ACCT RETURN_STATUS', '', 0);
                   parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, $(ddlUOAccount.options[ddlUOAccount.selectedIndex]).text(), 'UO_ACCT ACCOUNT_ID', '', 0);

                   if ($(a).text() == 'February' && ispCheckLeapYear($(ddlUOYears.options[ddlUOYears.selectedIndex]).val())) {
                       parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, $(ddlUOYears.options[ddlUOYears.selectedIndex]).val() + '0229', 'UO_ACCT PERIOD', '', 0);
                       //	alert($(ddlUOYears.options[ddlUOYears.selectedIndex]).text());

                   } else {
                       // ispXmlSetFieldVal(oUOForm, ddlUOYears.options(ddlUOYears.selectedIndex).innerText + a.getAttribute('period'), 'UO_ACCT PERIOD', '', 0);
                       // alert('value to set' + $(ddlUOYears.options[ddlUOYears.selectedIndex]).text() + $(a).attr('period'));
                       parent.$x.ispXmlSetFieldVal(parent.$g.oUOForm, $(ddlUOYears.options[ddlUOYears.selectedIndex]).val() + $(a).attr('period'), 'UO_ACCT PERIOD', '', 0);
                       //clipboardData.setData ('Text', parent.$g.oUOForm.xml.xml);

                   }
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

       function UOList_PopulateYears() {
           debugger;
           var ddlUOAccount = document.getElementById('ddlUOAccount');
           var ddlUOYears = document.getElementById('ddlUOYears');
           divList.style.display = 'none';
           divNoList.style.display = 'none';
           var iMaxYears = 10;
           var iAcctSelectedIdx = ddlUOAccount.selectedIndex;
           sStartDate = parent.$x.ispXmlGetFieldVal(parent.$g.oUOList, 'UO_ACCT START_DATE', '', iAcctSelectedIdx);  //ispXmlGetFieldVal(parent.MenuWin.oUOList, 'UO_ACCT START_DATE', '', iAcctSelectedIdx);
          
           iStartYear = sStartDate.substring(0,4);   /// int(sStartDate.substring(6));
           iStartMonth = sStartDate.substring(6, 4);   //int(sStartDate.substring(0, 2));
           sEndDate = parent.$x.ispXmlGetFieldVal(parent.$g.oUOList, 'UO_ACCT END_DATE', '', iAcctSelectedIdx); //ispXmlGetFieldVal(parent.MenuWin.oUOList, 'UO_ACCT END_DATE', '', iAcctSelectedIdx)
           iEndMonth = (sEndDate.substring(6, 4));
           iEndYear = (sEndDate.substring(0,4)) != 0 ? (sEndDate.substring(0,4)) : iCurrentYear;
           //  	if (iEndYear == 2017) {
           //  		iEndYear = 2016
           //  	}		//if
           //debugger
           if (iEndYear > 2013 && iEndMonth != 99 && iEndMonth > 6) {
               iEndYear = iEndYear + 1;
           }		//if

           if (iStartYear != 0) {
               var iNumOfYears = 0;
               if (iStartYear > 2013 && iStartMonth > 6) {
                   iNumOfYears = iEndYear - iStartYear;
               } else {
                   iNumOfYears = iEndYear - (iStartYear - 1);
               }		//if
               if (iStartYear == iEndYear) {
                   iNumOfYears = 1;
               }		//if 		
               if (iNumOfYears < iMaxYears) {
                   iMaxYears = iNumOfYears;
               }		//if
               ddlUOYears.options.length = 0;
               ddlUOYears.options.length = iMaxYears;
               var j = 0;
               for (i = 0; i < iMaxYears; i++) {
                   if (iEndYear - i > 2013) {
                       $(ddlUOYears.options[i]).text((iEndYear - (i + 1)) + '-' + (iEndYear - i));
                       $(ddlUOYears.options[i]).val(iEndYear - i);
                       j++;
                       } 
                   else {
                       //$(ddlUOYears.options[i]).val(iEndYear - i);
                       //$(ddlUOYears.options[i]).text(iEndYear - i);
                       $('#divList').css("display", "none");
                       
                       //ddlUOYears.options.length = 0;
                       //ddlUOYears.remove(0);
                   }		//if
               } 	//for   		
           } else {
               ddlUOYears.options.length = 0;
               ddlUOYears.remove(0);
           } 	//if
           debugger;
           ddlUOYears.options.length = j;
           divList.style.display = 'none';
           divNoList.style.display = 'none';

           if (ddlUOYears.options.length != 0) {
               $('#divList').css("display", "block");
               //UOList_ShowButtons();
               UOList_DisplayButtons();
           } else {
               $('#divNoList').css("display", "block");

           } 		//if
           var opts = $('#ddlUOYears')[0].options;
           if (opts[0].value == "") {
               $('#divNoList').css("display", "block");
               $('#divList').css("display", "none");
           }
           $('#lblPropLoc').html(parent.$x.ispXmlGetFieldVal(parent.$g.oUOList, 'UO_ACCT LOCATION', '', ddlUOAccount.selectedIndex));
           
           $('#lblStartDate').html(iStartMonth + '/' + sStartDate.substring(8, 6) + '/' + iStartYear);
           if (parent.$x.ispXmlGetFieldVal(parent.$g.oUOList, 'UO_ACCT END_DATE', '', ddlUOAccount.selectedIndex).indexOf("99/") > -1) {
               $('#lblEndDate').html("");
           } else {
               $('#lblEndDate').html(iEndMonth + '/' + sEndDate.substring(8, 6) + '/' + iEndYear);
           } 	//if
       } 	//UOList_PopulateYears

       
       function UOList_DisplayButtons() {
           debugger;
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
           var ddlUOAccount = document.getElementById('ddlUOAccount');
           var ddlUOYears = document.getElementById('ddlUOYears');
           var value = $(ddlUOYears.options[ddlUOYears.selectedIndex]).val();
           sFreq = parent.$x.ispXmlGetFieldVal(parent.$g.oUOList, 'UO_ACCT FREQ_YEAR'+ddlUOYears.selectedIndex , '', ddlUOAccount.selectedIndex);
           
           if (sFreq.toUpperCase() == "M") {
               if (value == '2014') {
                   $('#rowJan').css("display", "block");
                   $('#rowFeb').css("display", "block");
                   $('#rowMar').css("display", "block");
                   $('#rowApr').css("display", "block");
                   $('#rowMay').css("display", "block");
                   $('#rowJun').css("display", "block");
               }
               else {
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
               }

           } else if (sFreq.toUpperCase() == "Q") {
               if (value == '2014') {
                   $('#rowMar').css("display", "block");
                   $('#rowJun').css("display", "block");
               }
               else {
                   $('#rowMar').css("display", "block");
                   $('#rowJun').css("display", "block");
                   $('#rowSep').css("display", "block");
                   $('#rowDec').css("display", "block");
               }
           } else if (sFreq.toUpperCase() == "H") {
               if (value == '2014') {
                   $('#rowJun').css("display", "block");
               }
               else {
                   $('#rowJun').css("display", "block");
                   $('#rowDec').css("display", "block");
               }
           }

           
          
           if (value == "2013") {
               
               if (sFreq.toUpperCase() == "M") {
                   $('#rowJul').css("display", "none");
                   $('#rowAug').css("display", "none");
                   $('#rowSep').css("display", "none");
                   $('#rowOct').css("display", "none");
                   $('#rowNov').css("display", "none");
                   $('#rowDec').css("display", "none");
               } else if (sFreq.toUpperCase() == "Q") {
                   $('#rowSep').css("display", "none");
                   $('#rowDec').css("display", "none");
               } else if (sFreq.toUpperCase() == "H") {
                   $('#rowDec').css("display", "none");
               }
           }

          



       } //UOList_DisplayButtons
</script>
</head>
<body onload="DisplayUOList()">
    <div class="container-fluid no-padding" >

        <div class="block3">

            <div class="container-fluid">

                <div class="row">
        <div class="col-lg-12 col-md-12" style="display: block;" id="tab1">
            <div  class="blue_base_box">
               <%--<h2><span id="AppHeader">&nbsp;</span>  </h2>--%>
                 <h2>Tax Payer Information  |   <span id="AppHeader"></span>  </h2>
                <div class="inner_white-panel">
                <div class="contentsection">
                    <h4 id="AppMessage">&nbsp;</h4>
                    <div class="clearfix"></div>
                      <br>
                    <div class="row">


                        <div class="col-lg-12 u-o-account-request-01">
                      
                             <div class="well">
                                 <div class="row">
                                      <form>
                                    <div class="col-lg-2 col-sm-3 col-xs-6">
                                        <label class="select-lable-u-o">Select UO Account ID:</label>
                                    </div>
                                     <div class="col-lg-2 col-sm-2 col-xs-4 no-padding-left">
                                       
                                          <select class="form-control" id="ddlUOAccount" onchange="UOList_PopulateYears()" style="width:130px">
		                                <option></option>
	                                    </select>
                                    </div>
                                 </form>
                                 </div>
                                 <div class="row">
                                     <div class="col-lg-2 col-sm-3 col-xs-6">
                                         <label>Property Location:</label>
                                     </div>
                                     <div class="col-lg-3 col-sm-4 col-xs-6 no-padding-left"><span id="lblPropLoc"></span></div>
                                 </div>
                                 <div class="row">
                                     <div class="col-lg-2 col-sm-3 col-xs-6">
                                         <label>Start Date:</label>
                                     </div>
                                     <div class="col-lg-3 col-sm-3 col-xs-6 no-padding-left"><span id="lblStartDate"></span></div>
                                     <div class="col-lg-2 col-sm-3 col-xs-6">
                                         <label>End Date:</label>
                                     </div>
                                     <div class="col-lg-3 col-sm-3 col-xs-6 no-padding-left"><span id="lblEndDate"></span></div>
                                 </div>
                               <div class="row">
                                   <div class="col-lg-12 text-center red-text" id="divNoList" style="display:block"><label>No U&O return frequency found</label></div>
                               </div>
                                 
                                 
                             </div>
                        </div>
                        <div class="clearfix"></div>


                        <div class="col-lg-12 u-o-account-request-02" id="divList" style="display:block">
                            <div class="well">
                                 <div class="row">
                                      <form>
                                    <div class="col-lg-2 col-sm-3 col-xs-6">
                                        <label class="select-lable-u-o">Select U&O Year:</label>
                                    </div>
                                     <div class="col-lg-2 col-sm-2 col-xs-4 no-padding-left">
                                    <select class="form-control" id="ddlUOYears" onchange="UOList_DisplayButtons()" style="width:130px">
						            <option></option>
					               </select>
                                    </div>
                                 </form>
                                 </div>
                                <div class="row u-o-account-request-button">
                                    
                                    <div class="col-md-2 col-sm-2 col-xs-6" id="rowJul">
                                        <input type="button" id="btnJul" value="July" onclick="GotoUO1(this)"/>
                                    </div>
                                    <div class="col-md-2 col-sm-2 col-xs-6" id="rowAug">
                                        <input type="button" id="btnAug" value="August" onclick="GotoUO1(this)"/>
                                    </div>
                                    <div class="col-md-2 col-sm-2 col-xs-6" id="rowSep">
                                        <input type="button" id="btnSep" value="September" onclick="GotoUO1(this)"/>
                                    </div>
                                    <div class="col-md-2 col-sm-2 col-xs-6" id="rowOct">
                                        <input type="button" id="btnOct" value="October" onclick="GotoUO1(this)"/>
                                    </div>
                                    <div class="col-md-2 col-sm-2 col-xs-6" id="rowNov">
                                        <input type="button" id="btnNov" value="November" onclick="GotoUO1(this)"/>
                                    </div>
                                    <div class="col-md-2 col-sm-2 col-xs-6" id="rowDec">
                                        <input type="button" id="btnDec" value="December" onclick="GotoUO1(this)"/>
                                    </div>
                                    <div class="col-md-2 col-sm-2 col-xs-6" id="rowJan">
                                        <input type="button" id="btnJan" value="January" onclick="GotoUO1(this)"/>
                                    </div>
                                    <div class="col-md-2 col-sm-2 col-xs-6" id="rowFeb">
                                        <input type="button" id="btnFeb" value="February" onclick="GotoUO1(this)"/>
                                    </div>
                                    <div class="col-md-2 col-sm-2 col-xs-6" id="rowMar">
                                        <input type="button" id="btnMar" value="March" onclick="GotoUO1(this)"/>
                                    </div>
                                    <div class="col-md-2 col-sm-2 col-xs-6" id="rowApr">
                                        <input type="button" id="btnApr" value="April" onclick="GotoUO1(this)"/>
                                    </div>
                                    <div class="col-md-2 col-sm-2 col-xs-6" id="rowMay">
                                        <input type="button" id="btnMay" value="May" onclick="GotoUO1(this)"/>
                                    </div>
                                    <div class="col-md-2 col-sm-2 col-xs-6" id="rowJun">
                                        <input type="button" id="btnJun" value="June" onclick="GotoUO1(this)"/>
                                    </div>
                                </div>


                                </div>
                        </div>

                    </div>

                </div>
               </div>
              
            </div>
             <div class="clearfix"></div>
            </div>        
           </div>
          </div>
         </div>
        </div>
</body>
</html>
