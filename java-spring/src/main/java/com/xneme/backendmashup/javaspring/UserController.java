package com.xneme.backendmashup.javaspring;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.PathVariable;


@RestController
@RequestMapping
public class UserController {

    @Autowired
    private JdbcTemplate jdbcTemplate;


    @GetMapping("/users")
    public List<User> getUsers() {
        return jdbcTemplate.query(
                "SELECT * FROM users",
                (user, rowNum) ->
                    new User(
                        user.getLong("id"),
                        user.getString("name"),
                        user.getString("email")
                    )
        );
    }


    @GetMapping("/users/{id}")
    public ResponseEntity<User> getUserById(@PathVariable("id") Long id) {
        User user = jdbcTemplate.queryForObject(
            "SELECT * FROM users WHERE ID = ?",
            new Object[]{id},
            (item, rowNum) -> 
                new User(
                    item.getLong("id"),
                    item.getString("name"),
                    item.getString("email")
                )
        );
        return new ResponseEntity(user, HttpStatus.OK);
    }

}

