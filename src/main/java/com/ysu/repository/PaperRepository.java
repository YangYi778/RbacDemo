package com.ysu.repository;

import com.ysu.entity.Paper;

import java.util.List;
import java.util.Map;

/**
 * Created by 万恶de亚撒西 on 2020/9/17.
 */
public interface PaperRepository {

    public List<Paper> queryAllPapers();

    public Paper queryPaperById(int id);

    public List<Paper> queryPapersByExamId(int examId);

    public List<Paper> queryPapersByConditions(String paperName, Integer paperType);

    public List<Paper> queryPapersByUserId(int userId);

    public void insertExamRecord(int paperId, int userId, int userScore);

    public void insertPaper(Paper paper);

    public void insertQuestionsToPaper(Map<String,Object> map);
}
