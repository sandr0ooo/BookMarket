package org.BookMarket.controllers;

import jakarta.validation.Valid;
import org.BookMarket.models.*;
import org.BookMarket.repositories.CategoryRepositories;
import org.BookMarket.repositories.OrderRepositories;
import org.BookMarket.repositories.UserRepositories;
import org.BookMarket.security.UserDetails;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.ui.Model;
import org.BookMarket.services.ProductService;
import org.BookMarket.services.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Value("${upload.path}")
    private String uploadPath;

    private final ProductService productService;
    private final UserService userService;

    private final OrderRepositories orderRepositories;
    private final UserRepositories userRepositories;
    private final CategoryRepositories categoryRepo;

    public AdminController(ProductService productService, UserService userService, OrderRepositories orderRepositories, UserRepositories userRepositories, CategoryRepositories categoryRepo) {
        this.productService = productService;
        this.userService = userService;
        this.orderRepositories = orderRepositories;
        this.userRepositories = userRepositories;
        this.categoryRepo = categoryRepo;
    }

    @GetMapping("")
    public String panel(Model model) {
        System.out.println("TEST");

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        UserDetails userDetails = (UserDetails) auth.getPrincipal();

        model.addAttribute("products", productService.getAllProduct());
        model.addAttribute("users", userService.getAllUsers());
        model.addAttribute("orders", orderRepositories.findAll());
        model.addAttribute("user", userDetails.getUser());

        return "admin/panel";
    }

    @GetMapping("new_product")
    public String newProduct(Model model) {
        model.addAttribute("product", new Product());
        model.addAttribute("category", categoryRepo.findAll());
        return "admin/new_product";
    }

    @PostMapping("new_product")
    public String addProduct(@ModelAttribute("product") @Valid Product product, Errors error, @RequestParam(value = "files", required = false) MultipartFile[] files,
                             @RequestParam("category") int category,Model model) throws IOException {

        Category category_db = null;
            if (category == 0) {
                error.rejectValue("category", "", "Категория не указана!");
            }else {
                category_db = (Category) categoryRepo.findById(category).get();
            }

        if (files == null || files.length == 0 || files[0].getOriginalFilename().isEmpty()) {
            error.rejectValue("images", "", "Необходимо загрузить хотя бы одну фотографию!");
        }

        if(error.hasErrors()) {
            model.addAttribute("category", categoryRepo.findAll());
            return "admin/new_product";
        }

        for (var file : files) {
            File uploadDir = new File(uploadPath);
            if(!uploadDir.exists()){
                uploadDir.mkdir();
            }
            String uuidFile = UUID.randomUUID().toString();
            String resultFileName = uuidFile + "." + file.getOriginalFilename();
            file.transferTo(new File(uploadPath + "/" + resultFileName));

            Image image = new Image();
            image.setProduct(product);
            image.setPath(resultFileName);

            product.addImageToProduct(image);
        }

        productService.saveProduct(product, category_db);

        return "redirect:/admin";
    }
    @GetMapping("delete_product/{id}")
    public String deleteProduct(@PathVariable("id") int id){
        productService.deleteProduct(id);
        return "redirect:/admin";
    }

    @GetMapping("edit_product/{id}")
    public String editProduct(Model model, @PathVariable("id") int id){
        model.addAttribute("product", productService.getProductId(id));
        model.addAttribute("category", categoryRepo.findAll());
        return "admin/edit_product";
    }

    @PostMapping("edit_product/{id}")
    public String editProduct(@ModelAttribute("product") @Valid Product product, BindingResult bindingResult, @PathVariable("id") int id, Model model){
        if(bindingResult.hasErrors()){
            model.addAttribute("category", categoryRepo.findAll());
            return "admin/edit_product";
        }
        productService.updateProduct(id, product);
        return "redirect:/admin";
    }


    @PostMapping("change_user_role")
    public String changeUserRole(@ModelAttribute("user") User user, BindingResult bindingResult, Model model){
        User userRef = userRepositories.getReferenceById(user.getId());
        userRef.setRole(user.getRole());
        userRepositories.save(userRef);

        return "redirect:/admin";
    }

    @PostMapping("change_order_status")
    public String changeOrderStatus(@ModelAttribute("order") Order order, BindingResult bindingResult, Model model) {
        Order orderRef = orderRepositories.getReferenceById(order.getId());
        orderRef.setStatus(order.getStatus());
        orderRepositories.save(orderRef);

        return "redirect:/admin";
    }
}
