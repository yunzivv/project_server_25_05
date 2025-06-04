package com.example.project_server.service;

import com.example.project_server.repository.BoardRepository;
import com.example.project_server.repository.CertificateRepository;
import com.example.project_server.vo.Certificate;
import com.example.project_server.vo.JobCat;
import com.example.project_server.vo.JobCode;
import com.example.project_server.vo.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CertificateService {

	@Autowired
	private CertificateRepository certificateRepository;

	public CertificateService(CertificateRepository certificateRepository) {
		this.certificateRepository = certificateRepository;
	}

	public List<JobCat> getJobCats() {
		return certificateRepository.getJobCats();
	}


//	public List<JobCode> getJobCodes(int jobCatId) {
//
//		return certificateRepository.getJobCodes(jobCatId);
//	}
	public ResultData getJobCodes(int jobCatId) {

		String jobCatName =  certificateRepository.getJobCatNameById(jobCatId);
		return ResultData.from("S-1", jobCatName," 분야 직무 코드",
				certificateRepository.getJobCodes(jobCatId));
	}

	public ResultData getCertRankByCode(int jobCodeId) {

		String jobCodeName = certificateRepository.getJobCodeNameById(jobCodeId);
		return ResultData.from("S-1", jobCodeName," 직무 자격증 언급 랭킹",
				certificateRepository.getCertRankByCode(jobCodeId));
	}
}
