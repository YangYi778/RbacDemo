package com.ysu.service.impl;

import com.ysu.entity.Exam;
import com.ysu.repository.ExamRepository;
import com.ysu.service.ExamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by 万恶de亚撒西 on 2020/9/16.
 */
@Service(value = "examService")
public class ExamServiceImpl implements ExamService {

    @Autowired
    private ExamRepository examRepository;

    @Override
    public List<Exam> queryAllExams() {
        return examRepository.queryAllExams();
    }
}
