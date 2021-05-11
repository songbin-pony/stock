package com.example.demo.dao;

import com.example.demo.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserDao {
    //查询所有的方法
    List<User> findAll();

    void Save(User user);
    void Delete(String id);
    void Update(User user);
    //根据姓名或者邮箱进行模糊搜索
    List<User> findNameOrEmail(@Param("name") String name, @Param("email") String email);//参数绑定,可以试试不参数绑定
}
