<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="MY CERT"></c:set>
<%@ include file="../common/head.jspf" %>

<script>
    $(document).ready(function () {

        $('.nav_box > ul > li:nth-child(4) i').addClass('active');
        $('.side_bar_left > .myPage_sub_menu ').removeClass('hidden');
        $('.side_bar_left > .myPage_sub_menu > li:nth-child(1) > a').addClass('active');
        $('.side_bar_left > .myPage_sub_menu > li:nth-child(1) > a > i').addClass('active');

    });
</script>


<div class="flex w-full">
    <div class="side hidden xl:block shrink-0 w-96">
        <%@ include file="../common/side.jspf" %>
    </div>
    <div class="block min-[1280px]:hidden w-1/12"></div>

    <div class="flex flex-col flex-grow">

        <div id="cert" class="mt-10 px-2 bg-green-300 h-screen">
            <div class="flex">
            총 자격증: ${certlist.size()}개
            <div class="flex-grow"></div>
            <button onclick=""
            class="block ml-6 px-5 whitespace-nowrap text-base flex items-center justify-center font-large rounded-md hover:bg-neutral-300">
                자격증 등록
            </button>
            </div>

            <div>
            <form action="a">
            <input type="text" name="certName" placeholder="자격증명">
            <input type="text" name="certificateNumber" placeholder="자격번호">
            <input type="date" name="startDate" placeholder="취득일">
            <input type="date" name="endDate" placeholder="만료일">
            </form>
            </div>
            <table>
                <thead class="h-5 text-base text-neutral-200 bg-neutral-800">
					<tr>
						<th scope="col" class="px-6 py-4">NO</th>
						<th scope="col" class="px-6 py-4">자격증명</th>
						<th scope="col" class="px-6 py-4">자격번호</th>
						<th scope="col" class="px-6 py-4">취득일</th>
						<th scope="col" class="px-6 py-4">만료일</th>
					</tr>
				</thead>
				<tbody>
                    <c:forEach var="cert" items="${certlist }">
                    <tr class="border-b bg-neutral-200 border-neutral-300 hover:bg-neutral-300">
							<td class="px-5 py-3">${cert.extra__rankNum }</td>
							<td class="px-5 py-3">${cert.certname}</td>
							<td class="px-5 py-3">${cert.certificateNumber}</td>
							<td class="px-5 py-3">${cert.startDate.toString().substring(0, 10)}</td>
							<td class="px-5 py-3">${cert.endDate.toString().substring(0, 10)}</td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>

        </div>

        <div id="article" class="h-screen bg-blue-400"></div>


        <div class="side hidden xl:block w-52"></div>
        <div class="block min-[1280px]:hidden w-1/12"></div>
    </div>

    <div class="side hidden xl:block w-52"></div>
    <div class="block min-[1280px]:hidden w-1/12"></div>
</div>


    <%@ include file="../common/foot.jspf" %>
