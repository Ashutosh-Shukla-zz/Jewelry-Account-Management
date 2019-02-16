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
<link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.5.0/pure-min.css">

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
    	document.getElementById("dashboard-link").className = "menu-item-divided pure-menu-selected";
    }
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
          
        </div>
    </div>
</div>
<script src="js/ui.js"></script>
</body>
</html>
