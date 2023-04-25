package org.BookMarket.repositories;

import org.BookMarket.models.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CategoryRepositories extends JpaRepository<Category, Integer> {
    Category findByName(String name);
}
