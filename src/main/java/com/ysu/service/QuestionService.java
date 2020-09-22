package com.ysu.service;

import com.ysu.entity.Question;

import java.util.List;

/**
 * Created by 万恶de亚撒西 on 2020/9/16.
 */
public interface QuestionService {

    public List<Question> queryAllQuestions(String examCode, String keyword);

    public List<Question> queryQuestionsByPaperId(int paperId);

    public void deleteQuestion(int id);
}
