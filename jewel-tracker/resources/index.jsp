<%@page import="java.net.URL"%>
<%@page import="java.net.URLClassLoader"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="A layout example with a side menu that hides on mobile, just like the Pure website.">

    <title>Mangal &nbsp;Murti</title>
<link rel="stylesheet" href="css/pure-min.css">

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
</head>
<body>
<div id="layout">
    <!-- Menu toggle -->
    <a href="#menu" id="menuLink" class="menu-link">
        <!-- Hamburger icon -->
        <span></span>
    </a>

    <div id="menu">
        <div class="pure-menu pure-menu-open">
            <a class="pure-menu-heading" style="text-transform:none; font-size:120%" href="#">
                JewelTrack<sup>tm</sup>
            </a>
        </div>
    </div>

    <div id="main">
        <div class="header">
            <h1 style="margin-right: 1em">Mangal Murti Jewellers</h1>
        </div>
		
        <div class="content">
           <div class="center-text" >
           <form class="pure-form" action="Login" method="post">
                <fieldset>
                    <input type="text" placeholder="Email" name="username" required >
                    <div class="span-pad"></div>
                    <input type="password" placeholder="Password" name="password" required >
                    <div class="span-pad"></div>
                    <button type="submit" class="pure-button pure-button-primary">Sign in</button>
                </fieldset>
            </form>
            </div>
        </div>
    </div>
</div>
<script src="js/ui.js"></script>
</body>
</html>
