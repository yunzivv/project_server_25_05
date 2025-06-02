package com.example.project_server.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.project_server.service.ArticleService;
import com.example.project_server.service.ReactionService;
import com.example.project_server.vo.ResultData;
import com.example.project_server.vo.Rq;

@Controller
public class UsrReactionController {

	@Autowired
	private Rq rq;

	@Autowired
	private ReactionService reactionPointService;

	@Autowired
	private ArticleService articleService;


}
