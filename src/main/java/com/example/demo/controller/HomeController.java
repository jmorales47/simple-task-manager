package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *
 * @author Jesus Andres Morales Ramos <jmorales47@uabc.edu.mx>
 */
@Controller
@RequestMapping("/inicio")
public class HomeController {

    @GetMapping
    public String getHome() {
        return "home";
    }
}
