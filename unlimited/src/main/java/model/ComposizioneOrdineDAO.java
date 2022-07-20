package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ComposizioneOrdineDAO extends AbstractDAO<ComposizioneOrdineBean> {

	private static final String TABLE_NAME = "dettagliordine";
	
	@Override
	public synchronized void doSave(ComposizioneOrdineBean bean) throws SQLException {
		Connection con = null;
		PreparedStatement statement = null;
		
		String query = "INSERT INTO " + ComposizioneOrdineDAO.TABLE_NAME + 
					" (ordine,cliente,prodotto,taglia,quantita,costo) VALUES (?,?,?,?,?,?);";
		
		try {
			con = DriverManagerConnectionPool.getConnection();
			statement = con.prepareStatement(query);
			
			statement.setInt(1, bean.getOrdine());
			statement.setString(2, bean.getCliente());
			statement.setString(3, bean.getProdotto());
			statement.setString(4, bean.getTaglia());
			statement.setInt(5, bean.getQuantita());
			statement.setBigDecimal(6, bean.getCosto());
			
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

	public synchronized boolean doDelete(String key1,String key2,String key3, String key4) throws SQLException {
		Connection con = null;
		PreparedStatement statement = null;
		int result = 0;
		String query = "DELETE FROM " + ComposizioneOrdineDAO.TABLE_NAME + " WHERE ordine = ? AND cliente = ? AND prodotto = ? AND taglia = ?";
		
		try {
			con = DriverManagerConnectionPool.getConnection();
			statement = con.prepareStatement(query);
			statement.setString(1, key1);
			statement.setString(2, key2);
			statement.setString(3, key3);
			statement.setString(4, key4);
			
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

	public synchronized ComposizioneOrdineBean doRetrieveByKey(String key1, String key2, String key3, String key4) throws SQLException {
		Connection con = null;
		PreparedStatement statement = null;
		ComposizioneOrdineBean composizione = new ComposizioneOrdineBean();
		
		String query = "SELECT * FROM " + ComposizioneOrdineDAO.TABLE_NAME + " WHERE ordine = ? AND cliente = ? AND prodotto = ? AND taglia = ?";
		
		try {
			con = DriverManagerConnectionPool.getConnection();
			statement = con.prepareStatement(query);
			statement.setString(1, key1);
			statement.setString(2, key2);
			statement.setString(3, key3);
			statement.setString(4, key4);
			
			ResultSet result = statement.executeQuery();
				
			while(result.next()) {
				composizione.setOrdine(result.getInt("ordine"));
				composizione.setCliente(result.getString("cliente"));
				composizione.setProdotto(result.getString("prodotto"));
				composizione.setTaglia(result.getString("taglia"));
				composizione.setQuantita(result.getInt("quantita"));
				composizione.setCosto(result.getBigDecimal("costo"));
			
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
		
		return composizione;
	}

	@Override
	public synchronized List<ComposizioneOrdineBean> doRetrieveAll(String order) throws SQLException {
		Connection con = null;
		PreparedStatement statement = null;
		
		List<ComposizioneOrdineBean> composizioniOrdini = new ArrayList<>();
		
		String query = "SELECT * FROM " + ComposizioneOrdineDAO.TABLE_NAME;
		
//		if(checkOrder(order)) {
//			query += " ORDER BY" + order;
//		}
		
		try {
			con = DriverManagerConnectionPool.getConnection();
			statement = con.prepareStatement(query);
			
			ResultSet result = statement.executeQuery();
			
			while(result.next()) {
				ComposizioneOrdineBean composizione = new ComposizioneOrdineBean();
				
				composizione.setOrdine(result.getInt("ordine"));
				composizione.setCliente(result.getString("cliente"));
				composizione.setProdotto(result.getString("prodotto"));
				composizione.setTaglia(result.getString("taglia"));
				composizione.setQuantita(result.getInt("quantita"));
				composizione.setCosto(result.getBigDecimal("costo"));
				
				composizioniOrdini.add(composizione);
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
		
		return composizioniOrdini;
	}
	
	

	@Override
	public synchronized List<ComposizioneOrdineBean> doRetrieveAllByKey(String key) throws SQLException {
		Connection con = null;
		PreparedStatement statement = null;
		List<ComposizioneOrdineBean> composizioni = new ArrayList<>();
		ComposizioneOrdineBean composizione = null;
		
		String query = "SELECT * FROM " + ComposizioneOrdineDAO.TABLE_NAME + " WHERE ordine = ?";
		
		try {
			con = DriverManagerConnectionPool.getConnection();
			statement = con.prepareStatement(query);
			statement.setString(1, key);
			
			ResultSet result = statement.executeQuery();
				
			while(result.next()) {
				composizione = new ComposizioneOrdineBean();
				composizione.setOrdine(result.getInt("ordine"));
				composizione.setCliente(result.getString("cliente"));
				composizione.setProdotto(result.getString("prodotto"));
				composizione.setTaglia(result.getString("taglia"));
				composizione.setQuantita(result.getInt("quantita"));
				composizione.setCosto(result.getBigDecimal("costo"));
				
				composizioni.add(composizione);
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
		
		return composizioni;
	}

	@Override
	public synchronized boolean doUpdate(ComposizioneOrdineBean bean) throws SQLException {
		Connection con = null;
		PreparedStatement statement = null;
		int result = 0;
		
		String query = "UPDATE " + ComposizioneOrdineDAO.TABLE_NAME + " SET "
				+ "ordine = ?, cliente = ?, prodotto = ?, taglia = ?, quantita = ?, costo = ? WHERE ordine = ? AND prodotto = ?;";
		
		try {
			con = DriverManagerConnectionPool.getConnection();
			statement = con.prepareStatement(query);
			
			statement.setInt(1, bean.getOrdine());
			statement.setString(2, bean.getCliente());
			statement.setString(3, bean.getProdotto());
			statement.setString(4, bean.getTaglia());
			statement.setInt(5, bean.getQuantita());
			statement.setBigDecimal(6, bean.getCosto());
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
	
	public synchronized List<ComposizioneOrdineBean> filterByCliente(String cliente) throws SQLException {
		Connection con = null;
		PreparedStatement statement = null;
		List<ComposizioneOrdineBean> composizioniOrdini = new ArrayList<>();
		ComposizioneOrdineBean composizione = new ComposizioneOrdineBean();
		
		String query = "SELECT * FROM " + ComposizioneOrdineDAO.TABLE_NAME + " WHERE cliente = ?" ;

		try {
			con = DriverManagerConnectionPool.getConnection();
			statement = con.prepareStatement(query);
			statement.setString(1, cliente);
			
			ResultSet result = statement.executeQuery();
			
			while(result.next()) {
				composizione = new ComposizioneOrdineBean();
				composizione.setOrdine(result.getInt("ordine"));
				composizione.setCliente(result.getString("cliente"));
				composizione.setProdotto(result.getString("prodotto"));
				composizione.setTaglia(result.getString("taglia"));
				composizione.setQuantita(result.getInt("quantita"));
				composizione.setCosto(result.getBigDecimal("costo"));
				
				composizioniOrdini.add(composizione);
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
		
		return composizioniOrdini;
	}
}
