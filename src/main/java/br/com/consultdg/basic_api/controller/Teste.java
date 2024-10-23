package br.com.consultdg.basic_api.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@CrossOrigin
@RestController
@RequestMapping("/teste")
public class Teste {
 @GetMapping("/hello")
    public ResponseEntity<String> teste() {
        System.out.println("APi básica em Spring");
        return ResponseEntity.ok("Hello Word - Endpoint de Teste");
    }
}
