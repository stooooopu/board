package com.dw.board.service;

import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.BorderStyle;
//import org.apache.poi.ss.*;가능
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dw.board.mapper.BoardMapper;

@Service
public class ExcelService {

	@Autowired
	private BoardMapper boardMapper;

	// workbook = excel
	// throws Exception : 이 메소드에서 에러가 발생하면 캐치를 해줘
	public Workbook makeExcelForm() throws Exception {

		Workbook workbook = new HSSFWorkbook(); // excel생성

		// sheet이름
		Sheet sheet = workbook.createSheet("게시판 자료");
		Row row = null; // 엑셀 행
		Cell cell = null; // 엑셀 열
		int rowNumber = 0; // 행 번호

		CellStyle headStyle = makeExcelHeadStyle(workbook);
		CellStyle bodyStyle = makeExcelBodyStyle(workbook);
		
		row = sheet.createRow(rowNumber++); // 첫 번째 행(엑셀은 행이 0번이 아닌 1번부터 시작)
		cell = row.createCell(0); // 첫 번째 열 (0부터 시작)
		cell.setCellStyle(headStyle);
		cell.setCellValue("게시판 번호");

		cell = row.createCell(1);
		cell.setCellStyle(headStyle);
		cell.setCellValue("작성자");

		cell = row.createCell(2);
		cell.setCellStyle(headStyle);
		cell.setCellValue("제목");

		cell = row.createCell(3);
		cell.setCellStyle(headStyle);
		cell.setCellValue("수정날짜");

		cell = row.createCell(4);
		cell.setCellStyle(headStyle);
		cell.setCellValue("작성날짜");

		cell = row.createCell(5);
		cell.setCellStyle(headStyle);
		cell.setCellValue("조회수");

		// mapper데이터 호출
		// 데이터를 넣기
		List<Map<String, Object>> list = boardMapper.selectAllBoardList();

		for (Map<String, Object> data : list) {
			row = sheet.createRow(rowNumber++); // 행을 계속 추가함(for문 조건식이 만족할 때 까지
			cell = row.createCell(0); // 게시판 번호
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(data.get("boardId").toString());
			
			cell = row.createCell(1); // 작성자
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(data.get("studentsName").toString());
			
			cell = row.createCell(2); // 제목
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(data.get("title").toString());
			
			cell = row.createCell(3); // 수정날짜
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(data.get("updateAt").toString());
			
			cell = row.createCell(4); // 작성날짜
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(data.get("createAt").toString());
			
			cell = row.createCell(5); // 조회수
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(data.get("cnt").toString()); // toString 왜쓰지
		}
		return workbook;
	}

	// head와 body꾸미는게 다름 그래서 메소드 이름에 head넣은거
	// 엑셀 헤드 스타일 수정
	public CellStyle makeExcelHeadStyle(Workbook workbook) {

		CellStyle cellStyle = null;
		cellStyle = workbook.createCellStyle();
		// 엑셀 테두리 가는 경계선 생성
		cellStyle.setBorderTop(BorderStyle.THIN);
		cellStyle.setBorderLeft(BorderStyle.THIN);
		cellStyle.setBorderRight(BorderStyle.THIN);
		cellStyle.setBorderBottom(BorderStyle.THIN);

		// 배경색 입히기
		cellStyle.setFillForegroundColor(HSSFColor.HSSFColorPredefined.YELLOW.getIndex());
		cellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		// 가운데 정렬
		cellStyle.setAlignment(HorizontalAlignment.CENTER);
		return cellStyle;
	}

	// 엑셀 바디 스타일 수정
	public CellStyle makeExcelBodyStyle(Workbook workbook) {

		CellStyle cellStyle = null;
		cellStyle = workbook.createCellStyle();

		// 엑셀 테두리 가는 경계선 생성
		cellStyle.setBorderTop(BorderStyle.THIN);
		cellStyle.setBorderLeft(BorderStyle.THIN);
		cellStyle.setBorderRight(BorderStyle.THIN);
		cellStyle.setBorderBottom(BorderStyle.THIN);
		
		// 가운데 정렬
		cellStyle.setAlignment(HorizontalAlignment.CENTER);
		return cellStyle;
	}
}
