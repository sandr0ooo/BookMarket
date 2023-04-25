package org.BookMarket.repositories;

import org.BookMarket.models.Order;
import org.BookMarket.models.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderRepositories extends JpaRepository<Order, Integer> {
    List<Order> findByUser(User user);
}
