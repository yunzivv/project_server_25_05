<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="EXAM"></c:set>
<%@ include file="../common/head.jspf" %>

<div class="" style="height: 100vh;">
    <div class="h-full flex justify-center items-center">
        <div class="question-container flex flex-col w-4/5 h-5/6 bg-grey-2 pt-2 rounded-xl overflow-hidden">

            <div class="examHead flex items-center">
                <button onclick="confirmExit()"><i class="fa-solid fa-circle text-red-500 ml-4"></i></button>
                <i class="fa-solid fa-circle text-yellow-400 mx-4"></i>
                <i class="fa-solid fa-circle text-green-500"></i>

                <svg width="40" height="40" viewBox="0 0 40 40" xmlns="http://www.w3.org/2000/svg">
                    <g transform="translate(40,0) scale(-1,1)">
                        <path d="M0,0 H40 V40 H0 V0 ZM0,0 C5,0 10,0 13,5 C15,10 17,20 17,30 C17,35 19,38 24,40 H40 V0 H0 Z"
                              fill="#f3f3f3" fill-rule="evenodd"/>
                    </g>
                </svg>

                <div class=" bg-grey-1 py-2 pl-2 pr-12 font-bold">${certificate.name}</div>

                <svg width="40" height="40" viewBox="0 0 40 40" xmlns="http://www.w3.org/2000/svg">
                    <path d="M0,0 H40 V40 H0 V0 Z M0,0 C5,0 10,0 13,5 C15,10 17,20 17,30 C17,35 19,38 24,40 H40 V0 H0 Z"
                          fill="#f3f3f3" fill-rule="evenodd"/>
                </svg>
                <div class="flex-grow"></div>
            </div>

            <!-- 문제 영역 -->
            <div class="bg-grey-1 flex-grow">
                <c:forEach var="question" items="${questions}" varStatus="status">
                    <div class="examBody h-5/6 question-box ${!status.first ? 'hidden' : ''}"
                         data-subject-num="${question.extra__subjectNum}"
                         data-subject-name="${question.extra__subjectName}">

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
                            정답률: <span class="answerCorrectRate">0</span>% &nbsp;&nbsp;&nbsp; ${status.index + 1}
                            / ${questions.size()} &nbsp;&nbsp;&nbsp;
                            <span class="elapsedTime">
                            </span>
                        </div>

                        <!-- 문제 내용 -->
                        <div class="px-20">
                            <div class="questionBody m-5">
                                <div class="text-xl font-bold">${status.index + 1}. ${question.body}</div>

                                <c:if test="${question.hasImage}">
                                    <div class="ml-3"><img src="${question.imgUrl}" alt="문제 이미지" class="mt-2"
                                                           style="height: 200px; object-fit: contain;"/></div>
                                </c:if>
                            </div>
                            <div class="choiceBody ml-6 text-lg">
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

                <div class="h-1/6 py-8 px-12 flex items-end">
                    <button onclick="confirmExit()" class="px-4 py-2 bg-red-400 text-white rounded">종료</button>
                    <div class="flex-grow"></div>
                    <button onclick="showPrevQuestion()" class="px-4 py-2 bg-gray-400 mx-4 text-white rounded">이전
                    </button>
                    <button id="nextButton" onclick="showNextQuestion()"
                            class="px-4 py-2 bg-gray-400 text-white rounded">다음
                    </button>
                </div>
            </div>
        </div>
        <div class="result-container hidden flex flex-col pt-2 w-4/5 h-5/6 bg-grey-2 rounded-xl overflow-hidden">

            <div class="examHead flex items-center">
                <button><i class="fa-solid fa-circle text-red-500 ml-4"></i></button>
                <i class="fa-solid fa-circle text-yellow-400 mx-4"></i>
                <i class="fa-solid fa-circle text-green-500"></i>

                <svg width="40" height="40" viewBox="0 0 40 40" xmlns="http://www.w3.org/2000/svg">
                    <g transform="translate(40,0) scale(-1,1)">
                        <path d="M0,0 H40 V40 H0 V0 ZM0,0 C5,0 10,0 13,5 C15,10 17,20 17,30 C17,35 19,38 24,40 H40 V0 H0 Z"
                              fill="#f3f3f3" fill-rule="evenodd"/>
                    </g>
                </svg>

                <div class=" bg-grey-1 py-2 pl-2 pr-12 font-bold">${certificate.name}</div>

                <svg width="40" height="40" viewBox="0 0 40 40" xmlns="http://www.w3.org/2000/svg">
                    <path d="M0,0 H40 V40 H0 V0 Z M0,0 C5,0 10,0 13,5 C15,10 17,20 17,30 C17,35 19,38 24,40 H40 V0 H0 Z"
                          fill="#f3f3f3" fill-rule="evenodd"/>
                </svg>
                <div class="flex-grow"></div>
            </div>
            <div class="bg-grey-1 flex-grow">

                <div class="examBody h-full question-box relative">

                    <!-- 상단 바 -->
                    <div class="bg-grey-1 p-2 flex items-center">
                        <button><i
                                class="fa-solid fa-arrow-left ml-4 font-bold text-lg"></i></button>
                        <button><i
                                class="fa-solid fa-arrow-right mx-4 font-bold text-lg"></i></button>
                        <i class="fa-solid fa-rotate-right mr-4 font-bold text-lg"></i>
                        <div class="flex-grow bg-white rounded-xl px-4 py-2">시험 결과</div>
                        <i class="fa-solid fa-ellipsis-vertical mx-4 text-2xl"></i>
                    </div>
                    <div class="text-gray-500 p-20 text-xl" id="result-summary">
                        <%--                    결과출력--%>
                    </div>
                    <button type="button" class="absolute bottom-8 right-12 px-4 py-2 bg-red-400 text-white rounded">
                        <a href="../workbook/showWorkbook">시험 모드 종료</a></button>
                </div>
            </div>
        </div>
    </div>
