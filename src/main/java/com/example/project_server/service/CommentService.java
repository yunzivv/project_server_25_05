package com.example.project_server.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.project_server.repository.CommentRepository;
import com.example.project_server.util.Ut;
import com.example.project_server.vo.Comment;
import com.example.project_server.vo.ResultData;

@Service
public class CommentService {

	@Autowired
	private CommentRepository replyRepository;

	public CommentService(CommentRepository replyRepository) {
		this.replyRepository = replyRepository;
	}



}