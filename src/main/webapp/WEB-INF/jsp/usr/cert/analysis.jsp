<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="ANYAYSIS"></c:set>
<%@ include file="../common/head.jspf"%>

<script>
		$(document).ready(function () {

			$('.nav_box > ul > li:nth-child(1) i').addClass('active');
            $('.side_bar > .hub_sub_menu ').removeClass('hidden');
            $('.side_bar > .hub_sub_menu > li:nth-child(1) > a').addClass('active');
		});
</script>


<div class="flex w-full h-screen">
    <div class="side w-80 bg-blue-300">
        <%@ include file="../common/side.jspf"%>
    </div>
    <div class="flex flex-col flex-grow bg-red-300">
        <div class="title px-8 pt-20 pb-12 text-4xl font-black bg-blue-500">채용공고 우대 자격증 분석</div>
        <div class="analysis_1 flex p-2 ">
            <div class="select_box w-2/3 mr-2 bg-neutral-300">select</div>
            <div class="postsWithCert w-1/3 bg-neutral-300">postswithcert</div>
        </div>
        <div class="p-2">
            <div class="topCertsByField bg-yellow-300">aaaaa</div>
        </div>
        <div class="p-2">
            <div class=" bg-green-300">aaaaa</div>
        </div>
    </div>
    <div class="side w-60 bg-blue-300">

    </div>
</div>
analysis

<%@ include file="../common/foot.jspf"%>