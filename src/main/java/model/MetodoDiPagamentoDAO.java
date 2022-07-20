package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MetodoDiPagamentoDAO extends AbstractDAO<MetodoDiPagamentoBean>{
	
	private static final String TABLE_NAME = "metododipagamento";
	
	@Override
	public synchronized void doSave(MetodoDiPagamentoBean bean) throws SQLException {
		Connection con = null;
		PreparedStatement statement = null;
		
		String query = "INSERT INTO " + MetodoDiPagamentoDAO.TABLE_NAME + 
					" (utente,nome,cognome,numCarta,dataScadenza,cvv,preferito) VALUES (?,?,?,?,?,?,?);";
		
		try {
			con = DriverManagerConnectionPool.getConnection();
			statement = con.prepareStatement(query);
			
			statement.setString(1, bean.getUtente());
			statement.setString(2, bean.getNome());
			statement.setString(3, bean.getCognome());
			statement.setString(4, bean.getNumCarta());
			statement.setString(5, bean.getDataScadenza());
			statement.setString(6, bean.getCvv());
			statement.setString(7, bean.getPreferito());
			
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
	public synchronized boolean doDelete(String key) throws SQLException {
		// TODO Auto-generated method stub
		return super.doDelete(key);
	}

	@Override
	public synchronized boolean doDelete(String key1, String key2) throws SQLException {
		Connection con = null;
		PreparedStatement statement = null;
		int result = 0;
		String query = "DELETE FROM " + MetodoDiPagamentoDAO.TABLE_NAME + " WHERE numPagamentoProgressivo = ? AND utente = ?";
		
		try {
			con = DriverManagerConnectionPool.getConnection();
			statement = con.prepareStatement(query);
			statement.setString(1, key1);
			statement.setString(2, key2);
			
			result = statement.executeUpdate();
			
			con.commit(); // togliere commento se vuoi cancellare davvero dal db ad ogni delete
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
	public synchronized MetodoDiPagamentoBean doRetrieveByKey(String key) throws SQLException {
		// TODO Auto-generated method stub
		return super.doRetrieveByKey(key);
	}

	@Override
	public synchronized MetodoDiPagamentoBean doRetrieveByKey(String key1, String key2) throws SQLException {
		Connection con = null;
		PreparedStatement statement = null;
		MetodoDiPagamentoBean pagamento = new MetodoDiPagamentoBean();
		
		String query = "SELECT * FROM " + MetodoDiPagamentoDAO.TABLE_NAME + " WHERE numPagamentoProgressivo = ? AND utente = ?";
		
		try {
			con = DriverManagerConnectionPool.getConnection();
			statement = con.prepareStatement(query);
			statement.setString(1, key1);
			statement.setString(2, key2);
			
			ResultSet result = statement.executeQuery();
			
			while(result.next()) {
				pagamento.setNumPagamentoProgressivo(result.getInt("numPagamentoProgressivo"));
				pagamento.setUtente(result.getString("utente"));
				pagamento.setNome(result.getString("nome"));
				pagamento.setCognome(result.getString("cognome"));
				pagamento.setNumCarta(result.getString("numCarta"));
				pagamento.setDataScadenza(result.getString("dataScadenza"));
				pagamento.setCvv(result.getString("cvv"));

				pagamento.setPreferito(result.getString("preferito"));
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
		
		return pagamento;
	}

	@Override
	public synchronized List<MetodoDiPagamentoBean> doRetrieveAll(String order) throws SQLException {
		Connection con = null;
		PreparedStatement statement = null;
		
		List<MetodoDiPagamentoBean> metodiPagamento = new ArrayList<>();
		
		String query = "SELECT * FROM " + MetodoDiPagamentoDAO.TABLE_NAME;
		
//		if(checkOrder(order)) {
//			query += " ORDER BY" + order;
//		}
//		se ne parla dopo TODO
		
		try {
			con = DriverManagerConnectionPool.getConnection();
			statement = con.prepareStatement(query);
			
			ResultSet result = statement.executeQuery();
			
			while(result.next()) {
				MetodoDiPagamentoBean pagamento = new MetodoDiPagamentoBean();
				
				pagamento.setNumPagamentoProgressivo(result.getInt("numPagamentoProgressivo"));

				pagamento.setUtente(result.getString("utente"));
				pagamento.setNome(result.getString("nome"));
				pagamento.setCognome(result.getString("cognome"));
				pagamento.setNumCarta(result.getString("numCarta"));
				pagamento.setDataScadenza(result.getString("dataScadenza"));
				pagamento.setCvv(result.getString("cvv"));
				pagamento.setPreferito(result.getString("preferito"));
				
				metodiPagamento.add(pagamento);
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
		
		return metodiPagamento;
	}

	@Override
	public synchronized boolean doUpdate(MetodoDiPagamentoBean bean) throws SQLException {
		Connection con = null;
		PreparedStatement statement = null;
		int result = 0;
		
		String query = "UPDATE " + MetodoDiPagamentoDAO.TABLE_NAME + " SET "
				+ " nome = ?, cognome = ?, numCarta = ?, dataScadenza = ?, "
				+ "cvv = ?,  preferito = ? WHERE numPagamentoProgressivo = ? AND utente = ?;";
		
		try {
			con = DriverManagerConnectionPool.getConnection();
			statement = con.prepareStatement(query);
			
			statement.setString(1, bean.getNome());
			statement.setString(2, bean.getCognome());
			statement.setString(3, bean.getNumCarta());
			statement.setString(4, bean.getDataScadenza());
			statement.setString(5, bean.getCvv());
			
			statement.setString(6, bean.getPreferito());
			statement.setInt(7, bean.getNumPagamentoProgressivo());
			statement.setString(8, bean.getUtente());
			
			
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

	@Override
	public synchronized List<MetodoDiPagamentoBean> doRetrieveAllByKey(String key) throws SQLException {
		Connection con = null;
		PreparedStatement statement = null;
		
		List<MetodoDiPagamentoBean> metodiPagamento = new ArrayList<>();
		
		String query = "SELECT * FROM " + MetodoDiPagamentoDAO.TABLE_NAME + " WHERE utente = ?;";
		
		
		try {
			con = DriverManagerConnectionPool.getConnection();
			statement = con.prepareStatement(query);
			
			statement.setString(1, key);
			
			ResultSet result = statement.executeQuery();
			
			while(result.next()) {
				MetodoDiPagamentoBean pagamento = new MetodoDiPagamentoBean();
				
				pagamento.setNumPagamentoProgressivo(result.getInt("numPagamentoProgressivo"));
				pagamento.setUtente(result.getString("utente"));
				pagamento.setNome(result.getString("nome"));
				pagamento.setCognome(result.getString("cognome"));
				pagamento.setNumCarta(result.getString("numCarta"));
				pagamento.setDataScadenza(result.getString("dataScadenza"));
				pagamento.setCvv(result.getString("cvv"));
				pagamento.setPreferito(result.getString("preferito"));
				pagamento.setPreferito(result.getString("preferito"));
				
				metodiPagamento.add(pagamento);
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
		
		return metodiPagamento;
	}
	
	
}
