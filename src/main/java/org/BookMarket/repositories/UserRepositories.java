package org.BookMarket.repositories;

import org.BookMarket.models.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepositories extends JpaRepository<User, Integer> {
    Optional<User> getByUsername(String username);
}
