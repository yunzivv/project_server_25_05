<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="ANYAYSIS"></c:set>
<%@ include file="../common/head.jspf" %>

<div class="flex w-full">
    <div class="side hidden xl:block shrink-0 w-96">
        <%@ include file="../common/side.jspf" %>
    </div>
    <div class="block min-[1280px]:hidden w-1/12"></div>

    <div class="flex flex-col flex-grow">

        <div class="title px-8 pt-20 pb-12 text-4xl font-black">채용공고 우대 자격증 분석</div>

        <div class="analysis_1 flex p-2 " style="height: 200px;">

            <div class="select_box flex flex-col w-2/3 mr-2 p-2 border-blue-2 rounded-xl">
                <div class="select_box_title flex">
                    <div class="flex-grow font-bold p-2">직무 선택</div>
                    <div class="flex-grow font-bold p-2">전문 분야 선택</div>
                </div>
                <hr class="my-1">
                <div class="flex overflow-y-hidden">
                    <%--직무 카테고리--%>
                    <ul class="jobCat_list w-1/2 flex flex-wrap overflow-y-scroll">
                        <c:forEach var="jobCat" items="${jobCats }">
                            <li class="w-1/2 p-2 cursor-pointer text-sm" data-id="${jobCat.id}">${jobCat.name}</li>
                        </c:forEach>
                    </ul>

                    <%--직무 코드--%>
                    <ul class="jobCode_list w-1/2 flex flex-wrap overflow-y-scroll">
                        <li class="w-1/2 p-2 cursor-pointer text-sm" data-id="0">전체</li>
                        <c:if test="${jobCodes != null}">
                            <c:forEach var="jobCode" items="${jobCodes }">
                                <li class="w-1/2 p-2 cursor-pointer text-sm"
                                    data-id="${jobCode.id}">${jobCode.name}</li>
                            </c:forEach>
                        </c:if>
                    </ul>
                </div>

            </div>
            <div class="postsWithCert w-1/3 bg-neutral-300">
                dd
            </div>
        </div>

        <div class="analysis_2 p-2">
            <div class="job_code_name p-3">
                전체 직무 자격증 언급 TOP 10
            </div>
            <div class="topCertsByField p-2 border-blue-2">
                <canvas id="certChart" width="300" height="100" style="margin:20px 30px;"></canvas>
                <script th:inline="javascript">
                    /*<![CDATA[*/
                    const labels = ${labels};
                    const values = ${values};
                    /*]]>*/
                    const backgroundColors = values.map((_, idx) => idx === 0 ? '#1f418c' : '#afafaf');

                    console.log(labels);
                    console.log(values);
                    document.addEventListener('DOMContentLoaded', () => {
                        const ctx = document.getElementById('certChart').getContext('2d');

                        new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: labels,
                                datasets: [{
                                    label: '언급 횟수',
                                    data: values,
                                    backgroundColor: backgroundColors
                                }]
                            },
                            options: {
                                indexAxis: 'y',
                                scales: {
                                    x: {
                                        beginAtZero: true,
                                        ticks: {
                                            precision: 0
                                        }
                                    }
                                }
                            }
                        });
                    });
                </script>
            </div>
        </div>

        <div class="analysis_3 p-2">
            <div class="totalCertCount">

            </div>
            <div class="">

            </div>
        </div>

        <div class="p-2">
            <div class=""></div>
        </div>
    </div>

    <div class="side hidden xl:block w-52" style="min-width: 208px;"></div>
    <div class="block min-[1280px]:hidden w-1/12"></div>

</div>
<script>
    $(document).ready(function () {

        $('.nav_box > ul > li:nth-child(1) i').addClass('active');
        $('.side_bar_left > .hub_sub_menu ').removeClass('hidden');
        $('.side_bar_left > .hub_sub_menu > li:nth-child(1) > a').addClass('active');
        $('.side_bar_left > .hub_sub_menu > li:nth-child(1) > a > i').addClass('active');

        let selectedJobCatId = null;
        $('.jobCat_list').on('click', 'li', function () {
            const jobCatId = $(this).data('id');
            selectedJobCatId = jobCatId;

            // 선택된 항목 시각적 표시
            $('.jobCat_list li').removeClass('text-blue-1').find('.arrow').remove();
            $(this).addClass('text-blue-1').append('<span class="arrow">&nbsp;&nbsp; &gt; </span>');

            $.ajax({
                url: '/usr/api/jobCodes?jobCatId=' + jobCatId,
                method: 'GET',
                dataType: 'json',
                success: function (data) {
                    console.log(data);
                    const $list = $('.jobCode_list');
                    const jobCatName = data.msg;
                    $list.empty(); // 이전 목록 비우기

                    $list.append('<li class="w-1/2 p-2 cursor-pointer text-sm" data-id="0">전체</li>');
                    data.data1.forEach(function (jobCode) {

                        $list.append('<li class="w-1/2 p-2 cursor-pointer text-sm" data-id="' + jobCode.code +
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

            $('.jobCode_list li').removeClass('text-blue-1');
            $(this).addClass('text-blue-1');

            // AJAX로 자격증 랭킹 요청
            $.ajax({
                url: '/usr/api/certRankByJobCode?jobCatId=' + selectedJobCatId + '&jobCodeId=' + jobCodeId,
                method: 'GET',
                dataType: 'json',
                success: function (data) {
                    const $box = $('.topCertsByField');
                    const jobCodeName_box = $('.job_code_name');

                    const jobCatName = data.data1;      // 직무 대분류 이름
                    const jobCodeName = data.data2;     // 직무 소분류 이름
                    console.log(jobCodeName);
                    console.log(jobCodeId);
                    const certs = data.data3;           // 자격증 배열

                    jobCodeName_box.empty();
                    $box.empty();

                    jobCodeName_box.append(jobCatName + " > " + jobCodeName + " 자격증 언급 TOP 10");

                    if (!certs || certs.length === 0) {
                        $box.append('<div>관련 자격증이 없습니다.</div>');
                        return;
                    }

                    // 차트 캔버스 추가
                    $box.append('<canvas id="certChart" width="300" height="100" style="margin:20px 30px;"></canvas>');

                    const labels = certs.map(cert => cert.name);
                    const values = certs.map(cert => cert.extra__certCount);

                    const ctx = document.getElementById('certChart').getContext('2d');
                    const backgroundColors = values.map((_, idx) => idx === 0 ? '#1f418c' : '#afafaf');

                    new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: labels,
                            datasets: [{
                                label: '언급 횟수',
                                data: values,
                                backgroundColor: backgroundColors
                            }]
                        },
                        options: {
                            indexAxis: 'y',
                            responsive: true,
                            scales: {
                                x: {
                                    beginAtZero: true,
                                    ticks: {
                                        precision: 0
                                    }
                                }
                            }
                        }
                    });
                },
                error: function () {
                    alert('자격증 정보를 불러오는 데 실패했습니다.');
                }
            });

        });
    });
</script>


<%@ include file="../common/foot.jspf" %>