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
        <div class="flex flex-grow flex-col items-center pt-20" style="border-top-left-radius: 3rem;">

            <div id="cert" class="w-2/3 bg-green-300 h-screen">
                <div class="flex">
                    총 자격증: ${certs.size()}개
                    <div class="flex-grow"></div>
                    <button onclick=""
                            class="block ml-6 px-5 whitespace-nowrap text-base flex items-center justify-center font-large rounded-md hover:bg-neutral-300">
                        자격증 등록
                    </button>
                </div>
                <div>
                    <label class="inline-flex items-center cursor-pointer">
                        <span class="mr-6">만료일 알림 설정</span>
                        <input type="checkbox" value="" class="sr-only peer">
                        <div class="relative w-11 h-6 bg-gray-200 peer-focus:outline-none peer-focus:ring-4 peer-focus:ring-blue-300 dark:peer-focus:ring-blue-800 rounded-full peer dark:bg-gray-700 peer-checked:after:translate-x-full rtl:peer-checked:after:-translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:start-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all dark:border-gray-600 peer-checked:bg-blue-600 dark:peer-checked:bg-blue-600"></div>
                    </label>

                </div>
                    <%--알림설정 관리--%>
                <div>
                    <form action="/usr/cert/doAdd" method="post" class="relative">
                        <input type="hidden" name="certId" id="certIdHidden_myCert">
                        <input type="text" name="certName" id="certNameInput_myCert" placeholder="자격증명"
                               autocomplete="off">

                        <script>
                            $(document).ready(function () {
                                $("#certNameInput_myCert").on("input", function () {
                                    const keyword = $.trim($(this).val());
                                    if (keyword.length < 2) return;

                                    const box = $("#autocompleteBox_myCert");
                                    const input = $("#certNameInput_myCert");
                                    const form = input.closest("form");

                                    $.getJSON("/usr/cert/autoComplete", {keyword: keyword}, function (data) {
                                        console.log(data);
                                        box.empty();

                                        if (data.length === 0) {
                                            box.hide();
                                            return;
                                        }

                                        $.each(data, function (i, cert) {
                                            const item = $("<div>")
                                                .text(cert.name) // ✅ certificate.name 출력
                                                .css({
                                                    padding: "5px",
                                                    cursor: "pointer"
                                                })
                                                .on("click", function () {
                                                    input.val(cert.name); // ✅ 입력창에 name
                                                    $("#certIdHidden_myCert").val(cert.id); // ✅ 숨겨진 input에 id
                                                    box.hide();
                                                });

                                            box.append(item);
                                        });

                                        const inputOffset = input.offset();
                                        const formOffset = form.offset();

                                        const left = inputOffset.left - formOffset.left;
                                        const top = inputOffset.top + input.outerHeight() - formOffset.top;

                                        box.css({
                                            left: left + "px",
                                            top: top + "px",
                                            width: input.outerWidth(),
                                            position: "absolute",
                                            background: "#fff",
                                            zIndex: 1000
                                        }).show();
                                    });
                                });

                                $(document).on("click", function (e) {
                                    const box = $("#autocompleteBox_myCert");
                                    const input = $("#certNameInput_myCert");

                                    if (!box.is(e.target) && box.has(e.target).length === 0 && !input.is(e.target)) {
                                        box.hide();
                                    }
                                });
                            });
                        </script>

                        <div id="autocompleteBox_myCert"
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
                            <td class="px-5 py-3">
                                <button class="px-3 py-2 mr-2 rounded-md border-grey-2" onClick="">
                                    수정
                                </button>
                                <button class="px-3 py-2 mr-2 rounded-md border-grey-2" onClick="">
                                    삭제
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

            </div>

                <%--            <div id="article" class="h-screen bg-blue-400"></div>--%>


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
        } else {
            document.location.href = "../member/login";
        }

    });

</script>

<%@ include file="../common/foot.jspf" %>
