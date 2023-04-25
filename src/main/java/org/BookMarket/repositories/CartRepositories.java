package org.BookMarket.repositories;

import org.BookMarket.models.Cart;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Repository
public interface CartRepositories extends JpaRepository<Cart, Integer> {
    Cart findByUserId(int id);

    @Modifying
    @Query(value = "delete from carts where product_id=?1 AND user_id=?2", nativeQuery = true)
    void deleteProduct(int product_id, int user_id);
}
