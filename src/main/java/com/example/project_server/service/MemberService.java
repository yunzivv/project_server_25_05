package com.example.project_server.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.example.project_server.repository.MemberRepository;
import com.example.project_server.util.Ut;
import com.example.project_server.vo.Member;
import com.example.project_server.vo.ResultData;

import java.time.LocalDate;

@Service
public class MemberService {

	@Value("${custom.siteMainUri}")
	private String siteMainUri;
	@Value("${custom.siteName}")
	private String siteName;

	@Autowired
	private MemberRepository memberRepository;
	@Autowired
	private MailService mailService;

	public MemberService(MemberRepository memberRepository) {
		this.memberRepository = memberRepository;
	}

	public Member getMemberById(int id) {

		return memberRepository.getMemberById(id);
	}

	public int doJoin(String loginId, String loginPw, String name, LocalDate birthday, String nickName, String cellPhone, String email) {

		if(memberRepository.isJoinableLogInId(loginId) == 1) return -1; // 중복 아이디
		if(memberRepository.isExistsNameNEmail(name, email) == 1) return -2; // 중복 이름, 이메일

		memberRepository.doJoin(loginId, loginPw, name, birthday, nickName, cellPhone, email);
		return memberRepository.getLastInsertId(); // 방금 가입된 멤버의 id 반환
	}

	public Member getMemberByLoginId(String loginId) {

		return memberRepository.getMemberByLoginId(loginId);
	}

	public int modifyMember(int loginedMemberId, String loginId, String loginPw, String name, String nickName, String cellPhone, String email) {
		return memberRepository.modifyMember(loginedMemberId, loginId, loginPw, name, nickName, cellPhone, email);
	}

	public boolean isUsableLoginId(String loginId) {
		return memberRepository.isJoinableLogInId(loginId) != 1;
	}

	public ResultData notifyTempLoginPwByEmail(Member actor) {
		String title = "[" + siteName + "] 임시 패스워드 발송";
		String tempPassword = Ut.getTempPassword(6);
		String body = "<h1>임시 패스워드 : " + tempPassword + "</h1>";
		body += "<a href=\"" + siteMainUri + "/usr/member/login\" target=\"_blank\">로그인 하러가기</a>";

		ResultData sendResultData = mailService.send(actor.getEmail(), title, body);

		if (sendResultData.isFail()) {
			return sendResultData;
		}

		setTempPassword(actor, tempPassword);

		return ResultData.from("S-1", "계정의 이메일주소로 임시 패스워드가 발송되었습니다.");
	}

	private void setTempPassword(Member actor, String tempPassword) {
		memberRepository.modifyMember(actor.getId(), Ut.sha256(tempPassword), null, null, null, null, null);
	}
}
