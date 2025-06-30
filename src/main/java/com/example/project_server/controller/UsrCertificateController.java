package com.example.project_server.controller;

import com.example.project_server.util.Ut;
import com.example.project_server.vo.*;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.ui.Model;
import com.example.project_server.service.CertificateService;
import com.example.project_server.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
public class UsrCertificateController {

    @Autowired
    private Rq rq;

    @Autowired
    private CertificateService certificateService;

    @RequestMapping("/usr/cert/analysis")
    public String showAnalysis(Model model, @RequestParam(defaultValue = "0") int jobCatId,
                               @RequestParam(defaultValue = "0") int jobCodeId) throws JsonProcessingException {

        ObjectMapper mapper = new ObjectMapper();
        mapper.registerModule(new JavaTimeModule());
        mapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS); // optional

        List<JobCat> jobCats = certificateService.getJobCats();

        List<Certificate> certMentionRank = (List<Certificate>) certificateService.getCertRank(jobCatId, jobCodeId).getData3();
        List<JobCat> jobCatMentionRank = certificateService.getJobCatMentionRank();
        List<Map<String, Object>> certTypeRank = (List<Map<String, Object>>) certificateService.getCertTypeRank(0, 0);

        int certTypes = certificateService.getCertTypesAtMention();

        List<Integer> topCertCounts = certMentionRank.stream()
                .map(Certificate::getExtra__certCount)
                .collect(Collectors.toList());
        List<String> topCertNames = certMentionRank.stream()
                .map(Certificate::getName)
                .collect(Collectors.toList());

        List<Integer> topJobCatCounts = jobCatMentionRank.stream()
                .map(JobCat::getExtra__jobCatMentionCount)
                .collect(Collectors.toList());
        List<String> topJobCatNames = jobCatMentionRank.stream()
                .map(JobCat::getName)
                .collect(Collectors.toList());

        // 자격증 분류 랭킹
        Map<Integer, String> certTypeLabelMap = new HashMap<>();
        certTypeLabelMap.put(1, "국가자격");
        certTypeLabelMap.put(0, "국가공인 민간자격");
        certTypeLabelMap.put(-1, "민간자격");
        certTypeLabelMap.put(null, "기타");

        List<String> certTypeRankLabels = certTypeRank.stream()
                .map(row -> {
                    Integer type = row.get("extra__certType") != null
                            ? ((Number) row.get("extra__certType")).intValue()
                            : null;
                    return certTypeLabelMap.getOrDefault(type, "기타");
                })
                .collect(Collectors.toList());
        List<Integer> certTypeRankValues = certTypeRank.stream()
                .map(row -> ((Number) row.get("extra__certCountByType")).intValue())
                .collect(Collectors.toList());


        // 직무 카테고리
        model.addAttribute("jobCats", jobCats);

        // 자격증 언급 랭킹 labels: 자격증명 values: 언급 수
        model.addAttribute("topCertLabels", mapper.writeValueAsString(topCertNames));
        model.addAttribute("topCertValues", mapper.writeValueAsString(topCertCounts));

        // 직무 카테고리 언급 랭킹 labels: 카테고리명 values: 언급 수
        model.addAttribute("topJobCatLabels", mapper.writeValueAsString(topJobCatNames));
        model.addAttribute("topJobCatValues", mapper.writeValueAsString(topJobCatCounts));

        // 자격증 분류 순위
        model.addAttribute("certTypeRankLabels", mapper.writeValueAsString(certTypeRankLabels));
        model.addAttribute("certTypeRankValues", mapper.writeValueAsString(certTypeRankValues));

        model.addAttribute("totalPosts", 248780);
        model.addAttribute("postCount", certificateService.getPostCount(0, 0));
        model.addAttribute("certCount", certificateService.getCertCount(0, 0));
        model.addAttribute("mentionCount", certificateService.getMentionCount(0, 0));

        model.addAttribute("certTypes", certTypes);

        return "/usr/cert/analysis";
    }

    @GetMapping("/usr/api/jobCodes")
    @ResponseBody
    public ResultData getJobCodesByCat(int jobCatId) {

        if (jobCatId == 0) return null;
        return certificateService.getJobCodes(jobCatId);
    }

    @GetMapping("/usr/api/certRankByJobCode")
    @ResponseBody
    public ResultData getCertRankByCode(int jobCatId, int jobCodeId) {

        return certificateService.getCertRank(jobCatId, jobCodeId);
    }

    @RequestMapping("/usr/cert/library")
    public String showLibrary() {
        return "/usr/cert/library";
    }


    @RequestMapping("/usr/cert/doAdd")
    @ResponseBody
    public String doAdd(HttpServletRequest req, @RequestParam(defaultValue = "0") int certId, String certName, LocalDate startDate, LocalDate endDate, String certificateNumber) {

        Rq rq = (Rq) req.getAttribute("rq");

        if (Ut.isEmpty(certName))
            return Ut.jsHistoryBack("F-1", "자격증명을 입력하세요.");

        certificateService.doAdd(rq.getLoginedMemberId(), certName, certId, startDate, endDate, certificateNumber);
        return Ut.jsSucceseReplace("S-1", "자격증 등록이 완료되었습니다.", "../member/myCert");
    }

    @RequestMapping("/usr/cert/doDelete")
    @ResponseBody
    public String doDelete(HttpServletRequest req, int id) {

        Rq rq = (Rq) req.getAttribute("rq");

        MemberCert memberCert = certificateService.getMemberCertById(id);

        if (memberCert == null) {
            return Ut.jsHistoryBack("F-1", Ut.f("%d번 회원 자격증은 등록되지 않았습니다.", id));
        }

        if (memberCert.getMemberId() != rq.getLoginedMemberId()) {
            System.out.println(memberCert.getMemberId());
            System.out.println(rq.getLoginedMemberId());
            return Ut.jsHistoryBack("F-A", Ut.f("%d번 회원 자격증 대한 권한이 없습니다.", id));
        }

        certificateService.deleteMemberCert(id);

        return Ut.jsSucceseReplace("S-1", "등록된 회원 자격증 삭제 성공", "../member/myCert");
    }


    @RequestMapping("/usr/cert/autoComplete")
    @ResponseBody
    public List<Certificate> autoComplete(HttpServletRequest req, String keyword) {

        List<Certificate> autoCompleteCerts = certificateService.getAutoCompleteCerts(keyword);

        return autoCompleteCerts;
    }
}
