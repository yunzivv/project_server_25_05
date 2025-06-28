package com.example.project_server.service;

import com.example.project_server.repository.ExamRepository;
import com.example.project_server.util.Ut;
import com.example.project_server.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

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

    public static Map<String, List<Certificate>> groupCertsByInitial(List<Certificate> certs) {
        Map<String, List<Certificate>> grouped = new TreeMap<>();

        for (Certificate cert : certs) {
            String name = cert.getName();
            if (name == null || name.isEmpty()) continue;

            char firstChar = name.charAt(0);
            String key;

            // 1. 한글이면 초성으로
            if (isKorean(firstChar)) {
                key = getKoreanInitial(firstChar);
            }
            // 2. 숫자면 "0-9"
            else if (Character.isDigit(firstChar)) {
                key = "0-9";
            }
            // 3. 영문이면 대문자로 정규화
            else if ((firstChar >= 'A' && firstChar <= 'Z') || (firstChar >= 'a' && firstChar <= 'z')) {
                key = String.valueOf(Character.toUpperCase(firstChar));
            }
            // 4. 기타 문자는 "#"으로
            else {
                key = "#";
            }

            grouped.computeIfAbsent(key, k -> new ArrayList<>()).add(cert);
        }

        return grouped;
    }

    // 초성 추출: 한글 자모 범위 → 초성 테이블에서 인덱스 추출
    private static String getKoreanInitial(char ch) {
        final char[] INITIAL_SOUNDS = {
                'ㄱ', 'ㄲ', 'ㄴ', 'ㄷ', 'ㄸ',
                'ㄹ', 'ㅁ', 'ㅂ', 'ㅃ', 'ㅅ',
                'ㅆ', 'ㅇ', 'ㅈ', 'ㅉ', 'ㅊ',
                'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ'
        };

        int unicode = ch - 0xAC00;
        if (unicode < 0 || unicode > 11172) return "#";

        int initialIndex = unicode / (21 * 28);
        return String.valueOf(INITIAL_SOUNDS[initialIndex]);
    }

    // 한글 여부 판별
    private static boolean isKorean(char ch) {
        return (ch >= 0xAC00 && ch <= 0xD7A3);
    }

    public void doRecord(int loginedMemberId, int certId, int examId, LocalTime elapsedTime, int totalQuest, int correctQuest) {

        examRepository.insertMemberExam(
                MemberExam.builder()
                        .memberId(loginedMemberId)
                        .certId(certId)
                        .examId(examId != 0 ? examId : null)
                        .elapsedTime(elapsedTime)
                        .totalQuest(totalQuest)
                        .correctQuest(correctQuest)
                        .build()
        );
    }

    public List<MemberExam> getMemberExamByMemberId(int loginedMemberId) {
        return examRepository.getMemberExamByMemberId(loginedMemberId);
    }
}
