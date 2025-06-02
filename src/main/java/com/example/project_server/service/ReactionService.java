package com.example.project_server.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.project_server.repository.ReactionRepository;

@Service
public class ReactionService {

	@Autowired
	private ArticleService articleService;

	@Autowired
	private ReactionRepository reactionPointRepository;

	public ReactionService(ReactionRepository reactionPointRepository) {
		this.reactionPointRepository = reactionPointRepository;
	}


}