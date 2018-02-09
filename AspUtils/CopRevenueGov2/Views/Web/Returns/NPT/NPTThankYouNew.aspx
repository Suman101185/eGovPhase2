<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

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
    <script id="Script1" language="javascript" type="text/javascript">

        //EDD Added function to print coupon
        function DoPrintCoupon() {
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, 'NPT', 'COUPON_FORM CPN_FORM', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, '3', 'COUPON_FORM CPN_ACCOUNT_TYPE', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.MenuWin.xmlNPT, 'NPT_INFO ACCOUNT_ID', '', 0), 'COUPON_FORM CPN_ACCOUNT', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, $('#lblThankYouName').text(), 'COUPON_FORM CPN_NAME', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS1', '', '0'), 'COUPON_FORM CPN_ADDR', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS2', '', '0'), 'COUPON_FORM CPN_ADDR2', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, "", 'COUPON_FORM CPN_ADDR3', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS CITY', '', '0'), 'COUPON_FORM CPN_CITY', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS STATE', '', '0'), 'COUPON_FORM CPN_STATE', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ZIP', '', '0'), 'COUPON_FORM CPN_ZIP_CODE', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.MenuWin.xmlNPT, 'NPT_INFO PERIOD', '', 0), 'COUPON_FORM CPN_PERIOD', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.MenuWin.xmlNPT, 'NPT_INFO PERIOD', '', 0).substr(6, 4), "COUPON_FORM CPN_YEAR", "")

            SetupPassFields()
            // parent.DocWin.location.href = '../../PayCoupon/PDFCouponCreate?' + tempParameters
            parent.setFrameUrl('PayCoupon/PDFCouponCreate?' + tempParameters);
        }		//DoPrintCoupon
    </script>
</head>
<body>
 <div id="divNPTThankYou" style="display: none;" class="container-fluid no-padding">
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
                            <%--<h2><span id="AppHeaderThankyou">&nbsp;</span>  </h2>--%>
                            <div class="col-lg-12 templateclass">
                                <h4 id="hdrThankYou">Your Return is now being processed.
                                        <br>
                                    You may want to print a copy of this page for your records.<br>
                                    Thank you for filing your <script>document.write(sCurrYear - 1)</script> Net Profit Tax Return online.</h4>


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
                                                        <label id='lblThankYouName'></label>

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

                                       <input type="button" class="btn btn-default submit_button" value="Thank You" id="btnNPTThankYou" name="btnSchoolThankYou" onclick="DoThankYou()"/>
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



