package com.ysu.service;

import com.ysu.entity.Exam;

import java.util.List;

/**
 * Created by 万恶de亚撒西 on 2020/9/16.
 */
public interface ExamService {

    public List<Exam> queryAllExams();

    public List<Exam> queryExams(String examName);
}
