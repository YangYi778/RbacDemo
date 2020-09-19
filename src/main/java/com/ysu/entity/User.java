package com.ysu.entity;

import lombok.Data;

import java.util.Date;

/**
 * Created by 万恶de亚撒西 on 2020/9/14.
 */
@Data
public class User {
    private Integer userId;
    private String userName;
    private String password;
    private String userTrueName;
    private String userState;
    private Integer creator;
    private Date createDate;
    private Integer updater;
    private Date updateDate;
    private String email;
    private String active;
}
