<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="pageTitle" value="MY PAGE"></c:set>
<%@ include file="../common/head.jspf" %>


<div class="flex w-screen">
    <div class="side hidden xl:block shrink-0" style="width: 250px;">
        <%@ include file="../common/side.jspf" %>
    </div>
    <div class="block min-[1280px]:hidden w-1/12"></div>

    <div id="memberPosts" class="flex-grow flex flex-col justify-center items-center pt-20">
        <div class="text-3xl font-bold w-2/3">내 글</div>
        <div class="w-2/3 flex justify-end">
            <a href="../article/write"
               class="write-btn block w-12 h-12 rounded-full border-grey-3 flex items-center justify-center cursor-pointer">
                <i class="fa-solid fa-pen text-grey-5"></i>
            </a>
        </div>
        <c:forEach var="article" items="${articles}">
            <a href="../article/detail?id=${article.id}" class="block w-2/3">
                <div class="p-5 rounded-lg bg-white m-3 border-grey-2 hover:shadow cursor-pointer transition">
                    <div class="text-2xl font-semibold ">${article.title}</div>
                    <div class="max-h-32 overflow-hidden" style="overflow-wrap: anywhere;">
                        <c:choose>
                            <c:when test="${fn:length(article.body) > 100}">
                                <c:out value="${fn:substring(article.body, 0, 100)}"/>...
                            </c:when>
                            <c:otherwise>
                                <c:out value="${article.body}"/>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div>${article.regDate}</div>
                    <div>
                        <i class="fa-solid fa-heart text-grey-4"></i>${article.extra__sumReaction}
                        <i class="fa-solid fa-message text-grey-4"></i>${article.extra__sumComment}
                    </div>
                </div>
            </a>
        </c:forEach>

        <c:if test="${empty articles }">
            <div class="text-3xl font-bold m-8">작성된 게시물이 없습니다.</div>
            <div>좌측 상단의 글쓰기 버튼을 누르고 게시물을 작성해보세요.</div>
        </c:if>
    </div>


</div>

<%--    <div class="side hidden xl:block w-28 bg-grey-1"></div>--%>
<%--    <div class="block min-[1280px]:hidden w-1/12 bg-grey-1"></div>--%>


<script>
    $(document).ready(function () {

        const memberExists = ${member != null ? 'true' : 'false'};
        $('.header').addClass('active');
        $('.nav_box > ul > li:nth-child(4) i').addClass('active');

        if (memberExists) {
            $('.side_bar_left').addClass('active');
            $('.side_bar_left > .myPage_sub_menu ').removeClass('hidden');
            $('.side_bar_left > .myPage_sub_menu > li:nth-child(3) > a').addClass('active');
            $('.side_bar_left > .myPage_sub_menu > li:nth-child(3) > a > i').addClass('active');
        } else {
            document.location.href = "../member/login";
        }

    });
</script>

<%@ include file="../common/foot.jspf" %>
