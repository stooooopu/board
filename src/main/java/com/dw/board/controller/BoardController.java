package com.dw.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BoardController {

	@GetMapping("/home")
	public String callHompage() {
		//JSP 파일 이름 리턴
		return "index";
	}
}
