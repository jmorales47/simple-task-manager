<!DOCTYPE>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <title>JSP Page</title>
        <link rel="stylesheet" href="/resources/skeleton/css/skeleton.css"/>
    </head>
    <body>
        <div class="container">
            <h3>Pruebas con AXIOS</h3>
            <table id="tasks-table" class="u-full-width">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Description</th>
                        <th>Due date</th>
                        <th>Assign to</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            <h4>Agregar tarea</h4>
            <form>
                <div class="row">
                    <div class="six columns">
                        <label>Due date:</label>
                        <input class="u-full-width" type="text" pattern="[0-9]{2}-[0-9]{2}-[0-9]{4}" placeholder="DD-MM-YYYY" required="">
                    </div>
                    <div class="six columns">
                        <label>Assign to:</label>
                        <input class="u-full-width" type="text" required="">
                    </div>
                </div>
                <label>Description:</label>
                <textarea class="u-full-width" required=""></textarea>
            </form>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
        <script>
            loadElements();

            function loadElements() {
                axios.get('/tasks')
                        .then(function (response) {
                            if (response.data.length > 0) {
                                let table = document.getElementById("tasks-table");
                                let data = response.data;
                                for (var x in data) {
                                    let row = document.createElement("tr");
                                    let id = document.createElement("td");
                                    id.innerHTML = data[x].id;
                                    let description = document.createElement("td");
                                    description.innerHTML = data[x].description;
                                    let assignTo = document.createElement("td");
                                    assignTo.innerHTML = data[x].assignTo;
                                    let dueDate = document.createElement("td");
                                    dueDate.innerHTML = data[x].dueDate;
                                    row.appendChild(id);
                                    row.appendChild(description);
                                    row.appendChild(dueDate);
                                    row.appendChild(assignTo);
                                    table.appendChild(row);
                                }
                            }
                        })
                        .catch(function (error) {
                            console.log(error);
                        });
            }
        </script>
    </body>
</html>

