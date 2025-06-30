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

	@RequestMapping("/usr/article/list")
	public String getArticles(Model model, String keyword, @RequestParam(defaultValue = "0") int boardId,
							  @RequestParam(defaultValue = "1") int searchItem, @RequestParam(defaultValue = "1") int page) {

		Board board = boardService.getBoardById(boardId);

		int itemsInAPage = 10;
		int limitFrom = (page - 1) * itemsInAPage;

		int totalCnt =articleService.getArticlesCnt(keyword, boardId, searchItem);
		int totalPage = (int) Math.ceil(totalCnt / (double) itemsInAPage);

		List<Article> articles = articleService.getArticles(keyword, boardId, searchItem, limitFrom, itemsInAPage);

//		model.addAttribute("boardId", boardId);

		model.addAttribute("articles", articles);
		model.addAttribute("keyword", keyword);
		model.addAttribute("boardId", boardId);
		model.addAttribute("searchItem", searchItem);

		model.addAttribute("page", page);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("totalPage", totalPage);

		return "/usr/article/list";
	}

	@RequestMapping("/usr/article/detail")
	public String getArticle(Model model, HttpServletRequest req, int id) {

		Rq rq = (Rq) req.getAttribute("rq");

		// 검색 기준 article 조회
		Article article = articleService.getArticleForPrint(id, rq.getLoginedMemberId());
		// article 필드에 작성자, 게시판 이름, 수정 삭제 권한, 좋아요 싫어요 합계 개수 저장
		model.addAttribute("article", article);

		// 댓글 조회
		List<Comment> comments = commentService.getComments(id, rq.getLoginedMemberId());
		model.addAttribute("comments", comments);

		return "/usr/article/detail";
	}

	@RequestMapping("/usr/article/write")
	public String write() {
		return "/usr/article/write";
	}

	@RequestMapping("/usr/article/doWrite")
	@ResponseBody
	public String doWrite(HttpServletRequest req, String title, String body, @RequestParam(defaultValue = "0")int boardId) {

		Rq rq = (Rq) req.getAttribute("rq");

		if (Ut.isEmpty(title))
			return Ut.jsHistoryBack("F-2", "제목 좀 써");
		if (Ut.isEmpty(body))
			return Ut.jsHistoryBack("F-2", "내용 좀 써");
		if (boardId == 0)
			return Ut.jsHistoryBack("F-3", "게시판 선택해주시오");

		Article article = articleService.writeArticle(title, body, rq.getLoginedMemberId(), boardId);
		int id = articleService.getLastInsertId();

		return Ut.jsSucceseReplace("S-1", Ut.f("게시글 %d 번 작성 완료", id), Ut.f("../article/detail?id=%d", id));
	}

	@RequestMapping("/usr/article/modify")
	public String modify(Model model, HttpServletRequest req, int id) throws IOException { // , String title, String body

		Rq rq = (Rq) req.getAttribute("rq");

		Article article = articleService.getArticleById(id);

		// 권한이 없다면 이전 페이지로 돌아가야하고,
		if (article == null) {
			rq.printHistoryBack(Ut.f("%d 번 게시물은 없으시오", id));
		}

		if (article.getMemberId() != rq.getLoginedMemberId()) {
			rq.printHistoryBack("권한 없음");
		}

		model.addAttribute("article", article);

		// 권한이 있다면 수정페이지로 돌아가야한다.
		return "/usr/article/modify";
	}

	// 로그인 체크 -> 유무 체크 -> 권한 체크
	@RequestMapping("/usr/article/doModify")
	@ResponseBody
	public String doModify(int id, String title, String body) {

		articleService.modifyArticle(id, title, body);

		return Ut.jsSucceseReplace("S-1", Ut.f("%d 번 게시물 수정 완료", id), Ut.f("../article/detail?id=%d", id));
	}

	@RequestMapping("/usr/article/doDelete")
	@ResponseBody
	public String doDelete(HttpServletRequest req, int id) {

		Rq rq = (Rq) req.getAttribute("rq");

		Article article = articleService.getArticleById(id);

		if (article == null) {
			ResultData.from("F-1", Ut.f("%d번 게시글은 없거던", id));
			return Ut.jsFailBack("F-1", Ut.f("%d 번 게시물은 존재하지 않습니다.", id));
		}

		if (article.getMemberId() != rq.getLoginedMemberId()) {
			ResultData.from("F-A", "권한 없음");
			return Ut.jsFailBack("F-A", Ut.f("%d번 게시물에 대한 권한이 없습니다.", id));
		}

		articleService.deleteArticle(id);

		return Ut.jsSucceseReplace("S-1", Ut.f("%d번 게시물 삭제 완료", id), "../article/list");
	}

}
