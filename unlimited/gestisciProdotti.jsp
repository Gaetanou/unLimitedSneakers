<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="model.*" import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./CSS/gestisciProdotti.css">
<link rel="stylesheet" href="./CSS/login.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<title></title>
</head>
<body>
	<% boolean admin = (boolean) request.getSession().getAttribute("admin");
		if(!admin){
			response.sendError(401);
		}
	%>
	<jsp:include page="./header.jsp" />
	
	<div class="container-gestione">
		<div class="container-tabella">
			<table class="table">
			     <thead>
			     	<tr>
			     	 <th>Codice Seriale</th>
			     	 <th>Nome</th>
			     	 <th>Brand</th>
			     	 <th>Opzione</th>
			     	 
			     	</tr>
			     </thead>
			     
			     <% 
					ProdottoDAO dbProdotti = new ProdottoDAO();
					DettaglioProdottoDAO dbDettagli = new DettaglioProdottoDAO();
					List<ProdottoBean> prodottiAll = dbProdotti.doRetrieveAll("order");
					List<DettaglioProdottoBean> dettagliLista = dbDettagli.doRetrieveAll("order");		
				    	Iterator<ProdottoBean> iter = prodottiAll.iterator();
				    	Iterator<DettaglioProdottoBean> iterDettagli = dettagliLista.iterator();
				    	ProdottoBean prodotto = new ProdottoBean();
				    	DettaglioProdottoBean dettagli = new DettaglioProdottoBean();
				    	while(iter.hasNext()){
				    		prodotto = iter.next();
				    		while(iterDettagli.hasNext()){
				    			dettagli = iterDettagli.next();
				    			if(prodotto.getCodiceSeriale().equalsIgnoreCase(dettagli.getProdotto())) break;
				    		}
    				%>
			     <tbody>
			     
			     	 <tr>
			     	  	  <td data-label="Codice Seriale"><% out.println(prodotto.getCodiceSeriale());%></td>
			     	  	  <td data-label="Nome"><% out.println(prodotto.getNome()); %></td>
			     	  	  <td data-label="Marca"><% out.println(prodotto.getBrand()); %></td>
			     	  	  <td data-label="Opzione">
			     	  	  <a href="modificaProdotto?mode=modifica&prodotto=<% out.println(prodotto.getCodiceSeriale());%>">Modifica</a><br><br>
				          <a href="modificaProdotto?mode=elimina&prodotto=<% out.println(prodotto.getCodiceSeriale());%>">Elimina</a></td>
     				</tr>
    	<%}%>
			     </tbody>
   			</table>
		</div>
	</div>


    	<div class="container-tabella">
        <h1>Aggiungi un prodotto</h1>
          <form action="modificaProdotto" method="get" >         
  	<input required type="hidden" name="mode" value="aggiungi">
            
			<div class= "group">
				<input required type="text" class="input" name="codiceSeriale" id="codiceSeriale">
				<p class="error" id="error-codice"></p>
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Codice Seriale</label>
			</div>  
            
			<div class= "group">
				<input required type="text" class="input" name="nome">
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Nome</label>
			</div>
			
			<div class= "group">
				<input required type="text" class="input" name="brand">
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Brand</label>
			</div>   
			
			<div class= "group">
				<input required type="text" class="input" name="descrizioneBreve">
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Descrizione</label>
			</div>
			
			<div class= "group">
				<input required type="text" class="input" name="taglia" id="taglia">
				<p class="error" id="error-taglia"></p>
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Taglia</label>
			</div>     
			
			<div class= "group">
				<input required type="text" class="input" name="quantita"  id="quantita">
				<p class="error" id="error-quantita"></p>
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Quantita</label>
			</div>
			
			<div class= "group">
				<input required type="text" class="input" name="costo" id="costo">
				<p class="error" id="error-costo"></p>
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Costo</label>
			</div>
			
			<input required checked="checked" type="radio" name="categoria" value="uomo" >
  				<label><span class="dot one">Uomo</span></label>
  				
             <input required type="radio" name="categoria" value="donna" >
  				<label><span class="dot one">Donna</span></label> 
          <br><br>
            <input type="submit" class="button" value="Aggiungi">   
          </form>
</div>
<script src="./JS/productValidation.js"></script>
  <jsp:include page="./footer.jsp" />

</body>
</html>
