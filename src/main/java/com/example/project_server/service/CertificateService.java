package com.example.project_server.service;

import com.example.project_server.repository.BoardRepository;
import com.example.project_server.repository.CertificateRepository;
import com.example.project_server.vo.Certificate;
import com.example.project_server.vo.JobCat;
import com.example.project_server.vo.JobCode;
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

    public List<Certificate> getCertRankByCode(int jobCodeId) {
		return certificateRepository.getCertRankByCode(jobCodeId);
    }

	public List<JobCat> getJobCats() {
		return certificateRepository.getJobCats();
	}

	public List<JobCode> getJobCodes(int jobCatId) {
		return certificateRepository.getJobCodes(jobCatId);
	}
}
