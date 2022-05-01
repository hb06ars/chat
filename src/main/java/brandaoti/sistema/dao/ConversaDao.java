package brandaoti.sistema.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import brandaoti.sistema.model.Conversa;

public interface ConversaDao extends JpaRepository<Conversa, Integer> {
	@Query(" from Conversa where de.id = :id or para.id = :id order by envio asc")
	List<Conversa> minhasConversas(@Param("id") Integer id);
	
	@Query(" from Conversa where de.id = :id or para.id = :id order by envio desc")
	List<Conversa> minhaUltimaConversa(@Param("id") Integer id);
	
	@Query(" from Conversa where (de.id = :meuId or para.id = :meuId) and (de.id = :IdAmigo or para.id = :IdAmigo) order by envio asc")
	List<Conversa> conversacomAmigo(@Param("meuId") Integer meuId, @Param("IdAmigo") Integer IdAmigo);
}
