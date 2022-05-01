<jsp:include page="includes/header.jsp" />

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
	

<style>
body{
  min-height:1000px;
  background:gray;
  font-family:Arial;
}

topo{
  display:block;
  position:fixed;
  top:0;
  left:0;
  width:100%;
  background:white;
  text-align:center;
  padding: 20px 0;
  z-index: 7;
}


footer{
  display:block;
  position:fixed;
  width:100%;
  bottom:0vh;
  left:0;
  background:white;
  text-align:center;
  padding: 0px 0;
}

main{
  margin-top:80px;
  color:white;
}




body{
    background-color: #f4f7f6;
    margin-top:20px;
}
.card {
    background: #fff;
    transition: .5s;
    border: 0;
    margin-bottom: 30px;
    border-radius: .55rem;
    position: relative;
    width: 100%;
	box-shadow: 0 1px 2px 0 rgb(0 0 0 / 10%);
}
.chat-app .people-list {
    width: 280px;
    position: absolute;
    left: 0;
    top: 0;
    padding: 20px;
    z-index: 7
}

.chat-app .chat {
    margin-left: 280px;
    border-left: 1px solid #eaeaea
}

.people-list {
    -moz-transition: .5s;
    -o-transition: .5s;
    -webkit-transition: .5s;
    transition: .5s
}

.people-list .chat-list li {
    padding: 10px 15px;
    list-style: none;
    border-radius: 3px
}

.people-list .chat-list li:hover {
    background: #efefef;
    cursor: pointer
}

.people-list .chat-list li.active {
    background: #efefef
}

.people-list .chat-list li .name {
    font-size: 15px
}

.people-list .chat-list img {
    width: 45px;
    border-radius: 50%
}

.people-list img {
    float: left;
    border-radius: 50%
}

.people-list .about {
    float: left;
    padding-left: 8px
}

.people-list .status {
    color: #999;
    font-size: 13px
}

.chat .chat-header {
    padding: 15px 20px;
    border-bottom: 2px solid #f4f7f6
}

.chat .chat-header img {
    float: left;
    border-radius: 40px;
    width: 40px
}

.chat .chat-header .chat-about {
    float: left;
    padding-left: 10px
}

.chat .chat-history {
    padding: 20px;
    border-bottom: 2px solid #fff
}

.chat .chat-history ul {
    padding: 0
}

.chat .chat-history ul li {
    list-style: none;
    margin-bottom: 30px
}

.chat .chat-history ul li:last-child {
    margin-bottom: 0px
}

.chat .chat-history .message-data {
    margin-bottom: 15px
}

.chat .chat-history .message-data img {
    border-radius: 40px;
    width: 40px
}

.chat .chat-history .message-data-time {
    color: #434651;
    padding-left: 6px
}

.chat .chat-history .message {
    color: #444;
    padding: 18px 20px;
    line-height: 26px;
    font-size: 16px;
    border-radius: 7px;
    display: inline-block;
    position: relative
}

.chat .chat-history .message:after {
    bottom: 100%;
    left: 7%;
    border: solid transparent;
    content: " ";
    height: 0;
    width: 0;
    position: absolute;
    pointer-events: none;
    border-bottom-color: #fff;
    border-width: 10px;
    margin-left: -10px
}

.chat .chat-history .my-message {
    background: #efefef
}

.chat .chat-history .my-message:after {
    bottom: 100%;
    left: 30px;
    border: solid transparent;
    content: " ";
    height: 0;
    width: 0;
    position: absolute;
    pointer-events: none;
    border-bottom-color: #efefef;
    border-width: 10px;
    margin-left: -10px
}

.chat .chat-history .other-message {
    background: #e8f1f3;
    text-align: right
}

.chat .chat-history .other-message:after {
    border-bottom-color: #e8f1f3;
    left: 93%
}

.chat .chat-message {
    padding: 5px
}

.online,
.offline,
.me {
    margin-right: 2px;
    font-size: 8px;
    vertical-align: middle
}

.online {
    color: #86c541
}

.offline {
    color: #e47297
}

.me {
    color: #1d8ecd
}

.float-right {
    float: right
}

.clearfix:after {
    visibility: hidden;
    display: block;
    font-size: 0;
    content: " ";
    clear: both;
    height: 0
}

@media only screen and (max-width: 767px) {
    .chat-app .people-list {
        height: 465px;
        width: 100%;
        overflow-x: auto;
        background: #fff;
        left: -400px;
        display: none
    }
    .chat-app .people-list.open {
        left: 0
    }
    .chat-app .chat {
        margin: 0
    }
    .chat-app .chat .chat-header {
        border-radius: 0.55rem 0.55rem 0 0
    }
    .chat-app .chat-history {
        height: 300px;
        overflow-x: auto
    }
}

@media only screen and (min-width: 768px) and (max-width: 992px) {
    .chat-app .chat-list {
        height: 650px;
        overflow-x: auto
    }
    .chat-app .chat-history {
        height: 600px;
        overflow-x: auto
    }
}

@media only screen and (min-device-width: 768px) and (max-device-width: 1024px) and (orientation: landscape) and (-webkit-min-device-pixel-ratio: 1) {
    .chat-app .chat-list {
        height: 480px;
        overflow-x: auto
    }
    .chat-app .chat-history {
        height: calc(100vh - 350px);
        overflow-x: auto
    }
}
</style>

