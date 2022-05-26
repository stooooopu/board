package com.dw.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dw.board.mapper.BoardMapper;
import com.dw.board.vo.BoardVO;

@Service
public class BoardService {
	
	@Autowired
	private BoardMapper boardMapper;
	
	// insert
	@Transactional(rollbackFor = {Exception.class})
	public int setBoard(BoardVO vo) {
		return boardMapper.insertBoard(vo);
	}
	
	// get
	public List<Map<String,Object>> getAllBoardList(){
		return boardMapper.selectAllBoardList();
	}
	
	// delete
	@Transactional(rollbackFor = {Exception.class})
	public int deleteBoard(int boardId) {
		return boardMapper.deleteBoard(boardId);
	}
	
	// update
	@Transactional(rollbackFor = {Exception.class})
	public int updateBoard(BoardVO vo, int boardId) {
		vo.setBoardId(boardId);
		return boardMapper.updateBoard(vo);
	}
	
	// get
	public BoardVO getBoardContent(int boardId) {
		return boardMapper.selectBoardContent(boardId);
	}
}
