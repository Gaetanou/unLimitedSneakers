<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Accedi</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="./CSS/login.css">
</head>
<body>
<jsp:include page="./header.jsp" />
	<% Boolean logged = (Boolean) request.getSession().getAttribute("logged");
		if(logged != null && logged.booleanValue()) {
			String utente = (String) request.getSession().getAttribute("utente");
			String redirect = "login?mode=getInfo";
			response.sendRedirect(redirect);
		}%>
  <div class="login">
      <div class="container-login">
        <h1>Bello rivederti!</h1>
          <form action="login" method="post" id="login">         
           <input type="hidden" name="mode" value="login">

            
			<div class= "group">
				<input required type="text" class="input" name="username">
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Username</label>
			</div>  
            
            <div class= "group">
				<input required type="password" class="input" name="password" id="password">
				  <span class="highlight"></span>
				  <span class="bar"></span>
				  <label class="label-registrazione">Password</label>
			</div> 
          
            <button type="submit" class="button">Login</button>
          </form>

          <br>
          <br>
          
          <div >
            <a href="registration.jsp">Non hai un account? Registrati</a>
          <a id="home" href="homepage.jsp"><span class="material-icons" style="color:black; font-size:24px;">house</span></a>
      </div>
  	<% String error = (String) request.getSession().getAttribute("error");
  		String result = (String) request.getSession().getAttribute("result");
  		if(error != null) {%>
  		<p class="error"><%out.println(error);%></p>
  		<% request.getSession().removeAttribute("error"); }
  		if(result != null) {%>
  		<p><% out.println(result); %></p>
  		<% request.getSession().removeAttribute("result"); }%>
  </div>
</div>
<jsp:include page="./footer.jsp" />
</body>
</html>
