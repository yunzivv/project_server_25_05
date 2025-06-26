<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="LOGIN"></c:set>
<%@ include file="../common/head.jspf" %>

<script type="text/javascript">

    $('.back').addClass('hidden');

</script>


<div class="h-screen flex justify-center items-center">
    <div class="container mx-auto max-w-min p-4 bg-grey-1 border-grey-2 rounded-lg">
        <div class="title mt-4 mb-8 text-center text-2xl font-semibold">
            Login
        </div>
        <form name="login" action="doLogin" method="POST">
            <input type="hidden" name="afterLoginUri" value="${param.afterLoginUri}"/>
            <div class="flex flex-col items-center">
                <input type="text" name="loginId"
                       class="mb-6 bg-neutral-50 border border-neutral-300 text-sm rounded-lg block w-96 p-2.5"
                       placeholder="ID">
                <input type="text" name="loginPw"
                       class="mb-6 bg-neutral-50 border border-neutral-300 text-sm rounded-lg block w-96  p-2.5"
                       placeholder="Password">
                <button type="submit"
                        class="py-2.5 px-5 mb-2 w-96 text-sm font-large bg-blue-2 text-grey-1 rounded-lg hover:bg-neutral-700">
                    Login
                </button>
            </div>
        </form>
        <div class="login-menu text-center justify-around my-4 flex">
            <a class="hover:underline" href="join">Join</a>
            <a class="hover:underline" href="findLoginId">Find ID</a>
            <a class="hover:underline" href="findLoginPw">Find Password</a>
        </div>
    </div>
</div>

<%@ include file="../common/foot.jspf" %>