package com.example.project_server.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.project_server.vo.Article;

@Mapper
public interface ArticleRepository {

    public int writeArticle(String title, String body, int memberId, int boardId);

    public void modifyArticle(int id, String title, String body);

    public void deleteArticle(int id);

    public Article getArticleById(int id);

    public Article getArticleForPrint(int id);

    public List<Article> getArticles(String keyword, int boardId, int searchItem, int limitFrom, int itemsInAPage);

    public int getLastInsertId();

    public int getArticleCnt();

    public int getArticlesCnt(String keyword, int boardId, int searchItem);

    public List<Article> getArticlesByMemberId(int loginedMemberId);

    public List<Article> getLikeArticlesByMemberId(int loginedMemberId);

//    public int getHits(int id);
}
