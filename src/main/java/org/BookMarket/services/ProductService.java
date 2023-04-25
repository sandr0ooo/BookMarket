package org.BookMarket.services;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Predicate;
import jakarta.persistence.criteria.Root;
import org.BookMarket.models.Category;
import org.BookMarket.models.Product;
import org.BookMarket.repositories.ProductRepositories;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@Transactional(readOnly = true)
public class ProductService {
    private final ProductRepositories productRepositories;

    @PersistenceContext
    private EntityManager entityManager;

    public ProductService(ProductRepositories productRepositories) {
        this.productRepositories = productRepositories;
    }

    public List<Product> getAllProduct(){
        return productRepositories.findAll();
    }

    public Product getProductId(int id){
        Optional<Product> optionalProduct = productRepositories.findById(id);
        return optionalProduct.orElse(null);
    }

    @Transactional
    public void saveProduct(Product product, Category category){
        product.setCategory(category);
        productRepositories.save(product);
    }

    @Transactional
    public void updateProduct(int id, Product product){
        product.setId(id);
        productRepositories.save(product);
    }

    @Transactional
    public void deleteProduct(int id){
        productRepositories.deleteById(id);
    }

    public List<Product> findByFilters(String name, Category category, int minPrice, int maxPrice, String order) {
        CriteriaBuilder cb = entityManager.getCriteriaBuilder();
        CriteriaQuery<Product> query = cb.createQuery(Product.class);
        Root<Product> root = query.from(Product.class);

        List<Predicate> predicates = new ArrayList<>();

        if (name != null && !name.isEmpty()) {
            predicates.add(cb.like(cb.lower(root.get("title")), "%" + name.toLowerCase() + "%"));
        }

        if (category != null) {
            predicates.add(cb.equal(root.get("category"), category));
        }

        if (minPrice != -1) {
            predicates.add(cb.greaterThanOrEqualTo(root.get("price"), minPrice));
        }

        if (maxPrice != -1) {
            predicates.add(cb.lessThanOrEqualTo(root.get("price"), maxPrice));
        }

        if (order != null && !order.isEmpty()) {
            if (order.equals("asc")) {
                query.orderBy(cb.asc(root.get("price")));
            } else if (order.equals("desc")) {
                query.orderBy(cb.desc(root.get("price")));
            }
        }

        query.where(predicates.toArray(new Predicate[0]));

        return entityManager.createQuery(query).getResultList();
    }
}
