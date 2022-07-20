package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

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
 * Servlet implementation class CatalogoServlet
 */
@WebServlet("/catalogo")
public class CatalogoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CatalogoServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ProdottoDAO dbProdotti = new ProdottoDAO();
		DettaglioProdottoDAO dbDettagli = new DettaglioProdottoDAO();
		List<ProdottoBean> prodotti = new ArrayList<>();
		List<ProdottoBean> prodotti2 = new ArrayList<>();
		List<ProdottoBean> prodottiTerminati = new ArrayList<>();
		List<ProdottoBean> prodottiTerminati2 = new ArrayList<>();
		List<DettaglioProdottoBean> dettagliProdotti = new ArrayList<>();

		DettaglioProdottoBean dettagli = new DettaglioProdottoBean();
		ProdottoBean prodotto = new ProdottoBean();
		ProdottoBean terminato = new ProdottoBean();
		String filter = request.getParameter("filter");
		String path = null;
		
		if(filter != null) {
			if(filter.equals("uomo") || filter.equals("donna")) {
				try {
					dettagliProdotti = dbDettagli.filterByCategoria(filter);
					Iterator<DettaglioProdottoBean> iterDettagliProdotti = dettagliProdotti.iterator();
					Iterator<ProdottoBean> iterProdottiTerminati;
					Iterator<ProdottoBean> iterProdottiDisp;

					
					while(iterDettagliProdotti.hasNext()) {
						dettagli = iterDettagliProdotti.next();
						
						prodotto = dbProdotti.doRetrieveByKey(dettagli.getProdotto());
						
						if(dettagli.getQuantita() == 0) {
							prodottiTerminati.add(prodotto);
						} else {
							prodotti.add(prodotto);
						}	
					}
					
					//RIMOZIONE DUPLICATI
					iterProdottiTerminati = prodottiTerminati.iterator();
					while(iterProdottiTerminati.hasNext()) {
						terminato = iterProdottiTerminati.next();
							if(!prodottiTerminati2.contains(terminato)) {
								prodottiTerminati2.add(terminato);
							}
					}
					

					
					iterProdottiDisp = prodotti.iterator();
					while(iterProdottiDisp.hasNext()) {
						prodotto = iterProdottiDisp.next();
							if(!prodotti2.contains(prodotto)) {
								prodotti2.add(prodotto);
							}
					}
					prodottiTerminati.removeAll(prodottiTerminati);
					
					//RIMOZIONE FALSI TERMINATI
					iterProdottiTerminati = prodottiTerminati2.iterator();
					while(iterProdottiTerminati.hasNext()) {
						terminato = iterProdottiTerminati.next();
							if(!prodotti2.contains(terminato)) {
								prodottiTerminati.add(terminato);
							}
					}
					



					
				} catch (SQLException e) {
					// TODO Auto-generated catch block				
					request.getSession().setAttribute("prodottiTerminati", prodottiTerminati);
					request.getSession().setAttribute("prodotti", prodotti2);

					if (request.getSession().getAttribute("admin") == null) {
						request.getSession().setAttribute("admin",false);
					}
					e.printStackTrace();
				}
			}else if(filter.equalsIgnoreCase("brand")){
				
					try {
					String brandName = request.getParameter("brandName");
					dettagliProdotti = dbDettagli.doRetrieveAll("");
					Iterator<DettaglioProdottoBean> iterDettagliProdotti = dettagliProdotti.iterator();
					Iterator<ProdottoBean> iterProdottiTerminati;
					Iterator<ProdottoBean> iterProdottiDisp;

					
					while(iterDettagliProdotti.hasNext()) {
						dettagli = iterDettagliProdotti.next();
						
						prodotto = dbProdotti.doRetrieveByKey(dettagli.getProdotto());
						if(prodotto.getBrand().equals(brandName)) {
						if(dettagli.getQuantita() == 0) {
							prodottiTerminati.add(prodotto);
						} else {
							prodotti.add(prodotto);
						}
						}
					}
					
					//RIMOZIONE DUPLICATI
					iterProdottiTerminati = prodottiTerminati.iterator();
					while(iterProdottiTerminati.hasNext()) {
						terminato = iterProdottiTerminati.next();
							if(!prodottiTerminati2.contains(terminato)) {
								prodottiTerminati2.add(terminato);
							}
					}
					

					iterProdottiDisp = prodotti.iterator();
					while(iterProdottiDisp.hasNext()) {
						prodotto = iterProdottiDisp.next();
							if(!prodotti2.contains(prodotto)) {
								prodotti2.add(prodotto);
							}
					}
					prodottiTerminati.removeAll(prodottiTerminati);
					
					//RIMOZIONE FALSI TERMINATI
					iterProdottiTerminati = prodottiTerminati2.iterator();
					while(iterProdottiTerminati.hasNext()) {
						terminato = iterProdottiTerminati.next();
							if(!prodotti2.contains(terminato)) {
								prodottiTerminati.add(terminato);
							}
					}
					dettagliProdotti = dbDettagli.doRetrieveAll("categoria");
					
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}else if(filter.equalsIgnoreCase("ricerca")){
				
				try {
				String name = request.getParameter("name");
				dettagliProdotti = dbDettagli.doRetrieveAll("");
				Iterator<DettaglioProdottoBean> iterDettagliProdotti = dettagliProdotti.iterator();
				Iterator<ProdottoBean> iterProdottiTerminati;
				Iterator<ProdottoBean> iterProdottiDisp;

				
				while(iterDettagliProdotti.hasNext()) {
					dettagli = iterDettagliProdotti.next();
					
					prodotto = dbProdotti.doRetrieveByKey(dettagli.getProdotto());
					if(prodotto.getNome().contains(name)) {
					if(dettagli.getQuantita() == 0) {
						prodottiTerminati.add(prodotto);
					} else {
						prodotti.add(prodotto);
					}
					}
				}
				
				//RIMOZIONE DUPLICATI
				iterProdottiTerminati = prodottiTerminati.iterator();
				while(iterProdottiTerminati.hasNext()) {
					terminato = iterProdottiTerminati.next();
						if(!prodottiTerminati2.contains(terminato)) {
							prodottiTerminati2.add(terminato);
						}
				}
				

				iterProdottiDisp = prodotti.iterator();
				while(iterProdottiDisp.hasNext()) {
					prodotto = iterProdottiDisp.next();
						if(!prodotti2.contains(prodotto)) {
							prodotti2.add(prodotto);
						}
				}
				prodottiTerminati.removeAll(prodottiTerminati);
				
				//RIMOZIONE FALSI TERMINATI
				iterProdottiTerminati = prodottiTerminati2.iterator();
				while(iterProdottiTerminati.hasNext()) {
					terminato = iterProdottiTerminati.next();
						if(!prodotti2.contains(terminato)) {
							prodottiTerminati.add(terminato);
						}
				}
				dettagliProdotti = dbDettagli.doRetrieveAll("categoria");
	
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
			else if (filter.equalsIgnoreCase("catalogo")) {
				try {
					
					dettagliProdotti = dbDettagli.doRetrieveAll("");
					Iterator<DettaglioProdottoBean> iterDettagliProdotti = dettagliProdotti.iterator();
					Iterator<ProdottoBean> iterProdottiTerminati;
					Iterator<ProdottoBean> iterProdottiDisp;

					
					while(iterDettagliProdotti.hasNext()) {
						dettagli = iterDettagliProdotti.next();
						
						prodotto = dbProdotti.doRetrieveByKey(dettagli.getProdotto());
						
						if(dettagli.getQuantita() == 0) {
							prodottiTerminati.add(prodotto);
						} else {
							prodotti.add(prodotto);
						}	
					}
					
					//RIMOZIONE DUPLICATI
					iterProdottiTerminati = prodottiTerminati.iterator();
					while(iterProdottiTerminati.hasNext()) {
						terminato = iterProdottiTerminati.next();
							if(!prodottiTerminati2.contains(terminato)) {
								prodottiTerminati2.add(terminato);
							}
					}
					

					iterProdottiDisp = prodotti.iterator();
					while(iterProdottiDisp.hasNext()) {
						prodotto = iterProdottiDisp.next();
							if(!prodotti2.contains(prodotto)) {
								prodotti2.add(prodotto);
							}
					}
					prodottiTerminati.removeAll(prodottiTerminati);
					
					//RIMOZIONE FALSI TERMINATI
					iterProdottiTerminati = prodottiTerminati2.iterator();
					while(iterProdottiTerminati.hasNext()) {
						terminato = iterProdottiTerminati.next();
							if(!prodotti2.contains(terminato)) {
								prodottiTerminati.add(terminato);
							}
					}
					dettagliProdotti = dbDettagli.doRetrieveAll("categoria");
					
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
		}
		
		request.getSession().setAttribute("prodotti", prodotti2);
		request.getSession().setAttribute("prodottiTerminati", prodottiTerminati);
		request.getSession().setAttribute("dettagliProdotti", dettagliProdotti);
		
		if (request.getSession().getAttribute("admin") == null) {
			request.getSession().setAttribute("admin",false);
		}	
		path = "./catalogo.jsp";
		RequestDispatcher view = request.getRequestDispatcher(path);
		view.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}
}
