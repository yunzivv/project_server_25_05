package com.example.project_server.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.project_server.repository.ReactionPointRepository;
import com.example.project_server.vo.ResultData;

@Service
public class ReactionService {

	@Autowired
	private ArticleService articleService;

	@Autowired
	private ReactionPointRepository reactionPointRepository;

	public ReactionService(ReactionPointRepository reactionPointRepository) {
		this.reactionPointRepository = reactionPointRepository;
	}


}