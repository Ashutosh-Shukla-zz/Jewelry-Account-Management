<%@page import="search.JdbcSearchUtility"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="sale.JdbcSaleUtility"%>
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

<!--[if lte IE 8]>
        <link rel="stylesheet" href="css/layouts/side-menu-old-ie.css">
    <![endif]-->
<!--[if gt IE 8]><!-->
<link rel="stylesheet" href="css/layouts/side-menu.css">
<!--<![endif]-->


<style type="text/css">
.center-text {
	text-align: center;
	padding-top: 5em;
}

.span-pad {
	padding: 0.4em;
}
</style>
<style type="text/css">
<!-- Global CSS -->

.center-text {
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

<!-- Global CSS End -->
</style>
<script type="text/javascript" src="js/offline-scripts/jquery-2.1.1.min.js"></script>
<script src="js/offline-scripts/jquery-ui-1.11.0.js"></script>

<script type="text/javascript">

function textNumeric(){
	var x = document.getElementById("number").value;
	 var numericExpression = /^[0-9]+$/;
	 if(x.match(numericExpression)){
	 return true;
	 }else{
	 alert("Please enter a valid Number");
	 inputtext.focus();
	 return false;
	 }
	}

function inputAlphabet(){
	var x = document.getElementById("tags").value;
	 var alphaExp = /^[a-zA-Z]+$/;
	 if(x.match(alphaExp)){
	 return true;
	 }else{
	alert("Please enter a valid Name ");
	inputtext.focus();
	 return false;
	 }
	}

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
		window.history.replaceState("", "Mangal &nbsp;Murti", "/mortgage.jsp");
		document.getElementById("mortgage-link").className = "menu-item-divided pure-menu-selected";
	}

	
	
	function customerSearch() {
		var xmlhttp;
		if (window.XMLHttpRequest) {
			xmlhttp = new XMLHttpRequest(); //for IE7+, Firefox, Chrome, Opera, Safari
		} else {
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); //for IE6, IE5
		}
		xmlhttp.open("GET", "readproduct.jsp?productType=" + selectedValue,
				true);
		xmlhttp.send(null);
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4) {
				if (xmlhttp.status == 200) {
					document.getElementById("ajax-innerhtml").innerHTML = xmlhttp.responseText;
				}
			}
		};
	}
	
	$(function() {
		var availableTags = [ <%=new JdbcSearchUtility().ajaxCustomerName()%> ];
		$("#tags").autocomplete({
			source : availableTags
		});
	});

	function updatePhoneSuggestion() {
		var customerName = document.getElementById("tags").value;
		var xmlhttp;
		if (window.XMLHttpRequest) {
			xmlhttp = new XMLHttpRequest(); //for IE7+, Firefox, Chrome, Opera, Safari
		} else {
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); //for IE6, IE5
		}
		xmlhttp.open("GET", "readcustphone.jsp?custName=" + customerName, true);
		xmlhttp.send(null);
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4) {
				if (xmlhttp.status == 200) {
					$(function() {
						var availableTags = [ xmlhttp.responseText ];
						$("#number").autocomplete({
							source : availableTags
						});
					});
				}
			}
		};
	}

	function updateAddress() {
		var customerName = document.getElementById("tags").value;
		var custPhoneNumber = document.getElementById("number").value;
		var xmlhttp;
		if (window.XMLHttpRequest) {
			xmlhttp = new XMLHttpRequest(); //for IE7+, Firefox, Chrome, Opera, Safari
		} else {
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); //for IE6, IE5
		}
		xmlhttp.open("GET", "readaddress.jsp?custName=" + customerName + "&"
				+ "phoneNum=" + custPhoneNumber, true);
		xmlhttp.send(null);
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4) {
				if (xmlhttp.status == 200) {
					document.getElementById("address").value = xmlhttp.responseText;
				}
			}
		};
	}
	<%
	  String successString = request.getParameter("mortgageSuccess");
	     if(successString != null)
	     {
	         if(Boolean.parseBoolean(successString) == true) 
	         {
	    %>
	       alert("Mortgage performed successfully");
	    <%
	         }
	         else
	         {
	 %>
	    alert("Error performing mortgage");
	 <%
	         }
	     }
	    %>
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
					<form action="MortgageServ" enctype="multipart/form-data" method="post" style="margin:0px auto">
					<div class="pure-u-1-1">
						<div class="pure-form pure-form-aligned">
								<fieldset>

									<div class="pure-control-group">
										<label for="tags">Customer Name: </label> <input name="tags" id="tags"
											placeholder="Customer Name" required="required" maxlength ="100" onblur="inputAlphabet();">
									</div>

									<div class="pure-control-group">
										<label for="number">Phone Number: </label> <input name="number" id="number"
											type="text" placeholder="Customer Phone Number" required="required" 
											maxlength ="50"
											onfocus="updatePhoneSuggestion()" onblur="updateAddress();textNumeric()">
									</div>
									<div class="pure-control-group">
										<label for="address">Address</label> <input id="address" name="address"
											type="text" maxlength ="4000" placeholder="Address"  updateAddress()>
									</div>
								</fieldset>
							</div>
					
					<!-- Mortgage form -->
						<div class="pure-form pure-form-aligned">
							<fieldset>
								<div class="pure-control-group">
									<label for="productType">Product Type</label> <input id="productType" name="productType" type="text"
										placeholder="Product Type" required="required">
								</div>

								<div class="pure-control-group">
									<label for="productWeight">Product Weight</label> <input id="productWeight" name="productWeight"
										type="text" placeholder="Product Weight" required="required">
								</div>

								<div class="pure-control-group">
									<label for="productDesc">Product Description</label> <input id="productDesc" name="productDesc"
										type="text" placeholder="Description" >
								</div>
								
								<div class="pure-control-group">
									<label for="productPrice">Product Price</label> <input id="productPrice" name="productPrice"
										type="text" placeholder="Price" required="required">
								</div>
								
								<div class="pure-control-group">
									<label for="productImg">Product Image</label> <input id="productImg" name="productImg"
										type="file"  placeholder="Image" accept ="image/" style="width:200px;">
								</div>
								
								<div class="pure-control-group">
									<label for="productAmt">Loan Amount</label> <input id="productAmt" name="productAmt"
										type="text" placeholder="Loan Amount" required="required">
								</div>
								
									<div class="pure-control-group">
									<label for="productDate">Loan Date</label> <input id="datepicker" name="productDate"
										 onblur="dateChecker()" type="text" placeholder="Date of Mortgage" readonly required="required">
										
									</div>
									
									<div class="pure-control-group">
									<label for="expetedAmount">Expected Amount</label> <input id="expetedAmount" name="expetedAmount"
										type="text" placeholder="Amount Expected" required="required">
										
									</div>
								
							</fieldset>
						</div>
						<div class="pure-u-2-1" style="text-align: center">
							<input type="submit" style="margin-left:10em; padding: 0.5em 2em 0.5em 2em;" name="Submit" class="button-success pure-button" value="Create Mortgage" />
						</div>
						</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	<script src="js/ui.js"></script>
</body>
</html>
