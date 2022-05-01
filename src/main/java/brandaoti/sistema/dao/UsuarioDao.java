package brandaoti.sistema.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import brandaoti.sistema.model.Usuario;

public interface UsuarioDao extends JpaRepository<Usuario, Integer> {
	
	@Query(" from Usuario u where u.ativo = true and u.email = :email and u.senha = :senha")
	Usuario logar(@Param("email") String email, @Param("senha") String senha);
	
	@Query(" from Usuario u where u.ativo = true and LOWER(u.email) = LOWER(:email)")
	Usuario encontrarAmigo(@Param("email") String email);
	
}
