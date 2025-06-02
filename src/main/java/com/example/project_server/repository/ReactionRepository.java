package com.example.project_server.repository;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReactionRepository {

    int getUserReaction(int loginedMemberId, int id, String relTypeCode);

    int getIsReactioned(int loginedMemberId, int id, String relTypeCode);
}
