package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class ProdottoDAO extends AbstractDAO<ProdottoBean> {
	
	private static final String TABLE_NAME = "prodotto";
	
	@Override
	public synchronized void doSave(ProdottoBean bean) throws SQLException {
		Connection con = null;
		PreparedStatement statement = null;
		
		String query = "INSERT INTO " + ProdottoDAO.TABLE_NAME + 
					" (codiceSeriale,nome,brand,descrizioneBreve) VALUES (?,?,?,?);";
		
		try {
			con = DriverManagerConnectionPool.getConnection();
			statement = con.prepareStatement(query);
			
			statement.setString(1, bean.getCodiceSeriale());
			statement.setString(2, bean.getNome());
			statement.setString(3, bean.getBrand());
			statement.setString(4, bean.getDescrizioneBreve());
			
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
		Connection con = null;
		PreparedStatement statement = null;
		int result = 0;
		String query = "DELETE FROM " + ProdottoDAO.TABLE_NAME + " WHERE codiceSeriale = ?";
		
		try {
			con = DriverManagerConnectionPool.getConnection();
			statement = con.prepareStatement(query);
			statement.setString(1, key);
			
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
	public synchronized ProdottoBean doRetrieveByKey(String key) throws SQLException {
		Connection con = null;
		PreparedStatement statement = null;
		ProdottoBean prodotto = new ProdottoBean();
		
		String query = "SELECT * FROM " + ProdottoDAO.TABLE_NAME + " WHERE codiceSeriale = ?";
		
		try {
			con = DriverManagerConnectionPool.getConnection();
			statement = con.prepareStatement(query);
			statement.setString(1, key);
			
			ResultSet result = statement.executeQuery();
			
			while(result.next()) {
				prodotto.setCodiceSeriale(result.getString("codiceSeriale"));
				prodotto.setNome(result.getString("nome"));
				prodotto.setBrand(result.getString("brand"));
				prodotto.setDescrizioneBreve(result.getString("descrizioneBreve"));
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
		
		return prodotto;
	}

	@Override
	public synchronized List<ProdottoBean> doRetrieveAll(String order) throws SQLException {
		Connection con = null;
		PreparedStatement statement = null;
		
		List<ProdottoBean> prodotti = new ArrayList<>();
		
		String query = "SELECT * FROM " + ProdottoDAO.TABLE_NAME;
		
		try {
			con = DriverManagerConnectionPool.getConnection();
			statement = con.prepareStatement(query);
			
			ResultSet result = statement.executeQuery();
			
			while(result.next()) {
				ProdottoBean prodotto = new ProdottoBean();
				
				prodotto.setCodiceSeriale(result.getString("codiceSeriale"));
				prodotto.setNome(result.getString("nome"));
				prodotto.setBrand(result.getString("brand"));
				prodotto.setDescrizioneBreve(result.getString("descrizioneBreve"));
				
				prodotti.add(prodotto);
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
		
		return prodotti;
	}

	@Override
	public synchronized boolean doUpdate(ProdottoBean bean) throws SQLException {
		Connection con = null;
		PreparedStatement statement = null;
		int result = 0;
		
		String query = "UPDATE " + ProdottoDAO.TABLE_NAME + " SET "
				+ "nome = ?, brand = ?, descrizioneBreve = ? WHERE codiceSeriale = ?;";
		
		try {
			con = DriverManagerConnectionPool.getConnection();
			statement = con.prepareStatement(query);
			
			statement.setString(1, bean.getNome());
			statement.setString(2, bean.getBrand());
			statement.setString(3, bean.getDescrizioneBreve());
			statement.setString(4, bean.getCodiceSeriale());
			
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
	
	public synchronized List<ProdottoBean> searchBy(String search) throws SQLException {
		List<ProdottoBean> prodottiTrovati = new ArrayList<>();
		Connection con = null;
		PreparedStatement statement = null;
		
		String query = "SELECT " + ProdottoDAO.TABLE_NAME + ".* FROM " + ProdottoDAO.TABLE_NAME + " WHERE nome LIKE ? OR brand LIKE ?;";
		
		try {
			con = DriverManagerConnectionPool.getConnection();
			statement = con.prepareStatement(query);
			statement.setString(1, ("%" + search + "%"));
			statement.setString(2, ("%" + search + "%"));
			
			ResultSet result = statement.executeQuery();
			
			while(result.next()) {
				ProdottoBean prodotto = new ProdottoBean();
				
				prodotto.setCodiceSeriale(result.getString("codiceSeriale"));
				prodotto.setNome(result.getString("nome"));
				prodotto.setBrand(result.getString("brand"));
				prodotto.setDescrizioneBreve(result.getString("descrizioneBreve"));
				
				prodottiTrovati.add(prodotto);
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
		return prodottiTrovati;
	}

	public synchronized List<ProdottoBean> filterByBrand(String brand) throws SQLException{
		List<ProdottoBean> listaProdotti = new ArrayList<>();
		Connection con = null;
		PreparedStatement statement = null;
		
		String query = "SELECT * FROM " + ProdottoDAO.TABLE_NAME + " WHERE brand = ?";
		
		try {
			con = DriverManagerConnectionPool.getConnection();
			statement = con.prepareStatement(query);
			statement.setString(1, brand);
			
			ResultSet result = statement.executeQuery();
			
			while(result.next()) {
				ProdottoBean prodotto = new ProdottoBean();
				
				prodotto.setCodiceSeriale(result.getString("codiceSeriale"));
				prodotto.setNome(result.getString("nome"));
				prodotto.setBrand(result.getString("brand"));
				prodotto.setDescrizioneBreve(result.getString("descrizioneBreve"));
				
				listaProdotti.add(prodotto);
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
		return listaProdotti;
	}
	
	public synchronized boolean checkCodice(String codice) throws SQLException{
		boolean alreadyUsed = false;
		Connection con = null;
		PreparedStatement statement = null;

		String query = "SELECT * FROM " + ProdottoDAO.TABLE_NAME + " WHERE codiceSeriale = ?";

		try {
			con = DriverManagerConnectionPool.getConnection();
			statement = con.prepareStatement(query);

			statement.setString(1, codice);
			ResultSet result = statement.executeQuery();
			
			if(result.next()) {
				alreadyUsed = true;
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

		return alreadyUsed;
	}
	
}
