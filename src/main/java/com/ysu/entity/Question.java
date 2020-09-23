package com.ysu.entity;

import lombok.Data;

import java.util.Date;

/**
 * Created by 万恶de亚撒西 on 2020/9/16.
 */
@Data
public class Question {
    private Integer id;
    private String queInfo;
    private String queType;
    private int queScore;
    private String optA;
    private String optB;
    private String optC;
    private String optD;
    private String answer;
    private Date createDate;
    private int examCode;
    private double degree;
}
