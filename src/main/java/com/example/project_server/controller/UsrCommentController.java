package com.example.project_server.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.project_server.service.ReactionService;
import com.example.project_server.service.CommentService;
import com.example.project_server.util.Ut;
import com.example.project_server.vo.Comment;
import com.example.project_server.vo.ResultData;
import com.example.project_server.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrCommentController {

	@Autowired
	private Rq rq;

	@Autowired
	private ReactionService reactionService;

	@Autowired
	private CommentService commentService;

//	@RequestMapping("/usr/comment/doWrite")
//	@ResponseBody
//	public String doWrite(HttpServletRequest req, int articleId, String body) {
//
//		Rq rq = (Rq) req.getAttribute("rq");
//		if (Ut.isEmptyOrNull(body)) {
//			return Ut.jsHistoryBack("F-2", "내용을 입력해주세요");
//		}
//		ResultData writeReplyRd = commentService.doWrite(rq.getLoginedMemberId(), body, articleId);
//
//		return Ut.jsReplace(writeReplyRd.getResultCode(), writeReplyRd.getMsg(), "../article/detail?id=" + articleId);
//	}
//
//	@RequestMapping("/usr/comment/doModify")
//	@ResponseBody
//	public String doModify(HttpServletRequest req, int id, String body) {
//		System.err.println(id);
//		System.err.println(body);
//		Rq rq = (Rq) req.getAttribute("rq");
//
//		Comment comment = commentService.getComment(id);
//
//		if (comment == null) {
//			return Ut.jsHistoryBack("F-1", "해당 댓글은 존재하지 않습니다");
//		}
//
//		ResultData loginedMemberCanModifyRd = commentService.userCanModify(rq.getLoginedMemberId(), comment);
//
//		if (loginedMemberCanModifyRd.isSuccess()) {
//			commentService.modifyComment(id, body);
//		}
//
//		comment = commentService.getComment(id);
//
//		return comment.getBody();
//	}

}