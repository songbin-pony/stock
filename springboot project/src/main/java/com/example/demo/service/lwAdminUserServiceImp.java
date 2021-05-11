package com.example.demo.service;

import com.example.demo.dao.lwAdminUserDao;
import com.example.demo.entity.lwAdminUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class lwAdminUserServiceImp implements lwAdminUserService{

    @Autowired
    private lwAdminUserDao lwadminUserDao;

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public List<lwAdminUser> findAll() {
        return lwadminUserDao.findAll();
    }

    @Override
    public List<lwAdminUser> findByName(String admin) {
        return lwadminUserDao.findByName(admin);
    }

    @Override
    public void Delete(String admin) {
        lwadminUserDao.Delete(admin);
    }

    @Override
    public void updateAdminUser(lwAdminUser lwadminUser) {
        lwadminUserDao.updateAdminUser(lwadminUser);
    }

    @Override
    public void saveAdminUser(lwAdminUser lwadminUser) {
        lwadminUserDao.saveAdminUser(lwadminUser);
    }
}
