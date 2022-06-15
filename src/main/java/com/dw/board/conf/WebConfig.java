package com.dw.board.conf;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.dw.board.interceptor.Interceptor;

@Configuration
public class WebConfig implements WebMvcConfigurer {

	@Autowired
	private Interceptor interceptor;

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		// 우리가 만든 interceptor를 spring에 등록
		// (url)은 intercept하지마 : .excludePathPatterns("/api/v1/logs");
		// login하지도 않은 사람의 session은 필요 없음
		registry.addInterceptor(interceptor)
		.excludePathPatterns("/api/v1/logs",
				"/login",
				"/join",
				"/api/v1/login",
				"/resources/static/css/*",
				"/resources/static/images/*",
				"/resources/static/js/*",
				"/error");
		
	}
	
}
