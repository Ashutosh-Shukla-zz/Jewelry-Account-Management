<%@page import="product.ProductBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="launch.manager.DerbyManager"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
    Connection conn = DerbyManager.getManager().createConnection();
    String type = request.getParameter("productType");
    String query = "SELECT JT_INV_ID, JT_PRD_TYPE, JT_PRD_TAG, JT_PRD_WGHT, JT_PRD_IS_SOLD FROM JT_INV WHERE JT_PRD_TYPE='" + type + "'";
 	ArrayList<ProductBean> productList = new ArrayList<ProductBean>();
    ResultSet rs = conn.createStatement().executeQuery(query);
    String output = "<table class=\"pure-table\" style=\"margin: 0px auto;\">"
    	    +"<thead>"
    +"<tr>"
        +"<th>Product Id</th>"
        +"<th>Product Type</th>"
        +"<th>Product Tag</th>"
        +"<th>Product Weight</th>"
        +"<th>Product Status</th>"
    +"</tr>"
+"</thead>"

+"<tbody>";
   
   
   
    while (rs.next())
    {	
    	ProductBean product = new ProductBean();
        product.setInventoryID(rs.getInt(1));
        product.setProductType(rs.getString(2));
        product.setProductTag(rs.getString(3));
        product.setProductWeight(rs.getString(4));
        product.setSold(rs.getBoolean(5));
        String isSold="";
        if(product.isSold())
        {
        	isSold = "Sold";
        }
        else{
        	isSold = "Available";
        }
        
        productList.add(product);
        output += "<tr>"
        		+"<td>"+product.getInventoryID()+"</td>"
        		+"<td>"+product.getProductType()+"</td>"
        		+"<td>"+product.getProductTag()+"</td>"
    			+"<td>"+product.getProductWeight()+"</td>"
    			+"<td>"+ isSold +"</td>"
    			+"</tr>";
    }
    
    output += "</tbody></table>";

    out.print(output);
%>
