<%@page import="model.DettaglioProdottoBean"%>
<%@page import="model.ProdottoBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./CSS/login.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<title></title>
</head>
<body>
<jsp:include page="./header.jsp" />
	<% String taglia = request.getParameter("taglia");
	ProdottoBean prodotto = (ProdottoBean) request.getAttribute("prodotto");
	DettaglioProdottoBean dettagli = (DettaglioProdottoBean) request.getAttribute("dettagli");
		if(!dettagli.getCategoria().equals("null")){	
	%>
	
	<div class="login">
	<div class="container-login">
  	  <h3>Modifica Taglia "<%out.print(taglia); %>"</h3>
	  <form action="modificaTaglia" method="post">
			<input type = "hidden" name = "mode" value = "modifica">
			 <input type ="hidden" name ="prodotto" value="<%out.print(prodotto.getCodiceSeriale());%>">
			 <input type ="hidden" name ="taglia" value="<%out.print(taglia);%>">
			<div class= "group">
				<input required type="text" class="input" name="costo" id="costo" value="<%out.print(dettagli.getCosto()); %>">
				<p class="error" id="error-costo"></p>
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Costo</label>
			</div>
			
			<div class= "group">
				<input required type="text" class="input" name="quantita" id="quantita" value="<%out.print(dettagli.getQuantita()); %>">
				<p class="error" id="error-quantita"></p>
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Quantita</label>
			</div>   
			
			<% if(dettagli.getCategoria().equals("uomo")){%>
			<input required checked="checked" type="radio" name="categoria" value="uomo" >
  				<label><span class="dot one">Uomo</span></label>
  				
             <input required  type="radio" name="categoria" value="donna" >
  				<label><span class="dot one">Donna</span></label> 
          <br><br>
          <% }else{%>
          	<input required checked="checked" type="radio" name="categoria" value="uomo" >
  				<label><span class="dot one">Uomo</span></label>
  				
             <input required checked="checked" type="radio" name="categoria" value="donna" >
  				<label><span class="dot one">Donna</span></label> 
          <br><br>
          <% }%>
            <input type="submit" class="button" value="Modifica">
          </form>

	    </div>

</div>
<%} else{ %>

	<div class="login">
	<div class="container-login">
  	  <h3>Aggiungi  "<%out.print(taglia); %>"</h3>
	  <form action="modificaTaglia" method="get">
			<input type = "hidden" name = "mode" value = "aggiungi">
			 <input type ="hidden" name ="prodotto" value="<%out.print(prodotto.getCodiceSeriale());%>">
			 <input type ="hidden" name ="taglia" value="<%out.print(taglia);%>">
			<div class= "group">
				<input required type="text" class="input" name="costo" id="costo">
				<p class="error" id="error-costo"></p>
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Costo</label>
			</div>
			
			<div class= "group">
				<input required type="text" class="input" name="quantita" id="quantita">
				<p class="error" id="error-quantita"></p>
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Quantita</label>
			</div>   
			
          	<input required checked="checked" type="radio" name="categoria" value="uomo" >
  				<label><span class="dot one">Uomo</span></label>
  				
             <input required type="radio" name="categoria" value="donna" >
  				<label><span class="dot one">Donna</span></label> 
          <br><br>
          
            <input type="submit" class="button" value="Modifica">
          </form>

	    </div>
</div>
<%}%>
<script src="./JS/productValidation.js"></script>	
<jsp:include page="./footer.jsp" />

</body>
</html>