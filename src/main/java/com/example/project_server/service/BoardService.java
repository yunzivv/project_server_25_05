package com.example.project_server.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.project_server.repository.BoardRepository;
import com.example.project_server.vo.Board;

@Service
public class BoardService {

	@Autowired
	private BoardRepository boardRepository;

	public BoardService(BoardRepository boardRepository) {
		this.boardRepository = boardRepository;
	}

}
