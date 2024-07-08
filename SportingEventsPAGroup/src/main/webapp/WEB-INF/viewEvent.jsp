	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<!-- c:out ; c:forEach etc. --> 
	<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
	<!-- Formatting (dates) --> 
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
	<!-- form:form -->
	<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
	<!-- for rendering errors on PUT routes -->
	<%@ page isErrorPage="true" %>
	<!DOCTYPE html>
	<html data-bs-theme="dark">
	<head>
	    <meta charset="UTF-8">
	    <title>Event Information</title>
	   	<link
	    	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	    	rel="stylesheet"
	    	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	    	crossorigin="anonymous"
   		/>
	    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
	    <script type="text/javascript" src="/js/app.js"></script><!-- change to match your file/naming structure -->
	</head>
	<body>
		<nav class="navbar navbar-expand-lg bg-body-tertiary">
	  		<div class="container-fluid">
				<a class="navbar-brand" href="#">Navbar</a>
				<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarNav">
					<ul class="navbar-nav">
						<li class="nav-item">
							<a class="nav-link active" aria-current="page" href="#">Home</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="#">New</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="#">Search</a>
						</li>
						<li class="nav-item">
							<a class="nav-link disabled" aria-disabled="true">Disabled</a>
						</li>
					</ul>
				</div>
			</div>
		</nav>
		<div class="card shadow p-2">
			<div class="card-title">
				<h1><c:out value="${event.name}"/></h1>
			</div>
   			<div class="card-body">
   				<div class="d-flex justify-content-between align-items-center p-2 my-4 gap-2">
   					<div class="d-flex flex-3 flex-column">
   						<ul class="nav nav-tabs">
							<li class="nav-item">
								<a class="nav-link active" aria-current="page" href="#">Event Date</a>
							</li>
							<li class="nav-item">
								<a class="nav-link" href="#">Information</a>
							</li>
							<li class="nav-item">
								<a class="nav-link" href="#">Users</a>
							</li>
							<li class="nav-item">
								<a class="nav-link disabled" aria-disabled="true">Disabled</a>
							</li>
						</ul>
   					</div>
   					<div class="d-flex flex-2">
   						<img href="/static/images/map.jpg"/>
   					</div>
  					</div>
  					<div class="border border-primary border-2">
  						<h4>Messages:</h4>
  						<c:forEach var="message" items="${event.messages}">
  							<p>${message.author}: ${message.content}</p>
  						</c:forEach>
				</div>
			</div>
		</div>
	</body>
	</html>
	
	
	
	
	
	
		