package com.example.demo.service;

import com.example.demo.entity.lwOrderDetail;

import java.util.List;

public interface lwOrderDetailService {
    void saveOrderDetail(lwOrderDetail lworderDetail);
    List<lwOrderDetail> findDetailOrderById(String orderid);
}
