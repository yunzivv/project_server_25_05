<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="MEMBER JOIN"></c:set>
<%@ include file="../common/head.jspf" %>

<script type="text/javascript">

    $('.back').addClass('hidden');

</script>

<div class="h-screen flex justify-center items-center">
    <div class="container max-w-min p-4 bg-neutral-200 border border-solid border-neutral-300 rounded-lg">
        <div class="title my-3 text-center text-2xl font-semibold">
            Join
        </div>
        <form onsubmit="return validate();" name="join" action="doJoin" method="POST">

            <div calss="flex flex-col justify-center">

                <input type="text" name="loginId"
                       class="mb-6 border border-neutral-300 text-neutral-800 text-sm rounded-lg block w-96 p-2.5 bg-white"
                       placeholder="아이디">
                <!-- 			<div class="text-neutral-400 mb-6 px-2">Enter at least 4 letters and numbers</div> -->
                <input type="password" name="loginPw"
                       class="mb-6 border border-neutral-300 text-neutral-800 text-sm rounded-lg block w-96 p-2.5 bg-white"
                       placeholder="비밀번호">
                <!-- 			<div class="text-neutral-400 mb-6 px-2">Enter at least 4 letters and numbers</div> -->
                <input type="password" name="checkLoginPw"
                       class="mb-6 border border-neutral-300 text-neutral-800 text-sm rounded-lg block w-96 p-2.5 bg-white"
                       placeholder="비밀번호 확인">
                <!-- 			<div class="text-neutral-400 mb-6 px-2">Enter your password again to confirm it</div> -->
                <input type="text" name="name"
                       class="mb-6 border border-neutral-300 text-neutral-800 text-sm rounded-lg block w-96 p-2.5 bg-white"
                       placeholder="이름">
                생년월일
                <input type="date" name="birthday"
                       class="mb-6 border border-neutral-300 text-neutral-800 text-sm rounded-lg block w-96 p-2.5 bg-white">
                <input type="text" name="nickName"
                       class="mb-6 border border-neutral-300 text-neutral-800 text-sm rounded-lg block w-96 p-2.5 bg-white"
                       placeholder="닉네임">
                <input type="tel" name="cellPhone" pattern="[0-9]{11}" required
                       class="mb-6 border border-neutral-300 text-neutral-800 text-sm rounded-lg block w-96 p-2.5 bg-white"
                       placeholder="전화번호">
                <!-- 			<div class="text-neutral-400 mb-6 px-2">Enter your tel without highpen(-)</div> -->
                <input type="email" name="email"
                       class="mb-6 border border-neutral-300 text-neutral-800 text-sm rounded-lg block w-96 p-2.5 bg-white"
                       placeholder="e-mail">
            </div>
            <button type="submit"
                    class="py-2.5 px-5 me-2 mb-2 w-96 text-sm font-large bg-neutral-800 text-neutral-200 rounded-lg hover:bg-neutral-700">
                Join
            </button>
        </form>
        <div class="sub-menu text-center my-4 flex justify-center">
            <a class="hover:text-underline" href="login">Login</a>
        </div>
    </div>
</div>
<%@ include file="../common/foot.jspf" %>