package com.ysu.repository;

import com.ysu.entity.Question;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by 万恶de亚撒西 on 2020/9/16.
 */
public interface QuestionRepository {

    public List<Question> queryAllQuestions(@Param("examCode")Integer examCode, @Param("keyword")String keyword);

    public List<Question> queryQuestionsByPaperId(int paperId);

    public List<Question> queryQuestionsByIds(int[] ids);

    public void insertQuestion(Question question);

    public void updateQuestion(Question question);

    public void deleteQuestion(Integer id);
}
