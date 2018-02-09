<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
     <title></title>
     <!-- Bootstrap Core CSS -->
    <link href="../Content/Styles/bootstrap.css" rel="stylesheet" />

    <!-- Custom CSS -->
    <link href="../Content/Styles/copegov.css" rel="stylesheet" />
    <link href="../Content/Styles/style.css" rel="stylesheet" />
    <link href="../Content/Styles/Font.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="../Content/Styles/jPushMenu.css" />    

    <script type="text/javascript" language="javascript" src="../Content/Scripts/JqueryMin.js"></script>
    <script type="text/javascript" language="javascript" src="../Content/Scripts/ispFunctions.js"></script>
    <script type="text/javascript" language="javascript" src="../Content/Scripts/ispXmlProc.js"></script>

 

    <link type="text/css" rel="Stylesheet" href="../Content/Styles/framestyle.css" />
    <script language="javascript" type="text/javascript">

        var oCouponInfo = parent.$g.getXmlDocObj();
        parent.$g.loadXmlAsync('XML/PayCoupon', load_oCouponInfo);
        function load_oCouponInfo(xml) {
            oCouponInfo.xml = xml;
        }
        function DisplayNTL() {

            debugger;
            
            $('#AppError').html('');
            $('#AppHeaderNTL').text('No Tax Liability');           
            $('#AppMessage').text('Complete this screen to file a no wage tax liabilty coupon for the period selected.');          
            $('#PrtCoupAcctID').text('Wage Tax - ' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "WAGE_NTL ACCOUNT_ID", "", 0));
            var chkAgreement = document.getElementById('chkAgreement');
           
            var lsPeriod = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "WAGE_NTL PERIOD", "", 0);
            if (lsPeriod.substr(4, 2) == '01') {
                lsPeriod = 'January ' + lsPeriod.substr(6, 2) + ', ' + lsPeriod.substr(0, 4)
            } else if (lsPeriod.substr(4, 2) == '02') {
                lsPeriod = 'February ' + lsPeriod.substr(6, 2) + ', ' + lsPeriod.substr(0, 4)
            } else if (lsPeriod.substr(4, 2) == '03') {
                lsPeriod = 'March ' + lsPeriod.substr(6, 2) + ', ' + lsPeriod.substr(0, 4)
            } else if (lsPeriod.substr(4, 2) == '04') {
                lsPeriod = 'April ' + lsPeriod.substr(6, 2) + ', ' + lsPeriod.substr(0, 4)
            } else if (lsPeriod.substr(4, 2) == '05') {
                lsPeriod = 'May ' + lsPeriod.substr(6, 2) + ', ' + lsPeriod.substr(0, 4)
            } else if (lsPeriod.substr(4, 2) == '06') {
                lsPeriod = 'June ' + lsPeriod.substr(6, 2) + ', ' + lsPeriod.substr(0, 4)
            } else if (lsPeriod.substr(4, 2) == '07') {
                lsPeriod = 'July ' + lsPeriod.substr(6, 2) + ', ' + lsPeriod.substr(0, 4)
            } else if (lsPeriod.substr(4, 2) == '08') {
                lsPeriod = 'August ' + lsPeriod.substr(6, 2) + ', ' + lsPeriod.substr(0, 4)
            } else if (lsPeriod.substr(4, 2) == '09') {
                lsPeriod = 'September ' + lsPeriod.substr(6, 2) + ', ' + lsPeriod.substr(0, 4)
            } else if (lsPeriod.substr(4, 2) == '10') {
                lsPeriod = 'October ' + lsPeriod.substr(6, 2) + ', ' + lsPeriod.substr(0, 4)
            } else if (lsPeriod.substr(4, 2) == '11') {
                lsPeriod = 'November ' + lsPeriod.substr(6, 2) + ', ' + lsPeriod.substr(0, 4)
            } else if (lsPeriod.substr(4, 2) == '12') {
                lsPeriod = 'December ' + lsPeriod.substr(6, 2) + ', ' + lsPeriod.substr(0, 4)
            }		//if
          
            if (lsPeriod.substr(0, 11) == 'December 30') {
                lsPeriod = lsPeriod.replace('30', '31');                
            }		//if
           
            $('#PrtCoupPeriod').text(lsPeriod);
           
            $('#PrtEntityName').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "ENTITY_INFO NAME", '', 0));
            var info = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "ENTITY_INFO ADDRESS1", '', 0) +
                    '<br>' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "ENTITY_INFO CITY", '', 0) + ', ' +
                    parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "ENTITY_INFO STATE", '', 0) + ' ' +
                    parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "ENTITY_INFO ZIP_CODE", '', 0)
            $('#PrtEntityAddr').html(info);
            chkAgreement.checked = false;
          
        }		//DisplayNTL

        function SubmitNTL() {
           
            $('#AppError').html('');
            var validerr = ValidatePreparer();

            $('#AppError').text(validerr);

            if (validerr != '') {
                return
            }		//if

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, "", "ERROR_INFO ERROR", '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, "", "ERROR_INFO MESSAGE", '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, "N", "ENTITY_INFO FUNCTION_CODE", '', 0);
            
            PopulatePreparerXML(parent.$g.xmlPayCoupon, "WAGE_NTL");

            
            for (i = 199; i > 0; i--) {
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, 'TAX_ACCT ACCOUNT', "", i) == '0') {
                  
                    $(parent.$g.xmlPayCoupon.xml).find('PAYCOUPON TAX_ACCT').eq(i).remove();

                } else {
                }		//if
            }		//for

            var ReqXML = parent.$g.xmlPayCoupon;
            $.ajax({
                type: 'POST',
                url: '../Returns/Log',
                data: '{ "OriginationFom" : "NTL","ServiceName" : "RTTIE016","RequestXML" : "' + btoa(ReqXML.toString()) + '"}',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (msg) {

                }
            });
            ispCallXMLForm(parent.$g.xmlPayCoupon, oCouponInfo, "PayCoupon/PayCouponRecv", "");

            parent.$g.xmlPayCoupon.loadXML(oCouponInfo.xml);

            var ResXML = parent.$g.xmlPayCoupon;
            $.ajax({
                type: 'POST',
                url: '../Returns/Log',
                data: '{ "OriginationFom" : "NTL","ServiceName" : "RTTIE016","ResponseXML" : "' + btoa(ResXML.toString()) + '"}',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (msg) {

                }
            });

            if (parent.$x.ispXmlGetFieldVal(oCouponInfo, 'ERROR_INFO MESSAGE', "", 0) == "") {               
                $('#divNTL_Init').css("display", "none");
                $('#divNtlThankYou').css("display", "block");               
                $('#lblPeriod').text($('#PrtCoupPeriod').text());
                $('#lblName').text(parent.$x.ispXmlGetFieldVal(oCouponInfo, 'ENTITY_INFO NAME', "", 0));
                $('#lblAcctNo').text(parent.$x.ispXmlGetFieldVal(oCouponInfo, "WAGE_NTL ACCOUNT_ID", "", 0));
                $('#lblConfirmNo').text(parent.$x.ispXmlGetFieldVal(oCouponInfo, 'WAGE_NTL ADJ_REF_NO', "", 0));
            } else {
          
                $('#AppError').text(parent.$x.ispXmlGetFieldVal(oCouponInfo, 'ERROR_INFO MESSAGE', "", 0));
            }		//if
        }		//SubmitNTL

        function DoThankYou() {           
            parent.$g.xmlAccount = parent.$g.xmlTemplate;          
            $(parent.mnuLogPayCoupon).addClass('mnuNormal');
            parent.setFrameUrl('login/Main');            
        }		//DoThankYou

        function ReturnToSelection() {          
            parent.setFrameUrl('PayCoupon/PayCoupon');
        }		//ReturnToSelection
    </script>
