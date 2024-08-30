**Pern Stack To-Do List App**

This example demonstrates a basic To-Do List application using a PERN stack:

- **P** - **PostgreSQL** (database)
- **E** - **Express** (server framework)
- **R** - **React** (client-side library)
- **N** - **Node.js** (runtime environment)

### Database Setup

First, set up your PostgreSQL database.

#### Create Database

```sql
-- Create a new database
CREATE DATABASE todo_list;

-- Connect to the database
\c todo_list

-- Create a table for tasks
CREATE TABLE tasks (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    completed BOOLEAN DEFAULT FALSE
);
```

### Server Setup

Next, set up your Express server.

#### Install Dependencies

```bash
npm init -y
npm install express pg
```

#### Create Server

```javascript
// server.js
const express = require('express');
const { Pool } = require('pg');

const app = express();
const pool = new Pool({
  user: 'your_username',
  host: 'localhost',
  database: 'todo_list',
  password: 'your_password',
  port: 5432,
});

// Middleware
app.use(express.json());

// Get all tasks
app.get('/tasks', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM tasks');
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Failed to retrieve tasks' });
  }
});

// Create a new task
app.post('/tasks', async (req, res) => {
  try {
    const { title, description } = req.body;
    const result = await pool.query(
      'INSERT INTO tasks (title, description) VALUES ($1, $2) RETURNING *',
      [title, description]
    );
    res.json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Failed to create task' });
  }
});

// Update a task
app.put('/tasks/:id', async (req, res) => {
  try {
    const id = req.params.id;
    const { title, description } = req.body;
    const result = await pool.query(
      'UPDATE tasks SET title = $1, description = $2 WHERE id = $3 RETURNING *',
      [title, description, id]
    );
    res.json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Failed to update task' });
  }
});

// Delete a task
app.delete('/tasks/:id', async (req, res) => {
  try {
    const id = req.params.id;
    await pool.query('DELETE FROM tasks WHERE id = $1', [id]);
    res.json({ message: 'Task deleted successfully' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Failed to delete task' });
  }
});

const port = 3000;
app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
```

### Client Setup

Finally, set up your React client.

#### Install Dependencies

```bash
npm init -y
npm install react react-dom
```

#### Create Client

```javascript
// App.js
import React, { useState, useEffect } from 'react';

function App() {
  const [tasks, setTasks] = useState([]);
  const [title, setTitle] = useState('');
  const [description, setDescription] = useState('');

  useEffect(() => {
    fetch('/tasks')
      .then(response => response.json())
      .then(data => setTasks(data));
  }, []);

  const handleSubmit = async e => {
    e.preventDefault();
    const response = await fetch('/tasks', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ title, description }),
    });
    const data = await response.json();
    setTasks([...tasks, data]);
    setTitle('');
    setDescription('');
  };

  const handleUpdate = async (id, title, description) => {
    const response = await fetch(`/tasks/${id}`, {
      method: 'PUT',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ title, description }),
    });
    const data = await response.json();
    setTasks(
      tasks.map(task =>
        task.id === id ? { ...task, title, description } : task
      )
    );
  };

  const handleDelete = async id => {
    await fetch(`/tasks/${id}`, { method: 'DELETE' });
    setTasks(tasks.filter(task => task.id !== id));
  };

  return (
    <div>
      <h1>To-Do List</h1>
      <form onSubmit={handleSubmit}>
        <input
          type="text"
          value={title}
          onChange={e => setTitle(e.target.value)}
          placeholder="Title"
        />
        <input
          type="text"
          value={description}
          onChange={e => setDescription(e.target.value)}
          placeholder="Description"
        />
        <button type="submit">Add Task</button>
      </form>
      <ul>
        {tasks.map(task => (
          <li key={task.id}>
            {task.title} - {task.description}
            <button onClick={() => handleUpdate(task.id, task.title, task.description)}>
              Update
            </button>
            <button onClick={() => handleDelete(task.id)}>Delete</button>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default App;
```

### Run the Application

```bash
npm start
```

This will start the server and client simultaneously. Open your web browser and navigate to `http://localhost:3000` to view the To-Do List application.

### Example Use Cases

- **Create a new task**: Enter a title and description in the form and submit it.
- **Update a task**: Click the "Update" button next to a task to edit its title and description.
- **Delete a task**: Click the "Delete" button next to a task to remove it from the list.

This example demonstrates a basic To-Do List application using a PERN stack. You can extend this example to include additional features such as user authentication and task prioritization.