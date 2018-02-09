<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>

<html>
<head>
    <meta name="viewport" content="width=device-width" />
    <title>FileUpload</title>
    <script id="clientEventHandlersJS" language="javascript" type="text/javascript">

        $(document).ready(function () {
            $('#fileToUpload').val('');
            //==================For Validation Start============================
            //Get file size
            function GetFileSize(fileid) {

                try {
                    var fileSize = 0;
                    //for IE
                    if ($.browser) {
                        debugger;
                        //====before making an object of ActiveXObject,======== 
                        //===please make sure ActiveX is enabled in your IE browser======
                        var objFSO = new ActiveXObject("Scripting.FileSystemObject");
                        var filePath = $("#" + fileid)[0].value;
                        var objFile = objFSO.getFile(filePath);
                        var fileSize = objFile.size; //size in kb
                        fileSize = fileSize / 1048576; //size in mb 
                    }
                        //====for FF, Safari, Opeara and Others=========
                    else {
                        debugger;
                        fileSize = $("#" + fileid)[0].files[0].size //size in kb
                        fileSize = fileSize / 1048576; //size in mb 
                    }
                    return fileSize;
                }
                catch (ex) {
                    alert("Error is :" + ex);
                }
            }

            //========get file path from client system===================
            function getNameFromPath(strFilepath) {

                var objRE = new RegExp(/([^\/\\]+)$/);
                var strName = objRE.exec(strFilepath);

                if (strName == null) {
                    return null;
                }
                else {
                    return strName[0];
                }
            }

            $(function () {
                $("#btnSubmit").click(function () {
                    
                    if ($('#fileToUpload').val() == "") {
                        $("#spanfile").html("Please upload file");
                        return false;
                    }
                    else {
                        debugger;
                        checkfile();
                        if (flag == true && $("#spanfile").text() == '') {
                           
                            //=========Parameter Declaration=====================                          
                            var fileUpload = $("#fileToUpload").get(0);
                            var files = fileUpload.files;
                           
                            //======Create FormData object======================  
                            var fileData = new FormData();

                            //=========Looping over all files and add it to FormData object================  
                            for (var i = 0; i < files.length; i++) {                                
                                fileData.append(files[i].name, files[i]);
                               // alert(files[i].name);
                            }
                          
                            var url = '../Login/Upload';
                            var proceed = true;
                            var progress_bar_id = '#progress-wrp';
                           
                            $.ajax({
                                url: url,
                                type: 'post',
                                timeout:2400000,
                                contentType: false,
                                processData: false,
                                data: fileData,
                                xhr: function () {
                                    //upload Progress
                                    var xhr = $.ajaxSettings.xhr();
                                    if (xhr.upload) {
                                        xhr.upload.addEventListener('progress', function (event) {
                                            var percent = 0;
                                            debugger;
                                            var position = event.loaded || event.position;
                                            var total = event.total;
                                            if (event.lengthComputable) {
                                                percent = Math.ceil(position / total * 100);                                                
                                            }
                                            if (percent == 100) {                                            
                                                 
                                                $("#progress-wrp").hide();
                                                $("#progressw2").show();
                                                $("#fileprocessedMsg").show();
                                                
                                            }
                                            //update progressbar
                                            $(progress_bar_id + " .progress-bar").css("width", +percent + "%");
                                            $(progress_bar_id + " .status").text(percent + "%");
                                        }, true);
                                    }
                                    return xhr;
                                },

                                success: function (result) {
                                    $("#fileprocessedMsg").hide();
                                    $("#progressw2").hide();
                                    $("#progress-wrp").hide();
                                    alert(result);
                                    //move();
                                    $('#fileToUpload').val('');
                                    $(progress_bar_id + " .progress-bar").css("width", "0%");
                                    $(progress_bar_id + " .status").text("0%");
                                    $("#progress-wrp").show();
                                },                             
                                
                                error: function (err) {
                                    $("#progress-wrp").show();
                                    $("#progressw2").hide();
                                    $("#fileprocessedMsg").hide();
                                    console.log(err);
                                    alert(err.statusText);
                                }
                            });
                            event.preventDefault ? event.preventDefault() : (event.returnValue = false);
                        }
                    }
                });
            });
            function checkfile() {
                           
                    var file = getNameFromPath($("#fileToUpload").val());
                if (file != null) {
                    var extension = file.substr((file.lastIndexOf('.') + 1));
                    switch (extension) {
                        case 'txt':
                        case 'doc':
                        case 'docx':
                        case 'xlsx':
                        case 'pdf':
                        case 'TXT':
                        case 'DOC':
                        case 'DOCX':
                        case 'XLSX':
                        case 'PDF':
                            flag = true;
                            break;
                        default:
                            flag = false;
                    }
                }
                if (flag == false) {
                    $("#spanfile").text("You can upload only txt,docx,xlsx,pdf extension file");
                    return false;
                }
                else {                   
                    if ($("#fileToUpload").val()!= '') {
                        var size = GetFileSize('fileToUpload');
                        if (size > 10000) {
                            $("#spanfile").text("You can upload file up to 1 GB");
                            return false;
                        }
                        else {
                            $("#spanfile").text("");
                        }
                    }
                }
            }

            $(function () {
                $("#fileToUpload").change(function () {
                    checkfile();
                });
            });

            //================For Validation End=====================
        });

        
    </script>
    <style type="text/css">
        .form-wrap{
    max-width: 500px;
    padding: 30px;
    background: #f1f1f1;
    margin: 20px auto;
    border-radius: 4px;
	text-align: center;
}
.form-wrap form{
	border-bottom: 1px dotted #ddd;
	padding: 10px;
}
.form-wrap #output{
    margin: 10px 0;
}
.form-wrap .error{
    color: #d60000;
}
.form-wrap .images {
    width: 100%;
    display: block;
    border: 1px solid #e8e8e8;
    padding: 5px;
    margin: 5px 0;
}
.form-wrap .thumbnails {
    width: 32%;
    display: inline-block;
    margin: 3px;
}

