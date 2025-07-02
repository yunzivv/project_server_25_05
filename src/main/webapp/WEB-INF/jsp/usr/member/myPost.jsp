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

    <div id="memberPosts" class="flex-grow flex flex-col justify-center items-center py-24">
        <div class="w-2/3">

            <div class="flex self-start">
                <div class="myPost_section p-2 mr-6 active">내 글</div>
                <div class="myPost_section p-2">내 좋아요</div>
            </div>
            <div class="flex justify-end mb-10">
                <a href="../article/write"
                   class="write-btn block w-12 h-12 rounded-full border-grey-3 flex items-center justify-center cursor-pointer">
                    <i class="fa-solid fa-pen text-grey-5"></i>
                </a>
            </div>
            <div id="myPostsList" class="">
                <c:forEach var="article" items="${articles}">
                    <a href="../article/detail?id=${article.id}" class="block">
                        <div class="pt-8 px-10 pb-4 rounded-lg bg-white m-5 border-grey-2 hover:shadow cursor-pointer transition">
                            <div class="text-2xl font-semibold m-3">${article.title}</div>
                            <div class="h-40 overflow-hidden p-4" style="overflow-wrap: anywhere;">
                                <c:choose>
                                    <c:when test="${fn:length(article.body) > 250}">
                                        <c:out value="${fn:substring(article.body, 0, 248)}"/>...
                                    </c:when>
                                    <c:otherwise>
                                        <c:out value="${article.body}"/>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="my-2">${article.regDate.toString().substring(0,10)}&nbsp;&nbsp;
                                <i class="fa-solid fa-heart text-grey-4"></i>&nbsp;${article.extra__sumReaction}
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <i class="fa-solid fa-message text-grey-4"></i>&nbsp;${article.extra__sumComment}
                            </div>
                        </div>
                    </a>
                </c:forEach>
                <c:if test="${empty articles }">
                    <div class="text-3xl font-bold m-8">작성된 게시물이 없습니다.</div>
                    <div>우측 상단의 글쓰기 버튼을 누르고 게시물을 작성해보세요.</div>
                </c:if>
            </div>
            <div id="likedPostsList" class="hidden">
                <c:forEach var="article" items="${likeArticles}">
                    <a href="../article/detail?id=${article.id}" class="block">
                        <div class="pt-8 px-10 pb-4 rounded-lg bg-white m-5 border-grey-2 hover:shadow cursor-pointer transition">
                            <div class="text-2xl font-semibold m-3">${article.title}</div>
                            <div class="h-40 overflow-hidden p-4" style="overflow-wrap: anywhere;">
                                <c:choose>
                                    <c:when test="${fn:length(article.body) > 200}">
                                        <c:out value="${fn:substring(article.body, 0, 200)}"/>...
                                    </c:when>
                                    <c:otherwise>
                                        <c:out value="${article.body}"/>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="my-2">${article.regDate.toString().substring(0,10)}&nbsp;&nbsp;
                                <i class="fa-solid fa-heart text-grey-4"></i>&nbsp;${article.extra__sumReaction}
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <i class="fa-solid fa-message text-grey-4"></i>&nbsp;${article.extra__sumComment}
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <i class="fa-solid fa-user text-grey-4"></i>&nbsp;${article.extra__writer}
                            </div>
                        </div>
                    </a>
                </c:forEach>
                <c:if test="${empty likeArticles }">
                    <div class="text-3xl font-bold m-8">좋아요 한 게시물이 없습니다.</div>
                    <div><a href="../article/list" class="text-blue-2 hover:underline">COMMUNITY</a>탭에서 다른 사용자들이 작성한 글을
                        확인하세요!
                    </div>
                </c:if>
            </div>
        </div>
    </div>


</div>

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

<%--작성 글, 좋아요 글--%>
<script>
    $(document).ready(function () {
        // 탭 클릭 처리
        $(".myPost_section").click(function () {
            $(".myPost_section").removeClass("active");
            $(this).addClass("active");

            const index = $(".myPost_section").index(this);

            if (index === 0) {
                // "내 글"
                $("#myPostsList").removeClass("hidden");
                $("#likedPostsList").addClass("hidden");
            } else {
                // "내 좋아요"
                $("#myPostsList").addClass("hidden");
                $("#likedPostsList").removeClass("hidden");
            }
        });
    });
</script>


<%@ include file="../common/foot.jspf" %>
