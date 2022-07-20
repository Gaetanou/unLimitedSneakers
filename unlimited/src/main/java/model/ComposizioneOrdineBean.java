package model;

import java.io.Serializable;
import java.math.BigDecimal;

public class ComposizioneOrdineBean implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private int ordine;
	private String cliente;
	private String prodotto;
	private String taglia;
	private int quantita;
	private BigDecimal costo;
	
	public ComposizioneOrdineBean() {
		this.prodotto = "null";
		this.setTaglia("null");
		this.setCliente("null");
		this.ordine = -1;
		this.quantita = -1;
	}
	
	public String getProdotto() {
		return prodotto;
	}
	
	
	public int getOrdine() {
		return ordine;
	}


	public void setOrdine(int ordine) {
		this.ordine = ordine;
	}


	public void setProdotto(String prodotto) {
		this.prodotto = prodotto;
	}
	
	public int getQuantita() {
		return quantita;
	}
	
	public void setQuantita(int quantita) {
		this.quantita = quantita;
	}
	
	public BigDecimal getCosto() {
		return costo;
	}
	
	public void setCosto(BigDecimal costo) {
		this.costo = costo;
	}
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getCliente() {
		return cliente;
	}

	public void setCliente(String cliente) {
		this.cliente = cliente;
	}

	public String getTaglia() {
		return taglia;
	}

	public void setTaglia(String taglia) {
		this.taglia = taglia;
	}
	
	
}
