<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>CRIS ResearchersListView</title>
</head>
<body>
	<%@ include file="Header.jsp"%>

<table>
<tr>
<th>Id</th><th>Name</th><th>Last name</th><th>URL</th><th>Publications</th><th>Email</th>
</tr>
<c:forEach items="${researcherslist}" var="ri">
	<tr>
	    <!--<td>${ri.id}</td>-->
	    <td> <a href="ResearcherServlet?id=${ri.id}"> ${ri.id}</a></td>
		<td>${ri.name}</td>
		<td>${ri.lastname}</td>
		<td>${ri.scopusURL}</td>
		<td>${fn:length(ri.publications)}</td>
		<td>${ri.email}</td>
	</tr>
</c:forEach>
</table>


</body>
</html>