package com.example.demo.service;

import com.example.demo.entity.lwSlideImg;

import java.util.List;

public interface lwSlideImgService {
    List<lwSlideImg> findAllSlideImg();
    void saveSlideImg(lwSlideImg lwslideImg);
    void deleteSlideImg(String id);
    void updateSlideImg(lwSlideImg lwslideImg);
    List<lwSlideImg> findImgById(String id);
}
