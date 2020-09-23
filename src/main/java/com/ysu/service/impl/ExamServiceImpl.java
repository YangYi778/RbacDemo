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

    @Override
    public List<Exam> queryExams(String examName) {
        return examRepository.queryExams(examName);
    }

    @Override
    public void updateExam(Exam exam) {
        examRepository.updateExam(exam);
    }

    @Override
    public Exam queryExamById(Integer id) {
        return examRepository.queryExamById(id);
    }

    @Override
    public void insertExam(Exam exam) {
        examRepository.insertExam(exam);
    }

    @Override
    public void deleteExam(Integer id) {
        examRepository.deleteExam(id);
    }


}
