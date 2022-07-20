<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*" import="model.*"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="./CSS/header.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	
    <title>UnlimitedSneakers</title>
  </head>
  <body>
    <div class="header">
      <div class="header_filter">
      </div>
      
       <div class="logo">
       <a href="./homepage.jsp">
       		<img width="80%" alt="" src="./img/logo.png"></a>
      	</div>
      
    </div>
    <div class="navbar">
      <div class="catalogo">
        <ul>
          <li><a class="links" href="./homepage.jsp">HOME</a></li>
          <li><a class="links" href="catalogo?filter=catalogo">CATALOGO</a></li>
          <li><a class="links" href="catalogo?filter=uomo">UOMO</a></li>
          <li><a class="links" href="catalogo?filter=donna">DONNA</a></li>
        </ul>
      </div>

      <div class="menu">
        <ul>
           <li>
           <form action="catalogo" method="get">
           <input type="hidden" name="filter" value="ricerca">
			<input type="text" name="name" class="search" placeholder="Cerca...">
			</form>
			</li>
          <li><a class="links"  href="./carrello.jsp" id="carrello" ><i class="material-icons">shopping_bag</i></a></li>
          
          <% if(request.getSession().getAttribute("logged") == null) {%>
          <li  id="utente"><a class="links" href="./login.jsp"><i class="material-icons">person</i></a></li>
          <% } else { %>
           <li  id="utente"><a class="links" href="./areaPersonale.jsp"><i class="material-icons">person</i></a></li>
          <% } %>
        </ul>
      </div>
    </div>

  </body>
</html>
