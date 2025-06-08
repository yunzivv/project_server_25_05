package com.example.project_server.service;

import com.example.project_server.repository.CertificateRepository;
import com.example.project_server.vo.*;
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

	public ResultData getJobCodes(int jobCatId) {

		JobCat jobCat = certificateRepository.getJobCatById(jobCatId);
		return ResultData.from("S-1", jobCat.getName()," 분야 직무 코드",
				certificateRepository.getJobCodes(jobCatId));
	}

	public List<MemberCert> getMemberCerts(int loginedMemberId) {
		return certificateRepository.getMemberCerts(loginedMemberId);
	}

	public ResultData getCertRank(int jobCatId, int jobCodeId) {

		JobCat jobCat = (jobCatId != 0) ? certificateRepository.getJobCatById(jobCatId) : null;
		JobCode jobCode = (jobCodeId != 0) ? certificateRepository.getJobCodeById(jobCodeId) : null;

		if(jobCat == null){
			jobCat  = new JobCat();
			jobCat.setId(0);
			jobCat.setName("전체");
		}
		if(jobCode == null){
			jobCode = new JobCode();
			jobCode.setId(0);
			jobCode.setName("전체");
			jobCode.setJobCatId(jobCat.getId());
			jobCode.setJobCatName(jobCat.getName());
		}


		List<Certificate> certRank = certificateRepository.getCertRank(jobCatId, jobCodeId);

		return ResultData.from("S-2", "직무 카테고리 > 코드 자격증 언급 랭킹 가져오기 성공",
				"직무 카테고리", jobCat.getName(), "직무 코드", jobCode.getName(), "언급 랭킹", certRank);

	}

	public int getPostCount(int jobCatId, int jobCodeId) {
		return certificateRepository.getPostCount(jobCatId, jobCodeId);
	}

	public int getCertCount(int jobCatId, int jobCodeId) {
		return certificateRepository.getCertCount(jobCatId, jobCodeId);
	}

	public int getMentionCount(int jobCatId, int jobCodeId) {
		return certificateRepository.getMentionCount(jobCatId, jobCodeId);
	}
}
