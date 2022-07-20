<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8" import="model.*" import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
	<link rel="stylesheet" href="./CSS/indirizzi.css">
	<title>Ordini</title>
</head>
<body>
	<jsp:include page="./header.jsp" />
	<% if(request.getAttribute("cliente") != null){ 
	  		String cliente = (String) request.getAttribute("cliente"); 
	  		request.removeAttribute("cliente");%>
	  		</br></br>
  			<h1 style="text-align: center;font-size: 2rem">Storico ordini del cliente "<%out.print(cliente);%>"</h1>
  		<% } else { %>
  			</br></br>
	  		<h1 style="text-align: center;font-size: 2rem">Storico ordini</h1>
	  		<% } %>
	 <div class="sezione">
    	<% if(request.getSession().getAttribute("logged") == null) {
    		response.sendRedirect("./loginForm.jsp");
    	} else {
    	List<OrdineBean> ordini = (List<OrdineBean>) request.getSession().getAttribute("ordini"); 
  		Iterator<OrdineBean> iterOrdini = ordini.iterator();
  		boolean admin = (boolean) request.getSession().getAttribute("admin");
  		OrdineBean ordine = new OrdineBean(); 
  		while (iterOrdini.hasNext()){
  			ordine = iterOrdini.next();%>
  		<div class="carte">
  		<h3>Ordine #<% out.println(ordine.getNumOrdineProgressivo()); %></h3>
  		<%  if(admin) {%>
  			<p style="font-size:1.2em;">
  				<strong>Cliente:</strong> <% out.print(ordine.getCliente()); %>
  			</p>
  		<% } %>
  		<p style="font-size:1.2em;">
  			<strong>Data acquisto:</strong> <% out.print(ordine.getDataAcquisto()); %>
  		</p>
   		<p style="font-size:1.2em;">
  			<strong>Totale:</strong> <% out.println(String.format("%.2f", ordine.getCostoTotale())); %> &euro;<br><br>
  		</p>
  			<form action="gestisciOrdine" method="get">
  				<input type="hidden" name="ordine" value="<%out.print(ordine.getNumOrdineProgressivo());%>">
  				<input type="hidden" name="cliente" value="<% out.print(ordine.getCliente()); %>">
  				<button class="button">
					  <span>Vedi dettagli</span>
					  </svg>
				</button>
  			</form>
  		</div>
  		<%}
  		}%>
      </div>
	<jsp:include page="./footer.jsp" />
</body>
</html>