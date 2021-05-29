package com.example.demo.entity;

import java.io.Serializable;
import java.time.LocalDate;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import org.springframework.format.annotation.DateTimeFormat;

/**
 *
 * @author Jesus Andres Morales Ramos <jmorales47@uabc.edu.mx>
 */
@Entity
public class Task implements Serializable {

    @Id
    @GeneratedValue
    private Integer id;

    @Column(length = 100, nullable = false)
    private String description;

    @Column(name = "due_date", nullable = false)
    @DateTimeFormat(pattern = "dd-MM-yyyy")
    private LocalDate dueDate;

    @Column(name = "assign_to", length = 100)
    private String assignTo;

    public Task() {
    }

    public Task(String description, LocalDate dueDate) {
        this.description = description;
        this.dueDate = dueDate;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDate getDueDate() {
        return dueDate;
    }

    public void setDueDate(LocalDate dueDate) {
        this.dueDate = dueDate;
    }

    public String getAssignTo() {
        return assignTo;
    }

    public void setAssignTo(String assignTo) {
        this.assignTo = assignTo;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Task{id=").append(id);
        sb.append(", description=").append(description);
        sb.append(", dueDate=").append(dueDate);
        sb.append(", assignTo=").append(assignTo);
        sb.append('}');
        return sb.toString();
    }

}
