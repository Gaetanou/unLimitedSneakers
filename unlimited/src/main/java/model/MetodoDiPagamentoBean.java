package model;

import java.io.Serializable;

public class MetodoDiPagamentoBean implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private int numPagamentoProgressivo;
	private String utente;
	private String nome;
	private String cognome;
	private String numCarta;
	private String dataScadenza;
	private String cvv;
	private String preferito;
	
	public MetodoDiPagamentoBean() {
		this.numPagamentoProgressivo = -1;
		this.utente = "null";
		this.nome = "null";
		this.cognome = "null";
		this.numCarta = "null";
		this.dataScadenza = "null";
		this.cvv = "null";
		this.preferito = "null";
	}

	public int getNumPagamentoProgressivo() {
		return numPagamentoProgressivo;
	}

	public void setNumPagamentoProgressivo(int numPagamentoProgressivo) {
		this.numPagamentoProgressivo = numPagamentoProgressivo;
	}

	public String getUtente() {
		return utente;
	}

	public void setUtente(String utente) {
		this.utente = utente;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getCognome() {
		return cognome;
	}

	public void setCognome(String cognome) {
		this.cognome = cognome;
	}

	public String getDataScadenza() {
		return dataScadenza;
	}

	public void setDataScadenza(String dataScadenza) {
		this.dataScadenza = dataScadenza;
	}

	public String getCvv() {
		return cvv;
	}

	public void setCvv(String cvv) {
		this.cvv = cvv;
	}
	
	public String getNumCarta() {
		return numCarta;
	}

	public void setNumCarta(String numCarta) {
		this.numCarta = numCarta;
	}

	public String getPreferito() {
		return preferito;
	}

	public void setPreferito(String preferito) {
		this.preferito = preferito;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}
