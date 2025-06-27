<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="LOGIN"></c:set>
<%@ include file="../common/head.jspf" %>

<script type="text/javascript">

    $('.back').addClass('hidden');

    setTimeout(function () {
        const coverLogo = $('.member_loading');
        coverLogo.addClass('actived');
        coverLogo.on('transitionend', function () {
            coverLogo.addClass('hidden');
        });
    }, 1300);

    setTimeout(function () {
        const $cover = $('.login_cover');
        $cover.addClass('slide');
        $cover.on('transitionend', function () {
            $cover.addClass('hidden');
        });
    }, 1500);

    setTimeout(function () {
        $('.login_form').removeClass('opacity-0');
    }, 1800);

</script>


<div class="login_fullPage h-screen flex justify-center items-center" style="background-color: rgba(0, 0, 0, 0.3);">
    <div class="flex w-3/5 h-2/3 bg-grey-1 rounded-3xl shadow-2xl overflow-hidden relative">
        <div class="member_loading folding-text absolute w-full h-full z-50 text-10xl">
            <span>C</span><span>E</span><span>R</span><span>T</span><span>I</span><span>F</span><span>Y</span>
        </div>
        <div class="login_cover bg-grey-1 rounded-3xl"></div>
        <div class="w-1/2 relative bg-blue-2 flex items-center pt-20">
            <img src="/image/signin2.png" alt="LOGIN IMG">
            <div class="absolute" style="top: 0; left: 100%;">
                <svg width="20" height="20" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <mask id="login_up">
                            <g transform="rotate(90 50 50)">
                                <rect width="100" height="100" fill="white"/>
                                <circle cx="100" cy="0" r="100" fill="black"/>
                            </g>
                        </mask>
                    </defs>
                    <rect width="100" height="100" fill="#2f73d9" mask="url(#login_up)"/>
                </svg>
            </div>
            <div class="absolute" style="top: calc(100% - 20px); left: 100%;">
                <svg width="20" height="20" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <mask id="login_down">
                            <g transform="scale(1, -1) translate(0, -100)">
                                <g transform="rotate(90 50 50)">
                                    <rect width="100" height="100" fill="white"/>
                                    <circle cx="100" cy="0" r="100" fill="black"/>
                                </g>
                            </g>
                        </mask>
                    </defs>
                    <rect width="100" height="100" fill="#2f73d9" mask="url(#login_down)"/>
                </svg>

            </div>
            <a href="join" class="block max-w-max absolute text-grey-1 font-bold" style="right: 20px; bottom: 20px;">SIGN
                UP <i class="mr-2 fa-solid fa-angle-right"></i>
            </a>
        </div>
        <div class="login_form w-1/2 flex flex-col justify-center items-center opacity-0">
            <%--            <div class="title w-full p-4 text-4xl font-semibold">--%>
            <%--                Login--%>
            <%--            </div>--%>
            <form name="login" action="doLogin" method="POST" class="mt-20 w-5/6 flex flex-col items-center">
                <input type="hidden" name="afterLoginUri" value="${param.afterLoginUri}"/>
                <div class="flex flex-col w-2/3 h-full mb-4">
                    <input type="text" name="loginId"
                           class="bg-white border-grey-2 text-sm rounded-lg block p-4 mb-4"
                           placeholder="ID">
                    <input type="text" name="loginPw"
                           class="bg-white border-grey- text-sm rounded-lg block p-4 mb-4"
                           placeholder="Password">
                    <button type="submit"
                            class="p-3 mb-4 font-semibold bg-blue-2 text-grey-1 rounded-lg">
                        LOG IN
                    </button>
                    <div class="flex justify-between items-center py-2"><hr class="w-2/5">OR<hr class="w-2/5"></div>
                    <button type="submit"
                            class="p-3 font-semibold bg-blue-2 text-grey-1 rounded-lg">
                        GOOGLE
                    </button>
                </div>
                <div class="login-menu flex justify-around my-4 px-20 w-full">
                    <a class=" hover:underline" href="join">Join</a>
                    <a class=" hover:underline" href="findLoginId">Find ID</a>
                    <a class=" hover:underline" href="findLoginPw">Find PW</a>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="../common/foot.jspf" %>