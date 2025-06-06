package com.example.project_server.repository;

import org.apache.ibatis.annotations.Mapper;

import com.example.project_server.vo.Member;

@Mapper
public interface MemberRepository {

    public int doJoin(String loginId, String loginPw, String name, String nickName, String cellPhone, String email);

//    public void doLogin(int id);

    public int getLastInsertId();

    public Member getMemberById(int id);

    public int isJoinableLogInId(String loginId);

    public int isExistsNameNEmail(String name, String email);

    public Member getMemberByLoginId(String loginId);

    public int modifyMember(int loginedMemberId, String loginId, String loginPw, String name, String nickName, String cellPhone, String email);
}
