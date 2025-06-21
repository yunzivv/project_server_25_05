<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="MY CERT"></c:set>
<%@ include file="../common/head.jspf" %>


<div class="flex w-full">
    <div class="side hidden xl:block shrink-0" style="width: 250px;">
        <%@ include file="../common/side.jspf" %>
    </div>
    <div class="block min-[1280px]:hidden w-1/12"></div>

    <c:if test="${ empty member}">
        <%--    <div class="flex justify-center items-center text-5xl font-semibold h-screen">--%>
        <%--        <span><a href="../member/login" class="text-blue-1">로그인</a>--%>
        <%--        하여 자격증을 쉽게 관리할 수 있습니다!</span>--%>
        <%--    </div>--%>

    </c:if>
    <c:if test="${not empty member}">
        <div class="flex flex-col flex-grow px-12" style="border-top-left-radius: 3rem;">

            <div id="cert" class="mt-10 px-2 bg-green-300 h-screen">
                <div class="flex">
                    총 자격증: ${certs.size()}개
                    <div class="flex-grow"></div>
                    <button onclick=""
                            class="block ml-6 px-5 whitespace-nowrap text-base flex items-center justify-center font-large rounded-md hover:bg-neutral-300">
                        자격증 등록
                    </button>
                </div>

                <div>
                    <form action="/usr/cert/doAdd" method="post" class="relative">
                        <input type="hidden" name="certId" id="certIdHidden">
                        <input type="text" name="certName" id="certNameInput" placeholder="자격증명" autocomplete="off">
                        <script>
                            document.getElementById("certNameInput").addEventListener("input", function () {
                                const keyword = this.value.trim();
                                if (keyword.length < 2) return;

                                const encodedKeyword = encodeURIComponent(keyword); // ✅ 여기서 JS 함수 사용
                                const box = document.getElementById("autocompleteBox");
                                const input = document.getElementById("certNameInput");
                                const form = input.closest("form");

                                fetch("/usr/cert/autoComplete?keyword=" + encodedKeyword)
                                    .then(res => res.json())
                                    .then(data => {
                                        console.log(data);

                                        box.innerHTML = "";

                                        if (data.length === 0) {
                                            box.style.display = "none";
                                            return;
                                        }

                                        data.forEach(cert => {
                                            const item = document.createElement("div");
                                            item.textContent = cert.name; // 필드명 맞으면 OK
                                            item.style.padding = "5px";
                                            item.style.cursor = "pointer";
                                            document.querySelectorAll("#certNameInput")

                                            item.addEventListener("click", () => {
                                                document.getElementById("certNameInput").value = cert.name;
                                                document.getElementById("certIdHidden").value = cert.id;
                                                box.style.display = "none";
                                            });

                                            box.appendChild(item);
                                        });

                                        // 위치 및 스타일 세팅
                                        const inputRect = input.getBoundingClientRect();
                                        const formRect = form.getBoundingClientRect();

                                        const left = inputRect.left - formRect.left;
                                        const top = inputRect.bottom - formRect.top;

                                        box.style.left = `${left}px`;
                                        box.style.top = `${top}px`;
                                        box.style.width = "191px";
                                        box.style.position = "absolute";
                                        box.style.background = "#fff";
                                        box.style.zIndex = "1000";
                                        box.style.display = "block";
                                    });
                                // 바깥 클릭 시 자동완성 박스 숨기기
                                document.addEventListener("click", function (e) {
                                    if (!box.contains(e.target) && e.target !== input) {
                                        box.style.display = "none";
                                    }
                                });
                            });
                        </script>
                        <div id="autocompleteBox"
                             style="border: 1px solid #ccc; display: none; position: absolute;"></div>

                        <input type="text" name="certificateNumber" placeholder="자격번호">
                        <input type="date" name="startDate" placeholder="취득일">
                        <input type="date" name="endDate" placeholder="만료일">
                        <button type="submit">확인</button>
                    </form>
                </div>
                <table>
                    <thead class="h-5 text-base text-neutral-200 bg-neutral-800">
                    <tr>
                        <th scope="col" class="px-6 py-4">NO</th>
                        <th scope="col" class="px-6 py-4">자격증명</th>
                        <th scope="col" class="px-6 py-4">자격번호</th>
                        <th scope="col" class="px-6 py-4">취득일</th>
                        <th scope="col" class="px-6 py-4">만료일</th>
                        <th scope="col" class="px-6 py-4"></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="cert" items="${certs }">
                        <tr class="border-b bg-neutral-200 border-neutral-300 hover:bg-neutral-300">
                            <td class="px-5 py-3">${cert.extra__rankNum }</td>
                            <td class="px-5 py-3">${cert.certname}</td>
                            <td class="px-5 py-3">${cert.certificateNumber}</td>
                            <td class="px-5 py-3">${cert.startDate.toString().substring(0, 10)}</td>
                            <td class="px-5 py-3">${cert.endDate.toString().substring(0, 10)}</td>
                            <td class="px-5 py-3">수정 삭제</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

            </div>

            <div id="article" class="h-screen bg-blue-400"></div>


            <div class="side hidden xl:block w-52"></div>
            <div class="block min-[1280px]:hidden w-1/12"></div>
        </div>
    </c:if>
    <%--    <div class="side hidden xl:block w-28 bg-grey-1"></div>--%>
    <%--    <div class="block min-[1280px]:hidden w-1/12 bg-grey-1"></div>--%>
