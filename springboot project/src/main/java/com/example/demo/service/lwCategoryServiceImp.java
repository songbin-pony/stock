package com.example.demo.service;

import com.example.demo.dao.lwCategoryDao;
import com.example.demo.entity.lwCategory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import java.util.UUID;

import java.util.List;
@Service
@Transactional
public class lwCategoryServiceImp implements lwCategoryService {
    @Autowired
    private lwCategoryDao lwcategoryDao;
    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public List<lwCategory> findAllCategory() {
        return lwcategoryDao.findAllCategory();
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public void saveCategory(lwCategory lwcategory) {
        lwcategory.setType(UUID.randomUUID().toString());
        lwcategoryDao.saveCategory(lwcategory);

    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public void deleteCategory(String ctype) {
        lwcategoryDao.deleteCategory(ctype);

    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public void updateCategory(lwCategory lwcategory) {
        lwcategoryDao.updateCategory(lwcategory);

    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public List<lwCategory> findCategoryByType(String ctype) {
        return lwcategoryDao.findCategoryByType(ctype);
    }
}
