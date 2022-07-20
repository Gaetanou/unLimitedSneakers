$(document).ready(function(){
	
    let codiceValidator = /^[a-zA-Z0-9_.]{5}$/;
	let numberValidator = /^[3-4_.]{1}[0-6_.]{1}$/;
	let numberQValidator = /^[0-9_.]{1,5}$/;
    $("#codiceSeriale").keyup(function (){

    	let codice = $("#codiceSeriale").val();
        let slideCodice = 0;

        if(codice.match(codiceValidator)){

    		console.log("Codice formattato correttamente");
    		
    		$.ajax({
                type: "POST",
                url: "modificaProdotto",
                data: {
                	mode: "checkCodice",
                    codice: codice,
                },
                dataType: "html",
                success: function(data) {
                	console.log(data);
   
                    if(data.match("non disponibile")) {

                        if(slideCodice == 0) {

                            $("#error-codice").slideDown();
                            slideCodice = 1;

                        }

                    	$("#error-codice").text("Codice non disponibile e/o gia in uso");

                    } else if (data.match("disponibile")){	

                        slideCodice = 0;
                        $("#error-codice").text("Codice disponibile");
                        $("#error-codice").slideUp();

                    }
                }
            });

    	} else {

            console.log("Codice non disponibile");

            if(slideCodice == 0) {

                $("#error-codice").slideDown();
                slideCodice = 1;

            }

    		$("#error-codice").text("Codice non valido");

    	}

        if(codice == ""){

            if(slideCodice == 1) {
                
                slideCodice = 0;
                $("#error-codice").slideUp();
        
            }

            $("#error-codice").text("");

        }
    });
    
    
    
    
    
    
    $("#taglia").keyup(function (){

    	let taglia = $("#taglia").val();
        let slideCodice = 0;

        if(taglia.match(numberValidator)){

    		console.log("Taglia valida");
                        
                        slideCodice = 0;
                        $("#error-taglia").text("Taglia valida");
                        $("#error-taglia").slideUp();

        } else {

            console.log("Taglia non valida");

            if(slideCodice == 0) {

                $("#error-taglia").slideDown();
                slideCodice = 1;

            }

    		$("#error-taglia").text("Taglia non valida");

    	}

        if(codice == ""){

            if(slideCodice == 1) {
                
                slideCodice = 0;
                $("#error-taglia").slideUp();
        
            }

            $("#error-taglia").text("");

        }
    });
    
    
    
    
    
    
     $("#quantita").keyup(function (){

    	let quantita = $("#quantita").val();
        let slideCodice = 0;

        if(quantita.match(numberQValidator)){

    		console.log("quantita valida");
                        
                        slideCodice = 0;
                        $("#error-quantita").text("Quantita valida");
                        $("#error-quantita").slideUp();

        } else {

            console.log("Quantita non valida");

            if(slideCodice == 0) {

                $("#error-quantita").slideDown();
                slideCodice = 1;

            }

    		$("#error-quantita").text("Quantita non valida");

    	}

        if(quantita == ""){

            if(slideCodice == 1) {
                
                slideCodice = 0;
                $("#error-quantita").slideUp();
        
            }

            $("#error-quantita").text("");

        }
    });
    
    
    
     $("#costo").keyup(function (){

    	let costo = $("#costo").val();
        let slideCodice = 0;

        if(costo.match(numberQValidator)){

    		console.log("costo valida");
                        
                        slideCodice = 0;
                        $("#error-costo").text("Costo valido");
                        $("#error-costo").slideUp();

        } else {

            console.log("Costo non valido");

            if(slideCodice == 0) {

                $("#error-costo").slideDown();
                slideCodice = 1;

            }

    		$("#error-costo").text("Costo non valido");

    	}

        if(costo == ""){

            if(slideCodice == 1) {
                
                slideCodice = 0;
                $("#error-costo").slideUp();
        
            }

            $("#error-costo").text("");

        }
    });
    

});