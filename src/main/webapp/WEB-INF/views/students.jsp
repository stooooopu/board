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
					<label for="studentsId">학생 아이디 : </label> <input id="studentsId"
						type="text" placeholder="아이디 입력하세요...">
				</div>
				<div class="input-box">
					<label for="studentsName">학생 이름 : </label> <input id="studentsName"
						type="text" placeholder="이름을 입력하세요...">
				</div>
				<div class="input-box">
					<label for="studentsPassword">학생 비밀번호 : </label> <input
						id="studentsPassword" type="text" placeholder="이름을 입력하세요...">
				</div>
				<div class="btn-area">
					<input id="boardIdHidden" type="hidden"> <a
						id="contentUpdate" href="#" class="btn-update">수정</a> <a
						id="contentDelete" href="#" class="btn-delete">삭제</a>
				</div>
			</div>
		</div>
		<div class="navigation">
			<ul>
				<li><a href=""> <span class="icon"><ion-icon
								name="logo-apple"></ion-icon></span> <span class="title">DW
							Board</span>
				</a></li>
				<li><a href="/board?pageNum=1&pageSize=10"> <span
						class="icon"><ion-icon name="home-outline"></ion-icon></span> <span
						class="title">Dashboard</span>
				</a></li>
				<li><a href="/students?pageNum=1&pageSize=10"> <span class="icon"><ion-icon
								name="person-outline"></ion-icon></span> <span class="title">Students</span>
				</a></li>
				<li><a href="/logs?pageNum=1&pageSize=10"> <span class="icon"><ion-icon
								name="lock-closed-outline"></ion-icon></span> <span class="title">logs</span>
				</a></li>
				<li><a href="#"> <span class="icon"><ion-icon
								name="log-out-outline"></ion-icon></span> <span class="title">Sign
							Out</span>
				</a></li>
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
				<label> <input id="searchBar" type="text"
					placeholder="학생이름을 검색하세요..."> <!-- hidden으로 해 놓으면 화면에서는 안보임 -->
					<input id="searchBarHiddenVal" type="hidden" value="null">
				</label>
			</div>
			<div>
				<a href="#" class="logout">Logout</a>
				<div class="login-join-button" style="display: none">
					<a href="#" onclick="hrefLink()" class="btn login">login</a> <a
						href="#" onclick="joinHrefLink()" class="btn join-students">회원가입</a>
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
						<c:choose>
							<c:when test="${fn:length(pageHelper.list) > 0}">
								<c:forEach items="${pageHelper.list}" var="item">
									<tr onclick="getBoard(${item.studentsId})">
										<td>${item.studentsId}</td>
										<td>${item.studentsName}</td>
										<td>${item.createAt}</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan=6 style="text-align: center;">게시글이 없습니다</td>
								</tr>
							</c:otherwise>
						</c:choose>
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
					<c:if test="${pageHelper.hasPreviousPage}">
						<a onclick="getStudentsList(${pageHelper.pageNum-1},10)">Previous</a>
					</c:if>
					<c:forEach begin="${pageHelper.navigateFirstPage }"
						end="${pageHelper.navigateLastPage }" var="pageNum">
						<a id="pageNum${pageNum}" onclick="getStudentsList(${pageNum},10)">${pageNum}</a>
					</c:forEach>
					<c:if test="${pageHelper.hasNextPage}">
						<a onclick="getStudentsList(${pageHelper.pageNum+1},10)">Next</a>
					</c:if>
				</div>
				<input id="nowPageNum" type="hidden" value="${pageHelper.pageNum }">
			</div>
		</div>
	</div>
</body>
<script type="module"
	src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
<script nomodule
	src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>
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
<script type="text/javascript">
	getPageNum();

	// 페이지 번호 알아내는 함수
	function getPageNum(){
		var pageNum = $('#nowPageNum').val();

		$('#pageNum'+pageNum).css('backgroundColor','#287bff'); // id가 pageNum + pageNumber 문자를 합친거
		$('#pageNum'+pageNum).css('color','#fff');
	}
    
    // 학생리스트 확인 함수
    function getStudentsList(pageNum,pageSize){
    	location.href="/students?pageNum="+pageNum+"&pageSize="+pageSize;    
    }
    
    // 클릭한 게시물 확인
    function getBoard(studentsId){

        $('.update-popup').css('display','block');
        
        $.ajax({
            url : '/api/v1/students/id/'+studentsId,
            type : 'GET',
            dataType : 'json',
            success : function(response){
                $('#studentsId').val(response.studentsId)
                $('#studentsName').val(response.studentsName)
                $('#studentsPassword').val(response.studentsPassword)

                $('#boardIdHidden').val(studentsId);
            }
            });
    }
    

    // 수정함수
    $('#contentUpdate').click(function(){
        var studentsIdHidden = $('#boardIdHidden').val();

        var uptStudentsId = $('#studentsId').val();
        var studentsName = $('#studentsName').val();
        var studentsPassword = $('#studentsPassword').val();

        var jsonData = {
            studentsId : uptStudentsId,
            studentsName : studentsName,
            studentsPassword : studentsPassword
        }

        $.ajax({
            url : '/api/v1/students/id/'+studentsIdHidden,
            type : 'PATCH',
            contentType : 'application/json', 
            dataType : 'json',
            data: JSON.stringify(jsonData),
            success : function(response){
                if(response > 0){
                    alert('수정 완료')
                    var pageNum = $('#nowPageNum').val();
                    getStudentsList(pageNum,10); 
                }
            }
          });
    })
    
    // 삭제 함수
    $('#contentDelete').click(function(){
            
            // 게시판 번호 확인
            var studentsIdHidden = $('#boardIdHidden').val();

            if(confirm('정말 삭제 하시겠습니까?')){
                $.ajax({
                url : '/api/v1/students/id/'+studentsIdHidden,
                type : 'DELETE',
                dataType : 'json',
                success : function(response){
                	alert('삭제 완료')
                	var pageNum = $('#nowPageNum').val();
                    getBoardList(pageNum,10);     
                }
              }); //ajax end
            }
        })
    
    $('#searchBar').keyup(function(key){
        var pageNum = 1;
        var pageSize = 10;
          if(key.keyCode == 13){
     	     var writer = $('#searchBar').val().trim();
           		if(writer != ''){
            		location.href="/students/search?writer="+writer+"&pageNum="+pageNum+"&pageSize="+pageSize;
            	}
              }
      	    })
          

</script>
</html>