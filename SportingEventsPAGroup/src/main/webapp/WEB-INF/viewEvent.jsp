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
	    <div class="container-fluid px-4">
	        <div class="d-flex"><a class="navbar-brand text-primary" href="/users/dashboard">iSport</a></div>
	        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
	                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
	            <span class="navbar-toggler-icon"></span>
	        </button>
	        <div class="collapse navbar-collapse" id="navbarNav">
	            <ul class="navbar-nav">
	                <li class="nav-item">
	                    <a class="nav-link active" aria-current="page" href="/users/dashboard">Home</a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="/events/new">New</a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="/events/search">Search</a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="/users/profile">Account</a>
	                </li>
	            </ul>
	        </div>
	    </div>
    </nav>
    <div class="container m-auto my-5">
		<div class="card shadow p-3">
			<div class="card-title">
				<h1 class="display-6"><c:out value="${event.name}"/></h1>
			</div>
	 			<div class="card-body">
	 				<div class="d-flex justify-content-evenly">
		 				<div class="border border-primary border-2 rounded p-4">
		 					<p class="lead text-center"><u>Information</u></p>
		 					<p>Name: ${event.name}</p>
		 					<p>Location: ${event.location}</p>
		 					<p>Date: ${event.date}</p>
		 				</div>
		 				<div class="border border-primary border-2 rounded p-4">
		 					<p class="lead text-center"><u>Attendees</u></p>
		 					<c:forEach var ="attendee" items="${event.attendees}">
		 						<p>${attendee.firstName}</p>
		 					</c:forEach>
		 				</div>
	 				</div>
				<div class="border border-primary border-2 rounded p-2 mt-5">
					<h4>Messages:</h4>
					<c:forEach var="message" items="${event.messages}">
						<p>${message.author}: ${message.content}</p>
					</c:forEach>
				</div>
			</div>
		</div>
    </div>
</body>
</html>


	
	
	
	
		