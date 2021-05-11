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
public class lwUser {
    private String userid;
    private String username;
    private String password;
    private double balance;

    public void setBalance(double balance) {
        this.balance = balance;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public double getBalance() {
        return balance;
    }

}
