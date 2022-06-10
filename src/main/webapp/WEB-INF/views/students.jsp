<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link rel="stylesheet" href="/resources/static/css/board.css">
</head>
<body>
    <div class="container">
        <!-- 학생 정보 수정 -->
        <div class="update-popup">
            <div class="editor">
                <div class="close">
                    <a href="#" class="btn-close">닫기</a>
                </div>
                <div class="input-box">
                    <label for="studentsId">학생 아이디 : </label>
                    <input id="studentsId" type="text" placeholder="아이디 입력하세요...">
                </div>
                <div class="input-box">
                    <label for="studentsName">학생 이름 : </label>
                    <input id="studentsName" type="text" placeholder="이름을 입력하세요...">
                </div>
                <div class="input-box">
                    <label for="studentsPassword">학생 비밀번호 : </label>
                    <input id="studentsPassword" type="text" placeholder="이름을 입력하세요...">
                </div>
                <div class="btn-area">
                    <input id="boardIdHidden" type="hidden">
                    <a id="contentUpdate" href="#" class="btn-update">수정</a>
                    <a id="contentDelete" href="#" class="btn-delete">삭제</a>
                </div>
            </div>
        </div>
        <div class="navigation">
            <ul>
                <li>
                    <a href="#">
                        <span class="icon"><ion-icon name="logo-apple"></ion-icon></span>
                        <span class="title">DW Board</span>                
                    </a>
                </li>
                <li>
                    <a href="#">
                        <span class="icon"><ion-icon name="home-outline"></ion-icon></span>
                        <span class="title">Dashboard</span>                
                    </a>
                </li>
                <li>
                    <a href="#">
                        <span class="icon"><ion-icon name="person-outline"></ion-icon></span>
                        <span class="title">Students</span>                
                    </a>
                </li>
                <li>
                    <a href="#">
                        <span class="icon"><ion-icon name="lock-closed-outline"></ion-icon></span>
                        <span class="title">logs</span>                
                    </a>
                </li>
                <li>
                    <a href="#">
                        <span class="icon"><ion-icon name="log-out-outline"></ion-icon></span>
                        <span class="title">Sign Out</span>                
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <!-- main -->
    <div class="main">
        <div class="topbar">
            <div class="toggle">
                <!-- toggle은 나중에 만들기 -->
                <ion-icon name="menu-outline"></ion-icon>
            </div>
            <!-- search -->
            <div class="search">
                <label>
                    <input id="searchBar" type="text" placeholder="학생이름을 검색하세요..." >
                    <!-- hidden으로 해 놓으면 화면에서는 안보임 -->
                    <input id="searchBarHiddenVal" type="hidden" value="null"> 
                </label>
            </div>
            <div>
                <a href="#" class="logout">Logout</a>
                <div class="login-join-button"  style="display : none">
                    <a href="#" onclick = "hrefLink()" class="btn login">login</a>
                    <a href="#" onclick="joinHrefLink()" class="btn join-students">회원가입</a>
                </div>
            </div>
        </div>
         <!-- table -->
         <div class="details">
             <div class="recentOrders">
                 <div class="cardHeader">
                     <h2>학생 명단</h2>
                 </div>
                 <table>
                     <thead>
                         <tr>
                            <th>학생 아이디</th>
                            <th>학생 이름</th>
                            <th>가입 날짜</th>
                        </tr>
                     </thead>
                     <tbody id="boardData">
                         <!-- <tr>
                             <td>hyunsangwon</td>
                             <td>현상원</td>
                             <td>2022-05-19</td>
                         </tr>
                         <tr>
                            <td>hyunsangwon</td>
                            <td>현상원</td>
                            <td>2022-05-19</td>
                        </tr>
                        <tr>
                            <td>hyunsangwon</td>
                            <td>현상원</td>
                            <td>2022-05-19</td>
                        </tr> -->
                     </tbody>
                 </table>
                 <div class="pagination">
                    <!-- <a href="#">Previous</a>
                    <a href="#">1</a>
                    <a href="#">2</a>
                    <a href="#">3</a>
                    <a href="#">4</a>
                    <a href="#">5</a>
                    <a href="#">Next</a> -->
                 </div>
                 <input type="hidden" name="pageNum" value="#{pageNum}">
             </div>
         </div>
    </div>
</body>
<script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
<script
      src="https://code.jquery.com/jquery-3.6.0.min.js"
      integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
      crossorigin="anonymous"
    ></script>
