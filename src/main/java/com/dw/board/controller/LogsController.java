package com.dw.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.dw.board.service.LogsService;

@Controller
public class LogsController {

	@Autowired
	private LogsService logsService;
	
	@GetMapping("/logs")
	public String loadLogsPage() {
		return "logs";
	}
}
