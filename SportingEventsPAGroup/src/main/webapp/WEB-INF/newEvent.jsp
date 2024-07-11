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
	    <title>Create An Event</title>
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
							<a class="nav-link active" aria-current="page" href="/events/">Home</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="/events/new">New</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="/events/search">Search</a>
						</li>
						<li class="nav-item">
							<a class="nav-link disabled" aria-disabled="true">Disabled</a>
						</li>
					</ul>
				</div>
			</div>
		</nav>
		<div class="card shadow w-75 p-2 m-auto">
			<div class="card-title">
				<h3>Create a New Event</h3>
		   			<div class="card-body">
		   				<form:form action="/listings/create" method="post" modelAttribute="listing">
		   					<input type="hidden" path="id" value="${user.id}"/>
		   					<div>
		   						<form:label path="name">Name: </form:label>
		   						<form:errors class="text-danger" path="name"/>
		   						<form:input class= "w-100" path="name"/>
	   						</div>
	   						<div>
		   						<form:label path="location">Location: </form:label>
		   						<form:errors class="text-danger" path="location"/>
		   						<form:input class= "w-100" path="location"/>
	   						</div>
	   						<div>
		   						<form:label path="date">Date: </form:label>
		   						<form:errors class="text-danger" path="date"/>
		   						<form:input class= "w-100" path="date"/>
	   						</div>
	   						<input type="submit" class="btn btn-primary w-100" value="Create Event"/>
		   				</form:form>
		   			</div>
		   		</div>
	   		</div>
	</body>
	</html>
	
	
	
	
	
	
		