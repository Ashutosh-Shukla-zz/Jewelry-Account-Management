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
<link rel="stylesheet" href="css/jquery-ui.css">
<link rel="stylesheet" href="css/layouts/font-awesome.css">
<script src="js/offline-scripts/jquery.min.js"></script>
<script src="js/jquery.colorbox.js"></script>

<title>Insert title here</title>

<!-- Date JQuery Imports -->
<script type="text/javascript">
$(function() {
    $( "#datepicker" ).datepicker();
  });
</script>
<script src="js/offline-scripts/jquery-ui-1.11.0.js"></script>

<!-- Date JQuery Imports -->

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
<!--
Global
 
CSS
 
End
 
-->
</style>
</head>
<body>

	<%
	    int saleTransID = 0;
	    saleTransID = Integer.parseInt(request.getParameter("sTransID"));
	    JdbcSaleUtility saleUtil = new JdbcSaleUtility();
	    ArrayList<SaleHistoryTransactionBean> historyList = new ArrayList<SaleHistoryTransactionBean>();
	    historyList = saleUtil.fetchSaleHistory(saleTransID);
	%>


	<form action="UpdateEmiServ" method="post">
		<table class="pure-table pure-table-bordered" style="width: 100%">
			<thead>
				<tr>
					<th>Sr No.</th>
					<th>Emi Amount</th>
					<th>Paid on</th>
					<th>Balance</th>
				</tr>
			</thead>
			<tbody>
				<%
				    int i = 1;
				    SaleHistoryTransactionBean sHistBean = null;
				    Iterator iter = historyList.iterator();
				    while (iter.hasNext())
				    {
				        sHistBean = (SaleHistoryTransactionBean)iter.next();
				%>
				<tr>
					<td><%=i%></td>
					<td><%=sHistBean.getPartialAmount()%></td>
					<td><%=sHistBean.getEmiDate()%></td>
					<td><%=sHistBean.getBalance()%></td>

				</tr>

				<%
				    i++;
				    }
				    if(!(sHistBean.getBalance() == 0))
				    {
				%>
				<%-- ?saleID=<%=saleTransID %> --%>
				<tr>
					<td><%=i%></td>
					<td>
						<input name="emi-amount" id="emi-amount" type="text" placeholder="EMI amount" required="required" />
					</td>
					<td>
						<input type="text" name="paymentDate" id="datepicker" onblur="dateChecker()" placeholder="Payment Date" required="required" readonly>
					</td>
					<td>--</td>

					<input type="hidden" value="<%=sHistBean.getCustomerID()%>"name="customerId" />
					<input type="hidden" value="<%=saleTransID%>" name="saleID" />
					<input type="hidden" value="<%=sHistBean.getBalance()%>" name="balance" />
				</tr>
				<tr>
					<td colspan="4" style="text-align: center">
						<div class="pure-u-2-1" style="text-align: center">
							<input type="submit" style="margin-left: 10em; padding: 0.5em 2em 0.5em 2em;" name="Submit" class="button-success pure-button" value="Update EMI" onclick="$.colorbox.close();" />
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