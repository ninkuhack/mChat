package dev.eggSaint.mChat.service;

import dev.eggSaint.mChat.model.User;

public interface UserService {
    void save(User user);
    User findByUsername(String username);
}
