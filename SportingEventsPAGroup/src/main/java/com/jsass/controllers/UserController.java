package com.jsass.controllers;
import com.jsass.models.*;
import com.jsass.services.*;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.Optional;

@Controller
@RequestMapping("/users")
public class UserController {
    @Autowired
    private UserService userService;

    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("newUser", new User());
        return "index"; // Use the same JSP for login and register
    }

    @PostMapping("/register")
    public String registerUser(@ModelAttribute("newUser") User user, Model model) {
        if (userService.isEmailTaken(user.getEmail())) {
            model.addAttribute("emailError", "Email is already taken");
            return "index";
        }
        userService.saveUser(user);
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String showLoginForm(Model model) {
        model.addAttribute("newLogin", new User());
        return "index"; // Use the same JSP for login and register
    }

    @PostMapping("/login")
    public String loginUser(@ModelAttribute("newLogin") User user, Model model) {
        Optional<User> existingUser = userService.findUserByEmail(user.getEmail());
        if (existingUser.isPresent() && userService.checkPassword(user.getPassword(), existingUser.get().getPassword())) {
            model.addAttribute("user", existingUser.get());
            return "redirect:/dashboard";
        }
        model.addAttribute("loginError", "Invalid email or password");
        return "index";
    }

    @GetMapping("/profile")
    public String userProfile(Principal principal, Model model) {
        if (principal != null) {
            Optional<User> user = userService.findUserByEmail(principal.getName());
            user.ifPresent(value -> model.addAttribute("user", value));
        }
        return "userAccount";
    }

    @GetMapping("/edit")
    public String editUserForm(Principal principal, Model model) {
        if (principal != null) {
            Optional<User> user = userService.findUserByEmail(principal.getName());
            user.ifPresent(value -> model.addAttribute("user", value));
        }
        return "editUser";
    }

    @PostMapping("/update")
    public String updateUser(@ModelAttribute("user") User user, Principal principal) {
        if (principal != null) {
            Optional<User> existingUser = userService.findUserByEmail(principal.getName());
            existingUser.ifPresent(value -> {
                value.setFirstName(user.getFirstName());
                value.setLastName(user.getLastName());
                value.setBirthdate(user.getBirthdate());
                // If the password is being updated, hash it before saving
                if (!user.getPassword().isEmpty()) {
                    value.setPassword(BCrypt.hashpw(user.getPassword(), BCrypt.gensalt()));
                }
                userService.saveUser(value);
            });
        }
        return "redirect:/users/profile";
    }

    // Additional methods can go here
}