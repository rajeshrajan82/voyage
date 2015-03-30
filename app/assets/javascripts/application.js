// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function() {
    $('#signin').click(function(){
        var un = $("#user_email").val();
        var pw = $("#user_password").val();
        var unReg = /^[A-Za-z0-9_@.]{3,50}$/;
        var pwReg = /^[A-Za-z0-9!@#$%&*()_]{6,20}$/;
        var hasError = false;
        var errmsg = '';

        if (!un) { 
            errmsg = '<p>Please enter a email id</p>';
            hasError = true;
        } else if(!unReg.test(un)) {
            errmsg = '<p>Username must be 3 - 20 characters (a-z, 0-9, _).</p>';
            hasError = true;
        }

        if (!pw) { 
            errmsg += '<p>Please enter a password</p>';
            hasError = true;
        } else if(!pwReg.test(pw)) {
            errmsg += '<p>Password must be 6 - 20 characters (a-z, 0-9, !, @, #, $, %, &, *, (, ), _).</p>';
            hasError = true;
        }

        if (!hasError) {
            $('#msg').html('<p><img src="loading.gif" alt="loading" /> signing in...</p>');
        } else {
            $("#messageDiv div").addClass("hide");
            $("div#msg").addClass("alert");
            $('#msg').html(errmsg);
            return false;
        }
    });
    
    $('#signup').click(function(){
        var un = $("#user_email").val();
        var pw = $("#user_password").val();
        var cpw = $("#user_password_confirmation").val();
        var nm = $("#user_travels_name").val();
        var unReg = /^[A-Za-z0-9_@.]{3,50}$/;
        var pwReg = /^[A-Za-z0-9!@#$%&*()_]{6,20}$/;
        var hasError = false;
        var errmsg = '';
        
        if (!nm) {
            errmsg = '<p>Please enter a Name</p>';
            hasError = true;
        }
        
        if (!un) { 
            errmsg += '<p>Please enter a email id</p>';
            hasError = true;
        } else if(!unReg.test(un)) {
            errmsg = '<p>Email id must be 3 - 20 characters (a-z, 0-9, _).</p>';
            hasError = true;
        }

        if (!pw) { 
            errmsg += '<p>Please enter a password</p>';
            hasError = true;
        } else if(!pwReg.test(pw)) {
            errmsg += '<p>Password must be 6 - 20 characters (a-z, 0-9, !, @, #, $, %, &, *, (, ), _).</p>';
            hasError = true;
        }
        
        if (pw != cpw) {
            errmsg += '<p>Password does not match the confirm password</p>';
            hasError = true;
        }
        
        if (!hasError) {
            $('#msg').html('<p><img src="loading.gif" alt="loading" /> Create/Update in...</p>');
        } else {
            $("#messageDiv div").addClass("hide");
            $("div#msg").addClass("alert");
            $('#msg').html(errmsg);
            return false;
        }
    });
    
    $('#update').click(function(){
        var un = $("#user_email").val();
        var pw = $("#user_password").val();
        var cpw = $("#user_password_confirmation").val();
        var nm = $("#user_travels_name").val();
        var unReg = /^[A-Za-z0-9_@.]{3,50}$/;
        var pwReg = /^[A-Za-z0-9!@#$%&*()_]{6,20}$/;
        var hasError = false;
        var errmsg = '';
        
        if (!nm) {
            errmsg = '<p>Please enter a Name</p>';
            hasError = true;
        }
        
        if (!un) { 
            errmsg += '<p>Please enter a email id</p>';
            hasError = true;
        } else if(!unReg.test(un)) {
            errmsg = '<p>Email id must be 3 - 20 characters (a-z, 0-9, _).</p>';
            hasError = true;
        }

        if (!pw) { 
            hasError = false;
        } else if(!pwReg.test(pw)) {
            errmsg += '<p>Password must be 6 - 20 characters (a-z, 0-9, !, @, #, $, %, &, *, (, ), _).</p>';
            hasError = true;
        }
        
        if (pw != cpw) {
            errmsg += '<p>Password does not match the confirm password</p>';
            hasError = true;
        }
        
        if (!hasError) {
            $('#msg').html('<p><img src="loading.gif" alt="loading" /> Create/Update in...</p>');
        } else {
            $("#messageDiv div").addClass("hide");
            $("div#msg").addClass("alert");
            $('#msg').html(errmsg);
            return false;
        }
    });
    
    $('#vehicle').click(function(){
        var vno = $("#vehicle_v_no").val();
    
        var hasError = false;
        var errmsg = '';

        if (!vno) { 
            errmsg = '<p>Please enter vehicle number</p>';
            hasError = true;
        } 

        if (!hasError) {
            $('#msg').html('<p><img src="loading.gif" alt="loading" /> Create/Update in...</p>');
        } else {
            $("#messageDiv div").addClass("hide");
            $("div#msg").addClass("alert");
            $('#msg').html(errmsg);
            return false;
        }
    });
    
    $('#route').click(function(){
        var org = $("#route_origin").val();
        var dest = $("#route_destination").val();
        
        var hasError = false;
        var errmsg = '';

        if (!org) { 
            errmsg = '<p>Please enter From Station</p>';
            hasError = true;
        } 
        
        if (!dest) { 
            errmsg += '<p>Please enter To Station</p>';
            hasError = true;
        } 

        if (!hasError) {
            $('#msg').html('<p><img src="loading.gif" alt="loading" /> Create/Update in...</p>');
        } else {
            $("#messageDiv div").addClass("hide");
            $("div#msg").addClass("alert");
            $('#msg').html(errmsg);
            return false;
        }
    });
    
     $('#track1').click(function(){
        var trk = $("#tracking_code").val();
        
        var hasError = false;
        var errmsg = '';

        if (!trk) { 
            errmsg = '<p>Please enter tracking code</p>';
            hasError = true;
        } 
        
        if (!hasError) {
            $('#msg').html('<p><img src="loading.gif" alt="loading" /> Create/Update in...</p>');
        } else {
            $("#messageDiv div").addClass("hide");
            $("div#msg").addClass("alert");
            $('#msg').html(errmsg);
            return false;
        }
    });
    
    $(".confirm").confirm({
        text: "Are you sure you want to stop tracking this trip?",
        title: "Confirmation required",
        confirm: function(button) {
            document.location.href= $("#stoptrack").attr('url');
        },
        cancel: function(button) {
            // do something
        },
        confirmButton: "Yes I am",
        cancelButton: "No",
        post: true
    });
});