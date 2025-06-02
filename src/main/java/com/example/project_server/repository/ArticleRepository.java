package com.example.project_server.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.project_server.vo.Article;

@Mapper
public interface ArticleRepository {

    //	@Insert("INSERT INTO article SET regDate = NOW(), updateDate = NOW(), title = #{title}, `body` = #{body}")
    public int writeArticle(String title, String body, int memberId, int boardId);

    //	@Update("UPDATE article SET updateDate = NOW(), title = #{title}, `body` = #{body} WHERE id = #{id}")
    public void modifyArticle(int id, String title, String body);

    //	@Delete("DELETE FROM article WHERE id = #{id}")
    public void deleteArticle(int id);

    //	@Select("SELECT * FROM article WHERE id = #{id}")
    public Article getArticleById(int id);

    //	@Select("SELECT A.*, M.name as extra_writerName FROM article A JOIN `member` M ON A.writerId = M.id WHERE A.id = #{id}")
    public Article getArticleForPrint(int id);

    //	@Select("SELECT A.*, M.name as extra_writerName FROM article A JOIN `member` M ON A.writerId = M.id ORDER BY A.id DESC")
    public List<Article> getArticles(String keyword, int boardId, int searchItem, int limitFrom, int itemsInAPage);

    //  @Select("SELECT LAST_INSERT_ID();")
    public int getLastInsertId();

    //  @Select("SELECT COUNT(*) FROM article")
    public int getArticleCnt();

    public int getArticlesCnt(String keyword, int boardId, int searchItem);

    public int getHits(int id);
}
