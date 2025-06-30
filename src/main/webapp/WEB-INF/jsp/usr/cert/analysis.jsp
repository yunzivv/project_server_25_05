<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="ANYAYSIS"></c:set>
<%@ include file="../common/head.jspf" %>

<div class="flex w-full">
    <div class="side hidden xl:block shrink-0" style="width: 250px;">
        <%@ include file="../common/side.jspf" %>
    </div>
    <div class="block min-[1280px]:hidden w-1/12"></div>

    <div class="flex flex-col flex-grow px-12">

        <div class="title px-8 pt-24 pb-12 text-4xl font-black">채용공고 우대 자격증 분석</div>

        <div class="analysis_1 flex p-5" id="analysis_all">
            <div class="flex flex-col w-1/4 p-5 mr-2 analysis-element h-full">
                <div class="title p-2 mb-4"><i class="fa-solid fa-circle text-sm text-blue-2"></i>&nbsp;&nbsp;자격증이 가장 많이
                    언급된 직무
                </div>
                <div class="my-2 flex justify-center">
                    <canvas id="topJobCat" style="height: 200px; width: 350px;"></canvas>
                </div>
                <script th:inline="javascript">
                    const topJobCatLabels = ${topJobCatLabels};
                    const topJobCatValues = ${topJobCatValues};

                    // 전체 합 계산
                    const total = topJobCatValues.reduce((sum, val) => sum + val, 0);
                    // 퍼센트 계산
                    const percentages = topJobCatValues.map(val => ((val / total) * 100).toFixed(2));

                    // 도넛 차트 그리기
                    const jobCatCtx = document.getElementById('topJobCat').getContext('2d');
                    new Chart(jobCatCtx, {
                        type: 'doughnut',
                        data: {
                            labels: topJobCatLabels,
                            datasets: [{
                                data: percentages,
                                backgroundColor: [
                                    '#2f73d9', '#64c086', '#f2cd5c', '#d1d1d1', '#dedede'
                                ],
                                borderWidth: 0
                            }]
                        },
                        options: {
                            responsive: false,
                            maintainAspectRatio: false,
                            layout: {
                                padding: {}
                            },
                            plugins: {
                                legend: {
                                    position: 'right', // chartArea 내부에 범례 표시
                                    align: 'end',          // 오른쪽 아래 정렬
                                    labels: {
                                        padding: 10,
                                        boxWidth: 10,
                                        boxHeight: 10,
                                        usePointStyle: true,
                                        pointStyle: 'circle',
                                        font: {
                                            size: 12
                                        }
                                    }
                                },
                                tooltip: {
                                    callbacks: {
                                        label: function (context) {
                                            const label = context.label || '';
                                            const percent = context.dataset.data[context.dataIndex];
                                            const count = topJobCatValues[context.dataIndex];
                                            return percent + '% (' + count + '회)';
                                        }
                                    }
                                }
                            }
                        }
                    });
                </script>
            </div>
            <div class="flex flex-col w-1/4 p-5 mr-2 analysis-element h-full">
                <div class="title p-2 mb-4"><i class="fa-solid fa-circle text-sm text-blue-2"></i>&nbsp;&nbsp;자격증 분류별 언급<br>
                </div>
                <div class="my-2 flex justify-center">
                    <canvas id="certTypeChart" style="height: 200px; width: 350px;"></canvas>
                </div>
                <script th:inline="javascript">
                    (() => {
                        const certTypeLabels = /*[[${certTypeRankLabels}]]*/ ["국가자격", "국가공인 민간자격", "민간자격"];
                        const certTypeValues = /*[[${certTypeRankValues}]]*/ [120, 90, 60];
                        const certTypeTotal = certTypeValues.reduce((sum, val) => sum + val, 0);

                        const certTypeChartCtx = document.getElementById('certTypeChart').getContext('2d');

                        new Chart(certTypeChartCtx, {
                            type: 'doughnut',
                            data: {
                                labels: certTypeLabels,
                                datasets: [{
                                    data: certTypeValues,
                                    backgroundColor: ['#2f73d9', '#d1d1d1', '#dedede'],
                                    borderWidth: 0
                                }]
                            },
                            options: {
                                responsive: false,
                                plugins: {
                                    legend: {
                                        position: 'right',
                                        align: 'end',
                                        labels: {
                                            padding: 10,
                                            boxWidth: 10,
                                            boxHeight: 10,
                                            usePointStyle: true,
                                            pointStyle: 'circle',
                                            font: {
                                                size: 12
                                            }
                                        }
                                    },
                                    tooltip: {
                                        enabled: true,
                                        callbacks: {
                                            label: function (context) {
                                                const label = context.label || '';
                                                const value = context.raw;
                                                const percent = ((value / certTypeTotal) * 100).toFixed(1);
                                                return label + ": " + percent + "% (" + value + "회)";
                                            }
                                        }
                                    }
                                }
                            }
                        });
                    })();
                </script>
            </div>
            <div class="flex flex-col w-1/4 p-5 mr-2 analysis-element h-full">
                <div class="title p-2 mb-4"><i class="fa-solid fa-circle text-sm text-blue-2"></i>&nbsp;&nbsp;
                    자격증 언급 공고 비율<br></div>
                <div class="my-2 flex justify-center">
                    <canvas id="postsWithCert" style="height: 200px; width: 350px;"></canvas>
                </div>
                <script th:inline="javascript">
                    const postsCtx = document.getElementById('postsWithCert').getContext('2d');

                    const postCount = ${postCount};
                    const totalPosts = ${totalPosts};

                    const percent = totalPosts === 0 ? 0 : ((postCount / totalPosts) * 100).toFixed(1);

                    const data = {
                        labels: ['자격증 언급 공고', '자격증 무관 공고'],
                        datasets: [{
                            data: [percent, 100 - percent],
                            backgroundColor: ['#2f73d9', '#dedede'],
                            borderWidth: 0
                        }]
                    };

                    // const centerTextPlugin = {
                    //     id: 'centerText',
                    //     afterDraw(chart) {
                    //         const {ctx, chartArea: {left, right, top, bottom, width, height}} = chart;
                    //         ctx.save();
                    //
                    //         ctx.font = 'bold 30px "SUIT-Regular"';
                    //         ctx.fillStyle = '#2f73d9';
                    //         ctx.textAlign = 'center';
                    //         ctx.textBaseline = 'middle';
                    //
                    //         const centerX = left + width / 2 + 5;
                    //         const centerY = top + height / 2 + 5;
                    //         ctx.fillText(percent + '%', centerX, centerY);
                    //
                    //         ctx.restore();
                    //     }
                    // };

                    const options = {
                        responsive: false,
                        plugins: {
                            legend: {
                                position: 'right',
                                align: 'end',
                                labels: {
                                    padding: 10,
                                    boxWidth: 10,
                                    boxHeight: 10,
                                    usePointStyle: true,
                                    pointStyle: 'circle',
                                    font: {
                                        size: 12
                                    }
                                }
                            }, tooltip: {
                                enabled: true,
                                callbacks: {
                                    label: function (context) {
                                        if (context.dataIndex === 0) {
                                            return `${postCount}개`;
                                        } else {
                                            return '${totalPosts - postCount}개';
                                        }
                                    }
                                }
                            }
                        }
                    };

                    new Chart(postsCtx, {
                        type: 'doughnut',
                        data: data,
                        options: options,
                        // plugins: [centerTextPlugin]
                    });
                </script>

            </div>

            <div class="postsWithCert flex-grow flex flex-col">
                <div class="flex-1 mb-4 analysis-element p-5">
                    <div class="title p-2 flex items-center mb-2"><i class="fa-solid fa-circle text-sm text-blue-2"></i>&nbsp;&nbsp;언급된
                        자격증 종류<br></div>
                    <span class="text-5xl">&nbsp;&nbsp;${certTypes }개</span>
                </div>
                <div class="flex-1 analysis-element p-5">
                    <div class="title p-2 mb-2"><i class="fa-solid fa-circle text-sm text-blue-2"></i>&nbsp;&nbsp;자격증
                        언급량<br>
                    </div>
                    <span class="text-5xl">&nbsp;&nbsp;<fmt:formatNumber value="${postCount}" type="number"
                                                                         groupingUsed="true"/>개</span>
                </div>
            </div>
        </div>

        <div class="analysis_2 p-5 flex" id="analysis_section">
            <div class="w-1/3 h-full">
                <div class="select_box flex flex-col h-80 p-5 mr-2 analysis-element rounded-3xl">
                    <div class="select_box_title flex title">
                        <div class="flex-grow p-2 ml-2">직무 선택</div>
                        <div class="flex-grow p-2 ml-2">전문 분야 선택</div>
                    </div>
                    <hr class="my-1">
                    <div class="flex overflow-y-hidden">
                        <%--직무 카테고리--%>
                        <ul class="jobCat_list w-1/2 flex flex-col overflow-y-scroll">
                            <li class="p-2 cursor-pointer text-sm" data-id="0">전체</li>
                            <c:forEach var="jobCat" items="${jobCats }">
                                <li class="p-2 cursor-pointer text-sm" data-id="${jobCat.id}">${jobCat.name}</li>
                            </c:forEach>
                        </ul>

                        <%--직무 코드--%>
                        <ul class="jobCode_list w-1/2 flex flex-col overflow-y-scroll">
                        </ul>
                    </div>
                </div>
                <div class="h-44 mr-2 mt-2 analysis-element p-5 flex flex-col">
                    <div class="title p-2 flex items-center mb-2"><i class="fa-solid fa-circle text-sm text-blue-2"></i>&nbsp;&nbsp;
                        전체 직무 자격증 분류 비율
                    </div>
                    <div class="flex flex-grow items-center pt-3">
                        <div class="h-8 bg-blue-2 relative" id="bar-national" style="flex-grow: 16611;">
                            <span class="absolute" style="top: -30px; left: 10px;">국가자격증</span></div>
                        <div class="h-8 bg-grey-5 relative" id="bar-semi-national"
                             style="background-color: #d1d1d1; flex-grow: 2594;">
                            <span class="absolute whitespace-nowrap" style="top: -30px; right: 0;">국가공인 민간</span></div>
                        <div class="h-8 relative" id="bar-private"
                             style="background-color: #dedede; flex-grow: 2030;">
                            <span class="absolute" style="top: -30px; left: 10px;">국가</span></div>
                    </div>
                </div>
            </div>
            <div class="topCertsByField p-5 analysis-element w-2/3">
                <div class="job_code_name title p-2">
                    <i class="fa-solid fa-circle text-sm text-blue-2"></i>&nbsp;&nbsp;전체 직무 자격증 언급 TOP 10
                </div>
                <div class="text-gray-400 text-sm text-right">※ 2025년 6월 기준</div>
                <div class="chart_container">
                    <canvas id="certChart" height="500" style="margin:20px;"></canvas>
                </div>
                <script th:inline="javascript">
                    /*<![CDATA[*/
                    const topCertLabelsls = ${topCertLabels};
                    const topCertValues = ${topCertValues};
                    /*]]>*/

                    console.log(topCertLabelsls);
                    console.log(topCertValues);
                    document.addEventListener('DOMContentLoaded', () => {
                        const ctx = document.getElementById('certChart').getContext('2d');

                        new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: topCertLabelsls,
                                datasets: [{
                                    label: '언급 횟수',
                                    data: topCertValues,
                                    backgroundColor: [
                                        '#2f73d9', '#64c086', '#f2cd5c', '#c1c1c1', '#d1d1d1', '#dedede', '#e7e7e7', '#e7e7e7', '#e7e7e7', '#e7e7e7'
                                    ],
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
                                        grid: {
                                            display: false
                                        }
                                    },
                                    y: {
                                        ticks: {
                                            font: {
                                                size: 14
                                            }
                                        },
                                        grid: {
                                            display: false
                                        }
                                    }
                                }
                            }
                        });
                    });
                </script>

            </div>
        </div>

        <div class="analysis_3 p-5 flex h-80">

            <div class="w-1/3">

            </div>
        </div>

        <div class="analysis_4">

            <div class=""></div>
        </div>

    </div>

    <%--    <div class="side hidden xl:block w-20 bg-grey-1"></div>--%>
    <div class="block min-[1280px]:hidden w-1/12 bg-grey-1"></div>

