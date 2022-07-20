<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./CSS/login.css">
<title></title>
</head>
<body>
	<jsp:include page="./header.jsp" />
	
	<% String target = (String) request.getAttribute("target"); 
		String utente = (String) request.getAttribute("utente");
		String error = (String) request.getSession().getAttribute("error");
		
		if(error != null){%> 
			<p><%out.println(error); %>
		<% request.getSession().removeAttribute("error");
		}
		if (target.equals("indirizzo")) {%>
		
<!-- 		INIZIO DEL NUOVO FORM -->
		<div class="login">
				<div class="container-login">
  	  				<h3>AGGIUNGI NUOVO INDIRIZZO</h3>
				  	   <form action="modificaInfo" method="post">
							<input type="hidden" name="utente" value="<%out.print(utente);%>">
							<input type="hidden" name="target" value="indirizzo">
							<input type="hidden" name="mode" value="add">
			<div class= "group">
			<input required type="text" class="input" name="via" id="via">
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Via</label>
			</div>    
			
            <div class= "group">
				<input required type="text" class="input" name="citta" id="citta">
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Città</label>
			</div>
			
			<div class= "group">
				<input required type="text" class="input" name="CAP" id="CAP">
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">CAP</label>
			</div>
			
			<div class= "group">
				<input required type="text" class="input" name="civico" id="civico">
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Civico</label>
			</div>

			<div class= "group">
				<input required type="text" class="input" name="provincia" id="provincia">
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Provincia</label>
			</div>

			<div class= "group">
				<input required type="text" class="input" name="nazione" id="nazione">
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Nazione</label>
			</div> 
			
			<div class= "group">
				<input type="text" class="input" name="scala" id="scala" >
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Scala</label>
			</div>  

			<div class= "group">
				<input type="text" class="input" name="interno" id="interno" >
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Interno</label>
			</div>
				   		   
			<div class= "group">
	 		<span class="bar"></span>
				        <label>Preferito</label>
				        <select required id="preferito" name="preferito">
			 						<option value="si" selected>Si</option>
			 						<option value="no">No</option>
				        </select>
			</div>
			
	      	<input class="button" type="submit" value="AGGIUNGI">
			</form>
	   </div>
 	</div>
<!-- FINE  -->
		
		<% } else if (target.equals("metodoPagamento")) {%>
		
		<!-- 		INIZIO DEL NUOVO FORM PAGAMENTO -->
		<div class="login">
			<div class="container-login">
  	  		<h3>AGGIUNGI NUOVO METODO DI PAGAMENTO</h3>
	  	   <form action="modificaInfo" method="post">
				<input type="hidden" name="utente" value="<%out.print(utente);%>">
				<input type="hidden" name="target" value="metodoPagamento">
				<input type="hidden" name="mode" value="add">
            <div class= "group">
				<input required type="text" class="input" name="nome" id="nome">
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Nome</label>
			</div>
			
            <div class= "group">
				<input required type="text" class="input" name="cognome" id="cognome">
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Cognome</label>
			</div>  
				        
            <div class= "group">
				<input required type="text" class="input" name="numCarta" id="numCarta" >
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Numero Carta</label>
			</div>    
			
            <div class= "group">
				<input required type="text" class="input" name="dataScadenza" id="dataScadenza">
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Data di Scadenza</label>
			</div>
			
            <div class= "group">
				<input required type="password" class="input" name="cvv" id="cvv">
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">CVV</label>
			</div>
			
			<div class= "group">
	 		<span class="bar"></span>
				        <label>Preferito</label>
				        <select required id="preferito" name="preferito">
			 						<option value="si" selected>Si</option>
			 						<option value="no">No</option>
				        </select>
			</div>
			
	      	<input class="button" type="submit" value="AGGIUNGI">
	     </form>
	   		 
	   </div>
	</div>
				<%}%>

	<jsp:include page="./footer.jsp" />	
</body>
</html>