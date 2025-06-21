<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="CERTIFY"></c:set>
<%@ include file="../common/head.jspf" %>


<script>
    $(document).ready(function () {

        var boardId = ${boardId} +1;

        $('.header').addClass('active');
    });
</script>
<%@ include file="../common/foot.jspf" %>