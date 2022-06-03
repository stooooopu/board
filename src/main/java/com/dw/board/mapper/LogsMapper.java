package com.dw.board.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.dw.board.vo.LogsVO;

// log등의 기록 데이터는 insert(intercetor에서) & select(controller에서)만 구현
@Mapper
public interface LogsMapper {
	
	public int insertLogs(LogsVO logvo); // 접속이력 저장
	
	public List<Map<String,Object>> selectBoardLogs(); // 이력 불러오기
}
