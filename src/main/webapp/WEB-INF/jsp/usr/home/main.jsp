<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="CERTIFY"></c:set>
<%@ include file="../common/head.jspf" %>
<%@ include file="../common/side.jspf"%>

<script>
    $(document).ready(function () {

        const header = $('.header');
        const topBar = $('.topBar');

        header.addClass('active');
        header.removeClass('bg-blue-1');
        header.addClass('bg-white');
        topBar.removeClass('text-white');
        topBar.addClass('text-blue-2');

        $('.hamburgerIcon').addClass("main");

    });
</script>

<script>
    let lastScroll = 0;
    const topBar = $('.header');

    $(window).on('scroll', function () {
        const currentScroll = window.pageYOffset;

        if (currentScroll > lastScroll) {
            topBar.css('transform', 'translateY(-100%)');
        } else {
            topBar.css('transform', 'translateY(0)');
        }

        lastScroll = currentScroll;
    });
</script>

<div>
    <div class="mainSection1 flex justify-center my-10">
        <div class="relative my-10 rounded-2xl overflow-hidden" style="width: 1500px; height: 581px;">
            <img src="/image/dd.png"
                 alt=""
                 style="width: 1500px; height: 581px; object-fit: cover;"/>
<%--            <div class="absolute bg-white rounded-br-2xl" style="width: 400px; height: 200px; top: 0; left: 0;">--%>
<%--                <div>--%>
<%--                    <div class="absolute" style="top: 0; left: 400px;">--%>
<%--                        <svg width="25" height="25" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">--%>
<%--                            <defs>--%>
<%--                                <mask id="cutout">--%>
<%--                                    <g transform="rotate(90 50 50)">--%>
<%--                                        <rect width="100" height="100" fill="white"/>--%>
<%--                                        <circle cx="100" cy="0" r="100" fill="black"/>--%>
<%--                                    </g>--%>
<%--                                </mask>--%>
<%--                            </defs>--%>
<%--                            <rect width="100" height="100" fill="#ffffff" mask="url(#cutout)"/>--%>
<%--                        </svg>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div>--%>
<%--                    <div class="absolute" style="top: 200px; left: 0;">--%>
<%--                        <svg width="25" height="25" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">--%>
<%--                            <defs>--%>
<%--                                <mask id="cutout">--%>
<%--                                    <g transform="rotate(90 50 50)">--%>
<%--                                        <rect width="100" height="100" fill="white"/>--%>
<%--                                        <circle cx="100" cy="0" r="100" fill="black"/>--%>
<%--                                    </g>--%>
<%--                                </mask>--%>
<%--                            </defs>--%>
<%--                            <rect width="100" height="100" fill="#ffffff" mask="url(#cutout)"/>--%>
<%--                        </svg>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
        </div>

    </div>

    <div class="mainSection2 my-32">
<%--    <div>CERTIFY에서 자격증의 모든 것을 함께하세요</div>--%>
        <div class="flex justify-center">
            <%--hub--%>
            <a href="../cert/analysis"
               class="helpMenu flex flex-col justify-between w-3/12 rounded-xl m-4 p-6 block">
                <div class="mb-6">
                    <div class="menuTitle text-3xl font-black mb-3">HUB</div>
                    취업공고에서 발췌한 우대 자격증을 직무별로 확인할 수 있습니다.
                </div>
                <div class="flex justify-between">
                    <div class="iconBox w-10 h-10 bg-grey-3 rounded-full flex items-center justify-center">
                        <i class="fa-solid fa-chevron-right text-white"></i>
                    </div>
                    <div class="w-[200px] h-[200px] self-end">
                        <img src="/image/diagram.png" alt="Diagram icon" class="w-full h-full object-contain">
                    </div>
                </div>
            </a>

            <%--workbook--%>
            <a href="../workbook/showWorkbook"
               class="helpMenu flex flex-col justify-between w-3/12 rounded-xl m-4 p-6 block">
                <div class="mb-6">
                    <div class="menuTitle text-3xl font-black mb-3">WORK BOOK</div>
                    원하는 자격증과 문제 풀이 방식을 선택하여 자격증 공부를 쉽게 할 수 있습니다.
                </div>
                <div class="flex justify-between">
                    <div class="iconBox w-10 h-10 bg-grey-3 rounded-full flex items-center justify-center">
                        <i class="fa-solid fa-chevron-right text-white"></i>
                    </div>
                    <div class="w-[200px] h-[200px] self-end">
                        <img src="/image/study.png" alt="Study icon" class="w-full h-full object-contain">
                    </div>
                </div>
            </a>

            <%--wallet--%>
            <a href="../member/myCert"
               class="helpMenu flex flex-col justify-between w-3/12 rounded-xl m-4 p-6 block">
                <div class="mb-6">
                    <div class="menuTitle text-3xl font-black mb-3">WALLET</div>
                    내 자격증을 등록하고 만료일 전 알람을 받아보세요.
                </div>
                <div class="flex justify-between">
                    <div class="iconBox w-10 h-10 bg-grey-3 rounded-full flex items-center justify-center">
                        <i class="fa-solid fa-chevron-right text-white"></i>
                    </div>
                    <div class="w-[200px] h-[200px] self-end">
                        <img src="/image/certificate.png" alt="Trophy icon" class="w-full h-full object-contain">
                    </div>
                </div>
            </a>

        </div>
    </div>
    <div></div>
</div>
<%@ include file="../common/foot.jspf" %>