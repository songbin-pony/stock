package com.example.demo.service;
import com.example.demo.dao.lwUserDao;
import com.example.demo.entity.lwUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
@Service
@Transactional
public class lwUserServiceImp implements lwUserService{
    @Autowired
    private lwUserDao lwuserDao;
    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public List<lwUser> findByName(String username) {
        return lwuserDao.findByName(username);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public void saveUser(lwUser lwuser) {
        lwuserDao.saveUser(lwuser);

    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public void updateUser(String username,double balance) {
        List<lwUser> lwusers=lwuserDao.findByName(username);
        lwUser lwuser=lwusers.get(0);
        double temp=lwuser.getBalance();
        temp=temp-balance;
        lwuser.setBalance(temp);
        lwuserDao.updateUser(lwuser);
    }
    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public void charge(String username,double charge) {
        List<lwUser> lwusers=lwuserDao.findByName(username);
        lwUser lwuser=lwusers.get(0);
        double temp=lwuser.getBalance();
        temp=temp+charge;
        lwuser.setBalance(temp);
        lwuserDao.updateUser(lwuser);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public List<lwUser> findAllUser() {
        return lwuserDao.findAllUser();
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public void delUserById(String userid) {
        lwuserDao.delUserById(userid);
    }
}