<script>
    let list = document.querySelectorAll('.navigation li');
    function activeLink(){
        list.forEach((item) => {item.classList.remove('hovered')});
        this.classList.add('hovered');
    }
    list.forEach((item) => {item.addEventListener('mouseover',activeLink)});
    $('.btn-close').click(function(){
        $('.update-popup').css('display','none');
    })
</script>
<script>
    // 게시판 리스트 호출
    getStudentsList(1,10)
    
    // 학생리스트 확인 함수
    function getStudentsList(pageNum,pageSize){
        // getStudentsList Url
        var controllerUrl = 'http://localhost:8080/api/v1/students?pageNum='+pageNum+'&pageSize='+pageSize
        // 검색한 값이들어있음 hidden의 val은 새로고침 하기 전까지 담겨져 있음
        var hiddenVal = $('#searchBarHiddenVal').val();
        if(hiddenVal != 'null'){
            controllerUrl = 'http://localhost:8080/api/v1/students/search?writer='+hiddenVal+'&pageNum='+pageNum+'&pageSize='+pageSize;
        }
        $.ajax({
          url : controllerUrl,
          type : 'GET',
          dataType : 'json',
          success : function(response){
            //   json데이터가 맞게 들어왔는지 먼저 확인
            //   console.log(response);
            var html = ''; // 데이터를 담을 변수 생성

              for(var i=0; i<response.list.length; i++){
                //   console.log(response.list[i].studentsId)
                //   console.log(response.list[i].studentsName)
                //   console.log(response.list[i].createAt)
                // <tr> <td>hyunsangwon</td> <td>현상원</td> <td>2022-05-19</td> </tr>
                html += "<tr onclick = getBoard("+response.list[i].studentsId+")><td>"
                    +response.list[i].studentsId+"</td><td>"
                    +response.list[i].studentsName+"</td><td>"
                    +response.list[i].createAt+"</td></tr>";
            }
            
            // 페이지 구현
            var paginationHtml = '';
            
            if(response.hasPreviousPage){ // 이전 페이지가 true라면
                paginationHtml += '<a onclick="getStudentsList('+(response.pageNum-1)+','+pageSize+')" href="#">Previous</a>';
            }
                  for(var i=0; i<response.navigatepageNums.length; i++){ //페이지 번호만큼 for문 실행
                    // 페이지 번호가 있는 만큼 만들기
                    // 다음페이지 눌렀을 때 다음페이지로 넘어가기 onclick으로 구현
                    paginationHtml += '<a id="pageNum'+response.navigatepageNums[i]+'" onclick="getStudentsList('+response.navigatepageNums[i]+','+pageSize+')" href="#">'+response.navigatepageNums[i]+'</a>';
                }
                if(response.hasNextPage){ // 다음 페이지가 true라면
                    paginationHtml += '<a onclick="getStudentsList('+(response.pageNum+1)+','+pageSize+')"  href="#">Next</a>';
                }
                $('.pagination').children().remove();
                $('.pagination').append(paginationHtml);
                
                // 페이지 번호에 맞게 css수정
                $('#pageNum'+pageNum).css('backgroundColor','#287bff');
                $('#pageNum'+pageNum).css('color','#fff');

                // 둘의 children().remove()와 append()의 순서는 중요!
                // 반대로 하면 생성도 전에 모두 삭제 됨!!
                $('#boardData').children().remove();
                // 데이터가 맞게 들오온 걸 확인 후 table에 append
                $('#boardData').append(html);
            } 
        })
    }

    function getBoard(studentsId){

        // console.log(studentsId);
        $('.update-popup').css('display','block');
        
        $.ajax({
            url : 'http://localhost:8080/api/v1/students/id/'+studentsId,
            type : 'GET',
            dataType : 'json',
            success : function(response){
                console.log(response)

                // $('#수정할 정보 Id').val().(json으로 받아온 val넣기)
                $('#studentsId').val(response.studentsId)
                $('#studentsName').val(response.studentsName)
                $('#studentsPassword').val(response.studentsPassword)

                // studentsId를 왜 $('#boardIdHidden')의 val안에 넣지??
                // boardId를 숨겨서 val넣기 <- index.html 주석
                $('#boardIdHidden').val(studentsId);
            }
            }); //ajax end
    }

    // 수정함수
    $('#contentUpdate').click(function(){
        // boardIdHidden의 val = 내가 클릭한 studentsId
        // studentsId는 jsonData의 studentsId와 이름 겹치니까 변수이름 수정
        var studentsIdHidden = $('#boardIdHidden').val();
        // console.log(studentsIdHidden);

        // var 변수 = $('#수정할 정보 Id').val()
        // studentsId는 jsonData의 studentsId와 이름 겹치니까 변수이름 수정
        var uptStudentsId = $('#studentsId').val();
        var studentsName = $('#studentsName').val();
        var studentsPassword = $('#studentsPassword').val();

        var jsonData = {
            studentsId : uptStudentsId,
            studentsName : studentsName,
            studentsPassword : studentsPassword
        }

        $.ajax({
            url : 'http://localhost:8080/api/v1/students/id/'+studentsIdHidden,
            type : 'PATCH',
            contentType : 'application/json', 
            dataType : 'json',
            data: JSON.stringify(jsonData),
            success : function(response){
                if(response > 0){
                    alert('수정 완료')
                    $('.update-popup').css('display','none');
                    location.reload(); //F5
                }
            }
            }); //ajax end
    })

    // 삭제 함수
    $('#contentDelete').click(function(){
            
            // 게시판 번호 확인
            var studentsIdHidden = $('#boardIdHidden').val();

            if(confirm('정말 삭제 하시겠습니까?')){
                $.ajax({
                url : 'http://localhost:8080/api/v1/students/id/'+studentsIdHidden,
                type : 'DELETE',
                dataType : 'json',
                success : function(response){
                        $('.update-popup').css('display','none');
                }
                }); //ajax end
            }
        })

            
        $('#searchBar').keyup(function(key){
            if(key.keyCode == 13){ //keyCode13 = 엔터

                var pageNum = 1;
                var pageSize = 10;
                var writer = $('#searchBar').val().trim();
                
                if(writer != ''){
                    $('#searchBarHiddenVal').val(writer); // hidden에 내가 검색한 키워드를 val()에 set
                }
                $.ajax({
                    url : 'http://localhost:8080/api/v1/students/search?writer='+writer+'&pageNum='+pageNum+'&pageSize='+pageSize,
                    type : 'GET',
                    dataType : 'json',
                    success : function(response){
                        var html = ''; // 데이터를 담을 변수 생성

                for(var i=0; i<response.list.length; i++){
                    html += "<tr onclick = getBoard("+response.list[i].studentsId+")><td>"
                        +response.list[i].studentsId+"</td><td>"
                        +response.list[i].studentsName+"</td><td>"
                        +response.list[i].createAt+"</td></tr>";
                }
                
                // 페이지 구현
                var paginationHtml = '';
                
                if(response.hasPreviousPage){ // 이전 페이지가 true라면
                    paginationHtml += '<a onclick="getStudentsList('+(response.pageNum-1)+','+pageSize+')" href="#">Previous</a>';
                }
                    for(var i=0; i<response.navigatepageNums.length; i++){ //페이지 번호만큼 for문 실행
                        // 페이지 번호가 있는 만큼 만들기
                        // 다음페이지 눌렀을 때 다음페이지로 넘어가기 onclick으로 구현
                        paginationHtml += '<a id="pageNum'+response.navigatepageNums[i]+'" onclick="getStudentsList('+response.navigatepageNums[i]+','+pageSize+')" href="#">'+response.navigatepageNums[i]+'</a>';
                    }
                    if(response.hasNextPage){ // 다음 페이지가 true라면
                        paginationHtml += '<a onclick="getStudentsList('+(response.pageNum+1)+','+pageSize+')"  href="#">Next</a>';
                    }

                    $('.pagination').children().remove();
                    $('.pagination').append(paginationHtml);
                    
                    // 페이지 번호에 맞게 css수정
                    $('#pageNum'+pageNum).css('backgroundColor','#287bff');
                    $('#pageNum'+pageNum).css('color','#fff');

                    $('#boardData').children().remove();
                    $('#boardData').append(html);
                    }
                })
            }
        })
        
    $('.logout').on('click',function(){
    var result = confirm('로그아웃 하시겠습니까?');
    if(result){
        $('.login-join-button').css('display','block')
        $('.logout').css('display','none')
    }
})

function hrefLink(){
    var link = '../login.html'
    var result = confirm('로그인 하시겠습니까?');
    if(result){
        location.href = link;
    }
}

function joinHrefLink(){
    var link = '../join.html'
    var result = confirm('회원가입 하시겠습니까?');
    if(result){
        location.href = link;
    }
}
</script>
</html>