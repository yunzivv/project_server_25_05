<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="WORK BOOK"></c:set>
<%@ include file="../common/head.jspf" %>


<script>
    $(document).ready(function () {
        $('.header').addClass('active');
        $('.nav_box > ul > li:nth-child(2) i').addClass('active');

        $('.side_bar_left').addClass('active');
        $('.side_bar_left > .workbook_sub_menu ').removeClass('hidden');
        $('.side_bar_left > .workbook_sub_menu > li:nth-child(2) > a').addClass('active');
        $('.side_bar_left > .workbook_sub_menu > li:nth-child(2) > a > i').addClass('active');
    });

</script>

<div class="flex w-full">
    <div class="side hidden xl:block shrink-0" style="width: 250px;">
        <%@ include file="../common/side.jspf" %>
    </div>
    <div class="block min-[1280px]:hidden w-1/12"></div>

    <div class="flex-grow"><%--style="height: calc(100vh - 100px);"--%>

        <div class="mx-auto my-12 w-9/12" style="height: 600px;">
            <div id="examInputForm" class="overflow-hidden h-full p-12 rounded-2xl bg-grey-1 relative">
                <form action="showExam" class="h-full">

                    <div id="step1" class="step w-full p-12 font-semibold text-xl px-20 py-4 active">
                        <div class="my-6 text-4xl">어떤 <span class="font-black">자격증</span>을 준비 중이신가요?</div>
                        <div class="m-2">준비된 문제 유형 중 하나를 선택하고 학습을 시작해보세요</div>
                        <div class="m-2">문제를 풀면 즉시 정답 여부를 확인할 수 있습니다!</div>
                        <%--                        <button type="button" onclick="nextStep()"--%>
                        <%--                                class="bg-grey-2 rounded-xl hover:bg-gray-300 px-6 py-4 text-base absolute bottom-2 right-12">--%>
                        <%--                            다음--%>
                        <%--                        </button>--%>
                    </div>

                    <div id="step2" class="step w-full px-20 py-4 text-xl p-8">
                        <div class="my-6 text-4xl font-black">자격증을 선택하고 문제 풀이를 시작하세요.</div>
                        <div>
                            <select id="certSelect" name="certId" required>
                                <c:forEach var="cert" items="${examCertNames}">
                                    <option value="${cert.id}">${cert.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div id="step3" class="step w-full px-20 py-4 text-lg p-8">
                        <div class="my-6 text-4xl font-black">랜덤 또는 기출 방식 중 원하는 문제 풀이 방식을 선택하세요.</div>
                        <div class="mode-toggle flex justify-around mt-36">
                            <div class="relative">
                                <input type="radio" name="mode" id="modeRandom" value="random" hidden>
                                <label for="modeRandom" class="toggle-btn">랜덤</label>
                                <div class="questionCountSelectBox invisible absolute left-1/2 transform -translate-x-1/2 whitespace-nowrap"
                                     style="top: 200%;">
                                    <label for="questionCount"></label>
                                    <select id="questionCount" name="questionCount" required>
                                        <option value="-1" selected disabled>풀 문제 개수 선택</option>
                                        <option value="20">20문제</option>
                                        <option value="50">50문제</option>
                                        <option value="100">100문제</option>
                                        <option value="0">모든 문제 풀기</option>
                                    </select>
                                </div>
                            </div>
                            <div class="relative">
                                <input type="radio" name="mode" id="modePast" value="past" hidden>
                                <label for="modePast" class="toggle-btn">기출문제 선택</label>
                                <div class="examIdSelectBox invisible absolute left-1/2 transform -translate-x-1/2 whitespace-nowrap"
                                     style="top: 200%;">
                                    <label for="examId"></label>
                                    <select id="examId" name="examId" required>
                                        <option value="-1" selected></option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <script>
                            $(function () {
                                $('input[name="mode"]').change(function () {
                                    const selectedMode = $('input[name="mode"]:checked').val();
                                    if (selectedMode === 'random') {
                                        $('.questionCountSelectBox').removeClass("invisible");
                                        $('.examIdSelectBox').addClass("invisible");
                                    } else if (selectedMode === 'past') {
                                        $('.examIdSelectBox').removeClass("invisible");
                                        $('.questionCountSelectBox').addClass("invisible");

                                        const certId = $('#certSelect').val();
                                        if (!certId) {
                                            alert("먼저 자격증을 선택해주세요.");
                                            return;
                                        }

                                        // AJAX 요청으로 기출시험 목록 불러오기
                                        $.ajax({
                                            url: '/usr/api/examByCertId',
                                            method: 'GET',
                                            data: {certId: certId},
                                            success: function (data) {
                                                const exams = data.data1;
                                                const $examSelect = $('#examId');
                                                $examSelect.empty();
                                                if (exams.length === 0) {
                                                    $examSelect.append('<option value="">해당 자격증의 기출시험이 없습니다.</option>');
                                                } else {
                                                    $examSelect.append('<option value="-1" selected disabled>기출시험 선택</option>');
                                                    exams.forEach(function (exam) {
                                                        const $option = $('<option></option>');
                                                        $option.val(exam.id);
                                                        $option.text(exam.extra__certName + ' ' + exam.examDate);
                                                        $examSelect.append($option);
                                                    });
                                                }
                                            },
                                            error: function () {
                                                alert("기출시험 목록을 불러오는 데 실패했습니다.");
                                            }
                                        });
                                    }
                                });
                            });
                        </script>
                    </div>
                    <div id="step4" class="step h-5/6 w-full px-20 py-4 text-xl p-8">
                        <div class="my-6 text-4xl font-black">문제 풀이를 시작합니다.</div>
                    </div>
                    <div class="absolute bottom-12 left-12">
                        <button type="button" onclick="prevStep()" id="prevBtn"
                                class="bg-grey-2 rounded-xl hover:bg-gray-300 px-6 py-4 text-base hidden">
                            이전
                        </button>
                    </div>
                    <div class="absolute bottom-12 right-12">
                        <button type="button" onclick="nextStep()" id="nextBtn"
                                class="bg-grey-2 rounded-xl hover:bg-gray-300 px-6 py-4 text-base">
                            다음
                        </button>
                        <button type="submit" id="startBtn"
                                class="bg-red-300 rounded-xl hover:bg-red-400 px-6 py-4 text-base bottom-2 right-12 hidden">
                            시작하기
                        </button>
                    </div>

                </form>
            </div>
            <div></div>
        </div>

    </div>

    <%--    <div class="side hidden xl:block w-20 bg-grey-1"></div>--%>
    <div class="block min-[1280px]:hidden w-1/12 bg-grey-1"></div>
</div>

<script>
    const steps = document.querySelectorAll(".step");

    function getCurrentStepIndex() {
        for (let i = 0; i < steps.length; i++) {
            if (steps[i].classList.contains("active")) {
                return i;
            }
        }
        return 0;
    }

    function showStep(index) {
        steps.forEach((step, i) => {
            // 단계
            step.classList.remove("active");
            step.classList.remove("end");
            if (i === index) {
                step.classList.add("active");
            } else if (i < index) {
                step.classList.add("end");
            }
        });

        const prevBtn = $("#prevBtn");
        const nextBtn = $("#nextBtn");
        const startBtn = $("#startBtn");

        // 이전 버튼
        if (index === 0) {
            prevBtn.addClass("hidden");
        } else {
            prevBtn.removeClass("hidden");
        }

        // 다음 버튼
        if (index === steps.length - 1) {
            nextBtn.addClass("hidden");
            startBtn.removeClass("hidden")
        } else {
            nextBtn.removeClass("hidden");
            startBtn.addClass("hidden")
        }
    }

    function prevStep() {
        const currentStep = getCurrentStepIndex();

        if (currentStep > 0) {
            showStep(currentStep - 1);
        }
    }

    function nextStep() {
        const currentStep = getCurrentStepIndex();

        const loginedMemberId = ${loginedMemberId != null ? loginedMemberId : 0};
        const loginUri = '${loginUri}';

        console.log(loginedMemberId);
        console.log(loginUri);

        if (loginedMemberId === 0) {
            alert("로그인 후 이용 가능합니다.");
            window.location.href = loginUri;
            console.log(loginUri);
            return;
        }

        if (currentStep === 1) {
            const cert = document.getElementById("certSelect").value;
            if (!cert) {
                alert("자격증과 과목을 선택해주세요.");
                return;
            }
        }

        if (currentStep === 2) {
            const modeElement = document.querySelector("input[name='mode']:checked");

            if (!modeElement) {
                alert("풀이 방식을 선택해주세요.");
                return;
            }
            const mode = modeElement.value;
            const questionCount = document.getElementById("questionCount")?.value;
            const examId = document.getElementById("examId")?.value;

            if (mode === "random") {

                if (!questionCount || questionCount < 0) {
                    alert("문제 수를 입력해주세요.");
                    return;
                }
            } else if (mode === "past") {
                if (!examId || examId < 0) {
                    alert("기출시험을 선택해주세요.");
                    return;
                }
            }
        }

        if (currentStep < steps.length - 1) {
            showStep(currentStep + 1);
        }
    }

</script>


<%@ include file="../common/foot.jspf" %>