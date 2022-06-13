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
        <!-- 접속 기록 팝업 -->
        <div class="logs-popup">
            <div class="editor">
                <div class="input-box">
                    <label for="studentsName">접속 IP : </label>
                    <input id="ip" type="text" value="192.168.52.43" readonly>
                </div>
                <div class="input-box">
                    <label for="title">접속 시간 : </label>
                    <input id="createAt" type="text" value="2022-06-02 09:10:58" readonly>
                </div>
                <div class="input-box">
                    <!--카카오맵 위치-->
                    <div id="map" style="width:100%; height:300px;"></div>
                </div>
                <div class="btn-area">
                    <a href="#" class="btn-cancel">닫기</a>
                </div>
            </div>
        </div>
        <div class="navigation">
            <ul>
                <li>
                    <a href="">
                        <span class="icon"><ion-icon name="logo-apple"></ion-icon></span>
                        <span class="title">DW Board</span>                
                    </a>
                </li>
                <li>
                    <a href="/board?pageNum=1&pageSize=10">
                        <span class="icon"><ion-icon name="home-outline"></ion-icon></span>
                        <span class="title">Dashboard</span>                
                    </a>
                </li>
                <li>
                    <a href="/students">
                        <span class="icon"><ion-icon name="person-outline"></ion-icon></span>
                        <span class="title">Students</span>                
                    </a>
                </li>
                <li>
                    <a href="/logs">
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
                    <!-- <input id="searchBar" type="text" placeholder="작성자를 검색하세요..." > -->
                </label>
            </div>
            <div>
                <a href="#" class="logout">Logout</a>
            </div>
        </div>
         <!-- table -->
         <div class="details">
             <div class="recentOrders">
                 <div class="cardHeader">
                     <h2>접속자 히스토리</h2>
                 </div>
                 <table>
                     <thead>
                     <c:choose>
							<c:when test="${fn:length(pageHelper.list) > 0}">
								<c:forEach items="${pageHelper.list}" var="item">
									<tr onclick="getLogsList(${item.logId})">
										<td>${item.ip}</td>
										<td>${item.url}</td>
										<td>${item.httpMethod}</td>
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
                         <tr>
                            <th>로그 번호</th>
                            <th>IP</th>
                            <th>요청 URL</th>
                            <th>HTTP Method</th>
                            <th>접속 날짜</th>
                         </tr>
                     </thead>
                     <tbody id="boardData">
                         <!-- <tr onclick="getPopup()">
                            <td>1</td>
                            <td>192.158.0.252</td>
                            <td>/board</td>
                            <td>GET</td>
                            <td>2022-05-19 13:33:02</td>
                         </tr>
                         <tr onclick="getPopup()">
                            <td>2</td>
                            <td>192.158.0.252</td>
                            <td>/board</td>
                            <td>GET</td>
                            <td>2022-05-19 13:33:02</td>
                        </tr>
                        <tr onclick="getPopup()">
                            <td>3</td>
                            <td>192.158.0.252</td>
                            <td>/board</td>
                            <td>GET</td>
                            <td>2022-05-19 13:33:02</td>
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
						<a onclick="getLogsList(${pageHelper.pageNum-1},10)">Previous</a>
					</c:if>
					<c:forEach begin="${pageHelper.navigateFirstPage }"
						end="${pageHelper.navigateLastPage }" var="pageNum">
						<a id="pageNum${pageNum}" onclick="getLogsList(${pageNum},10)">${pageNum}</a>
					</c:forEach>
					<c:if test="${pageHelper.hasNextPage}">
						<a onclick="getLogsList(${pageHelper.pageNum+1},10)">Next</a>
					</c:if>
                 </div>
                 <input id="nowPageNum" type="hidden" value="${pageHelper.pageNum }">
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
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6d952a4c1fcd339237cc3a977487d364"></script>
<script>
    let list = document.querySelectorAll('.navigation li');
    function activeLink(){
        list.forEach((item) => {item.classList.remove('hovered')});
        this.classList.add('hovered');
    }
    list.forEach((item) => {item.addEventListener('mouseover',activeLink)});
</script>
<script>
    $('.logs-popup').css('display', 'none')

    // 페이지 번호 알아내는 함수
	function getPageNum(){
		var pageNum = $('#nowPageNum').val();

		$('#pageNum'+pageNum).css('backgroundColor','#287bff'); // id가 pageNum + pageNumber 문자를 합친거
		$('#pageNum'+pageNum).css('color','#fff');
	}
    
    function getLogsList(pageNum, pageSize){
    	location.href=http:"localhost:8080/api/v1/logs?pageNum="+pageNum+"&pageSize="+pageSize;
    }

    function getPopup(log_id){
        $('.logs-popup').css('display', 'block');
        
        $.ajax({
            url : '/api/v1/logs/logId/'+log_id,
            type : 'GET',
            dataType : 'json',
            success : function(response){

                    var latitude = response.latitude;
                    var longitude = response.longitude;
                    $('#ip').val(response.ip);
                    $('#createAt').val(response.create_at);
                    //카카오맵 
                    var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                       mapOption = { 
                           center: new kakao.maps.LatLng(latitude, longitude), // 지도의 중심좌표
                           level: 3 // 지도의 확대 레벨
                       };
           
                   var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
           
                   // 마커가 표시될 위치입니다 
                   var markerPosition  = new kakao.maps.LatLng(latitude, longitude); 
           
                   // 마커를 생성합니다
                   var marker = new kakao.maps.Marker({
                       position: markerPosition
                   });
                   // 마커가 지도 위에 표시되도록 설정합니다
                   marker.setMap(map);
                }
            }); //ajax end


    }

    $('.btn-cancel').click(function(){
        $('.logs-popup').css('display', 'none');
     });


    
</script>
</html>