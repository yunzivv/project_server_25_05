<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="ARTICLE WRITE"></c:set>
<%@ include file="../common/head.jspf" %>
<%@ include file="../common/toastUiEditorLib.jspf" %>

<%--<script>--%>

<%--    $(document).ready(function () {--%>
<%--        // $('.back').addClass("hidden");--%>
<%--        $('.header').addClass('active');--%>
<%--        $('.nav_box > ul > li:nth-child(3) i').addClass('active');--%>
<%--    });--%>
<%--</script>--%>
<script>
    $(document).ready(function () {

        const header = $('.header');
        const topBar = $('.topBar');

        header.addClass('active');
        header.removeClass('bg-grey-1');
        // header.addClass('bg-white');
        topBar.removeClass('text-grey-100');
        topBar.addClass('text-blue-2');
        $('.nav_box > ul > li:nth-child(3) i').addClass('active');

        $('.hamburgerIcon').addClass("main");

    });
</script>

<script type="text/javascript">
    function articleWrite__submit(form) {

        form.title.value = form.title.value.trim();
        const board = $(form).find('#boardId').val();
        console.log(board);
        const body = $(form).find('.toast-ui-editor').data('data-toast-editor').getMarkdown().trim();

        if (!board || board == 0) {
            alert('게시판을 선택해주세요.');
            return false;
        }

        if (form.title.value.length == 0) {
            alert('제목을 작성해주세요.');
            return false;
        }

        if (body.length == 0) {
            alert('내용을 작성해주세요.');
            return false;
        }

        form.body.value = body;
        form.submit();
    }
</script>


<%
    String currentUrl = request.getRequestURI();
    String query = request.getQueryString();
    String fullUrl = currentUrl + (query != null ? "?" + query : "");
    String encodedUrl = java.net.URLEncoder.encode(fullUrl, "UTF-8");
%>

<div class="container mx-auto my-24 p-6 w-4/5 border border-solid border-neutral-300 rounded-xl overflow-hidden">

    <%--		<div class="font-semibold text-4xl text-neutral-800 px-1 py-6"></div>--%>

    <form onsubmit="articleWrite__submit(this); return false;" action="doWrite" method="POST" class="w-full">
        <div class="flex justify-center flex-col">
            <div class="flex px-3">
                <label for="boardId" class="flex mr-4">
                    <select name="boardId" id="boardId" required
                            class="block flex justify-center items-center px-8 border border-solid border-neutral-500 rounded-lg overflow-hidden">
                        <option value="0" disabled selected hidden class="text-neutral-400">게시판 선택</option>
                        <option value="1">공지사항</option>
                        <option value="2">시험후기</option>
                        <option value="3">자료실</option>
                        <option value="4">QnA</option>
                        <option value="5">자유게시판</option>
                    </select>
                </label>
                <div class="flex-grow">
                    <input class="w-full px-4 py-2 border border-neutral-500 border-solid rounded-lg " type="text"
                           name="title" placeholder="제목을 입력하세요"/>
                </div>
            </div>
            <br>
            <section class="w-full p-4 rounded-lg">
                <textarea class="resize-none hidden" name="body"></textarea>
                <div class="toast-ui-editor h-72">
                    <script type="text/x-template"></script>
                </div>
            </section>
            <br>
        </div>

        <div class="text-right px-2 pb-2">
            <button type="submit"
                    class="py-2.5 px-5 w-32 text-base font-large bg-neutral-800 text-neutral-200 rounded-lg hover:bg-neutral-700">
                Write
            </button>
        </div>

    </form>
</div>

<%@ include file="../common/foot.jspf" %>