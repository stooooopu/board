package com.dw.board.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dw.board.service.StudentsService;
import com.github.pagehelper.PageInfo;

@Controller
public class StudentsController {

	@Autowired
	private StudentsService studentsService;
	
	@GetMapping("/students")
	public String loadStudentsPage(ModelMap map, 
			@RequestParam("pageNum")int pageNum,
			@RequestParam("pageSize")int pageSize) {
		List<Map<String,Object>> list = studentsService.getAllStudentsList(pageNum, pageSize);
		
		PageInfo<Map<String, Object>> pageInfo = new PageInfo<Map<String,Object>>(list);
		
		map.addAttribute("pageHelper", pageInfo);
		return "students";
	}
	@GetMapping("/students/search")
	public String callBoardSearch(ModelMap map,
			@RequestParam("writer") String writer,
			@RequestParam("pageNum")int pageNum,
			@RequestParam("pageSize")int pageSize){
		List<Map<String,Object>> list = studentsService.getAllStudentsList(pageNum, pageSize);
		PageInfo<Map<String,Object>> pageInfo = new PageInfo<Map<String,Object>>(list);
		
		map.addAttribute("pageHelper", pageInfo);
		
		return "students";
	}
		
}
	
