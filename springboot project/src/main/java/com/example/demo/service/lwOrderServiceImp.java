package com.example.demo.service;

import com.example.demo.entity.lwOrder;
import org.springframework.beans.factory.annotation.Autowired;
import com.example.demo.dao.lwOrderDao;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class lwOrderServiceImp implements lwOrderService{
    @Autowired
    private lwOrderDao lworderDao;
    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public void saveOrder(lwOrder lworder) {
        lworderDao.saveOrder(lworder);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public List<lwOrder> findpaidOrder(String username) {
        return lworderDao.findOrder(username,"0");
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public List<lwOrder> findfinishOrder(String username) {
        return lworderDao.findOrder(username,"1");
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public List<lwOrder> findAllOrder() {
        return lworderDao.findAllOrder("0");
    }
    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public List<lwOrder> findAllFinishOrder() {
        return lworderDao.findAllOrder("1");
    }

    @Override
    public void ConfirmOrder(String orderid) {
        lworderDao.ConfirmOrder("1",orderid);
    }
}
