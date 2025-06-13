<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="WORK BOOK"></c:set>
<%@ include file="../common/head.jspf"%>


<script>
    $(document).ready(function () {
        $('.header').addClass('active');
        $('.nav_box > ul > li:nth-child(4) i').addClass('active');


        $('.side_bar_left').addClass('active');
        $('.side_bar_left > .myPage_sub_menu ').removeClass('hidden');
        $('.side_bar_left > .myPage_sub_menu > li:nth-child(2) > a').addClass('active');
        $('.side_bar_left > .myPage_sub_menu > li:nth-child(2) > a > i').addClass('active');
    });

</script>

work book

<%@ include file="../common/foot.jspf"%>