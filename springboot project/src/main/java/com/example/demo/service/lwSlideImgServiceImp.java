package com.example.demo.service;

import com.example.demo.entity.lwSlideImg;
import java.util.List;
import com.example.demo.dao.lwSlideImgDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import java.util.UUID;

@Service
@Transactional
public class lwSlideImgServiceImp implements lwSlideImgService{
    @Override
    public void saveSlideImg(lwSlideImg lwslideImg) {
        lwslideImg.setId(UUID.randomUUID().toString());
        lwslideImgDao.saveSlideImg(lwslideImg);
    }

    @Autowired
    private lwSlideImgDao lwslideImgDao;

    @Override
    public List<lwSlideImg> findImgById(String id) {
        return lwslideImgDao.findImgById(id);
    }

    @Override
    public void updateSlideImg(lwSlideImg lwslideImg) {
        lwslideImgDao.updateSlideImg(lwslideImg);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public List<lwSlideImg> findAllSlideImg() {
        return lwslideImgDao.findAllSlideImg();
    }

    @Override
    public void deleteSlideImg(String id) {
        lwslideImgDao.deleteSlideImg(id);
    }
}
