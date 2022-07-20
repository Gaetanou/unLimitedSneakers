package model;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DettaglioProdottoDAO extends AbstractDAO<DettaglioProdottoBean> {
	
	private static final String TABLE_NAME = "dettaglioprodotto";
	
	@Override
	public synchronized void doSave(DettaglioProdottoBean bean) throws SQLException {
		Connection con = null;
		PreparedStatement statement = null;
		
		String query = "INSERT INTO " + DettaglioProdottoDAO.TABLE_NAME + 
					" (prodotto,taglia,costo,quantita,categoria) "
					+ "VALUES (?,?,?,?,?);";
		
		try {
			con = DriverManagerConnectionPool.getConnection();
			statement = con.prepareStatement(query);
			
			statement.setString(1, bean.getProdotto());
			statement.setString(2, bean.getTaglia());			
			statement.setBigDecimal(3, bean.getCosto());
			statement.setInt(4, bean.getQuantita());
			statement.setString(5, bean.getCategoria());

			
			statement.executeUpdate();
			
			con.commit();
		} finally {
			try {
				if (statement != null) {
					statement.close();
				}
			} finally {
				DriverManagerConnectionPool.releaseConnection(con);
			}
		}
	}
	
	@Override
	public synchronized boolean doDelete(String key1, String key2) throws SQLException {
		Connection con = null;
		PreparedStatement statement = null;
		int result = 0;
		String query = "DELETE FROM " + DettaglioProdottoDAO.TABLE_NAME + " WHERE taglia = ? AND prodotto = ?";
		
		try {
			con = DriverManagerConnectionPool.getConnection();
			statement = con.prepareStatement(query);
			statement.setString(1, key1);
			statement.setString(2, key2);
			
			result = statement.executeUpdate();
		} finally {
			try {
				if(statement != null) {
					statement.close();
				}
			} finally {
				DriverManagerConnectionPool.releaseConnection(con);
			}
		}
		
		return result != 0;
	}

	@Override
	public synchronized DettaglioProdottoBean doRetrieveByKey(String key1, String key2) throws SQLException {
		Connection con = null;
		PreparedStatement statement = null;
		DettaglioProdottoBean dettaglioProdotto = new DettaglioProdottoBean();
		
		String query = "SELECT * FROM " + DettaglioProdottoDAO.TABLE_NAME + " WHERE taglia = ? AND prodotto = ?";
		
		try {
			con = DriverManagerConnectionPool.getConnection();
			statement = con.prepareStatement(query);
			statement.setString(1, key1);
			statement.setString(2, key2);
			
			ResultSet result = statement.executeQuery();
			
			while(result.next()) {
				
				dettaglioProdotto.setTaglia(result.getString("taglia"));
				dettaglioProdotto.setProdotto(result.getString("prodotto"));
				dettaglioProdotto.setCosto(result.getBigDecimal("costo"));
				dettaglioProdotto.setQuantita(Integer.parseInt(result.getString("quantita")));
				dettaglioProdotto.setCategoria(result.getString("categoria"));
				
			}
		} finally {
			try {
				if(statement != null) {
					statement.close();
				}
			} finally {
				DriverManagerConnectionPool.releaseConnection(con);
			}
		}
		
		return dettaglioProdotto;
	}
	
	@Override
	public synchronized DettaglioProdottoBean doRetrieveByKey(String key) throws SQLException {
		Connection con = null;
		PreparedStatement statement = null;
		DettaglioProdottoBean dettaglioProdotto = new DettaglioProdottoBean();
		
		String query = "SELECT * FROM " + DettaglioProdottoDAO.TABLE_NAME + " WHERE prodotto = ?";
		
		try {
			con = DriverManagerConnectionPool.getConnection();
			statement = con.prepareStatement(query);
			statement.setString(1, key);
			
			ResultSet result = statement.executeQuery();
			
			while(result.next()) {
				
				dettaglioProdotto.setTaglia(result.getString("taglia"));
				dettaglioProdotto.setProdotto(result.getString("prodotto"));
				dettaglioProdotto.setCosto(result.getBigDecimal("costo"));
				dettaglioProdotto.setQuantita(Integer.parseInt(result.getString("quantita")));
				dettaglioProdotto.setCategoria(result.getString("categoria"));
				
			}
		} finally {
			try {
				if(statement != null) {
					statement.close();
				}
			} finally {
				DriverManagerConnectionPool.releaseConnection(con);
			}
		}
		
		return dettaglioProdotto;
	}

	@Override
	public synchronized List<DettaglioProdottoBean> doRetrieveAll(String order) throws SQLException {
		Connection con = null;
		PreparedStatement statement = null;
		
		List<DettaglioProdottoBean> dettagliProdotti = new ArrayList<>();
		
		String query = "SELECT * FROM " + DettaglioProdottoDAO.TABLE_NAME;
		
//		if(checkOrder(order)) {
//			query += " ORDER BY" + order;
//		}
		
		try {
			con = DriverManagerConnectionPool.getConnection();
			statement = con.prepareStatement(query);
			
			ResultSet result = statement.executeQuery();
			
			while(result.next()) {
				DettaglioProdottoBean dettaglioProdotto = new DettaglioProdottoBean();
				
				
				dettaglioProdotto.setTaglia(result.getString("taglia"));
				dettaglioProdotto.setProdotto(result.getString("prodotto"));
				dettaglioProdotto.setCosto(result.getBigDecimal("costo"));
				dettaglioProdotto.setQuantita(Integer.parseInt(result.getString("quantita")));
				dettaglioProdotto.setCategoria(result.getString("categoria"));
				
				
				dettagliProdotti.add(dettaglioProdotto);
			}
		} finally {
			try {
				if(statement != null) {
					statement.close();
				}
			} finally {
				DriverManagerConnectionPool.releaseConnection(con);
			}
		}
		
		return dettagliProdotti;
	}
	
	@Override
	public synchronized boolean doUpdate(DettaglioProdottoBean bean) throws SQLException {
		Connection con = null;
		PreparedStatement statement = null;
		int result = 0;
		
		String query = "UPDATE " + DettaglioProdottoDAO.TABLE_NAME + " SET "
				+ "costo = ?, quantita = ?, categoria = ? WHERE prodotto = ? AND taglia = ?;";
		
		try {
			con = DriverManagerConnectionPool.getConnection();
			statement = con.prepareStatement(query);
					
			statement.setBigDecimal(1, bean.getCosto());
			statement.setInt(2, bean.getQuantita());
			statement.setString(3, bean.getCategoria());
			statement.setString(4, bean.getProdotto());
			statement.setString(5, bean.getTaglia());
			
			result = statement.executeUpdate();
			
			con.commit();
		} finally {
			try {
				if(statement != null) {
					statement.close();
				}
			} finally {
				DriverManagerConnectionPool.releaseConnection(con);
			}
		}
		
		return result != 0;
	}
	
	public synchronized List<DettaglioProdottoBean> filterByTaglia(String prodotto) throws SQLException {
		List<DettaglioProdottoBean> listaDettagliProdottiFiltrati = new ArrayList<>();
		Connection con = null;
		PreparedStatement statement = null;
		
		String query = "SELECT * FROM " + DettaglioProdottoDAO.TABLE_NAME + " WHERE prodotto = ? AND quantita>0 ORDER BY taglia ASC";
		
		try {
			con = DriverManagerConnectionPool.getConnection();
			statement = con.prepareStatement(query);
			statement.setString(1, prodotto);
			
			ResultSet result = statement.executeQuery();
			
			while(result.next()) {
				DettaglioProdottoBean dettaglioProdotto = new DettaglioProdottoBean();
				
				dettaglioProdotto.setTaglia(result.getString("taglia"));
				dettaglioProdotto.setProdotto(result.getString("prodotto"));
				dettaglioProdotto.setCosto(result.getBigDecimal("costo"));
				dettaglioProdotto.setQuantita(Integer.parseInt(result.getString("quantita")));
				dettaglioProdotto.setCategoria(result.getString("categoria"));
				
				listaDettagliProdottiFiltrati.add(dettaglioProdotto);
			}
		} finally {
			try {
				if(statement != null) {
					statement.close();
				}
			} finally {
				DriverManagerConnectionPool.releaseConnection(con);
			}
		}
		
		return listaDettagliProdottiFiltrati;
	}
	
	
	public synchronized List<DettaglioProdottoBean> filterByTerminati() throws SQLException {
		List<DettaglioProdottoBean> listaDettagliProdottiFiltrati = new ArrayList<>();
		Connection con = null;
		PreparedStatement statement = null;
		
		String query = "SELECT * FROM " + DettaglioProdottoDAO.TABLE_NAME + " WHERE quantita = 0;";
		
		try {
			con = DriverManagerConnectionPool.getConnection();
			statement = con.prepareStatement(query);
			
			ResultSet result = statement.executeQuery();
			
			while(result.next()) {
				DettaglioProdottoBean dettaglioProdotto = new DettaglioProdottoBean();
				
				dettaglioProdotto.setTaglia(result.getString("taglia"));
				dettaglioProdotto.setProdotto(result.getString("prodotto"));
				dettaglioProdotto.setCosto(result.getBigDecimal("costo"));
				dettaglioProdotto.setQuantita(Integer.parseInt(result.getString("quantita")));
				dettaglioProdotto.setCategoria(result.getString("categoria"));
				
				listaDettagliProdottiFiltrati.add(dettaglioProdotto);
			}
		} finally {
			try {
				if(statement != null) {
					statement.close();
				}
			} finally {
				DriverManagerConnectionPool.releaseConnection(con);
			}
		}
		
		return listaDettagliProdottiFiltrati;
	}

	public synchronized List<DettaglioProdottoBean> filterByCategoria(String tipo) throws SQLException {
		List<DettaglioProdottoBean> listaDettagliProdottiFiltrati = new ArrayList<>();
		Connection con = null;
		PreparedStatement statement = null;
		
		String query = "SELECT * FROM " + DettaglioProdottoDAO.TABLE_NAME + " WHERE categoria = ?";
		
		try {
			con = DriverManagerConnectionPool.getConnection();
			statement = con.prepareStatement(query);
			statement.setString(1, tipo);
			
			ResultSet result = statement.executeQuery();
			
			while(result.next()) {
				DettaglioProdottoBean dettaglioProdotto = new DettaglioProdottoBean();
				
				dettaglioProdotto.setTaglia(result.getString("taglia"));
				dettaglioProdotto.setProdotto(result.getString("prodotto"));
				dettaglioProdotto.setCosto(result.getBigDecimal("costo"));
				dettaglioProdotto.setQuantita(Integer.parseInt(result.getString("quantita")));
				dettaglioProdotto.setCategoria(result.getString("categoria"));
				
				listaDettagliProdottiFiltrati.add(dettaglioProdotto);
			}
		} finally {
			try {
				if(statement != null) {
					statement.close();
				}
			} finally {
				DriverManagerConnectionPool.releaseConnection(con);
			}
		}
		
		return listaDettagliProdottiFiltrati;
	}

}