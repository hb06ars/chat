<!DOCTYPE html>

<html>
    <head>
        <meta charset="utf-8">
       	<meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Sistema para Senhas">
        <meta name="author" content="Henrique Brandão">
        <meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="shortcut icon" href="/assets/images/avatar-1.jpg">
        <title>Chat</title>
        
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
	    <link rel="stylesheet" href="/css/style3.css">
	    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css">
	    <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/solid.js" integrity="sha384-tzzSw1/Vo+0N5UhStP3bvwWPq+uvzCMfrN1fEFe+xBmv1C/AtVX5K0uZtmcHitFZ" crossorigin="anonymous"></script>
	    <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/fontawesome.js" integrity="sha384-6OIrr52G08NpOFSZdxxz1xdNSndlD4vdcf/q2myIUVO0VsqaGHJsB0RaBE01VTOY" crossorigin="anonymous"></script>
	        
        <link rel="shortcut icon" href="/assets/images/avatar-1.jpg">
		<script src="assets/outros/jqueryLoader.min.js"></script>
        
        <script>
			//Loading ---------------------------------------
			jQuery(function($){
				$(".loader").fadeOut("slow"); //retire o delay quando for copiar!
			});
			// Loading ---------------------------------------
		</script>

	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
	<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
	<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

    </head>
    
    <style>
    .loader {
			position: fixed;
			left: 0px;
			top: 0px;
			width: 100%;
			height: 100%;
			z-index: 9999;
			background-color: white;
		}
	</style>

	<script>
	
	function filtrar(){
		let filtro = document.getElementById("email_amigo").value;
		if(filtro != ""){
			<c:if test="${usuarioSessao != null && usuarioSessao.amigos != null && usuarioSessao.amigos.size() > 0 }">
				<c:forEach items="${usuarioSessao.amigos }" var="u">
					if("reg_${u.nome}#${u.email}".includes(filtro)){
						document.getElementById("reg_${u.nome}#${u.email}").style.display = "block";
					} else{
						document.getElementById("reg_${u.nome}#${u.email}").style.display = "none";
					}
				</c:forEach>
			</c:if>	
		}
	}
	
	
	function add(){
		var amigo = document.getElementById("email_amigo").value;
		document.getElementById("email_amigo").value = "";
		getAdicionar(amigo);
	}
	
	function preenchendoLista(json){
		requisicoesFinalizar = 0;
		var result = JSON.parse(json);
		var objeto = {}
		document.getElementById("listaAmigos").innerHTML = '';
		document.getElementById("listaAmigos").innerHTML = "<li> <div class='input-group mb-3' style='padding:10px'> <input onkeyup='filtrar()' onchange='filtrar()' type='text' class='form-control' aria-label='hidden' name='email_amigo' id='email_amigo'> <div class='input-group-prepend'>   <span onclick='add()' class='input-group-text'><i class='fa fa-plus'></i></span> </div> </div> </li>";
		for (var i = 0, emp; i < result["usuarios"].length; i++) {
			emp = result["usuarios"][i];
			valores = '';
			valores = valores + "<li onclick='verAmigo(\"reg_"+emp.descricao+"#"+emp.id+"#"+emp.online+"#"+emp.ultimoVisto+"\")' id='reg_"+emp.descricao+"#"+emp.id+"' style='cursor:pointer'>";
			if(emp.online == "true"){
				valores = valores + "<a style='color:#ACFA58' ><span class='fa fa-user'></span>&nbsp "+emp.descricao+"</a>";
			} else{
				valores = valores + "<a style='color:#F78181' ><span class='fa fa-user'></span>&nbsp "+emp.descricao+"</a>";
			}
			valores = valores + "</li>";
			document.getElementById("listaAmigos").innerHTML = document.getElementById("listaAmigos").innerHTML + valores;
		}
	}
	
	
	// AJAX ------------------------------------------------------------------------------------
	// Requisicao no AJAX ----------------------------------------------------------------------
	var request = null;
	  function createRequest() {
	    try {
	      request = new XMLHttpRequest();
	    } catch (trymicrosoft) {
	      try {
	        request = new ActiveXObject("Msxml2.XMLHTTP");
	      } catch (othermicrosoft) {
	        try {
	          request = new ActiveXObject("Microsoft.XMLHTTP");
	        } catch (failed) {
	          request = null;
	        }
	      }
	    }
	    if (request == null)
	      alert("Erro na requisição.");
	  }
	//Requisicao no AJAX ------------------------------------------------------------------------------------
	
	
	// Add user ------------------------------------------------------------------------------------
	var requisicoesAddUser = 0;
	function getAdicionar(conteudo) {
		if(requisicoesAddUser == 0){
			createRequest();
			var url = "/adicionar_{"+conteudo+"}";
			request.open("GET", url, true);
			request.onreadystatechange = atualizaPaginaAddUser;
			request.send(null);
			requisicoesAddUser = 0;
		}
	}
	function atualizaPaginaAddUser() {
		if (request.readyState == 4) {
			var respostaDoServidor = request.responseText;
			preenchendoLista(respostaDoServidor);
		}
	}
	//Add user ------------------------------------------------------------------------------------

	
	function verAmigo(amigo){
		document.getElementById("amigoSelecionado").value = amigo;
		idAmigoSelecionado = amigo;
		var valores = amigo.replaceAll("reg_","").split("#");
		document.getElementById("nome_visto").innerHTML = valores[0]; 
		if(valores[2] == "true"){ 
			document.getElementById("online_visto").innerHTML = "<span style='color:#ACFA58' class='fa fa-circle'></span></a>"
		} else{
			document.getElementById("online_visto").innerHTML = "<span style='color:#F78181' class='fa fa-circle'></span></a>"
		}
		var data = valores[3].replaceAll('T',' ').split(".")[0].split(" ");
		var dmy = data[0].split("-")[2] + '/' + data[0].split("-")[1] + '/' + data[0].split("-")[0];
		document.getElementById("ultimoVisto_visto").innerHTML = dmy + ' ' + data[1];
		preencherConversa(valores[1]);
	}
	
	
	
	function preencherConversa(email){
		document.getElementById("listaChat").innerHTML = '';
		getMostrarConversas(email);
	}
	
	// Ajax Mostrar Conversas ----------------------
	var requisicoesMostrarCv = 0;
	function getMostrarConversas(conteudo) {
		idAmigoSelecionado =  conteudo;
		if(requisicoesMostrarCv == 0){
			createRequest();
			var url = "/mostrarConversas_{"+conteudo+"}";
			request.open("GET", url, true);
			request.onreadystatechange = atualizaPaginaMostrarCv;
			request.send(null);
			requisicoesMostrarCv = 0;
		}
	}
	function atualizaPaginaMostrarCv() {
		if (request.readyState == 4) {
			var respostaDoServidor = request.responseText;
			preenchendoConversas(respostaDoServidor);
		}
	}
	
	function preenchendoConversas(json){
		requisicoesPreencherConversa = 0;
		if(json != '{}' && requisicoesPreencherConversa == 0){
			var result = JSON.parse(json);
			var objeto = {};
			var valores = '';
			var data = '';
			var dmy = '';
			if(result != null && result["mensagens"] != null){
				for (var i = 0, emp; i < result["mensagens"].length; i++) {
					emp = result["mensagens"][i];
					data = emp.envio.replaceAll('T',' ').split(".")[0].split(" ");
					dmy = data[0].split("-")[2] + '/' + data[0].split("-")[1] + '/' + data[0].split("-")[0];
					strData = dmy + ' ' + data[1];
					if(emp.de == "${usuarioSessao.id}"){
						valores = valores + "<li class='clearfix'> <div class='message-data text-right'> <span class='message-data-time'>"+strData+"</span> </div> <div class='message other-message float-right'> "+emp.mensagem+" </div> </li> ";
					}
					if(emp.para == "${usuarioSessao.id}"){
						valores = valores + "<li class='clearfix'> <div class='message-data'> <span class='message-data-time'>"+strData+"</span> </div> <div class='message other-message'> "+emp.mensagem+" </div> </li> ";
					}
					document.getElementById("listaChat").innerHTML = valores;
				}	
			}
		}
	}
	
	var idAmigoSelecionado = '';
	function enviar(){
		var msg = document.getElementById("suaMensagem").value;
		document.getElementById("suaMensagem").value = '';
		document.getElementById("suaMensagem").focus();
		getSalvarMensagem(idAmigoSelecionado, msg);
		getMostrarConversas(idAmigoSelecionado);
	}
	// Ajax Mostrar Conversas ----------------------
	
	
	// Salvar Mensagem ------------------------------------------------------------------------------------
	var requisicoesSalvarMsg = 0;
	function getSalvarMensagem(emailAmigo, msg) {
		if(requisicoesSalvarMsg == 0){
			createRequest();
			var url = "/emailAmigo_{"+emailAmigo+"}_msg_{"+msg+"}";
			request.open("GET", url, true);
			request.onreadystatechange = atualizaPaginaSalvarMsg;
			request.send(null);
			requisicoesSalvarMsg = 0;
		}
	}
	function atualizaPaginaSalvarMsg() {
		if (request.readyState == 4) {
			var respostaDoServidor = request.responseText;
		}
	}
	// Salvar Mensagem ------------------------------------------------------------------------------------
	
	
	
	
	
	</script>

    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
	<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
	<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
	
	<jsp:include page="mensagens.jsp" />    
    <jsp:include page="javaScript.jsp" />
    
    
    <body class="fixed-left" onload="iniciando()" >
    
    	<div id="loader" class="loader">
				<div class="col-sm-12 text-center" style="top:30%; color: #302010">
					<div class="col-sm-12 text-center">
						<img src="/assets/images/avatar-1.webp" onerror="this.src='/assets/images/avatar-1.jpg" style="max-width:100px" />
						<br>
						Aguarde...
						<br>
					</div>
					<div class="col-sm-12 text-center">
						<span class='fa fa-spinner fa-spin fa-2x'></span>
					</div>
				</div>
		</div>
		

    <div class="wrapper">
        <!-- Sidebar  -->
        <nav id="sidebar">
            <div id="dismiss">
                <i class="fas fa-arrow-left"></i>
            </div>

            <div class="sidebar-header">
                <span>${usuarioSessao.nome }</span>
            </div>

            <ul id="listaAmigos" class="list-unstyled components">
            	<li>
                   <div class="input-group mb-3" style="padding:10px">
					  <input onkeyup="filtrar()" onchange="filtrar()" type="text" class="form-control" aria-label="hidden" name="email_amigo" id="email_amigo">
					  <div class="input-group-prepend">
					    <span onclick="add()" class="input-group-text"><i class="fa fa-plus"></i></span>
					  </div>
					</div>
                </li>
            	<c:forEach items="${usuarioSessao.amigos }" var="a">
	                <li onclick="verAmigo('reg_${a.nome}#${a.email}#${a.online}#${a.ultimoVisto}')" id="reg_${a.nome}#${a.email}" style="cursor:pointer">
	                	<c:if test="${a.online }">
	                		<a style="color:#ACFA58" ><span class="fa fa-user"></span>&nbsp ${a.nome }</a>
	                	</c:if>
	                	<c:if test="${!a.online }">
	                		<a style="color:#F78181" ><span class="fa fa-user"></span>&nbsp ${a.nome }</a>
	                	</c:if>
	                </li>
                </c:forEach>
            </ul>
            <div class="sidebar-header">
                <a href="/deslogar"><span class="fa fa-power-off"></span> &nbsp Sair</a>
            </div>
        </nav>

        <!-- Page Content  -->
        <div id="content">
        	<topo>
	            <nav style="top:0; position:absolute; min-width:100%" class="navbar navbar-expand-lg navbar-light bg-light">
	                <div class="container-fluid">
	                    <button type="button" id="sidebarCollapse" class="btn btn-info">
	                        <span>Contatos</span>
	                    </button>
	                </div>
	            </nav>
            </topo>
