<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="MEMBER JOIN"></c:set>
<%@ include file="../common/head.jspf" %>

<script type="text/javascript">

    $('.back').addClass('hidden');

</script>

<div class="hidden h-screen flex justify-center items-center" style="background-color: rgba(0, 0, 0, 0.3);">
    <div class="container max-w-min p-4 bg-grey-1 rounded-3xl shadow-2xl overflow-hidden rounded-lg">
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

<div class="join_fullPage h-screen flex justify-center items-center" style="background-color: rgba(0, 0, 0, 0.3);">
    <div class="flex w-3/5 h-2/3 bg-grey-1 rounded-3xl shadow-2xl overflow-hidden">

        <div class="w-1/2 flex flex-col justify-center items-center">
            <form name="login" action="doLogin" method="POST" class="w-5/6 flex flex-col items-center">
                <input type="hidden" name="afterLoginUri" value="${param.afterLoginUri}"/>
                <div class="flex flex-col w-2/3 h-full mb-4">
                    <input type="text" name="name"
                           class="bg-white border-grey-2 text-sm rounded-lg block p-3 mb-4"
                           placeholder="이름">
                    <input type="text" name="loginId"
                           class="bg-white border-grey-2 text-sm rounded-lg block p-3 mb-4"
                           placeholder="ID">
                    <input type="text" name="loginPw"
                           class="bg-white border-grey-2 text-sm rounded-lg block p-3 mb-4"
                           placeholder="Password">
                    <input type="password" name="checkLoginPw"
                           class="bg-white border-grey-2 text-sm rounded-lg block p-3 mb-4"
                           placeholder="비밀번호 확인">
                    <input type="text" name="nickName"
                           class="bg-white border-grey-2 text-sm rounded-lg block p-3 mb-4"
                           placeholder="닉네임">
                    <input type="tel" name="cellPhone" pattern="[0-9]{11}" required
                           class="bg-white border-grey-2 text-sm rounded-lg block p-3 mb-4"
                           placeholder="전화번호">
                    <!-- 			<div class="text-neutral-400 mb-6 px-2">Enter your tel without highpen(-)</div> -->
                    <input type="email" name="email"
                           class="bg-white border-grey-2 text-sm rounded-lg block p-3 mb-4"
                           placeholder="e-mail">
                    <button type="submit"
                            class="p-3 mb-2 font-semibold bg-blue-2 text-grey-1 rounded-lg">
                        JOIN
                    </button>
                </div>
                <div class="login-menu flex justify-around my-4 px-20 w-full">
                    <a class="hover:text-underline" href="login">SIGN IN</a>
                </div>
            </form>
        </div>
        <div class="w-1/2 relative bg-blue-2 flex items-center">
            <img src="/image/signup2.png" alt="LOGIN IMG">
            <div class="absolute" style="top: 0; left: -20px;">
                <svg width="20" height="20" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <mask id="join_up">
                            <g transform="translate(100, 0) scale(-1, 1) rotate(90 50 50)">
                                <rect width="100" height="100" fill="white"/>
                                <circle cx="100" cy="0" r="100" fill="black"/>
                            </g>
                        </mask>
                    </defs>
                    <rect width="100" height="100" fill="#2f73d9" mask="url(#join_up)"/>
                </svg>


            </div>
            <div class="absolute" style="top: calc(100% - 20px); left: -20px;">
                <svg width="20" height="20" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <mask id="join_down">
                            <g transform="translate(100, 0) scale(-1, 1)">
                                <g transform="scale(1, -1) translate(0, -100)">
                                    <g transform="rotate(90 50 50)">
                                        <rect width="100" height="100" fill="white"/>
                                        <circle cx="100" cy="0" r="100" fill="black"/>
                                    </g>
                                </g>
                            </g>
                        </mask>
                    </defs>
                    <rect width="100" height="100" fill="#2f73d9" mask="url(#join_down)"/>
                </svg>


            </div>
        </div>
    </div>
</div>
<%@ include file="../common/foot.jspf" %>