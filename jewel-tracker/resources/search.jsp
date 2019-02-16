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
<meta name="description" content="A layout example with a side menu that hides on mobile, just like the Pure website.">

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
    	document.getElementById("search-link").className = "menu-item-divided pure-menu-selected";
    }
    </script>
</head>

<%
	ArrayList<CustomerBean> list = null;
	if(session.getAttribute("List")!=null)
	{
		list = (ArrayList<CustomerBean>)session.getAttribute("List");
	}
%>

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
		
        <div class="content" style="padding-right: 8em">
        <div class="pure-g" >
					<form action="CustomerSearch" method="get" style="margin:0px auto">
						<div class="pure-u-1-1">
							<div class="pure-form pure-form-aligned">
								<fieldset>
								<div class="pure-control-group">
										<label for="tags">Customer Name: </label> <input name="customerName" id="tags"
											placeholder="Customer Name" required="required" autocomplete="off">
									</div>
									<div class="pure-control-group">
										<label for="number">Customer Number: </label> <input name="customerNumber" id="number"
											type="text" placeholder="Customer Number" 
											>
									</div>
									<div class="pure-control-group">
										<label for="address">Customer Address</label> <input id="address" name="customerAddress"
											type="text" placeholder="Customer Address" >
									</div>
									<div class="pure-u-2-1" style="text-align: center">
							<input type="submit" style="margin-left:10em; padding: 0.5em 2em 0.5em 2em;" name="Submit" class="button-success pure-button" value="Search" />
						</div>
          </fieldset>
        </div>
    </div>
    </form>
</div>
<script src="js/ui.js"></script>
<%
	if(list!=null)
	{
%>
<div  class="pure-u-2-1" style=" padding-top: 3em;">
<%
		Iterator<CustomerBean> iter = list.iterator();
		%>
		<table class="pure-table pure-table-bordered" style="margin : 0px auto;">
    <thead>
        <tr>
            <th>Name</th>
            <th>Phone no.</th>
            <th>Address</th>
        </tr>
    </thead>

    <tbody>
        <tr>
		<%
		while(iter.hasNext()) 
		{
		    CustomerBean csbean = iter.next();
%>
	
            <td><a href="customerdetail.jsp?id=<%=csbean.getCustomerID() %>"><%=csbean.getCustomerName() %></a></td>
            <td><%=csbean.getCustomerPhoneNum() %></td>
            <td><%=csbean.getCustomerAddress() %></td>
        </tr>

    
	<%	
		}
		
	%>
	</tbody>
</table>
	</div>

	<%
	}
	%>

</div>
</div>
</div>

</body>
</html>
