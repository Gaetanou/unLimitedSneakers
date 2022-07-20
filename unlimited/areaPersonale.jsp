<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">
<link rel="stylesheet" href="./CSS/personalArea.css?v=1.1">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<title>Il mio account</title>
</head>
<body>
	<jsp:include page="./header.jsp" />
	
		<% Boolean logged = (Boolean) request.getSession().getAttribute("logged");
		if(logged == null){
			response.sendRedirect("./login.jsp");
		} else {
		
		boolean admin = (boolean) request.getSession().getAttribute("admin");
	%>

	<div class="titolo">
      <h1>Bentornato <% out.println(request.getSession().getAttribute("nome")); %></h1>
      <% if(request.getSession().getAttribute("messaggio") != null) {
    	  String messaggio = (String) request.getSession().getAttribute("messaggio");
    	  request.getSession().removeAttribute("messaggio");%>
    	<p><% out.println(messaggio);%></p>
      <%}%>
    </div>
     <% if (!admin) { %>
     <div class="section">
		
		<div class="grid-card" id="icon-aggiungi">
          <div class="icon">
          	<a class="a" href="modificaInfo?mode=update&target=utente"><span style="color: black" class="material-icons">settings</span></a>
          	</div>
          <div class="card-description">
            <h2>Modifica credenziali</h2>
            <p>Modifica password, nome e cognome.</p>
            
          </div>
        </div>
        
        
        <div class="grid-card">
          <div class="icon">
			<a href="./indirizzi.jsp"><span style="color: black" class="material-icons">house</span></a>
          </div>
          <div class="card-description">
            <h2>I miei indirizzi</h2>
            <p>Controlla e/o modifica i tuoi indirizzi</p>

          </div>
        </div>
		
        <div class="grid-card">
          <div class="icon">
            <a href="./listaOrdini.jsp"><span style="color: black" class="material-icons">local_shipping</span></a>
          </div>
          <div class="card-description">
            <h2>I miei ordini</h2>
            <p>Controlla i tuoi ordini</p>

          </div>
        </div>

        <div class="grid-card">
          <div class="icon">
           <a href="./metodiDiPagamento.jsp"><span style="color: black" class="material-icons">credit_card</span></a>
          </div>
          <div class="card-description">
            <h2>I miei metodi di pagamento</h2>
            <p>Controlla e/o modifica i tuoi metodi di pagamento</p>
            
          </div>
        </div>
    </div>
	<% } else { %>
		 <div class="section">
		 <a href="./listaOrdini.jsp">
        <div class="grid-card">
          <div class="icon">
            <span style="color: black" class="material-icons">local_shipping</span>
          </div>
          <div class="card-description">
            <h2>Gestisci ordini</h2>
            <p>Controlla gli ordini dei clienti</p>
            
          </div>
        </div>
        </a>
        <a href="gestisciProdotti">
	   <div class="grid-card">
          <div class="icon">
           <span style="color: black" class="material-icons">dashboard</span>
          </div>
          <div class="card-description">
          
            <h2>Gestisci prodotti</h2>
            <p>Rimuovi, aggiungi, modifica prodotti del catalogo</p>
          </div>
        </div>
        	</a>
          <a href="modificaInfo?mode=update&target=utente">
        <div class="grid-card">
          <div class="icon">
            <span style="color: black" class="material-icons">settings</span>
          </div>
          <div class="card-description">
            <h2>I miei dati</h2>
            <p>Controlla e/o modifica i dati admin</p>
          </div>   
        </div>
    </a>
    </div>
    <% }
     }%>
    <div class="wrapper">
    <form action="LogOutServlet" method="get">
        <button type="submit" class="button">Logout</button>
    </form>
	</div>
	
		<jsp:include page="./footer.jsp" />
</body>
</html>