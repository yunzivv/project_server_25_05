<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="pageTitle" value="LOGIN"></c:set>
<%@ include file="../common/head.jspf" %>

<script type="text/javascript">
    $('.back').addClass('hidden');

    function MemberFindLoginId__submit(form) {
        event.preventDefault();

        const $form = $(form);
        const $name = $form.find('input[name="name"]');
        const $email = $form.find('input[name="email"]');

        const name = $name.val().trim();
        const email = $email.val().trim();

        let hasError = false;

        $form.find('.msg-area').addClass('opacity-0');

        if (name.length === 0) {
            $form.find('.msgFromName').removeClass('opacity-0');
            $name.focus();
            hasError = true;
        }

        if (email.length === 0) {
            $form.find('.msgFromEmail').removeClass('opacity-0');
            if (!hasError) {
                $email.focus();
            }
            hasError = true;
        }

        if (hasError) return;

        // AJAX 요청
        $.post($form.attr("action"), $form.serialize(), function (data) {

            console.log(data);
            if (data.resultCode.startsWith("F-")) {
                const $emailError = $form.find('.msgFromEmail');
                $emailError.removeClass('opacity-0').text(data.msg);
                return;
            }

            // 성공 시 처리
            const member = data.data1;

            $(".findLoginIdForm").addClass("hidden");
            $(".showLoginId").removeClass("hidden");
            $(".showLoginId .member-name").text(member.name);
            $(".showLoginId .member-loginId").text("[ " + member.loginId + " ]");
        }, "json");
    }
</script>

<div class="login_fullPage h-screen flex justify-center items-center" style="background-color: rgba(0, 0, 0, 0.3);">
    <div class="flex w-3/5 h-2/3 bg-grey-1 rounded-3xl shadow-2xl overflow-hidden relative">
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
        <div class="findLoginIdForm w-1/2 flex flex-col justify-center items-center">
            <form action="../member/doFindLoginId" method="POST" onsubmit="MemberFindLoginId__submit(this);"
                  class="mt-20 w-5/6 flex flex-col items-center">
                <input type="hidden" name="afterLoginUri" value="${param.afterLoginUri}"/>
                <div class="flex flex-col w-2/3 h-full mb-4">
                    <input class="bg-white border-grey-2 text-sm rounded-lg block p-4"
                           autocomplete="off" type="text" placeholder="이름"
                           name="name"/>
                    <div class="self-start m-1 msg-area msgFromName opacity-0 text-right text-red-400 mb-2">* 이름이 입력되지
                        않았습니다.
                    </div>
                    <input class="bg-white border-grey-2 text-sm rounded-lg block p-4 mt-4 mb-2"
                           autocomplete="off" type="text" placeholder="이메일"
                           name="email"/>
                    <div class="self-start m-1 msg-area msgFromEmail opacity-0 text-right text-red-400 mb-4">* 이메일이 입력되지
                        않았습니다.
                    </div>

                    <button type="submit"
                            class="p-3 mb-4 font-semibold bg-blue-2 text-grey-1 rounded-lg">
                        아이디 찾기
                    </button>
                </div>
                <div class="login-menu flex justify-around my-4 px-20 w-full">
                    <a class=" hover:underline" href="join">Join</a>
                    <a class=" hover:underline" href="findLoginId">Login</a>
                    <a class=" hover:underline" href="findLoginPw">Find PW</a>
                </div>
            </form>
        </div>
        <div class="showLoginId hidden w-1/2 mb-8 p-12 flex flex-col justify-center items-center text-lg tracking-wide">
        <div class="flex-grow flex items-center justify-center">
            <span class="member-name font-semibold"></span> &nbsp; 님의 아이디는&nbsp;&nbsp;
            <span class="member-loginId font-semibold"></span> &nbsp;입니다.</div>
            <div class="login-menu flex justify-around my-4 px-20 w-full">
                <a class=" hover:underline" href="join">Join</a>
                <a class=" hover:underline" href="findLoginId">Login</a>
                <a class=" hover:underline" href="findLoginPw">Find PW</a>
            </div>
        </div>
    </div>
</div>


<%@ include file="../common/foot.jspf" %>