<script>
function redirecionar(site){
	window.location.href=site;
}

function amigoInicial(){
	if("${conversacomAmigo[0].de.id }" != "${usuarioSessao.id }"){
		idAmigoSelecionado =  "${conversacomAmigo[0].de.email }";
		document.getElementById("amigoSelecionado").value = "${conversacomAmigo[0].de.email }";
	} else{
		idAmigoSelecionado =  "${conversacomAmigo[0].para.email }";
		document.getElementById("amigoSelecionado").value = "${conversacomAmigo[0].para.email }";
	}
}

window.onload = function () {
	refresh();
	setInterval(refresh, 500);
	amigoInicial();
	
}
	


function refresh(){
	if(idAmigoSelecionado != ''){
		getMostrarConversas(idAmigoSelecionado);	
	}
}

</script>
<div class="chat" style="max-height:30%;position:relative; top:50px">
					<div class="chat-header clearfix">
						<div class="row">
							<div class="col-lg-6">
								<a href="javascript:void(0);" data-toggle="modal" data-target="#view_info">
									<img src="/assets/images/user.png">
								</a>
								<div class="chat-about">
									<c:if test="${conversacomAmigo == null }">
										<h6 class="m-b-0"><span id="nome_visto"></span>
											<a id="online_visto"></a>
										</h6>
										<small>Último visto: <span id="ultimoVisto_visto"></span></small>
									</c:if>
									<c:if test="${conversacomAmigo != null }">
										<c:if test="${conversacomAmigo[0].de.id != usuarioSessao.id }">
											<h6 class="m-b-0"><span id="nome_visto">${conversacomAmigo[0].de.nome }</span>
												<c:if test="${conversacomAmigo[0].de.online }">
													<a id="online_visto"><span style="color:#ACFA58" class="fa fa-circle"></span></a>
												</c:if>
												<c:if test="${!conversacomAmigo[0].de.online }">
													<a id="online_visto"><span style="color:#F78181" class="fa fa-circle"></span></a>
												</c:if>
											</h6>
											<fmt:parseDate value="${ conversacomAmigo[0].de.ultimoVisto }" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" type="both" />
											<small>Último visto: <span id="ultimoVisto_visto"><fmt:formatDate pattern="dd/MM/yyyy HH:mm" value="${ parsedDateTime }" /></span></small>
										</c:if>
										<c:if test="${conversacomAmigo[0].para.id != usuarioSessao.id }">
											<h6 class="m-b-0"><span id="nome_visto">${conversacomAmigo[0].para.nome }</span>
												<c:if test="${conversacomAmigo[0].para.online }">
													<a id="online_visto"><span style="color:#ACFA58" class="fa fa-circle"></span></a>
												</c:if>
												<c:if test="${!conversacomAmigo[0].para.online }">
													<a id="online_visto"><span style="color:#F78181" class="fa fa-circle"></span></a>
												</c:if>
											</h6>
											<fmt:parseDate value="${ conversacomAmigo[0].para.ultimoVisto }" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" type="both" />
											<small>Último visto: <span id="ultimoVisto_visto"><fmt:formatDate pattern="dd/MM/yyyy HH:mm" value="${ parsedDateTime }" /></span></small>
										</c:if>
									</c:if>
								</div>
							</div>
						</div>
					</div>
					<div class="chat-history">
						<ul id="listaChat" class="m-b-0">
							<c:if test="${conversacomAmigo == null }">
								<h3>Selecione / Adicione um contato.</h3>
							</c:if>
							<c:forEach items="${conversacomAmigo }" var="c">
								<c:if test="${c.de.id == usuarioSessao.id }">
									<li class="clearfix">
										<div class="message-data text-right">
											<fmt:parseDate value="${ c.envio }" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" type="both" />
											<span class="message-data-time"><fmt:formatDate pattern="dd/MM/yyyy HH:mm" value="${ parsedDateTime }" /></span>
										</div>
										<div class="message other-message float-right"> ${c.mensagem } </div>
									</li>
								</c:if>
								<c:if test="${c.de.id != usuarioSessao.id }">
									<li class="clearfix">
										<div class="message-data">
											<fmt:parseDate value="${ c.envio }" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" type="both" />
											<span class="message-data-time"><fmt:formatDate pattern="dd/MM/yyyy HH:mm" value="${ parsedDateTime }" /></span>
										</div>
										<div class="message my-message">${c.mensagem }</div>                                    
									</li>
								</c:if>
							</c:forEach>
						</ul>
					</div>
					<footer>
            		<div class="chat-message clearfix">
						<div class="input-group mb-0">
							<input type="text" id="suaMensagem" name="suaMensagem" class="form-control" placeholder="Insira a mensagem aqui...">
							<div onclick="enviar()" class="input-group-prepend">
								<span class="input-group-text"><i class="fa fa-paper-plane"></i></span>
							</div>                                    
						</div>
					</div>
				</footer>
				</div>
            

				<input type="hidden" id="amigoSelecionado" value="" />



<jsp:include page="includes/footer.jsp" />