package com.example.project_server.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.project_server.repository.ArticleRepository;
import com.example.project_server.util.Ut;
import com.example.project_server.vo.Article;
import com.example.project_server.vo.ResultData;

@Service
public class ArticleService {

	@Autowired
	private ArticleRepository articleRepository;

	public ArticleService(ArticleRepository articleRepository) {
		this.articleRepository = articleRepository;
	}



}
