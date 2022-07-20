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
 * Servlet implementation class SelectProdottoServlet
 */
@WebServlet("/select")
public class SelectProdottoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SelectProdottoServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type = request.getParameter("type");
		String path = null;
		ProdottoDAO dbProdotto = new ProdottoDAO();
		DettaglioProdottoDAO dbDettagli = new DettaglioProdottoDAO();
		
		ProdottoBean prodotto = new ProdottoBean();
		DettaglioProdottoBean dettagliProdotto = new DettaglioProdottoBean();
		List<DettaglioProdottoBean> dettagli = new ArrayList<>();
		Iterator<DettaglioProdottoBean> iterDettagli;
		DettaglioProdottoBean dettaglio = new DettaglioProdottoBean();
		
		if(type.equalsIgnoreCase("prodotto")) {
		try {
			prodotto = dbProdotto.doRetrieveByKey(request.getParameter("prodotto"));
			dettagliProdotto = dbDettagli.doRetrieveByKey(prodotto.getCodiceSeriale());
			
			dettagli = dbDettagli.filterByTaglia(request.getParameter("prodotto"));
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(!dettagli.isEmpty()) {
			request.getSession().setAttribute("empty", false);
			request.getSession().setAttribute("taglieTrovate", dettagli);		
		}

		request.setAttribute("prodotto", prodotto);
		request.setAttribute("dettagliProdotto", dettagliProdotto);
		if(!(request.getParameter("stato") == null)) {
			if(request.getParameter("stato").equalsIgnoreCase("terminato")) {
				request.setAttribute("stato", "termianto");
			}
		}
		path = "./prodotto.jsp";
		} 
		
		
		RequestDispatcher view = request.getRequestDispatcher(path);
		view.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
