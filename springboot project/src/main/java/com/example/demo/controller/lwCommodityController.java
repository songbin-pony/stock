package com.example.demo.controller;

import com.example.demo.service.LwCommodityServiceImp;
import com.example.demo.entity.lwCommodity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@CrossOrigin
@RestController
public class lwCommodityController {
    @Autowired
    private LwCommodityServiceImp lwCommodityServiceImp;

    @GetMapping("findAllonsellCommodity")
    public List<lwCommodity> findAllonsellCommodity() {
        List<lwCommodity> lwCommoditys = lwCommodityServiceImp.findAllonsellCommodity();
        System.out.println(lwCommoditys);
        return lwCommoditys;
    }
    @GetMapping("findAllselloutCommodity")
    public List<lwCommodity> findAllselloutCommodity() {
        List<lwCommodity> lwCommoditys = lwCommodityServiceImp.findAllselloutCommodity();
        System.out.println(lwCommoditys);
        return lwCommoditys;
    }
    @PostMapping("saveCommodity")
    public Map<String, Object> saveCommodity(@RequestBody lwCommodity lwcommodity) {
        System.out.println("sssssssssssssss");
        System.out.println(lwcommodity);
        Map<String, Object> map = new HashMap<>();
        try {
            lwCommodityServiceImp.saveCommodity(lwcommodity);
            map.put("success", true);
        } catch (Exception e) {
            map.put("success", false);
            map.put("message", "change user failed");
        }
        return map;

    }

    @PostMapping("deleteCommodity")
    public Map<String, Object> deleteCommodity(@RequestBody Map<String, String> values) {
        Map<String, Object> map = new HashMap<>();
        try {
            System.out.println(values);
            lwCommodityServiceImp.deleteCommodity(values.get("params_1"));
            map.put("success", true);
        } catch (Exception e) {
            map.put("success", false);
            map.put("message", "save user failed");
        }
        return map;
    }

    @PostMapping("tosellCommodity")
    public Map<String, Object> tosellCommodity(@RequestBody Map<String, String> values) {
        Map<String, Object> map = new HashMap<>();
        try {
            System.out.println(values);
            lwCommodityServiceImp.tosellCommodity(values.get("params_1"));
            map.put("success", true);
        } catch (Exception e) {
            map.put("success", false);
            map.put("message", "save user failed");
        }
        return map;
    }

    @PostMapping("toselloutCommodity")
    public Map<String, Object> toselloutCommodity(@RequestBody Map<String, String> values) {
        Map<String, Object> map = new HashMap<>();
        try {
            System.out.println(values);
            lwCommodityServiceImp.toselloutCommodity(values.get("params_1"));
            map.put("success", true);
        } catch (Exception e) {
            map.put("success", false);
            map.put("message", "save user failed");
        }
        return map;
    }


    @PostMapping("findCommodityById")
    public List<lwCommodity> findCommodityById(@RequestBody Map<String, String> values) {
        System.out.println(values.get("params_1"));
        List<lwCommodity> lwcommoditys = lwCommodityServiceImp.findCommodityById(values.get("params_1"));
        System.out.println(lwcommoditys);
        return lwcommoditys;
    }

    @PostMapping("updateCommodity")
    public Map<String, Object> updateCommodity(@RequestBody lwCommodity lwcommodity) {
        System.out.println(lwcommodity);
        Map<String, Object> map = new HashMap<>();
        try {
            lwCommodityServiceImp.updateCommodity(lwcommodity);
            map.put("success", true);
        } catch (Exception e) {
            map.put("success", false);
            map.put("message", "change user failed");
        }
        return map;

    }
}
