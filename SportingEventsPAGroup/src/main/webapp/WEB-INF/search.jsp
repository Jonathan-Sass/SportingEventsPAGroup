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
    <div class="container m-2 m-auto">
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
