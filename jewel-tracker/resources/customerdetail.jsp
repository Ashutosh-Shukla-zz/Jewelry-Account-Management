<%@page import="mortgage.JdbcMortgageUtility"%>
<%@page import="mortgage.MortgageProductBean"%>
<%@page import="mortgage.MortgageTransactionBean"%>
<%@page import="product.ProductBean"%>
<%@page import="sale.SaleTransactionBean"%>
<%@page import="customer.JdbcCustomerUtility"%>
<%@page import="sale.JdbcSaleUtility"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="customer.CustomerBean"%>
<%@page import="search.CustomerSearchBean"%>
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
<link rel="stylesheet" href="css/colorbox.css" />
<script src="js/offline-scripts/jquery.min.js"></script>
<script src="js/jquery.colorbox.js"></script>

<!--[if lte IE 8]>
        <link rel="stylesheet" href="css/layouts/side-menu-old-ie.css">
    <![endif]-->
<!--[if gt IE 8]><!-->
<link rel="stylesheet" href="css/layouts/side-menu.css">
<!--<![endif]-->
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

<style type="text/css">
.center-text {
	text-align: center;
	padding-top: 5em;
}

.span-pad {
	padding: 0.4em;
}
</style>
<script>
			$(document).ready(function(){
				$(".iframe").colorbox({iframe:true, width:"70%", height:"80%"});
			});
