package com.example.demo.controller;
import com.example.demo.entity.lwOrderDetail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import com.example.demo.service.lwOrderDetailServiceImp;
import java.util.HashMap;
import java.util.Map;
import java.util.List;

@CrossOrigin
@RestController
public class lwOrderDetailController {
    @Autowired
    private lwOrderDetailServiceImp lworderDetailServiceImp;
    @PostMapping("saveOrderDetail")
    public Map<String, Object> saveOrderDetail(@RequestBody lwOrderDetail lworderDetail) {
        System.out.println(lworderDetail);
        Map<String, Object> map = new HashMap<>();
        try {
            lworderDetailServiceImp.saveOrderDetail(lworderDetail);
            map.put("success", true);
        } catch (Exception e) {
            map.put("success", false);
            map.put("message", "change user failed");
        }
        return map;

    }
    @PostMapping("findDetailOrderById")
    public  List<lwOrderDetail> findDetailOrderById(@RequestBody  Map<String, String> values) {
        System.out.println(values.get("orderid"));
        List<lwOrderDetail> lworderdetails = lworderDetailServiceImp.findDetailOrderById(values.get("orderid"));
        System.out.println(lworderdetails);
        return lworderdetails;

    }
}
