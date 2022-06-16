package com.dw.board.interceptor;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

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

	// syso이 아닌 실무에서 확인하는 방법
	private static final Logger logger = LoggerFactory.getLogger(Interceptor.class);
	
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

		logger.info("Hello World");
		logger.info("client IP : "+ip);
		logger.info("request URL : "+url);
		logger.info("request HTTPMethod : "+httpMethod);
		
//		System.out.println("IP ====> "+ip);
//		// IP ====> 0:0:0:0:0:0:0:1 : localHost
//		System.out.println("요청받은 URL은 ==> "+url);
//		System.out.println("HTTP Method ==> "+httpMethod);
		
		
		SimpleDateFormat formatter = 
				new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.KOREA);
		String time = formatter.format(Calendar.getInstance().getTime());
//		System.out.println("time ==> "+time);
		
		LogsVO vo = new LogsVO();
		vo.setUrl(url);
		vo.setIp(ip);
		vo.setHttpMethod(httpMethod);
		vo.setLatitude("36.3286904");
		vo.setLongitude("127.4229992");
		vo.setCreateAt(time);
		
		logsService.setLogs(vo);
		
		
		// 모든controller, restController에 세션을 가져와서 확인할 수 없으니 Interceptor에 추가한것
		// session 체크
		HttpSession session = request.getSession();
//		if(session.getAttribute("studentsId") != null) {
//			int studentsId = (int)session.getAttribute("studentsId");
//			String studentsName = (String)session.getAttribute("studentsName");
//			System.out.println("session에서 가져온 id ==> "+studentsId);
//			System.out.println("session에서 가져온 name ==> "+studentsName);
//		}
		if(session.getAttribute("studentsId") == null) {
			response.sendRedirect("/login"); // session값이 없으면 "/login"경로로 redirect
			return false; // 원래는 redirect로 바로 넘어야야하는데 return true로 돼서 false추가
		}
		
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
