<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*" import="model.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./CSS/carrello.css">
<title></title>
</head>
<body>
	<jsp:include page="./header.jsp" />
	<% 
		Boolean admin = (Boolean) request.getSession().getAttribute("admin");
	
	if(request.getSession().getAttribute("carrello") == null) {
		response.sendRedirect("index.jsp");
	}
	if(admin){
		request.getSession().setAttribute("messaggio", "L'admin non può acquistare. Utilizza un account pubblico!");
		response.sendRedirect("./areaPersonale.jsp");
	} else {
	List<MetodoDiPagamentoBean> listaMetodi = (List<MetodoDiPagamentoBean>) request.getSession().getAttribute("metodiPagamento");
		List<IndirizzoBean> listaIndirizzi = (List<IndirizzoBean>) request.getSession().getAttribute("indirizzi");
		
		if(listaMetodi.isEmpty() || listaIndirizzi.isEmpty()){
			request.getSession().setAttribute("messaggio", "Devi aggiungere un indirizzo/metodo di pagamento prima di continuare con l'acquisto");
			response.sendRedirect("./areaPersonale.jsp");
		}
		Iterator<MetodoDiPagamentoBean> iterMetodiPagamento = listaMetodi.iterator();
		Iterator<IndirizzoBean> iterIndirizzi = listaIndirizzi.iterator(); 
		IndirizzoBean indirizzo = new IndirizzoBean();
		MetodoDiPagamentoBean metodPagamento = new MetodoDiPagamentoBean();%>
		<form action="ordine" method="post">
		<div class="container">
		
			<div class="cart-container-interno">
			<h4>Scegli indirizzo di spedizione</h4><br>
		<%	while(iterIndirizzi.hasNext()){
			indirizzo = iterIndirizzi.next();
			if(indirizzo.getPreferito().equals("si")){ %>
				<input type="radio" name="indirizzo" id="indirizzo" value="<%out.print(indirizzo.getNumIndirizzoProgressivo());%>" checked>
				<label for="indirizzo"><% out.println(indirizzo.getVia() + " " + indirizzo.getCivico() + " " 
					+ indirizzo.getCitta() + " " + indirizzo.getCAP() + " " + indirizzo.getProvincia() + " " + indirizzo.getNazione());
					if(indirizzo.getScala() != null){
						out.print(indirizzo.getScala() + " ");
					}
					if(indirizzo.getInterno() != null){
						out.print(indirizzo.getInterno());
					}
					%></label><br>
			<%} else { %>
				<input type="radio" name="indirizzo" id="indirizzo" value="<%out.print(indirizzo.getNumIndirizzoProgressivo());%>">
				<label for="indirizzo"><% out.println(indirizzo.getVia() + " " + indirizzo.getCivico() + " " 
						+ indirizzo.getCitta() + " " + indirizzo.getCAP() + " " + indirizzo.getProvincia() + " " + indirizzo.getNazione());
						if(indirizzo.getScala() != null){
							out.print(indirizzo.getScala() + " ");
						}
						if(indirizzo.getInterno() != null){
							out.print(indirizzo.getInterno());
						}
						%>
			<% } %>
		<%}%>
		<a href="modificaInfo?mode=add&target=indirizzo">Aggiungi indirizzo</a>
		</div>
		
		
		<div class="cart-container-interno">
		<h4>Scegli un metodo di pagamento</h4>
		<% while(iterMetodiPagamento.hasNext()){
			metodPagamento = iterMetodiPagamento.next();
			if(metodPagamento.getPreferito().equals("si")){%>
				<input type="radio" name="metodoPagamento" id="pagamento" value="<%out.print(metodPagamento.getNumPagamentoProgressivo());%>" checked>
			<%	out.println(metodPagamento.getNumCarta());%>
	
		<% } else { %>
			<input type="radio" name="metodoPagamento" id="pagamento" value="<%out.print(metodPagamento.getNumPagamentoProgressivo());%>">
			<%	out.println(metodPagamento.getNumCarta());
			}
			%>

		<% }
		} %>
		
		<a href="modificaInfo?mode=add&target=metodoPagamento">Aggiungi metodo di pagamento</a>
		</div>
		
		<%
		Map <String, Map<String,Integer>> carrello = (Map <String, Map<String,Integer>>) request.getSession().getAttribute("carrello");
		Iterator <String> iterKeysProdotto = carrello.keySet().iterator();
		Iterator <String> iterKeysTaglie;
		List<ProdottoBean> prodotti = (List<ProdottoBean>) request.getSession().getAttribute("prodotti");
		List<DettaglioProdottoBean> dettagliProdotti = (List<DettaglioProdottoBean>) request.getSession().getAttribute("dettagliProdotti");			
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

			System.out.println(prodotto.getCodiceSeriale());
			
			iterKeysTaglie = carrello.get(key).keySet().iterator();
			while(iterKeysTaglie.hasNext()){
				taglia = iterKeysTaglie.next();
				
			iterDettagli = dettagliProdotti.iterator();
			while(iterDettagli.hasNext()){
				dettagli = iterDettagli.next();
				if(dettagli.getTaglia().equals(taglia) && dettagli.getProdotto().equals(prodotto.getCodiceSeriale())){
					quantita = carrello.get(key).get(taglia);
					System.out.println(taglia);
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
							<p> Quantita: <% out.print(quantita); %></p>
 				        </div>
 				       <%
 						costo = dettagli.getCosto().intValue();
 						totaleP += costo * quantita;

				}}
		}}}}
					if(totaleP<50) spedizione=5;
					totale = totaleP+spedizione;%>
			</div>
			<div class="riepilogo">
			      <div class="totale_parziale">
			        <div class="prova">
			
			        </div>
			        <div class="card">
			          <h2 class="h2_style">Totale parziale: </h2>
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
								<button type="submit" class="procedibutton">Acquista</button> 
						</div> 
			        </div>
			      </div>
     
    		</div>
		</form>
	<jsp:include page="./footer.jsp" />
</body>
</html>