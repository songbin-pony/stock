package com.example.demo.service;

import com.example.demo.entity.lwOrder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
@Service
@Transactional
public interface lwOrderService {
    void saveOrder(lwOrder lworder);
    List<lwOrder> findpaidOrder(String username);
    List<lwOrder> findfinishOrder(String username);
    List<lwOrder> findAllOrder();
    List<lwOrder> findAllFinishOrder();
    void ConfirmOrder(String orderid);
}
