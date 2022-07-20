<%@page import="model.*" import="java.lang.*" import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="./CSS/prodotto.css">
</head>
<body>
	<% 
		ProdottoBean prodotto = (ProdottoBean) request.getAttribute("prodotto");
		List<DettaglioProdottoBean> taglieDisponibili = (List<DettaglioProdottoBean>) request.getSession().getAttribute("taglieTrovate");
		DettaglioProdottoBean dettagli = (DettaglioProdottoBean) request.getAttribute("dettagliProdotto");
		Iterator<DettaglioProdottoBean> iterDettagli = taglieDisponibili.iterator();
		DettaglioProdottoBean taglie = new DettaglioProdottoBean();
		String immagine = prodotto.getNome();
		immagine = immagine.replaceAll("\\s+", "");
	%>
	<jsp:include page="./header.jsp" />
    <div class="grid-display">
      <div class="immagine_prodotto">
        <img src="<%out.println("./img/" + immagine +".png");%>" alt="">
      </div>
      <div class="informazioni_prodotto">
            <div class="nome_prodotto">
              <h1><% out.println(prodotto.getNome()); %></h1>
            </div>
            <div class="descrizione_prodotto">
              <p><%out.println(prodotto.getDescrizioneBreve());%></p>
            </div>
            <div class="prezzo_prodotto">
              <p><%out.println(dettagli.getCosto());%> &euro;</p>
            </div>
            <div class="info_pagamento">
              <ul>
                <li> <i style="color:black" class="material-icons">credit_card</i>&nbsp;&nbsp;Pagamenti con carta di credito</li>
                <li> <i style="color:black" class="material-icons">local_shipping</i>&nbsp;&nbsp;Consegna gratis sopra i 50&euro;</li>
                <li> <i style="color:black" class="material-icons">lock</i>&nbsp;&nbsp;Pagamenti sicuri e criptati</li>
              </ul>
            </div>
            
             <form action="carrello" method="get" > 
            <div class="gender__details">
  			<input type="hidden" name="mode" value="add">
  			<input type="hidden" name="prodotto" value=<%out.println(prodotto.getCodiceSeriale());%>>
            <%  
            
            if(request.getParameter("stato") == null){
            
            
            while(iterDettagli.hasNext()){
  				dettagli = iterDettagli.next();
  			%>
  				<input checked="checked" type="radio" name="taglia" id="dot<%out.println(dettagli.getTaglia());%>" value="<%out.println(dettagli.getTaglia());%>" required>
  				<label for="dot<%out.println(dettagli.getTaglia());%>">
		          <span class="dot one"><%out.println(dettagli.getTaglia());%></span>
		        </label>
  			<%
  			} }
  			%>

		    </div>
    <%  
            
    if(request.getParameter("stato") == null) { %>
            <div class="acquistare">
                <button class="addtocart" id="added<% out.print(prodotto.getCodiceSeriale()); %>">
                    <div class="pretext">
                       AGGIUNGI
                    </div>
                </button>
            </div>
 		</form>

<%}%>
</div>
</div>
	<jsp:include page="./footer.jsp"  />
</body>
</html>
