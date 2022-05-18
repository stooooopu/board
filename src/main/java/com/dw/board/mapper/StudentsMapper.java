package com.dw.board.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.dw.board.vo.StudentsVO;

@Mapper
public interface StudentsMapper {
	
	// 메소드를 클릭 한 상태에서 alt + shift + J
	/**
	 * @param vo
	 * @return
	 * @author : ji_U
	 * @date : 2022. 5. 18.
	 * comment :
	 */
	public int insertStudents(StudentsVO vo);
	
	/**
	 * @return
	 * @author : ji_U
	 * @date : 2022. 5. 18.
	 * comment :
	 */
	public List<StudentsVO> selectAllStudentsList();
	
	/**
	 * @return
	 * @author : ji_U
	 * @date : 2022. 5. 18.
	 * comment :
	 */
	public List<Map<String, Object>> selectAllStudentsMap();
	
	public StudentsVO selectStudents(int studentsId);
	
	public int deleteStudents(int studentsId);
	
	/**
	 * @param vo
	 * @param studentsId
	 * @return
	 * @author : ji_U
	 * @date : 2022. 5. 18.
	 * comment : 특정학생 수정
	 */
	public int updateStudents(StudentsVO vo);
}
