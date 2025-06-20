package com.example.project_server.controller;

import com.example.project_server.service.CertificateService;
import com.example.project_server.service.ExamService;
import com.example.project_server.vo.Certificate;
import com.example.project_server.vo.Exam;
import com.example.project_server.vo.Rq;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
public class UsrExamController {

    @Autowired
    private Rq rq;

    @Autowired
    private ExamService examService;

    @RequestMapping("/usr/workbook/showWorkbook")
    public String showWorkbook(Model model) {

        List<Certificate> examCertNames = examService.getExamCertNames(); // 기출문제 있는 자격증명
        List<Exam> exams = examService.getExams();

        model.addAttribute("examCertNames", examCertNames);
        model.addAttribute("exams", exams);

        return "/usr/cert/workbook";
    }

    @RequestMapping("/usr/workbook/showExam")
    public String showExam (Model model, int certId, String mode, int questionCount) {

        List<Certificate> examCertNames = examService.getExamCertNames();
        List<Exam> exams = examService.getExams();

        model.addAttribute("examCertNames", examCertNames);
        model.addAttribute("exams", exams);

        return "/usr/cert/exam";
    }
}
