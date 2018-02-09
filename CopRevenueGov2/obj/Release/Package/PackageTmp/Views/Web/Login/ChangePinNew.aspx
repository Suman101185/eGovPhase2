<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>


<script type="text/javascript" language="javascript">
    var arrChangePinErr = new Array()

    function DisplayChangePin() {

        $('#divChangePin').css("display", "block");
        $('#LogChangePin').css("display", "block");
        $('#AppHeaderChangePwd').html(txtHeader + '<Span class=hdrMedium> | Change PIN</Span>');
        $('#txtPcOldPin').val('');
        $('#txtPcNewPin1').val('');
        $('#txtPcNewPin2').val('');
        LoadChangePinError();
        $('#txtPcOldPin').focus();
    }
    $(function () {
        $('#txtPcOldPin').keypress(function (evt) {
            if (evt.charCode > 31 && (evt.charCode < 48 || evt.charCode > 57)) {
                return false;
            }
        });
    });
    $(function () {
        $('#txtPcNewPin1').keypress(function (evt) {
            if (evt.charCode > 31 && (evt.charCode < 48 || evt.charCode > 57)) {
                return false;
            }
        });
    });
    $(function () {
        $('#txtPcNewPin2').keypress(function (evt) {
            if (evt.charCode > 31 && (evt.charCode < 48 || evt.charCode > 57)) {
                return false;
            }
        });
    });
    function LoadChangePinError() {
        var i = 0;
        var txtPcOldPin = document.getElementById('txtPcOldPin')
        var txtPcNewPin1 = document.getElementById('txtPcNewPin1')
        var txtPcNewPin2 = document.getElementById('txtPcNewPin2')

        arrChangePinErr[i++] = [txtPcOldPin, '$(\'#txtPcOldPin\').val() == ""', 'Enter old PIN'];
        arrChangePinErr[i++] = [txtPcOldPin, 'regInteger.exec($(\'#txtPcOldPin\').val()) != $(\'#txtPcOldPin\').val()', 'Old PIN must be an integer'];
        arrChangePinErr[i++] = [txtPcOldPin, 'regInteger.exec($(\'#txtPcOldPin\').val()) == 0', 'Old PIN must not be zero'];
        arrChangePinErr[i++] = [txtPcOldPin, '$(\'#txtPcOldPin\').val() != parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, "ENTITY_INFO PIN", "", 0)', 'Old PIN does not match current PIN'];

        arrChangePinErr[i++] = [txtPcNewPin1, '$(\'#txtPcNewPin1\').val() == ""', 'Enter new PIN'];
        arrChangePinErr[i++] = [txtPcNewPin1, 'regInteger.exec($(\'#txtPcNewPin1\').val()) != $(\'#txtPcNewPin1\').val()', 'New PIN must be an integer'];
        arrChangePinErr[i++] = [txtPcNewPin1, 'regInteger.exec($(\'#txtPcNewPin1\').val()) == 0', 'New PIN must not be zero'];

        arrChangePinErr[i++] = [txtPcNewPin2, '$(\'#txtPcNewPin2\').val() == ""', 'Enter confirm PIN'];
        arrChangePinErr[i++] = [txtPcNewPin2, 'regInteger.exec($(\'#txtPcNewPin2\').val()) != $(\'#txtPcNewPin2\').val()', 'Confirm PIN must be an integer'];
        arrChangePinErr[i++] = [txtPcNewPin2, 'regInteger.exec($(\'#txtPcNewPin2\').val()) == 0', 'Confirm PIN must not be zero'];
        arrChangePinErr[i++] = [txtPcNewPin2, '$(\'#txtPcNewPin1\').val() != $(\'#txtPcNewPin2\').val()', 'Confirm PIN does not match new PIN'];

    }


    function ValidateChangePin() {
        var changepin = ispSetInputErr_pwd(arrChangePinErr);
        $(AppError_Pc).text(changepin);
        resolvedIframeheight();
    }


    var oAcctInfo = parent.$g.getXmlDocObj();
    $(function (e) {
        $('#txtPcOldPin').keyup(function (e) {
            if ((e.which == 13) || (e.keyCode == 13)) {
                DoChangePin();
                $("#btnApply").click();
            }

        });
        $("#txtPcNewPin1").keyup(function (e) {
            if ((e.which == 13) || (e.keyCode == 13)) {
                DoChangePin();
                $("#btnApply").click();
            }

        });
        $("#txtPcNewPin2").keyup(function (e) {
            if ((e.which == 13) || (e.keyCode == 13)) {
                DoChangePin();
                $("#btnApply").click();
            }

        });
        $("#btnApply").keyup(function (e) {
            if ((e.which == 13) || (e.keyCode == 13)) {
                DoChangePin();
                $("#btnApply").click();
            }

        });

    });
    function DoChangePin() {

        ValidateChangePin();
        var txtPcNewPin1=document.getElementById('txtPcNewPin1');
        if ($(AppError_Pc).text() == '') {
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, '3', "ENTITY_INFO FUNCTION_CODE", '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtPcNewPin1.value, "ENTITY_INFO PIN", '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, 'Y', "ENTITY_INFO FORCEPINCHG", '', 0);

            ispCallXMLForm(parent.$g.xmlAccount, oAcctInfo, "AccountInfo");

            parent.$g.xmlAccount.loadXML(oAcctInfo.xml);

            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ERROR_INFO MESSAGE', "", 0) == "") {

                parent.setFrameUrl('Acct/ApplyMain');
                // parent.DocWin.location.href = '../Acct/ApplyMain';
            } else {
                var errmsg = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ERROR_INFO MESSAGE', "", 0);
                $(AppError_Pc).text(errmsg);
                resolvedIframeheight();
                $('#txtPcOldPin').focus();

            }
        } else {
            var apperr = $(AppError_Pc).text();
            if ((apperr.indexOf("New") != -1) && (apperr.indexOf("Confirm") != -1)) {
                $('#txtPcNewPin1').focus();
            } else {
                if (apperr.indexOf("Confirm") != -1) {
                    $('#txtPcNewPin2').focus();

                } else {
                    $('#txtPcOldPin').focus();
                }
            }
        }
    }
