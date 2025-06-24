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
        $form.find('.msg-area').addClass('hidden');

        if (loginId.length === 0) {
            $form.find('.msgFromName').removeClass('hidden');
            $loginId.focus();
            hasError = true;
        }

        if (email.length === 0) {
            $form.find('.msgFromEmail').removeClass('hidden');
            if (!hasError) {
                $email.focus();
            }
            hasError = true;
        }

        if (hasError) return;
        form.submit();
    }
</script>


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

<div class="h-screen flex justify-center items-center">
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