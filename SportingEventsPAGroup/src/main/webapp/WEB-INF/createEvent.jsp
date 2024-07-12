<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <title>Create Event</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"/>
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container w-50 m-auto mt-5">
    <h2>Create New Event</h2>
    <form:form action="/events/create" method="post" modelAttribute="event">
        <div class="mb-3">
            <form:label path="name">Event Name:</form:label>
            <form:input path="name" class="form-control"/>
            <form:errors path="name" cssClass="text-danger"/>
        </div>
        <div class="mb-3">
            <form:label path="location">Location:</form:label>
            <form:input path="location" class="form-control"/>
            <form:errors path="location" cssClass="text-danger"/>
        </div>
        <div class="mb-3">
            <form:label path="date">Date:</form:label>
            <form:input path="date" type="date" class="form-control"/>
            <form:errors path="date" cssClass="text-danger"/>
        </div>
        <input type="submit" class="btn btn-primary" value="Create Event"/>
    </form:form>
</div>
</body>
</html>
