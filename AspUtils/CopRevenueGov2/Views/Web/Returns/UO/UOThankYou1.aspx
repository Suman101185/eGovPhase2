<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<CopRevenueGov2.Models.Web.Returns.UOThankYouModel>" %>

<!DOCTYPE html>

<html>
<head>  
    <title></title>
     <!-- Bootstrap Core CSS -->
    <link href="../../Content/Styles/bootstrap.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="../../Content/Styles/copegov.css" rel="stylesheet">
    <link href="../../Content/Styles/style.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../../Content/Styles/jPushMenu.css">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
   <script id="clientEventHandlersJS" language="javascript" type="text/javascript">

       function UOThankYouDisplay() {
           //frmePay.imgCards.src = '../../Images/ePay.gif'
           //$(frmePay.imgCards).attr("src", "../../../../Content/Images/ePay.gif");
           //xmlCC.src = '../../xml/CCBilling.xml'
           //xmlCCTemplate.src = '../../xml/CCBilling.xml'

           $('#lblNameTY').text($('#lblName').text())

           $('#lblAcctNo').text(parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO_ACCT ACCOUNT_ID', '', 0));
           if (parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO_ACCT ADJUSTMENT_REF_NO', '', 0) != '') {
               $('#lblConfirmNo').text(parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO_ACCT ADJUSTMENT_REF_NO', '', 0));
           } else {
               $('#lblConfirmNo').text($('#lblAcctNo').text())

           }		//if Adjustment reference number
           $('#divUOThankYou').css("display", "block");

           this.focus()
           parent.gsInstructionItem = ''
           $('#AppMessage').html('');
           $('#AppHeaderThankyou').html(txtHeader + '<Font class=hdrMedium>|thank you</Font>');
           $('#ccFeeText').text('A user fee of 2.49% will be charged in addition to the amount of tax due.');
           var sPeriod = parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO_ACCT PERIOD', '', 0);
           sPeriod = sPeriod.substr(0, 4);
           $('#lblFileYear').text(sPeriod + ' ');
       }		//DisplayThankyou


       //AppHeaderThankyou
       function DoThankYou() {
           var sEmailMsg
           if (txaComments.value != '') {
               sEmailMsg = '<p align=middle><strong>Comments and Feedback</strong></p>'
               sEmailMsg += '<p>The following comments or feedback was submitted by: '
               sEmailMsg += parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS NAME', '', 0) + '</p>'
               sEmailMsg += '<p>Company: '
               sEmailMsg += parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS TRADE_NAME', '', 0) + '</p>'
               sEmailMsg += '<p>E-mail address: '
               sEmailMsg += parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS EMAIL', '', 0) + '</p><br>'
               sEmailMsg += '<p><strong>Message: </strong></p>'
               sEmailMsg += '<p>' + txaComments.value + '</p>'

               sEmailMsg = sEmailMsg.replace('>', '&GT&');
               sEmailMsg = sEmailMsg.replace('<', '&LT&');

               parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, 'COMMENT', 'FUNCTION', '', 0)
               parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, sEmailMsg, 'DATA', '', 0)

               ispCallXMLForm(parent.$g.xmlEmail, parent.$g.xmlEmail, 'MailPIN', '')
           }		//if
           //parent.DocWin.location.href = '../../Acct/ApplyMain'
           parent.setFrameUrl('Acct/ApplyMain');
       }		//DoThankYou

       //EOGVWEB-69 EDD Added function to print coupon
       function DoPrintCoupon() {
           parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, 'UO', 'COUPON_FORM CPN_FORM', '')
           parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, '84', 'COUPON_FORM CPN_ACCOUNT_TYPE', '')
           parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO_ACCT ACCOUNT_ID', '', 0), 'COUPON_FORM CPN_ACCOUNT', '')
           parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS NAME', '', '0'), 'COUPON_FORM CPN_NAME', '')
           parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS1', '', '0'), 'COUPON_FORM CPN_ADDR', '')
           parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS2', '', '0'), 'COUPON_FORM CPN_ADDR2', '')
           parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, "", 'COUPON_FORM CPN_ADDR3', '')
           parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS CITY', '', '0'), 'COUPON_FORM CPN_CITY', '')
           parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS STATE', '', '0'), 'COUPON_FORM CPN_STATE', '')
           parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ZIP', '', '0'), 'COUPON_FORM CPN_ZIP_CODE', '')
           //Period for UO (YYYYMMDD) different from other types (MM/DD/YYYY) - Coupon needs (MM/DD/YYYY)
           var sPeriod = parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO_ACCT PERIOD', '', 0)
           sPeriod = sPeriod.substr(4, 2) + '/' + sPeriod.substr(6, 2) + '/' + sPeriod.substr(0, 4)
           parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, sPeriod, 'COUPON_FORM CPN_PERIOD', '')
           parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, sPeriod.substr(6, 4), "COUPON_FORM CPN_YEAR", "")
           ispDisplayProgress('', 'Creating Use and Occupancy Tax Coupon')
           SetupPassFields()
           parent.DocWin.location.href = '../../PayCoupon/PDFCouponCreate?' + tempParameters
       }		//DoPrintCoupon

