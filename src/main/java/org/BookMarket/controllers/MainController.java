package org.BookMarket.controllers;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.BookMarket.models.Cart;
import org.BookMarket.models.Order;
import org.BookMarket.models.Product;
import org.BookMarket.models.User;
import org.BookMarket.repositories.CartRepositories;
import org.BookMarket.repositories.CategoryRepositories;
import org.BookMarket.repositories.OrderRepositories;
import org.BookMarket.security.UserDetails;
import org.BookMarket.services.ProductService;
import org.BookMarket.services.UserService;
import org.BookMarket.util.Validators;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@Controller
public class MainController {
    private final UserService userService;
    private final ProductService productService;

    private final CategoryRepositories categoryRepo;
    private final CartRepositories cartRepo;
    private final OrderRepositories orderRepositories;

    public MainController(UserService userService, ProductService productService, CategoryRepositories categoryRepo, CartRepositories cartRepo, OrderRepositories orderRepositories) {
        this.userService = userService;
        this.productService = productService;
        this.categoryRepo = categoryRepo;
        this.cartRepo = cartRepo;
        this.orderRepositories = orderRepositories;
    }

    @GetMapping("/")
    public String index(@RequestParam(value = "search", required = false) String search,
                        @RequestParam(value = "category", required = false) String category,
                        @RequestParam(value = "price_from", required = false) String price_from,
                        @RequestParam(value = "price_to", required = false) String price_to,
                        @RequestParam(value = "price_sort", required = false) String price_order,
                        Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();

        if (auth.getPrincipal() instanceof UserDetails userDetails) {
            System.out.println(userDetails.getUser().getRole());
            model.addAttribute("user", userDetails.getUser());
        }

        int minPrice = -1, maxPrice = -1;

        System.out.println(price_from);

        if (price_from != null && !price_from.isEmpty())
            minPrice = Integer.parseInt(price_from);

        if (price_to != null && !price_to.isEmpty())
            maxPrice = Integer.parseInt(price_to);

        var productsList = productService.findByFilters(search, categoryRepo.findByName(category), minPrice, maxPrice, price_order);

        model.addAttribute("products", productsList);
        model.addAttribute("categories", categoryRepo.findAll());

        return "index";
    }

    @GetMapping("/logout")
    public String logout(HttpServletRequest request, HttpServletResponse response) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null) {
            new SecurityContextLogoutHandler().logout(request, response, authentication);
        }
        return "redirect:/login?logout";
    }

    @GetMapping("/registration")
    public String regPage(@ModelAttribute("user") User user) {
        return "registration";
    }

    @PostMapping("/registration")
    public String regResult(@ModelAttribute("user") User user, Errors errors) {

        if (userService.getByUsername(user.getUsername()) != null) {
            errors.rejectValue("username", "", "Имя пользователя занято! Попробуйте другой");
            return "registration";
        }

        if (!Validators.validateUsername(user.getUsername()))
            errors.rejectValue("username", "", "Невалидное имя пользователя!");

        if (!Validators.validatePassword(user.getPassword()))
            errors.rejectValue("password", "", "Невалидный пароль!");

        if (errors.hasErrors()) {
            return "registration";
        }

        userService.register(user);
        return "login";
    }

    @GetMapping("/product/{id}")
    public String infoProduct(@PathVariable("id") int id, Model model){
        model.addAttribute("product", productService.getProductId(id));
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();

        if (auth.getPrincipal() instanceof UserDetails userDetails) {
            System.out.println(userDetails.getUser().getRole());
            model.addAttribute("user", userDetails.getUser());
        }
        return "product";
    }

    @GetMapping("/cart_add/{id}")
    public String addProductInCart(@PathVariable("id") int id, Model model){
        Product product = productService.getProductId(id);
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetails personDetails = (UserDetails) authentication.getPrincipal();
        // Извлекаем id пользователя из объекта
        int id_person = personDetails.getUser().getId();

        Cart cart = cartRepo.findByUserId(id_person);

        if (cart == null) {
            cart = new Cart();
            cart.setUser(personDetails.getUser());
        }

        cart.setUser(personDetails.getUser());
        cart.addProduct(productService.getProductId(id));

        cartRepo.save(cart);
        return "redirect:/cart";
    }

    @GetMapping("/cart")
    public String cart(Model model){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetails userDetails = (UserDetails) authentication.getPrincipal();

        int id_person = userDetails.getUser().getId();
        Cart cart = cartRepo.findByUserId(id_person);
        if (cart == null) {
            cart = new Cart();
            cart.setUser(userDetails.getUser());
        }
        List<Product> productList = cart.getProducts();

        float price = 0;
        for (Product product: productList) {
            price += product.getPrice();
        }

        model.addAttribute("user", userDetails.getUser());
        model.addAttribute("price", price);
        model.addAttribute("cart_product", productList);
        return "cart";
    }

    @GetMapping("/cart_delete/{product_idx}")
    public String deleteProductFromCart(Model model, @PathVariable("product_idx") int index) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetails userDetails = (UserDetails) authentication.getPrincipal();
        User user = userDetails.getUser();
        Cart cart = cartRepo.findByUserId(user.getId());

        if (index >= 0 && index < cart.getProducts().size()) {
            cart.getProducts().remove(index);
            cartRepo.save(cart);
        }

        return "redirect:/cart";
    }

    @GetMapping("/create_order")
    public String order() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetails personDetails = (UserDetails) authentication.getPrincipal();
        int id_person = personDetails.getUser().getId();

        Cart cart = cartRepo.findByUserId(id_person);
        List<Product> productList = cart.getProducts();

        float price = 0;
        for (Product product: productList) {
            price += product.getPrice();
        }

        String uuid = UUID.randomUUID().toString();

        for (Product product : productList) {
            Order newOrder = new Order(uuid, product, personDetails.getUser(), 1, product.getPrice(), "Оформлен");
            orderRepositories.save(newOrder);
        }

        cart.getProducts().clear();
        cartRepo.save(cart);

        return "redirect:/orders";
    }

    @GetMapping("/orders")
    public String orderUser(Model model){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetails userDetails = (UserDetails) authentication.getPrincipal();

        List<Order> orderList = orderRepositories.findByUser(userDetails.getUser());
        model.addAttribute("orders", orderList);
        model.addAttribute("user", userDetails.getUser());
        return "orders";
    }
}
