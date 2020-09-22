package com.ysu.service.impl;

import com.ysu.entity.Question;
import com.ysu.repository.QuestionRepository;
import com.ysu.service.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by 万恶de亚撒西 on 2020/9/16.
 */
@Service(value = "questionService")
public class QuestionServiceImpl implements QuestionService {

    @Autowired
    private QuestionRepository questionRepository;


    @Override
    public List<Question> queryAllQuestions(String examCode, String keyword) {
        return questionRepository.queryAllQuestions(examCode,keyword);
    }

    @Override
    public List<Question> queryQuestionsByPaperId(int paperId) {
        return questionRepository.queryQuestionsByPaperId(paperId);
    }

    @Override
    public void deleteQuestion(int id) {
        questionRepository.deleteQuestion(id);
    }
}
