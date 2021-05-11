package com.example.demo.dao;
import com.example.demo.entity.lwSlideImg;

import java.util.List;

public interface lwSlideImgDao {
    List<lwSlideImg> findAllSlideImg();
    void saveSlideImg(lwSlideImg lwslideImg);
    void deleteSlideImg(String id);
    void updateSlideImg(lwSlideImg lwslideImg);
    List<lwSlideImg> findImgById(String id);
}
