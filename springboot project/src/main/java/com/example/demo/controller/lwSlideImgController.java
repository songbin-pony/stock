package com.example.demo.controller;

import com.example.demo.service.lwSlideImgServiceImp;
import com.example.demo.entity.lwSlideImg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@CrossOrigin
@RestController
public class lwSlideImgController {
    @Autowired
    private lwSlideImgServiceImp lwslideImgServiceImp;
    @GetMapping("findAllSlideImg")
    public List<lwSlideImg> findAll(){
        List<lwSlideImg> lwslideImgs=lwslideImgServiceImp.findAllSlideImg();
        System.out.println(lwslideImgs);
        return lwslideImgs;
    }

    @PostMapping("saveSlideImg")
    public Map<String, Object> saveAdminUser(@RequestBody lwSlideImg lwslideImg) {
        System.out.println(lwslideImg);
        Map<String, Object> map = new HashMap<>();
        try {
            lwslideImgServiceImp.saveSlideImg(lwslideImg);
            map.put("success", true);
        } catch (Exception e) {
            map.put("success", false);
            map.put("message", "change user failed");
        }
        return map;

    }
    @PostMapping("deleteSlideImg")
    public Map<String, Object> deleteSlideImg(@RequestBody Map<String, String> values) {
        Map<String, Object> map = new HashMap<>();
        try {
            System.out.println(values);
            lwslideImgServiceImp.deleteSlideImg(values.get("params_1"));
            map.put("success", true);
        } catch (Exception e) {
            map.put("success", false);
            map.put("message", "save user failed");
        }
        return map;
    }
    @PostMapping("findImgById")
    public List<lwSlideImg> findImgById(@RequestBody Map<String, String> values) {
        System.out.println(values.get("params_1"));
        List<lwSlideImg> lwadminUsers = lwslideImgServiceImp.findImgById(values.get("params_1"));
        System.out.println(lwadminUsers);
        return lwadminUsers;
    }
    @PostMapping("updateSlideImg")
    public Map<String, Object> updateSlideImg(@RequestBody lwSlideImg lwslideImg) {
        System.out.println(lwslideImg);
        Map<String, Object> map = new HashMap<>();
        try {
            lwslideImgServiceImp.updateSlideImg(lwslideImg);
            map.put("success", true);
        } catch (Exception e) {
            map.put("success", false);
            map.put("message", "change user failed");
        }
        return map;

    }
}
