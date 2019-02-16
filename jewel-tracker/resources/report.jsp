<%@page import="java.sql.Date"%>
<%@page import="sale.SaleTransactionBean"%>
<%@page import="java.util.Iterator"%>
<%@page import="mortgage.MortgageTransactionBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description"
	content="A layout example with a side menu that hides on mobile, just like the Pure website.">

<title>Mangal &nbsp;Murti</title>
<link rel="stylesheet"
	href="css/pure-min.css">

<!--[if lte IE 8]>
        <link rel="stylesheet" href="css/layouts/side-menu-old-ie.css">
    <![endif]-->
<!--[if gt IE 8]><!-->
<link rel="stylesheet" href="css/layouts/side-menu.css">
<!--<![endif]-->

<script type="text/javascript"
	src="js/offline-scripts/jquery-2.1.1.min.js"></script>
<script src="js/offline-scripts/jquery-ui-1.11.0.js"></script>
<style type="text/css">
.center-text {
	text-align: center;
	padding-top: 5em;
}

.span-pad {
	padding: 0.4em;
}
</style>
<script type="text/javascript">
	function myFunction() {
		var x;
		if (confirm("Do you want to logout ???") == true) {
			window.location.replace("logout.jsp");
		} else {
			x = "You pressed Cancel!";
		}
		document.getElementById("demo").innerHTML = x;
	}
	function pageEssentials() {
		document.getElementById("report-link").className = "menu-item-divided pure-menu-selected";
	}
</script>
</head>
<body onload="pageEssentials()">
	<div id="layout">
		<!-- Menu toggle -->
		<a href="#menu" id="menuLink" class="menu-link"> <!-- Hamburger icon -->
			<span></span>
		</a>

		<%@include file="menu.jsp"%>

		<div id="main">

			<%@include file="header.jsp"%>

			<div class="content">
				<div class="pure-g">
					<form action="ReportServ" method="post">
						<div class="pure-u-1-1" style="text-align:center; margin-left:130px;">
							<div class="pure-form pure-form-aligned">
								<fieldset>
										<div class="pure-control-group">
											<label for="date">From Date</label> 
											<input id="datepicker" type="text" placeholder="Date" autocomplete="off" name="fromDate" required="required" readonly>
										</div>
										<div class="pure-control-group">
											<label for="date">To Date</label> 
											<input id="datepicker1" type="text" placeholder="Date" autocomplete="off" name="toDate" required="required" readonly>
										</div>
										<div class="pure-control-group" >
											<span style="padding:30px;"></span>
											<label for="option-three" class="pure-radio">Sale</label>
											<input id="option-three" type="radio" name="optionsRadios" value="sale" required>
											<label for="option-two" class="pure-radio" style="text-align:left; padding-left:10px; width:65px;">Mortgage</label>
											<input id="option-two" type="radio" name="optionsRadios" value="mortgage" required>
										</div>
										<div class="pure-control-group" style="text-align:right; padding-right:80px;">
											<input type="submit" style="padding: 0.5em 2em 0.5em 2em;" name="Submit" class="button-success pure-button" onclick="dateChecker()" value="Show Reports" />
										</div>
								</fieldset>
							</div>
						</div>
					</form>
					<!-- ------------------------------- Data Display Starts here ----------------------------- -->
					<div class="pure-u-1-1">
					<%
						String fromDate = (String) request.getAttribute("fromDate");
						String toDate = (String) request.getAttribute("toDate");
					%>
					<div class="pure-form pure-form-aligned">
					<%
					    ArrayList<SaleTransactionBean> sArray = new ArrayList<SaleTransactionBean>();
					    ArrayList<MortgageTransactionBean> mArray = new ArrayList<MortgageTransactionBean>();

					    if (request.getAttribute("sarray") != null)
					    {

					        sArray = (ArrayList<SaleTransactionBean>)request.getAttribute("sarray");
					        Iterator sarrayIter = sArray.iterator();
					%>
					<h3>Sale Transactions Report from <%=fromDate%> to <%=toDate%></h3>
					<table class="pure-table pure-table-bordered" style="width: 100%">
						<tbody>
						<thead>
							<tr>
								<th>Customer Name</th>
								<th>Product Price</th>
								<th>Date of Sale</th>
							</tr>
						</thead>
						<%
						    SaleTransactionBean sbean = new SaleTransactionBean();
						        while (sarrayIter.hasNext())
						        {
						            sbean = (SaleTransactionBean)sarrayIter.next();
						%>
						<tr>
							<td><a
								href="customerdetail.jsp?id=<%=sbean.getCustomerBean().getCustomerID()%>"><%=sbean.getCustomerBean().getCustomerName()%></a></td>
							<td><%=sbean.getSalePrice()%></td>
							<td><%=sbean.getDateOfSale()%></td>
						</tr>

						<%
						    }
						%>
					</table>


					<%
					    }
					    else if (request.getAttribute("marray") != null)
					    {
					        mArray = (ArrayList<MortgageTransactionBean>)request.getAttribute("marray");
					        Iterator marrrayIter = mArray.iterator();
					%>
					<h3>Mortgage Transactions Report from <%=fromDate%> to <%=toDate%></h3>
					<table class="pure-table pure-table-bordered" style="width: 100%">
						<tbody>
						<thead>
							<tr>
								<th>Customer Name</th>
								<th>Mortgage Amount</th>
								<th>Mortgage Date</th>
							</tr>
						</thead>
						<%
						    MortgageTransactionBean mbean = new MortgageTransactionBean();
						        while (marrrayIter.hasNext())
						        {
						            mbean = (MortgageTransactionBean)marrrayIter.next();
						%>
						<tr>
							<td><a
								href="customerdetail.jsp?id=<%=mbean.getCbean().getCustomerID()%>"><%=mbean.getCbean().getCustomerName()%></a></td>
							<td><%=mbean.getMortgageAmount()%></td>
							<td><%=mbean.getMortgageDate()%></td>
						</tr>

						<%
						    }
						%>
					</table>
					<%
					    }
					%>
				</div>
				</div>
				</div>
			</div>
		</div>
	</div>
	<script src="js/ui.js"></script>
</body>
</html>
