package com.example.project_server.repository;

import org.apache.ibatis.annotations.Mapper;

import com.example.project_server.vo.Member;

import java.time.LocalDate;

@Mapper
public interface MemberRepository {

    public int doJoin(String loginId, String loginPw, String name, LocalDate birthday, String nickName, String cellPhone, String email);

    public int getLastInsertId();

    public Member getMemberById(int id);

    public int getMemberByLogInId(String loginId);

    public int isExistsNameNEmail(String name, String email);

    public Member getMemberByLoginId(String loginId);

    public int modifyMember(int loginedMemberId, String loginId, String loginPw, String name, String nickName, String cellPhone, String email);

    public Member getMemberByNameAndEmail(String name, String email);

}
