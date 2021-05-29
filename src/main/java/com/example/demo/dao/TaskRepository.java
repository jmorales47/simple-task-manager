package com.example.demo.dao;

import com.example.demo.entity.Task;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Jesus Andres Morales Ramos <jmorales47@uabc.edu.mx>
 */
@Repository
public interface TaskRepository extends JpaRepository<Task, Integer> {

}
