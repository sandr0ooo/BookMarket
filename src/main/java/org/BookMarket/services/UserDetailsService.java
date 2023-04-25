package org.BookMarket.services;

import org.BookMarket.models.User;
import org.BookMarket.repositories.UserRepositories;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserDetailsService implements org.springframework.security.core.userdetails.UserDetailsService {
    private final UserRepositories userRepositories;

    @Autowired
    public UserDetailsService(UserRepositories userRepositories) {
        this.userRepositories = userRepositories;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Optional<User> user = userRepositories.getByUsername(username);

        if (user.isEmpty())
            throw new UsernameNotFoundException("Пользователь \"" + username + "\" не найден!");

        return new org.BookMarket.security.UserDetails(user.get());
    }
}
