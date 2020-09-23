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
    public List<Question> queryAllQuestions(Integer examCode, String keyword) {
        return questionRepository.queryAllQuestions(examCode,keyword);
    }

    @Override
    public List<Question> queryQuestionsByPaperId(int paperId) {
        return questionRepository.queryQuestionsByPaperId(paperId);
    }

    @Override
    public List<Question> queryQuestionsByIds(int[] ids) {
        return questionRepository.queryQuestionsByIds(ids);
    }

    @Override
    public void insertQuestion(Question question) {
        questionRepository.insertQuestion(question);
    }

    @Override
    public void updateQuestion(Question question) {
        questionRepository.updateQuestion(question);
    }

    @Override
    public void deleteQuestion(Integer id) {
        questionRepository.deleteQuestion(id);
    }

    @Override
    public List<Question> queryQuestionsByExamCode(Integer examCode) {
        return questionRepository.queryQuestionsByExamCode(examCode);
    }
}
