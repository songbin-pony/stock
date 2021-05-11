package com.example.demo.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.experimental.Accessors;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Accessors(chain = true)
public class lwCommodity {
    private String commodityid;
    private String cname;
    private String price;
    private String description;
    private String categoryid;
    private String categoryname;
    private String link;
    private int stock;
    private String whetheronsell;

    public String getCommodityid() {
        return commodityid;
    }

    public void setCommodityid(String commodityid) {
        this.commodityid = commodityid;
    }
}
