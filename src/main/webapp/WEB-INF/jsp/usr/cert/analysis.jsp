<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="ANYAYSIS"></c:set>
<%@ include file="../common/head.jspf" %>

<div class="flex w-full">
    <div class="side hidden xl:block shrink-0" style="width: 250px;">
        <%@ include file="../common/side.jspf" %>
    </div>
    <div class="block min-[1280px]:hidden w-1/12"></div>

    <div class="flex flex-col flex-grow px-12 bg-grey-1" style="border-top-left-radius: 4rem;">

            <div class="title px-8 pt-24 pb-12 text-4xl font-black">채용공고 우대 자격증 분석</div>

            <div class="analysis_1 flex p-5" style="height: 300px;">

                <div class="select_box flex flex-col w-1/2 mr-2 p-5 analysis-element">
                    <div class="select_box_title flex">
                        <div class="flex-grow font-bold p-2 ml-2">직무 선택</div>
                        <div class="flex-grow font-bold p-2 ml-2">전문 분야 선택</div>
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
                            <c:if test="${jobCodes != null}">
                                <c:forEach var="jobCode" items="${jobCodes }">
                                    <li class="w-1/2 p-2 cursor-pointer text-sm"
                                        data-id="${jobCode.id}">${jobCode.name}</li>
                                </c:forEach>
                            </c:if>
                        </ul>
                    </div>

                </div>
                <div class="postsWithCert w-1/4 p-5 mr-2 analysis-element text-right">
                    <i class="fa-solid fa-circle"></i>
                    <i class="fa-solid fa-file"></i>
                    <strong class="text-lg"> 조사된 공고 <fmt:formatNumber value="${totalPosts}" type="number" groupingUsed="true" />개 중</strong>
                    <br>자격증이 언급된 공고<br>
                    <span class="text-5xl"><fmt:formatNumber value="${postCount}" type="number" groupingUsed="true" />개</span>
                </div>
                <div class="postsWithCert w-1/4 p-5 analysis-element text-right">
                    <i class="fa-solid fa-circle"></i> 전체 공고 ??
                    <canvas id="postsWithCert" width="200" height="200"></canvas>

                    <script>
                    const ctx = document.getElementById('postsWithCert').getContext('2d');

                    const postCount = ${postCount};      // 서버에서 넘어온 값으로 치환
                    const totalPosts = ${totalPosts};    // 서버에서 넘어온 값으로 치환

                    const percent = totalPosts === 0 ? 0 : ((postCount / totalPosts) * 100).toFixed(1);

                    const data = {
                        labels: ['조회됨', '남은부분'],
                        datasets: [{
                            data: [percent, 100 - percent],
                            backgroundColor: ['#2f73d9', '#e0e0e0'],
                            borderWidth: 0
                        }]
                    };

                    const centerTextPlugin = {
                        id: 'centerText',
                        afterDraw(chart) {
                            const {ctx, chartArea: {left, right, top, bottom, width, height}} = chart;
                            ctx.save();

                            ctx.font = 'bold 30px "SUIT-Regular"';
                            ctx.fillStyle = '#2f73d9';
                            ctx.textAlign = 'center';
                            ctx.textBaseline = 'middle';

                            const centerX = left + width / 2 + 5;
                            const centerY = top + height / 2 + 5;
                            ctx.fillText(percent + '%', centerX, centerY);

                            ctx.restore();
                        }
                    };

                    const options = {
                        cutout: '70%',
                        responsive: false,
                        plugins: {
                            legend: { display: false },
                            tooltip: { enabled: false }
                        }
                    };

                    new Chart(ctx, {
                        type: 'doughnut',
                        data: data,
                        options: options,
                        plugins: [centerTextPlugin]
                    });
                </script>
                </div>
            </div>

            <div class="analysis_2 p-5 flex h-80">
                <div class="select_box flex flex-col w-1/3 p-5 mr-2 analysis-element rounded-3xl">
                    <div class="select_box_title flex">
                        <div class="flex-grow font-bold p-2 ml-2">직무 선택</div>
                        <div class="flex-grow font-bold p-2 ml-2">전문 분야 선택</div>
                    </div>
                    <hr class="my-1">
                    <div class="flex overflow-y-hidden">
                        <%--직무 카테고리--%>
                        <ul class="jobCat_list w-1/2 flex flex-col overflow-y-scroll">
                            <c:forEach var="jobCat" items="${jobCats }">
                                <li class="p-2 cursor-pointer text-sm" data-id="${jobCat.id}">${jobCat.name}</li>
                            </c:forEach>
                        </ul>

                        <%--직무 코드--%>
                        <ul class="jobCode_list w-1/2 flex flex-col overflow-y-scroll">
                            <c:if test="${jobCodes != null}">
                                <c:forEach var="jobCode" items="${jobCodes }">
                                    <li class="w-1/2 p-2 cursor-pointer text-sm"
                                        data-id="${jobCode.id}">${jobCode.name}</li>
                                </c:forEach>
                            </c:if>
                        </ul>
                    </div>

                </div>
                <div class="topCertsByField p-5 analysis-element w-2/3 h-96">
                    <div class="job_code_name p-2 font-bold">
                        전체 직무 자격증 언급 TOP 10
                    </div>
                    <div class="chart_container"><canvas id="certChart" height="270" style="margin:20px;"></canvas></div>
                    <script th:inline="javascript">
                        /*<![CDATA[*/
                        const labels = ${labels};
                        const values = ${values};
                        /*]]>*/
                        const backgroundColors = values.map((_, idx) => idx === 0 ? '#2f73d9' : '#afafaf');

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
                                        backgroundColor: backgroundColors,
                                        barPercentage: 0.7
                                    }]
                                },
                                options: {
                                    indexAxis: 'y',
                                    maintainAspectRatio: false,
                                    plugins: {
                                        legend: {
                                            display: false
                                        }
                                    },
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

            <div class="analysis_3 p-5 h-80">
                <div class="totalCertCount">

                </div>
                <div class="">

                </div>
            </div>

            <div class="p-5">
                <div class=""></div>
            </div>

    </div>

<%--    <div class="side hidden xl:block w-20 bg-grey-1"></div>--%>
    <div class="block min-[1280px]:hidden w-1/12 bg-grey-1"></div>

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

                    $list.append('<li class="p-2 cursor-pointer text-sm" data-id="0">전체</li>');
                    data.data1.forEach(function (jobCode) {

                        $list.append('<li class="p-2 cursor-pointer text-sm" data-id="' + jobCode.code +
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
                    const $box = $('.topCertsByField .chart_container');
                    const jobCodeName_box = $('.job_code_name');

                    const jobCatName = data.data1;      // 직무 대분류 이름
                    const jobCodeName = data.data2;     // 직무 소분류 이름
                    console.log(jobCodeName);
                    console.log(jobCodeId);
                    const certs = data.data3;           // 자격증 배열

                    jobCodeName_box.empty();
                    $box.empty();

                    jobCodeName_box.append(jobCatName + " > " + jobCodeName + " 자격증 언급 TOP 10");

                    const barHeight = 40; // 막대 1개의 높이
                    const minHeight = 100; // 최소 높이 보장
                    const canvasHeight = Math.max(certs.length * barHeight, minHeight);

                    if (!certs || certs.length === 0) {
                        $box.append('<div class="text-center p-4">' + jobCatName + " > " + jobCodeName +
                                    '<br>' + '언급된 자격증이 없습니다.</div>');
                        return;
                    }

                    $box.append(`<canvas id="certChart" width="300" height="` + canvasHeight + `" style="margin:20px;"></canvas>`);

                    // 차트 캔버스 추가
                    // $box.append('<canvas id="certChart" width="300" height="100" style="margin:20px 30px;"></canvas>');

                    const labels = certs.map(cert => cert.name);
                    const values = certs.map(cert => cert.extra__certCount);

                    const ctx = document.getElementById('certChart').getContext('2d');
                    const backgroundColors = values.map((_, idx) => idx === 0 ? '#2f73d9' : '#afafaf');

                    new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: labels,
                            datasets: [{
                                label: '언급 횟수',
                                data: values,
                                backgroundColor: backgroundColors,
                                barPercentage: 0.8
                            }]
                        },
                        options: {
                            indexAxis: 'y',
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: {
                                    display: false
                                }
                            },
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