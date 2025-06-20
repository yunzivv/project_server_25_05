<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="WORK BOOK"></c:set>
<%@ include file="../common/head.jspf" %>

<script>
    $(document).ready(function () {
        $('.header').addClass('active');
        $('.nav_box > ul > li:nth-child(2) i').addClass('active');
        $('.side_bar_left').addClass('active');
        $('.side_bar_left > .community_sub_menu ').removeClass('hidden');
    });
</script>

<div class="">
    <div class="question-container">
        <c:forEach var="question" items="${questions}" varStatus="status">
            <div class="question-box ${!status.first ? 'hidden' : ''}">
                <div class="m-2 bg-blue-300">
                    <div>(${question.extra__subjectName}) ${question.questNum}. ${question.body}</div>

                    <c:if test="${question.hasImage}">
                        <img src="${question.imgUrl}" alt="문제 이미지" />
                    </c:if>

                    <c:forEach var="choice" items="${question.extra__choices}">
                        <div>${choice.label}) ${choice.body} ${choice.correct}</div>
                    </c:forEach>
                </div>
            </div>
        </c:forEach>
    </div>

    <button onclick="showNextQuestion()" class="mt-4 px-4 py-2 bg-blue-500 text-white rounded">다음</button>
</div>

<script>
    let currentIndex = 0;
    const boxes = document.querySelectorAll(".question-box");

    function showNextQuestion() {
        if (currentIndex < boxes.length - 1) {
            boxes[currentIndex].classList.add("hidden");
            currentIndex++;
            boxes[currentIndex].classList.remove("hidden");
        } else {
            alert("마지막 문제입니다.");
        }
    }
</script>

<%@ include file="../common/foot.jspf" %>
