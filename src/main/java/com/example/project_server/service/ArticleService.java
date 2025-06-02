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

	public int getLastInsertId() {
		return articleRepository.getLastInsertId();
	}

	public Article writeArticle(String title, String body, int memberId, int boardId) {
		articleRepository.writeArticle(title, body, memberId, boardId);
		return new Article(title, body, memberId, boardId);
	}

	public void deleteArticle(int id) {
		articleRepository.deleteArticle(id);
	}

	public void modifyArticle(int id, String title, String body) {
		articleRepository.modifyArticle(id, title, body);
	}

	public Article getArticleById(int id) {
		return articleRepository.getArticleById(id);
	}

	public List<Article> getArticles(String keyword, int boardId, int searchItem, int limitFrom, int itemsInAPage) {
		return articleRepository.getArticles(keyword, boardId, searchItem, limitFrom, itemsInAPage);
	}

	public Article getArticleForPrint(int id, int loginedMemberId) {

		Article article = articleRepository.getArticleForPrint(id);

		updateForPrintData(loginedMemberId, article);

		return article;
	}

	public int getArticleCnt() {

		return articleRepository.getArticleCnt();
	}


	public int getArticlesCnt(String keyword, int boardId, int searchItem) {
		return articleRepository.getArticlesCnt(keyword, boardId, searchItem);
	}

	private void updateForPrintData(int loginedMemberId, Article article) {
		if (article == null) return;

		ResultData userCanModifyRd = userCanModify(loginedMemberId, article);
		article.setUserCanModify(userCanModifyRd.isSuccess());

		ResultData userCanDeleteRd = userCanDelete(loginedMemberId, article);
		article.setUserCanDelete(userCanModifyRd.isSuccess());

//		ResultData userReactionRd = userReaction(loginedMemberId, article.getId());
//		if(userReactionRd == null) return;
//		article.setUserReaction((int)userReactionRd.getData1());

	}

	public ResultData userCanModify(int loginedMemberId, Article article) {

		if (article.getMemberId() != loginedMemberId) {
			return ResultData.from("F-A", Ut.f("%d번 게시글 수정 권한 없음", article.getId()));
		}

		return ResultData.from("S-1", Ut.f("%d번 게시글 수정 권한 있음", article.getId()));
	}

	private ResultData userCanDelete(int loginedMemberId, Article article) {

		if (article.getMemberId() != loginedMemberId) {
			return ResultData.from("F-A", Ut.f("%d번 게시글 삭제 권한 없음", article.getId()));
		}

		return ResultData.from("S-1", Ut.f("%d번 게시글 삭제 권한 있음", article.getId()));
	}

}
