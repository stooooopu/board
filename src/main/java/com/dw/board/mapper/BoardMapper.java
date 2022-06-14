package com.dw.board.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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
	// 위에 전체 조회는 기존에서 사용했으니까 테스트용 따로 만든거
	public List<Map<String,Object>> selectAllBoardListTest(@Param("pageNum") int pageNum, @Param("pageSize") int pageSize);
	
	public int deleteBoard(int boardId);
	
	public int updateBoard(BoardVO vo);
	
	public BoardVO selectBoardContent(int boardId);
	
	public int updateBoardViews(BoardVO vo);
	
	// 파라미터가 2개이상이면 @Param필수
	public List<Map<String,Object>> selectSearchBoardList(@Param("studentsName") String studentsName);
	
	public Map<String,Object> selectBoardStatistics();
	
	public int selectAllBoardListTotal();
}
