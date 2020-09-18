package com.ysu.repository;

import com.ysu.entity.Question;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by 万恶de亚撒西 on 2020/9/16.
 */
public interface QuestionRepository {

    public List<Question> queryAllQuestions(@Param("examCode")String examCode, @Param("keyword")String keyword);

    public List<Question> queryQuestionsByPaperId(int paperId);
}
