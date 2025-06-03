package com.example.project_server.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.example.project_server.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class NeedLogoutInterceptor implements HandlerInterceptor {

	@Autowired
	private Rq rq;

	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler) throws Exception {

		if (rq.isLogined()) {

			rq.printConfirmAndRedirect("로그아웃 후 사용 할 수 있습니다. 로그아웃 하시겠습니까?",
					"../member/doLogout");
			return false;
		}

		return HandlerInterceptor.super.preHandle(req, resp, handler);
	}
}
