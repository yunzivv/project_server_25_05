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

        $form.find('.msg-area').addClass('hidden');

        if (name.length === 0) {
            $form.find('.msgFromName').removeClass('hidden');
            $name.focus();
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

        // AJAX 요청
        $.post($form.attr("action"), $form.serialize(), function (data) {

            console.log(data);
            if (data.resultCode.startsWith("F-")) {
                const $emailError = $form.find('.msgFromEmail');
                $emailError.removeClass('hidden').text(data.msg);
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


<div class="h-screen flex justify-center items-center">
    <div class="container max-w-min p-4 bg-neutral-200 border border-solid border-neutral-300 rounded-lg">
        <div class="title mt-4 mb-8 text-center text-2xl font-semibold">
            아이디 찾기
        </div>
        <div class="findLoginIdForm mb-8">
            <form action="../member/doFindLoginId" method="POST" onsubmit="MemberFindLoginId__submit(this);">
                <input type="hidden" name="afterLoginUri" value="${param.afterFindLoginIdUri }"/>
                <div class="flex flex-col items-center">
                    <input class="bg-neutral-50 border border-neutral-300 text-neutral-800 text-sm rounded-lg block w-96 p-2.5"
                           autocomplete="off" type="text" placeholder="이름을 입력해주세요"
                           name="name"/>
                    <div class="self-start m-1 msg-area msgFromName hidden text-right text-red-400">* 이름이 입력되지 않았습니다.
                    </div>
                    <input class="mt-4 bg-neutral-50 border border-neutral-300 text-neutral-800 text-sm rounded-lg block w-96 p-2.5"
                           autocomplete="off" type="text" placeholder="이메일을 입력해주세요"
                           name="email"/>
                    <div class="self-start m-1 msg-area msgFromEmail hidden text-right text-red-400">* 이메일이 입력되지
                        않았습니다.
                    </div>
                    <button type="submit"
                            class="py-2.5 px-5 mt-10 mb-2 w-96 text-sm font-large bg-neutral-800 text-neutral-200 rounded-lg hover:bg-neutral-700">
                        찾기
                    </button>
                </div>
            </form>
        </div>
        <div class="showLoginId hidden mb-8 p-6 flex justify-center items-center text-lg tracking-wide" style="height: 188px; width: 384px;">
            <span class="member-name font-semibold"></span> &nbsp; 님의 아이디는&nbsp;&nbsp;
            <span class="member-loginId font-semibold"></span> &nbsp;입니다.
        </div>
        <div class="login-menu text-center justify-around my-4 flex">
            <a class="hover:underline" href="join">Join</a>
            <a class="hover:underline" href="login">Login</a>
            <a class="hover:underline" href="findLoginPw">Find PW</a>
        </div>
    </div>
</div>


<%@ include file="../common/foot.jspf" %>