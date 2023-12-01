<%@page import="entities.Hotel"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des hôtels</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body {
            background-color: #add8e6; /* light blue */
        }

        table {
            background-color: #f5f5dc; /* beige */
            width: 100%;
            margin-top: 20px;
        }

        th, td {
            padding: 15px;
            text-align: left;
        }

        button {
            margin-top: 5px;
            margin-right: 5px;
            cursor: pointer;
        }

        /* Add some styles to the filter input */
        #filterContainer {
            position: absolute;
            top: 10px;
            right: 10px;
        }

        #villeFilter {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-right: 5px;
        }

        #filterLabel {
            font-size: 18px;
            margin-right: 5px;
        }

        h1 {
            color: #800080; /* purple */
        }

        /* Style for success (green) alert */
        .alert-success {
            color: #155724;
            background-color: #d4edda;
            border-color: #c3e6cb;
        }

        /* Style for danger (red) alert */
        .alert-danger {
            color: #721c24;
            background-color: #f8d7da;
            border-color: #f5c6cb;
        }

        /* Style for purple buttons */
        .btn-purple {
            background-color: #800080;
            color: white;
        }

        /* Style for purple buttons on hover */
        .btn-purple:hover {
            background-color: #6a007d;
            color: white;
        }
    </style>
</head>
<body>

    <div class="container">
        <form action="HotelController" method="post" class="mb-4">
            <div class="form-row">
                <div class="col">
                    <input type="text" name="nom" class="form-control" placeholder="Nom">
                </div>
                <div class="col">
                    <input type="text" name="adresse" class="form-control" placeholder="Adresse">
                </div>
                <div class="col">
                    <input type="text" name="telephone" class="form-control" placeholder="Téléphone">
                </div>
                <div class="col">
                    <select name="ville" class="form-control">
                        <c:forEach items="${villes}" var="v">
                            <option value="${v.id }">${v.nom }</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col">
                    <input type="hidden" name="action" value="create" />
                    <button type="submit" class="btn btn-purple">Enregistrer</button>
                </div>
            </div>
        </form>

        <!-- Move the filter input and label to the top right of the page -->
        <div id="filterContainer" class="mb-4">
            <label id="filterLabel" for="villeFilter">Filtrer par Ville:</label>
            <input type="text" id="villeFilter" oninput="filterTable()" class="form-control">
        </div>

        <!-- Display success or error messages -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success" role="alert">
                ${successMessage}
            </div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger" role="alert">
                ${errorMessage}
            </div>
        </c:if>

        <c:if test="${not empty hotels}">
            <h1>Liste des hôtels :</h1>
            <table class="table table-bordered" id="hotelsTable">
                <thead class="thead-light">
                    <tr>
                        <th>ID</th>
                        <th>Nom</th>
                        <th>Adresse</th>
                        <th>Téléphone</th>
                        <th>Ville</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${hotels}" var="h">
                        <tr>
                            <td>${h.id}</td>
                            <td>${h.nom}</td>
                            <td>${h.adresse}</td>
                            <td>${h.telephone}</td>
                            <td>${h.ville.nom}</td>
                            <td>
                                <form action="HotelController" method="post" class="mr-2">
                                    <input type="text" name="modifiedNom" value="${h.nom}" class="form-control">
                                    <input type="text" name="modifiedAdresse" value="${h.adresse}" class="form-control">
                                    <input type="text" name="modifiedTelephone" value="${h.telephone}" class="form-control">
                                    <select name="modifiedVille" class="form-control">
                                        <c:forEach items="${villes}" var="vil">
                                            <option value="${vil.id}" ${vil.id eq h.ville.id ? 'selected' : ''}>${vil.nom}</option>
                                        </c:forEach>
                                    </select>
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="id" value="${h.id}">
                                    <button type="submit" class="btn btn-purple">Modifier</button>
                                </form>

                                <form action="HotelController" method="post" onsubmit="return confirm('Êtes-vous sûr de vouloir supprimer cet hôtel ?');">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="Id" value="${h.id}">
                                    <button type="submit" class="btn btn-purple">Supprimer</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
            function filterTable() {
                var input, filter, table, tr, td, i, txtValue;
                input = document.getElementById("villeFilter");
                filter = input.value.toUpperCase();
                table = document.getElementById("hotelsTable");
                tr = table.getElementsByTagName("tr");

                // Loop through all table rows and hide those that don't match the filter
                for (i = 1; i < tr.length; i++) {
                    td = tr[i].getElementsByTagName("td")[4]; // Adjust the index as needed
                    if (td) {
                        txtValue = td.textContent || td.innerText;
                        if (txtValue.toUpperCase().indexOf(filter) > -1) {
                            tr[i].style.display = "";
                        } else {
                            tr[i].style.display = "none";
                        }
                    }
                }
            }
        </script>
    </div>
</body>
</html>
