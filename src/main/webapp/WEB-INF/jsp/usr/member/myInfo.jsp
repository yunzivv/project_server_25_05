<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="MY PAGE"></c:set>
<%@ include file="../common/head.jspf" %>


<div class="flex w-full">
    <div class="side hidden xl:block shrink-0" style="width: 250px;">
        <%@ include file="../common/side.jspf" %>
    </div>
    <div class="block min-[1280px]:hidden w-1/12"></div>

    <div class="flex flex-col flex-grow px-60 pt-20">

        <div id="memberInfo" class="">
            <div class="flex items-end relative">
                <div class="img w-40 h-40 rounded-full overflow-hidden"><img src="/image/user.png" alt="USER"></div>
                <span class="font-bold text-4xl ml-8 mb-4">${member.name}</span>
                <div class="absolute" style="top: 30px; right: 100px;">
                    <a href="../member/modify"
                       class="write-btn block w-12 h-12 rounded-full border-grey-3 flex items-center justify-center cursor-pointer">
                        <i class="fa-solid fa-pen text-grey-5"></i>
                    </a>
                </div>
            </div>
            <div class="text-lg font-semibold flex flex-col p-10 h-60 justify-between">
                <span>생년월일: ${member.birthday}</span>
                <span>가입일자: ${member.regDate.toString().substring(0, 10)}</span>
                <span>전화번호: ${member.cellPhone.toString().substring(0, 3)}-${member.cellPhone.toString().substring(3, 7)}-${member.cellPhone.toString().substring(7)}</span>
                <span>이 메 일: ${member.email}</span>
            </div>
            <div class="examHistory mt-10 px-8 py-4">
                <div class="font-bold text-2xl mb-4">문제은행 히스토리</div>
                <table class="m-10">
                    <thead class="h-5 text-base bg-grey-1 text-blue-2 border-b">
                    <tr>
                        <th scope="col" class="px-10 py-4 w-2/5">자격증</th>
                        <th scope="col" class="px-10 py-4">푼 날</th>
                        <th scope="col" class="px-10 py-4">총 푼 문제</th>
                        <th scope="col" class="px-10 py-4">맞춘 문제</th>
                        <th scope="col" class="px-10 py-4 whitespace-nowrap">경과 시간</th>
                    </tr>
                    </thead>
                    <c:forEach var="exam" items="${exams}">
                        <tr class="bg-grey-1 cursor-pointer text-center">
                            <td class="p-4 text-left"> ${exam.extra__certName}</td>
                            <td><a class="block text-left pl-6"> ${exam.regDate.toString().substring(0,10)}</a>
                            </td>
                            <td class="p-4">${exam.totalQuest}</td>
                            <td class="p-4">${exam.correctQuest}</td>
                            <td class="p-4">${exam.elapsedTime}</td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
            <div class="side hidden xl:block w-52"></div>
            <div class="block min-[1280px]:hidden w-1/12"></div>
        </div>

    </div>


    <script>
        $(document).ready(function () {

            $('.header').addClass('active');
            $('.nav_box > ul > li:nth-child(4) i').addClass('active');

            $('.side_bar_left').addClass('active');
            $('.side_bar_left > .myPage_sub_menu ').removeClass('hidden');
            $('.side_bar_left > .myPage_sub_menu > li:nth-child(1) > a').addClass('active');
            $('.side_bar_left > .myPage_sub_menu > li:nth-child(1) > a > i').addClass('active');
        });
    </script>


    <%@ include file="../common/foot.jspf" %>
