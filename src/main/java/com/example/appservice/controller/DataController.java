package com.example.appservice.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class DataController {

    @GetMapping("/api/data")
    public String getData() {
        return "Succesfully responded to the microservice ";
    }
}
