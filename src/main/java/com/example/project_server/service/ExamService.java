package com.example.project_server.service;

import com.example.project_server.repository.ExamRepository;
import com.example.project_server.vo.Certificate;
import com.example.project_server.vo.Exam;
import com.example.project_server.vo.Question;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ExamService {

	@Autowired
	private ExamRepository examRepository;

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

	public List<Question> getRandomQuestionsByCertId(int certId, int questionCount) {
		return examRepository.getRandomQuestionsByCertId(certId, questionCount);
	}
}
