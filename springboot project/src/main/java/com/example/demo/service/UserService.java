package com.example.demo.service;

import com.example.demo.entity.User;

import java.util.List;

public interface UserService {
    //find all users
    List<User> findAll();
    void Save(User user);
    void Delete(String id);
    void Update(User user);
    List<User>  findNameOrEmail(String name,String email);
}
