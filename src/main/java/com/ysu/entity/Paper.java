package com.ysu.entity;

import lombok.Data;

import java.sql.Time;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by 万恶de亚撒西 on 2020/9/17.
 */
@Data
public class Paper {

    private int id;
    private String paperName;
    private Integer paperType;
    private String paperDegree;
    private int paperScore;
    private int singleQueNum;
    private Time examTime;
    private Date createDate;
    private int paperStatus;
    private int userId;

    private int userScore;

    private List<Question> questions = new ArrayList<>();
}
