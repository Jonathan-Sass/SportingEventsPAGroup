<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <title>Edit Message</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"/>
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
	<div class="container">
	    <h2>Edit Message</h2>
	    <form:form action="/messages/${message.id}/update" method="post" modelAttribute="message">
	        <div class="mb-3">
	            <form:label path="content">Content:</form:label>
	            <form:textarea path="content" class="form-control"/>
	            <form:errors path="content" cssClass="text-danger"/>
	        </div>
	        <input type="submit" class="btn btn-primary" value="Update Message"/>
	    </form:form>
	</div>
</body>
</html>