</script>			
<script type="text/javascript">
	function myFunction() {
		var x = "";
		if (confirm("Do you want to logout ???") == true) {
			window.location.replace("logout.jsp");
		} else {
			x = "You pressed Cancel!";
		}
		document.getElementById("demo").innerHTML = x;
	}
	function pageEssentials() {
		document.getElementById("search-link").className = "menu-item-divided pure-menu-selected";
	}
	
	function deleteImagesFromDb(){
		var custID = <%= request.getParameter("id")%>
		var xmlhttp;
		if (window.XMLHttpRequest) {
			xmlhttp = new XMLHttpRequest(); //for IE7+, Firefox, Chrome, Opera, Safari
		} else {
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); //for IE6, IE5
		}
		xmlhttp.open("GET", "deleteoldimages.jsp?id=" + custID, true);
		xmlhttp.send(null);
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4) {
				if (xmlhttp.status == 200) {
					var isSuccess = xmlhttp.responseText;
					if(isSuccess)
					{
						alert("Images deleted for Completed Mortgage");
					}
					else
					{
						alert("Error deleting images");
					}
				}
			}
		};
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
				<div class="pure-g ">
					<div class="pure-u-1-1">
						<div class="pure-form pure-form-aligned">
							<!-- ----------------------------------------------------- CUSTOMER START ------------------------------------------------------------- -->
							<%
							    String cID = request.getParameter("id");
							    int customerID = Integer.parseInt(cID);
							    CustomerBean cBean = JdbcCustomerUtility.getCustomerById(customerID);
							%>
							<h3>Customer Profile</h3>
							<table class="pure-table pure-table-bordered" style="width: 100%">
								<thead>
									<tr>
										<th colspan="2" style="text-align: center">Customer Details</th>
									</tr>
								</thead>

								<tbody>
									<tr>
										<td style="width: 15em;">Customer ID</td>
										<td><%=cBean.getCustomerID()%></td>
									</tr>

									<tr>
										<td>Customer Name</td>
										<td><%=cBean.getCustomerName()%></td>
									</tr>

									<tr>
										<td>Customer Phone</td>
										<td><%=cBean.getCustomerPhoneNum()%></td>
									</tr>

									<tr>
										<td>Customer Address</td>
										<td><%=cBean.getCustomerAddress()%></td>
									</tr>
								</tbody>
							</table>
							
							<!-- ------------------------------------------------------ CUSTOMER END -------------------------------------------------------------- -->
							<!-- ------------------------------------------------------- SALE START --------------------------------------------------------------- -->
							
							<%
							    ArrayList<SaleTransactionBean> sBeanList = new JdbcCustomerUtility().fetchCustomerSaleDetails(cBean);
							    Iterator<SaleTransactionBean> iterator = sBeanList.iterator();
							%>
							<h3>Sale Transactions</h3>
							<table class="pure-table pure-table-bordered" style="width: 100%">
								<tbody>
								<thead>
									<tr>
										<th>Product Type</th>
										<th>Product Tag</th>
										<th>Product Weight</th>
										<th>Product Price</th>
										<th>Date of Sale</th>
										<th>EMI</th>
									</tr>
								</thead>
								<%
								    while (iterator.hasNext())
								    {
								        SaleTransactionBean sBean = iterator.next();
								        ProductBean pBean = sBean.getProductBean();
								%>
								<tr>
									<td><%=pBean.getProductType()%></td>
									<td><%=pBean.getProductTag()%></td>
									<td><%=pBean.getProductWeight()%></td>
									<td><%=sBean.getSalePrice()%></td>
									<td><%=sBean.getDateOfSale()%></td>
								<%
									if(sBean.isEMI())
									{
								%>
									<td><a class='iframe' href="<%=request.getContextPath()%>/salehistoryupdate.jsp?sTransID=<%=sBean.getSaleTransactionID()%>">EMI Details</a></td>
								<%
									}
									else
									{
								%>
									<td>NA</td>
								<%
									}
								%>
								</tr>
								<%
								    if (iterator.hasNext())
								        {
								            sBean = iterator.next();
								            pBean = sBean.getProductBean();
								%>
								<tr class="pure-table-odd">
									<td><%=pBean.getProductType()%></td>
									<td><%=pBean.getProductTag()%></td>
									<td><%=pBean.getProductWeight()%></td>
									<td><%=sBean.getSalePrice()%></td>
									<td><%=sBean.getDateOfSale()%></td>
									<%
										if(sBean.isEMI())
										{
									%>
										<td><a class='iframe' href="<%=request.getContextPath()%>/salehistoryupdate.jsp?sTransID=<%=sBean.getSaleTransactionID()%>">EMI Details</a></td>
									<%
										}
										else
										{
									%>
										<td>NA</td>
									<%
										}
									%>
								</tr>
								<%
								    	}
								    }
								%>
								</tbody>
							</table>
							
							<!-- ------------------------------------------------------ SALE END -------------------------------------------------------------- -->
							<!-- --------------------------------------------------- MORTGAGE START ----------------------------------------------------------- -->
							
							<%
								ArrayList<MortgageTransactionBean> mBeanList = new JdbcCustomerUtility().fetchCustomerMortgageDetails(cBean);
							    Iterator<MortgageTransactionBean> mBeanIter = mBeanList.iterator();
							%>
							<h3>Mortgage Transactions</h3>
							<table class="pure-table pure-table-bordered" style="width: 100%">
								<tbody>
								<thead>
									<tr>
										<th>Product Type</th>
										<th>Product Weight</th>
										<th>Product Description</th>
										<th>Product Price</th>
										<th>Product Image</th>
										<th>Loan Amount</th>
										<th>Loan Date</th>
										<th>Update Mortgage</th>
									</tr>
								</thead>
								<%
								    while (mBeanIter.hasNext())
								    {
								        MortgageTransactionBean mBean = mBeanIter.next();
								   	 	MortgageProductBean mpBean = mBean.getMbean();
								%>
								<tr>
									<td><%=mpBean.getProductType()%></td>
									<td><%=mpBean.getProductWeight()%></td>
									<td><%=mpBean.getProductDesc()%></td>
									<td><%=mpBean.getProductPrice()%></td>
									<td><a class="iframe" href="<%=request.getContextPath()%>/MortgageImage?mortgageTransID=<%=mBean.getMortgageTransactionID()%>">View Image</a></td>
									<td><%=mBean.getMortgageAmount()%></td>
									<td><%=mBean.getMortgageDate()%></td>
									<td><a class="iframe" href="<%=request.getContextPath()%>/mortgagehistoryupdate.jsp?mTransID=<%=mBean.getMortgageTransactionID()%>">Mortgage Details</a></td>
								</tr>
								<%
								    if (mBeanIter.hasNext())
								        {
								        	mBean = mBeanIter.next();
								            mpBean = mBean.getMbean();
								%>
								<tr class="pure-table-odd">
									<td><%=mpBean.getProductType()%></td>
									<td><%=mpBean.getProductWeight()%></td>
									<td><%=mpBean.getProductDesc()%></td>
									<td><%=mpBean.getProductPrice()%></td>
									<td><a class="iframe" href="<%=request.getContextPath()%>/MortgageImage?mortgageTransID=<%=mBean.getMortgageTransactionID()%>">View Image</a></td>
									<td><%=mBean.getMortgageAmount()%></td>
									<td><%=mBean.getMortgageDate()%></td>
									<td><a class="iframe" href="<%=request.getContextPath()%>/mortgagehistoryupdate.jsp?mTransID=<%=mBean.getMortgageTransactionID()%>">Mortgage Details</a></td>
								</tr>
								<%
								    	}
								    }
								%>
								</tbody>
							</table>
							<!-- ---------------------------------------------------- MORTGAGE END ------------------------------------------------------------ -->
							<!-- <div class="pure-control-group" style="width: 15%; margin: 0px auto; margin-top: 1em;">
								<input type="button" name="Submit" class="button-success pure-button" value="Delete Old Images" onclick="deleteImagesFromDb()" />
							</div> -->
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="js/ui.js"></script>
</body>
</html>
