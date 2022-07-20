package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.DettaglioProdottoBean;
import model.DettaglioProdottoDAO;
import model.ProdottoBean;
import model.ProdottoDAO;

/**
 * Servlet implementation class RimuoviProdottoServlet
 */
@WebServlet("/modificaTaglia")
public class ModificaTagliaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ModificaTagliaServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mode = request.getParameter("mode");
		ProdottoDAO dbProdotto = new ProdottoDAO();
		DettaglioProdottoDAO dbDettagli = new DettaglioProdottoDAO();
		String pathForward = null;
		
		if (mode.equalsIgnoreCase("modifica")) {
			ProdottoBean prodotto = new ProdottoBean();
			DettaglioProdottoBean dettagli = new DettaglioProdottoBean();
			String codiceSeriale = request.getParameter("prodotto");
			String taglia = request.getParameter("taglia");

			try {
				prodotto = dbProdotto.doRetrieveByKey(codiceSeriale);
				dettagli = dbDettagli.doRetrieveByKey(taglia,codiceSeriale);
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			
			request.setAttribute("prodotto", prodotto);
			request.setAttribute("dettagli", dettagli);
			request.setAttribute("taglia", taglia);
			pathForward = "./modificaTaglieForm.jsp";
			
		} else if (mode.equalsIgnoreCase("aggiungi")) {
			String codiceSeriale = request.getParameter("prodotto");	
			String taglia = request.getParameter("taglia");
			String quantita = request.getParameter("quantita");;
			String costo = request.getParameter("costo");
			String categoria = request.getParameter("categoria");

			DettaglioProdottoBean dettagli = new DettaglioProdottoBean();
			
			
			dettagli.setProdotto(codiceSeriale);
			dettagli.setTaglia(taglia);
			dettagli.setQuantita(Integer.parseInt(quantita));
			dettagli.setCosto(BigDecimal.valueOf(Double.parseDouble(costo)));
			dettagli.setCategoria(categoria);

			
			try {

				dbDettagli.doSave(dettagli);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			pathForward = "catalogo?filter=catalogo";
		}
		
		RequestDispatcher view = request.getRequestDispatcher(pathForward);
		view.forward(request, response);
	}

	/**
	 * @throws IOException 
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		DettaglioProdottoDAO dbDettagli = new DettaglioProdottoDAO();
		//Writer out = response.getWriter();
		
		String codiceSeriale = request.getParameter("prodotto");
		
		String taglia = request.getParameter("taglia");
		//System.out.println(taglia);
		Integer quantita = Integer.parseInt(request.getParameter("quantita"));
		BigDecimal costo = BigDecimal.valueOf(Double.parseDouble(request.getParameter("costo")));
		String categoria = request.getParameter("categoria");		
		
		DettaglioProdottoBean dettagli = new DettaglioProdottoBean();
		
		try {
			dettagli = dbDettagli.doRetrieveByKey(taglia,codiceSeriale);
		} catch (SQLException e) {
			e.printStackTrace();
		}	

		if(!dettagli.getCategoria().equalsIgnoreCase(categoria)) {
			if(categoria.equalsIgnoreCase("uomo") || categoria.equalsIgnoreCase("donna")) {
				dettagli.setCategoria(categoria.toLowerCase());
			}
		}
		
		if(!dettagli.getCosto().equals(costo)) {
			dettagli.setCosto(costo);
		}
		
		
		if(dettagli.getQuantita() != quantita.intValue()) {
			dettagli.setQuantita(quantita);
		}
		

		try {
			dbDettagli.doUpdate(dettagli);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		RequestDispatcher view = request.getRequestDispatcher("./gestisciProdotti.jsp");
		view.forward(request, response);
	}

}
