package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.cj.x.protobuf.MysqlxExpect.Open.Condition.Key;

import model.DettaglioProdottoBean;
import model.DettaglioProdottoDAO;
import model.IndirizzoBean;
import model.IndirizzoDAO;
import model.MetodoDiPagamentoBean;
import model.MetodoDiPagamentoDAO;
import model.OrdineBean;
import model.OrdineDAO;
import model.ProdottoBean;
import model.ProdottoDAO;
import model.UtenteBean;
import model.UtenteDAO;

/**
 * Servlet implementation class CarrelloServlet
 */
@WebServlet("/carrello")
public class CarrelloServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CarrelloServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String prodotto = request.getParameter("prodotto");

		String taglia = request.getParameter("taglia");

		String mode = request.getParameter("mode");
		Integer quantita;
		String path = null;
		response.setContentType("text/plain");
		Map <String, Map<String,Integer>> carrello = new HashMap<>();
		Map <String,Integer> coppia = new HashMap<>();
		Map <String,Integer> newCoppia = new HashMap<>();
		
		Iterator <Map<String,Integer>> iterKeysDettagli;
		
		if(mode.equalsIgnoreCase("add")) {
			taglia = taglia.trim();
			if(request.getSession().getAttribute("carrello") != null) {
				carrello = (Map <String, Map<String,Integer>>) request.getSession().getAttribute("carrello");
				
				if(carrello.containsKey(prodotto)) {
						if(carrello.get(prodotto).containsKey(taglia)) {
							quantita = carrello.get(prodotto).get(taglia);
							//carrello.get(prodotto).remove(coppia);
							carrello.get(prodotto).put(taglia, quantita + 1);
				
						}
						else {
						
							carrello.get(prodotto).put(taglia, 1);
						}
				} else {
				
					newCoppia.put(taglia, 1);
					carrello.put(prodotto, newCoppia);
				}
			} else {
			
				newCoppia.put(taglia, 1);
				carrello.put(prodotto, newCoppia);
			}
			
			request.getSession().setAttribute("carrello", carrello);
			if(request.getParameter("catalogo") != null) {
				path = "/catalogo.jsp";
			} else {
				request.getSession().setAttribute("aggiunto", "Aggiunto al carrello!");
				path = "/catalogo.jsp";
			}
			
		} else if(mode.equalsIgnoreCase("updateplus")) {
			quantita = Integer.parseInt(request.getParameter("quantita"));
			Integer quantitaMax = Integer.parseInt(request.getParameter("quantitaMax"));
			carrello = (Map <String, Map<String,Integer>>) request.getSession().getAttribute("carrello");

			if(carrello.isEmpty()) {
					request.getSession().removeAttribute("carrello");
			}
 
			if (quantita+1<=quantitaMax){
			newCoppia.put(taglia, quantita+1);
			carrello.put(prodotto, newCoppia);
			request.getSession().setAttribute("carrello", carrello);
			}
			path = "/carrello.jsp";
		}else if(mode.equalsIgnoreCase("updateminus")) {
			quantita = Integer.parseInt(request.getParameter("quantita"));
			Integer quantitaMax = Integer.parseInt(request.getParameter("quantitaMax"));
			carrello = (Map <String, Map<String,Integer>>) request.getSession().getAttribute("carrello");
			
			if(quantita-1 == 0) {
				carrello.get(prodotto).remove(taglia);
				if(carrello.get(prodotto).isEmpty()) {
					carrello.remove(prodotto);
				}
				if(carrello.isEmpty()) {
					request.getSession().removeAttribute("carrello");
				}
			} else{
			newCoppia.put(taglia, quantita-1);
			carrello.put(prodotto, newCoppia);
			request.getSession().setAttribute("carrello", carrello);
			}
			path = "/carrello.jsp";
		}else if(mode.equalsIgnoreCase("remove")) {
			taglia = taglia.trim();
			carrello = (Map <String, Map<String,Integer>>) request.getSession().getAttribute("carrello");
			carrello.get(prodotto).remove(taglia);
			if(carrello.get(prodotto).isEmpty()) {
				carrello.remove(prodotto);
			}
			if(carrello.isEmpty()) {
				request.getSession().removeAttribute("carrello");
			}
			RequestDispatcher view = request.getRequestDispatcher("./carrello.jsp");
			view.forward(request, response);
		} else if(mode.equalsIgnoreCase("reset")) {
			request.getSession().removeAttribute("carrello");
			RequestDispatcher view = request.getRequestDispatcher("./carrello.jsp");
			view.forward(request, response);
		} else if(mode.equalsIgnoreCase("getTotal")) {
			if(request.getSession().getAttribute("carrello") == null) {
				return;
			} else {
				Double total = 0.0;
				carrello = (Map <String, Map<String,Integer>>) request.getSession().getAttribute("carrello");
				DettaglioProdottoBean dettagliProdotto = new DettaglioProdottoBean();
				DettaglioProdottoDAO dbDettagliProdotti = new DettaglioProdottoDAO();
				String key;
				Iterator<String> iterKeys = carrello.keySet().iterator();
				while(iterKeys.hasNext()) {
					key = iterKeys.next();
					try {
						dettagliProdotto = dbDettagliProdotti.doRetrieveByKey(key);
						if(dettagliProdotto.getCosto() != null) {
							total += dettagliProdotto.getCosto().doubleValue() * carrello.get(key).get(taglia);
						} else {
							total += dettagliProdotto.getCosto().doubleValue() * carrello.get(key).get(taglia);
						}
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				
				response.getWriter().print(String.format("%.2f", total));
			}
		}
		RequestDispatcher view = request.getRequestDispatcher(path);
		view.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
}