</script>

<div class="container-fluid no-padding">
    <div id="divChangePin" class="block3" style="display: none;">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3" name="LogChangePin" style="display: none;" id="LogChangePin">
                    <div class="blue_base_box">
                        <h2 id="AppHeaderChangePwd"></h2>

                        <div class="inner_white-panel">
                             <div class="row">
                                   <div class="col-lg-12 col-lg-offset-0">
                                 <div id="AppError_Pc" class="errormsg no-padding" style="display:block;"></div>
                                       </div></div>
                            <div class="contentsection">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <h4>Your PIN was generated by the Philadelphia Department of Revenue. For security purposes
                                                we are requiring you to change your PIN.<br>
                                            <span class="lblTextRed">* </span>Required Field</h4>
                                    </div>
                                </div>
                                <div class="clearfix"></div>

                                <div class="row">

                                    <div class="col-lg-12">

                                        <form class="form-horizontal login_form">
                                            <div class="form-group text-left-custom">
                                                <label for="inputEmail3" class="col-sm-3 control-label text-left-custom">Old PIN<span class="lblTextRed">* </span>: </label>
                                                <div class="col-sm-9">
                                                    <input type="PASSWORD" id="txtPcOldPin" name="txtPcOldPin" maxlength="13"
                                                        onchange="ValidateChangePin()" />
                                                </div>
                                            </div>
                                            <div class="form-group text-left-custom">
                                                <label for="inputPassword3" class="col-sm-3 control-label text-left-custom">New PIN<span class="lblTextRed">* </span>: </label>
                                                <div class="col-sm-9">
                                                    <input type="PASSWORD" id="txtPcNewPin1" name="txtPcNewPin1" maxlength="13"
                                                        onchange="ValidateChangePin()">
                                                </div>
                                            </div>
                                            <div class="form-group text-left-custom">
                                                <label for="inputPassword3" class="col-sm-3 control-label text-left-custom">Confirm PIN<span class="lblTextRed">* </span>: </label>
                                                <div class="col-sm-9">
                                                    <input type="PASSWORD" id="txtPcNewPin2" name="txtPcNewPin2" maxlength="13"
                                                        onchange="ValidateChangePin()">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-sm-offset-4 col-sm-6">
                                                    <input id="btnApply" name="btnApply" type="button" onclick="DoChangePin()" class="btn btn-default submit_button"
                                                        size="48" value="Submit">
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

