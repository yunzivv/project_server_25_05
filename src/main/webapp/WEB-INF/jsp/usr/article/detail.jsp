<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="ARTICLE DETAIL"></c:set>
<%@ include file="../common/head.jspf" %>
<%@ include file="../common/side.jspf" %>
<%@ include file="../common/toastUiEditorLib.jspf" %>

<script>
    const params = {};
    params.id = parseInt('${param.id}');

</script>

<script>
    $(document).ready(function () {

        const header = $('.header');
        const topBar = $('.topBar');

        header.addClass('active');
        header.removeClass('bg-grey-1');
        // header.addClass('bg-white');
        topBar.removeClass('text-grey-100');
        topBar.addClass('text-blue-2');
        $('.nav_box > ul > li:nth-child(3) i').addClass('active');

        $('.hamburgerIcon').addClass("main");

    });
</script>

<script>
    // 조회수 증가 함수
    function articleDetail_increaseHits() {

        const localStorageKey = 'article__' + params.id + '__alreadyOnView';

        if (localStorage.getItem(localStorageKey)) { // 로컬 스토리지
            return;
        }

        localStorage.setItem(localStorageKey, true);

        $.get('../article/doIncHits', {
            id: params.id,
            ajaxMode: 'Y'
        }, function (data) {
            $('.article_detail_hit_count').html("조회수 : " + data.data1);
            console.log(data);
            console.log($("comment_reaction_box").find(".good_btn").val());
            console.log($("comment_reaction_box").find(".bad_btn").val());
        }, 'json');
    }

    // 	article 좋아요 활성화 함수
    function articleDetail_goodReaction_toArticle() {
        const value = $(".article_reaction_box").find(".good_btn").val();
        $.get('../article/doGoodReaction', {
            id: params.id,
            relTypeCode: "article",
            ajaxMode: 'Y'
        }, function (data) {
            console.log(data);
            $(".article_reaction_box").find(".good_btn").toggleClass("bg-neutral-300");
            $(".article_reaction_box").find('.good_btn').html("👍 " + data.data1.extra_goodReactionPoint);
        }, 'json');
    }

    // 	comment 좋아요 활성화 함수
    function articleDetail_goodReaction_toComment() {
        const value = $(".comment_reaction_box").find(".good_btn").val();
        $.get('../article/doGoodReaction', {
            id: params.id,
            relTypeCode: "comment",
            ajaxMode: 'Y'
        }, function (data) {
            console.log(data);
            $(".comment_reaction_box").find('.good_btn').toggleClass("bg-neutral-300");
            $(".comment_reaction_box").find('.good_btn').html("👍 " + data.data1.extra_goodReactionPoint);
        }, 'json');
    }

    $(function () {
        articleDetail_increaseHits();
// 		setTimeout(articleDetail_increaseHits, 2000);
    })

</script>