</div>
<script>
    $(document).ready(function () {

        $('.header').addClass('active');
        $('.nav_box > ul > li:nth-child(1) i').addClass('active');

        $('.side_bar_left').addClass('active');
        $('.side_bar_left > .hub_sub_menu ').removeClass('hidden');
        $('.side_bar_left > .hub_sub_menu > li:nth-child(1) > a').addClass('active');
        $('.side_bar_left > .hub_sub_menu > li:nth-child(1) > a > i').addClass('active');
    });
</script>


<script>
    $(document).ready(function () {

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
                    const $list = $('.jobCode_list');
                    $list.empty(); // 이전 목록 비우기

                    $list.append('<li class="p-2 cursor-pointer text-sm" data-id="0">전체</li>');
                    data.data1.forEach(function (jobCode) {

                        $list.append('<li class="p-2 cursor-pointer text-sm" data-id="' + jobCode.code +
                            '">' + jobCode.name + '</li>');
                    });
                },
                error: function (err) {
                    const $list = $('.jobCode_list');
                    $list.empty();
                    $list.append('<li class="p-2 cursor-pointer text-sm" data-id="0">전체</li>');
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

                    <%--                    const certTypeRaw = data.data4;--%>
                    <%--const typeMap = {1: '국가자격', 2: '국가공인 민간자격', 0: '민간자격'};--%>
                    <%--const backgroundColors = ['#2f73d9', '#d1d1d1', '#dedede'];--%>

                    <%--const stackedDatasets = Object.keys(typeMap).map((type, i) => {--%>
                    <%--    const found = certTypeRaw.find(e => e.extra__certType == type);--%>
                    <%--    const value = found ? found.extra__certCountByType : 0;--%>
                    <%--    return {--%>
                    <%--        label: typeMap[type],--%>
                    <%--        data: [value], // 수평 1줄--%>
                    <%--        backgroundColor: backgroundColors[i]--%>
                    <%--    };--%>
                    <%--});--%>

                    <%--// 기존 차트 제거--%>
                    <%--if (window.certCatChart) {--%>
                    <%--    window.certCatChart.destroy();--%>
                    <%--}--%>

                    <%--// 재그리기--%>
                    <%--const stackedCtx = document.getElementById('certCatRate').getContext('2d');--%>
                    <%--window.certCatChart = new Chart(stackedCtx, {--%>
                    <%--    type: 'bar',--%>
                    <%--    data: {--%>
                    <%--        labels: ['선택 직무'],--%>
                    <%--        datasets: stackedDatasets--%>
                    <%--    },--%>
                    <%--    options: {--%>
                    <%--        indexAxis: 'y',--%>
                    <%--        responsive: false,--%>
                    <%--        maintainAspectRatio: false,--%>
                    <%--        plugins: {--%>
                    <%--            legend: {--%>
                    <%--                position: 'right',--%>
                    <%--                labels: {--%>
                    <%--                    usePointStyle: true,--%>
                    <%--                    pointStyle: 'rect',--%>
                    <%--                    font: { size: 12 }--%>
                    <%--                }--%>
                    <%--            },--%>
                    <%--            tooltip: {--%>
                    <%--                callbacks: {--%>
                    <%--                    label: function (context) {--%>
                    <%--                        return `${context.dataset.label}: ${context.raw}회`;--%>
                    <%--                    }--%>
                    <%--                }--%>
                    <%--            }--%>
                    <%--        },--%>
                    <%--        scales: {--%>
                    <%--            x: {--%>
                    <%--                stacked: true,--%>
                    <%--                beginAtZero: true,--%>
                    <%--                ticks: {--%>
                    <%--                    precision: 0--%>
                    <%--                }--%>
                    <%--            },--%>
                    <%--            y: {--%>
                    <%--                stacked: true--%>
                    <%--            }--%>
                    <%--        }--%>
                    <%--    }--%>
                    <%--});--%>


                    jobCodeName_box.empty();
                    $box.empty();

                    jobCodeName_box.append("<i class=\'fa-solid fa-circle text-sm text-blue-2'></i>&nbsp;&nbsp;" +
                        jobCatName + " > " + jobCodeName + " 자격증 언급 TOP 10");

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

                    new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: labels,
                            datasets: [{
                                label: '언급 횟수',
                                data: values,
                                backgroundColor: [
                                    '#2f73d9', '#64c086', '#f2cd5c', '#c1c1c1', '#d1d1d1', '#dedede', '#e7e7e7', '#e7e7e7', '#e7e7e7', '#e7e7e7'
                                ],
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
                                    },
                                    grid: {
                                        display: false
                                    }
                                },
                                y: {
                                    grid: {
                                        display: false
                                    }
                                }
                            }
                        }
                    });
                },
                error: function () {
                    Swal.fire({
                        icon: 'error',
                        title: '자격증 정보를 불러오는 데 실패했습니다.',
                        confirmButtonText: '확인'
                    });
                }
            });

        });
    });
</script>


<%@ include file="../common/foot.jspf" %>