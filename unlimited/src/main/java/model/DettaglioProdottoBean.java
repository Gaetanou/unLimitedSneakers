package model;

import java.io.Serializable;
import java.math.BigDecimal;

public class DettaglioProdottoBean implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String taglia;
	private String prodotto;
	private BigDecimal costo;
	private int quantita;
	private String categoria;
	 
	
	public DettaglioProdottoBean() {
		this.taglia = "null";
		this.prodotto = "null";
		this.costo = BigDecimal.valueOf(-1);
		this.quantita = -1;
		this.categoria= "null";
	}

	public String getTaglia() {
		return taglia;
	}

	public void setTaglia(String taglia) {
		this.taglia = taglia;
	}

	public String getProdotto() {
		return prodotto;
	}

	public void setProdotto(String prodotto) {
		this.prodotto = prodotto;
	}

	public BigDecimal getCosto() {
		return costo;
	}

	public void setCosto(BigDecimal costo) {
		this.costo = costo;
	}
	
	public int getQuantita() {
		return quantita;
	}

	public void setQuantita(int quantita) {
		this.quantita = quantita;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getCategoria() {
		return categoria;
	}

	public void setCategoria(String categoria) {
		this.categoria = categoria;
	}
	
	
}
