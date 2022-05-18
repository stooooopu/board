package com.dw.board.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dw.board.service.StudentsService;
import com.dw.board.vo.StudentsVO;

@RestController
// 중복되는 url을 @RequestMapping으로 전역변수처럼 뺄 수 있음
@RequestMapping("/api/v1") //api주소에 버젼1임
public class StudentsRestController {

	@Autowired
	private StudentsService studentsService;
		// 학생 저장
		// post는 body로 데이터를 받음
		// @PostMapping("/api/v1/students") 
		@CrossOrigin 
		@PostMapping("/students")
		public int callSaveStudents(@RequestBody StudentsVO vo) {
			return studentsService.setStudents(vo);
		}
		
		// 학생 조회
		@GetMapping("/students")
		public List<StudentsVO> callStudentsList(){
			return studentsService.getAllStudentsList();
		}
		
		// map으로 학생 조회
		@GetMapping("/students/map")
		public List<Map<String, Object>> callStudentsListByMap(){
			return studentsService.getAllStudentsMap();
		}
		
		// 특정 학생 조회(PK로 조회예정)
		@GetMapping("/students/id/{id}")
		public StudentsVO callStudents(@PathVariable("id") int studentsId) {
			return studentsService.getStudents(studentsId);
		}
		
		@DeleteMapping("/students/id/{id}")
		public int callRemoveStudents(@PathVariable("id") int studentsId) {
			return studentsService.deleteStudents(studentsId);
		}
		
		@PatchMapping("/students/id/{id}")
		public int callUpdateStudents(@PathVariable("id") int studentsID, 
				@RequestBody StudentsVO vo) {
			return studentsService.getUpdateStudents(vo, studentsID);
		}
}
