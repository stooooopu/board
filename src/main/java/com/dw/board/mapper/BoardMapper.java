package com.dw.board.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.dw.board.vo.BoardVO;

@Mapper
public interface BoardMapper {
	
	/**
	 * @param vo
	 * @return
	 * @author : ji_U
	 * @date : 2022. 5. 19.
	 * comment : 보드 입력
	 */
	public int insertBoard(BoardVO vo);
	
	/**
	 * @return
	 * @author : ji_U
	 * @date : 2022. 5. 19.
	 * comment : 전체 보드 조회
	 */
	public List<Map<String,Object>> selectAllBoardList();
	
	public int deleteBoard(int boardId);
	
	public int updateBoard(BoardVO vo);
}
