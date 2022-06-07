package com.dw.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dw.board.mapper.StudentsMapper;
import com.dw.board.vo.StudentsVO;
import com.github.pagehelper.PageHelper;

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

//	public List<StudentsVO> getAllStudentsList(){
//		return studentsMapper.selectAllStudentsList();
//	}
	
	public List<Map<String,Object>> getAllStudentsList(int pageNum, int pageSize){
		PageHelper.startPage(pageNum, pageSize);
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
		
		String password = vo.getStudentsPassword();
		password = passwordEncoder.encode(password);
		vo.setStudentsPassword(password);
		
		return studentsMapper.updateStudents(vo);
	}
	
	// 가입된 학생인지 아닌지 체크
	@Transactional(rollbackFor = {Exception.class})
	public boolean isStuents(StudentsVO vo) {
		
		StudentsVO student = studentsMapper.selectStudentsOne(vo);
		// 회원이 있는지 없는지 부터 체크
		if(student == null) { // query결과가 null로 리턴
			return false;
		}
		String inputPassword = vo.getStudentsPassword(); // HTML에 입력된 패스워드
		String password = student.getStudentsPassword(); // DB에서 가져온 진짜 패스워드
		
		// passwordEncoder클래스에서 사용할 수 있는 method matches
		// 괄호안에 두 값이 암호화 된 상태인데 서로 같은지를 비교해줌
		if(!passwordEncoder.matches(inputPassword, password)) { // 비밀번호 체크
			return false;
		}
		return true;
	}
	
	// 학생이름 검색
	public List<Map<String, Object>> getStudentsSearchList(int pageNum, int pageSize, String writer){
		PageHelper.startPage(pageNum, pageSize);
		return studentsMapper.studentsSearchList(writer);
	}
}
