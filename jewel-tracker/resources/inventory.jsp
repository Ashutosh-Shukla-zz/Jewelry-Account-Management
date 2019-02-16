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
<script type="text/javascript" src="js/offline-scripts/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="js/offline-scripts/jquery-ui.js"></script>
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
    .button-success {
		background: rgb(28, 184, 65);
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
    	$('#show-inv').hide();
    	$('#inventoryAdd').hide();
    	document.getElementById("inventory-link").className = "menu-item-divided pure-menu-selected";
    }
    
    
    function readProduct() {
    	$('#add-button').show();
    	$('#show-inv').hide();
    	$('#inventoryAdd').hide();
    	$('#prdType').show();
		var type = document.getElementById("prd-type");

		var selectedValue = type.options[type.selectedIndex].value;
		
		if(selectedValue == "")
			{
			$('#prd-table').hide();
			return;
			} 
		var xmlhttp;
		if (window.XMLHttpRequest) {
			xmlhttp = new XMLHttpRequest(); //for IE7+, Firefox, Chrome, Opera, Safari
		} else {
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); //for IE6, IE5
		}
		xmlhttp.open("GET", "getInventoryDetailsByProductType.jsp?productType=" + selectedValue,
				true);
		xmlhttp.send(null);
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4) {
				if (xmlhttp.status == 200) {
					document.getElementById("prd-table").innerHTML = xmlhttp.responseText;
					$('#prd-table').show();
				}
			}
		};
	}

    function showInventoryAdd(){
    	$('#inventoryAdd').show();
    	$('#prd-table').hide();
    	$('#add-button').hide();
    	$('#prdType').hide();
    	$('#show-inv').show();
    }

	$(function() {
		<%	
			ArrayList<String> prdType1 = new JdbcSaleUtility().getProductTypeFromInventory();
			Iterator<String> prdTypeIter1 = prdType1.iterator();
			String finalArray = "";
			while(prdTypeIter1.hasNext())
			{
			    finalArray += "\"";
			    finalArray += prdTypeIter1.next();
			    finalArray += "\"";
			    if(prdTypeIter1.hasNext())
			        finalArray += ",";
			}
		%>
		var availableTags = [<%=finalArray%>];
		$("#productType").autocomplete({
			source : availableTags
		});
	});
    </script>
</head>
<body onload="pageEssentials()">
<div id="layout">
    <!-- Menu toggle -->
    <a href="#menu" id="menuLink" class="menu-link">
        <!-- Hamburger icon -->
        <span></span>
    </a>
    
    <%@include file="menu.jsp"%>
    
    <div id="main">
    
    <%@include file="header.jsp"%>
    		
        <div class="content">
        <div class="pure-g" >
        <div class="pure-u-1-1">
        <div class="pure-form pure-form-aligned" >
        <div class="pure-control-group" id="prdType" style="text-align: center">
										<label for="product-type">Product Type :</label> 
										<select name="type" id="prd-type" onchange="readProduct()" >
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
									<div style="margin: 0px auto;">
									<div class="pure-control-group" style="text-align: center; padding-top: 20px; padding-bottom: 20px;" id = "prd-table">
									</div>
									</div>
									<div id ="add-button" style="text-align: center">
									<button class="pure-button button-success" style="margin-left:10em; padding: 0.5em 2em 0.5em 2em;" onclick="showInventoryAdd();">Add A Product</button>
									</div>
									</div>
			<form class="pure-form pure-form-aligned" action="InventoryAdd" method="get" style="margin:0px auto  padding-top: 20px;" id = "inventoryAdd">
			
                <fieldset>
                					
                <div class="pure-control-group" style="text-align: center">
										<label for="productType">Product Type: </label> <input name="productType" id="productType"
											placeholder="Product Type" required="required">
									</div>
									
									<div class="pure-control-group" style="text-align: center">
										<label for="productTag">Product Tag: </label> <input name="productTag" id="productTag"
											placeholder="Product Tag" required="required">
									</div>
									
									<div class="pure-control-group" style="text-align: center">
										<label for="productWeight">Product Weight: </label> <input name="productWeight" id="productWeight"
											placeholder="Product Weight" required="required">
									</div>
					
					<div class="pure-u-2-1" style="text-align: center">
							<input type="submit" style="margin-left:10em; padding: 0.5em 2em 0.5em 2em;" name="Submit" class="button-success pure-button" value="Add A Product" />
					</div>
					<br>
			        <div id ="show-inv" style="text-align: center">
						<button class="pure-button button-success" style="margin-left:10em; padding: 0.5em 2em 0.5em 2em;" onclick="readProduct();">Show Inventory</button>
					</div>
				    
				 </fieldset>
				
			</form>
			 </div>
        </div>
        </div>
    </div>
</div>
<script src="js/ui.js"></script>
</body>
</html>
