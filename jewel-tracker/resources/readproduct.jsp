<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="launch.manager.DerbyManager"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
    Connection conn = DerbyManager.getManager().createConnection();
    String type = request.getParameter("productType");
    String query = "SELECT JT_PRD_TAG FROM JT_INV WHERE JT_PRD_TYPE='" + type + "' AND JT_PRD_IS_SOLD<>1";
    ResultSet rs = conn.createStatement().executeQuery(query);
    String output = "";
    while (rs.next())
    {
        String tag = rs.getString("JT_PRD_TAG");
        output += "<option value='" + tag + "'>" + tag + "</option>";

    }
    out.print(output);
%>