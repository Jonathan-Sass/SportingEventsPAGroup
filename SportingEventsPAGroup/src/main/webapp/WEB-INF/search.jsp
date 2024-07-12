<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <title>Event Search</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"/>
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/js/app.js"></script>
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
    <div class="container m-2 m-auto">
        <div class="d-flex justify-content-between align-items-center">
            <form action="/search/submit" method="post">
                <div class="form-floating">
                    <input type="text" class="form-control" name="search-input" id="search-input"/>
                    <label for="search-input" class="form-label">Search</label>
                </div>
                <div>
                    <h6>Search by:</h6>
                    <select>
                    	<option value="searchName">Name</option>
                    	<option value="searchLocation">Location</option>
                    	<option value="searchDate">Date</option>
                    </select>
                </div>
                <input type="submit" class="btn btn-primary btn-sm" value="Submit"/>
            </form>
        </div>
        <div class="d-flex justify-content-between align-items-center">
            <table class="table">
                <thead>
                    <tr>
                        <th>Event Name</th>
                        <th>Location Name</th>
                        <th>Attendees</th>
                        <th>Date</th>
                        <th>Creator</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="event" items="${events}">
                        <tr>
                            <td>${event.name}</td>
                            <td>${event.location}</td>
                            <td>
                                <c:forEach var="attendee" items="${event.attendees}">
                                    ${attendee.firstName} ${attendee.lastName}<br/>
                                </c:forEach>
                            </td>
                            <td>${event.date}</td>
                            <td>${event.creator.firstName} ${event.creator.lastName}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${event.attendees.size() == event.capacity}">
                                        <p>Full</p>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="/events/${event.id}/join">Join</a>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
