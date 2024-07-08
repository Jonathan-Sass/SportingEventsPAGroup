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
	<html lang="en" data-bs-theme="dark">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    <title>Login or Register</title>
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
	<div class="container w-75 m-auto">
		<div class="m-2">
			<h1 class="text-primary">iSport</h1>
			<h4>Free Pickup Game Finder and Organizer</h4>
		</div>
	</div>
		<div class="container w-75 m-auto d-flex justify-content-evenly">
			<div class="card shadow p-2 m-2">
				<div class="card-body forms">
					<h4>Register</h4>			
					<form:form action="/register" method="post" modelAttribute="newUser">
			            <p>
			                <form:label path="firstName">First Name:</form:label>
			                <form:errors class="text-danger" path="firstName" />
			                <form:input class="w-100" path="firstName" />
			            </p>
			            <p>
			                <form:label path="lastName">Last Name:</form:label>
			                <form:errors class="text-danger" path="lastName" />
			                <form:input class="w-100" path="lastName" />
			            </p>
			            <p>
			                <form:label path="email">Email:</form:label>
			                <form:errors class="text-danger" path="email" />
			                <form:input class="w-100" path="email" />
			            </p>
			            <p>
			                <form:label path="password">Password:</form:label>
			                <form:errors class="text-danger" path="password" />
			                <form:input class="w-100" type="password" path="password" />
			            </p>
			            <p>
			                <form:label path="confirm">Confirm Password:</form:label>
			                <form:errors class="text-danger" path="confirm" />
			                <form:input class="w-100" type="password" path="confirm" />
			            </p>
			            <p>
			                <form:label path="birthdate">Birthdate:</form:label>
			                <form:errors class="text-danger" path="birthdate" />
			                <form:input class="w-100" type="date" path="confirm" />
			            </p>
			            <input class="btn btn-primary btn-sm" type="submit" value="Submit" />
	        		</form:form>
				</div>
			</div>
			<div class="card shadow p-2 m-2">
				<div class="card-body forms">
				<h4>Login</h4>
					<form:form action="/login" method="post" modelAttribute="newLogin">
			            <p>
			                <form:label path="email">Email:</form:label>
			                <form:errors class="text-danger" path="email" />
			                <form:input class="w-100" path="email" />
			            </p>
			            <p>
			                <form:label path="password">Password:</form:label>
			                <form:errors class="text-danger" path="password" />
			                <form:input class="w-100" type="password" path="password" />
			            </p>
	            		<input class="btn btn-primary btn-sm" type="submit" value="Submit" />
	       			 </form:form>
				</div>
			</div>
		</div>
</body>
</html>