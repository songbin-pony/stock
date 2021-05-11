package com.example.demo.controller;

import com.alibaba.druid.util.StringUtils;
import com.example.demo.entity.User;
import com.example.demo.service.UserServiceImp;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@CrossOrigin
@RestController
public class UserController {
    //find all user
    @Autowired
    private UserServiceImp serviceImp;


    @GetMapping("findAll")
    public List<User> findAll(){
        List<User> users=serviceImp.findAll();
        return users;
    }
    @PostMapping("save")
    public Map<String,Object> Save(@RequestBody User user){
        Map<String,Object> map=new HashMap<>();
        try{
            System.out.println(user);
            System.out.println(StringUtils.isEmpty(user.getId()));
            if(StringUtils.isEmpty(user.getId())){
                serviceImp.Save(user);
            }
            else{
               serviceImp.Update(user);
            }
            map.put("success",true);
        }catch (Exception e){
            map.put("success",false);
            map.put("message","save or change user failed");
        }
        return map;

    }
    @PostMapping("deleteUser")
    public Map<String,Object> delete(@RequestBody Map<String,String> values){
        Map<String,Object> map=new HashMap<>();
        try{
            System.out.println(values);
            serviceImp.Delete(values.get("params_1"));
            map.put("success",true);
        }catch (Exception e){
            map.put("success",false);
            map.put("message","save user failed");
        }
        return map;
    }
    @PostMapping("searchUser")
    public List<User> searchUser(@RequestBody Map<String,String> values){
        System.out.println(values);
        List<User> users=serviceImp.findNameOrEmail(values.get("params_1"),values.get("params_2"));
        return users;
    }

}
