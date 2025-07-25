package com.example.project_server.repository;

import com.example.project_server.vo.Certificate;
import com.example.project_server.vo.Exam;
import com.example.project_server.vo.MemberExam;
import com.example.project_server.vo.Question;
import org.apache.ibatis.annotations.Mapper;

import java.time.LocalTime;
import java.util.List;

@Mapper
public interface ExamRepository {


    public List<Exam> getExams();

    public List<Certificate> getExamCertNames();

    public List<Question> getQuestionsByExamId(int examId);

    public List<Question> getRandomQuestionsByCertId(int certId, int questionCount);

    public List<Exam> getExamByCertId(int certId);

    public List<Exam> getAutoCompleteExams(String keyword);

    public void insertMemberExam(MemberExam memberExam);

    public List<MemberExam> getMemberExamByMemberId(int loginedMemberId);
}