/* progress bar */
#progress-wrp {
    border: 1px solid #0099CC;
    padding: 1px;
    position: relative;
    border-radius: 3px;
    margin: 10px;
    text-align: left;
    background: #fff;
    box-shadow: inset 1px 3px 6px rgba(0, 0, 0, 0.12);
    height:25px;
}
#progress-wrp .progress-bar{   
	height: 20px;
    border-radius: 3px;
    background-color: #f39ac7;
    width: 0;
    box-shadow: inset 1px 1px 10px rgba(0, 0, 0, 0.11);
}
#progress-wrp .status{
	top:3px;
	left:50%;
	position:absolute;
	display:inline-block;
	color: #000000;
}

#progressw2-wrp {
    border: 1px solid #0099CC;
    padding: 1px;
    position: relative;
    border-radius: 3px;
    margin: 10px;
    text-align: left;
    background-color: #f39ac7;
    box-shadow: inset 1px 3px 6px rgba(0, 0, 0, 0.12);
    height:25px;
}
#progressw2-wrp .progressw2-bar{   
	height: 20px;
    border-radius: 3px;
    background-color: #f39ac7;
    width: 0;
    box-shadow: inset 1px 1px 10px rgba(0, 0, 0, 0.11);
}


    </style>
   
</head>
<body>
    <div class="form-group">
        <div class="row table-responsive">
            <div class="col-lg-12">

                <table summary="Employee Pay Sheet" class="table table-condensed table-striped custom_table03">

                    <tbody>

                        <tr>
                            <td width="5%"></td>
                            <td width="70%" style="text-align:center;"><p style=" font: bold 17px/25px Verdana;">Electronically file your W-2 forms</p></td>
                            <td colspan="2" width="25%"></td>
                        </tr>
                       
                        <tr>
                            <td width="5%"></td>
                            <td width="70%" class="text-left">
                                <input type="file" id="fileToUpload" name="file" style="margin: 20px auto;" />
                                <span class="field-validation-error" id="spanfile"></span>
                                <label id="lblUO1_14"></label>
                            </td>
                            <td colspan="2" align="center" width="25%">
                                <div class="form-horizontal">
                                    <div class="form-group no-margin">
                                        <div class="">

                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td width="5%"></td>
                            <td width="70%" class="text-left"></td>
                            <td colspan="2" align="center" width="25%">
                                <div class="form-horizontal">
                                    <div class="form-group no-margin">
                                        <div class="">

                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td width="5%"></td>
                            <td align="center" width="75%">
                                <div class="form-horizontal">
                                    <div class="form-group no-margin">
                                        <div class="">
                                            <input class="submit_button" id="btnSubmit" name="btnSubmit" type="submit" value="Upload" style="margin:0 auto;">
                                        </div>
                                    </div>
                                </div>
                            </td>
                            <td colspan="2" width="20%" class="text-left"> <input type="text" class="form-control input-sm " id="txt_BPT_WSEZ1" maxlength="10" style="WIDTH: 20%; display:none"></td>
                            
                        </tr>
                        <tr>
                           <td>
                              
                           </td>
                        </tr>

                    </tbody>
                </table>
                
                 <div class="progress-wrp" id="progress-wrp"><div class="progress-bar"></div ><div class="status">0%</div></div>
                <div id="fileprocessedMsg" style="display:none">The file has been processed successfully.Please wait while server processing the file</div><br />
                <span id="progressw2" style="display:none;margin-left:76px">
               <img id="id1" alt="" src="../../Content/images/gif-load.gif">
                </span>
               
                <div class="clear"></div>
            </div>
        </div>
    </div>
</body>
</html>
