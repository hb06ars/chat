package brandaoti.sistema.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import brandaoti.sistema.dao.ConversaDao;
import brandaoti.sistema.dao.UsuarioDao;
import brandaoti.sistema.model.Conversa;
import brandaoti.sistema.model.Usuario;


@RestController
@RequestMapping("/")
@CrossOrigin("*")
public class SistemaController extends HttpServlet {
		private static final long serialVersionUID = 1L;
		@Autowired
		UsuarioDao usuarioDao;
		@Autowired
		ConversaDao conversaDao;
		
		@RequestMapping(value = {"/","/index"}, produces = "text/plain;charset=UTF-8", method = RequestMethod.GET) // Pagina de Vendas
		public void login(HttpServletRequest request, HttpServletResponse response, @RequestParam(value = "nome", required = false, defaultValue = "Henrique Brandão") String nome) throws SQLException, ServletException, IOException { //Funcao e alguns valores que recebe...
			/* 
			if(usuarioDao.findAll().size() == 0) {
				Usuario u = new Usuario();
				u.setEmail("Administrador");
				u.setNome("Administrador");
				u.setSenha("123");
				usuarioDao.save(u);
				
				Usuario u2 = new Usuario();
				u2.setEmail("Mah");
				u2.setNome("Mah");
				u2.setSenha("123");
				usuarioDao.save(u2);
				
				Usuario u3 = new Usuario();
				u3.setEmail("Henrique");
				u3.setNome("Henrique");
				u3.setSenha("123");
				usuarioDao.save(u3);
				
				List<Usuario> listaU = new ArrayList<Usuario>();
				listaU.add(u2);
				u3.setAmigos(listaU);
				usuarioDao.save(u3);
				
				Conversa msgParaUser = new Conversa();
				msgParaUser.setDe(u3);
				msgParaUser.setPara(u2);
				msgParaUser.setMensagem("Olá tudo bem?");
				msgParaUser.setEnvio(LocalDateTime.now());
				conversaDao.save(msgParaUser);
				
				Conversa msgDeUser = new Conversa();
				msgDeUser.setDe(u2);
				msgDeUser.setPara(u3);
				msgDeUser.setMensagem("Blz e voce?!");
				msgDeUser.setEnvio(LocalDateTime.now());
				conversaDao.save(msgDeUser);
				
				List<Conversa> lista_cv = new ArrayList<Conversa>();
				lista_cv.add(msgParaUser);
				lista_cv.add(msgDeUser);
				u3.setConversas(lista_cv);
				usuarioDao.save(u3);
				
			} */
			
			HttpSession session = request.getSession();
			if(session.getAttribute("usuarioSessao") != null) {
				response.sendRedirect("/home");
			} else {
				request.getRequestDispatcher("/WEB-INF/jsp/index.jsp").forward(request, response); //retorna a variavel
			}
		}
		
		@RequestMapping(value = {"/","/index"}, produces = "text/plain;charset=UTF-8", method = {RequestMethod.POST}) // Pagina de Vendas
		public void index_post(HttpServletRequest request, HttpServletResponse response, @RequestParam(value = "tipo", defaultValue = "") String tipo, @RequestParam(value = "email", defaultValue = "") String email, @RequestParam(value = "senha", defaultValue = "") String senha) throws SQLException, ServletException, IOException {
			HttpSession session = request.getSession();
			String link = "index";
			Usuario u = usuarioDao.logar(email, senha);
			if(tipo.equals("logar")){
				if(u != null && u.getId() != null) {
					u.setOnline(true);
					usuarioDao.save(u);
					session.setAttribute("usuarioSessao",u);
					link = "pages/home";
					try {
						Conversa ultimaConversa = conversaDao.minhaUltimaConversa(u.getId()).get(0);
						Integer idAmigo = 0;
						if(ultimaConversa.getDe().getId() != u.getId()) {
							idAmigo = ultimaConversa.getDe().getId();
						} else {
							idAmigo = ultimaConversa.getPara().getId();
						}
						List<Conversa> conversacomAmigo = conversaDao.conversacomAmigo(u.getId(), idAmigo);
						request.setAttribute("conversacomAmigo", conversacomAmigo);
					} catch(Exception e) {
					}
				} else {
					request.setAttribute("mensagem", "Login inválido / Inativo.");
				}
			} else {
				if(u == null) {
					link = "pages/home";
					Usuario usu = new Usuario();
					usu.setNome(email);
					usu.setEmail(email);
					usu.setSenha(senha);
					usu.setOnline(true);
					usu.setUltimoVisto(LocalDateTime.now());
					usuarioDao.save(usu);
					session.setAttribute("usuarioSessao",usu);
				} else {
					request.setAttribute("mensagem", "O usuário já existe.");
				}
			}
			request.getRequestDispatcher("/WEB-INF/jsp/"+link+".jsp").forward(request, response); //retorna a variavel
		}
		
