<%@page import="model.DettaglioProdottoBean"%>
<%@page import="model.ProdottoBean"%>
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
	<% ProdottoBean prodotto = (ProdottoBean) request.getAttribute("prodotto");
		DettaglioProdottoBean dettagli = (DettaglioProdottoBean) request.getAttribute("dettagli");
	%>
	<jsp:include page="./header.jsp" />
	<div class="login">
	<div class="container-login">
  	  <h3>Modifica "<%out.print(prodotto.getCodiceSeriale()); %>"</h3>
	  <form action="modificaProdotto" method="post">
			<input type = "hidden" name = "mode" value = "modifica">
			 <input type ="hidden" name ="prodotto" value="<%out.print(prodotto.getCodiceSeriale());%>">
			<div class= "group">
				<input required type="text" class="input" name="nome" value="<%out.print(prodotto.getNome()); %>">
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Nome</label>
			</div>
			
			<div class= "group">
				<input required type="text" class="input" name="brand" value="<%out.print(prodotto.getBrand()); %>">
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Brand</label>
			</div>   
			
			<div class= "group">
				<input required type="text" class="input" name="descrizioneBreve" value="<%out.print(prodotto.getDescrizioneBreve()); %>">
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Descrizione</label>
			</div>   
          
            <input type="submit" class="button" value="Modifica">
          </form>
          <br>
	  <form action="./listaTaglie.jsp" method="get">
			<input type = "hidden" name = "prodotto" value = "<%out.print(prodotto.getCodiceSeriale());%>">			
				<input type="submit" class="button" value="Taglie">
	  </form>	
	    </div>

</div>
	<jsp:include page="./footer.jsp" />

</body>
</html>