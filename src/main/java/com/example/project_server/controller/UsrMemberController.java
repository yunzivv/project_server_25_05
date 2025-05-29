package com.example.project_server.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.project_server.service.MemberService;
import com.example.project_server.util.Ut;
import com.example.project_server.vo.Member;
import com.example.project_server.vo.ResultData;
import com.example.project_server.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrMemberController {

	@Autowired
	private Rq rq;

	@Autowired
	private MemberService memberService;


}
