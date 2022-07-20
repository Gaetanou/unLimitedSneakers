<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registrazione</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="./CSS/login.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<jsp:include page="./header.jsp" />
  <div class="login">
      <div class="container-login">
        <h1>Sono un nuovo cliente</h1>
          <form action="login" method="post" id="login">
            <input type="hidden" name="mode" value="register">         

			<div class= "group">
				<input required type="text" class="input" name="username"  id="username">
				<p class="error" id="error-username"></p>
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Username</label> 
			</div>
			
			<div class= "group">
				<input required type="text" class="input" name="email" id="email">
				<p class="errors" id="error-email"></p>
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Email</label>
			</div> 
            
            <div class= "group">
				<input required type="password" class="input" name="password" id="password">
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Password</label>
			</div> 
			
			<div class= "group">
				<input required type="password" class="input" name="passwordCheck" id="passwordCheck">
				 <p class="error" id="error-pwd"></p>
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Conferma Password</label>
			</div> 
			
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
          
            <button type="submit" class="button">Registrati</button>
          </form>

          <br>
          <br>
          
          <div >
            <a href="login.jsp">Hai un account? Accedi</a>
          <a id="home" href="homepage.jsp"><i class="material-icons" style="color:black; font-size:24px">house</i></a>
      </div>
  </div>
</div>
	<jsp:include page="./footer.jsp" />
<script src="./JS/registerValidation.js"></script>
</body>
</html>
