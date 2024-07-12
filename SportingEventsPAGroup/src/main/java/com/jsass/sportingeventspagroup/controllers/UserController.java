package com.jsass.sportingeventspagroup.controllers;

import com.jsass.sportingeventspagroup.models.User;
import com.jsass.sportingeventspagroup.services.UserService;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
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
    public String registerUser(@Valid @ModelAttribute("newUser") User user, BindingResult result, Model model) {
        if (userService.isEmailTaken(user.getEmail())) {
            result.rejectValue("email", "error.user", "Email is already taken");
        }
        if (!user.getPassword().equals(user.getConfirm())) {
            result.rejectValue("confirm", "error.user", "Passwords do not match");
        }
        if (result.hasErrors()) {
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
    public String loginUser(@Valid @ModelAttribute("newLogin") User user, BindingResult result, Model model, HttpSession session) {
        Optional<User> existingUser = userService.findUserByEmail(user.getEmail());
        if (existingUser.isPresent() && userService.checkPassword(user.getPassword(), existingUser.get().getPassword())) {
            session.setAttribute("loggedInUser", existingUser.get());
            return "redirect:/users/dashboard";
        }
        result.rejectValue("email", "error.user", "Invalid email or password");
        if (result.hasErrors()) {
            model.addAttribute("newUser", new User());
            return "index";
        }
        return "redirect:/users/dashboard";
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            Optional<User> userWithEvents = userService.findUserByEmailWithEvents(loggedInUser.getEmail());
            if (userWithEvents.isPresent()) {
                User user = userWithEvents.get();
                model.addAttribute("user", user);
                model.addAttribute("eventsCreated", user.getEvents());
                model.addAttribute("eventsAttending", user.getAttendedEvents());
            }
            return "dashboard"; // Logical view name
        }
        return "redirect:/users/login";
    }

    @GetMapping("/profile")
    public String userProfile(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            model.addAttribute("user", loggedInUser);
            return "userAccount"; // Logical view name
        }
        return "redirect:/users/login";
    }

    @GetMapping("/edit")
    public String editUserForm(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            model.addAttribute("user", loggedInUser);
            return "editUser"; // Logical view name
        }
        return "redirect:/users/login";
    }

    @PostMapping("/update")
    public String updateUser(@Valid @ModelAttribute("user") User user, BindingResult result, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            if (result.hasErrors()) {
                return "editUser";
            }
            loggedInUser.setFirstName(user.getFirstName());
            loggedInUser.setLastName(user.getLastName());
            loggedInUser.setBirthdate(user.getBirthdate());
            if (!user.getPassword().isEmpty()) {
                loggedInUser.setPassword(BCrypt.hashpw(user.getPassword(), BCrypt.gensalt()));
            }
            userService.saveUser(loggedInUser);
        }
        return "redirect:/users/profile";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/users/login";
    }
}
