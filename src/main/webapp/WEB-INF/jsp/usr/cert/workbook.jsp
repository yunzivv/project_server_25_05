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

    <div class="flex-grow px-12 bg-red-300">

        <div class="bg-red-200 w-9/12" style="height: 680px;">
            <div>a</div>
            <div id="examInputForm" class="overflow-hidden h-full">
                <form action="showExam" class="relative bg-blue-300">

                    <div id="step1" class="step active">
                        자격증 선택하고 문제를 풀 수 있습니다.
                        <button type="button" onclick="nextStep()">다음</button>
                    </div>
                    <div id="step2" class="step">
                        자격증과 과목을 선택하세요
                        <div>
<%--                            <input type="hidden" name="certId" id="certIdHidden">--%>
<%--                            <div id="autocompleteBox"--%>
<%--                                 style="border: 1px solid #ccc; display: none; position: absolute; background: white;"></div>--%>
                            <select id="certSelect" name="certId" required>
                                <c:forEach var="cert" items="${examCertNames}">
                                    <option value="${cert.id}">${cert.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <button type="button" onclick="nextStep()">다음</button>
                    </div>
                    <div id="step3" class="step">
                        문제풀이 방식과 풀 문제 개수를 선택하세요
                        <div class="mode-toggle">
                            <input type="radio" name="mode" id="modeRandom" value="random" hidden>
                            <label for="modeRandom" class="toggle-btn">랜덤</label>

                            <input type="radio" name="mode" id="modePast" value="past" hidden>
                            <label for="modePast" class="toggle-btn">기출문제</label>
                        </div>

                        <label for="questionCount">문제 수 선택:</label>
                        <select id="questionCount" name="questionCount" required>
                            <option value="" selected disabled>선택하세요</option>
                            <option value="20">20문제</option>
                            <option value="50">50문제</option>
                            <option value="100">100문제</option>
                        </select>

                        <button type="button" onclick="nextStep()">다음</button>
                    </div>
                    <div id="step4" class="step">
                        문제 풀이를 시작합니다.
                        <button type="submit">다음</button>
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
            step.classList.remove("active");
            step.classList.remove("end");
            if (i === index) {
                step.classList.add("active");
            } else if (i < index) {
                step.classList.add("end");
            }
        });
    }

    function nextStep() {
        const currentStep = getCurrentStepIndex();

        if (currentStep === 1) {
            const cert = document.getElementById("certSelect").value;
            console.log(cert)
            if (!cert) {
                alert("자격증과 과목을 선택해주세요.");
                return;
            }
        }

        if (currentStep === 2) {
            const mode = document.querySelector("input[name='mode']:checked");
            console.log(mode.value);
            if (!mode) {
                alert("풀이 방식을 선택해주세요.");
                return;
            }

            const count = document.getElementById("questionCount")?.value;
            console.log(count);
            if (!count || count <= 0) {
                alert("문제 수를 입력해주세요.");
                return;
            }
        }

        if (currentStep < steps.length - 1) {
            showStep(currentStep + 1);
        }
    }

</script>



<%@ include file="../common/foot.jspf" %>