<%@page import="mortgage.MortgageTransactonHistoryBean"%>
<%@page import="mortgage.JdbcMortgageUtility"%>
<%@page import="java.util.Iterator"%>
<%@page import="sale.SaleHistoryTransactionBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="sale.JdbcSaleUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/pure-min.css">
<script src="js/offline-scripts/jquery-ui-1.11.0.js"></script>
<link rel="stylesheet" href="css/layouts/font-awesome.css">
<script src="js/offline-scripts/jquery.min.js"></script>
<link rel="stylesheet" href="css/jquery-ui.css">
<script src="js/jquery.colorbox.js"></script>
<title>Insert title here</title>
<style type="text/css">
<!--
Global CSS -->.center-text {
	text-align: center;
	padding-top: 5em;
}

.span-pad {
	padding: 0.4em;
}

#scrollable-dropdown-menu .tt-dropdown-menu {
	max-height: 150px;
	overflow-y: auto;
}

.button-success,.button-error,.button-warning,.button-secondary {
	color: white;
	border-radius: 4px;
	text-shadow: 0 1px 1px rgba(0, 0, 0, 0.2);
}

.button-success {
	background: rgb(28, 184, 65); /* this is a green */
}

html {
	overflow-y: scroll;
}
<!-- Global CSS End -->
</style>

<!-- Date JQuery Imports -->
<script type="text/javascript">
$(function() {
    $( "#datepicker" ).datepicker();
  });
</script>
<script src="js/offline-scripts/jquery-ui-1.11.0.js"></script>

<!-- Date JQuery Imports -->

</head>
<body>

	<%
	    int mTransId = 0;
		mTransId = Integer.parseInt(request.getParameter("mTransID"));
	    JdbcMortgageUtility mrtgUtil = new JdbcMortgageUtility();
	    ArrayList<MortgageTransactonHistoryBean> historyList = new ArrayList<MortgageTransactonHistoryBean>();
	    historyList = mrtgUtil.fetchMortgageHistory(mTransId);
	%>


	<form action="UpdateMortgage" method="post">
		<table class="pure-table pure-table-bordered" style="width: 100%">
			<thead>
				<tr>
					<th>Sr No.</th>
					<th>Paid Amount</th>
					<th>Paid on</th>
					<th>Balance</th>
				</tr>
			</thead>
			<tbody>
				<%
				    int i = 1;
				    MortgageTransactonHistoryBean mHistBean = null;
				    Iterator iter = historyList.iterator();
				    while (iter.hasNext())
				    {
				        mHistBean = (MortgageTransactonHistoryBean)iter.next();
				%>
				<tr>
					<td><%=i%></td>
					<td><%=mHistBean.getPartialAmount()%></td>
					<td><%=mHistBean.getPaymenDate()%></td>
					<td><%=mHistBean.getBalanceAmount()%></td>

				</tr>

				<%
				    i++;
				    }
				    if(!mHistBean.getBalanceAmount().equalsIgnoreCase("0"))
				    {
				%>
				<%-- ?saleID=<%=saleTransID %> --%>
				<tr>
					<td><%=i%></td>
					<td>
						<input name="mortgage-amount" id="mortgage-amount" type="text" placeholder="Mortgage partial amount" required="required" />
					</td>
					<td>
						<input type="text" name="mortgage-part-date"  onblur="dateChecker()" id="datepicker" placeholder="Mortgage partial Date" required="required" readonly>
					</td>
					<td>--</td>

					<input type="hidden" value="<%=mTransId%>" name="mTransId" />
					<input type="hidden" value="<%=mHistBean.getBalanceAmount()%>" name="balance" /> 
				</tr>
				<tr>
					<td colspan="4" style="text-align: center">
						<div class="pure-u-2-1" style="text-align: center">
							<input type="submit" style="margin-left: 10em; padding: 0.5em 2em 0.5em 2em;" name="Submit" class="button-success pure-button" value="Update Mortgage" onclick="$.colorbox.close();" />
						</div>
					</td>
				</tr>
				<%
				    }
				%>
			</tbody>
		</table>
	</form>
</body>
</html>