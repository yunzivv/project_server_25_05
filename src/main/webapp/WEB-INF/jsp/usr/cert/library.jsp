<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="LIBRARY"></c:set>
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/side.jspf"%>

<script>
		$(document).ready(function () {

			$('.nav_box > ul > li:nth-child(1) i').addClass('active');
            $('.side_bar > .hub_sub_menu ').removeClass('hidden');
            $('.side_bar > .hub_sub_menu > li:nth-child(2) > a').addClass('active');
		});
</script>

library

<%@ include file="../common/foot.jspf"%>