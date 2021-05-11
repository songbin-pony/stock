package com.example.demo.dao;

import com.example.demo.entity.lwCategory;
import java.util.List;

public interface lwCategoryDao {
    List<lwCategory> findAllCategory();
    List<lwCategory> findCategoryByType(String admin);
    void deleteCategory(String admin);
    void updateCategory(lwCategory lwcategory);
    void saveCategory(lwCategory lwcategory);
}
