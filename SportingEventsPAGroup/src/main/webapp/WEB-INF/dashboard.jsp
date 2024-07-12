<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"/>
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
	<div class="container-fluid w-75 m-2 m-auto">
	    <div class="d-flex justify-content-between align-items-center">
	        <div><h1 class="display-5">Welcome, <c:out value="${user.firstName}"/>!</h1></div>
	        <div><a href="/users/register">logout</a></div>
	    </div>
	</div>
	<div class="container-fluid w-75 m-2 m-auto">
	    <div class="card shadow p-3 m-2">
	        <c:choose>
	            <c:when test="${numTodaysEvents == 1}">
	                <div><h4 class="display-6">Today is ${todaysDate}, you have ${numTodaysEvents} event today.</h4></div>
	            </c:when>
	            <c:otherwise>
	                <div><h4 class="display-6">Today is ${todaysDate}, you have ${numTodaysEvents} events today.</h4></div>
	            </c:otherwise>
	        </c:choose>
			<div class="card-body">
			    <table class="table table-dark table-hover table-striped d-block">
			        <thead>
				        <tr>
				            <th class="lead">Event Name</th>
				            <th class="lead">Location Name</th>
				            <th class="lead">Attendees</th>
				            <th class="lead">Date</th>
				        </tr>
			        </thead>
			        <tbody>
				        <c:forEach var="event" items="${events}">
							<c:if test="${event.date == todaysDate}">
					            <tr>
					                <td><a href="/events/${event.id}"><c:out value="${event.name}"/></a></td>
					                <td><c:out value="${event.location}"/></td>
					                <td><c:out value="${event.attendees}/${capacity}"/></td>
					                <td><c:out value="${event.date}"/></td>
					            </tr>
				            </c:if>
				        </c:forEach>
			        </tbody> 
			    </table>
			</div>
		</div>
		<div class="card shadow p-3 m-2">
			<h4 class="display-6">Here are your future events.</h4>
			<div class="card-body">
			    <table class="table table-dark table-hover table-striped d-block">
			        <thead>
				        <tr>
				            <th class="lead">Event Name</th>
				            <th class="lead">Location Name</th>
				            <th class="lead">Attendees</th>
				            <th class="lead">Date</th>
				            <th class="lead">Action</th>
				            
				        </tr>
			        </thead>
			        <tbody>
				        <c:forEach var="event" items="${events}">
							<c:if test="${event.date != todaysDate}">
					            <tr>
					                <td><a href="/events/${event.id}"><c:out value="${event.name}"/></a></td>
					                <td><c:out value="${event.location}"/></td>
					                <td><c:out value="${event.attendees.size()}/${capacity}"/></td>
					                <td><c:out value="${event.date}"/></td>
					                <c:choose>
							            <c:when test="${event.attendees.size() < event.capacity}">
							                <td>Full</td>
							            </c:when>
							            <c:otherwise>
							                <td><a href="/events/${event.id}/join">Join</a></td>
							            </c:otherwise>
									</c:choose>
					            </tr>
				            </c:if>
				        </c:forEach>
			        </tbody> 
			    </table>
			</div>
		</div>
	</div>
</body>
</html>
