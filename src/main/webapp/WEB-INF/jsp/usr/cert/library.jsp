<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="LIBRARY"></c:set>
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/side.jspf"%>

<script>
    $('.side_bar_left').addClass('active');
	$(document).ready(function () {
		$('.nav_box > ul > li:nth-child(1) i').addClass('active');
        $('.side_bar_left > .hub_sub_menu ').removeClass('hidden');
        $('.side_bar_left > .hub_sub_menu > li:nth-child(2) > a').addClass('active');
        $('.side_bar_left > .hub_sub_menu > li:nth-child(2) > a > i').addClass('active');
	});
</script>

<div class="bg-grey-1">

</div>

<%@ include file="../common/foot.jspf"%>