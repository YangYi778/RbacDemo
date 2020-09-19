package com.ysu.service.impl;

import com.ysu.entity.Paper;
import com.ysu.repository.PaperRepository;
import com.ysu.service.PaperService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by 万恶de亚撒西 on 2020/9/17.
 */
@Service(value = "paperService")
public class PaperServiceImpl implements PaperService {

    @Autowired
    private PaperRepository paperRepository;
    @Override
    public List<Paper> queryAllPapers() {
        return paperRepository.queryAllPapers();
    }

    @Override
    public Paper queryPaperById(int id) {
        return paperRepository.queryPaperById(id);
    }

    @Override
    public List<Paper> queryPapersByExamId(int examId) {
        return paperRepository.queryPapersByExamId(examId);
    }

    @Override
    public List<Paper> queryPapersByConditions(String paperName, Integer paperType) {
        return paperRepository.queryPapersByConditions(paperName,paperType);
    }
}
