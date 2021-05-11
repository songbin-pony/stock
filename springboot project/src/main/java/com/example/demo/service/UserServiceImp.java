package com.example.demo.service;

import com.example.demo.dao.UserDao;
import com.example.demo.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
@Transactional
public class UserServiceImp implements UserService {

    @Autowired
    private UserDao userdao;

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public List<User> findAll() {
        return userdao.findAll();
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public void Save(User user) {
        user.setId(UUID.randomUUID().toString());
        System.out.println("实现中"+user);
        userdao.Save(user);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public void Delete(String id) {
        userdao.Delete(id);

    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public void Update(User user) {
        userdao.Update(user);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public List<User> findNameOrEmail(String name, String email) {
        return userdao.findNameOrEmail(name,email);
    }
}
