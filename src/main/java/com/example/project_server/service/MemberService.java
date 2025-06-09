package com.example.project_server.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.project_server.repository.MemberRepository;
import com.example.project_server.util.Ut;
import com.example.project_server.vo.Member;
import com.example.project_server.vo.ResultData;

import java.time.LocalDate;

@Service
public class MemberService {

	@Autowired
	private MemberRepository memberRepository;

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


}
