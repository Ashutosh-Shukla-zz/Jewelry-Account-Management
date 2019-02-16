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
<meta name="description" content="A layout example with a side menu that hides on mobile, just like the Pure website.">

<title>Mangal &nbsp;Murti</title>
<link rel="stylesheet" href="css/layouts/font-awesome.css">

<!--[if lte IE 8]>
        <link rel="stylesheet" href="css/layouts/side-menu-old-ie.css">
    <![endif]-->
<!--[if gt IE 8]><!-->
<link rel="stylesheet" href="css/layouts/side-menu.css">
<!--<![endif]-->
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

html {
	overflow-y: scroll;
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
		window.history.replaceState("", "Mangal &nbsp;Murti", "/sale.jsp");
		document.getElementById("sale-link").className = "menu-item-divided pure-menu-selected";
	}

	function readProduct() {
		var type = document.getElementById("prd-type");

		var selectedValue = type.options[type.selectedIndex].value;

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
					document.getElementById("product-tag-select").innerHTML = xmlhttp.responseText;
				}
			}
		};
	}

	$(function() {
		var availableTags = [ <%=new JdbcSearchUtility().ajaxCustomerName() != null?new JdbcSearchUtility().ajaxCustomerName():"" %> ];
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
		String successString = request.getParameter("saleSuccess");
    	if(successString != null)
    	{
    	    if(Boolean.parseBoolean(successString) == true) 
    	    {
    %>
    			alert("Sale performed successfully");
    <%
    	    }
    	    else
    	    {
	%>
				alert("Error performing sale");
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

			<div class="content" style="padding-right: 8em">
				<div class="pure-g" >
					<form action="Sale" method="post" style="margin:0px auto" autocomplete="off" onSubmit="return validateForm()" >
						<div class="pure-u-1-1">
							<div class="pure-form pure-form-aligned">
								<fieldset>

									<div class="pure-control-group">
										<label for="tags">Customer Name: </label> <input name="tags" id="tags" autocomplete="off" 
											placeholder="Customer Name" required="required" maxlength ="100" onblur= "inputAlphabet();" >
										 
									</div>

									<div class="pure-control-group">
										<label for="number">Phone Number: </label> <input name="number" id="number" autocomplete="off" 
											type="text" placeholder="Customer Phone Number" required="required" maxlength="50"
											onfocus="updatePhoneSuggestion()" onblur="updateAddress();textNumeric()">
									</div>
									<div class="pure-control-group">
										<label for="address">Address</label> <input id="address" name="address" autocomplete="off" 
											type="text" placeholder="Address" maxlength="4000">
									</div>
								</fieldset>
							</div>
							<div class="pure-form pure-form-aligned">
								<fieldset>
									<div class="pure-control-group">
										<label for="product-type">Product Type :</label> 
										<select name="type" id="prd-type" onchange="readProduct()" required="required" >
											<option value="" selected>Select Product Type</option>
											<%
											    JdbcSaleUtility sf = new JdbcSaleUtility();
											    ArrayList<String> prdType = sf.getProductTypeFromInventory();
											    Iterator<String> prdTypeIter = prdType.iterator();
											    while (prdTypeIter.hasNext())
											    {
											        String prodctType = prdTypeIter.next();
											%>
											<option value="<%=prodctType%>"><%=prodctType%></option>
											<%
											    }
											%>
										</select>
									</div>
									<div class="pure-control-group" id="product-tag">
										<label for="product-tag">Product Tag :</label>
										<select id="product-tag-select" name="product-tag">
												<option value="" selected></option>
										</select>
									</div>

									<div class="pure-control-group" id="product-weight">
										<label for="weight">Product Weight</label> 
										<input id="weight" name="product-weight" autocomplete="off" required="required" type="text" placeholder="Weight">
									</div>
									
									<div class="pure-control-group" >
										<label for="price">Product Price</label> 
										<input id="price" type="number" placeholder="Price" autocomplete="off" required="required" name="price" step="any">
									</div>
									 
									<div class="pure-control-group" >
										<label for="date">Date of Sale</label> 
										<input id="datepicker" type="text" placeholder="Date" onblur="dateChecker()" autocomplete="off" name="date" required="required" readonly>
									</div>
									<script type="text/javascript">
							        
									function isEmi(){
							           
							                if ($("#is-emi").prop('checked') == true) {
							                    $('#emi-field').show();
							                    $('#emi-installment').show();
							                    $('#emi-field-label').show();
							                    $('#emi-installment-label').show();
							                    $('input[id=emi-field]').prop('required',true);
							                    $('input[id=emi-installment]').prop('required',true); 
							                } else {
							                    $('#emi-field').hide();
							                     $('#emi-installment').hide();
							                    $('#emi-field-label').hide();
							                    $('#emi-installment-label').hide();
							                    $('input[id=emi-field]').prop('required',false);
							-                    $('input[id=emi-installment]').prop('required',false);
							                }
							           
							         };

									</script>
									<div class="pure-control-group" >
								        <label for="is-emi">EMI</label>
								        <input id="is-emi" onclick="isEmi();" name="check-emi" type="checkbox">
								    </div>

								    <div class="pure-control-group" >
								    	<label for="emi-field" id="emi-field-label" style="display:none" >Number of EMI</label>
										<input type="number" placeholder="Number of EMIs" autocomplete="off" name="no-of-emi" style="display:none" id="emi-field">
								    </div>
								    
								    <div class="pure-control-group" >
								    	<label for="emi-installment-label" id="emi-installment-label" style="display:none" >EMI Installment</label>
										<input type="number" placeholder="1st EMI Amount" autocomplete="off" name="emi-installment" style="display:none" id="emi-installment" >
								    </div>
								    
								</fieldset>
							</div>
						</div>
						<div class="pure-u-2-1" style="text-align: center">
							<input type="submit" style="margin-left:10em; padding: 0.5em 2em 0.5em 2em;" name="Submit" class="button-success pure-button" value="Sale" />
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script src="js/ui.js"></script>
</body>
</html>
