<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="MY PAGE"></c:set>
<%@ include file="../common/head.jspf" %>

<script>
    $(document).ready(function () {

        $('.header').addClass('active');
        $('.nav_box > ul > li:nth-child(4) i').addClass('active');

        $('.side_bar_left').addClass('active');
        $('.side_bar_left > .myPage_sub_menu ').removeClass('hidden');
        $('.side_bar_left > .myPage_sub_menu > li:nth-child(2) > a').addClass('active');
        $('.side_bar_left > .myPage_sub_menu > li:nth-child(2) > a > i').addClass('active');
    });
</script>
<link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css"
/>
<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>

<div class="flex w-full">
    <div class="side hidden xl:block shrink-0" style="width: 250px;">
        <%@ include file="../common/side.jspf" %>
    </div>

    <div class="flex-grow flex flex-col items-center pt-16" style="border-top-left-radius: 3rem;">
        <div id="cert" class="w-2/3 flex flex-col">
            <div>
                <div class="ml-12 mb-8 text-4xl font-bold">자격증 등록</div>
                <form action="/usr/cert/doAdd" method="post" class="relative border-grey-2 p-3 rounded-lg">
                    <input type="hidden" name="certId" id="certIdHidden_myCert">

                    <div class="flex gap-2">
                        <input type="text" name="certName" id="certNameInput_myCert" placeholder="자격증명"
                               autocomplete="off" class="flex-[1]"/>
                        <input type="text" name="certificateNumber" placeholder="자격번호" class="flex-[1]"/>
                        <input type="date" name="startDate" placeholder="취득일" class="flex-[0.5]"/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="date" name="endDate" placeholder="만료일" class="flex-[0.5]"/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <button type="submit" class="flex-[0.3] bg-gray-100 hover:bg-gray-200 rounded-md py-2 mx-2">등록
                        </button>
                    </div>

                    <div id="autocompleteBox_myCert"
                         style="border: 1px solid #ccc; display: none; position: absolute;"></div>
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
                </form>

            </div>
            <div class="mt-20 ml-12 text-4xl font-bold">내 자격증</div>
            <div class="ml-12 my-4 text-lg font-medium">총 자격증: ${certs.size()}개</div>
            <div class="swiper mySwiper mt-10 w-full max-w-[1500px]">
                <div class="swiper-wrapper">
                    <c:forEach var="cert" items="${certs}">
                        <div class="swiper-slide">
                            <div class="slide-card p-3 rounded-xl overflow-hidden bg-grey-1 shadow-md relative"
                                 style="width: 500px; height: 313px;">
                                <div class="cardCover w-full h-full absolute top-0 left-0 bg-white/50 z-10 transition-opacity pointer-events-none"></div>
                                <div class="cardHead h-1/6 text-center text-3xl font-bold text-grey-100 tracking-widest">
                                    회원정보자격
                                </div>
                                <div class="flex h-2/3">
                                    <div class="img w-1/3 h-full p-2"><img src="/image/user.png" alt="USER"></div>
                                    <div class="info flex flex-col justify-between w-2/3 h-full text-lg p-5">
                                        <span>자 격 명: ${cert.certname}</span>
                                        <span>자격번호: ${cert.certificateNumber}</span>
                                        <span>취 득 일: ${cert.startDate}</span>
                                        <span>만 료 일: ${cert.endDate}</span>
                                    </div>
                                </div>
                                <div class="cardBottom h-1/6 flex justify-between items-center p-2 text-center">
                                    <button class="px-3 py-2 rounded-md hover:bg-gray-200"
                                            onclick="confirmDelete(${cert.id})">삭제
                                    </button>
                                    <div class="font-black text-lg text-Kakao3">CERTIFY</div>
                                    <div class="flex items-center">
                                        알림&nbsp;&nbsp;
                                        <label class="inline-flex items-center cursor-pointer">
                                            <input type="checkbox" class="sr-only peer" ${cert.alert ? "checked" : ""}
                                                   onchange="toggleAlertMode(${cert.id})">
                                            <div class="relative w-11 h-6 bg-gray-200 rounded-full peer-checked:bg-blue-600 after:content-[''] after:absolute after:top-[2px] after:start-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:after:translate-x-full"></div>
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <!-- Navigation -->
                <div class="swiper-button-next"></div>
                <div class="swiper-button-prev"></div>
            </div>
        </div>
    </div>
</div>

<script>
    const swiper = new Swiper(".mySwiper", {
        slidesPerView: 3,
        spaceBetween: -80,
        centeredSlides: true,
        loop: true,
        speed: 600,
        allowTouchMove: false,
        navigation: {
            nextEl: ".swiper-button-next",
            prevEl: ".swiper-button-prev"
        },
        on: {
            slideChangeTransitionEnd: function () {
                document.querySelectorAll(".swiper-slide").forEach((slide, i) => {
                    const cover = slide.querySelector(".cardCover");
                    if (slide.classList.contains("swiper-slide-active")) {
                        cover?.classList.add("opacity-0");
                    } else {
                        cover?.classList.remove("opacity-0");
                    }
                });
            }
        }
    });
</script>

<style>
    .swiper-slide {
        transform: scale(0.85);
        transition: transform 0.4s ease;
        opacity: 0.5;
    }

    .swiper-slide.swiper-slide-active {
        transform: scale(1);
        opacity: 1;
        z-index: 10;
    }
</style>

<script>
    function toggleAlertMode(certId) {
        fetch("/usr/member/alertModeCert?memberCertId=" + certId, {method: "POST"})
            .then((res) => {
                if (!res.ok) throw new Error("요청 실패");
                return res.text();
            })
            .catch((err) => {
                alert("알람 상태 변경 중 오류 발생");
                console.error(err);
            });
    }

    function confirmDelete(id) {
        Swal.fire({
            title: '정말 삭제하시겠습니까?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#aaa',
            confirmButtonText: '삭제',
            cancelButtonText: '취소'
        }).then((result) => {
            if (result.isConfirmed) {
                location.href = "../cert/doDelete?id=" + id;
            }
        });
    }
</script>
