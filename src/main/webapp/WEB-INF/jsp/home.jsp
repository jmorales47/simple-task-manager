<!DOCTYPE>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <title>JSP Page</title>
        <link rel="stylesheet" href="/resources/skeleton/css/skeleton.css"/>
        <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
    </head>
    <body>
        <div class="container">
            <h3>Axios test</h3>
            <a id="refresh" class="button">
                <i class="ri-refresh-line ri-xl"></i> Refresh
            </a>
            <table id="tasks-table" class="u-full-width">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Description</th>
                        <th>Due date</th>
                        <th>Assign to</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            <h4>Task form</h4>
            <form id="form-task">
                <input type="hidden" name="id" id="task-id">
                <div class="row">
                    <div class="six columns">
                        <label>Due date:</label>
                        <input class="u-full-width" name="dueDate" type="text" pattern="[0-9]{2}-[0-9]{2}-[0-9]{4}" placeholder="DD-MM-YYYY" required="">
                    </div>
                    <div class="six columns">
                        <label>Assign to:</label>
                        <input class="u-full-width" name="assignTo" type="text" required="">
                    </div>
                </div>
                <label>Description:</label>
                <textarea name="description" class="u-full-width" required=""></textarea>

                <input type="submit" class="button-primary" value="Save">
                <input id="form-reset" type="reset" class="button" value="Clear">
            </form>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
        <script>
            window.addEventListener('load', function () {
                const form = document.getElementById('form-task');
                const formReset = document.getElementById('form-reset');
                const table = document.getElementById('tasks-table');
                const refreshBtn = document.getElementById('refresh');

                loadElements();

                form.onsubmit = function (event) {
                    event.preventDefault();
                    let data = new FormData(form);
                    let id = document.getElementById('task-id').value;
                    if (id == '') {
                        axios.post('/tasks', data)
                                .then(function () {
                                    loadElements();
                                    let event = new MouseEvent('click', {
                                        view: window,
                                        bubbles: true,
                                        cancelable: true
                                    });
                                    formReset.dispatchEvent(event);
                                })
                                .catch(function (error) {
                                    console.log(error);
                                });
                    } else {
                        axios.put('/tasks/' + id, data)
                                .then(function () {
                                    loadElements();
                                    let event = new MouseEvent('click', {
                                        view: window,
                                        bubbles: true,
                                        cancelable: true
                                    });
                                    formReset.dispatchEvent(event);
                                })
                                .catch(function (error) {
                                    console.log(error);
                                });
                    }
                };

                form.onreset = function () {
                    document.getElementById('task-id').value = '';
                };

                refreshBtn.onclick = function () {
                    loadElements();
                };

                document.body.addEventListener('click', function (event) {
                    //Events for the edit button
                    if (event.target.className == 'edit') {
                        loadData(event.target.dataset.id);
                    } else if (event.target.parentNode.className == 'edit') {
                        loadData(event.target.parentNode.dataset.id);
                    } else if (event.target.className == 'delete') {
                        confirmDelete(event.target.dataset.id);
                    } else if (event.target.parentNode.className == 'delete') {
                        confirmDelete(event.target.parentNode.dataset.id);
                    }
                });

                function loadElements() {
                    clearTable();
                    axios.get('/tasks')
                            .then(function (response) {
                                if (response.data.length > 0) {
                                    let table = document.getElementById("tasks-table");
                                    let data = response.data;
                                    for (var x in data) {
                                        let row = document.createElement("tr");
                                        row.className = 'task';
                                        let id = document.createElement("td");
                                        id.innerHTML = data[x].id;
                                        let description = document.createElement("td");
                                        description.innerHTML = data[x].description;
                                        let assignTo = document.createElement("td");
                                        assignTo.innerHTML = data[x].assignTo;
                                        let dueDate = document.createElement("td");
                                        dueDate.innerHTML = moment(data[x].dueDate, 'YYYY-MM-DD').format('DD-MM-YYYY');
                                        let actions = document.createElement("td");
                                        actions.innerHTML =
                                                '<a class="edit" data-id=' + data[x].id + ' title="Edit"><i class="ri-edit-2-fill ri-xl"></i></a>' +
                                                '<a class="delete" data-id=' + data[x].id + ' title="Delete"><i class="ri-delete-bin-6-line ri-xl"></i></a>';
                                        row.appendChild(id);
                                        row.appendChild(description);
                                        row.appendChild(dueDate);
                                        row.appendChild(assignTo);
                                        row.appendChild(actions);
                                        table.appendChild(row);
                                    }
                                }
                            })
                            .catch(function (error) {
                                console.log(error);
                            });
                }

                function clearTable() {
                    let rows = document.getElementsByClassName('task');
                    while (rows.length > 0) {
                        rows[0].parentNode.removeChild(rows[0]);
                    }
                }

                function loadData(id) {
                    axios.get('tasks/' + id)
                            .then(function (response) {
                                let task = response.data;
                                form.elements['id'].value = id;
                                form.elements['description'].value = task.description;
                                form.elements['assignTo'].value = task.assignTo;
                                form.elements['dueDate'].value = moment(task.dueDate, 'YYYY-MM-DD').format('DD-MM-YYYY');
                            })
                            .catch(function (error) {
                                console.log(error);
                            });
                }

                function confirmDelete(id) {
                    if (window.confirm("Do you really want to delete the task number " + id + "?")) {
                        axios.delete('tasks/' + id)
                                .then(function (response) {
                                    loadElements();
                                })
                                .catch(function (error) {
                                    console.log(error);
                                });
                    }
                }
            });
        </script>
    </body>
</html>

