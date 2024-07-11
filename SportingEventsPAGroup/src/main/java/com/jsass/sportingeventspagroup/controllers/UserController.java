package com.jsass.sportingeventspagroup.controllers;

import com.jsass.sportingeventspagroup.models.User;
import com.jsass.sportingeventspagroup.services.UserService;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;
import java.util.Optional;

@Controller
@RequestMapping("/users")
public class UserController {
    @Autowired
    private UserService userService;

    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("newUser", new User());
        model.addAttribute("newLogin", new User());
        return "index"; // Logical view name
    }

    @PostMapping("/register")
    public String registerUser(@ModelAttribute("newUser") User user, Model model) {
        if (userService.isEmailTaken(user.getEmail())) {
            model.addAttribute("emailError", "Email is already taken");
            model.addAttribute("newUser", new User());
            model.addAttribute("newLogin", new User());
            return "index";
        }
        userService.saveUser(user);
        return "redirect:/users/login";
    }

    @GetMapping("/login")
    public String showLoginForm(Model model) {
        model.addAttribute("newLogin", new User());
        model.addAttribute("newUser", new User());
        return "index"; // Logical view name
    }

    @PostMapping("/login")
    public String loginUser(@ModelAttribute("newLogin") User user, Model model, HttpSession session) {
        Optional<User> existingUser = userService.findUserByEmail(user.getEmail());
        if (existingUser.isPresent() && userService.checkPassword(user.getPassword(), existingUser.get().getPassword())) {
            session.setAttribute("loggedInUser", existingUser.get());
            return "redirect:/users/dashboard";
        }
        model.addAttribute("loginError", "Invalid email or password");
        model.addAttribute("newLogin", new User());
        model.addAttribute("newUser", new User());
        return "index";
    }

    @GetMapping("/dashboard")
    public String showDashboard(Model model, HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user != null) {
            model.addAttribute("user", user);
            return "dashboard"; // Logical view name
        }
        return "redirect:/users/login";
    }

    @GetMapping("/profile")
    public String userProfile(Model model, HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user != null) {
            model.addAttribute("user", user);
            return "userAccount"; // Logical view name
        }
        return "redirect:/users/login";
    }

    @GetMapping("/edit")
    public String editUserForm(Model model, HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user != null) {
            model.addAttribute("user", user);
            return "editUser"; // Logical view name
        }
        return "redirect:/users/login";
    }

    @PostMapping("/update")
    public String updateUser(@ModelAttribute("user") User user, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            Optional<User> existingUser = userService.findUserByEmail(loggedInUser.getEmail());
            existingUser.ifPresent(value -> {
                value.setFirstName(user.getFirstName());
                value.setLastName(user.getLastName());
                value.setBirthdate(user.getBirthdate());
                // If the password is being updated, hash it before saving
                if (!user.getPassword().isEmpty()) {
                    value.setPassword(BCrypt.hashpw(user.getPassword(), BCrypt.gensalt()));
                }
                userService.saveUser(value);
                session.setAttribute("loggedInUser", value); // Update session user
            });
            return "redirect:/users/profile";
        }
        return "redirect:/users/login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // Invalidate the session
        return "redirect:/users/login";
    }
}
