package org.BookMarket.services;

import jakarta.transaction.Transactional;
import org.BookMarket.models.User;
import org.BookMarket.repositories.UserRepositories;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserService {
    private final UserRepositories userRepositories;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public UserService(UserRepositories userRepositories, PasswordEncoder passwordEncoder) {
        this.userRepositories = userRepositories;
        this.passwordEncoder = passwordEncoder;
    }

    public List<User> getAllUsers() {
        return userRepositories.findAll();
    }

    public User getByUsername(String username) {
        Optional<User> person_db = userRepositories.getByUsername(username);
        return person_db.orElse(null);
    }

    @Transactional
    public void register(User user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setRole("ROLE_CUSTOMER");
        userRepositories.save(user);
    }

    // @Transactional
    // public
}
