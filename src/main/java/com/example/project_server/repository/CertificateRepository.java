package com.example.project_server.repository;

import com.example.project_server.vo.Certificate;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CertificateRepository {

    List<Certificate> getCertRanking(int jobCode);
}
