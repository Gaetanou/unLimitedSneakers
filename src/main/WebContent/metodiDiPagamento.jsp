<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8" import="model.*" import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
	<link rel="stylesheet" href="./CSS/indirizzi.css">
	<title>I miei metodi di pagamento</title>
</head>
<body>
	<jsp:include page="./header.jsp" />
	 <div class="sezione">
      <div class="aggiungi">
      	<form action="modificaInfo" method="get">
  				<input type="hidden" value="<% out.print(request.getSession().getAttribute("utente"));%>" name="utente">
  				<input type="hidden" name="mode" value="add">
  				<input type="hidden" name="target" value="metodoPagamento">
  				<button class="button">
					  <span id="aggiungi" >Aggiungi</span>
				</button>
  			</form>
      </div>
      <% List<MetodoDiPagamentoBean> metodiPagamento = (List<MetodoDiPagamentoBean>) request.getSession().getAttribute("metodiPagamento"); 
  		Iterator<MetodoDiPagamentoBean> iterMetodi = metodiPagamento.iterator();
  		int i = 0;
  		MetodoDiPagamentoBean metodoPagamento = new MetodoDiPagamentoBean(); %>
  		
  		<% while(iterMetodi.hasNext()){
  			metodoPagamento = iterMetodi.next();
  			i += 1;%>
  			<div class="carte">
  			<% if(metodoPagamento.getPreferito().equalsIgnoreCase("si")) { %>
  						<h3>Metodo di pagamento predefinito</h3>
  					<%} else{%>
      		<h3>Metodo di pagamento <%out.print(i);%></h3>
  		<% }%>
		
  			<p>
  				<% 
  					out.println("Titolare: " + metodoPagamento.getNome() + " " + metodoPagamento.getCognome());
  				 %>
  			</p>
  			
  			<p>
  				<% out.println("Numero Carta: " + metodoPagamento.getNumCarta() + " ");%>
  			</p>
  			
  			<p>
  				<% out.println("Data di Scadenza: " + metodoPagamento.getDataScadenza() + " ");%>
  			</p>
  			
  			<p>
  				<% out.println("CVV: " + metodoPagamento.getCvv() + " ");%>
  			</p>


  			<form action="modificaInfo" method="get">
  				<input type="hidden" value="<% out.print(request.getSession().getAttribute("utente"));%>" name="utente">
  				<input type="hidden" value="<% out.print(metodoPagamento.getNumPagamentoProgressivo());%>" name="metodoPagamentoID">
				<input type="hidden" name="mode" value="update">
				<input type="hidden" name="target" value="metodoPagamento">
				<button class="button" type="submit">Modifica</button>
  			</form>
  			<br>
  			<form action="modificaInfo" method="post">
  				<input type="hidden" value="<% out.print(request.getSession().getAttribute("utente"));%>" name="utente">
  				<input type="hidden" value="<% out.print(metodoPagamento.getNumPagamentoProgressivo());%>" name="metodoPagamentoID">
				<input type="hidden" name="mode" value="delete">
				<input type="hidden" name="target" value="metodoPagamento">
				<button class="button" type="submit">Elimina</button>
  			</form>
  			</div>

 <%}%>
      </div>
<jsp:include page="./footer.jsp" />	
</body>
</html>