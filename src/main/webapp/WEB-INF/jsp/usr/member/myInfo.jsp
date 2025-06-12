<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="MY PAGE"></c:set>
<%@ include file="../common/head.jspf" %>

<script>
    $(document).ready(function () {

        $('.nav_box > ul > li:nth-child(4) i').addClass('active');
        $('.side_bar_left > .myPage_sub_menu ').removeClass('hidden');
        $('.side_bar_left > .myPage_sub_menu > li:nth-child(2) > a').addClass('active');
        $('.side_bar_left > .myPage_sub_menu > li:nth-child(2) > a > i').addClass('active');

    });
</script>


<div class="flex w-full">
    <div class="side hidden xl:block shrink-0" style="width: 250px;">
        <%@ include file="../common/side.jspf" %>
    </div>
    <div class="block min-[1280px]:hidden w-1/12"></div>

    <div class="flex flex-col flex-grow px-12 bg-grey-1" style="border-top-left-radius: 3rem;">


        <div class="bg-red-300 m-2">

            <div class="updateProfile">
                <a href="modify" class="block p-3 text-base flex items-center
		 	justify-center font-large rounded-md hover:bg-neutral-300 border border-neutral-300">
                    회원 정보 수정</a>
            </div>
        </div>

        <div id="article" class="h-screen bg-blue-400"></div>


        <div class="side hidden xl:block w-52"></div>
        <div class="block min-[1280px]:hidden w-1/12"></div>
    </div>

<%--    <div class="side hidden xl:block w-28 bg-grey-1"></div>--%>
<%--    <div class="block min-[1280px]:hidden w-1/12 bg-grey-1"></div>--%>
</div>

<script>
    $(document).ready(function () {

        $('.header').addClass('active');
        $('.side_bar_left').addClass('active');
        $('.nav_box > ul > li:nth-child(4) i').addClass('active');
        $('.side_bar_left > .myPage_sub_menu ').removeClass('hidden');
        $('.side_bar_left > .myPage_sub_menu > li:nth-child(2) > a').addClass('active');
        $('.side_bar_left > .myPage_sub_menu > li:nth-child(2) > a > i').addClass('active');

    });
</script>


    <%@ include file="../common/foot.jspf" %>
