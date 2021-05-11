package com.example.demo.service;

import com.example.demo.entity.lwUser;

import java.util.List;

public interface lwUserService {
    List<lwUser> findByName(String username);
    void saveUser(lwUser lwuser);
    void updateUser(String username,double balance);
    void charge(String username,double charge);
    List<lwUser> findAllUser();
    void delUserById(String userid);
}
