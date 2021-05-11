package com.example.demo.controller;

import com.example.demo.service.lwCategoryServiceImp;
import com.example.demo.entity.lwCategory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@CrossOrigin
@RestController
public class lwCategoryController {
    @Autowired
    private lwCategoryServiceImp lwcategoryServiceImp;
    @GetMapping("findAllCategory")
    public List<lwCategory> findAllCategory(){
        List<lwCategory> lwcategories=lwcategoryServiceImp.findAllCategory();
        System.out.println(lwcategories);
        return lwcategories;
    }

    @PostMapping("saveCategory")
    public Map<String, Object> saveCategory(@RequestBody lwCategory lwcategory) {
        System.out.println(lwcategory);
        Map<String, Object> map = new HashMap<>();
        try {
            lwcategoryServiceImp.saveCategory(lwcategory);
            map.put("success", true);
        } catch (Exception e) {
            map.put("success", false);
            map.put("message", "change user failed");
        }
        return map;

    }
    @PostMapping("deleteCategory")
    public Map<String, Object> deleteCategory(@RequestBody Map<String, String> values) {
        Map<String, Object> map = new HashMap<>();
        try {
            System.out.println(values);
            lwcategoryServiceImp.deleteCategory(values.get("params_1"));
            map.put("success", true);
        } catch (Exception e) {
            map.put("success", false);
            map.put("message", "save user failed");
        }
        return map;
    }
    @PostMapping("findCategoryByType")
    public List<lwCategory> findCategoryByType(@RequestBody Map<String, String> values) {
        System.out.println(values.get("params_1"));
        List<lwCategory> lwadminUsers = lwcategoryServiceImp.findCategoryByType(values.get("params_1"));
        System.out.println(lwadminUsers);
        return lwadminUsers;
    }
    @PostMapping("updateCategory")
    public Map<String, Object> updateSlideImg(@RequestBody lwCategory lwcategory) {
        System.out.println(lwcategory);
        Map<String, Object> map = new HashMap<>();
        try {
            lwcategoryServiceImp.updateCategory(lwcategory);
            map.put("success", true);
        } catch (Exception e) {
            map.put("success", false);
            map.put("message", "change user failed");
        }
        return map;
    }

}
