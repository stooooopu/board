package com.dw.board.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dw.board.service.LogsService;
import com.github.pagehelper.PageInfo;

@Controller
public class LogsController {

	@Autowired
	private LogsService logsService;
	
	@GetMapping("/logs")
	public String loadLogsPage(ModelMap map, 
			@RequestParam("pageNum")int pageNum,
			@RequestParam("pageSize")int pageSize) {
		List<Map<String, Object>> list = logsService.getLogsList(pageNum, pageSize);
		System.out.println(list);
		// page정보(pageNum, pageSize ... 이들어있는 클래스)+list(내가 작성한 boardList)
		PageInfo<Map<String,Object>> pageInfo = new PageInfo<Map<String,Object>>(list);
		
		// pageHelper = json형식으로 page정보가 들어있는 클래스
		map.addAttribute("pageHelper", pageInfo);
		return "logs";
	}
}
