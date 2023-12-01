<%@page import="entities.Ville"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <style>
        body {
            background-color: lightblue;
        }

        table {
            background-color: beige;
            width: 100%;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        /* Style for success (green) buttons */
        .btn-success {
            background-color: #800080; /* Mauve */
            color: white;
        }

        /* Style for success (green) buttons on hover */
        .btn-success:hover {
            background-color: #4b0082; /* Darker Mauve */
            color: white;
        }

        /* Style for danger (red) buttons */
        .btn-danger {
            background-color: #800080; /* Mauve */
            color: white;
        }

        /* Style for danger (red) buttons on hover */
        .btn-danger:hover {
            background-color: #4b0082; /* Darker Mauve */
            color: white;
        }

        /* Style for default (blue) buttons */
        .btn-primary {
            background-color: #800080; /* Mauve */
            color: white;
        }

        /* Style for default (blue) buttons on hover */
        .btn-primary:hover {
            background-color: #4b0082; /* Darker Mauve */
            color: white;
        }
    </style>
</head>
<body>

    <form action="VilleController" method="post">
        Nom : <input type="text" name="ville" />
        <button type="submit" class="btn btn-success">Enregistrer</button>
    </form>

    <c:if test="${not empty villes}">
        <h1>Liste des villes :</h1>
        <table border="1">
            <thead>
                <tr>
                    <th style="width: 10%;">ID</th>
                    <th style="width: 20%;">Nom</th>
                    <th style="width: 40%;">Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${villes}" var="v">
                    <tr>
                        <td>${v.id}</td>
                        <td>${v.nom}</td>
                        <td>
                            <form action="VilleController" method="post">
                                <input type="text" name="ville" value="${v.nom}" />
                                <input type="hidden" name="action" value="update" />
                                <input type="hidden" name="id" value="${v.id}" />
                                <button type="submit" class="btn btn-primary">Modifier</button>
                            </form>
                            <form action="VilleController" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="${v.id}" />
                                <button type="submit" class="btn btn-danger">Supprimer</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>

</body>
</html>
