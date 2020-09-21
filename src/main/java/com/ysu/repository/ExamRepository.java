package com.ysu.repository;

import com.ysu.entity.Exam;
import lombok.Data;

import java.util.List;

/**
 * Created by 万恶de亚撒西 on 2020/9/16.
 */

public interface ExamRepository {

    public List<Exam> queryAllExams();

    public List<Exam> queryExams(String examName);


}
