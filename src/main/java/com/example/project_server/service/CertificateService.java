package com.example.project_server.service;

import com.example.project_server.repository.BoardRepository;
import com.example.project_server.repository.CertificateRepository;
import com.example.project_server.vo.Certificate;
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

    public List<Certificate> getCertRanking(int jobCode) {
		return certificateRepository.getCertRanking(jobCode);
    }
}
