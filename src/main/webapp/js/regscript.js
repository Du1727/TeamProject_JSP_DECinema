function idCheck(inputVal) {
	
	var pattern1 = /[0-9]/;
	var pattern2 = /[a-zA-Z]/;
	
	if (!pattern1.test(inputVal) || !pattern2.test(inputVal)) {
		inputVal = inputVal.toLowerCase();
		document.regFrm.id.value = inputVal.replace(/[^a-z0-9]/gi,'');		
	}
	
	if(inputVal.length > 4) {
		document.getElementById("idText").style.color = "#323232";
		document.getElementById("idText").textContent = "✔️ 5~20자 영문 소문자, 숫자";
	} else {
		document.getElementById("idText").style.color = "#F03A17";
		document.getElementById("idText").textContent = "❌ 5~20자 영문 소문자, 숫자";	
	}	
}

function duplicateCheck(idListString, inputVal) {
	
	var flag = true;
	let idList = idListString.split("/");
	for(var i = 0; i < idList.length; i++) {
		if (inputVal==idList[i]) {
			flag = false;
		}
	}
	
	if(flag) {
		if (inputVal.length > 4) {
			document.getElementById("idText").style.color = "#14C60C";
			document.getElementById("idText").textContent = "✔️ 사용 가능한 아이디입니다.";			
		}		
	} else if (inputVal.length > 0) {	
		document.getElementById("idText").style.color = "#F03A17";
		document.getElementById("idText").textContent = "❌ 중복된 아이디입니다.";
	}
}

function pwCheck(inputVal) {
	
	var pattern = /^[A-Za-z0-9!@#$%^&*()_+-=]{8,16}$/;
	
	if (pattern.test(inputVal)) {
		document.getElementById("pwText").style.color = "#323232";
		document.getElementById("pwText").textContent = "✔️ 8~16자 영문 대 소문자, 숫자, 특수문자";	
		
	} else {
		document.getElementById("pwText").style.color = "#F03A17";
		document.getElementById("pwText").textContent = "❌ 8~16자 영문 대 소문자, 숫자, 특수문자";	
	}		
	pwdCheck();
}


function pwdCheck() {
	
	let pw = document.regFrm.pw.value;
	if (pw.length > 0 && pw === document.regFrm.pwd.value) {
		document.getElementById("pwdText").style.color = "#323232";
		document.getElementById("pwdText").textContent = "✔️ 비밀번호와 일치";
	} else {
		document.getElementById("pwdText").style.color = "#F03A17";
		document.getElementById("pwdText").textContent = "❌ 비밀번호 불일치";	
	}		
}

function nameCheck() {
	
	var pattern = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g;
	document.regFrm.name.value = document.regFrm.name.value.match(pattern)?.join('') || '';

}

function phoneCheck(){
	num = document.regFrm.phone.value.replaceAll("-", "");
    if(num.length==11){
    	num = num.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
    } else if(num.length==8){
        num = num.replace(/(\d{4})(\d{4})/, '$1-$2');
    } else {
        if(num.indexOf('02')==0){
        	num = num.replace(/(\d{2})(\d{4})(\d{4})/, '$1-$2-$3');
        } else {
            num = num.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
        }
    }
    document.regFrm.phone.value = num;
}

function inputCheck(){
	
	if(document.regFrm.id.value=="" || document.regFrm.id.value.length < 5){
		document.regFrm.id.focus();
		return;
	}
	if(document.regFrm.pw.value=="" || document.regFrm.pw.value.length < 8){
		document.regFrm.pw.focus();
		return;
	}
	if(document.regFrm.pwd.value==""){
		document.regFrm.pwd.focus();
		return;
	}
	if(document.regFrm.pw.value != document.regFrm.pwd.value){
		document.regFrm.pwd.value="";
		document.regFrm.pwd.focus();
		return;
	}
	if(document.regFrm.name.value==""){
		document.regFrm.name.focus();
		return;
	}
	if(document.regFrm.birthday.value==""){
		document.regFrm.birthday.focus();
		return;
	}
	if(document.regFrm.phone.value==""){
		document.regFrm.phone.focus();
		return;
	}
	if(document.regFrm.mail.value==""){
		document.regFrm.mail.focus();
		return;
	}
    var str=document.regFrm.mail.value;	   
    var atPos = str.indexOf('@');
    var atLastPos = str.lastIndexOf('@');
    var dotPos = str.indexOf('.'); 
    var spacePos = str.indexOf(' ');
    var commaPos = str.indexOf(',');
    var mailSize = str.length;
    if (atPos > 1 && atPos == atLastPos && 
	   dotPos > 3 && spacePos == -1 && commaPos == -1 
	   && atPos + 1 < dotPos && dotPos + 1 < mailSize);
    else {
	      document.regFrm.mail.focus();
		  return;
    }
    
	document.regFrm.submit();
}