package com.example.demo.dao;

import com.example.demo.entity.lwAdminUser;
import java.util.List;

public interface lwAdminUserDao {
    List<lwAdminUser> findAll();
    List<lwAdminUser> findByName(String admin);
    void Delete(String admin);
    void updateAdminUser(lwAdminUser lwadminUser);
    void saveAdminUser(lwAdminUser lwadminUser);

}
