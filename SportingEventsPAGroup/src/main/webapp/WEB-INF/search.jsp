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
	    <title>Event Search</title>
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
	   	<div class="container  m-2 m-auto">
	   		<div class="d-flex justify-content-between align-items-center">
	   			<form action="/search/submit" method="post">
		   			<div class="form-floating d-flex">
			   			<input type="text" class="form-control" name="search-input" id="search-input"/>
			   			<label for="search-input" class="form-label">Search</label>
		   			</div>
		   			<div class="d-flex">
		   				<h6>Search by:</h6>
		   				<select>
		   				</select>
		   			</div>
		   			<input type="submit" class="btn btn-primary btn-sm" value="Submit"/>
	   			</form>
	   		</div>
	   		<div class="d-flex justify-content-between align-items-center">
	   			<table>
	   				<thead>
	   					<tr>Event Name</tr>
	   					<tr>Location Name</tr>
	   					<tr>Member</tr>
	   					<tr>Date</tr>
	   					<tr>Creator</tr>
	   					<tr>Action</tr>
	   				</thead>
	   				<tbody>
	   					<c:forEach var="event" items="${events}">
		   					<td>${event.name}</td>
		   					<td>${event.location}</td>
		   					<td>${event.members}</td>
		   					<td>${event.date}</td>
		   					<td>${event.creator}</td>
		   					<c:choose>
			   					<c:when test="${event.members} == ${event.capacity}">
			   						<p>Full</p>
			   						</c:when>
			   					<c:otherwise>
		   							<a href="/events/{id}/join">Join</a>
	   							</c:otherwise>
		   					</c:choose>
	   					</c:forEach>
	   				</tbody>
	   			</table>
	   		</div>
	  	</div>
	  	<div class="container m-auto m-2">
	  		TODO: Tabs 
	  	</div>
	</body>
	</html>