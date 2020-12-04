<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>CRIS ResearcherView</title>
</head>
<body>
	<%@ include file="Header.jsp"%>


<table>
<tr>
<th>Id</th><th>Name</th><th>Last name</th><th>URL</th><th>Email</th><th>Npubs</th>
</tr>
	<tr>
	    <td>${ri.id}</td>
		<td>${ri.name}</td>
		<td>${ri.lastname}</td>
		<td><a href="${ri.scopusURL}">Scopus URL</a></td>
		<td>${ri.email}</td>
		<td>${fn:length(ri.publications)}</td>
	</tr>
</table>

<table>
<c:forEach items="${publications}" var="pi">
	<tr>
	    <td> <a href="PublicationServlet?pi=${pi.id}"> ${pi.id}</a></td>
	</tr>
</c:forEach>
</table>

<h2>Create publication</h2>
<form action="CreatePublicationServlet" method="post">
	<input type="text" name="id" placeholder="Publication Id"> 
	<input type="text" name="title" placeholder="Title">
	<input type="text" name="publicationname" placeholder="Publication name">
	<input type="text" name="publicationdate" placeholder="Publication date">
	<input type="text" name="authors" placeholder="Authors">
	<button type="submit">Create publication</button>
</form>


</body>
</html>