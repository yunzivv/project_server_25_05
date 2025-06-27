<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="MY CERT"></c:set>
<%@ include file="../common/head.jspf" %>

<script>
    $(document).ready(function () {

        $('.header').addClass('active');
        $('.nav_box > ul > li:nth-child(4) i').addClass('active');

        $('.side_bar_left').addClass('active');
        $('.side_bar_left > .myPage_sub_menu ').removeClass('hidden');
    });
</script>

<div class="flex w-full">
    <div class="side hidden xl:block shrink-0" style="width: 250px;">
        <%@ include file="../common/side.jspf" %>
    </div>
    <div class="block min-[1280px]:hidden w-1/12"></div>

    <div class="flex flex-grow flex-col items-center pt-20" style="border-top-left-radius: 3rem;">
        <div id="cert" class="w-2/3 h-screen flex flex-col">
            <div class="">
                총 자격증: ${certs.size()}개
            </div>
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
                                            .text(cert.name)
                                            .css({
                                                padding: "5px",
                                                cursor: "pointer"
                                            })
                                            .on("click", function () {
                                                input.val(cert.name);
                                                $("#certIdHidden_myCert").val(cert.id);
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
            <div class="carousel-wrapper mt-10 w-2/3">
            <div class="bg-blue-300 owl-carousel">
                <c:forEach var="cert" items="${certs }">
                    <div class="p-3 rounded-xl overflow-hidden bg-red-300 shadow-md"
                         style="width: 500px; height: 313px;">
                        <div class="cardHead h-1/6 text-center text-3xl font-bold text-grey-100 tracking-widest">
                            회원정보자격
                        </div>
                        <div class="flex h-2/3">
                            <div class="img w-1/3 h-full p-4 border border-solid">사진</div>
                            <div class="info flex flex-col justify-between w-2/3 h-full text-lg p-5">
                                <span>성    명: ${member.name}</span>
                                    <%--                                <span>생년월일: ${member.birthday}</span>--%>
                                <span>가입일자: ${member.regDate.toString().substring(0, 10)}</span>
                                <span>전화번호: ${member.cellPhone.toString().substring(0, 3)}-${member.cellPhone.toString().substring(3, 7)}-${member.cellPhone.toString().substring(7)}</span>
                                <span>이 메 일: ${member.email}</span>
                            </div>
                        </div>
                        <div class="cardBottom h-1/6 flex justify-between items-end p-2 text-right">
                            <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
                            <div class="font-black text-lg text-Kakao3">CERTIFY</div>
                            <a href="modify"
                               class="rounded-md hover:bg-neutral-300 border border-neutral-300 px-3 py-1">수정</a>
                        </div>
                    </div>
                </c:forEach>
            </div></div>
            <table class="hidden">
                <thead class="h-5 text-grey-1 bg-neutral-800">
                <tr>
                    <th scope="col" class="px-6 py-4">NO</th>
                    <th scope="col" class="px-6 py-4">자격증명</th>
                    <th scope="col" class="px-6 py-4">자격번호</th>
                    <th scope="col" class="px-6 py-4">취득일</th>
                    <th scope="col" class="px-6 py-4">만료일</th>
                    <%--                    <th scope="col" class="px-6 py-4"></th>--%>
                    <th scope="col" class="px-6 py-4">설정</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="cert" items="${certs }">
                    <tr class="hover:bg-neutral-100 border-b-grey-1">
                        <td class="px-5 py-3">${cert.extra__rankNum }</td>
                        <td class="px-5 py-3">${cert.certname}</td>
                        <td class="px-5 py-3">${cert.certificateNumber}</td>
                        <td class="px-5 py-3">${cert.startDate.toString().substring(0, 10)}</td>
                        <td class="px-5 py-3">${cert.endDate.toString().substring(0, 10)}</td>

                            <%--                            /usr/member/settings/alertModeCert--%>
                        <td class="px-5 flex justify-center">
                            <button class="p-3 mr-2 rounded-md hover:bg-gray-200"
                                    onclick="confirmDelete(${cert.id})">
                                삭제
                            </button>
                            <label class="inline-flex items-center cursor-pointer">
                                <input type="checkbox"
                                       class="sr-only peer"
                                    ${cert.alert ? "checked" : ""}
                                       onchange="toggleAlertMode(${cert.id})">
                                <div class="relative w-11 h-6 bg-gray-200 rounded-full
                                    peer-checked:after:translate-x-full
                                    rtl:peer-checked:after:-translate-x-full
                                    peer-checked:after:border-white
                                    after:content-[''] after:absolute after:top-[2px] after:start-[2px]
                                    after:bg-white after:border-gray-300 after:border
                                    after:rounded-full after:h-5 after:w-5
                                    after:transition-all
                                    peer-checked:bg-blue-600">
                                </div>
                            </label>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="side hidden xl:block w-52"></div>
            <div class="block min-[1280px]:hidden w-1/12"></div>
        </div>
        <%--    <div class="side hidden xl:block w-28 bg-grey-1"></div>--%>
        <%--    <div class="block min-[1280px]:hidden w-1/12 bg-grey-1"></div>--%>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
<script>
    $(".owl-carousel").owlCarousel({
        items: 1,
        loop: true,
        nav: true,
        autoplay: false
    });
</script>

<%--알람설정 토글버튼--%>
<script>
    function toggleAlertMode(certId) {
        fetch("/usr/member/alertModeCert?memberCertId=" + certId, {
            method: 'POST'
        })
            .then(res => {
                if (!res.ok) throw new Error("요청 실패");
                return res.text();
            })
            .then(msg => {
            })
            .catch(err => {
                alert("알람 상태 변경 중 오류 발생");
                console.error(err);
            });
    }
</script>

<script>
    function confirmDelete(id) {
        if (confirm('정말 삭제하시겠습니까?')) {
            location.href = "../cert/doDelete?id=" + id;
        }
    }
</script>

<%@ include file="../common/foot.jspf" %>
