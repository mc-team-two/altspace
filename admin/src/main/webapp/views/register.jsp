<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>

  const register = {

    init:function(){
      $('#register_btn').click(()=>{
        this.check();
      });
    },

    check:function(){
      let email = $('#email').val();
      let pwd = $('#pwd').val();
      let pwd2 = $('#pwd2').val();
      let name = $('#name').val();
      let phone = $('#phone').val();

      if(email == '' || email == null){
        $('#msg').text('이메일 주소를 입력하세요.');
        $('#email').focus();
        return;
      }

      if(pwd == '' || pwd == null){
        $('#msg').text('비밀번호를 입력하세요.');
        $('#pwd').focus();
        return;
      }

      if(pwd2 == '' || pwd2 == null){
        $('#msg').text('비밀번호 확인을 입력하세요.');
        $('#pwd2').focus();
        return;
      }

      if(pwd != pwd2){
        $('#msg').text('Password가 서로 다릅니다. 다시 입력하세요');
        $('#pwd2').focus();
        return;
      }

      if(name == '' || name == null){
        $('#msg').text('이름을 입력하세요.');
        $('#name').focus();
        return;
      }

      if(phone == '' || phone == null){
        $('#msg').text('휴대폰 번호를 입력하세요.');
        $('#phone').focus();
        return;
      }

      let c = confirm('회원가입 하시겠습니까?');
      if(c == true){
        this.send();
      }
    },

    send:function(){
      $('#register_form').attr('method','post');
      $('#register_form').attr('action','<c:url value="/goregister"/>');
      $('#register_form').submit();
    }
  }
  $(function(){
    register.init();
  });

</script>

<div class="col-sm-10">
  <h2>회원가입</h2>
  <div class="row">
    <div class="col-sm-8">
      <form id="register_form">

        <div class="form-group">
          <label for="name">이메일 주소</label>
          <input type="text" name="email" class="form-control" placeholder="예) abcd@naver.com" id="email">
        </div>

        <div class="form-group">
          <label for="pwd">비밀번호</label>
          <input type="password" name="pwd" class="form-control" placeholder="Enter password" id="pwd">
        </div>
        <div class="form-group">
          <label for="pwd2">비밀번호 확인</label>
          <input type="password" name="pwd2" class="form-control" placeholder="Enter password" id="pwd2">
        </div>

        <div class="form-group">
          <label for="name">이름</label>
          <input type="text" name="name" class="form-control" placeholder="Enter name" id="name">
        </div>

        <div class="form-group">
          <label for="phone">핸드폰 번호</label>
          <input type="text" name="phone" class="form-control" placeholder="하이픈(-)없이 입력" id="phone">
        </div>

      </form>
      <button id="register_btn" class="btn btn-primary">회원가입</button>

    </div>
    <div class="col-sm-4">
      <p id="msg">회원가입 진행중</p>
    </div>
  </div>

</div>