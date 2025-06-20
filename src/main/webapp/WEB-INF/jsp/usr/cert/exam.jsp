<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="WORK BOOK"></c:set>
<%@ include file="../common/head.jspf" %>

<div class="bg-green-400 p-auto" style="height: 100vh;">

    <div class="h-full flex justify-center items-center">
        <%--        <div class="w-4/5 h-5/6 bg-grey-2 py-2 rounded-xl">--%>
        <div class="question-container w-4/5 h-5/6 bg-grey-2 py-2 rounded-xl">
            <c:forEach var="question" items="${questions}" varStatus="status">
                <div class="flex">
                    <i class="fa-solid fa-circle text-red-500 mx-2"></i>
                    <i class="fa-solid fa-circle text-yellow-400"></i>
                    <i class="fa-solid fa-circle text-green-500 mx-2"></i>

                        <%--                <svg width="40" height="40" viewBox="0 0 512 528" xmlns="http://www.w3.org/2000/svg">--%>
                        <%--                    <path d="M 0,0 L 0,527 L 90,527 C 140,520 180,490 210,440 C 230,400 250,340 270,280--%>
                        <%--                                C 290,220 310,160 330,110 C 350,70 380,40 420,20 C 450,5 480,0 512,0 L 0,0 Z"--%>
                        <%--                          fill="#d9d9d9"/>--%>
                        <%--                </svg>--%>
<%--                    <svg width="40" height="40" viewBox="0 0 40 40" xmlns="http://www.w3.org/2000/svg">--%>
<%--                        <path d="M0,0 H40 V40 H0 V0 Z--%>
<%--           M0,0 L0,40 C8,39 13,37 18,32 C21,28 24,22 27,15 C30,9 32,5 36,2 C37,1 38,0.5 40,0 Z"--%>
<%--                              fill="#d9d9d9" fill-rule="evenodd"/>--%>
<%--                    </svg>--%>

                    <svg width="40" height="40" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
                        <path d="M94.87,4.80 L93.84,4.77 L92.79,4.72 L91.71,4.67 L90.61,4.61 L89.49,4.54 L88.35,4.48 L87.20,4.41 L86.04,4.36 L84.87,4.31 L83.69,4.28 L82.51,4.26 L81.32,4.26 L80.14,4.29 L78.96,4.34 L77.79,4.42 L76.63,4.54 L75.47,4.69 L74.33,4.88 L73.21,5.12 L72.10,5.40 L71.02,5.73 L69.96,6.12 L68.92,6.55 L67.91,7.04 L66.92,7.57 L65.96,8.14 L65.02,8.75 L64.11,9.39 L63.23,10.07 L62.37,10.78 L61.54,11.51 L60.74,12.26 L59.97,13.03 L59.23,13.83 L58.51,14.64 L57.82,15.46 L57.15,16.30 L56.51,17.16 L55.89,18.04 L55.29,18.93 L54.72,19.83 L54.17,20.75 L53.64,21.69 L53.13,22.63 L52.63,23.59 L52.16,24.57 L51.70,25.55 L51.26,26.55 L50.84,27.56 L50.43,28.57 L50.04,29.60 L49.66,30.64 L49.30,31.69 L48.94,32.75 L48.60,33.81 L48.27,34.89 L47.95,35.97 L47.63,37.06 L47.33,38.15 L47.03,39.25 L46.74,40.36 L46.46,41.47 L46.18,42.59 L45.91,43.71 L45.64,44.84 L45.37,45.96 L45.11,47.10 L44.85,48.23 L44.58,49.37 L44.32,50.51 L44.06,51.64 L43.79,52.78 L43.53,53.92 L43.26,55.06 L42.98,56.20 L42.71,57.34 L42.42,58.48 L42.13,59.61 L41.84,60.74 L41.53,61.87 L41.22,63.00 L40.90,64.12 L40.57,65.24 L40.22,66.35 L39.87,67.46 L39.50,68.56 L39.12,69.65 L38.73,70.74 L38.32,71.83 L37.90,72.90 L37.46,73.97 L37.01,75.02 L36.53,76.07 L36.04,77.11 L35.53,78.14 L35.00,79.15 L34.45,80.15 L33.88,81.13 L33.29,82.10 L32.67,83.05 L32.04,83.97 L31.38,84.87 L30.70,85.75 L29.99,86.60 L29.27,87.43 L28.51,88.22 L27.73,88.99 L26.93,89.72 L26.10,90.42 L25.24,91.09 L24.35,91.71 L23.44,92.30 L22.50,92.85 L21.53,93.36 L20.52,93.83 L19.49,94.24 L18.43,94.62 L17.34,94.94 L16.22,95.22 L15.07,95.46 L13.90,95.65 L12.71,95.80 L11.50,95.90 L10.28,95.97 L94.87,95.87 Z"
                              fill="#d9d9d9"/>
                    </svg>

                    <div class="bg-grey-1 py-2 pl-4 pr-12 w-40 font-bold">자격증명</div>
                        <%--                <svg width="40" height="40" viewBox="0 0 512 528" xmlns="http://www.w3.org/2000/svg">--%>
                        <%--                    <path d="M 512,0 L 512,527 L 422,527 C 372,520 332,490 302,440 C 282,400 262,340 242,280--%>
                        <%--                    C 222,220 202,160 182,110 C 162,70 132,40 92,20 C 62,5 32,0 0,0 L 512,0 Z"--%>
                        <%--                          fill="#d9d9d9"/>--%>
                        <%--                </svg>--%>
                    <svg width="40" height="40" viewBox="0 0 40 40" xmlns="http://www.w3.org/2000/svg">
                        <path d="M0,0 H40 V40 H0 V0 Z
           M40,0 L40,40 C32,39 27,37 22,32 C19,28 16,22 13,15 C10,9 8,5 4,2 C3,1 2,0.5 0,0 Z"
                              fill="#d9d9d9" fill-rule="evenodd"/>
                    </svg>

                    <div class="flex-grow"></div>
                </div>
                <div class="bg-grey-1 p-2 flex">
                    <i class="fa-solid fa-arrow-left mx-2 font-bold"></i>
                    <i class="fa-solid fa-arrow-right mx-2 font-bold"></i>
                    <i class="fa-solid fa-rotate-right mx-2 font-bold"></i>
                    <div class="flex-grow bg-white rounded-xl p-2">${question.extra__subjectName}
                    </div>
                </div>
                <%--            <div class="question-container">--%>
                <%--                <c:forEach var="question" items="${questions}" varStatus="status">--%>
                <div class="question-box ${!status.first ? 'hidden' : ''}">
                    <div class="m-2 bg-blue-300">
                        <div>(${question.extra__subjectName}) ${question.questNum}. ${question.body}</div>

                        <c:if test="${question.hasImage}">
                            <img src="${question.imgUrl}" alt="문제 이미지"/>
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
</div>
</div>
<script>
    $(document).ready(function () {
        $('.back').addClass("hidden");
        // $('.header').addClass('active');
        // $('.nav_box > ul > li:nth-child(2) i').addClass('active');
        // $('.side_bar_left').addClass('active');
        // $('.side_bar_left > .community_sub_menu ').removeClass('hidden');
    });
</script>
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