</head>
<body onload="DisplayNTL()">

    <div class="container-fluid no-padding" style="display: block;" id="divNTL_Init">
        <div class="block3">

            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12 col-md-12">
                        <div style="display: block;" id="tab2" class="blue_base_box">
                            <h2><span id="AppHeaderNTL">&nbsp;</span>  </h2>
                            <div class="inner_white-panel">
                                <div class="contentsection">
                                  <div class="col-lg-12 col-lg-offset-0 no-padding-left">
                                                  <div id="AppError" class="errormsg no-padding" style="display:block;">
                                                   </div>
                                                     </div>
                                   
                                      
                                       <div class="row"> 
                                        <div class="col-lg-12 templateclass">

                                        <table class="hor-zebra" cellSpacing="0" cellPadding="0"  border="0" id="frmNTL_Init"
                                    style="margin:0 15px !important; border-left:#E6E6E6 1px solid;">
		
			
			                <tr>
			
			                <td align=left style="border-top:#E6E6E6 1px solid;">
				                &nbsp;Account Number:</td>
			                <td align=left style="Padding-left: 10px;" class=lbltext 
				                id="PrtCoupAcctID" ></td>
	   		
			                </tr>
			
			                <tr>
			
			                <td align=left style=""> &nbsp;Period:</td>
			                <td align=left style="Padding-left: 10px;" id="PrtCoupPeriod" ></td>
	   		
			                </tr>
			
			                <tr>
			
			                <td align=left style="">&nbsp;Amount Owed:</td>
			                <td align=left style="Padding-left: 10px;"><p>$0.00</p></td>
	   		
			                </tr>
			
			
			                <tr>
			
			                <td align=left style="Padding-left: 10px; Height: 18px;"				      
					                type="lbltext" size="36" 
					                id="PrtEntityName" 
					                class=lbltext valign=top></td>
					                <td align=left style="Padding-left: 10px; Height: 18px;"
					                type="lbltext" size="36" id="PrtEntityAddr" 
					                class=lbltext></td>
				
			                </tr>

			
			                <tr>
			                <td colspan=2 align=left>&nbsp;</td>
			                </tr>
			
			                <tr>
			                <td colspan=2>

                            <%
                                Html.RenderAction("PreparerSection", "INC");    
                            %>                

			                </td>
			                <tr>
			
			                <tr>
				                <td colspan=2><p>&nbsp;</p></td><tr>
				
			                <tr>
			                <td colspan=2><p><span style="font-size:13px; color:red;line-height:18px;">*</span> You must complete all fields before clicking the Submit NTL button.</p></td>
			                <tr>
			
			                <tr>
			                <td colspan=2><p>&nbsp;</p></td><tr>
			
			               
			
	                 </table>
                                            <div class="col-sm-offset-3 col-sm-9  text-right">
                                                      <input type="button" onclick="SubmitNTL()" class="btn btn-default submit_button_light" value="Submit NTL" id="btnNtlSubmit">
                                               <input type="button" onclick="ReturnToSelection()" id="btnNtlCancel" class="btn btn-default submit_button" value="Cancel">                  
                                               
                                                </div>


                                        </div>
                                        </div>
                            </div>
                                
                            </div>
            
                        </div>


                    </div>

                </div>
                
            </div>
        </div>
    </div>

    <%
                                Html.RenderAction("NTL_ThankYou", "PayCoupon");    
                                %>
</body>
</html>
