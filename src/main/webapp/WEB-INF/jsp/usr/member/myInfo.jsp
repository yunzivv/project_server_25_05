<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="MY PAGE"></c:set>
<%@ include file="../common/head.jspf" %>


<div class="flex w-full">
    <div class="side hidden xl:block shrink-0" style="width: 250px;">
        <%@ include file="../common/side.jspf" %>
    </div>
    <div class="block min-[1280px]:hidden w-1/12"></div>

    <c:if test="${not empty member}">
        <div class="flex flex-col flex-grow px-24 pt-12" style="border-top-left-radius: 3rem;">


            <div id="memberInfo" class="bg-red-300">
                    <%--                사진 업로드--%>
                <div class="updateProfile">

                    <div id="infoCard" class="p-3 rounded-xl overflow-hidden border border-solid bg-grey-1"
                         style="width: 500px; height: 313px; background-image: url('<c:url value="/image/certBG.png"/>'); background-size: cover; background-position: center;">
                        <div class="cardHead h-1/6 text-center text-3xl font-bold text-grey-1 tracking-widest">
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
                            <div class="font-black text-lg">CERTIFY</div>
                            <a href="modify"
                               class="rounded-md hover:bg-neutral-300 border border-neutral-300 px-3 py-1">수정</a>
                        </div>
                    </div>

                </div>
            </div>

                <%--        <div id="memberCerts" class="bg-blue-300">--%>
                <%--            <table>--%>
                <%--                <thead class="h-5 text-base text-neutral-200 bg-neutral-800">--%>
                <%--					<tr>--%>
                <%--						<th scope="col" class="px-6 py-4">NO</th>--%>
                <%--						<th scope="col" class="px-6 py-4">자격증명</th>--%>
                <%--						<th scope="col" class="px-6 py-4">자격번호</th>--%>
                <%--						<th scope="col" class="px-6 py-4">취득일</th>--%>
                <%--						<th scope="col" class="px-6 py-4">만료일</th>--%>
                <%--					</tr>--%>
                <%--				</thead>--%>
                <%--				<tbody>--%>
                <%--                    <c:forEach var="cert" items="${certs }">--%>
                <%--                    <tr class="border-b bg-neutral-200 border-neutral-300 hover:bg-neutral-300">--%>
                <%--							<td class="px-5 py-3">${cert.extra__rankNum }</td>--%>
                <%--							<td class="px-5 py-3">${cert.certname}</td>--%>
                <%--							<td class="px-5 py-3">${cert.certificateNumber}</td>--%>
                <%--							<td class="px-5 py-3">${cert.startDate.toString().substring(0, 10)}</td>--%>
                <%--							<td class="px-5 py-3">${cert.endDate.toString().substring(0, 10)}</td>--%>
                <%--                    </tr>--%>
                <%--                    </c:forEach>--%>
                <%--                    <c:if test="${empty certs }">--%>
                <%--						<tr class="text-center">--%>
                <%--							<td colspan="5" class="text-center text-lg py-8">등록된 자격증이 없습니다.</td>--%>
                <%--						</tr>--%>
                <%--					</c:if>--%>
                <%--                </tbody>--%>
                <%--            </table>--%>
                <%--        </div>--%>

                <%--        <div id="memberPosts" class="bg-red-300">--%>
                <%--            <c:forEach var="article" items="${articles }">--%>
                <%--                <div>--%>
                <%--			    	<div>${article.title }</div>--%>
                <%--					<div>${article.body}</div>--%>
                <%--					<div>${article.regDate}</div>--%>
                <%--					<div>${article.extra__sumComment}</div>--%>
                <%--					<div>${article.extra__sumComment}</div>--%>
                <%--                </div>--%>
                <%--                </c:forEach>--%>
                <%--                <c:if test="${empty articles }">--%>
                <%--                   <div>작성된 게시물이 없습니다.</div>--%>
                <%--				</c:if>--%>
                <%--        </div>--%>


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
        $('.myPage_sub_menu a[href$="myInfo"]').addClass('active');
        $('.myPage_sub_menu a[href$="myInfo"] > i').addClass('active');

    });
</script>


<%@ include file="../common/foot.jspf" %>
