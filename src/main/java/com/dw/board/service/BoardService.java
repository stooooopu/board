package com.dw.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dw.board.mapper.BoardMapper;
import com.dw.board.vo.BoardVO;

@Service
public class BoardService {
	
	@Autowired
	private BoardMapper boardMapper;
	
	@Transactional(rollbackFor = {Exception.class})
	public int setBoard(BoardVO vo) {
		return boardMapper.insertBoard(vo);
	}
	
	public List<BoardVO> getAllBoardList(){
		return boardMapper.selectAllBoardList();
	}
	
	@Transactional(rollbackFor = {Exception.class})
	public int deleteBoard(int boardId) {
		return boardMapper.deleteBoard(boardId);
	}
}
