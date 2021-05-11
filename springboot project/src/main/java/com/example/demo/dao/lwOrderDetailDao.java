package com.example.demo.dao;

import com.example.demo.entity.lwOrderDetail;
import java.util.List;
public interface lwOrderDetailDao {
    void saveOrderDetail(lwOrderDetail lworderDetail);
    List<lwOrderDetail> findDetailOrderById(String orderid);

}
