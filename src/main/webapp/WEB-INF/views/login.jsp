<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="/resources/static/css/login.css" />
    <title>게시판 로그인</title>
  </head>
  <body>
    <div class="container">
      <h1>Login</h1>
      <div class="login-form">
        <div class="txt-field">
          <input id="userId" type="text" required />
          <label>이름</label>
        </div>
        <div class="txt-field">
          <input id="userPassword" type="password" required />
          <label>비밀번호</label>
        </div>
        <input id="loginBtn" class="login-btn" type="butten" value="로그인" />
        <div class="signup-link">회원이 아닌가요? <a href="/join">회원가입</a></div>
      </div>
    </div>
    <script
      src="https://code.jquery.com/jquery-3.6.0.min.js"
      integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
      crossorigin="anonymous"
    ></script>
    <script>
      // 버튼을 클릭할 때 실행
      $('#loginBtn').on('click',function(){
        var userId = $('#userId').val();
        var userPassword = $('#userPassword').val();

        if(userId =='' || userPassword == ''){
          alert('빈칸을 입력 해 주세요');
          $('#userId').focus();
          return false;
          }
          var jsonData = {
            studentsName : userId,
            studentsPassword : userPassword
          }
          $.ajax({
              url : '/api/v1/login',
              type : 'POST',
              // postman에서 json선택하는게 밑에 contentType
              contentType : 'application/json', // 서버에 json타입으로 보낼 예정(요청)
              dataType : 'json', // 서버에 결과를 json으로 응답 받겠다
              data: JSON.stringify(jsonData), // 이걸 안쓰면 jsonType이 아닌 문자로 인식
              success : function(response){
                if(response){
                  location.href = 'board/index.html'; //페이지 이동
                }else{
                  alert('회원정보를 확인 해 주세요');
                  return false;
                }
                
              }
            });
      });

   </script>
  </body>
</html>