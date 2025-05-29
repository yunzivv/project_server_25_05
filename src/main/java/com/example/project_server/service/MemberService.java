package com.example.project_server.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.project_server.repository.MemberRepository;
import com.example.project_server.util.Ut;
import com.example.project_server.vo.Member;
import com.example.project_server.vo.ResultData;

@Service
public class MemberService {

	@Autowired
	private MemberRepository memberRepository;

	public MemberService(MemberRepository memberRepository) {
		this.memberRepository = memberRepository;
	}


}
