<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="pageTitle" value="LOGIN"></c:set>
<%@ include file="../common/head.jspf" %>

<script type="text/javascript">
    $('.back').addClass('hidden');

    function MemberFindLoginPw__submit(form) {
        event.preventDefault();

        const $form = $(form);
        const $loginId = $form.find('input[name="loginId"]');
        const $email = $form.find('input[name="email"]');

        const loginId = $loginId.val().trim();
        const email = $email.val().trim();

        let hasError = false;

        // 모든 에러 메시지 숨기기
        $form.find('.msg-area').addClass('opacity-0');

        if (loginId.length === 0) {
            $form.find('.msgFromName').removeClass('opacity-0');
            $loginId.focus();
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
        form.submit();
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
            <form action="../member/doFindLoginPw" method="POST" onsubmit="MemberFindLoginPw__submit(this);"
                  class="mt-20 w-5/6 flex flex-col items-center">
                <input type="hidden" name="afterLoginUri" value="${param.afterLoginUri}"/>
                <div class="flex flex-col w-2/3 h-full mb-4">
                    <%--                    <input type="text" name="loginId"--%>
                    <%--                           class="bg-white border-grey-2 text-sm rounded-lg block p-4 mb-4"--%>
                    <%--                           placeholder="ID">--%>
                    <input class="bg-white border-grey-2 text-sm rounded-lg block p-4"
                           autocomplete="off" type="text" placeholder="아이디" name="loginId"/>
                    <div class="self-start m-1 msg-area msgFromName opacity-0 text-right text-red-400 mb-2">* 아이디가 입력되지
                        않았습니다.
                    </div>
                    <input class="bg-white border-grey-2 text-sm rounded-lg block p-4 mt-4 mb-2"
                           autocomplete="off" type="text" placeholder="이메일" name="email"/>
                    <div class="self-start m-1 msg-area msgFromEmail opacity-0 text-right text-red-400 mb-4">* 이메일이 입력되지
                        않았습니다.
                    </div>

                    <button type="submit"
                            class="p-3 mb-4 font-semibold bg-blue-2 text-grey-1 rounded-lg">
                        비밀번호 찾기
                    </button>
                </div>
                <div class="login-menu flex justify-around my-4 px-20 w-full">
                    <a class=" hover:underline" href="join">Join</a>
                    <a class=" hover:underline" href="login">Login</a>
                    <a class=" hover:underline" href="findLoginId">Find ID</a>
                </div>
            </form>
        </div>
<%--        <div class="showLoginId hidden w-1/2 mb-8 p-12 flex flex-col justify-center items-center text-lg tracking-wide">--%>
<%--            <div class="flex-grow flex items-center justify-center">--%>
<%--                <span class="member-name font-semibold"></span> &nbsp; 님의 아이디는&nbsp;&nbsp;--%>
<%--                <span class="member-loginId font-semibold"></span> &nbsp;입니다.--%>
<%--            </div>--%>
<%--            <div class="login-menu flex justify-around my-4 px-20 w-full">--%>
<%--                <a class=" hover:underline" href="join">Join</a>--%>
<%--                <a class=" hover:underline" href="login">Login</a>--%>
<%--                <a class=" hover:underline" href="findLoginId">Find ID</a>--%>
<%--            </div>--%>
<%--        </div>--%>
    </div>
</div>

<section class="hidden mt-8 text-xl px-4">
    <div class="mx-auto">
        <form action="../member/doFindLoginPw" method="POST" onsubmit="MemberFindLoginPw__submit(this);">
            <input type="hidden" name="afterFindLoginPwUri" value="${param.afterFindLoginPwUri  }"/>
            <table class="login-box table-box-1" border="1">
                <tbody>
                <tr>
                    <th>아이디</th>
                    <td>
                        <input class="input input-bordered w-full max-w-xs" autocomplete="off" type="text"
                               placeholder="아이디를 입력해주세요"
                               name="loginId"/>
                    </td>
                </tr>
                <tr>
                    <th>이메일</th>
                    <td>
                        <input class="input input-bordered w-full max-w-xs" autocomplete="off" type="text"
                               placeholder="이메일을 입력해주세요"
                               name="email"/>
                    </td>
                </tr>
                <tr>
                    <th></th>
                    <td>
                        <button type="submit">비밀번호 찾기</button>
                    </td>
                </tr>
                <tr>
                    <th></th>
                    <td>
                        <a class="btn btn-active btn-ghost" href="../member/login">로그인</a>
                    </td>
                </tr>
                </tbody>
            </table>
        </form>
        <div class="btns">
            <button class="btn btn-outline" type="button" onclick="history.back();">뒤로가기</button>
        </div>
    </div>
</section>

<div class="hidden h-screen flex justify-center items-center">
    <div class="container max-w-min p-4 bg-neutral-200 border border-solid border-neutral-300 rounded-lg">
        <div class="title mt-4 mb-8 text-center text-2xl font-semibold">
            비밀번호 찾기
        </div>
        <div class="mb-8">
            <form action="../member/doFindLoginPw" method="POST" onsubmit="MemberFindLoginPw__submit(this);">
                <input type="hidden" name="afterLoginUri" value="${param.afterFindLoginPwUri }"/>
                <div class="flex flex-col items-center">
                    <input class="bg-neutral-50 border border-neutral-300 text-neutral-800 text-sm rounded-lg block w-96 p-2.5"
                           autocomplete="off" type="text" placeholder="아이디를 입력해주세요" name="loginId"/>
                    <div class="self-start m-1 msg-area msgFromName hidden text-right text-red-400">* 아이디가 입력되지 않았습니다.
                    </div>
                    <input class="mt-4 bg-neutral-50 border border-neutral-300 text-neutral-800 text-sm rounded-lg block w-96 p-2.5"
                           autocomplete="off" type="text" placeholder="이메일을 입력해주세요" name="email"/>
                    <div class="self-start m-1 msg-area msgFromEmail hidden text-right text-red-400">* 이메일이 입력되지 않았습니다.
                    </div>
                    <button type="submit"
                            class="py-2.5 px-5 mt-10 mb-2 w-96 text-sm font-large bg-neutral-800 text-neutral-200 rounded-lg hover:bg-neutral-700">
                        찾기
                    </button>
                </div>
            </form>
        </div>
        <div class="login-menu text-center justify-around my-4 flex">
            <a class="hover:underline" href="join">Join</a>
            <a class="hover:underline" href="login">Login</a>
            <a class="hover:underline" href="findLoginId">Find ID</a>
        </div>
    </div>
</div>

<%@ include file="../common/foot.jspf" %>