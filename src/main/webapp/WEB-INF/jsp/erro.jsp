<!DOCTYPE html>
<html>

<head>
    
    <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Chat">
    <meta name="author" content="Henrique Brandão">
    <meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <link rel="shortcut icon" href="/assets/images/avatar-1.jpg">

    <title>Chat</title>
    <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="assets/css/core.css" rel="stylesheet" type="text/css" />
    <link href="assets/css/components.css" rel="stylesheet" type="text/css" />
    <link href="assets/css/icons.css" rel="stylesheet" type="text/css" />
    <link href="assets/css/pages.css" rel="stylesheet" type="text/css" />
    <link href="assets/css/responsive.css" rel="stylesheet" type="text/css" />
	<script src="assets/outros/jqueryLoader.min.js"></script>
		
    <script>
    function goBack() {
    	window.history.back();
    }
    
			//Loading ---------------------------------------
			jQuery(function($){
				$(".loader").fadeOut("slow"); //retire o delay quando for copiar!
			});
			// Loading ---------------------------------------
	</script>
	
    
    <!-- Bootstrap CSS CDN -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
    <!-- Our Custom CSS -->
    <link rel="stylesheet" href="/css/style3.css">
    <!-- Scrollbar Custom CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css">

    <!-- Font Awesome JS -->
    <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/solid.js" integrity="sha384-tzzSw1/Vo+0N5UhStP3bvwWPq+uvzCMfrN1fEFe+xBmv1C/AtVX5K0uZtmcHitFZ" crossorigin="anonymous"></script>
    <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/fontawesome.js" integrity="sha384-6OIrr52G08NpOFSZdxxz1xdNSndlD4vdcf/q2myIUVO0VsqaGHJsB0RaBE01VTOY" crossorigin="anonymous"></script>

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


<body>

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


        <!-- Page Content  -->
            <div class="text-center" style="padding:20px">
                <h2>Ops! Página não encontrada!</h2><br>
                <img src="/assets/images/avatar-1.webp" onerror="this.src='/assets/images/avatar-1.jpg" style="max-width:100px" />
                <br>
                <p class="text-muted">Página não encontrada ou ocorreu um erro.</p>
                <p class="text-muted">Clique abaixo para voltar</p>
                <br>
                <button type="button" onclick="goBack()" class="btn btn-info">
                	<span>Voltar</span>
                </button>
			</div>


</body>

</html>






