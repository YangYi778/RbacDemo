package com.ysu.entity;

import lombok.Data;

import java.util.Date;

/**
 * Created by 万恶de亚撒西 on 2020/9/15.
 */
@Data
public class Role {
    private Integer roleId;
    private String roleName;
    private String roleContent;
    private Integer cteator;
    private Date createDate;
    private Integer updater;
    private Date updateDate;
}
