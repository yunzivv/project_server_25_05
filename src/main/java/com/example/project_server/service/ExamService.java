package com.example.project_server.service;

import com.example.project_server.repository.ExamRepository;
import com.example.project_server.util.Ut;
import com.example.project_server.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ExamService {

	@Autowired
	private ExamRepository examRepository;
    @Autowired
    private CertificateService certificateService;

	public ExamService(ExamRepository examRepository) {
		this.examRepository = examRepository;
	}

	public List<Certificate> getExamCertNames() {
		return examRepository.getExamCertNames();
	}

	public List<Exam> getExams() {
		return examRepository.getExams();
	}

	public List<Question> getQuestionsByExamId(int examId) {
		return examRepository.getQuestionsByExamId(examId);
	}

	public ResultData getExamByCertId(Certificate certificate) {

		List<Exam> exams = examRepository.getExamByCertId(certificate.getId());

		return ResultData.from("S-1", "특정 자격증 시험 가져오기 성공",
				Ut.f("%s 자격증 시험", certificate.getName()), exams);
	}

	public List<Question> getRandomQuestionsByCertId(int certId, int questionCount) {
		return examRepository.getRandomQuestionsByCertId(certId, questionCount);
	}

	public List<Exam> getAutoCompleteExams(String keyword) {
		return examRepository.getAutoCompleteExams(keyword);
	}
}
