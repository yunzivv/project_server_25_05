package com.example.project_server.service;

import com.example.project_server.repository.CertificateRepository;
import com.example.project_server.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Service
public class CertificateService {

    @Autowired
    private CertificateRepository certificateRepository;

    public CertificateService(CertificateRepository certificateRepository) {
        this.certificateRepository = certificateRepository;
    }

    public List<JobCat> getJobCats() {
        return certificateRepository.getJobCats();
    }

    public ResultData getJobCodes(int jobCatId) {

        JobCat jobCat = certificateRepository.getJobCatById(jobCatId);
        return ResultData.from("S-1", jobCat.getName(), " 분야 직무 코드",
                certificateRepository.getJobCodes(jobCatId));
    }

    public List<MemberCert> getMemberCerts(int loginedMemberId) {
        return certificateRepository.getMemberCerts(loginedMemberId);
    }

    public ResultData getCertRank(int jobCatId, int jobCodeId) {

        JobCat jobCat = (jobCatId != 0) ? certificateRepository.getJobCatById(jobCatId) : null;
        JobCode jobCode = (jobCodeId != 0) ? certificateRepository.getJobCodeById(jobCodeId) : null;

        if (jobCat == null) {
            jobCat = new JobCat();
            jobCat.setId(0);
            jobCat.setName("전체");
        }
        if (jobCode == null) {
            jobCode = new JobCode();
            jobCode.setId(0);
            jobCode.setName("전체");
            jobCode.setJobCatId(jobCat.getId());
            jobCode.setJobCatName(jobCat.getName());
        }

        List<Certificate> certRank = certificateRepository.getCertRank(jobCatId, jobCodeId);
        List<Map<String, Object>> certTypeRank= getCertTypeRank(jobCatId, jobCodeId);

        return ResultData.from("S-1", "직무 카테고리 > 코드 자격증 언급, 분류 랭킹 가져오기 성공",
                "직무 카테고리", jobCat.getName(), "직무 코드", jobCode.getName(), 
                "자격증 언급 랭킹", certRank, "자격증 분류 랭킹", certTypeRank);

    }

    public int getPostCount(int jobCatId, int jobCodeId) {
        return certificateRepository.getPostCount(jobCatId, jobCodeId);
    }

    public int getCertCount(int jobCatId, int jobCodeId) {
        return certificateRepository.getCertCount(jobCatId, jobCodeId);
    }

    public int getMentionCount(int jobCatId, int jobCodeId) {
        return certificateRepository.getMentionCount(jobCatId, jobCodeId);
    }

    public Certificate getCertByName(String certname) {
        return certificateRepository.getCertByName(certname);
    }

    public void doAdd(int memberId, String certname, int certid, LocalDate startDate, LocalDate endDate, String certificateNumber) {
        certificateRepository.doAdd(memberId, certname, certid, startDate, endDate, certificateNumber);
    }

    public List<Certificate> getAutoCompleteCerts(String keyword) {
        return certificateRepository.getAutoCompleteCerts(keyword);
    }

    public List<JobCat> getJobCatMentionRank() {
        return certificateRepository.getJobCatMentionRank();
    }

    public Certificate getCertById(int certId) {
        return certificateRepository.getCertById(certId);
    }

    public MemberCert getMemberCertById(int id) {
        return certificateRepository.getMemberCertById(id);
    }

    public void deleteMemberCert(int id) {
        certificateRepository.deleteMemberCert(id);
    }

    public List<Map<String, Object>> getCertTypeRank(int jobCatId, int jobCodeId) {
        return certificateRepository.getCertTypeRank(jobCatId, jobCodeId);
    }

    public void doChangAlertModeCert(int memberCertId) {
        certificateRepository.doChangAlertModeCert(memberCertId);
    }

    public List<Certificate> getExamCertById(Set<Integer> certIdsWithExam) {
        return certificateRepository.getExamCertById(certIdsWithExam);
    }

    public int getCertTypesAtMention() {
        return certificateRepository.getCertTypesAtMention();
    }
}
