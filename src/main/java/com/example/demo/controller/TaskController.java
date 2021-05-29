package com.example.demo.controller;

import com.example.demo.dao.TaskRepository;
import com.example.demo.entity.Task;
import java.util.List;
import javax.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author Jesus Andres Morales Ramos <jmorales47@uabc.edu.mx>
 */
@RestController
@RequestMapping("/tasks")
public class TaskController {

    @Autowired
    private TaskRepository taskRepository;

    @GetMapping
    public List<Task> getAll() {
        return taskRepository.findAll();
    }

    @GetMapping("/{id}")
    public Task getFindOne(@PathVariable Integer id) {
        return taskRepository.findById(id).orElseThrow(() -> new EntityNotFoundException("Entity not found"));
    }

    @PostMapping
    public Task postCreate(@ModelAttribute Task task) {
        return taskRepository.save(task);
    }

    @PutMapping("/{id}")
    public Task putUpdate(@PathVariable Integer id, @ModelAttribute Task task) {
        return taskRepository.findById(id).map(t -> {
            t.setAssignTo(task.getAssignTo());
            t.setDescription(task.getDescription());
            t.setDueDate(task.getDueDate());
            return taskRepository.save(t);
        }).orElseThrow(() -> new EntityNotFoundException("Entity not found"));
    }

    @DeleteMapping("/{id}")
    public void deleteEntity(@PathVariable Integer id) {
        taskRepository.deleteById(id);
    }
}
