package com.example.demo.service;

import java.util.List;
import com.example.demo.entity.lwCategory;

public interface lwCategoryService {
    List<lwCategory> findAllCategory();
    void saveCategory(lwCategory lwcategory);
    void deleteCategory(String ctype);
    void updateCategory(lwCategory lwcategory);
    List<lwCategory> findCategoryByType(String ctype);

}
