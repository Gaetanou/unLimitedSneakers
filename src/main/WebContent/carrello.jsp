<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*" import="java.math.BigDecimal" import="model.*"
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./CSS/carrello.css">

<title></title>
</head>
<body>
	<jsp:include page="./header.jsp" />
	
	<div class="cart-container">
		<%Map <String, Map<String,Integer>> carrello = (Map <String, Map<String,Integer>>) request.getSession().getAttribute("carrello");
		if(carrello == null){%>
			<div class="carrello-vuoto">
				<p>Carrello vuoto!</p>
			</div>
			<div class="centra_ancora">
				<a href="catalogo?filter=catalogo">Continua lo shopping</a>
			</div>
			
			<%}else{ 
			Iterator <String> iterKeysProdotto = carrello.keySet().iterator();
			Iterator <String> iterKeysTaglie;
			ProdottoDAO dbProdotti = new ProdottoDAO();
			DettaglioProdottoDAO dbDettagli = new DettaglioProdottoDAO();
			List<ProdottoBean> prodotti = dbProdotti.doRetrieveAll("order");
			List<DettaglioProdottoBean> dettagliProdotti = dbDettagli.doRetrieveAll("order");		
			Integer quantita = 0;
			ProdottoBean prodotto = new ProdottoBean();
			DettaglioProdottoBean dettagli = new DettaglioProdottoBean();
			Iterator<ProdottoBean> iterProdotti;
			Iterator<DettaglioProdottoBean> iterDettagli;
			String key;
			String taglia;
			Iterator<Map<String, Integer>> iterKeysDettagli;
			Map <String,Integer> coppia = new HashMap<>();
			Iterator<Map.Entry<String, Integer>> itr;
			Integer totaleP = 0;
			Integer totale = 0;
			Integer costo=0;
			Integer spedizione=0;
			while(iterKeysProdotto.hasNext()){
				key = iterKeysProdotto.next();
				
				iterProdotti = prodotti.iterator();
				while(iterProdotti.hasNext()){
					prodotto = iterProdotti.next();
					if(prodotto.getCodiceSeriale().equals(key)) {
				
				iterKeysTaglie = carrello.get(key).keySet().iterator();
				while(iterKeysTaglie.hasNext()){
					taglia = iterKeysTaglie.next();
					
				iterDettagli = dettagliProdotti.iterator();
				while(iterDettagli.hasNext()){
					dettagli = iterDettagli.next();
					if(dettagli.getTaglia().equals(taglia) && dettagli.getProdotto().equals(prodotto.getCodiceSeriale())){
						quantita = carrello.get(key).get(taglia);

				String immagine = prodotto.getNome();
				immagine = immagine.replaceAll("\\s+", "");
				
				%>
				  
				     <div class="cart-container-interno">
				        	<div class="info-prodotto"> 
				        	<a href="select?type=prodotto&prodotto=<%out.println(prodotto.getCodiceSeriale());%>"> 	
				        	<img src="img/<%out.print(immagine);%>.png" alt="ciao"></a>
				        	</div>
				        
				        <div class="info-prodotto">
				        <p><% out.print(prodotto.getNome()); %></p>
				        </div>
				          <p> <% out.print(dettagli.getTaglia()); %></p>

				          <p> <% out.print(dettagli.getCosto()); %>&euro;</p>

							
							<input type="hidden" id="costoUnitarioTot" value="">
							<input type="button" value="-"  onclick = window.location.href="carrello?mode=updateminus&taglia=<%out.print(dettagli.getTaglia());%>&prodotto=<%out.print(prodotto.getCodiceSeriale());%>&quantita=<%out.print(quantita);%>&quantitaMax=<%out.print(dettagli.getQuantita());%>">
							<input type="number" placeholder="quantita" name="quantita" value="<% out.print(quantita); %>" readonly>
							<input type="button" value="+"  onclick = window.location.href="carrello?mode=updateplus&taglia=<%out.print(dettagli.getTaglia());%>&prodotto=<%out.print(prodotto.getCodiceSeriale());%>&quantita=<%out.print(quantita);%>&quantitaMax=<%out.print(dettagli.getQuantita());%>">
							
						<form action="carrello" method="get">
							<input type="hidden" name="prodotto" value="<%out.print(prodotto.getCodiceSeriale());%>">
							<input type="hidden" name="mode" value="remove">
							<input type="hidden" name="taglia" value="<%out.print(dettagli.getTaglia());%>">
							<button class="rimuovibutton">Rimuovi</button>
						</form>
				    </div>
				</div>
			<%
			costo = dettagli.getCosto().intValue();
			totaleP += costo * quantita;
					}
				}
			}}}}
			if(totaleP<50) spedizione=5;
			totale = totaleP+spedizione;%>
			
			<div class="riepilogo">
      <div class="totale_parziale">
        <div class="prova">

        </div>
        <div class="card">
          <h2 class="h2_style">Totale parziale:</h2>
        </div>
        <div class="card2">
          <p class="p_style"  id="netto"><%out.print(totaleP);%></p>
        </div>

      </div>

      <div class="totale_parziale">
        <div class="prova">

        </div>
        <div class="card">
            <h2 class="h2_style">Spedizione:</h2>
        </div>
        <div class="card2">
            <p class="p_style" id="spedizione"> <%out.print(spedizione);%></p>
        </div>

      </div>
      <div class="totale_parziale">
        <div class="prova">

        </div>
        <div class="card">
              <h2 class="h2_style">Totale:</h2>
        </div>
        <div class="card2">
          <p class="p_style" id="prezzoTot"><%out.print(totale);%></p>
        </div>
      </div>
      <div class="totale_parziale">
        <div class="prova">

        </div>
        <div class="card">
             
        </div>
        <div class="card2">
          <div id="procedi" > 
          <form action="ordine" method="get"> 
					<button class="procedibutton">Procedi</button> 
					<input type="hidden" name="costoTot" value="<%out.print(totale);%>">
				</form>
			</div> 
        </div>
      </div>
      <div class="totale_parziale" id="margine">
        <div class="prova">
        </div>
        <div class="card">  
        </div>
        <div class="card2">
         <div id="pulisci"> 
			<form action="carrello" method="get"> 
					<input type="hidden" name="mode" value="reset"> 
 					<button  type="submit">Svuota Carrello</button> 
 				</form> 
				</div> 
        </div>
      </div>
      <%} %>
    </div>
		<jsp:include page="./footer.jsp" />

</body>
</html>