<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="ARTICLE MODIFY"></c:set>
<%@ include file="../common/head.jspf" %>
<%@ include file="../common/toastUiEditorLib.jspf" %>

<script>
    $(document).ready(function () {

        const header = $('.header');
        const topBar = $('.topBar');

        header.addClass('active');
        header.removeClass('bg-grey-1');
        topBar.removeClass('text-grey-100');
        topBar.addClass('text-blue-2');
        $('.nav_box > ul > li:nth-child(3) i').addClass('active');

        $('.hamburgerIcon').addClass("main");

    });
</script>

<script type="text/javascript">
    function articleModify__submit(form) {
        form.title.value = form.title.value.trim();
        const body = $(form).find('.toast-ui-editor').data('data-toast-editor').getMarkdown().trim();

        if (form.title.value.length == 0) {
            Swal.fire({
                icon: 'warning',
                title: '제목을 입력해주세요.',
                confirmButtonText: '확인'
            });
            return false;
        }

        if (body.length == 0) {
            Swal.fire({
                icon: 'warning',
                title: '내용을 입력해주세요.',
                confirmButtonText: '확인'
            });
            return false;
        }

        form.body.value = body;
        form.submit();
    }
</script>

<div class="container mx-auto my-24 p-6 w-4/5 border border-solid border-neutral-300 rounded-xl overflow-hidden">
    <form onsubmit="articleModify__submit(this); return false;" action="doModify" method="POST" class="w-full">
        <input type="hidden" name="id" value="${article.id}">
        <div class="flex justify-center flex-col">
            <div class="flex px-3">
                <label class="flex-grow">
                    <input class="w-full px-4 py-2 border border-neutral-500 border-solid rounded-lg "
                           type="text" name="title" placeholder="제목을 입력하세요" value="${article.title}" required>
                </label>
            </div>
            <br>
            <section class="w-full p-4 rounded-lg">
                <textarea class="resize-none hidden" name="body"></textarea>
                <div class="toast-ui-editor h-72">
                    <script type="text/x-template">
                        ${article.body}
                    </script>
                </div>
            </section>
            <br>
        </div>

        <div class="text-right px-2 pb-2">
            <button type="submit"
                    class="py-2.5 px-5 w-32 text-base font-large bg-neutral-800 text-neutral-200 rounded-lg hover:bg-neutral-700">
                수정하기
            </button>
        </div>
    </form>
</div>

<%@ include file="../common/foot.jspf" %>