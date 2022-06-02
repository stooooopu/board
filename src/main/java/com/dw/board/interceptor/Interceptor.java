package com.dw.board.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

// Bean : 스프링이 관리하는 클래스
// spring에서 제공하고 spring에서 관리하는 class : @Bean
// 내가 생성하고 spring에게 Bean으로 등록 해달라는 class : @Component
@Component
public class Interceptor implements HandlerInterceptor{

	// ** controller에 도착전에 intercept하는 함수
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		String url = request.getRequestURI();
		String ip = request.getHeader("X-forwarded-For");
		if(ip == null) ip = request.getRemoteAddr(); 

		System.out.println("IP ====> "+ip);
		System.out.println("요청받은 URL은 ==> "+url);
		
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
