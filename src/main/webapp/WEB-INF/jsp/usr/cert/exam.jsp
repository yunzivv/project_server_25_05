<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="WORK BOOK"></c:set>
<%@ include file="../common/head.jspf" %>


<script>
	$(document).ready(function() {

		$('.header').addClass('active');
		$('.nav_box > ul > li:nth-child(2) i').addClass('active');
        $('.side_bar_left').addClass('active');
		$('.side_bar_left > .community_sub_menu ').removeClass('hidden');
	});
</script>



<%@ include file="../common/foot.jspf" %>