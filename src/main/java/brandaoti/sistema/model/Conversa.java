package brandaoti.sistema.model;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;

@Entity
public class Conversa {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id; //Esse número é o ID automático gerado.
	
	@OneToOne
	private Usuario de;
	
	@OneToOne
	private Usuario para;
	
	@Column
	private LocalDateTime envio = LocalDateTime.now();
	
	@Column
	private Boolean visualizado = false;

	@Column
	private String mensagem;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Usuario getDe() {
		return de;
	}

	public void setDe(Usuario de) {
		this.de = de;
	}

	public Usuario getPara() {
		return para;
	}

	public void setPara(Usuario para) {
		this.para = para;
	}

	public LocalDateTime getEnvio() {
		return envio;
	}

	public void setEnvio(LocalDateTime envio) {
		this.envio = envio;
	}

	public Boolean getVisualizado() {
		return visualizado;
	}

	public void setVisualizado(Boolean visualizado) {
		this.visualizado = visualizado;
	}

	public String getMensagem() {
		return mensagem;
	}

	public void setMensagem(String mensagem) {
		this.mensagem = mensagem;
	}
	
	
	
	
	
}
