package com.example.project_server.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.project_server.interceptor.BeforeActionInterceptor;
import com.example.project_server.service.ArticleService;
import com.example.project_server.service.BoardService;
import com.example.project_server.service.ReactionService;
import com.example.project_server.service.CommentService;
import com.example.project_server.util.Ut;
import com.example.project_server.vo.Article;
import com.example.project_server.vo.Board;
import com.example.project_server.vo.Comment;
import com.example.project_server.vo.ResultData;
import com.example.project_server.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrArticleController {

	private final BeforeActionInterceptor beforeActionInterceptor;

	@Autowired
	private Rq rq;

	@Autowired
	private ArticleService articleService;

	@Autowired
	private BoardService boardService;

	@Autowired
	private ReactionService reactionService;
	
	@Autowired
	private CommentService commentService;

	UsrArticleController(BeforeActionInterceptor beforeActionInterceptor) {
		this.beforeActionInterceptor = beforeActionInterceptor;
	}



}
