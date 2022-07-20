<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="./CSS/login.css">
</head>
<body>
	<jsp:include page="./header.jsp" />
<%String prodotto = request.getParameter("prodotto"); %>

      <div class="container-taglie">
        <h2>Modifica Taglie del prodotto: <%out.print(prodotto); %></h2>

           <form action="modificaTaglia" method="get">
			<input type = "hidden" name = "prodotto" value = "<%out.print(prodotto);%>">
			<input type = "hidden" name = "mode" value = "modifica">

             <input checked="checked" type="radio" name="taglia" value="36" >
  			 <label><span class="dot one">36</span></label>
             <input checked="checked" type="radio" name="taglia" value="37" >
  			 <label><span class="dot one">37</span></label>
  			            
             <input checked="checked" type="radio" name="taglia" value="38" >
  			 <label><span class="dot one">38</span></label>
  
             <input checked="checked" type="radio" name="taglia" value="39" >
             <label><span class="dot one">39</span></label>
<br>
             <input checked="checked" type="radio" name="taglia" value="40" >
  				<label><span class="dot one">40</span></label>
  				
             <input checked="checked" type="radio" name="taglia" value="41" >
  				<label><span class="dot one">41</span></label>
  			 
             <input checked="checked" type="radio" name="taglia" value="42" >
  				<label><span class="dot one">42</span></label>
  				
             <input checked="checked" type="radio" name="taglia" value="43" >
  				<label><span class="dot one">43</span></label>
  				<br>
             <input checked="checked" type="radio" name="taglia" value="44" >
  				<label><span class="dot one">44</span></label>
             <input checked="checked" type="radio" name="taglia" value="45" >
  				<label><span class="dot one">45</span></label>
              <input checked="checked" type="radio" name="taglia" value="46" >
  				<label><span class="dot one">46</span></label>

 	 
         	<br><br><button type="submit" class="button">Modifica</button>
    </form>


  </div>

	<jsp:include page="./footer.jsp" />
</body>
</html>
