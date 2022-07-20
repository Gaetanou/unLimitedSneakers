<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./CSS/homepage.css?v=1.1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<title>unLIMITED Sneakers</title>
</head>
<body>
<jsp:include page="./header.jsp" />
<div class="underHeader">
	<section id="left">
		<h1>AIR JORDAN x DIOR</h1>
		<br>
		<h4>LUXURY LIMITED EDITION</h4>
		<br>
	
		<button onclick="window.location.href='select?type=prodotto&prodotto=N0001'" class="scopributton">SCOPRI</button>
	</section>
	<section class="right" id="right">
		<img class="target" id="jordanxdior" src="img/airdior.png" alt="jordanxdior underheader image">
	</section>
</div>

<div class="separator">
<h1>I NOSTRI MARCHI!</h1><br>
</div>

<div class="container-gestione">
		<div class="container-tabella">
			<table class="table">
			     <tbody>     
			     <tr> 
			     	 <td style="background-color:black;" >
			     	 	<img  src="img/nike.png" alt="nike image">
			     	 </td>
			     	 <td style="background-color:#C9C9C9;" > 
			     	  	<h4>IL COLOSSO DELL'ABBIGLIAMENTO</h4>
						<p> Creare un marchio di successo non è una passeggiata, ma spesso basta essere perseveranti nei propri sogni, progetti ed obiettivi e seguire una semplice sensazione o un'intuizione per ottenere successi davvero inaspettati. 
						 È quello che è successo al fondatore del marchio Nike, Phil Knight.</p> 
						<p> Oggi il logo Nike è forse uno dei più conosciuti al mondo, non ha bisogno di slogan e pay off per essere riconosciuto ed è in grado di evocare sensazioni e concetti che vanno al di là della semplice identità del brand.</p>
						<button onclick="window.location.href='./catalogo?filter=brand&brandName=Nike'" class="scopributton" >VEDI I MODELLI</button>
					</td>
     			</tr>
			     <tr> 
			     	<td style="background-color:black;" >
			     	 	<img src="img/offwhite.png" alt="offwhite image">
			     	</td>
			     	  <td style="background-color:#C9C9C9;" >
						<h4>IL BRAND PIÙ APPREZZATO</h4>
						<p> Il brand di abbigliamento streetwear Off-White è diventato in poco tempo il più apprezzato da celebrity e Millenials.</p> 
						<p>Grazie all'incredibile design di Virgil Abloh, suo fondatore, il brand sta spopolando in tutto il mondo per la sua visione creativa, particolarmente lungimirante.</p>
						<button onclick="window.location.href='./catalogo?filter=brand&brandName=Off-White'" class="scopributton" >VEDI I MODELLI</button>
					</td>

     			</tr>
			     <tr> 
			     	  <td style="background-color:black;" >
			     	 	<img src="img/yeezy.png" alt="yeezy image">
			     	 </td>
			     	 <td style="background-color:#C9C9C9;" > 
						<h4>LA COLLAB PIÙ FAMOSA</h4>
						<p> Con il marchio Yeezy, Kanye West e Adidas hanno rivoluzionato il mondo delle sneakers. 
						Le loro coppie, che mescolano comfort e tecnicità, sono disponibili in molti colori.</p>
						<button onclick="window.location.href='./catalogo?filter=brand&brandName=Yeezy'" class="scopributton" >VEDI I MODELLI</button>
					</td>
     			</tr>    			

			     </tbody>
   			</table>
		</div>
	</div>



<jsp:include page="./footer.jsp" />

        <script type="text/javascript">
        $(document).ready(function()
        		{
        		    $(".right").find("img").css("transition", "transform 500ms ease-in-out");

        		    $(".right").hover(    
        		        // Handler for mouseenter
        		        function()
        		        {
        		            $(this).find("img").css("transform", "scale(1.1)");
        		        },
        		        // Handler for mouseleave
        		        function()
        		        {
        		            $(this).find("img").css("transform", "scale(1)");
        		        }
        		    );
        		});
        </script>
</body>
</html>