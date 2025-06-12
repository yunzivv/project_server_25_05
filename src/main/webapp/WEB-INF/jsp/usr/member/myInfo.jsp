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

    <c:if test="${not empty member}">
    <div class="flex flex-col flex-grow px-24 pt-12" style="border-top-left-radius: 3rem;">


        <div id="memberInfo" class="bg-red-300">

            <div class="updateProfile">
                <a href="modify" class="block p-3 text-base flex items-center
		 	justify-center font-large rounded-md hover:bg-neutral-300 border border-neutral-300">
                    회원 정보 수정</a>
                    ${member.nickName}
                    ${member.birthday}
                    ${member.regDate}
                    ${member.name}
                    ${member.cellPhone}

            </div>
        </div>

        <div id="memberCerts" class="bg-blue-300">
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
                    <c:forEach var="cert" items="${certs }">
                    <tr class="border-b bg-neutral-200 border-neutral-300 hover:bg-neutral-300">
							<td class="px-5 py-3">${cert.extra__rankNum }</td>
							<td class="px-5 py-3">${cert.certname}</td>
							<td class="px-5 py-3">${cert.certificateNumber}</td>
							<td class="px-5 py-3">${cert.startDate.toString().substring(0, 10)}</td>
							<td class="px-5 py-3">${cert.endDate.toString().substring(0, 10)}</td>
                    </tr>
                    </c:forEach>
                    <c:if test="${empty certs }">
						<tr class="text-center">
							<td colspan="5" class="text-center text-lg py-8">등록된 자격증이 없습니다.</td>
						</tr>
					</c:if>
                </tbody>
            </table>
        </div>

        <div id="memberPosts" class="bg-red-300">
            <c:forEach var="article" items="${articles }">
                <div>
			    	<div>${article.title }</div>
					<div>${article.body}</div>
					<div>${article.regDate}</div>
					<div>${article.extra__sumComment}</div>
					<div>${article.extra__sumComment}</div>
                </div>
                </c:forEach>
                <c:if test="${empty articles }">
                   <div>작성된 게시물이 없습니다.</div>
				</c:if>
        </div>


        <div class="side hidden xl:block w-52"></div>
        <div class="block min-[1280px]:hidden w-1/12"></div>
    </div>
    </c:if>

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
