<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>CRIS Admin view</title>
</head>
<body>
	<%@ include file="Header.jsp"%>
	<h2>Create researcher</h2>
	<form action="CreateResearcherServlet" method="post">
		<input type="text" name="id" placeholder="User Id"> 
		<input type="text" name="name" placeholder="Name">
		<input type="text" name="lastname" placeholder="Last name">
		<input type="text" name="email" placeholder="Email">
		<input type="text" name="password" placeholder="Password">
		<button type="submit">Create researcher</button>
	</form>

</body>
</html>