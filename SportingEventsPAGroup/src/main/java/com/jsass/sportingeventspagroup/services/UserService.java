package com.jsass.sportingeventspagroup.services;

import com.jsass.sportingeventspagroup.models.User;
import com.jsass.sportingeventspagroup.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;

    public boolean isEmailTaken(String email) {
        return userRepository.findByEmail(email).isPresent();
    }

    public void saveUser(User user) {
        userRepository.save(user);
    }

    public Optional<User> findUserByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public boolean checkPassword(String plainPassword, String hashedPassword) {
        return org.mindrot.jbcrypt.BCrypt.checkpw(plainPassword, hashedPassword);
    }
}
