<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8" import="model.*" import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
	<link rel="stylesheet" href="./CSS/catalogo.css">
	<title></title>
</head>
<body>
	<jsp:include page="./header.jsp" />
	  <div class="section">
	<% 
  	Boolean admin = (boolean) request.getSession().getAttribute("admin");
  		List<ProdottoBean> prodotti = (List<ProdottoBean>) request.getSession().getAttribute("prodotti");
  		List<DettaglioProdottoBean> dettagliProdotti = (List<DettaglioProdottoBean>) request.getSession().getAttribute("dettagliProdotti");
  		Iterator<ProdottoBean> iterProdotto = prodotti.iterator();
  		Iterator<DettaglioProdottoBean> iterDettagli;
  		ProdottoBean prodotto = new ProdottoBean();
  		DettaglioProdottoBean dettagli = new DettaglioProdottoBean(); 
		
  		 while(iterProdotto.hasNext()){
  			prodotto = iterProdotto.next();
  			iterDettagli = dettagliProdotti.iterator();
  			while(iterDettagli.hasNext()){
  				dettagli = iterDettagli.next();
  				if(prodotto.getCodiceSeriale().equals(dettagli.getProdotto())) break;
  			}
  			String immagine = prodotto.getNome();
  			immagine = immagine.replaceAll("\\s", "");

  			%>
        <div class="grid-card">
          		<div class="img">
          		<a href="./select?type=prodotto&prodotto=<%out.println(prodotto.getCodiceSeriale());%>">
            		<img src="<% out.println("./img/" + immagine +".png"); %>">
            	</a>
	          	</div>
	          <div class="nome_prodotto">
	            <h2><% out.println(prodotto.getNome()); %></h2>
		          </div>
		          <div class="prezzo">
		          <p class="price"><% out.println(dettagli.getCosto().toPlainString()); %>&euro;</p>
	          </div>
          <div class="acquista">
          <a href="./select?type=prodotto&prodotto=<%out.println(prodotto.getCodiceSeriale());%>">
          	<button class="addtocart" id="added<% out.print(prodotto.getCodiceSeriale()); %>">
				  <div class="pretext">
				     Disponibile
				  </div>		  
			</button>
			</a>
          </div> 

        </div>
        <% } 
        
        List<ProdottoBean> prodottiTerminati = (List<ProdottoBean>) request.getSession().getAttribute("prodottiTerminati");
        if(!prodottiTerminati.isEmpty()){
        iterProdotto = prodottiTerminati.iterator();
		iterDettagli = dettagliProdotti.iterator();
        while(iterProdotto.hasNext()){
        	prodotto = iterProdotto.next();

  			while(iterDettagli.hasNext()){
  				dettagli = iterDettagli.next();
  				if(prodotto.getCodiceSeriale().equals(dettagli.getProdotto())) break;
  			}
  			String immagine = prodotto.getNome();
  			immagine = immagine.replaceAll("\\s+", "");

  		%>
        <div class="grid-card-terminato">
       		<div class="img">

         		<img src="<% out.println("./img/" + immagine +".png"); %>">
    
          	</div>
          <div class="nome_prodotto">
            <h2><% out.println(prodotto.getNome()); %></h2>
          </div>
          <div class="prezzo">
          <p class="priceterminato"><% out.println(dettagli.getCosto().toPlainString()); %>&euro;</p>
          </div>
          <div class="acquista">
             <a href="./select?type=prodotto&prodotto=<%out.println(prodotto.getCodiceSeriale());%>&stato=terminato">
          	<button class="addtocart" id="added<% out.print(prodotto.getCodiceSeriale()); %>">
				  <div class="pretext-terminato">
				     Terminato
				  </div>		  
			</button>
			</a>
          </div>

        </div>
        <%}
        }%>
      </div>

	<jsp:include page="./footer.jsp" />

</body>
</html>