package com.ysu.service;

import com.ysu.entity.Paper;

import java.util.List;

/**
 * Created by 万恶de亚撒西 on 2020/9/17.
 */
public interface PaperService {

    public List<Paper> queryAllPapers();

    public Paper queryPaperById(int id);

    public List<Paper> queryPapersByExamId(int examId);

    public List<Paper> queryPapersByConditions(String paperName, Integer paperType);
}
