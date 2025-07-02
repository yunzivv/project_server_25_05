<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="POST LIST"></c:set>
<%@ include file="../common/head.jspf" %>

<a href="../article/write" style="top: auto; left: auto; bottom: 50px; right: 50px;"
   class="write-btn block fixed w-16 h-16 rounded-full border-grey-3 flex items-center justify-center cursor-pointer">
    <i class="fa-solid fa-pen text-grey-5 text-xl"></i>
</a>

<div class="flex w-full">
    <div class="side hidden xl:block shrink-0" style="width: 250px;">
        <%@ include file="../common/side.jspf" %>
    </div>
    <div class="block min-[1280px]:hidden w-1/12"></div>

    <div class="flex flex-col flex-grow items-center">
        <div class="w-3/4 pr-3 mt-20">
            <div class="flex justify-between items-end text-neutral-800 mx-2 my-3">
                <div class="articleCnt text-lg mx-4">
                    총 게시 글 : ${totalCnt }
                </div>

                <div class="search-bar flex justify-between items-center h-12 px-2 text-sm mt-auto mb-0">
                    <form class="search-box flex" action="list" method="POST">

                        <label for="boardId" class="flex h-12 mr-4 justify-center">
                            <select name="boardId" id="boardId"
                                    class="block flex justify-center items-center px-4 border-grey-3 rounded-lg overflow-hidden h-12">
                                <option value="0" disabled ${boardId eq 0 ? 'selected' : ''} hidden
                                        class="text-neutral-400">게시판 선택
                                </option>
                                <option value="0">전체 게시판</option>
                                <option value="1" ${boardId eq 1 ? 'selected' : ''}>공지사항</option>
                                <option value="2" ${boardId eq 2 ? 'selected' : ''}>시험후기</option>
                                <option value="3" ${boardId eq 3 ? 'selected' : ''}>자료실</option>
                                <option value="4" ${boardId eq 4 ? 'selected' : ''}>QnA</option>
                                <option value="5" ${boardId eq 5 ? 'selected' : ''}>자유 게시판</option>
                            </select>
                        </label>

                        <label class="flex items-center h-12 border-grey-3 rounded-md overflow-hidden px-2">

                            <select name="searchItem" id="searchItem"
                                    class="h-full pl-1 pr-2 bg-transparent text-sm outline-none">
                                <option value="1" ${searchItem eq 1 ? 'selected' : ''}>제목</option>
                                <option value="2" ${searchItem eq 2 ? 'selected' : ''}>내용</option>
                                <option value="3" ${searchItem eq 3 ? 'selected' : ''}>작성자</option>
                            </select>

                            <input type="text" name="keyword" placeholder="Search"
                                   value="${not empty keyword ? keyword : ''}"
                                   class="flex-1 h-full px-3 text-sm outline-none bg-transparent"/>

                            <button type="submit" class="text-grey-4 hover:text-grey-1 mr-2">
                                <i class="fa-solid fa-magnifying-glass"></i>
                            </button>
                        </label>
                    </form>
                </div>

            </div>


            <div class="container text-center">
                <div class="mx-auto my-4 rounded-lg overflow-hidden">
                    <table class="w-full text-sm text-center rtl:text-right">
                        <thead class="h-5 text-base bg-grey-1 text-blue-2 border-b">
                        <tr>
                            <th scope="col" class="px-6 py-4">게시판</th>
                            <th scope="col" class="px-6 py-4 w-1/2">제목</th>
                            <th scope="col" class="px-6 py-4">작성자</th>
                            <th scope="col" class="px-6 py-4">조회수</th>
                            <th scope="col" class="px-6 py-4 whitespace-nowrap">작성일</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="article" items="${articles }">
                            <tr class="bg-grey-1 hover:bg-neutral-200 cursor-pointer"
                                onclick="location.href='detail?id=${article.id}'">
                             <td class="p-4">${article.extra__boardCode }</td>
                                <td><a class="block text-left pl-6"
                                       href="detail?id=${article.id }">${article.title }</a>
                                </td>
                                <td class="p-4">${article.extra__writer }</td>
                                <td class="p-4">${article.hits }</td>
                                <td class="p-4">${article.regDate.toString().substring(0, 10) }</td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty articles }">
                            <tr class="text-center">
                                <td colspan="5" class="text-center text-lg py-8">게시글이 없습니다</td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>

                <div class="inline-flex mx-auto justify-between text-xl">


                    <c:forEach var="i" begin="1" end="${totalPage}">
                        <c:choose>
                            <c:when test="${page eq i}">
                                <a href="?keyword=${keyword}&boardId=${boardId}&searchItem=${searchItem}&page=${i}"
                                   class="block mx-1 w-8 px-2 py-1 hover:underline bg-neutral-200 rounded-full">${i}</a>
                            </c:when>
                            <c:otherwise>
                                <a href="?keyword=${keyword}&boardId=${boardId}&searchItem=${searchItem}&page=${i}"
                                   class="block mx-1 w-8 py-1 hover:underline">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {

        var boardId = ${boardId} +1;

        $('.header').addClass('active');
        $('.side_bar_left').addClass('active');
        $('.nav_box > ul > li:nth-child(3) i').addClass('active');
        $('.side_bar_left > .community_sub_menu ').removeClass('hidden');
        $('.side_bar_left > .community_sub_menu > li:nth-child(' + boardId + ') > a > i').addClass('active');
        $('.community_sub_menu > li:nth-child(' + boardId + ') > a').addClass('actived');
    });
</script>
<%@ include file="../common/foot.jspf" %>