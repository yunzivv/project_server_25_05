package com.example.project_server.repository;

import com.example.project_server.vo.Certificate;
import com.example.project_server.vo.JobCat;
import com.example.project_server.vo.JobCode;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CertificateRepository {

    List<Certificate> getCertRankByCode(int jobCodeId);

    List<JobCat> getJobCats();

    List<JobCode> getJobCodes(int jobCatId);
}
