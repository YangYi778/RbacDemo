package com.ysu.entity;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by 万恶de亚撒西 on 2020/9/15.
 */
@Data
public class Auth {
    private Integer id;
    private String name;
    private String authUrl;
    private Integer authParentRoot;
    private String authIsRoot;
    private String icon;
    private boolean open=true;

    //自关联
    private List<Auth> children = new ArrayList();
    public List<Auth> getChildren() {
        return children;
    }

    public void setChildren(List<Auth> children) {
        this.children = children;
    }
}
