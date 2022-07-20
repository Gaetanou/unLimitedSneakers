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
@WebServlet("/modificaProdotto")
public class ModificaProdottoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ModificaProdottoServlet() {
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
		
		if(mode.equalsIgnoreCase("elimina")) {
			String prodotto = request.getParameter("prodotto");
			try {
				dbProdotto.doDelete(prodotto);
				} catch (SQLException e) {
				e.printStackTrace();
			}
			
			pathForward = "./gestisciProdotti.jsp";
			
		} else if (mode.equalsIgnoreCase("modifica")) {
			ProdottoBean prodotto = new ProdottoBean();
			DettaglioProdottoBean dettagli = new DettaglioProdottoBean();
			String codiceSeriale = request.getParameter("prodotto");
			
			try {
				prodotto = dbProdotto.doRetrieveByKey(codiceSeriale);
				dettagli = dbDettagli.doRetrieveByKey(codiceSeriale);
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			
			request.setAttribute("prodotto", prodotto);
			request.setAttribute("dettagli", dettagli);
			pathForward = "./modificaProdottoForm.jsp";
			
			
		} else if (mode.equalsIgnoreCase("aggiungi")) {
			String codiceSeriale = request.getParameter("codiceSeriale");
			String nome = request.getParameter("nome");
			String brand = request.getParameter("brand");
			String descrizione = request.getParameter("descrizioneBreve");

			String taglia = request.getParameter("taglia");
			Integer quantita = Integer.parseInt(request.getParameter("quantita"));
			BigDecimal costo = BigDecimal.valueOf(Double.parseDouble(request.getParameter("costo")));
			String categoria = request.getParameter("categoria");

			
			ProdottoBean prodotto = new ProdottoBean();
			DettaglioProdottoBean dettagli = new DettaglioProdottoBean();
			
			
			prodotto.setCodiceSeriale(codiceSeriale);
			prodotto.setNome(nome);
			prodotto.setBrand(brand);
			prodotto.setDescrizioneBreve(descrizione);
			
			dettagli.setProdotto(codiceSeriale);
			dettagli.setTaglia(taglia);
			dettagli.setQuantita((quantita));
			dettagli.setCosto(costo);
			dettagli.setCategoria(categoria);
			
			
			try {
				dbProdotto.doSave(prodotto);
				dbDettagli.doSave(dettagli);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			pathForward = "./gestisciProdotti.jsp";
			//pathForward = "./gestisciProdotti.jsp";
		}
		
		RequestDispatcher view = request.getRequestDispatcher(pathForward);
		view.forward(request, response);
	}

	/**
	 * @throws IOException 
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ProdottoDAO dbProdotto = new ProdottoDAO();
		
		if ((request.getParameter("mode")).equalsIgnoreCase("checkCodice")) {
			response.setContentType("text/plain");
			String codice = request.getParameter("codice");
			try {
				if(dbProdotto.checkCodice(codice)) {
					response.getWriter().print("non disponibile");
				} else {
					response.getWriter().print("disponibile");
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}			
		}else {
		
		
		

		//Writer out = response.getWriter();
		String pathForward = null;
		String codiceSeriale = request.getParameter("prodotto");
		String nome = request.getParameter("nome");
		String brand = request.getParameter("brand");
		String descrizione = request.getParameter("descrizioneBreve");
		
		ProdottoBean prodotto = new ProdottoBean();

		
		try {
			prodotto = dbProdotto.doRetrieveByKey(codiceSeriale);
	
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		if(!prodotto.getNome().equals(nome)) {
			prodotto.setNome(nome);
		}
		
		if(!prodotto.getBrand().equals(brand)) {
			prodotto.setBrand(brand);
		}
		
		if(!prodotto.getDescrizioneBreve().equals(descrizione)) {
			prodotto.setDescrizioneBreve(descrizione);
		}

		try {
			dbProdotto.doUpdate(prodotto);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		//pathForward = "/catalogo?filter=catalogo";
		pathForward = "./gestisciProdotti.jsp";
		RequestDispatcher view = request.getRequestDispatcher(pathForward);
		view.forward(request, response);
	}
	}

}
