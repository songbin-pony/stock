package com.example.demo.service;

import com.example.demo.entity.lwCommodity;

import java.util.List;

public interface lwCommodityService {
    List<lwCommodity> findAllonsellCommodity();
    List<lwCommodity> findAllselloutCommodity();
    void saveCommodity(lwCommodity lwcommodity);
    void deleteCommodity(String commodityid);
    void updateCommodity(lwCommodity lwcommodity);
    List<lwCommodity> findCommodityById(String commodityid);
    void tosellCommodity(String commodityid);
    void toselloutCommodity(String commodityid);
}
