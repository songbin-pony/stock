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
public class lwCategory {
    private String ctype;
    private String cname;
    public String getType() {
        return ctype;
    }

    public void setType(String ctype) {
        this.ctype = ctype;
    }
}
