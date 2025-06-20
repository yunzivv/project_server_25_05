<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="WORK BOOK"></c:set>
<%@ include file="../common/head.jspf" %>

<div class="" style="height: 100vh;">
    <div class="h-full flex justify-center items-center">
        <div class="question-container flex flex-col w-4/5 h-5/6 bg-grey-2 pt-2 rounded-xl overflow-hidden">

            <!-- examHead: 고정 -->
            <div class="examHead flex items-center">
                <button onclick="confirmExit()"><i class="fa-solid fa-circle text-red-500 ml-4"></i></button>
                <i class="fa-solid fa-circle text-yellow-400 mx-4"></i>
                <i class="fa-solid fa-circle text-green-500"></i>

                <svg width="40" height="40" viewBox="0 0 40 40" xmlns="http://www.w3.org/2000/svg">
                    <g transform="translate(40,0) scale(-1,1)">
                        <path d="M0,0 H40 V40 H0 V0 ZM0,0 C5,0 10,0 13,5 C15,10 17,20 17,30 C17,35 19,38 24,40 H40 V0 H0 Z"
                              fill="#d9d9d9" fill-rule="evenodd"/>
                    </g>
                </svg>

                <div class=" bg-grey-1 py-2 pl-2 pr-12 font-bold">${certificate.name}</div>

                <svg width="40" height="40" viewBox="0 0 40 40" xmlns="http://www.w3.org/2000/svg">
                    <path d="M0,0 H40 V40 H0 V0 Z M0,0 C5,0 10,0 13,5 C15,10 17,20 17,30 C17,35 19,38 24,40 H40 V0 H0 Z"
                          fill="#d9d9d9" fill-rule="evenodd"/>
                </svg>
                <div class="flex-grow"></div>
            </div>

            <!-- 문제 영역 -->
            <div class="bg-grey-1 flex-grow">
                <c:forEach var="question" items="${questions}" varStatus="status">
                    <div class="examBody h-5/6 question-box ${!status.first ? 'hidden' : ''}">

                        <!-- 상단 바 -->
                        <div class="bg-grey-1 p-2 flex items-center">
                            <button onclick="showPrevQuestion()"><i
                                    class="fa-solid fa-arrow-left ml-4 font-bold text-lg"></i></button>
                            <button onclick="showNextQuestion()"><i
                                    class="fa-solid fa-arrow-right mx-4 font-bold text-lg"></i></button>
                            <i class="fa-solid fa-rotate-right mr-4 font-bold text-lg"></i>
                            <div class="flex-grow bg-white rounded-xl px-4 py-2">${question.extra__subjectNum}과목: ${question.extra__subjectName}</div>
                            <i class="fa-solid fa-ellipsis-vertical mx-4 text-2xl"></i>
                        </div>
                        <div class="text-right text-sm px-4 pt-2 text-gray-500">
                                정답률: <span class="answerCorrectRate">0</span>% &nbsp;&nbsp;&nbsp; ${status.index + 1} / ${questions.size()}
                        </div>
                        <!-- 문제 내용 -->
                        <div class="px-10">
                            <div class="questionBody m-5">
                                <div class="text-lg font-bold">${status.index + 1}. ${question.body}</div>

                                <c:if test="${question.hasImage}">
                                    <div class="ml-3"><img src="${question.imgUrl}" alt="문제 이미지" class="mt-2"
                                                           style="height: 200px; object-fit: contain;"/></div>
                                </c:if>
                            </div>
                            <div class="choiceBody ml-6">
                                <c:forEach var="choice" items="${question.extra__choices}">
                                    <div class="mt-1 choice-option cursor-pointer px-3 py-1 rounded hover:bg-gray-100"
                                         data-correct="${choice.correct}" data-label="${choice.label}"
                                         onclick="checkAnswer(this)">
                                        <c:choose>
                                            <c:when test="${choice.label == 1}">①</c:when>
                                            <c:when test="${choice.label == 2}">②</c:when>
                                            <c:when test="${choice.label == 3}">③</c:when>
                                            <c:when test="${choice.label == 4}">④</c:when>
                                        </c:choose> ${choice.body}
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                    </div>
                </c:forEach>

                <div class="h-1/6 py-4 px-12 text-right">
                    <button onclick="showPrevQuestion()" class="px-4 py-2 bg-gray-400 text-white rounded">이전</button>
                    <button id="nextButton" onclick="showNextQuestion()"
                            class="px-4 py-2 bg-gray-400 text-white rounded">다음
                    </button>
                    <button onclick="confirmExit()"
                            class="px-4 py-2 bg-red-400 text-white rounded">종료
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
</div>

<%--시험 종료--%>
<script>
    function confirmExit() {
        if (confirm("시험을 종료하시겠습니까?")) {
            window.location.href = "/usr/workbook/showWorkbook";
        }
    }
</script>

<!-- 문제 넘기기 -->
<script>
    let currentIndex = 0;
    const boxes = document.querySelectorAll(".question-box");
    const nextBtn = document.getElementById("nextButton");

    function showNextQuestion() {
        if (currentIndex < boxes.length - 1) {
            boxes[currentIndex].classList.add("hidden");
            currentIndex++;
            boxes[currentIndex].classList.remove("hidden");

            if (currentIndex === boxes.length - 1) {
                nextBtn.textContent = "제출";
                nextBtn.onclick = submitExam;
            }
        } else {
            submitExam();
        }
    }

    function showPrevQuestion() {
        if (currentIndex > 0) {
            boxes[currentIndex].classList.add("hidden");
            currentIndex--;
            boxes[currentIndex].classList.remove("hidden");

            // 마지막 문제에서 이전으로 돌아가면 다시 "다음"으로 복귀
            if (nextBtn.textContent === "제출") {
                nextBtn.textContent = "다음";
                nextBtn.onclick = showNextQuestion;
            }
        } else {
            alert("첫 번째 문제입니다.");
        }
    }

    function submitExam() {
        alert("제출되었습니다!");
        // 여기에 실제 제출 로직 추가 가능 (예: form.submit(), location.href, fetch 등)
    }

    $(document).ready(function () {
        $('.back').addClass("hidden");
    });
</script>

<script>
    let totalAnswered = 0;
    let correctCount = 0;

    // 정답 출력
    function checkAnswer(el) {
        const isCorrect = el.getAttribute("data-correct") === "true";

        if (isCorrect) {
            el.classList.add("bg-green-200");
            correctCount++;
        } else {
            el.classList.add("bg-red-200");
        }

        // 선택 후 다른 선택지 클릭 못 하게 비활성화
        const siblings = el.parentElement.querySelectorAll('.choice-option');
        siblings.forEach(option => {
            option.onclick = null;
            option.classList.add("pointer-events-none");
        });
        totalAnswered++;
        updateAccuracy(correctCount, totalAnswered);
    }

    // 정답률
    function updateAccuracy(correctCount, totalAnswered) {
        const accuracy = totalAnswered === 0 ? 0 : Math.round((correctCount / totalAnswered) * 100);
        $(".answerCorrectRate").text(accuracy);
    }
</script>


<%@ include file="../common/foot.jspf" %>