</div>


<script>

    totalAnswered = 0;
    let correctCount = 0;
    let examStartTime;
    let examElapsedMinutes = 0;
    let examElapsedSeconds = 0;

    // 과목별 통계
    const subjectStats = {};

    $(document).ready(function () {

        $('.back').addClass("hidden");

        // 시간 저장
        examStartTime = new Date();

        setInterval(function () {
            const now = new Date();
            const elapsedMs = now - examStartTime;

            examElapsedMinutes = Math.floor(elapsedMs / 60000);
            examElapsedSeconds = Math.floor((elapsedMs % 60000) / 1000);

            const minutesStr = String(examElapsedMinutes).padStart(2, '0');
            const secondsStr = String(examElapsedSeconds).padStart(2, '0');

            $('.elapsedTime').text(minutesStr + " : " + secondsStr);
        }, 1000);
    });

    // 정답 여부
    function checkAnswer(el) {
        const isCorrect = el.getAttribute("data-correct") === "true";
        const box = el.closest(".question-box");
        const subjectNum = parseInt(box.getAttribute("data-subject-num"));
        const subjectName = box.getAttribute("data-subject-name");

        if (!subjectStats[subjectNum]) {
            subjectStats[subjectNum] = {
                subjectNum: subjectNum,
                name: subjectName,
                total: 0,
                correct: 0
            };
        }

        subjectStats[subjectNum].total++;

        const siblings = el.parentElement.querySelectorAll('.choice-option');

        siblings.forEach(option => {
            const correct = option.getAttribute("data-correct") === "true";

            if (correct) {
                option.classList.add("bg-green-200");
            }

            if (option === el && !isCorrect) {
                option.classList.add("bg-red-200");
            }

            option.onclick = null;
            option.classList.add("pointer-events-none");
        });

        if (isCorrect) {
            correctCount++;
            subjectStats[subjectNum].correct++;
        }

        totalAnswered++;
        updateAccuracy(correctCount, totalAnswered);
    }

    // 정답률
    function updateAccuracy(correctCount, totalAnswered) {
        const accuracy = totalAnswered === 0 ? 0 : Math.round((correctCount / totalAnswered) * 100);
        $(".answerCorrectRate").text(accuracy);
    }

    // 시험 종료(중단)
    function confirmExit() {
        Swal.fire({
            title: '시험을 종료하시겠습니까?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: '종료',
            cancelButtonText: '취소',
            confirmButtonColor: '#d54b4b',
            cancelButtonColor: '#dedede'
        }).then((result) => {
            if (result.isConfirmed) {
                submitExam();
            }
        });
    }

    let currentIndex = 0;
    const boxes = $(".question-container .question-box");
    const nextBtn = $("#nextButton");

    // 다음 문제
    function showNextQuestion() {
        if (currentIndex < boxes.length - 1) {
            boxes[currentIndex].classList.add("hidden");
            currentIndex++;
            boxes[currentIndex].classList.remove("hidden");

            if (currentIndex === boxes.length - 1) {
                nextBtn.text("제출");
                nextBtn.off("click").on("click", submitExam);
            }
        } else {
            submitExam();
        }
    }

    // 이전 문제
    function showPrevQuestion() {
        if (currentIndex > 0) {
            boxes[currentIndex].classList.add("hidden");
            currentIndex--;
            boxes[currentIndex].classList.remove("hidden");

            if (nextBtn.textContent === "제출") {
                nextBtn.textContent = "다음";
                nextBtn.onclick = showNextQuestion;
            }
        } else {
            Swal.fire({
                icon: 'warning',
                title: '첫 번째 문제입니다.',
                confirmButtonText: '확인'
            });
        }
    }

    // 시험 제출(전체 문제 풀이 완료)
    function submitExam() {
        $(".question-container").addClass("hidden");
        $(".result-container").removeClass("hidden");

        const total = totalAnswered;
        const accuracy = total === 0 ? 0 : Math.round((correctCount / total) * 100);
        const timeStr = examElapsedMinutes + "분 " + examElapsedSeconds + "초";

        let resultHtml = "<div>총 문제 수: <strong>" + total + "</strong></div>" +
            "<div>맞춘 개수: <strong>" + correctCount + "</strong></div>" +
            "<div>정답률: <strong>" + accuracy + "%</strong></div>" +
            "<div>소요 시간: <strong>" + timeStr + "</strong></div>";

        resultHtml += "<br/><div class='mt-4 font-bold'>[과목별 성적]</div>";

        for (const key in subjectStats) {
            const sub = subjectStats[key];
            const rate = sub.total === 0 ? 0 : Math.round((sub.correct / sub.total) * 100);
            resultHtml += "<div>" + sub.subjectNum + "과목 " + sub.name + " - " +
                sub.total + "문제 중 정답: " + sub.correct + "개 (정답률 " + rate + "%)</div>";
        }

        $("#result-summary").html(resultHtml);

        saveExamResult();
    }

    // 시험 결과 기록
    function saveExamResult() {
        const certId = ${certificate.id};
        const examId = ${examId != null ? examId : 0};

        const timeStr = (examElapsedMinutes < 10 ? "0" : "") + examElapsedMinutes + ":" +
            (examElapsedSeconds < 10 ? "0" : "") + examElapsedSeconds + ":00";

        $.ajax({
            url: "/usr/workbook/doRecord",
            type: "POST",
            data: {
                certId: certId,
                examId: examId,
                elapsedTime: timeStr,
                totalQuest: totalAnswered,
                correctQuest: correctCount
            },
            error: function (err) {
                console.error("시험 결과 저장 실패", err);
            }
        });
    }

</script>


<%@ include file="../common/foot.jspf" %>
