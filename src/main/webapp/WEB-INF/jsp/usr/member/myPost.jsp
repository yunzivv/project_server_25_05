<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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


<div class="flex w-full">
    <div class="side hidden xl:block shrink-0" style="width: 250px;">
        <%@ include file="../common/side.jspf" %>
    </div>
    <div class="block min-[1280px]:hidden w-1/12"></div>

    <div id="memberPosts" class="bg-red-300">
        <c:forEach var="article" items="${articles }">
            <div>
                <div>${article.title }</div>
                <div>${article.body}</div>
                <div>${article.regDate}</div>
                <div>${article.extra__sumComment}</div>
                <div>${article.extra__sumComment}</div>
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
