<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!-- Date JQuery Imports -->
<script type="text/javascript">
function dateChecker() {
	var something = document.getElementById("datepicker").value;
	var something1 = document.getElementById("datepicker1").value;
	if(something == "" || something1 == "")
	{
			alert('Please enter date !!!');
	}
}

$(function() {
    $("#datepicker").datepicker();
  });
  
$(function() {
    $("#datepicker1").datepicker();
  });
</script>
<link rel="stylesheet" href="css/jquery-ui.css">
<link rel="stylesheet" href="css/pure-min.css">
<!-- Date JQuery Imports -->
	<%
		Boolean isloggedin = (Boolean) session.getAttribute("isloggedin");
		if(isloggedin == null || isloggedin == Boolean.FALSE)
		{
		    out.write("<script type='text/javascript'>\n");
		    out.write("alert(' Your session has expired. Please login again. ');\n");
		    out.write("setTimeout(function(){window.location.href='index.jsp'},0);");
		    out.write("</script>\n");	    
		}
	%>
<div id="menu">
	<div class="pure-menu pure-menu-open">
		<a class="pure-menu-heading"
			style="text-transform: none; font-size: 120%" href="#">JewelTrack<sup>tm</sup></a>

		<ul>
			<li class="" id="dashboard-link"><a href="dashboard.jsp" >Home</a></li>
			<li class="" id="report-link"><a href="report.jsp" >Report</a></li>

			<li class="" id="inventory-link"><a href="inventory.jsp" >Inventory</a></li>

			<li class="" id="sale-link"><a href="sale.jsp" >Sale</a></li>
			<li class="" id="mortgage-link"><a href="mortgage.jsp" >Mortgage</a></li>
			<li class="" id="search-link"><a href="search.jsp" >Search</a></li>
		</ul>
		<ul>
			<li><a onclick="myFunction()" href="#">Logout</a></li>
		</ul>
	</div>

</div>