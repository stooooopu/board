package com.dw.board.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.dw.board.vo.LogsVO;

@Mapper
public interface LogsMapper {
	// Log같은 기록 데이터는 삭제, 수정을 하지 않는다
	// insert, select만 구현
	
	// 접속이력 저장
	public int insertLogs(LogsVO logsVO);
	
	public List<Map<String, Object>> selectBoardLogs(int logId);
}
