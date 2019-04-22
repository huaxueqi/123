<%@ page language="java" contentType="text/json; charset=utf-8" pageEncoding="UTF-8" import="com.util.*"%>
<%
// 	HibernateUtil.rollback();
	Exception ex = (Exception) request.getAttribute("exception");
	String msg = ex.toString();
	if (msg.contains("RuntimeException")) msg = msg.split(":")[1];
	ex.printStackTrace();
%>
{"success":false,"msg":"<%=msg%>"}
