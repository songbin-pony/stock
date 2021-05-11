package com.example.demo.service;

import java.util.List;
import com.example.demo.entity.lwAdminUser;

public interface lwAdminUserService {
    List<lwAdminUser> findAll();
    List<lwAdminUser> findByName(String admin);
    void Delete(String admin);
    void updateAdminUser(lwAdminUser lwadminUser);
    void saveAdminUser(lwAdminUser lwadminUser);
}
