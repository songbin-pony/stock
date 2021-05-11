package com.example.demo.service;

import com.example.demo.entity.lwOrderDetail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import com.example.demo.dao.lwOrderDetailDao;

import java.util.List;

@Service
@Transactional
public class lwOrderDetailServiceImp implements lwOrderDetailService{
    @Autowired
    private lwOrderDetailDao lwOrderDetailDao;
    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public void saveOrderDetail(lwOrderDetail lworderDetail) {
        lwOrderDetailDao.saveOrderDetail(lworderDetail);

    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public List<lwOrderDetail> findDetailOrderById(String orderid) {
        return lwOrderDetailDao.findDetailOrderById(orderid);
    }
}
