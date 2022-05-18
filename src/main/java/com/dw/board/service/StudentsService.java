package com.dw.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dw.board.mapper.StudentsMapper;
import com.dw.board.vo.StudentsVO;

@Service
public class StudentsService {

	@Autowired
	private StudentsMapper studentsMapper;
	@Autowired
	private PasswordEncoder passwordEncoder; // Bean등록을 해 줘서 autowired가능
	
	// 학생 저장
	@Transactional(rollbackFor = {Exception.class})
	public int setStudents(StudentsVO vo) {
		// 학생 비밀번호 암호화
		String password = vo.getStudentsPassword();
		password = passwordEncoder.encode(password);
		vo.setStudentsPassword(password);
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
