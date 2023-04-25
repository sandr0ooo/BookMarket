package org.BookMarket.models;

import jakarta.persistence.*;

@Entity
public class Image {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String path;

    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    private Product product;

    public Image(int id, String path, Product product) {
        this.id = id;
        this.path = path;
        this.product = product;
    }

    public Image() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
}
