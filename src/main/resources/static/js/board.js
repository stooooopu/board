getBoardStatistics();
getPageNum();

// 통계 함수
function getBoardStatistics() {
	// .ajax로 불러온 데이터는 RestController에서 불러온데이터
	$.ajax({
		url: '/api/v1/board/statistics', // input의 값을 가져옴
		type: 'GET',
		dataType: 'json',
		success: function(response) {
			$('#boardCnt').text(response.boardCnt);
			$('#studentsCnt').text(response.studentsCnt);
			$('#writerCnt').text(response.writerCnt);
			$('#viewsCnt').text(response.viewsCnt);
		}
	})
}
//페이지 번호 알아내는 함수
function getPageNum() {
	var pageNum = $('#nowPageNum').val();
	$('#pageNum' + pageNum).css('backgroundColor', '#287bff'); // id가 pageNum + pageNumber 문자를 합친거
	$('#pageNum' + pageNum).css('color', '#fff');
}


// 전체 조회 함수
// controller(Spring안에 함께 있는 데이터)에서 직접 위에 데이터를 넣어줌
function getBoardList(pageNum, pageSize) {
	location.href = "/board?pageNum=" + pageNum + "&pageSize=" + pageSize;
}

// 클릭한 게시물 확인하는 함수
function getBoard(boardId) {
	$('.update-popup').css('display', 'block');

	$.ajax({
		url: '/api/v1/board/boardId/' + boardId,
		type: 'GET',
		dataType: 'json',
		success: function(response) {
			$('#upt-title').val(response.title)
			$('#upt-content').val(response.content)
			$('#boardIdHidden').val(boardId);
			setBoardViews(boardId) //조회수 증가함수
		}
	})
}

// 게시판 조회수 증가함수
function setBoardViews(boardId) {
	$.ajax({
		url: '/api/v1/board/views/boardId/' + boardId,
		type: 'PATCH',
		dataType: 'json',
		success: function(response) {
			if (response > 0) {
				// 추후 로직 구현 예정 (에러페이지로 이동하는 로직)
			}
		}
	})
}

// 글작성
$('#contentSubmit').click(function() {

	if (confirm('게시글을 작성하시겠습니까?')) {
		var title = $('#title').val();
		var content = $('#content').val();
		// hidden으로 숨긴 로그인한 id를 가져와서 입력
		var studentsId = $('#studentsId').val();

		if (title == '') {
			alert('제목을 입력하세요');
			$('#title').focus();
			return false;
		}

		if (content == '') {
			alert('본문을 입력하세요');
			$('#content').focus();
			return false;
		}

		var jsonData = {
			studentsId: studentsId,
			title: title,
			content: content
		}
		$.ajax({
			url: '/api/v1/board',
			type: 'POST',
			contentType: 'application/json',
			dataType: 'json',
			data: JSON.stringify(jsonData),
			success: function(response) {
				if (response > 0) {
					var pageNum = $('#nowPageNum').val();
					getBoardList(pageNum, 10);
				}
			}
		}); //ajax end
	} // if end
}); // function end

// 게시물 수정하는 함수
// contentUpdate type은 button
$('#contentUpdate').click(function() {

	// 1. 게시판 번호 확인
	var boardId = $('#boardIdHidden').val(); // hidden에 숨겨둔 baordId가져오기
	// console.log(boardId)

	// 2. json만들어서 수정할 제목과 내용 ajax로 보내기
	var title = $('#upt-title').val();
	var content = $('#upt-content').val();

	var jsonData = {
		title: title,
		content: content
	}

	// 3. ajax를 이용해서 업데이트
	$.ajax({
		url: '/api/v1/board/boardId/' + boardId,
		type: 'PATCH',
		contentType: 'application/json',
		dataType: 'json',
		data: JSON.stringify(jsonData),
		success: function(response) {
			if (response > 0) {
				alert('수정완료')
				var pageNum = $('#nowPageNum').val();
				getBoardList(pageNum, 10);
			}
		}
	});
})

// 삭제함수
$('#contentDelete').click(function() {
	// 게시판 번호 확인
	var boardId = $('#boardIdHidden').val();

	if (confirm('정말 삭제 하시겠습니까?')) {
		$.ajax({
			url: '/api/v1/board/boardId/' + boardId,
			type: 'DELETE',
			dataType: 'json',
			success: function(response) {
				alert('삭제 완료')
				var pageNum = $('#nowPageNum').val();
				getBoardList(pageNum, 10);
			}
		});
	}
})

$('#searchBar').keyup(function(key) {
	var pageNum = 1;
	var pageSize = 10;
	if (key.keyCode == 13) {
		var search = $('#searchBar').val().trim(); // input에 작성한 작성자값을 가져옴
		if (search != '') {
			location.href = "/board/search?writer=" + search + "&pageNum=" + pageNum + "&pageSize=" + pageSize;
		}
	}
})