		@RequestMapping(value = "/deslogar", method = {RequestMethod.GET}) // Link que irÃ¡ acessar...
		public void deslogar(HttpServletRequest request, HttpServletResponse response ) throws IOException { //Funcao e alguns valores que recebe...
			HttpSession session = request.getSession();
			Usuario sessao = (Usuario) session.getAttribute("usuarioSessao");
			sessao.setOnline(false);
			usuarioDao.save(sessao);
			session.invalidate();
			response.sendRedirect("/");
		}
		
		
		@RequestMapping(value = {"/home"}, produces = "text/plain;charset=UTF-8", method = {RequestMethod.GET}) // Pagina de Vendas
		public void home(HttpServletRequest request, HttpServletResponse response, @RequestParam(value = "nome", defaultValue = "") String usuarioVal, @RequestParam(value = "senhaVal", defaultValue = "") String senhaVal) throws SQLException, ServletException, IOException {
			HttpSession session = request.getSession();
			String link = "pages/deslogar";
			if(session.getAttribute("usuarioSessao") != null) {
				Usuario sessao = (Usuario) session.getAttribute("usuarioSessao");
				link = "pages/home";
				try {
					Conversa ultimaConversa = conversaDao.minhaUltimaConversa(sessao.getId()).get(0);
					Integer idAmigo = 0;
					if(ultimaConversa.getDe().getId() != sessao.getId()) {
						idAmigo = ultimaConversa.getDe().getId();
					} else {
						idAmigo = ultimaConversa.getPara().getId();
					}
					List<Conversa> conversacomAmigo = conversaDao.conversacomAmigo(sessao.getId(), idAmigo);
					request.setAttribute("conversacomAmigo", conversacomAmigo);
				} catch(Exception e) {
				}
			}
			request.getRequestDispatcher("/WEB-INF/jsp/"+link+".jsp").forward(request, response); //retorna a variavel
		}
		
		@RequestMapping(value = {"/adicionar_{amigo}"}, produces = "text/plain;charset=UTF-8", method = {RequestMethod.GET, RequestMethod.POST}) // Pagina de Vendas
		public String adicionar(HttpServletRequest request, HttpServletResponse response, @PathVariable(value = "amigo") String amigo) throws SQLException, ServletException, IOException {
			String json = "";
			HttpSession session = request.getSession();
			if(session.getAttribute("usuarioSessao") != null) {
				Usuario usuarioSessao = (Usuario) session.getAttribute("usuarioSessao");
				amigo = amigo.replace("{", "").replace("}", "");
				Usuario u = usuarioDao.encontrarAmigo(amigo);
				Boolean jaTenhoComoAmigo = false;
				if(u != null && u.getId() != null) {
					if(usuarioSessao.getAmigos() != null && usuarioSessao.getAmigos().size() > 0) {
						for(Usuario meusAmigos : usuarioSessao.getAmigos()) {
							if(meusAmigos.getId() == u.getId()) {
								jaTenhoComoAmigo = true;
							}
						}
						if(!jaTenhoComoAmigo) {
							usuarioSessao.getAmigos().add(u);
							usuarioDao.save(usuarioSessao);
						}
					} else {
						List<Usuario> listaA = new ArrayList<Usuario>();
						listaA.add(u);
						usuarioSessao.setAmigos(listaA);
						usuarioDao.save(usuarioSessao);
					}
					
					jaTenhoComoAmigo = false;
					if(u.getAmigos() != null && u.getAmigos().size() > 0) {
						for(Usuario meusAmigosB : u.getAmigos()) {
							if(meusAmigosB.getId() == usuarioSessao.getId()) {
								jaTenhoComoAmigo = true;
							}
						}
						if(!jaTenhoComoAmigo) {
							u.getAmigos().add(usuarioSessao);
							usuarioDao.save(u);
						}
					} else {
						List<Usuario> listaB = new ArrayList<Usuario>();
						listaB.add(usuarioSessao);
						u.setAmigos(listaB);
						usuarioDao.save(u);
					}
					
					
					
				}
				JSONObject jsonObj = new JSONObject();
				try {
					JSONObject usuarios = new JSONObject();
					for(Usuario amigo_obj : usuarioSessao.getAmigos()) {
						usuarios = new JSONObject();
						usuarios.put("id", amigo_obj.getEmail());
						usuarios.put("descricao", amigo_obj.getNome());
						usuarios.put("online", amigo_obj.getOnline());
						usuarios.put("ultimoVisto", amigo_obj.getUltimoVisto());
						jsonObj.append("usuarios", usuarios);
					}
				} catch (JSONException e) {
					e.printStackTrace();
				}
				json = ""+jsonObj;
			}
			return json;
		}

		
		
