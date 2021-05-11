package com.example.demo;

import com.example.demo.dao.UserDao;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;


@SpringBootTest(classes =DemoApplication.class )
@RunWith(SpringRunner.class)
public class DemoApplicationTests {

    @Autowired
    private UserDao userDao;

    @Test
    public void testFindAll() {

        System.out.println(userDao.findAll());
    }

}
