function loginCheck(id, pw) {		
	if (id == "") {
		document.loginFrm.loginid.focus();
		return;
	}
	if (pw == "") {
		document.loginFrm.pw.focus();
		return;
	}
    
	document.loginFrm.submit();		
}