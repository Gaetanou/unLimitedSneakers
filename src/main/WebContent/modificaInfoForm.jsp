<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="model.*" import="java.util.Base64.Decoder" import="java.util.Base64"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./CSS/login.css">
<title> </title>
</head>
<body>
	<jsp:include page="./header.jsp" />
	<% Boolean logged = (Boolean) request.getSession().getAttribute("logged");
	
	if(logged == null){
		response.sendRedirect("./login.jsp");
	} else {
	
	String target = (String) request.getAttribute("target"); 
		String error = (String) request.getSession().getAttribute("error");
		if (target.equals("utente")) {
			UtenteBean utente = (UtenteBean) request.getAttribute("utente");
			Decoder decoder = Base64.getDecoder();	
			String decodedPwd = new String(decoder.decode(utente.getPassword()));
		%>
<!-- 		NUOVO FORM DELLE INFO -->


	<div class="login">
      <div class="container-login">
        <h1>COMPILA I CAMPI CHE VUOI MODIFICARE</h1>
         <form action="modificaInfo" method="post">  
        	<input type="hidden" name="utente" value="<% out.print(utente.getUsername());%>">
			<input type="hidden" name="target" value="utente">
			<input type="hidden" name="mode" value="update">
        
			<input required type="hidden" id="username" name="username" value="<%out.print(utente.getUsername());%>">
	        <span class="errors" id="error-username"></span>
	        
	        
            <div class= "group">
				<input required type="password" class="input" name="password" id="password" value="<%out.print(decodedPwd);%>">
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <span class="errors" id="error-pwd"></span>
				  <label class="label-registrazione">Password</label>
			</div>    
			
            <div class= "group">
				<input required type="password" class="input" name="passwordCheck" id="passwordCheck" value="<%out.print(decodedPwd);%>">
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <span class="errors" id="error-pwd"></span>
				  <label class="label-registrazione">Ripeti Password</label>
			</div>    
			
            <div class= "group">
				<input required type="text" class="input" name="nome" id="nome" value="<%out.print(utente.getNome());%>">
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Nome</label>
			</div>  
			
            <div class= "group">
				<input required type="text" class="input" name="cognome" id="cognome"  value="<%out.print(utente.getCognome());%>">
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Cognome</label>
			</div>  	
			
	      	<input class="button" type="submit" value="Modifica dati">
	    
	    </form>


	    <% if(error != null) { %>
			<p> <% out.println(error); %> </p>
			<% request.getSession().removeAttribute("error");}%>
	   </div>
		<% } else if (target.equals("indirizzo")) {
			IndirizzoBean indirizzo = (IndirizzoBean) request.getAttribute("indirizzo");%>	
		</div>	
			
	<div class="login">
      <div class="container-login">
        <h1>MODIFICA INDIRIZZO</h1>
         <form action="modificaInfo" method="post">  
			<input type="hidden" name="indirizzoID" value="<%out.print(indirizzo.getNumIndirizzoProgressivo());%>">
			<input type="hidden" name="utente" value="<%out.print(indirizzo.getUtente());%>">
			<input type="hidden" name="target" value="indirizzo">
			<input type="hidden" name="mode" value="update">
	        
	        
            <div class= "group">
				<input required type="text" class="input" name="via" id="via" value="<%out.print(indirizzo.getVia());%>">
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Via</label>
			</div>    
			
            <div class= "group">
				<input required type="text" class="input" name="citta" id="citta" value="<%out.print(indirizzo.getCitta());%>">
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Città</label>
			</div>
			
			<div class= "group">
				<input required type="text" class="input" name="CAP" id="CAP" value="<%out.print(indirizzo.getCAP());%>">
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">CAP</label>
			</div>
			
			<div class= "group">
				<input required type="text" class="input" name="civico" id="civico" value="<%out.print(indirizzo.getCivico());%>">
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Civico</label>
			</div>

			<div class= "group">
				<input required type="text" class="input" name="provincia" id="provincia" value="<%out.print(indirizzo.getProvincia());%>">
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Provincia</label>
			</div>

			<div class= "group">
				<input required type="text" class="input" name="nazione" id="nazione" value="<%out.print(indirizzo.getNazione());%>">
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Nazione</label>
			</div> 
			
			<div class= "group">
				<input type="text" class="input" name="scala" id="scala" value="<%out.print(indirizzo.getScala());%>">
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Scala</label>
			</div>  

			<div class= "group">
				<input type="text" class="input" name="interno" id="interno" value="<%out.print(indirizzo.getInterno());%>">
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Interno</label>
			</div>
			
			<div class= "group">
	 		<span class="bar"></span>
				        <label>Preferito</label>
				        <select required id="preferito" name="preferito">
				         <% if (indirizzo.getPreferito().equalsIgnoreCase("si")) {%>
			 						<option value="si" selected>Si</option>
			 						<option value="no">No</option>
			 			<%} else {%>
			 						<option value="si">Si</option>
			 						<option value="no" selected>No</option>
			 			<% } %>
				        </select>
			</div>          
			 	
			
	      	<input class="button" type="submit" value="MODIFICA">
	    
	    </form>


	    <% if(error != null) { %>
			<p> <% out.println(error); %> </p>
			<% request.getSession().removeAttribute("error");}%>
	   </div>
	   </div>
		<% } else if (target.equals("metodoPagamento")) {
				MetodoDiPagamentoBean metodoPagamento = (MetodoDiPagamentoBean) request.getAttribute("metodoPagamento");%>
				
	<div class="login">
      <div class="container-login">
        <h1>MODIFICA METODO DI PAGAMENTO</h1>
        <form action="modificaInfo" method="post">
			<input type="hidden" name="metodoPagamentoID" value="<%out.print(metodoPagamento.getNumPagamentoProgressivo());%>">
			<input type="hidden" name="utente" value="<%out.print(metodoPagamento.getUtente());%>">
			<input type="hidden" name="target" value="metodoPagamento">
			<input type="hidden" name="mode" value="update">
        
	        
            <div class= "group">
				<input required type="text" class="input" name="nome" id="nome" value="<%out.print(metodoPagamento.getNome());%>">
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Nome</label>
			</div>
			
            <div class= "group">
				<input required type="text" class="input" name="cognome" id="cognome" value="<%out.print(metodoPagamento.getCognome());%>">
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Cognome</label>
			</div>  
				        
            <div class= "group">
				<input required type="text" class="input" name="numCarta" id="numCarta" value="<%out.print(metodoPagamento.getNumCarta());%>">
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Numero Carta</label>
			</div>    
			
            <div class= "group">
				<input required type="text" class="input" name="dataScadenza" id="dataScadenza" value="<%out.print(metodoPagamento.getDataScadenza());%>">
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Data di Scadenza</label>
			</div>
			
            <div class= "group">
				<input required type="password" class="input" name="cvv" id="cvv" value="<%out.print(metodoPagamento.getCvv());%>">
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">CVV</label>
			</div>
			
			<div class= "group">
	 		<span class="bar"></span>
				        <label>Preferito</label>
				        <select required id="preferito" name="preferito">
				         <% if (metodoPagamento.getPreferito().equalsIgnoreCase("si")) {%>
			 						<option value="si" selected>Si</option>
			 						<option value="no">No</option>
			 			<%} else {%>
			 						<option value="si">Si</option>
			 						<option value="no" selected>No</option>
			 			<% } %>
				        </select>
			</div>
			
	      	<input class="button" type="submit" value="MODIFICA">
	    
	    </form>
				
	    <% if(error != null) { %>
			<p> <% out.println(error); %> </p>
			<%request.getSession().removeAttribute("error");} }}%>
		
	   </div>
	</div> 	
	<jsp:include page="./footer.jsp" />	
</body>
</html>