package com.example.project_server.controller;

import com.example.project_server.util.Ut;
import com.example.project_server.vo.*;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.ui.Model;
import com.example.project_server.service.CertificateService;
import com.example.project_server.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Controller
public class UsrCertificateController {

	@Autowired
	private Rq rq;

	@Autowired
	private CertificateService certificateService;

	@RequestMapping("/usr/cert/analysis")
	public String showAnalysis(Model model, @RequestParam(defaultValue = "0")int jobCatId,
							   @RequestParam(defaultValue = "0")int jobCodeId) throws JsonProcessingException {

		List<JobCat> jobCats = certificateService.getJobCats();
		ResultData jobCodes = null;
		if(jobCatId != 0) {
			jobCodes = certificateService.getJobCodes(jobCatId);
		}
		ResultData certRanking = certificateService.getCertRank(jobCatId, jobCodeId);
		List<Certificate> certsRanking = (List<Certificate>)certRanking.getData3();

		int[] count = new int[10];
		List<String> certNames = new ArrayList<>();

		int index = 0;
		for(Certificate cert : certsRanking) {
			count[index++] = cert.getExtra__certCount();
			certNames.add(cert.getName());
		}

		ObjectMapper mapper = new ObjectMapper();

		String valuesJson = mapper.writeValueAsString(count);
		String labelsJson = mapper.writeValueAsString(certNames);

		// 자격증 랭킹 labels: 자격증명 values: 언급 수
		model.addAttribute("labels", labelsJson);
		model.addAttribute("values", valuesJson);

		// 직무 카테고리
		model.addAttribute("jobCats", jobCats);

		model.addAttribute("totalPosts", 31256);
		model.addAttribute("postCount", certificateService.getPostCount(0, 0));
		model.addAttribute("certCount", certificateService.getCertCount(0, 0));
		model.addAttribute("mentionCount", certificateService.getMentionCount(0, 0));

		return "/usr/cert/analysis";
	}

	@GetMapping("/usr/api/jobCodes")
	@ResponseBody
	public ResultData getJobCodesByCat(int jobCatId) {

		if(jobCatId == 0) return null;
		return certificateService.getJobCodes(jobCatId);
	}

	@GetMapping("/usr/api/certRankByJobCode")
	@ResponseBody
	public ResultData getCertRankByCode(int jobCatId ,int jobCodeId) {

		return certificateService.getCertRank(jobCatId, jobCodeId);
	}

	@RequestMapping("/usr/cert/library")
	public String showLibrary() {
		return "/usr/cert/library";
	}

	@RequestMapping("/usr/cert/workbook")
	public String showWorkbook() {
		return "/usr/cert/workbook";
	}

	@RequestMapping("/usr/cert/doAdd")
	@ResponseBody
	public String doAdd(HttpServletRequest req, String certname, LocalDate startDate, LocalDate endDate, String certificateNumber) {

		Rq rq = (Rq) req.getAttribute("rq");

		if (Ut.isEmpty(certname))
			return Ut.jsHistoryBack("F-1", "자격증명을 입력하세요.");

		Certificate certificate = certificateService.getCertByName(certname);
		if(certificate == null) {
			certificate = new Certificate();
			certificate.setId(0);
		}

		certificateService.doAdd(rq.getLoginedMemberId(), certname, certificate.getId(), startDate, endDate, certificateNumber);
		return null;
	}
}
