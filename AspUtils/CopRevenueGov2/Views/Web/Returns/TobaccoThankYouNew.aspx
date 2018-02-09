<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>

<html>
<head>
      <!-- Bootstrap Core CSS -->
    <link href="../Content/Styles/bootstrap.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="../Content/Styles/copegov.css" rel="stylesheet">
    <link href="../Content/Styles/style.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../Content/Styles/jPushMenu.css">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <meta name="viewport" content="width=device-width" />
    <script ID="clientEventHandlersJS" type="text/javascript" LANGUAGE="javascript">

        function DisplayTobaccoThankYou() {

            //loadXmlFiles();
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, '', 'COUPON_FORM CPN_FORM', '');
            $('#ispProgressScreen').css("display", "none");


            $('#lblNameTY').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS NAME', '', 0));	//lblName.innerText
            $('#lblAcctNo').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'TOBACCO_INFO ACCOUNT_ID', '', 0));
            $('#lblConfirmNo').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'TOBACCO_INFO ADJUSTMENT_REF_NO', '', 0));

            $('#divTobaccoThankYou').css("display", "block");
            this.focus();
            $('#AppMessage').html('');
            $('#AppHeaderThankyou').html(txtHeader + '<Font class=hdrMedium>|thank you</Font>');

        }		//DisplayThankyou

        function DoThankYou() {
            var sEmailMsg;

            if (txaComments.value != '') {
                sEmailMsg = '<p align=middle><strong>Comments and Feedback</strong></p>';
                sEmailMsg += '<p>The following comments or feedback was submitted by: ';
                sEmailMsg += parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS NAME', '', 0) + '</p>';
                sEmailMsg += '<p>Company: ';
                sEmailMsg += parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS TRADE_NAME', '', 0) + '</p>';
                sEmailMsg += '<p>E-mail address: ';
                sEmailMsg += parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESSEMAIL', '', 0) + '</p><br>';
                sEmailMsg += '<p><strong>Message: </strong></p>';
                sEmailMsg += '<p>' + txaComments.value + '</p>';

                sEmailMsg = sEmailMsg.replace('>', '&GT&');
                sEmailMsg = sEmailMsg.replace('<', '&LT&');

                parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, 'COMMENT', 'FUNCTION', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, sEmailMsg, 'DATA', '', 0);

                ispCallXMLForm(parent.$g.xmlEmail, parent.$g.xmlEmail, '../MailPIN', '');

            }		//if

            // parent.DocWin.location.href = '../Acct/ApplyMain';
            parent.setFrameUrl('Acct/ApplyMain');
        }		//DoThankYou


        function DoPrintCoupon() {


            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, 'TOBACCO', 'COUPON_FORM CPN_FORM', '');

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, '27', 'COUPON_FORM CPN_ACCOUNT_TYPE', '');
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'TOBACCO_INFO ACCOUNT_ID', '', 0), 'COUPON_FORM CPN_ACCOUNT', '');
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, $('#lblNameTY').text(), 'COUPON_FORM CPN_NAME', '');
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS1', '', '0'), 'COUPON_FORM CPN_ADDR', '');
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS2', '', '0'), 'COUPON_FORM CPN_ADDR2', '');
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, "", 'COUPON_FORM CPN_ADDR3', '');
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS CITY', '', '0'), 'COUPON_FORM CPN_CITY', '');
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS STATE', '', '0'), 'COUPON_FORM CPN_STATE', '');
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ZIP', '', '0'), 'COUPON_FORM CPN_ZIP_CODE', '');
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'TOBACCO_INFO PERIOD', '', 0), 'COUPON_FORM CPN_PERIOD', '');
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, '2012', "COUPON_FORM CPN_YEAR", "");
            ispDisplayProgress('', 'Creating Tobacco Tax Coupon');
            SetupPassFields();

            // parent.DocWin.location.href = '../PayCoupon/PDFCouponCreate?' + tempParameters;
            parent.setFrameUrl('PayCoupon/PDFCouponCreate?' + tempParameters);
        }		//DoPrintCoupon

</script>
    <title>Cop</title>
</head>
<body>
   <div id="divTobaccoThankYou" style="display: none;" class="container-fluid no-padding">
    <div class="block3">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12">
                    <div class="well">
                        <div class="row">
                            <h2><span id="AppHeaderThankyou">&nbsp;</span>  </h2>
                            <div class="col-lg-12 templateclass">
                                <h4 id="hdrThankYou">Your Return is now being processed.
                                        <br>
                                    You may want to print a copy of this page for your records.<br>
                                    Thank you for filing your <%= (AspUtils.Util.GetInt(Model.sCurrentYear) - 1).ToString( )%> Tobacco Tax Return online.</h4>


                            </div>
                        </div>
                    </div>

                    <div class="row">


                        <div class="table-responsive">

                            <table class="table table-condensed table-striped custom_table03">


                                <tbody>

                                    <tr>
                                        <td width="50%" class="text-left">Name</td>
                                        <td width="50%" class="text-left">
                                            <form class="form-horizontal">

                                                <div class="form-group no-margin">
                                                    <div>
                                                        <label class="form-control input-sm" id='lblName'></label>

                                                    </div>
                                                </div>

                                            </form>
                                        </td>
                                    </tr>

                                    <tr class="odd">
                                        <td width="50%" class="text-left">Account No</td>
                                        <td width="50%" class="text-left">
                                            <form class="form-horizontal">

                                                <div class="form-group no-margin">
                                                    <div>
                                                        <label class='form-control input-sm' id='lblAcctNo'></label>

                                                    </div>
                                                </div>

                                            </form>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="50%" class="text-left">Your Confirmation No. is</td>
                                        <td width="50%" class="text-left">
                                            <form class="form-horizontal">

                                                <div class="form-group no-margin">
                                                    <div>
                                                        <label class="form-control input-sm" id="lblConfirmNo"></label>

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
                                        P.O. Box 53250<br>
                                        Philadelphia, PA 19105-0389
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

                                                            <textarea class="form-control input-sm" id=txaComments  name=txaComments></textarea>
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

                                       <input type="button" class="btn btn-default submit_button" value="Thank You" id="btnTobaccoThankYou" name="btnTobaccoThankYou" onclick="DoThankYou()"/>
                                        <div class="clearfix"></div>
                                    </div>
                                </div>

                            </form>

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