</script>
</head>
<body>
 <div id="divUOThankYou" style="display: none;" class="container-fluid no-padding">
    <div class="block3">
        <div class="container-fluid">
        <div class="row">
        <div class="col-lg-12 col-md-12">   
       	<div class="blue_base_box">
               <h2>Tax Payer Information  |   <span>thank you </span>  </h2>
            <div class="inner_white-panel">
           <div class="contentsection">
            <div class="row">
                <div class="col-lg-12">
                    <div class="well">
                        <div class="row">                          
                            <div class="col-lg-12 templateclass">
                                <h4 id="hdrThankYou">Your Return is now being processed.
                                        <br>
                                    You may want to print a copy of this page for your records.<br>
                                    Thank you for filing your  <%=(AspUtils.Util.GetInt(Model.sCurrentYear) - 1).ToString( )%>  Use and Occupancy Tax Return online.</h4>


                            </div>
                        </div>
                    </div>

                    <div class="row">


                        <div class="table-responsive">

                            <table class="table table-condensed table-striped custom_table03">


                                <tbody>

                                    <tr>
                                        <td width="10%" class="text-left">Name</td>
                                        <td  class="text-left">
                                            <form class="form-horizontal">

                                                <div class="form-group no-margin">
                                                    <div>
                                                        <label id='lblNameTY'></label>

                                                    </div>
                                                </div>

                                            </form>
                                        </td>
                                    </tr>

                                    <tr class="odd">
                                        <td width="10%" class="text-left">Account No</td>
                                        <td  class="text-left">
                                            <form class="form-horizontal">

                                                <div class="form-group no-margin">
                                                    <div>
                                                        <label  id='lblAcctNo'></label>

                                                    </div>
                                                </div>

                                            </form>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="20%" class="text-left">Your Confirmation No. is</td>
                                        <td  class="text-left">
                                            <form class="form-horizontal">

                                                <div class="form-group no-margin">
                                                    <div>
                                                        <label id="lblConfirmNo"></label>

                                                    </div>
                                                </div>

                                            </form>
                                        </td>
                                    </tr>

                                </tbody>



                            </table>

                        </div>

                        <h3 class="text-center">Payment Option</h3>
                        <div><% Html.RenderAction("CCPage", "CreditCard"); %> </div>
                        <div class="table-responsive">
                            <h5>Coupon</h5>


                        </div>

                        <form class="form-horizontal school_form">


                            <div class="form-group">
                                <div class="col-sm-offset-3 col-sm-9  text-right">

                                    <a class="btn btn-default submit_button" onclick="DoPrintCoupon()">Print Coupon </a>


                                    <%--  <button class="btn btn-default submit_button" type="submit">Print Coupon</button>--%>
                                </div>
                            </div>

                        </form>

                        <div class="well">
                            <div class="row">

                                <div class="col-lg-12 templateclass">
                                    <p>
                                        Attach a check for	the amount 
				due, payable to the "City of Philadelphia" and mail the coupon and check to:
                                    </p>
                                    <p>
                                        Philadelphia Department
				of Revenue<br>
                                        P.O. Box 1393<br>
                                        Philadelphia, PA 19105-9731
                                    </p>
                                    <br>
                                </div>
                            </div>
                        </div>

                        <div class="well">
                            <div class="row">

                                <div class="col-lg-12 templateclass">
                                    <h5>Others</h5>
                                    <p>
                                        if you do not want to pay by credit card and you do not
				have a coupon, print a copy of this page to mail with your payment to the address noted
				above.
                                    </p>

                                    <p>
                                        We would appreciate your comments / feedback concerning your online experience.<br>
                                        Please enter your comments / feedback below:
                                    </p>
                                </div>
                            </div>
                            <div class="table-responsive">

                                <table class="table table-condensed table-striped custom_table03">


                                    <tbody>

                                        <tr>
                                            <td width="90%" class="text-left" style="border-top: 0;">
                                                <form class="form-horizontal">

                                                    <div class="form-group no-margin">
                                                        <div>

                                                            <textarea class="form-control input-sm" id="txaComments"  name="txaComments"></textarea>
                                                        </div>
                                                    </div>

                                                </form>
                                            </td>
                                        </tr>



                                    </tbody>



                                </table>

                            </div>

                            <form class="form-horizontal school_form">


                                <div class="form-group">
                                    <div class="col-sm-offset-3 col-sm-9  text-right">

                                       <input type="button" class="btn btn-default submit_button" value="Thank You" id="btnUOThankYou" name="btnUOThankYou" onclick="DoThankYou()"/>
                                        <div class="clearfix"></div>
                                    </div>
                                </div>

                            </form>

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
        <div class="clearfix"></div>
        </div>
    </div>
</div>
</body>
</html>



