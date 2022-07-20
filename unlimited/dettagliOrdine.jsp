<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="model.*" import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./CSS/dettagliOrdine.css">
<title>Ordine</title>
</head>
<body>
	<jsp:include page="./header.jsp" />
	<% if(request.getAttribute("acquisto") != null){ 
	request.removeAttribute("acquisto"); %>
	<h1 style="text-align: center;">Acquisto effettuato!</h1>
	<% } %>
	<div class="container">
	<% OrdineBean ordine = (OrdineBean) request.getAttribute("ordine");
		List<ComposizioneOrdineBean> composizioneOrdine = (List<ComposizioneOrdineBean>) request.getAttribute("composizione");
		Iterator<ComposizioneOrdineBean> iterComposizione = composizioneOrdine.iterator();
		ProdottoBean prodotto = new ProdottoBean();
		ProdottoDAO dbProdotti = new ProdottoDAO();
		ComposizioneOrdineBean singolaComposizione = new ComposizioneOrdineBean();
		List<DettaglioProdottoBean> listaDettagli = (List<DettaglioProdottoBean>) request.getSession().getAttribute("dettagliProdotti");
		Iterator<DettaglioProdottoBean> iterDettagli = null;
		DettaglioProdottoBean dettaglio = new DettaglioProdottoBean();
		%>
		
		<div class="container-ordine">
		<h1>Ordine #<% out.println(ordine.getNumOrdineProgressivo()); %></h1>
		<h3>Cliente: <% out.println(ordine.getCliente()); %></h3>
		</div>
		<div class="container-tabella">
			<table class="table">
			     <thead>
			     	<tr>
			     	 <th>Prodotto</th>
			     	 <th>Quantita</th>
			     	 <th>Prezzo</th>
			     	 <th>Immagine</th> 
			     	</tr>
			     </thead>
			     	<% while(iterComposizione.hasNext()){
						singolaComposizione = iterComposizione.next();
						iterDettagli = listaDettagli.iterator();
						while(iterDettagli.hasNext()){
							dettaglio = iterDettagli.next();
							if(dettaglio.getProdotto().equals(singolaComposizione.getProdotto())) {
								prodotto = dbProdotti.doRetrieveByKey(dettaglio.getProdotto());
								break;
							}
						}
						
			  			String immagine = prodotto.getNome();
			  			immagine = immagine.replaceAll("\\s", "");
					%>
			     <tbody>
			     	  <tr>
			     	  	  <td data-label="Nome prodotto"><% out.println(prodotto.getNome());%></td>
			     	  	  <td data-label="Quantita"><% out.println(singolaComposizione.getQuantita()); %></td>
			     	  	  <td data-label="Prezzo"><% out.println(singolaComposizione.getCosto()); %> &euro;</td>
			     	  	  <td data-label="Immagine"><img style="width:100px" src=" <% out.println("./img/" + immagine +".png"); %>"></td>  
			     	  </tr> 
			     </tbody>
			     <% } %>
   			</table>
		</div>
		
		<div class="container-info">

		<p>
			<strong>Totale prodotti</strong>: <% out.println(String.format("%.2f",ordine.getCostoTotale())); %> &euro;
		</p>
		
		<p> 
		<% if((ordine.getCostoTotale().doubleValue() - 5) < 45) {%>
			<strong>Spedizione</strong>: 5.00 &euro;
			<% } else { %>
			<strong>Spedizione</strong>: 0.00 &euro;
			<% } %>
		</p>
		<p>
			<strong>Totale</strong>: <% out.println(String.format("%.2f",ordine.getCostoTotale())); %> &euro;
		</p>
			<p>
  				<strong>Spedito verso</strong>: <% out.println(ordine.getVia() + " " + ordine.getCivico() + " ");
  					out.println(ordine.getCitta() + ", " + ordine.getProvincia() + " " + ordine.getCAP());
  					out.println(ordine.getNazione()); %>
  			</p>

			<p>

				 <strong>Num. Carta: </strong>
					<% out.println(ordine.getNumCarta()); %>

			</p>
			</div>
		</div>

	<jsp:include page="./footer.jsp" />
</body>
</html>