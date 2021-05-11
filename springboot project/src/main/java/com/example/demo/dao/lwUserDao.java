package com.example.demo.dao;
import com.example.demo.entity.lwUser;
import org.apache.ibatis.annotations.Param;

import java.util.List;
public interface lwUserDao {
    List<lwUser> findByName(String username);
    List<lwUser> findAllUser();
    void saveUser(lwUser lwuser);
    void updateUser(lwUser lwuser);
    void delUserById(String userid);

}
