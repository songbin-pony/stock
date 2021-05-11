package com.example.demo.controller;

import com.example.demo.entity.lwOrder;
import com.example.demo.service.lwUserServiceImp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.example.demo.service.lwOrderServiceImp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@CrossOrigin
@RestController
public class lwOrderController {
    @Autowired
    private lwOrderServiceImp lworderServiceImp;
    @Autowired
    private lwUserServiceImp lwuserServiceImp;
    @PostMapping("saveOrder")
    public Map<String, Object> saveOrder(@RequestBody lwOrder lworder) {
        System.out.println(lworder);
        Map<String, Object> map = new HashMap<>();
        try {
            lworderServiceImp.saveOrder(lworder);
            lwuserServiceImp.updateUser(lworder.getUsername(),lworder.getTotalprice());
            map.put("success", true);
        } catch (Exception e) {
            map.put("success", false);
            map.put("message", "change user failed");
        }
        return map;

    }
    @PostMapping("findpaidOrder")
    public List<lwOrder> findpaidOrder(@RequestBody Map<String, String> values) {
        System.out.println(values.get("username"));
        List<lwOrder> lworders = lworderServiceImp.findpaidOrder(values.get("username"));
        System.out.println(lworders);
        return lworders;
    }
    @PostMapping("findfinishOrder")
    public List<lwOrder> findfinishOrder(@RequestBody Map<String, String> values) {
        System.out.println(values.get("username"));
        List<lwOrder> lworders = lworderServiceImp.findfinishOrder(values.get("username"));
        System.out.println(lworders);
        return lworders;
    }
    @GetMapping("findAllOrder")
    public List<lwOrder> findAllOrder() {
        List<lwOrder> lworders = lworderServiceImp.findAllOrder();
        System.out.println(lworders);
        return lworders;
    }
    @GetMapping("findAllFinishOrder")
    public List<lwOrder> findAllFinishOrder() {
        List<lwOrder> lworders = lworderServiceImp.findAllFinishOrder();
        System.out.println(lworders);
        return lworders;
    }

    @PostMapping("ConfirmOrder")
    public Map<String, Object> ConfirmOrder(@RequestBody Map<String, String> values) {
        Map<String, Object> map = new HashMap<>();
        try {
            lworderServiceImp.ConfirmOrder(values.get("orderid"));
            map.put("success", true);
        } catch (Exception e) {
            map.put("success", false);
            map.put("message", "failed");
        }
        return map;
    }
}
