package com.dw.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dw.board.mapper.LogsMapper;
import com.dw.board.vo.LogsVO;
 
// controller에서 intercept하기때문에 controller가따로 필요 없음
@Service
public class LogsService {
	
	@Autowired
	private LogsMapper logsMapper;
	
	// 쌓는일이 대부분이기 때문에 transection안해도 됨
	public int setLogs(LogsVO vo) {
		return logsMapper.insertLogs(vo);
	}
	
	public List<Map<String,Object>> getLogsList(){
		return logsMapper.selectBoardLogs();
	}
}
