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
	    <title>View A Book</title>
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
	   	<div class="container">
		   	<div class="d-flex card shadow p-2 gap-2">
		   		<div class="card-body">
			   		<div class="d-flex flex-3">
			   			<div class="my-3">
				   			<p class="lead">Name: ${user.firstName}</p>
				   			<p class="">Email: ${user.email}</p>
							<p class="">Password: **********</p>
			   			</div>
			   			<div class="my-3">
				   			<a href="/users/${user.id}/edit">Edit</a>	   			
			   			</div>
			   			<div class="my-3">
			   				<p>Event History:</p>
			   				<c:forEach var="event" items="${user.events}">
				   				<c:if test="${event.date} < ${currentDate}">
				   					<p>${Event.name}</p>
				   				</c:if>
			   				</c:forEach>
			   			</div>
			   			<div class="my-3">
			   				<p>Future Events:</p>
			   				<c:forEach var="event" items="${user.events}">
			   					<c:if test="${event.date >= ${currentDate}">
			   						<p>${event.name}</p>
			   					</c:if>
			   				</c:forEach>
			   			</div>
		   			</div>
	   			</div>
	   		</div>
	   	</div>
	</body>
	</html>
	
	
	
	
	
	
		