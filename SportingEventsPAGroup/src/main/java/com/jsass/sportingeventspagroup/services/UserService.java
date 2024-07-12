package com.jsass.sportingeventspagroup.services;

import com.jsass.sportingeventspagroup.models.User;
import com.jsass.sportingeventspagroup.repositories.UserRepository;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;

    public Optional<User> findUserByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public boolean isEmailTaken(String email) {
        return userRepository.findByEmail(email).isPresent();
    }

    public void saveUser(User user) {
        // Ensure the password is hashed before saving
        if (user.getPassword() != null && !user.getPassword().isEmpty()) {
            user.setPassword(BCrypt.hashpw(user.getPassword(), BCrypt.gensalt()));
        }
        userRepository.save(user);
    }

    public boolean checkPassword(String rawPassword, String encodedPassword) {
        return BCrypt.checkpw(rawPassword, encodedPassword);
    }

    public Optional<User> findUserByEmailWithEvents(String email) {
        return userRepository.findByEmailWithEvents(email);
    }
}
