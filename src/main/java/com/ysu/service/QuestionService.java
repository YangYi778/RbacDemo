package com.ysu.service;

import com.ysu.entity.Question;
import org.apache.commons.collections4.QueueUtils;

import java.util.List;

/**
 * Created by 万恶de亚撒西 on 2020/9/16.
 */
public interface QuestionService {

    public List<Question> queryAllQuestions(Integer examCode, String keyword);

    public List<Question> queryQuestionsByPaperId(int paperId);

    public List<Question> queryQuestionsByIds(int[] ids);

    public void insertQuestion(Question question);

    public void updateQuestion(Question question);

    public void deleteQuestion(Integer id);
}
