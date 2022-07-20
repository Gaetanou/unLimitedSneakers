package model;

import java.io.Serializable;

public class ProdottoBean implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String codiceSeriale;
	private String nome;
	private String brand;
	private String descrizioneBreve;
	
	public ProdottoBean() {
		this.codiceSeriale = "null";
		this.nome = "null";
		this.brand = "null";
		this.descrizioneBreve = "null";
	}

	public String getCodiceSeriale() {
		return codiceSeriale;
	}

	public void setCodiceSeriale(String codiceSeriale) {
		this.codiceSeriale = codiceSeriale;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getDescrizioneBreve() {
		return descrizioneBreve;
	}

	public void setDescrizioneBreve(String descrizioneBreve) {
		this.descrizioneBreve = descrizioneBreve;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	public boolean equals(Object obj) {
		if (obj == null) {
		return false;
		}

		if (!(obj instanceof ProdottoBean)) {
		return false;
		}

		ProdottoBean p = (ProdottoBean) obj;
		return p.codiceSeriale.equals(this.codiceSeriale);
		}
	
	
}
