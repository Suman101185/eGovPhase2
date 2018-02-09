<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>


<script src="../Content/Scripts/JqueryMin.js" type="text/javascript"></script>
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
<script id="clientEventHandlersJS" language="javascript" type="text/javascript">

    var arrLoginErr = new Array()

    function DisplayThankYou(sLayer) {

        //ForgotPinThankYou.style.display = 'none'
        //LogPinApply.style.display = 'none'
        $('#ForgotPinThankYou').css('display', 'none');
        $('#ForgotPinThankYou').css('display', 'none');
        if (sLayer == 'APPLYPIN') {
            
            $('#divThankYou').css('display', 'block');
            $('#ApplyPinThankYou').css('display', 'block');
        } else {
            ///ForgotPinThankYou.style.display = 'block'
            $('#ForgotPinThankYou').css('display', 'block');
        }		//if
        this.focus()
        $('#AppHeaderThankyou').html(txtHeader + '<Span class=hdrMedium>|thank you</Spant>');
        $('#AppHeaderThankyouForgotPin').html(txtHeader + '<Span class=hdrMedium>|thank you</Span>');
    }		//DisplayApplyPin


    function DoThankYou() {
        $('#ApplyPinThankYou').css('display', 'none')
        //ForgotPinThankYou.style.display = 'none';
        $('#ForgotPinThankYou').css('display', 'none')
        //alert($(parent.MenuWin.document).find('#mnuLogLogout'));
        //parent.MenuWin.mnuLogLogout.click();
        $(parent.document).find('#mnuLogLogout').first().trigger('click');
    }		//if

</script>


<div class="container-fluid no-padding">
    <div id="divThankYou" class="block3" style="display: none;">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3" name="ApplyPinThankYou" style="display: none;" id="ApplyPinThankYou">
                    <div class="blue_base_box">
                        <h2 id="AppHeaderThankyou"></h2>

                        <div class="inner_white-panel">

                            <div class="contentsection">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <h4 id="hdrThankYou" name="hdrThankYou">The PIN is now being generated. Shortly, you will receive via
				e-mail the Philadelphia Revenue Personal Identification Number (PIN) for this tax entity.</h4>
                                        <h4>You must get the PIN from this e-mail before using "Online Services"</h4>
                                    </div>
                                </div>
                                <div class="clearfix"></div>

                                <div class="row">

                                    <div class="col-lg-12">

                                        <form class="form-horizontal login_form">

                                            <div class="form-group">
                                                <div class="col-sm-offset-4 col-sm-6">
                                                    <input class="submit_button" id="SubbtnExistThankYoumit1" name="btnThankYou"
                                                        type="button" value="Thank You" onclick="DoThankYou()" />
                                                </div>
                                            </div>


                                        </form>

                                    </div>

                                    <%-- <div class="clearfix"></div>--%>
                                </div>

                            </div>

                        </div>

                    </div>

                </div>

                <div class="col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3" name="ForgotPinThankYou" style="display: none;" id="ForgotPinThankYou">
                    <div class="blue_base_box">
                        <h2 id="AppHeaderThankyouForgotPin"></h2>

                        <div class="inner_white-panel">

                            <div class="contentsection">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <h4 id="hdrThankYou" name="hdrThankYou">Your PIN is now being retrieved. Shortly, you will receive via
				e-mail the Philadelphia Revenue Personal Identification Number (PIN) for this tax entity.</h4>
                                    </div>
                                </div>
                                <div class="clearfix"></div>

                                <div class="row">

                                    <div class="col-lg-12">

                                        <form class="form-horizontal login_form">

                                            <div class="form-group">
                                                <div class="col-sm-offset-4 col-sm-6">
                                                    <input class="submit_button" id="btnExistThankYou" name="btnExistThankYou"
                                                        type="button" value="Thank You" onclick="DoThankYou()">
                                                </div>
                                            </div>


                                        </form>

                                    </div>

                                    <%-- <div class="clearfix"></div>--%>
                                </div>

                            </div>

                        </div>

                    </div>

                </div>
            </div>

        </div>
    </div>
</div>

