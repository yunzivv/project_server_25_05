<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="CERTIFY"></c:set>
<%@ include file="../common/head.jspf" %>


<script>
    $(document).ready(function () {
        $('.header').addClass('active');
    });
</script>

<div>
    <div></div>
    <div class="">
        <div class="flex justify-center">

<%--hub--%>
            <a href="/usr/cert/analysis" class="helpMenu flex flex-col justify-between w-3/12 bg-grey-1 rounded-xl m-4 p-6 block hover:shadow-md transition">
                <div class="mb-4">
                    <div class="text-xl font-black mb-2">HUB</div>
                    취업공고에서 발췌한 우대 자격증을 직무별로 확인할 수 있습니다.
                </div>
                <div class="flex justify-between">
                    <div class="iconBox w-10 h-10 bg-blue-400 rounded-full flex items-center justify-center">
                        <i class="fa-solid fa-chevron-right text-white"></i>
                    </div>
                    <div class="w-[200px] h-[200px] self-end">
                        <img src="/image/diagram.png" alt="Diagram icon" class="w-full h-full object-contain">
                    </div>
                </div>
            </a>

<%--workbook--%>
            <a href="/usr/workbook/showWorkbook/" class="helpMenu flex flex-col justify-between w-3/12 bg-grey-1 rounded-xl m-4 p-6 block hover:shadow-md transition">
                <div class="mb-4">
                    <div class="text-xl font-black mb-2">WORK BOOK</div>
                    원하는 자격증과 문제 풀이 방식을 선택하여 자격증 공부를 쉽게 할 수 있습니다.
                </div>
                <div class="flex justify-between">
                    <div class="iconBox w-10 h-10 bg-blue-400 rounded-full flex items-center justify-center">
                        <i class="fa-solid fa-chevron-right text-white"></i>
                    </div>
                    <div class="w-[200px] h-[200px] self-end">
                        <img src="/image/study.png" alt="Study icon" class="w-full h-full object-contain">
                    </div>
                </div>
            </a>

<%--wallet--%>
            <a href="/usr/member/myCert" class="helpMenu flex flex-col justify-between w-3/12 bg-grey-1 rounded-xl m-4 p-6 block hover:shadow-md transition">
                <div class="mb-4">
                    <div class="text-xl font-black mb-2">WALLET</div>
                    내 자격증을 등록하고 만료일 전 알람을 받아보세요.
                </div>
                <div class="flex justify-between">
                    <div class="iconBox w-10 h-10 bg-blue-400 rounded-full flex items-center justify-center">
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