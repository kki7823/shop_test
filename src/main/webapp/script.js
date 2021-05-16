function idCheck(id) {
    if (id == "") {
        alert("아이디를 입력해주세요");
        document.regForm.id.focus();
    } else {
        url = "idCheck.jsp?id=" + id;
        window.open(url, "post", "width=300,height=150");
    }
}

function win_close() {
    self.close();
}

function inputCheck() {
    if (document.regForm.repwd.value == "") {
        alert("비밀번호확인 부분이 입력되지 않았습니다~");
        document.regForm.repwd.focus();
        return;
    }

    if (document.regForm.pwd.value != document.regForm.repwd.value) {
        alert("비밀번호가 일치하지 않습니다.");
        document.regForm.repwd.focus();
        return;
    }
    document.regForm.submit();
}

function zipCheck() {
    url = "zipSearch.jsp?search=n";
    window.open(url, "post", "width=500,height=300");
}
//Product
function productDetail(no) {
    document.detail.no.value=no;
    document.detail.submit();
}   //get방식으로 전송

//Cart
function cartUpdate(form){
    form.flag.value="update"
    form.submit();
}

function cartDelete(form) {
    form.flag.value="del";
    form.submit();
}








