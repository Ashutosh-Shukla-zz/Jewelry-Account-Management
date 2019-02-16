<%@page import="java.sql.SQLException"%>
<%@page import="launch.manager.DerbyManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="mortgage.JdbcMortgageUtility"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
    // JdbcMortgageUtility mUtil = new JdbcMortgageUtility();
    // Boolean result = mUtil.deleteImagesForCompletedMortagages(request.getParameter("id"));
    // out.print(result);
%>

<%
    String customerId = request.getParameter("id");
    String sql = "UPDATE JT_MRTG SET JT_MRTG_PRD_IMG = NULL WHERE JT_MRTG_ID IN ";
    sql += "(SELECT JT_MRTG_ID FROM JT_MRTG_TRANS WHERE  JT_CT_ID = " + Integer.parseInt(customerId)
            + " AND JT_MRTG_TRANS_ID IN ";
    sql += "(SELECT JT_MRTG_TRANS_ID FROM JT_MRTG_TRANS_HIST WHERE JT_BALANCE_AMT = '0'))";
    boolean isSuccess = false;
    try
    {
        Statement stmt = DerbyManager.getConnection().createStatement();

        int result = stmt.executeUpdate(sql);
        isSuccess = result >= 1 ? true : false;
    }
    catch (SQLException e)
    {
        e.printStackTrace();
    }
    out.print(isSuccess);
%>