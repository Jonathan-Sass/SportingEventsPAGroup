<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <title>View Event</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"/>
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
    <h1>${event.name}</h1>
    <p>Location: ${event.location}</p>
    <p>Date: ${event.date}</p>

    <h2>Messages</h2>
    <div id="messages">
        <c:forEach var="message" items="${messageList}">
            <div>
                <strong>${message.author}:</strong> ${message.content}
            </div>
        </c:forEach>
    </div>

    <h2>Leave a Message</h2>
    <form:form modelAttribute="message" action="/messages/create" method="post">
        <form:hidden path="eventId" value="${event.id}"/>
        <div class="mb-3">
            <form:textarea path="content" class="form-control" placeholder="Type your message here..."/>
            <form:errors path="content" cssClass="text-danger"/>
        </div>
        <button type="submit" class="btn btn-primary">Send</button>
    </form:form>
</div>
</body>
</html>
