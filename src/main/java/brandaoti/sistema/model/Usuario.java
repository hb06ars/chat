package brandaoti.sistema.model;

import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;

import org.hibernate.annotations.FetchMode;

@Entity
public class Usuario {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id; //Esse número é o ID automático gerado.
	
	@Column
	private Boolean ativo = true;

	@Column
	private Boolean online = false;
	
	@Column
	private String nome;
	
	@Column
	private String email;
	
	@Column
	private String senha;
	
	@ManyToMany
	private List<Usuario> amigos;
	
	@Column
	private LocalDateTime ultimoVisto = LocalDateTime.now();
	
	@ManyToMany
	(fetch = FetchType.EAGER)
	private List<Conversa> conversas;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Boolean getOnline() {
		return online;
	}

	public void setOnline(Boolean online) {
		this.online = online;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getSenha() {
		return senha;
	}

	public void setSenha(String senha) {
		this.senha = senha;
	}

	public List<Usuario> getAmigos() {
		return amigos;
	}

	public void setAmigos(List<Usuario> amigos) {
		this.amigos = amigos;
	}

	public LocalDateTime getUltimoVisto() {
		return ultimoVisto;
	}

	public void setUltimoVisto(LocalDateTime ultimoVisto) {
		this.ultimoVisto = ultimoVisto;
	}

	
	public Boolean getAtivo() {
		return ativo;
	}

	public void setAtivo(Boolean ativo) {
		this.ativo = ativo;
	}

	public List<Conversa> getConversas() {
		return conversas;
	}

	public void setConversas(List<Conversa> conversas) {
		this.conversas = conversas;
	}
	
	
	
	
}
