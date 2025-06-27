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
            <%--                사진 업로드--%>
            <div class="updateProfile">

                <div id="infoCard" class="p-3 rounded-xl overflow-hidden border border-black border-solid bg-white"
                     style="width: 500px; height: 313px; background-size: cover; background-position: center;">
<%--                     background-image: url('<c:url--%>
<%--                             value="/image/certBG.png"/>');--%>
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

            </div>
        </div>
        <div class="side hidden xl:block w-52"></div>
        <div class="block min-[1280px]:hidden w-1/12"></div>
    </div>

</div>


<script>
    $(document).ready(function () {

        const memberExists = ${member != null ? 'true' : 'false'};
        $('.header').addClass('active');
        $('.nav_box > ul > li:nth-child(4) i').addClass('active');

        if (memberExists) {
            $('.side_bar_left').addClass('active');
            $('.side_bar_left > .myPage_sub_menu ').removeClass('hidden');
            $('.side_bar_left > .myPage_sub_menu > li:nth-child(1) > a').addClass('active');
            $('.side_bar_left > .myPage_sub_menu > li:nth-child(1) > a > i').addClass('active');
        } else {
            document.location.href = "../member/login";
        }

    });

</script>


<%@ include file="../common/foot.jspf" %>
