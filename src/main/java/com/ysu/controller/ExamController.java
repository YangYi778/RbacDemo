package com.ysu.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ysu.entity.Exam;
import com.ysu.entity.Paper;
import com.ysu.entity.Question;
import com.ysu.entity.User;
import com.ysu.service.ExamService;
import com.ysu.service.PaperService;
import com.ysu.service.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import sun.security.krb5.internal.PAEncTSEnc;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by 万恶de亚撒西 on 2020/9/16.
 */
@Controller
@RequestMapping(value = "/exam")
public class ExamController {

    @Autowired
    private ExamService examService;
    @Autowired
    private QuestionService questionService;
    @Autowired
    private PaperService paperService;

    /**
     * 考试中心首页——用户查看当前发布的考试信息列表，并选择是否进入考试
     * @param pn
     * @param model
     * @return
     */
    @RequestMapping(value = "main")
    public String main(String examCode, String keyword,@RequestParam(value="pn", defaultValue="1")Integer pn, Model model) {

        List<Exam> exams = examService.queryAllExams();
        //传入当前页，以及页面的大小
        PageHelper.startPage(pn,2);
        List<Paper> papers = paperService.queryAllPapers();
        for(Paper paper: papers) {
            System.out.println(paper);
        }
        //pageinfo包装查询后的结果，只需要将pageinfo交给页面就行
        //封装了分页的信息,6表示底部连续显示的页数
        PageInfo page = new PageInfo(papers, 6);
        model.addAttribute("pageInfo",page);
        model.addAttribute("exams",exams);
        return "exam/main";
    }

    /**
     * 考试科目管理首页——展示当前已存在的考试科目信息
     * @param pn
     * @param model
     * @return
     */
    @RequestMapping(value = "index")
    public String index(@RequestParam(value="pn", defaultValue="1")Integer pn, Model model) {
        //传入当前页，以及页面的大小
        PageHelper.startPage(pn,2);
        List<Exam> exams = examService.queryAllExams();
        for(Exam exam: exams) {
            System.out.println(exam);
        }
        //pageinfo包装查询后的结果，只需要将pageinfo交给页面就行
        //封装了分页的信息,6表示底部连续显示的页数
        PageInfo page = new PageInfo(exams, 6);
        model.addAttribute("pageInfo",page);
        return "exam/index";
    }

    /**
     * 修改考试科目
     * @param id
     * @return
     */
    @RequestMapping(value = "updateExam")
    public String updateExam(int id){
        //修改考试科目信息
        return "exam/index";
    }

    /**
     * 查询所有的考试科目——测试使用
     * @return
     */
    @RequestMapping(value = "queryAllExams")
    public String queryAllExams(){
        return "exam/index";
    }

    /**
     * 试题管理首页——展示题库已存在的试题信息列表
     * @param pn
     * @param model
     * @return
     */
    @RequestMapping(value = "question")
    public String question(String examCode, String keyword,@RequestParam(value="pn", defaultValue="1")Integer pn, Model model) {
        //传入当前页，以及页面的大小
        PageHelper.startPage(pn,2);
        List<Question> questions = questionService.queryAllQuestions(examCode,keyword);
        for(Question question: questions) {
            System.out.println(question);
        }
        //pageinfo包装查询后的结果，只需要将pageinfo交给页面就行
        //封装了分页的信息,6表示底部连续显示的页数
        PageInfo page = new PageInfo(questions, 6);
        model.addAttribute("pageInfo",page);
        return "exam/question";
    }

    /**
     * 自动生成试卷：随机从题库抽取一定数量和一定难度（可交由用户设置，也可固定试卷难度为ABC三档，A档试卷困难题大于0.8的占比20%，中档题大于0.4的占比50%，BC档以此类推）的题目并生成试卷（要求设计页面或弹出框来设置试卷属性）
     * 手动生成试卷：要求试题管理页面按考试科目显示试题列表，通过复选框或其他方式批量添加试题到试卷
     */
    @RequestMapping(value = "paper")
    public String paper(String examCode, String keyword,@RequestParam(value="pn", defaultValue="1")Integer pn, Model model) {
        //传入当前页，以及页面的大小
        PageHelper.startPage(pn,1);
        List<Paper> papers = paperService.queryAllPapers();
        for(Paper paper: papers) {
            System.out.println(paper);
        }
        //pageinfo包装查询后的结果，只需要将pageinfo交给页面就行
        //封装了分页的信息,6表示底部连续显示的页数
        PageInfo page = new PageInfo(papers, 6);
        model.addAttribute("pageInfo",page);
        return "exam/paper";
    }

    /**
     * 考试信息显示页面——用于显示当前已发布的考试信息列表
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "startExam")
    public String startExam(int id,Model model){

        Paper paper = paperService.queryPaperById(id);
        System.out.println("考试试卷为：" + paper);
        List<Question> questions = questionService.queryQuestionsByPaperId(id);
        for(Question question: questions) {
            System.out.println(questions);
        }
        model.addAttribute("questions", questions);
        model.addAttribute("paper",paper);
        System.out.println("paperTime======" + paper.getExamTime());
        return "exam/startExam";
    }

    /*根据查询条件显示考试信息
      @param paperName
      @param examId
      @param pn
      @param model
      @return*/
    @RequestMapping(value = "queryExam")
    public String queryExam(HttpServletRequest request, @RequestParam(value="pn", defaultValue="1")Integer pn, Model model){
        String paperName = request.getParameter("paperName");
        String pType = request.getParameter("paperType");
        Integer paperType = null;
        if(pType != ""){
            paperType = Integer.parseInt(pType);
        }
        System.out.println("paperName ==="+ paperName +"*******paperType ====" + paperType);
        //传入当前页，以及页面的大小
        PageHelper.startPage(pn,1);
//        List<Paper> papers = paperService.queryPapersByExamId(examId);
        List<Paper> papers = paperService.queryPapersByConditions(paperName,paperType);
        for(Paper paper: papers) {
            System.out.println(paper);
        }
        //pageinfo包装查询后的结果，只需要将pageinfo交给页面就行
        //封装了分页的信息,6表示底部连续显示的页数
        List<Exam> exams = examService.queryAllExams();
        model.addAttribute("exams",exams);
        PageInfo page = new PageInfo(papers, 6);
        model.addAttribute("pageInfo",page);
        return "exam/main";
    }

    @RequestMapping(value = "deleteQuestion")
    public String deleteQuestion(int id){
        questionService.deleteQuestion(id);
        return "";
    }
}
