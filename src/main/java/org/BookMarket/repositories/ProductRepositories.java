package org.BookMarket.repositories;

import org.BookMarket.models.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepositories extends JpaRepository<Product, Integer> {

    List<Product> findByTitle(String name);
}
