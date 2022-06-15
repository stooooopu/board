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
    <title>Document</title>
    <style>
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }
      .container {
        margin: 100px auto;
        background: rgba(232, 232, 232, 0.5);
        width: 800px;
        height: auto;
        padding: 3%;
      }
      .container h1 {
        text-align: center;
        margin-bottom: 10px;
      }
      .container input {
        width: 100%;
        height: 30px;
        margin-bottom: 5px;
      }
      .container select {
        width: 100%;
        height: 30px;
        margin-bottom: 5px;
      }
      .row {
        display: flex;
        justify-content: space-between;
        margin-bottom: 5px;
      }
      .row input {
        flex-basis: 30%;
      }
      .row select {
        flex-basis: 30%;
      }
      button {
        color: #fff;
        border: solid 1px rgba(0, 0, 0, 0.08);
        background-color: #03c75a;
        width: 100%;
        padding: 15px 0 15px;
        margin-top: 10px;
        font-size: 18px;
        font-weight: 700;
        text-align: center;
        cursor: pointer;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <h1>DW 게시판 회원가입</h1>
      <label for="userName">이름</label>
      <input id="userName" type="text" />
      <label for="password">비밀번호</label>
      <input id="password" type="password" />
      <label for="rePassword">비밀번호 재확인</label>
      <input id="rePassword" type="password" />

      <label for="userAddr">주소</label>
      <input id="userAddr" type="text" />
      <button type="button" onclick="getPostCode()">도로명 주소</button>
      
      <button type="button" onclick="join()">가입하기</button>
    </div>
    <script
      src="https://code.jquery.com/jquery-3.6.0.min.js"
      integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
      crossorigin="anonymous"
    ></script>
    <!-- 다음 도로명주소 script -->
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
      // 비밀번호 비밀번호재확인이 맞는지 확인
      function join(){
        var password = $('#password').val(); //비밀번호 데이터를 변수에 담음
        var rePassword = $('#rePassword').val();
        var userName = $('#userName').val();

        // 빈칸 체크
        if(password==''||rePassword==''||userName==''){
          alert('양식을 모두 작성 해 주세요');
          return false;
        }

        // 비밀번호, 비밀번호 재확인이 동일한지 체크
        if(password!==rePassword){
          alert('입력한 비밀번호가 다릅니다');
          $('#rePassword').focus();
          return false;
        }
        // 정말 중요한 정보일 경우 백엔드에서 한 번더 체크

        // API서버에 전송할 json생성
        var jsonData = {
          studentsName : userName,
          studentsPassword : rePassword
        }

        $.ajax({
          url : '/api/v1/students', // html파일을 jsp로 바꾸면서 주소가 줄어듦(헷갈리면 jsp폴더들어가서 controller, jsp파일 확인)
          type : 'POST',
          // postman에서 json선택하는게 밑에 contentType
          contentType : 'application/json', // 서버에 json타입으로 보낼 예정(요청)
          dataType : 'json', // 서버에 결과를 json으로 응답 받겠다
          data: JSON.stringify(jsonData), // 이걸 안쓰면 jsonType이 아닌 문자로 인식
          success : function(response){
            console.log(response);
            if(response > 0){
              alert('회원가입이 완료 되었습니다.');
              location.href = "/login" // login으로 넘어가는 controller만들기
            }
          }
        });
      }
      
      function getPostCode(){
    	  // daum클래스는 위에 script cdn에서 불러옴
    	  new daum.Postcode({
    		  // oncomplete : 내가 주소를 입력했다면 실행 해
              oncomplete: function(data) {
                  // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                  // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                  var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                  var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                  // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                  // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                  if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                      extraRoadAddr += data.bname;
                  }
                  // 건물명이 있고, 공동주택일 경우 추가한다.
                  if(data.buildingName !== '' && data.apartment === 'Y'){
                      extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                  }
                  // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                  if(extraRoadAddr !== ''){
                      extraRoadAddr = ' (' + extraRoadAddr + ')';
                  }
                  // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                  if(fullRoadAddr !== ''){
                      fullRoadAddr += extraRoadAddr;
                  }
                  //$("#userAddr").val(fullRoadAddr); // 위에 inputId userAddr에 값을 넣기
                  $("#userAddr").val(data.zonecode+', '+fullRoadAddr);
                  //data.zoncode = 우편번호
                  // 만약 우편번호까지 나오게 하고 싶으면 밑에 zonecode포함된걸 하기
              }
          }).open();
      }
    </script>
  </body>
</html>
