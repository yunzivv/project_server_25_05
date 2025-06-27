<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="MY PAGE"></c:set>
<%@ include file="../common/head.jspf" %>


<div class="flex w-full">
    <div class="side hidden xl:block shrink-0" style="width: 250px;">
        <%@ include file="../common/side.jspf" %>
    </div>
    <div class="block min-[1280px]:hidden w-1/12"></div>

    <%--시험 히스토리--%>

    <div class="flex flex-col flex-grow px-24 pt-12">
        <div id="memberInfo" class="">

            <span>성    명: ${member.name}</span>
            <%--                                <span>생년월일: ${member.birthday}</span>--%>
            <span>가입일자: ${member.regDate.toString().substring(0, 10)}</span>
            <span>전화번호: ${member.cellPhone.toString().substring(0, 3)}-${member.cellPhone.toString().substring(3, 7)}-${member.cellPhone.toString().substring(7)}</span>
            <span>이 메 일: ${member.email}</span>
        </div>
        <div class="examHistory">

            <span>성    명: ${member.name}</span>
            <%--                                <span>생년월일: ${member.birthday}</span>--%>
            <span>가입일자: ${member.regDate.toString().substring(0, 10)}</span>
            <span>전화번호: ${member.cellPhone.toString().substring(0, 3)}-${member.cellPhone.toString().substring(3, 7)}-${member.cellPhone.toString().substring(7)}</span>
            <span>이 메 일: ${member.email}</span>
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
