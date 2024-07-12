<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <title>Create Event</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"/>
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/js/app.js"></script>
</head>
<body>
<div class="container w-75 m-auto">
    <h2>Create Event</h2>
    <form:form action="/events/create" method="post" modelAttribute="event">
        <div class="form-group">
            <form:label path="name">Event Name:</form:label>
            <form:errors path="name" cssClass="text-danger"/>
            <form:input path="name" class="form-control"/>
        </div>
        <div class="form-group">
            <form:label path="location">Location:</form:label>
            <form:errors path="location" cssClass="text-danger"/>
            <form:input path="location" class="form-control"/>
        </div>
        <div class="form-group">
            <form:label path="date">Date:</form:label>
            <form:errors path="date" cssClass="text-danger"/>
            <form:input path="date" type="date" class="form-control"/>
        </div>
        <button type="submit" class="btn btn-primary mt-3">Create Event</button>
    </form:form>
</div>
</body>
</html>
