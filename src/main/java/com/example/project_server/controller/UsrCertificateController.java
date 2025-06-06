package com.example.project_server.controller;

import com.example.project_server.vo.*;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.ui.Model;
import com.example.project_server.service.CertificateService;
import com.example.project_server.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
		ResultData certRanking = certificateService.getCertRankByCode(jobCodeId);
		List<Certificate> certList = (List<Certificate>)certRanking.getData3();

		int[] count = new int[10];
		List<String> certNames = new ArrayList<>();

		int index = 0;
		for(Certificate cert : certList) {
			count[index++] = cert.getExtra__certCount();
			certNames.add(cert.getName());
		}

		ObjectMapper mapper = new ObjectMapper();

		String valuesJson = mapper.writeValueAsString(count);
		String labelsJson = mapper.writeValueAsString(certNames);

		model.addAttribute("values", valuesJson);
		model.addAttribute("labels", labelsJson);

		model.addAttribute("jobCats", jobCats);
		model.addAttribute("jobCodes", jobCodes);

		model.addAttribute("certRanking", certList);
		model.addAttribute("certRankingSize", Math.min(certList.size(), 10));

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
	public ResultData getCertRankByCode(int jobCodeId) {

		if(jobCodeId == 0) return null;
		return certificateService.getCertRankByCode(jobCodeId);
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