<div class="article container m-auto">

    <div class="rounded-xl p-10 mt-12">

        <div class="header p-3">

            <div class="title text-3xl font-bold">${article.title }</div>

            <div class="articleInfo flex my-2">
                <div class="writeInfo text-neutral-800 m-1">
                    <span> 작성일 : ${article.regDate.toString().substring(0, 10)} &nbsp;&nbsp;&nbsp;</span>
                    <span> 작성자 : ${article.extra__writer } &nbsp;&nbsp;&nbsp;</span>
                    <span> 게시판 : ${article.extra__boardCode } &nbsp;&nbsp;&nbsp;</span>
                    <span class="article_detail_hit_count"> 조회수 : ${article.hits } </span>
                </div>

                <div class="flex-grow"></div>

                <!-- 				like -->
                <div class="article_reaction_box flex items-center justify-center mx-4 text-xl cursor-pointer">
                    <c:choose>
                        <c:when test="${article.userReaction}">
                            <button class="good_btn btn btn-circle btn-xl btn-outline bg-neutral-300 px-3 text-base whitespace-nowrap"
                                    onClick="articleDetail_doReaction_toArticle()" value="${article.userReaction}">
                                <i class="fa-solid fa-heart"></i> ${article.extra__sumReaction }</button>
                        </c:when>
                        <c:otherwise>
                            <button class="good_btn btn btn-circle btn-xl btn-outline px-3 text-base whitespace-nowrap"
                                    onClick="articleDetail_goodReaction_toArticle()" value="${article.userReaction}">
                                <i class="fa-regular fa-heart"></i> ${article.extra__sumReaction }</button>
                        </c:otherwise>
                    </c:choose>

                </div>

                <!-- 				modify, delete btn -->
                <div class="article-btn-box">
                    <c:if test="${article.userCanModify}">
                        <button class="btn rounded-xl ml-4 mr-1 px-3 hover:bg-neutral-300">
                            <a href="modify?id=${article.id}">Modify</a>
                        </button>
                    </c:if>
                    <c:if test="${article.userCanDelete}">
                        <button class="btn rounded-xl mx-1 px-3 hover:bg-neutral-300">
                            <a onclick="return confirm('게시글을 삭제하시겠습니까?');"
                               href="doDelete?id=${article.id}">Delete</a>
                        </button>
                    </c:if>
                </div>

            </div>
        </div>

        <hr class="border-neutral-400"/>

        <div class="toast-ui-viewer content mt-2 p-4">
            <script type="text/x-template">${article.body}</script>
        </div>
        <div class="hidden">
            <button class="btn btn-xl btn-circle hover:bg-neutral-300 font-black felx flex-col"
                    onClick="articleDetail_goodReaction()" value="${article.userReaction}">
                <c:choose>
                    <c:when test="${article.userReaction}">
                        <span class="goodIcon -m-1">♥</span>
                        <div class="good_count -m-2">${article.extra__sumReaction }</div>
                    </c:when>
                    <c:otherwise>
                        <span class="goodIcon -m-1">♡</span>
                        <div class="good_count -m-2">${article.extra__sumReaction }</div>
                    </c:otherwise>
                </c:choose>
            </button>

        </div>
    </div>
</div>


<div class="comment-box container flex justify-center flex-col mx-auto mt-4 mb-20">
    <c:if test="${not empty comments }">
        <div class="comments-box my-2 rounded-xl border border-solid border-neutral-500 px-4 py-6">
            <c:forEach var="comment" items="${comments }">
                <hr class="border-neutral-500 my-4"/>
                <div class="flex items-center px-4">
                    <!-- 					profile -->
                    <div class="avatar">
                        <div class="w-12 rounded">
                            <img src="https://img.daisyui.com/images/profile/demo/batperson@192.webp"/>
                        </div>
                    </div>
                    <!-- 					content -->
                    <strong class="ml-2 mr-6">${comment.extra_writer }</strong>
                    <div class="flex-grow">${comment.body }</div>
                    <!-- 					btn -->
                    <div class="comment_reaction_box">
                        <c:if test="${comment.userCanModify}">
                            <button class="btn rounded-xl px-3 hover:bg-neutral-300">
                                수정
                            </button>
                        </c:if>
                        <c:if test="${comment.userCanDelete}">
                            <button class="btn rounded-xl px-3 hover:bg-neutral-300" onClick="">
                                삭제
                            </button>
                        </c:if>
                        <c:choose>
                            <c:when test="${comment.userReaction}">
                                <button class="good_btn btn btn-circle btn-xl btn-outline bg-neutral-300 px-3 text-base whitespace-nowrap"
                                        onClick="articleDetail_goodReaction_toComment()"
                                        value="${comment.userReaction}">
                                    👍 ${comment.extra_goodReactionPoint }</button>
                            </c:when>
                            <c:otherwise>
                                <button class="good_btn btn btn-circle btn-xl btn-outline px-3 text-base whitespace-nowrap"
                                        onClick="articleDetail_goodReaction_toComment()"
                                        value="${comment.userReaction}">
                                    👍 ${comment.extra_goodReactionPoint }</button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>
    <div class="input-comment-box">
        <form action="doCommentWrite" class="text-center">
            <input type="hidden" name="id" value="${article.id}">
            <label class="flex items-center border border-neutral-500 mx-auto overflow-hidden rounded-3xl p-2 gap-2">
                <input type="text" name="body" placeholder="나도 한마디 하기!"
                       class="flex-grow min-w-0 px-2 py-1 focus-within:outline-none"/>
                <input type="submit" value="게시" class="px-3 py-1 font-bold"/>
            </label>
        </form>
    </div>
</div>

<%@ include file="../common/foot.jspf" %>