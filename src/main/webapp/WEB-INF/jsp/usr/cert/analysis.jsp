<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="ANYAYSIS"></c:set>
<%@ include file="../common/head.jspf"%>

<script>
		$(document).ready(function () {

			$('.nav_box > ul > li:nth-child(1) i').addClass('active');
            $('.side_bar_left > .hub_sub_menu ').removeClass('hidden');
            $('.side_bar_left > .hub_sub_menu > li:nth-child(1) > a').addClass('active');
            $('.side_bar_left > .hub_sub_menu > li:nth-child(1) > a > i').addClass('active');
            $('.jobCat_list').on('click', 'li', function () {
                const jobCatId = $(this).data('id');

                // 선택된 항목 시각적 표시 (선택사항)
                $('.jobCat_list li').removeClass('text-white').find('.arrow').remove();
                $(this).addClass('text-blue-2').append('<span class="arrow">&nbsp;&nbsp; &gt; </span>');

                $.ajax({
                    url: '/usr/api/jobCodes?jobCatId=' + jobCatId,
                    method: 'GET',
                    dataType: 'json',
                    success: function (data) {
                        const $list = $('.jobCode_list');
                        $list.empty(); // 이전 목록 비우기

                        data.data1.forEach(function (jobCode) {
                            $list.append('<li class="p-2 cursor-pointer" data-id="' + jobCode.id +
                            '">' + jobCode.name + '</li>');
                        });
                    },
                    error: function (err) {
                        console.error("직무 코드 불러오기 실패", err);
                    }
                });
            });
            $('.jobCode_list').on('click', 'li', function () {
            const jobCodeId = $(this).data('id');

            $('.jobCode_list li').removeClass('text-blue-2');
            $(this).addClass('text-blue-2');

            // AJAX로 자격증 랭킹 요청
            $.ajax({
                url: '/usr/api/certRankByJobCode?jobCodeId=' + jobCodeId,
                method: 'GET',
                dataType: 'json',
                success: function (data) {
                    const $box = $('.topCertsByField');
                    $box.empty();

                    if (data.data1.length === 0) {
                        $box.append('<div>관련 자격증이 없습니다.</div>');
                        return;
                    }

                    data.data1.slice(0, 10).forEach(function (cert) {
                        $box.append('<div>' + cert.name + '</div>');
                    });
                },
                error: function () {
                    alert('자격증 정보를 불러오는 데 실패했습니다.');
                }
            });
        });
    });
</script>


<div class="flex w-full h-screen">
    <div class="side hidden xl:block w-80" style="min-width: 320px;">
        <%@ include file="../common/side.jspf"%>
    </div>
    <div class="block min-[1280px]:hidden w-1/12">
    </div>
    <div class="flex flex-col flex-grow" style="min-width: 770px">

        <div class="title px-8 pt-20 pb-12 text-4xl font-black">채용공고 우대 자격증 분석</div>

        <div class="analysis_1 flex p-2 " style="height: 200px;">
            <div class="select_box flex w-2/3 mr-2 p-2 border-blue-2 rounded-xl">

<%--                직무 카테고리--%>
                <ul class="jobCat_list w-1/2 overflow-y-scroll text-bold">
                    <c:forEach var="jobCat" items="${jobCats }">
                        <li class="p-2 cursor-pointer" data-id="${jobCat.id}">${jobCat.name}</li>
                    </c:forEach>
                </ul>

<%--                직무 코드--%>
                <ul class="jobCode_list w-1/2 overflow-y-scroll text-bold">
                    <c:if test="${jobCodes != null}">
                        <c:forEach var="jobCode" items="${jobCodes }">
                            <li class="p-2 cursor-pointer" data-id="${jobCode.id}">${jobCode.name}</li>
                        </c:forEach>
                    </c:if>
                </ul>
            </div>
            <div class="postsWithCert w-1/3 bg-neutral-300">
                dd
            </div>
        </div>

        <div class="analysis_2 p-2">
            <div class="topCertsByField border-blue-2">
            <c:forEach var="certificate" items="${certRanking }" varStatus="status">
               <c:if test="${status.index < 10}">
                    ${certificate.name}
               </c:if>
            </c:forEach>
            </div>
        </div>

        <div class="analysis_3 p-2">
            <div class="totalCertCount">

            </div>
            <div class="">

            </div>
        </div>

        <div class="p-2">
            <div class=" ">aaaaa</div>
        </div>
    </div>
    <div class="side hidden xl:block w-32">

    </div>
    <div class="block min-[1280px]:hidden w-1/12">
    </div>
</div>

<%@ include file="../common/foot.jspf"%>