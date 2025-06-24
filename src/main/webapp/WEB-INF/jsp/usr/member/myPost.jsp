<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="pageTitle" value="MY PAGE"></c:set>
<%@ include file="../common/head.jspf" %>

<script>
    $(document).ready(function () {

        $('.nav_box > ul > li:nth-child(4) i').addClass('active');
        $('.side_bar_left > .myPage_sub_menu ').removeClass('hidden');
        $('.side_bar_left > .myPage_sub_menu > li:nth-child(3) > a').addClass('active');
        $('.side_bar_left > .myPage_sub_menu > li:nth-child(3) > a > i').addClass('active');

    });
</script>


<div class="flex w-screen">
    <div class="side hidden xl:block shrink-0" style="width: 250px;">
        <%@ include file="../common/side.jspf" %>
    </div>
    <div class="block min-[1280px]:hidden w-1/12"></div>

    <div id="memberPosts" class="flex-grow bg-red-300 flex flex-col justify-center items-center">
        <div class="text-3xl font-bold">내 글</div>
        <c:forEach var="article" items="${articles }">
            <div class="p-3 rounded-md bg-white m-2" style="width: 1000px;">
                <div class="text-2xl font-semibold ">${article.title }</div>
                <div class="whitespace-pre-line break-words">
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
                <div>${article.extra__sumReaction} ${article.extra__sumComment}</div>
            </div>
        </c:forEach>
        <c:if test="${empty articles }">
            <div>작성된 게시물이 없습니다.</div>
        </c:if>
    </div>


</div>

<%--    <div class="side hidden xl:block w-28 bg-grey-1"></div>--%>
<%--    <div class="block min-[1280px]:hidden w-1/12 bg-grey-1"></div>--%>
</div>
<script>
    $(document).ready(function () {

        $('.header').addClass('active');
        $('.side_bar_left').addClass('active');
        $('.nav_box > ul > li:nth-child(4) i').addClass('active');
        $('.side_bar_left > .myPage_sub_menu ').removeClass('hidden');
        $('.side_bar_left > .myPage_sub_menu > li:nth-child(3) > a').addClass('active');
        $('.side_bar_left > .myPage_sub_menu > li:nth-child(3) > a > i').addClass('active');

    });
</script>

<%@ include file="../common/foot.jspf" %>
