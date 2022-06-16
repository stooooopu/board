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
		<!-- 글 작성 팝업 -->
		<div class="write-popup">
			<div class="editor">
				<div class="input-box">
					<label for="studentsName">작성자 : </label> <input id="studentsName"
						type="text" value="현상원" readonly>
						<!-- 현재 로그인 한 studetnsId를 hidden으로 받기 위치는 노상관 지금 확인하기 쉽게 위에서 받은 것 -->
						<input id="studentsId" type="hidden" value="${studentsId }">
				</div>
				<div class="input-box">
					<label for="title">제목 : </label> <input id="title" type="text"
						placeholder="제목을 입력하세요...">
				</div>
				<div class="input-box">
					<textarea id="content" rows="10" cols="65"
						placeholder="내용을 간단히 적어주세요..."></textarea>
				</div>
				<div class="btn-area">
					<a href="#" class="btn-cancel">취소</a> <a id="contentSubmit"
						href="#" class="btn-success">등록</a>
				</div>
			</div>
		</div>
		<!-- 글 작성 수정 -->
		<div class="update-popup">
			<div class="editor">
				<div class="close">
					<a href="#" class="btn-close">닫기</a>
				</div>
				<div class="input-box">
					<label for="title">제목 : </label> <input id="upt-title" type="text"
						placeholder="제목을 입력하세요...">
				</div>
				<div class="input-box">
					<textarea id="upt-content" rows="10" cols="65"
						placeholder="내용을 간단히 적어주세요..."></textarea>
				</div>
				<div class="btn-area">
					<!-- boardId를 숨길거-->
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
					placeholder="작성자를 검색하세요..."> <input id="keyword"
					type="hidden" value="null">
				</label>
			</div>
			<div>
				<a href="/logout" class="logout">Logout</a>
			</div>
		</div>
		<!-- cards -->
		<div class="cardBox">
			<div class="card">
				<div>
					<div id="studentsCnt" class="numbers">1,400</div>
					<div class="cardName">학생 수</div>
				</div>
				<div class="iconBx">
					<ion-icon name="school-outline"></ion-icon>
				</div>
			</div>
			<div class="card">
				<div>
					<div id="boardCnt" class="numbers">500</div>
					<div class="cardName">게시글 수</div>
				</div>
				<div class="iconBx">
					<ion-icon name="book-outline"></ion-icon>
				</div>
			</div>
			<div class="card">
				<div>
					<div id="writerCnt" class="numbers">300</div>
					<div class="cardName">작성자 수</div>
				</div>
				<div class="iconBx">
					<ion-icon name="code-slash-outline"></ion-icon>
				</div>
			</div>
			<div class="card">
				<div>
					<div id="viewsCnt" class="numbers">2,800</div>
					<div class="cardName">총 조회 수</div>
				</div>
				<div class="iconBx">
					<ion-icon name="eye-outline"></ion-icon>
				</div>
			</div>
		</div>
		<!-- table -->
		<div class="details">
			<div class="recentOrders">
				<div class="cardHeader">
					<h2>Board List</h2>
					<a href="/excel" class="excel-btn">엑셀 다운로드</a>
					<a href="#" class="btn">글 작성</a>
				</div>
				<table>
					<thead>
						<tr>
							<th>게시판 번호</th>
							<th>작성자</th>
							<th>제목</th>
							<th>수정 날짜</th>
							<th>작성 날짜</th>
							<th>조회 수</th>
						</tr>
					</thead>
					<tbody id="boardData">
						<c:choose>
							<c:when test="${fn:length(pageHelper.list) > 0}">
								<c:forEach items="${pageHelper.list}" var="item">
									<tr onclick="getBoard(${item.boardId})">
										<td>${item.boardId}</td>
										<td>${item.studentsName}</td>
										<td>${item.title}</td>
										<td>${item.updateAt}</td>
										<td>${item.createAt}</td>
										<c:if test="${item.cnt  < 10}">
											<td><span class="row">${item.cnt}</span></td>
										</c:if>
										<c:if test="${item.cnt > 10 } && ${item.cnt < 20}">
											<td><span class="middle">${item.cnt}</span></td>
										</c:if>
										<c:if test="${item.cnt >= 20}">
											<td><span class="high">${item.cnt}</span></td>
										</c:if>
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
                             <td>1</td>
                             <td>현상원</td>
                             <td>점심시간이 너무 짧아요!</td>
                             <td>2022-05-19</td>
                             <td>2022-05-18</td>
                             <td><span class="high">8320</span></td>
                         </tr>
                         <tr>
                            <td>2</td>
                            <td>현상원</td>
                            <td>학원에 커피기계가 없어요!</td>
                            <td>2022-05-19</td>
                            <td>2022-05-18</td>
                            <td><span class="middle">1200</span></td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td>현상원</td>
                            <td>너무 졸려요...</td>
                            <td>2022-05-19</td>
                            <td>2022-05-18</td>
                            <td><span class="row">5</span></td>
                        </tr>
                        <tr>
                            <td>4</td>
                            <td>현상원</td>
                            <td>안녕하세요!</td>
                            <td>2022-05-19</td>
                            <td>2022-05-18</td>
                            <td><span class="row">22</span></td>
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
						<a onclick="getBoardList(${pageHelper.pageNum-1},10)">Previous</a>
					</c:if>
					<c:forEach begin="${pageHelper.navigateFirstPage }"
						end="${pageHelper.navigateLastPage }" var="pageNum">
						<a id="pageNum${pageNum}" onclick="getBoardList(${pageNum},10)">${pageNum}</a>
					</c:forEach>
					<c:if test="${pageHelper.hasNextPage}">
						<a onclick="getBoardList(${pageHelper.pageNum+1},10)">Next</a>
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
    $('.btn').click(function(){
        $('.write-popup').css('display', 'block');
    });
    $('.btn-cancel').click(function(){
        $('.write-popup').css('display', 'none');
    });
    // 팝업창 닫기
    $('.btn-close').click(function(){
        $('.update-popup').css('display','none');
		location.reload(); // 닫기창을 누름과 동시에 새로고침
    })
    // $('#contentSubmit').click(function(){
    //     if(confirm('게시글을 작성하시겠습니까?')){
    //         $('.write-popup').css('display', 'none');
    //     }
    // });
    let list = document.querySelectorAll('.navigation li');
    function activeLink(){
        list.forEach((item) => {item.classList.remove('hovered')});
        this.classList.add('hovered');
    }
    list.forEach((item) => {item.addEventListener('mouseover',activeLink)});
</script>
<script src="/resources/static/js/board.js"></script>
</html>