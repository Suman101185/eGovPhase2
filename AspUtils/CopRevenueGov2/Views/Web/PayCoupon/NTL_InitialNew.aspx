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

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script type="text/javascript" language="javascript" src="../Content/Scripts/JqueryMin.js"></script>
    <script type="text/javascript" language="javascript" src="../Content/Scripts/ispFunctions.js"></script>
    <script type="text/javascript" language="javascript" src="../Content/Scripts/ispXmlProc.js"></script>

    <%--<link rel="Stylesheet" href="../Content/Styles/Font.css" />
<link rel="Stylesheet" href="../Content/Styles/Object.css" />--%>

    <link type="text/css" rel="Stylesheet" href="../Content/Styles/framestyle.css" />
    <script language="javascript" type="text/javascript">

        var oCouponInfo = parent.$g.getXmlDocObj();
        parent.$g.loadXmlAsync('XML/PayCoupon', load_oCouponInfo);
        function load_oCouponInfo(xml) {
            oCouponInfo.xml = xml;
        }
        function DisplayNTL() {

            $('#AppHeaderNTL').text('No Tax Liability');
            //AppMessage.innerText = "Complete this screen to file a no wage tax liabilty coupon for the period selected."
            $('#AppMessage').text('Complete this screen to file a no wage tax liabilty coupon for the period selected.');
            //alert('in');
            $('#PrtCoupAcctID').text('Wage Tax - ' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "WAGE_NTL ACCOUNT_ID", "", 0));

            //alert('in');
            //PrtCoupAcctID.innerText = 'Wage Tax - ' + 
            //	parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "WAGE_NTL/ACCOUNT_ID", "", 0)
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
            //EGOVWEB-61 EDD 2011.02.04 Last week payment must be 12/31/ccyy per Nancy Needs to be redisplayed as 31
            if (lsPeriod.substr(0, 11) == 'December 30') {
                lsPeriod = lsPeriod.replace('30', '31');
                //		alert(lsPeriod)
            }		//if
            //PrtCoupPeriod.innerText = lsPeriod
            $('#PrtCoupPeriod').text(lsPeriod);
            //PrtEntityName.innerText = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "ENTITY_INFO/NAME", '', 0)
            $('#PrtEntityName').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "ENTITY_INFO NAME", '', 0));
            var info = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "ENTITY_INFO ADDRESS1", '', 0) +
                    '<br>' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "ENTITY_INFO CITY", '', 0) + ', ' +
                    parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "ENTITY_INFO STATE", '', 0) + ' ' +
                    parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "ENTITY_INFO ZIP_CODE", '', 0)
            $('#PrtEntityAddr').html(info);
            /*PrtEntityAddr.innerHTML = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "ENTITY_INFO ADDRESS1", '', 0) +
                    '<br>' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "ENTITY_INFO CITY", '', 0) + ', ' +
                    parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "ENTITY_INFO STATE", '', 0) + ' ' +
                    parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "ENTITY_INFO ZIP_CODE", '', 0)*/
        }		//DisplayNTL

        function SubmitNTL() {
            //	var xmlNTL = new ActiveXObject("MSXML.DOMDocument")
            $('#AppError').html('');
            var validerr = ValidatePreparer();

            $('#AppError').text(validerr);

            if (validerr != '') {
                return
            }		//if

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, "", "ERROR_INFO ERROR", '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, "", "ERROR_INFO MESSAGE", '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, "N", "ENTITY_INFO FUNCTION_CODE", '', 0);
            //alert('in');
            PopulatePreparerXML(parent.$g.xmlPayCoupon, "WAGE_NTL");

            //EGOVWEB-61
            for (i = 199; i > 0; i--) {
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, 'TAX_ACCT ACCOUNT', "", i) == '0') {

                    //parent.$x.ispXmlRemoveNode(parent.$g.xmlPayCoupon, 'PAYCOUPON', 0, 'TAX_ACCT', i);
                    $(parent.$g.xmlPayCoupon.xml).find('PAYCOUPON TAX_ACCT').eq(i).remove();

                } else {
                }		//if
            }		//for


            ispCallXMLForm(parent.$g.xmlPayCoupon, oCouponInfo, "PayCoupon/PayCouponRecv", "");

            if (parent.$x.ispXmlGetFieldVal(oCouponInfo, 'ERROR_INFO MESSAGE', "", 0) == "") {
                //alert("1");
                $('#divNTL_Init').css("display", "none");
                $('#divNtlThankYou').css("display", "block");
                //divNtlThankYou.style.display = "block"
                //lblPeriod.innerText = PrtCoupPeriod.innerText
                $('#lblPeriod').text($('#PrtCoupPeriod').text());
                $('#lblName').text(parent.$x.ispXmlGetFieldVal(oCouponInfo, 'ENTITY_INFO NAME', "", 0));
                $('#lblAcctNo').text(parent.$x.ispXmlGetFieldVal(oCouponInfo, "WAGE_NTL ACCOUNT_ID", "", 0));
                $('#lblConfirmNo').text(parent.$x.ispXmlGetFieldVal(oCouponInfo, 'WAGE_NTL ADJ_REF_NO', "", 0));
            } else {

                //AppError.innerText = parent.$x.ispXmlGetFieldVal(oCouponInfo, 'ERROR_INFO/MESSAGE', "", 0)
                $('#AppError').text(parent.$x.ispXmlGetFieldVal(oCouponInfo, 'ERROR_INFO MESSAGE', "", 0));
            }		//if
        }		//SubmitNTL

        function DoThankYou() {
            //	Clear Account XML so the Main Page Displays
            //parent.$g.xmlAccount.loadXML(parent.$g.xmlTemplate.xml)
            parent.$g.xmlAccount = parent.$g.xmlTemplate;
            //parent.MenuWin.mnuLogPayCoupon.className = 'mnuNormal'
            $(parent.mnuLogPayCoupon).addClass('mnuNormal');
            parent.setFrameUrl('login/Main');
            // parent.DocWin.location.href = '../login/Main';
        }		//DoThankYou

        function ReturnToSelection() {
            //parent.DocWin.location.href = 'PayCoupon';
            parent.setFrameUrl('PayCoupon/PayCoupon');
        }		//ReturnToSelection
    </script>
</head>
<body onload="DisplayNTL()">

    <div class="container-fluid no-padding">
        <div class="block3">

            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12 col-md-12">
                        <div style="display: block;" id="tab2" class="blue_base_box">
                            <h2><span id="AppHeaderNTL">&nbsp;</span>  </h2>
                            <div class="inner_white-panel">
                                <div class="contentsection" style="display: block;" id="divNTL_Init">
                   
                                    <div class="clearfix"></div>
                                      <br>
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
			                <td colspan=2><p><FONT color=red size=5pt>*</FONT> You must complete all fields before clicking the Submit NTL button.</p></td>
			                <tr>
			
			                <tr>
			                <td colspan=2><p>&nbsp;</p></td><tr>
			
			                <tr id="coup2">
			
			                <td><p><INPUT id=btnNtlSubmit onclick=SubmitNTL() type=button value="Submit NTL"></p></td>
			
			                <td><p><INPUT id=btnNtlCancel onclick=ReturnToSelection() type=button value=Cancel></p></td>
		 	
			                </tr>
			
	                 </table>
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
            </div>
        </div>
    </div>
</body>
</html>