		@RequestMapping(value = {"/mostrarConversas_{email}"}, produces = "text/plain;charset=UTF-8", method = {RequestMethod.GET, RequestMethod.POST}) // Pagina de Vendas
		public String mostrarConversas(HttpServletRequest request, HttpServletResponse response, @PathVariable(value = "email") String email) throws SQLException, ServletException, IOException {
			String json = "";
			HttpSession session = request.getSession();
			if(session.getAttribute("usuarioSessao") != null) {
				Usuario usuarioSessao = (Usuario) session.getAttribute("usuarioSessao");
				email = email.replace("{", "").replace("}", "");
				Usuario u = usuarioDao.encontrarAmigo(email);
				List<Conversa> conversas = conversaDao.conversacomAmigo(usuarioSessao.getId(), u.getId());
				if(u != null && u.getId() != null) {
					JSONObject jsonObj = new JSONObject();
					try {
						JSONObject mensagens = new JSONObject();
						for(Conversa conversa_obj : conversas) {
							mensagens = new JSONObject();
							mensagens.put("de", conversa_obj.getDe().getId());
							mensagens.put("para", conversa_obj.getPara().getId());
							mensagens.put("mensagem", conversa_obj.getMensagem());
							mensagens.put("envio", conversa_obj.getEnvio());
							jsonObj.append("mensagens", mensagens);
						}
					} catch (JSONException e) {
						e.printStackTrace();
					}
					json = ""+jsonObj;
				}
			}
			return json;
		}
		
		
		
		@RequestMapping(value = {"/emailAmigo_{emailAmigo}_msg_{msg}"}, produces = "text/plain;charset=UTF-8", method = {RequestMethod.GET}) // Pagina de Vendas
		public void salvarConversa(HttpServletRequest request, HttpServletResponse response, @PathVariable(value = "emailAmigo") String emailAmigo, @PathVariable(value = "msg") String msg) throws SQLException, ServletException, IOException {
			String json = "";
			HttpSession session = request.getSession();
			if(session.getAttribute("usuarioSessao") != null) {
				Usuario usuarioSessao = (Usuario) session.getAttribute("usuarioSessao");
				emailAmigo = emailAmigo.replace("{", "").replace("}", "");
				msg = msg.replace("{", "").replace("}", "");
				Usuario u = usuarioDao.encontrarAmigo(emailAmigo);
				if(u != null && u.getId() != null) {
					Conversa cv = new Conversa();
					cv.setDe(usuarioSessao);
					cv.setPara(u);
					cv.setMensagem(msg);
					cv.setEnvio(LocalDateTime.now());
					conversaDao.save(cv);
					
					if(usuarioSessao.getConversas() != null && usuarioSessao.getConversas().size() > 0) {
						usuarioSessao.getConversas().add(cv);
					} else {
						List<Conversa> listaSess = new ArrayList<Conversa>();
						listaSess.add(cv);
						usuarioSessao.setConversas(listaSess);
					}
					usuarioDao.save(usuarioSessao);
					
					if(u.getConversas() != null && u.getConversas().size() > 0) {
						u.getConversas().add(cv);
					} else {
						List<Conversa> lista = new ArrayList<Conversa>();
						lista.add(cv);
						u.setConversas(lista);
					}
					usuarioDao.save(u);
					
				}
			}
		}
		
		
}
	
	
	




