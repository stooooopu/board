package com.dw.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dw.board.mapper.StudentsMapper;
import com.dw.board.vo.StudentsVO;

@Service
public class StudentsService {

	@Autowired
	private StudentsMapper studentsMapper;
	
	@Transactional(rollbackFor = {Exception.class})
	public int setStudents(StudentsVO vo) {
		return studentsMapper.insertStudents(vo);
	}

	public List<StudentsVO> getAllStudentsList(){
		return studentsMapper.selectAllStudentsList();
	}
	
	public List<Map<String, Object>> getAllStudentsMap(){
		return studentsMapper.selectAllStudentsMap();
	}

	public StudentsVO getStudents(int studentsId) {
		return studentsMapper.selectStudents(studentsId);
	}
	
	@Transactional(rollbackFor = {Exception.class})
	public int deleteStudents(int StudentsId) {
		return studentsMapper.deleteStudents(StudentsId);
	}
	
	@Transactional(rollbackFor = {Exception.class})
	public int getUpdateStudents(StudentsVO vo,int StudentsId) {
		vo.setStudentsId(StudentsId);
		return studentsMapper.updateStudents(vo);
	}
}
