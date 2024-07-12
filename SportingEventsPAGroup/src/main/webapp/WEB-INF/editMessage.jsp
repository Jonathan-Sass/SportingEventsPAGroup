<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Message</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"/>
</head>
<body>
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
