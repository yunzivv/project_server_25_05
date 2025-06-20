package com.example.project_server.repository;

import com.example.project_server.vo.Certificate;
import com.example.project_server.vo.Exam;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ExamRepository {


    public List<Exam> getExams();

    public List<Certificate> getExamCertNames();
}
