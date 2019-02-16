<%@page import="search.JdbcSearchUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	String custName = (String)request.getParameter("custName");
	out.print(new JdbcSearchUtility().getPhoneNumByCustName(custName));
%>