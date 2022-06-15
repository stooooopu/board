package com.dw.board.controller;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class GlobalController implements ErrorController{ // errorController는 이미 존재함

	// 에러 코드에 맞게 페이지를 보여줄 것
	@GetMapping("/error") // 여기로 모든 error가 옴
	public String handleError(ModelMap model, HttpServletRequest request) { // Servlet : tomcat에 요청 오는 것으로 생각
		// 에러 코드를 받는 변수
		String status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE).toString();
		// String status = (String)request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);

		System.out.println("Error Code : "+status);
		
		if(status.equals("404")) {
			return "error/error404";
		}
		
		if(status.equals("500")) {
			return "error/error500";
		}
		return null;
	}
	
}
