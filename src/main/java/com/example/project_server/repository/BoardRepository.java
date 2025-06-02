package com.example.project_server.repository;

import org.apache.ibatis.annotations.Mapper;

import com.example.project_server.vo.Board;

@Mapper
public interface BoardRepository {

    public Board getBoardById(int id);

}
