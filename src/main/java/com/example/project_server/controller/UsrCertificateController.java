package com.example.project_server.controller;

import org.springframework.ui.Model;
import com.example.project_server.service.CertificateService;
import com.example.project_server.service.MemberService;
import com.example.project_server.vo.Certificate;
import com.example.project_server.vo.Rq;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class UsrCertificateController {

	@Autowired
	private Rq rq;

	@Autowired
	private CertificateService certicateService;

	@RequestMapping("/usr/cert/analysis")
	public String showAnalysis(Model model, @RequestParam(defaultValue = "0")int jobCode) {

		List<Certificate> certRanking = certicateService.getCertRanking(jobCode);
		model.addAttribute("certRanking", certRanking);
		model.addAttribute("certRankingSize", Math.min(certRanking.size(), 10));

		return "/usr/cert/analysis";
	}

	@RequestMapping("/usr/cert/library")
	public String showLibrary() {
		return "/usr/cert/library";
	}

	@RequestMapping("/usr/cert/workbook")
	public String showWorkbook() {
		return "/usr/cert/workbook";
	}
}
