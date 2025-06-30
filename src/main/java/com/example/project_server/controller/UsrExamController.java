package com.example.project_server.controller;

import com.example.project_server.service.CertificateService;
import com.example.project_server.service.ExamService;
import com.example.project_server.vo.*;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.time.LocalTime;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Controller
public class UsrExamController {

    @Autowired
    private Rq rq;

    @Autowired
    private ExamService examService;

    @Autowired
    private CertificateService certificateService;

    @RequestMapping("/usr/workbook/showWorkbook")
    public String showWorkbook(Model model, HttpServletRequest req) {

        Rq rq = (Rq) req.getAttribute("rq");
        List<Certificate> examCertNames = examService.getExamCertNames(); // 기출문제 있는 자격증명
        List<Exam> exams = examService.getExams();

        Set<Integer> certIdsWithExam = exams.stream()
                .map(Exam::getCertId)
                .collect(Collectors.toSet());

        List<Certificate> certs = certificateService.getExamCertById(certIdsWithExam);

        Map<String, List<Certificate>> certIndexMap = examService.groupCertsByInitial(certs);
        model.addAttribute("certIndexMap", certIndexMap);

        model.addAttribute("loginedMemberId", rq.getLoginedMemberId());
        model.addAttribute("examCertNames", examCertNames);
        model.addAttribute("exams", exams);
        model.addAttribute("loginUri", rq.getLoginUri());

        return "/usr/cert/workbook";
    }

    @RequestMapping("/usr/workbook/autoComplete")
    @ResponseBody
    public List<Exam> autoComplete(HttpServletRequest req, String keyword) {

        List<Exam> autoCompleteExams = examService.getAutoCompleteExams(keyword);

        return autoCompleteExams;
    }

    @GetMapping("/usr/api/examByCertId")
    @ResponseBody
    public ResultData getExamByCertId(int certId) {

        Certificate certificate = certificateService.getCertById(certId);
        return examService.getExamByCertId(certificate);
    }

    @RequestMapping("/usr/workbook/showExam")
    public String showExam (Model model, @RequestParam(defaultValue = "0")int examId, @RequestParam(defaultValue = "0")int certId,
                            String mode, @RequestParam(defaultValue = "100")int questionCount) {

        List<Question> questions;
        if(mode.equals("random")) {
            questions = examService.getRandomQuestionsByCertId(certId, questionCount);
        }else if(mode.equals("past")) {
            questions = examService.getQuestionsByExamId(examId);
        }else {
            questions = null;
            System.out.println("UsrExamController showExam 실패");
        }

        Certificate certificate = certificateService.getCertById(certId);

        model.addAttribute("examId", examId);
        model.addAttribute("questions", questions);
        model.addAttribute("certificate", certificate);

        return "/usr/cert/exam";
    }

    @RequestMapping("/usr/workbook/doRecord")
    @ResponseBody
    public void doRecord(HttpServletRequest req, int certId, @RequestParam(defaultValue = "0")int examId, LocalTime elapsedTime,
                         int totalQuest, int correctQuest) {

        Rq rq = (Rq) req.getAttribute("rq");
        int loginedMemberId = rq.getLoginedMemberId();

        if(examId == -1){
            examId = 0; // 랜덤 문제 풀이 시 시험ID 0처리
        }

        examService.doRecord(loginedMemberId, certId, examId, elapsedTime, totalQuest, correctQuest);
    }
}
