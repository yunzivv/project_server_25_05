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
        $('.side_bar_left > .workbook_sub_menu > li:nth-child(1) > a').addClass('active');
        $('.side_bar_left > .workbook_sub_menu > li:nth-child(1) > a > i').addClass('active');
    });

</script>

<div class="flex w-full">
    <div class="side hidden xl:block shrink-0" style="width: 250px;">
        <%@ include file="../common/side.jspf" %>
    </div>
    <div class="block min-[1280px]:hidden w-1/12"></div>

    <div class="flex-grow"><%--style="height: calc(100vh - 100px);"--%>

        <div class="mx-auto my-16 w-9/12" style="height: 600px;">

            <ol class="flex items-center w-full px-20 mb-6">
                <!-- Step 1 -->
                <li class="flex items-center w-full">
                    <span class="flex items-center justify-center w-10 h-10 bg-blue-2 rounded-full lg:w-12 lg:h-12 shrink-0">
                        <i class="fa-solid fa-crosshairs text-grey-1 text-xl"></i>
                        <i class="fa-solid fa-check text-xl text-grey-1 hidden"></i>
                    </span>
                    <div class="flex-1 h-1 bg-grey-3 mx-2 rounded overflow-hidden">
                        <div class="progress-bar h-full bg-blue-2 transition-all duration-700 ease-in-out w-0"></div>
                    </div>
                </li>

                <!-- Step 2 -->
                <li class="flex items-center w-full">
                        <span class="flex items-center justify-center w-10 h-10 bg-grey-1 rounded-full lg:h-12 lg:w-12 shrink-0">
                            <i class="fa-solid fa-address-card text-grey-5 text-xl"></i>
                            <i class="fa-solid fa-check text-xl text-grey-1 hidden"></i>
                        </span>
                    <div class="flex-1 h-1 bg-grey-3 mx-2 rounded overflow-hidden">
                        <div class="progress-bar h-full bg-blue-2 transition-all duration-700 ease-in-out w-0"></div>
                    </div>
                </li>

                <!-- Step 3 -->
                <li class="flex items-center w-full">
                        <span class="flex items-center justify-center w-10 h-10 bg-grey-1 rounded-full lg:h-12 lg:w-12 shrink-0">
                            <i class="fa-solid fa-gears text-grey-5 text-xl"></i>
                            <i class="fa-solid fa-check text-xl text-grey-1 hidden"></i>
                        </span>
                    <div class="flex-1 h-1 bg-grey-3 mx-2 rounded overflow-hidden">
                        <div class="progress-bar h-full bg-blue-2 transition-all duration-700 ease-in-out w-0"></div>
                    </div>
                </li>

                <!-- Step 4 -->
                <li class="flex items-center">
                        <span class="flex items-center justify-center w-10 h-10 bg-grey-1 rounded-full lg:h-12 lg:w-12 shrink-0">
                            <i class="fa-solid fa-play text-grey-5 text-xl"></i>
                        </span>
                </li>
            </ol>
            <div id="examInputForm" class="overflow-hidden h-full px-16 py-10 rounded-2xl bg-grey-1">
                <form action="showExam" class="h-full relative">
                    <div>
                        <div id="examStep1" class="step w-full text-xl active" style="height: 460px;">
                            <div class="mt-6 mb-10 text-4xl font-semibold">어떤 <span class="text-blue-2">자격증</span>을 준비
                                중이신가요?
                            </div>
                            <div class="m-2">준비된 문제 유형을 선택해 바로 학습을 시작해보세요!</div>
                            <div class="m-2">문제를 풀자마자 정답 여부를 바로 확인할 수 있어요.</div>
                        </div>

                        <div id="examStep2" class="step w-full text-lg flex flex-col" style="height: 460px;">
                            <div class="my-6 text-4xl font-black">자격증을 선택하고 문제 풀이를 시작하세요.</div>
                            <div class="flex justify-end">
                                <div class="flex items-center h-12 border-grey-3 rounded-md px-2 bg-white relative">
                                    <input type="hidden" name="certId" id="certIdHidden_workbook">
                                    <input type="text" name="certName" id="certNameInput_workbook" placeholder="자격증 검색"
                                           autocomplete="off" class="focus:outline-none"/>
                                    <div id="autocompleteBox_workbook"
                                         class="absolute top-full left-1/2 w-full transform -translate-x-1/2
                                         border-grey-2 bg-white shadow-md rounded-b-md max-h-48 overflow-y-auto hidden z-20">
                                    </div>
                                    <button type="button" class="text-grey-5 mr-2">
                                        <i class="fa-solid fa-magnifying-glass"></i>
                                    </button>
                                </div>

                                <script>
                                    function searchCertName() {
                                        const keyword = $.trim($("#certNameInput_workbook").val());
                                        if (keyword.length < 2) return;

                                        const box = $("#autocompleteBox_workbook");
                                        const input = $("#certNameInput_workbook");

                                        $.getJSON("/usr/workbook/autoComplete", {keyword: keyword}, function (data) {
                                            box.empty();

                                            if (data.length === 0) {
                                                box.hide();
                                                return;
                                            }

                                            $.each(data, function (i, cert) {
                                                $("<div>")
                                                    .text(cert.extra__certName)
                                                    .css({
                                                        padding: "5px",
                                                        cursor: "pointer"
                                                    })
                                                    .on("click", function () {
                                                        input.val(cert.extra__certName);
                                                        $("#certIdHidden_workbook").val(cert.certId);
                                                        box.hide();
                                                        if (typeof activateCertFromAutoComplete === "function") {
                                                            activateCertFromAutoComplete(cert.certId, cert.extra__certName);
                                                        }
                                                    }).appendTo(box);
                                            });

                                            box.show();
                                        });
                                    }

                                    $(document).ready(function () {
                                        $("#certNameInput_workbook").on("input", searchCertName);
                                        $("#searchBtn_workbook").on("click", searchCertName);

                                        // 바깥 클릭 시 자동완성 박스 숨기기
                                        $(document).on("click", function (e) {
                                            const box = $("#autocompleteBox_workbook");
                                            const input = $("#certNameInput_workbook");

                                            if (!box.is(e.target) && box.has(e.target).length === 0 && !input.is(e.target)) {
                                                box.hide();
                                            }
                                        });
                                    });

                                </script>
                            </div>
                            <div class="flex-grow m-3 flex flex-col relative overflow-hidden">

                                <!-- 인덱스 탭 -->
                                <div class="pb-2" id="cert-index-tabs">
                                    <div class="flex justify-around">
                                        <c:forEach var="key" items="${certIndexMap.keySet()}">
                                            <button type="button"
                                                    class="cert-index-btn px-3 py-1 rounded-lg hover:bg-blue-200"
                                                    data-key="${key}">
                                                    ${key}
                                            </button>
                                        </c:forEach>
                                    </div>
                                </div>

                                <!-- 자격증 리스트 -->
                                <div class="flex-grow overflow-y-auto h-60">
                                    <c:forEach var="entry" items="${certIndexMap}">
                                        <div class="cert-group w-full hidden p-3 border-grey-3 rounded-xl"
                                             data-key="${entry.key}">
                                            <div class="cert-list-wrapper overflow-y-auto max-h-52">
                                                <div class="flex flex-wrap">
                                                    <c:forEach var="cert" items="${entry.value}">
                                                        <div class="cert-option p-2 my-2 rounded hover:bg-blue-100 cursor-pointer w-1/4"
                                                             data-id="${cert.id}" data-name="${cert.name}"
                                                             data-key="${entry.key}">
                                                                ${cert.name}
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>

                            </div>

                        </div>

                        <div id="examStep3" class="step w-full text-lg" style="height: 460px;">
                            <div class="my-6 text-4xl font-black">랜덤 또는 기출 방식 중 원하는 문제 풀이 방식을 선택하세요.</div>
                            <div class="mode-toggle flex justify-around gap-6">
                                <!-- 랜덤 카드 -->
                                <div class="w-1/2 p-6 border rounded-xl bg-white hover:shadow-md cursor-pointer relative"
                                     id="cardRandom" style="height: 330px;">
                                    <input type="radio" name="mode" value="random" id="modeRandom" hidden>
                                    <label for="modeRandom" class="block text-xl font-bold mb-4">랜덤 문제 풀이</label>

                                    <!-- 랜덤 슬라이더 영역 -->
                                    <div id="randomOptions" class="hidden mt-4">

                                        <input type="range" id="sliderQuestionCount" min="10" max="100" step="10"
                                               value="10" class="w-full accent-blue-500">
                                        <div class="text-center mt-2 font-semibold text-blue-700" id="sliderDisplay">
                                            10문제
                                        </div>

                                        <input type="hidden" name="questionCount" id="questionCount" value="10">
                                    </div>
                                </div>

                                <!-- 기출 카드 -->
                                <div id="cardPast"
                                     class="w-1/2 p-6 border rounded-xl bg-white hover:shadow-md cursor-pointer"
                                     style="height: 330px;">
                                    <input type="radio" name="mode" value="past" id="modePast" hidden>
                                    <label for="modePast" class="block text-xl font-bold mb-4">기출 회차 풀이</label>

                                    <div id="pastOptions"
                                         class="transition-opacity duration-300 opacity-0 pointer-events-none max-h-56 overflow-y-auto space-y-2">
                                        <div class="text-gray-500">불러오는 중...</div>
                                    </div>
                                    <input type="hidden" name="examId" id="examId" value="-1">
                                </div>
                            </div>

                            <script>
                                $(document).ready(function () {
                                    // 카드 클릭 시 라디오 버튼 수동 체크 + change 이벤트 트리거
                                    $('#cardRandom').on('click', function () {
                                        $('#cardRandom').removeClass("bg-white").addClass("bg-blue-50");
                                        $('#cardPast').removeClass("bg-blue-50").addClass("bg-white");
                                        $('#modeRandom').prop('checked', true).trigger('change');
                                    });

                                    $('#cardPast').on('click', function () {
                                        $('#cardPast').removeClass("bg-white").addClass("bg-blue-50");
                                        $('#cardRandom').removeClass("bg-blue-50").addClass("bg-white");
                                        $('#modePast').prop('checked', true).trigger('change');
                                    });

                                    // 라디오 버튼 변경 시 UI 처리
                                    $('input[name="mode"]').change(function () {
                                        const selected = $(this).val();

                                        if (selected === 'random') {
                                            $('#randomOptions').removeClass('hidden');
                                            $('#pastOptions').addClass('opacity-0 pointer-events-none');
                                        }

                                        if (selected === 'past') {
                                            $('#randomOptions').addClass('hidden');
                                            $('#pastOptions').removeClass('opacity-0 pointer-events-none');

                                            const certId = $('#certIdHidden_workbook').val();
                                            if (!certId) {
                                                alert("자격증을 먼저 선택해주세요.");
                                                return;
                                            }

                                            const $container = $('#pastOptions');
                                            $container.html('<div class="text-gray-400">불러오는 중...</div>');

                                            $.get('/usr/api/examByCertId', {certId}, function (data) {
                                                $container.empty();
                                                const exams = data.data1;

                                                if (!exams || exams.length === 0) {
                                                    return $container.append('<div class="text-red-500">기출시험이 없습니다.</div>');
                                                }

                                                exams.forEach(exam => {
                                                    const $btn = $('<button type="button" class="exam-btn w-full bg-white border-grey-3 hover:bg-blue-300 px-4 py-2 rounded text-left"></button>')
                                                        .text(exam.extra__certName + ' ' + exam.examDate)
                                                        .on('click', function () {
                                                            $('#examId').val(exam.id);
                                                            $('.exam-btn').removeClass('bg-blue-500 text-white').addClass('bg-blue-100 text-black');
                                                            $(this).addClass('bg-blue-500 text-white').removeClass('bg-blue-100 text-black');
                                                        });

                                                    $container.append($btn);
                                                });
                                            });
                                        }
                                    });

                                    // 슬라이더 변경 시 문제 수 텍스트 업데이트
                                    $('#randomOptions input[type="range"]').on('input', function () {
                                        const val = $(this).val();
                                        $('#randomOptions .text-center').text(val + '문제');
                                    });
                                });
                            </script>
                        </div>

                        <div id="examStep4" class="step h-5/6 w-full text-xl" style="height: 460px;">
                            <div class="my-6 text-4xl font-black">문제 풀이를 시작합니다.</div>
                        </div>

                        <div class="absolute bottom-0 left-0">
                            <button type="button" onclick="prevStep()" id="prevBtn"
                                    class="w-14 h-14 flex items-center justify-center bg-white text-grey-100 rounded-full hover:bg-gray-300 hidden">
                                <i class="fa-solid fa-chevron-left"></i>
                            </button>
                        </div>
                    </div>
                    <div class="absolute bottom-0 right-0">
                        <button type="button" onclick="nextStep()" id="nextBtn"
                                class="w-14 h-14 flex items-center justify-center bg-white text-grey-100 rounded-full hover:bg-gray-300">
                            <i class="fa-solid fa-chevron-right"></i>
                        </button>
                        <button type="submit" id="startBtn"
                                class="w-14 h-14 flex items-center justify-center bg-blue-2 text-grey-1 rounded-full hover:bg-gray-300 hidden">
                            <i class="fa-solid fa-play"></i>
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
    $(document).ready(function () {
        const $steps = $(".step");

        function updateStepperUI(index) {
            const $stepperItems = $("ol > li"); // stepper 상단 li들

            $stepperItems.each(function (i) {
                const li = $(this);
                const circle = li.find("span");
                const progressBar = li.find(".progress-bar");
                const icons = circle.find("i");

                const mainIcon = icons.not(".fa-check");
                const checkIcon = icons.filter(".fa-check");

                // 초기화
                circle.removeClass("bg-blue-2").addClass("bg-grey-1");
                mainIcon.removeClass("text-grey-1").addClass("text-grey-5").removeClass("hidden");
                checkIcon.addClass("hidden");
                progressBar.removeClass("w-full").addClass("w-0");

                if (i === index) {
                    // 현재 단계
                    circle.removeClass("bg-grey-1").addClass("bg-blue-2");
                    mainIcon.removeClass("text-grey-5").addClass("text-grey-1").removeClass("hidden");
                    checkIcon.addClass("hidden");
                } else if (i < index) {
                    // 지난 단계
                    circle.removeClass("bg-grey-1").addClass("bg-blue-2");
                    mainIcon.addClass("hidden");
                    checkIcon.removeClass("hidden");
                    progressBar.removeClass("w-0").addClass("w-full");
                }
            });
        }


        $("#startBtn").on("click", function (e) {
            e.preventDefault(); // 기본 submit 막고 수동 제출

            const certId = $("#certIdHidden_workbook").val();
            if (!certId) {
                alert("자격증을 선택해주세요.");
                return;
            }

            const $mode = $("input[name='mode']:checked");
            if ($mode.length === 0) {
                alert("풀이 방식을 선택해주세요.");
                return;
            }

            const mode = $mode.val();

            if (mode === "random") {
                const count = $("#questionCount").val();
                if (!count || count < 0) {
                    alert("문제 수를 선택해주세요.");
                    return;
                }
            } else if (mode === "past") {
                const examId = $("#examId").val();
                if (!examId || examId < 0) {
                    alert("기출시험을 선택해주세요.");
                    return;
                }
            }

            // 모든 조건 통과 시 form 제출
            $(this).closest("form").submit();
        });

        function getCurrentStepIndex() {
            let index = 0;
            $steps.each(function (i) {
                if ($(this).hasClass("active")) {
                    index = i;
                    return false; // break
                }
            });
            return index;
        }

        $(function () {
            $('#questionCount').on('input', function () {
                const val = $(this).val();
                $('#questionCountDisplay').text(val + '문제');
            });

            $('input[name="mode"]').change(function () {
                const selectedMode = $('input[name="mode"]:checked').val();
                if (selectedMode === 'random') {
                    $('.questionCountSelectBox').removeClass("invisible");
                    $('.examIdSelectBox').addClass("invisible");
                } else if (selectedMode === 'past') {
                    $('.examIdSelectBox').removeClass("invisible");
                    $('.questionCountSelectBox').addClass("invisible");
                    // 기존 AJAX 로직 유지
                }
            });
        });

        function showStep(index) {
            $steps.each(function (i) {
                const $step = $(this);
                $step.removeClass("active end");
                if (i === index) {
                    $step.addClass("active");
                } else if (i < index) {
                    $step.addClass("end");
                }
            });

            updateStepperUI(index);

            const $prevBtn = $("#prevBtn");
            const $nextBtn = $("#nextBtn");
            const $startBtn = $("#startBtn");

            // 이전 버튼
            if (index === 0) {
                $prevBtn.addClass("hidden");
            } else {
                $prevBtn.removeClass("hidden");
            }

            // 다음 버튼
            if (index === $steps.length - 1) {
                $nextBtn.addClass("hidden");
                $startBtn.removeClass("hidden");
            } else {
                $nextBtn.removeClass("hidden");
                $startBtn.addClass("hidden");
            }
        }

        window.prevStep = function () {
            const currentStep = getCurrentStepIndex();
            if (currentStep > 0) {
                showStep(currentStep - 1);
            }
        };

        window.nextStep = function () {
            const currentStep = getCurrentStepIndex();

            const loginedMemberId = ${loginedMemberId != null ? loginedMemberId : 0};
            const loginUri = '${loginUri}';

            if (loginedMemberId === 0) {
                alert("로그인 후 이용 가능합니다.");
                window.location.href = loginUri;
                return;
            }

            if (currentStep === 1) {
                const cert = $("#certIdHidden_workbook").val();
                if (!cert) {
                    alert("자격증을 선택해주세요.");
                    return;
                }
            }

            if (currentStep === 2) {
                const $mode = $("input[name='mode']:checked");
                if ($mode.length === 0) {
                    alert("풀이 방식을 선택해주세요.");
                    return;
                }

                const mode = $mode.val();
                const questionCount = $("#questionCount").val();
                const examId = $("#examId").val();

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

            if (currentStep < $steps.length - 1) {
                showStep(currentStep + 1);
            }
        };
    });
</script>

<%--index tab--%>
<script>
    document.addEventListener("DOMContentLoaded", () => {
        const buttons = document.querySelectorAll(".cert-index-btn");
        const groups = document.querySelectorAll(".cert-group");

        buttons.forEach(btn => {
            btn.addEventListener("click", () => {
                const key = btn.dataset.key;

                groups.forEach(g => {
                    const isMatched = g.dataset.key === key;
                    g.style.display = g.dataset.key === key ? "block" : "none";
                });

                buttons.forEach(b => b.classList.remove("text-blue-2", "bg-grey-3"));

                btn.classList.add("text-blue-2", "bg-blue-100");
            });
        });
    });
</script>

<script>
    document.addEventListener("DOMContentLoaded", () => {
        const certIdInput = document.getElementById("certIdHidden_workbook");
        const certNameInput = document.getElementById("certNameInput_workbook");

        function clearCertActive() {
            document.querySelectorAll(".cert-option").forEach(el => {
                el.classList.remove("bg-blue-100", "text-blue-2");
            });
        }

        function activateCert(certId, certName) {
            certIdInput.value = certId;
            certNameInput.value = certName;

            clearCertActive();

            const matched = [...document.querySelectorAll(".cert-option")]
                .find(el => el.dataset.id === String(certId));

            if (matched) {
                matched.classList.add("bg-blue-100", "text-blue-2");

                const key = matched.dataset.key;

                // 보여줄 cert-group 설정
                document.querySelectorAll(".cert-group").forEach(group => {
                    group.style.display = group.dataset.key === key ? "block" : "none";
                });

                // 인덱스 탭 버튼 강조
                document.querySelectorAll(".cert-index-btn").forEach(btn => {
                    if (btn.dataset.key === key) {
                        btn.classList.add("text-blue-2", "bg-blue-100");
                    } else {
                        btn.classList.remove("text-blue-2", "bg-blue-100");
                    }
                });

            } else {
                console.warn("❌ 자격증 목록에서 certId 못 찾음", certId);
            }
        }

        // 리스트에서 자격증 클릭 시
        document.querySelectorAll(".cert-option").forEach(el => {
            el.addEventListener("click", () => {
                const certId = el.dataset.id;
                const certName = el.dataset.name;
                activateCert(certId, certName);
            });
        });

        // 자동완성에서 사용 가능하게 등록
        window.activateCertFromAutoComplete = activateCert;
    });
</script>


<%@ include file="../common/foot.jspf" %>