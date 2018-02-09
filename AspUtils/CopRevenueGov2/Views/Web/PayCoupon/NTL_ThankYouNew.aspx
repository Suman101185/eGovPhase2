<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
    
    <title></title>
</head>
<body>
     
    <div id="divNtlThankYou" style="display: none;" class="container-fluid no-padding">
    <div class="block3">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12">
                    <div class="well">
                        <div class="row">
                            <h2><span id="AppHeaderThankyou">&nbsp;</span>  </h2>
                            <div class="col-lg-12 templateclass">
                                <h4 id="hdrThankYou">Your No Tax Liability Payment Coupon has been posted. <br>
					You may want to print a copy of this page for your records.<br>
					Thank you for posting your
                <label class='lblTextBlack' id='lblPeriod'></label>&nbsp;No Tax Liability coupon online.


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

                                       <input type="button" class="btn btn-default submit_button" value="Thank You" id="btnNtlThankYou"  name="btnNtlThankYou" onclick="DoThankYou()"/>
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
