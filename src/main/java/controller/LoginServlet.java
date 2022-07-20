package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Base64.Encoder;
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

import model.ComposizioneOrdineBean;
import model.ComposizioneOrdineDAO;
import model.IndirizzoBean;
import model.IndirizzoDAO;
import model.MetodoDiPagamentoBean;
import model.MetodoDiPagamentoDAO;
import model.OrdineBean;
import model.OrdineDAO;
import model.UtenteBean;
import model.UtenteDAO;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mode = request.getParameter("mode");
		String path = null;
		
		if(mode.equalsIgnoreCase("getInfo")) {
			String utente = (String) request.getSession().getAttribute("utente");
			boolean admin = (boolean) request.getSession().getAttribute("admin");
			
			List<IndirizzoBean> indirizzi = new ArrayList<>();
			List<MetodoDiPagamentoBean> metodiPagamento = new ArrayList<>();
			List<OrdineBean> ordini = new ArrayList<>();
			List<ComposizioneOrdineBean> composizioni = new ArrayList<>();
			Map<Integer,List<ComposizioneOrdineBean>> composizioniOrdini = new HashMap<>();
			List<ComposizioneOrdineBean> composizioniTemp = new ArrayList<>();
			
			ComposizioneOrdineBean composizione = new ComposizioneOrdineBean();
			
			IndirizzoDAO dbIndirizzo = new IndirizzoDAO();
			MetodoDiPagamentoDAO dbPagamento = new MetodoDiPagamentoDAO();
			OrdineDAO dbOrdine = new OrdineDAO();
			ComposizioneOrdineDAO dbComposizioni = new ComposizioneOrdineDAO();
			
			if(!admin) {
				try {
					indirizzi = dbIndirizzo.doRetrieveAllByKey(utente);
					metodiPagamento = dbPagamento.doRetrieveAllByKey(utente);
					ordini = dbOrdine.doRetrieveAllByKey(utente);
					composizioni = dbComposizioni.filterByCliente(utente);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				Iterator<ComposizioneOrdineBean> iterComposizioni = composizioni.iterator();
				
				while(iterComposizioni.hasNext()) {
					composizione = iterComposizioni.next();
					if(composizioniOrdini.containsKey((Integer) composizione.getOrdine())) {
						composizioniTemp = composizioniOrdini.get((Integer) composizione.getOrdine());
					} else {
						composizioniTemp = new ArrayList<>();
						composizioniTemp.add(composizione);
					}
					
					composizioniTemp.add(composizione);
					composizioniOrdini.put((Integer) composizione.getOrdine(), composizioniTemp);
				}
				
				request.getSession().setAttribute("indirizzi", indirizzi);
				request.getSession().setAttribute("metodiPagamento", metodiPagamento);
				request.getSession().setAttribute("ordini", ordini);
				request.getSession().setAttribute("composizioniOrdini", composizioniOrdini);
				
				if(request.getParameter("next") != null) {
					int ordineID = ordini.get(ordini.size()-1).getNumOrdineProgressivo();
					response.sendRedirect("./gestisciOrdine?ordine=" + ordineID + "&cliente=" + utente + "&acquisto=si");
					return;
				} else {
					path = "./areaPersonale.jsp";
				}
			} else {
				List<String> usernameList = new ArrayList<>();
				List<UtenteBean> utenti = new ArrayList<>();
				Iterator<UtenteBean> iterUtenti;
				UtenteDAO dbUtenti = new UtenteDAO();
				UtenteBean utenteTrovato = new UtenteBean();
				try {
					ordini = dbOrdine.doRetrieveAll(utente);
					utenti = dbUtenti.doRetrieveAll(utente);
					iterUtenti = utenti.iterator();
					
					while(iterUtenti.hasNext()) {
						utenteTrovato = iterUtenti.next();
						
						if(!utenteTrovato.isAdmin()) usernameList.add(utenteTrovato.getUsername());
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				request.getSession().setAttribute("usernameList", usernameList);
				request.getSession().setAttribute("ordini", ordini);
				
				path = "catalogo?filter=catalogo";
			}
		} else if(mode.equalsIgnoreCase("register")) {
			response.sendRedirect("./registration.jsp");
		} else if(mode.equalsIgnoreCase("acquisto")) {
			path = "acquisto.jsp";
		}
		
		RequestDispatcher view = request.getRequestDispatcher(path);
		view.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mode = request.getParameter("mode");
		String path = null;
		UtenteDAO dbUtenti = new UtenteDAO();
		
		if(mode.equalsIgnoreCase("login")) {
			String username = request.getParameter("username");
		
			Encoder encoder = Base64.getEncoder();
			String password64 = encoder.encodeToString(request.getParameter("password").getBytes());
			UtenteBean user = checkLogin(username, password64);
			
			//UtenteBean user = checkLogin(username, request.getParameter("password"));
			
			if(user != null) {
				request.getSession().setAttribute("nome", user.getNome());
				request.getSession().setAttribute("cognome", user.getCognome());
				request.getSession().setAttribute("utente", user.getUsername());
				request.getSession().setAttribute("logged", (Boolean) true);
				
				if(user.isAdmin()) {
					request.getSession().setAttribute("admin", true);
				} else {
					request.getSession().setAttribute("admin", false);
				}
				
				response.sendRedirect("login?mode=getInfo");
			} else {
				request.getSession().setAttribute("logged", (Boolean) false);
				request.getSession().setAttribute("error", "Username e/o password invalidi.");
				response.sendRedirect("./login.jsp");
			}
		} else if(mode.equalsIgnoreCase("register")) {
			String username = request.getParameter("username");
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			String passwordCheck = request.getParameter("passwordCheck");
			String nome = request.getParameter("nome");
			String cognome = request.getParameter("cognome");
			Encoder encoder = Base64.getEncoder();
			String pwd64 = null;
			String pwdchk64 = null;
			
			pwd64 = encoder.encodeToString(password.getBytes());
			pwdchk64 = encoder.encodeToString(passwordCheck.getBytes());
			
			try {
				if(pwd64.equals(pwdchk64)) {
					UtenteBean utente = new UtenteBean();
					UtenteBean utenteRicercato = new UtenteBean();
					boolean flag = false;
					List<UtenteBean> listaUtenti = dbUtenti.doRetrieveAll(username);
					Iterator<UtenteBean> iterUtenti = listaUtenti.iterator();
					
					utente.setUsername(username);
					utente.setPassword(pwd64);
					
					while(iterUtenti.hasNext()) {
						utenteRicercato = iterUtenti.next();
						if(!utenteRicercato.getUsername().equalsIgnoreCase(utente.getUsername())) {
							if(utenteRicercato.getEmail().equalsIgnoreCase(email)) {
								flag = true;
								break;
							}
						}
					}
					
					utente.setEmail(email);
					utente.setNome(nome);
					utente.setCognome(cognome);
					utente.setAdmin(false);
					
					if(!flag) {
						dbUtenti.doSave(utente);
						request.getSession().setAttribute("result", "Registrato con successo!");
					} else {
						request.getSession().setAttribute("error", "Registrazione non completata. Riprovare.");
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			path = "./login.jsp";
			
			RequestDispatcher view = request.getRequestDispatcher(path);
			view.forward(request, response);
		} else if(mode.equalsIgnoreCase("checkEmail")) {
			response.setContentType("text/plain");
			String email = request.getParameter("email");
			
			try {
				if(dbUtenti.checkEmail(email)) {
					response.getWriter().print("non disponibile");
				} else {
					response.getWriter().print("disponibile");
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if(mode.equalsIgnoreCase("checkUsername")) {
			response.setContentType("text/plain");
			String username = request.getParameter("username");
			
			try {
				if(dbUtenti.checkUsername(username)) {
					response.getWriter().print("non disponibile");
				} else {
					response.getWriter().print("disponibile");
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	private UtenteBean checkLogin(String username, String password64) {
		UtenteDAO database = new UtenteDAO();
		UtenteBean user = new UtenteBean();
		
		try {
			user = database.doRetrieveByKey(username);
			
			if(user.getUsername().equals(username) && user.getPassword().equals(password64)) {
				return user;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return null;
	}
}