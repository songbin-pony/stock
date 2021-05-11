package com.example.demo.controller;

import com.example.demo.service.lwAdminUserServiceImp;
import com.example.demo.entity.lwAdminUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@CrossOrigin
@RestController
public class lwAdminUserController {
    @Autowired
    private lwAdminUserServiceImp lwadminUserServiceImp;

    @GetMapping("findAllAdminUser")
    public List<lwAdminUser> findAll() {
        List<lwAdminUser> lwadminUsers = lwadminUserServiceImp.findAll();
        return lwadminUsers;
    }

    @PostMapping("findAdminByName")
    public List<lwAdminUser> findByName(@RequestBody Map<String, String> values) {
        System.out.println(values.get("params_1"));
        List<lwAdminUser> lwadminUsers = lwadminUserServiceImp.findByName(values.get("params_1"));
        System.out.println(lwadminUsers);
        return lwadminUsers;
    }

    @PostMapping("deleteAdminUser")
    public Map<String, Object> deleteAdminUser(@RequestBody Map<String, String> values) {
        Map<String, Object> map = new HashMap<>();
        try {
            System.out.println(values);
            lwadminUserServiceImp.Delete(values.get("params_1"));
            map.put("success", true);
        } catch (Exception e) {
            map.put("success", false);
            map.put("message", "save user failed");
        }
        return map;
    }

    @PostMapping("updateAdminUser")
    public Map<String, Object> updateAdminUser(@RequestBody lwAdminUser lwadminUser) {
        System.out.println(lwadminUser);
        Map<String, Object> map = new HashMap<>();
        try {
            lwadminUserServiceImp.updateAdminUser(lwadminUser);
            map.put("success", true);
        } catch (Exception e) {
            map.put("success", false);
            map.put("message", "change user failed");
        }
        return map;

    }
    @PostMapping("saveAdminUser")
    public Map<String, Object> saveAdminUser(@RequestBody lwAdminUser lwadminUser) {
        System.out.println(lwadminUser);
        Map<String, Object> map = new HashMap<>();
        try {
            lwadminUserServiceImp.saveAdminUser(lwadminUser);
            map.put("success", true);
        } catch (Exception e) {
            map.put("success", false);
            map.put("message", "change user failed");
        }
        return map;

    }
}
