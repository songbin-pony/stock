package com.example.demo.service;

import com.example.demo.entity.lwCommodity;
import com.example.demo.dao.lwCommodityDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
@Service
@Transactional
public class LwCommodityServiceImp implements lwCommodityService {
    @Autowired
    private lwCommodityDao lwCommodityDao;
    @Override
    public List<lwCommodity> findAllonsellCommodity() {
        return lwCommodityDao.findAllonsellCommodity();
    }
    @Override
    public List<lwCommodity> findAllselloutCommodity() {
        return lwCommodityDao.findAllselloutCommodity();
    }
    @Override
    public void saveCommodity(lwCommodity lwcommodity) {
        lwcommodity.setCommodityid(UUID.randomUUID().toString());
        lwCommodityDao.saveCommodity(lwcommodity);

    }

    @Override
    public void deleteCommodity(String commodityid) {
        lwCommodityDao.deleteCommodity(commodityid);

    }

    @Override
    public void updateCommodity(lwCommodity lwcommodity) {
        lwCommodityDao.updateCommodity(lwcommodity);

    }

    @Override
    public List<lwCommodity> findCommodityById(String commodityid) {
        return lwCommodityDao.findCommodityById(commodityid);
    }

    @Override
    public void tosellCommodity(String commodityid) {
        lwCommodityDao.tosellCommodity(commodityid);
    }

    @Override
    public void toselloutCommodity(String commodityid) {
        lwCommodityDao.toselloutCommodity(commodityid);
    }
}
