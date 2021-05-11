package com.example.demo.controller;

import com.alibaba.druid.util.StringUtils;
import com.example.demo.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.example.demo.entity.lwUser;
import com.example.demo.service.lwUserServiceImp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@CrossOrigin
@RestController
public class lwUserController {
    @Autowired
    private lwUserServiceImp lwuserServiceImp;

    @PostMapping("findByName")
    public List<lwUser> findByName(@RequestBody Map<String, String> values) {
        System.out.println(values);
        List<lwUser> lwusers = lwuserServiceImp.findByName(values.get("username"));
        return lwusers;

    }

    @PostMapping("saveUser")
    public Map<String, Object> SaveUser(@RequestBody lwUser lwuser) {
        Map<String, Object> map = new HashMap<>();
        try {
            lwuser.setUserid(UUID.randomUUID().toString());
            System.out.println(lwuser);
            lwuserServiceImp.saveUser(lwuser);
            map.put("success", true);
        } catch (Exception e) {
            map.put("success", false);
            map.put("message", "save or change user failed");
        }
        return map;

    }
    @PostMapping("chargebalance")
    public Map<String, Object> chargebalance(@RequestBody Map<String, String> values) {
        System.out.println(values.get("username"));
        System.out.println(values.get("charge"));
        Map<String, Object> map = new HashMap<>();
        try {
            lwuserServiceImp.charge(values.get("username"),Double.parseDouble(values.get("charge")));
            map.put("success", true);
        } catch (Exception e) {
            map.put("success", false);
            map.put("message", "change user failed");
        }
        return map;

    }
    @GetMapping("findAllUser")
    public List<lwUser> findAllUser(){
        List<lwUser> lwusers=lwuserServiceImp.findAllUser();
        return lwusers;
    }
    @PostMapping("delUserById")
    public Map<String, Object> delUserById(@RequestBody Map<String, String> values) {
        System.out.println(values.get("userid"));
        Map<String, Object> map = new HashMap<>();
        try {
            lwuserServiceImp.delUserById(values.get("userid"));
            map.put("success", true);
        } catch (Exception e) {
            map.put("success", false);
            map.put("message", "failed");
        }
        return map;

    }
}
