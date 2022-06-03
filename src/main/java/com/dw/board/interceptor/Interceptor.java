package com.dw.board.interceptor;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.dw.board.service.LogsService;
import com.dw.board.vo.LogsVO;

// Bean : 스프링이 관리하는 클래스
// spring에서 제공하고 spring에서 관리하는 class : @Bean
// 내가 생성하고 spring에게 Bean으로 등록 해달라는 class : @Component
@Component
public class Interceptor implements HandlerInterceptor{

	@Autowired
	private LogsService logsService;
	// ** controller에 도착전에 intercept하는 함수
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		String url = request.getRequestURI();
		String ip = request.getHeader("X-forwarded-For");
		String httpMethod = request.getMethod();
		if(ip == null) ip = request.getRemoteAddr(); 

		System.out.println("IP ====> "+ip);
		// IP ====> 0:0:0:0:0:0:0:1 : localHost
		System.out.println("요청받은 URL은 ==> "+url);
		System.out.println("HTTP Method ==> "+httpMethod);
		
		
		SimpleDateFormat formatter = 
				new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.KOREA);
		String time = formatter.format(Calendar.getInstance().getTime());
		System.out.println("time ==> "+time);
		
		LogsVO vo = new LogsVO();
		vo.setUrl(url);
		vo.setIp(ip);
		vo.setHttpMethod(httpMethod);
		vo.setLatitude("36.3286904"); 
		vo.setLongitude("127.4229992");
		vo.setCreateAt(time);
		
		logsService.setLogs(vo);
		
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		
	}
	
}
