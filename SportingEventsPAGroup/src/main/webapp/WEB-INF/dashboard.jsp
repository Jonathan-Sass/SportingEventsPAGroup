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
	<html data-bs-themes="dark">
	<head>
	    <meta charset="UTF-8">
	    <title>Dashboard</title>
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
	   	<div class="container  m-2 m-auto">
	   		<div class="d-flex justify-content-between align-items-center">
	   			<div><h1>Welcome, <c:out value="${firstName}"/>!</h1></div>
	   			<div><a href="/logout">logout</a></div>
	   		</div>
	   		<div class="d-flex justify-content-between align-items-center">
	   			<c:choose>
	   				<c:when test="${numTodaysEvents} == 1">
	   					<div><h4>Today is ${todaysDate}, you have ${numTodaysEvents} event today.</h4></div>
	   				</c:when>
	   				<c:otherwise>
	   					<div><h4>Today is ${todaysDate}, you have ${numTodaysEvents} events today.</h4></div>
	   				</c:otherwise>
	   			</c:choose>
	   		</div>
	  	</div>
	  	<div class="container m-auto m-2">
	  		<table class="table table-primary table-hover table-striped d-block">
	  			<thead>
	  				<tr>
	  					<th>Event Name</th>
	  					<th>Location Name</th>
	  					<th>Attendees</th>
	  					<th>Date</th>
	  				</tr>
	  			</thead>
	  			<tbody>
	  				<c:forEach var="event" items="${events}">
   					<tr>
   						<td><a href="/events/${event.id}"><c:out value="${event.name}"/></a></td>
	   					<td><c:out value="${event.location}"/></td>
   						<td><c:out value="${event.attendees}"/></td>
   						<td><c:out value="${event.date}"/></td>
   					</tr>
   				</c:forEach>
	  			</tbody>
	  		<!-- TODO: Scroll bar -->
	  		</table>
	  	</div>
	  	
	</body>
	</html>