</div>

<script>
    $(document).ready(function () {

        const memberExists = ${member != null ? 'true' : 'false'};
        $('.header').addClass('active');
        $('.nav_box > ul > li:nth-child(4) i').addClass('active');

        if (memberExists) {
            $('.side_bar_left').addClass('active');
            $('.side_bar_left > .myPage_sub_menu ').removeClass('hidden');
            $('.side_bar_left > .myPage_sub_menu > li:nth-child(2) > a').addClass('active');
            $('.side_bar_left > .myPage_sub_menu > li:nth-child(2) > a > i').addClass('active');
        }

    });
    <%--const input = document.getElementById("certNameInput");--%>
    <%--const hiddenInput = document.getElementById("certIdHidden");--%>
    <%--const box = document.getElementById("autocompleteBox");--%>
    <%--const encodedValue = encodeURIComponent(rawValue);--%>

    <%--clearTimeout(timer);--%>
    <%--timer = setTimeout(() => {--%>
    <%--    fetch(`/usr/cert/autoComplete?keyword=${encodedKeyword}`)--%>
    <%--        .then(res => res.json())--%>
    <%--        .then(data => {--%>
    <%--            console.log(data);--%>
    <%--            box.innerHTML = "";--%>
    <%--            if (data.length === 0) {--%>
    <%--                box.style.display = "none";--%>
    <%--                return;--%>
    <%--            }--%>

    <%--            data.forEach(cert => {--%>
    <%--                const item = document.createElement("div");--%>
    <%--                item.textContent = cert.name;--%>
    <%--                item.style.padding = "5px";--%>
    <%--                item.style.cursor = "pointer";--%>

    <%--                item.addEventListener("click", () => {--%>
    <%--                    input.value = cert.name;--%>
    <%--                    hiddenInput.value = cert.id;--%>
    <%--                    box.style.display = "none";--%>
    <%--                });--%>

    <%--                box.appendChild(item);--%>
    <%--            });--%>

    <%--            const rect = input.getBoundingClientRect();--%>
    <%--            box.style.left = `${rect.left}px`;--%>
    <%--            box.style.top = `${rect.bottom + window.scrollY}px`;--%>
    <%--            box.style.width = `${input.offsetWidth}px`;--%>
    <%--            box.style.position = "absolute";--%>
    <%--            box.style.background = "#fff";--%>
    <%--            box.style.zIndex = "1000";--%>
    <%--            box.style.display = "block";--%>
    <%--        });--%>
    <%--}, 300);--%>

    <%--document.addEventListener("click", function (e) {--%>
    <%--    if (!box.contains(e.target) && e.target !== input) {--%>
    <%--        box.style.display = "none";--%>
    <%--    }--%>
    <%--});--%>

</script>

<%@ include file="../common/foot.jspf" %>
