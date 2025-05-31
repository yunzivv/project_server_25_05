package com.example.project_server.controller;

import com.example.project_server.service.CertificateService;
import com.example.project_server.service.MemberService;
import com.example.project_server.vo.Rq;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UsrCertificateController {

	@Autowired
	private Rq rq;

	@Autowired
	private CertificateService certicateService;

	@RequestMapping("/usr/cert/analysis")
	public String showAnalysis() {
		return "/usr/cert/analysis";
	}

}
