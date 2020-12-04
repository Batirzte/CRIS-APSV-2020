<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>CRIS Login view</title>
</head>
<body>
	<%@ include file="Header.jsp"%>
	
	<% UserService userService = UserServiceFactory.getUserService();%>

<c:if test="${pageContext.request.userPrincipal == null}">
  <p><a href='<%=userService.createLoginURL(request.getRequestURI())%>'>
        Login with Google</a>
  </p>
</c:if>

<c:if test="${pageContext.request.userPrincipal != null}">
  <p><a href='<%=userService.createLogoutURL(request.getRequestURI())%>'>
        Logout from Google</a>
	</p>
</c:if>
	
	
	<h2>Login</h2>
	<form action="LoginServlet" method="post">
		<input type="text" name="email" placeholder="Email">
		<input type="password" name="password" placeholder="Password">
		<button type="submit">Login</button>
	</form>

</body>
</html>