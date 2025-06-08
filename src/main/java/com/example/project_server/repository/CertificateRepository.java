package com.example.project_server.repository;

import com.example.project_server.vo.Certificate;
import com.example.project_server.vo.JobCat;
import com.example.project_server.vo.JobCode;
import com.example.project_server.vo.MemberCert;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CertificateRepository {

    public List<Certificate> getCertRank(int jobCatId, int jobCodeId);

    public List<JobCat> getJobCats();

    public List<JobCode> getJobCodes(int jobCatId);

    public JobCat getJobCatByCodeId(int jobCodeId);

    public JobCode getJobCodeById(int jobCodeId);

    public JobCat getJobCatById(int jobCatId);

    public List<MemberCert> getMemberCerts(int loginedMemberId);

    public int getPostCount(int jobCatId, int jobCodeId);

    public int getCertCount(int jobCatId, int jobCodeId);

    public int getMentionCount(int jobCatId, int jobCodeId);
}
