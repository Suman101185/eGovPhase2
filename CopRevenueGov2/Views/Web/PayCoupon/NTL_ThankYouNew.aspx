<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
    
    <title></title>
<script id="clientEventHandlersJS" language="javascript">
    function DoThankYou() {
        var sEmailMsg;
        oEmail = parent.$g.getXmlDocObj();
        if ($('#txaComments').val() != '') {
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

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, sEmailMsg, 'DATA', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS EMAIL', '', 0), 'ADDRESS', '', 0);
            ispCallXMLForm(parent.$g.xmlEmail, parent.$g.xmlEmail, 'MailPIN', '');
        }		//if
      
        parent.setFrameUrl('Login/MainAsp');
    }
    //DoThankYou
    </script>
</head>
<body>
     
    <div id="divNtlThankYou" style="display: none;" class="container-fluid no-padding">
    <div class="block3">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12">
                       <div class="blue_base_box">
               <h2>Taxpayer Information  |   <span>thank you </span>  </h2>
                <div class="inner_white-panel">
                 <div class="contentsection">
                   <div class="row">
                   <div class="col-lg-12">
                    <div class="row">
                    <div class="well">
                        <div class="row">                          
                            <div class="col-lg-12 templateclass">
                                <h4 id="hdrThankYou">Your No Tax Liability Payment Coupon has been posted. <br>
					You may want to print a copy of this page for your records.<br>
					Thank you for posting your
                <label class='lblTextBlack' id='lblPeriod'></label>&nbsp;No Tax Liability coupon online.</h4>


                            </div>
                        </div>
                    </div>
                    </div>

                    <div class="row">


                        <div class="table-responsive">

                            <table class="table table-condensed table-striped custom_table03">


                                <tbody>

                                    <tr>
                                        <td width="10%" class="text-left">Name</td>
                                        <td class="text-left">
                                            <form class="form-horizontal">

                                                <div class="form-group no-margin">
                                                    <div>
                                                        <label  id='lblName'></label>

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
                                                        <label class='' id='lblAcctNo'></label>

                                                    </div>
                                                </div>

                                            </form>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="20%" class="text-left">Your Confirmation No. is</td>
                                        <td class="text-left">
                                            <form class="form-horizontal">

                                                <div class="form-group no-margin">
                                                    <div>
                                                        <label class="" id="lblConfirmNo"></label>

                                                    </div>
                                                </div>

                                            </form>
                                        </td>
                                    </tr>

                                </tbody>



                            </table>

                        </div>
                       

                        <div class="well">
                            <div class="row">

                                <div class="col-lg-12 templateclass">                                  

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

                                                            <textarea class="form-control input-sm" id="txaComments" name="txaComments"></textarea>
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

                                        <input type="button" class="btn btn-default submit_button" value="Thank You" id="btnNtlThankYou" name="btnNtlThankYou" onclick="DoThankYou()" />
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
