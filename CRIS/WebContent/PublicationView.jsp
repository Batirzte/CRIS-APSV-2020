<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>CRIS Publication view</title>
</head>
<body>
	<%@ include file="Header.jsp"%>

<table>
<tr>
<th>Id</th><th>Title</th><th>Publication name</th><th>Date</th><th>Authors</th><th>Cite count</th>
</tr>
	<tr>
	    <td>${pub.id}</td>
		<td>${pub.title}</td>
		<td>${pub.publicationName}</td>
		<td>${pub.publicationDate}</td>
		<td>${pub.authors}</td>
		<td>${pub.citeCount}</td>
	</tr>
</table>

<c:if test="${user.id == 'root'}">
<h2>Update citations of publication</h2>
<a href="UpdateCitationsAPIServlet?id=${pub.id}"> ${pub.id}</a>
</c:if>

</body>
</html>