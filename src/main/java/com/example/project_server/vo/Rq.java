package com.example.project_server.vo;

import java.io.IOException;

import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Component;

import com.example.project_server.util.Ut;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.Getter;
import lombok.Setter;

@Component
@Scope(value = "request", proxyMode = ScopedProxyMode.TARGET_CLASS)
@Getter
@Setter
public class Rq {

	private final HttpServletRequest req;
	private final HttpServletResponse resp;
	private final HttpSession session;

	private boolean isLogined = false;
	private int loginedMemberId = 0;

	public Rq(HttpServletRequest req, HttpServletResponse resp) {
		this.req = req;
		this.resp = resp;
		this.session = req.getSession();

		if (session.getAttribute("loginedMemberId") != null) {
			isLogined = true;
			loginedMemberId = (int) session.getAttribute("loginedMemberId");
		}

		this.req.setAttribute("rq", this);
	}

	public void printHistoryBack(String msg) throws IOException {
		resp.setContentType("text/html; charset=UTF-8");
		println("<script>");
		if (!Ut.isEmpty(msg)) {
			println("alert('" + msg.replace("'", "\\'") + "');");
		}
		println("history.back();");
		println("</script>");
		resp.getWriter().flush();
		resp.getWriter().close();
	}

	public void printConfirmAndRedirect(String msg, String redirectUrl) throws IOException {
		resp.setContentType("text/html; charset=UTF-8");
		println("<script>");

		if (!Ut.isEmpty(msg)) {
			// 'msg'를 confirm 메시지로 사용
			println("if (confirm('" + msg.replace("'", "\\'") + "')) {");
			println("    location.href = '" + redirectUrl + "';");
			println("} else {");
			println("    history.back();");
			println("}");
		} else {
			// 메시지가 없으면 그냥 이동
			println("location.href = '../member/login';");
		}

		println("</script>");
		resp.getWriter().flush();
		resp.getWriter().close();
	}

	private void println(String str) throws IOException {
		print(str + "\n");
	}

	private void print(String str) throws IOException {
		resp.getWriter().append(str);
	}

	public void logout() {
		session.removeAttribute("loginedMemberId");
	}

	public void login(Member member) {
		session.setAttribute("loginedMemberId", member.getId());
	}

	public String historyBackOnView(String msg) {
		req.setAttribute("msg", msg);
		req.setAttribute("historyBack", true);
		return "usr/common/js";
	}

	public String getCurrentUri() {
		String currentUri = req.getRequestURI();
		String queryString = req.getQueryString();

		System.out.println(currentUri);
		System.out.println(queryString);

		if (currentUri != null && queryString != null) {
			currentUri += "?" + queryString;
		}

		return currentUri;
	}
	public String getEncodedCurrentUri() {
		return Ut.getEncodedCurrentUri(getCurrentUri());
	}

	public String getLoginUri() {
		return "../member/login?afterLoginUri=" + getAfterLoginUri();
	}

	private String getAfterLoginUri() {
		return getEncodedCurrentUri();
	}

	public String getFindLoginIdUri() {
		return "../member/findLoginId?afterFindLoginIdUri=" + getAfterFindLoginIdUri();
	}

	private String getAfterFindLoginIdUri() {
		return getEncodedCurrentUri();
	}

	public String getFindLoginPwUri() {
		return "../member/findLoginPw?afterFindLoginPwUri=" + getAfterFindLoginPwUri();
	}

	private String getAfterFindLoginPwUri() {
		return getEncodedCurrentUri();
	}
}
