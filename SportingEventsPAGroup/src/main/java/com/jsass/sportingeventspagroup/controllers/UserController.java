package com.jsass.sportingeventspagroup.controllers;

import com.jsass.sportingeventspagroup.models.Event;
import com.jsass.sportingeventspagroup.models.User;
import com.jsass.sportingeventspagroup.services.EventService;
import com.jsass.sportingeventspagroup.services.UserService;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/users")
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    private EventService eventService;

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
            model.addAttribute("newLogin", new User()); // Add this line
            return "index";
        }
        userService.saveUser(user);
        return "redirect:/users/login";
    }

    @GetMapping("/login")
    public String showLoginForm(Model model) {
        model.addAttribute("newLogin", new User());
        model.addAttribute("newUser", new User()); // Add this line
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
        model.addAttribute("newUser", new User()); // Add this line
        return "index";
    }

    @GetMapping("/dashboard")
    public String userDashboard(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/users/login";
        }
        List<Event> events = eventService.findEventsByUser(loggedInUser);
        model.addAttribute("user", loggedInUser);
        model.addAttribute("events", events);
        return "dashboard"; // Logical view name
    }

    @GetMapping("/profile")
    public String userProfile(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            model.addAttribute("user", loggedInUser);
        }
        return "userAccount"; // Logical view name
    }

    @GetMapping("/edit")
    public String editUserForm(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            model.addAttribute("user", loggedInUser);
        }
        return "editUser"; // Logical view name
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
                session.setAttribute("loggedInUser", value);
            });
        }
        return "redirect:/users/profile";
    }

    // Additional methods can go here
}
