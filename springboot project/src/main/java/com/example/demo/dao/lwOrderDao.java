package com.example.demo.dao;

import com.example.demo.entity.lwOrder;
import org.apache.ibatis.annotations.Param;

import java.util.List;
public interface lwOrderDao {
    void saveOrder(lwOrder lworder);
    List<lwOrder> findOrder(@Param("username") String username, @Param("statusone") String statusone);
    List<lwOrder> findAllOrder(String statusone);
    void ConfirmOrder(@Param("statusone") String statusone, @Param("orderid") String orderid);
}
