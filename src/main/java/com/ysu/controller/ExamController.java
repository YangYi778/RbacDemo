package com.ysu.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ysu.entity.*;
import com.ysu.service.ExamService;
import com.ysu.service.PaperService;
import com.ysu.service.QuestionService;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.*;

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
        PageHelper.startPage(pn,5);
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

    @RequestMapping(value = "deleteExam")
    public boolean deleteExam(@RequestParam("id") Integer id){
        System.out.println("&&&&&&&&&&&&&&&");
        System.out.println("id_+_+_+_" + id);
        try {
            examService.deleteExam(id);
            return true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
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
        PageHelper.startPage(pn,5);
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
     * @param
     * @return
     */
    @RequestMapping(value = "updateExam")
    public String updateExam(Exam exam){
        Exam result = examService.queryExamById(exam.getId());
        if(result != null){
            examService.updateExam(exam);
        }else{
            examService.insertExam(exam);
        }
        return "redirect:/exam/index";
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
    public String question(HttpServletRequest request,@RequestParam(value="pn", defaultValue="1")Integer pn, Model model) {
        //传入当前页，以及页面的大小
        PageHelper.startPage(pn,5);
        String eCode = request.getParameter("examCode");
        String keyword = request.getParameter("keyword");
        List<Exam> exams = examService.queryAllExams();
        model.addAttribute("exams",exams);

        Integer examCode = null;
        if(eCode != "" && eCode != null){
            examCode = Integer.parseInt(eCode);
        }
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

    @RequestMapping(value = "updateQuestion")
    public String updateQuestion(Question question){
        System.out.println("*****************");
        System.out.println("id" + question.getId());
        if(question.getId() != null){
            System.out.println("更新**********");
            questionService.updateQuestion(question);
        }else{
            System.out.println("插入******************----");
            question.setCreateDate(new Date());
            questionService.insertQuestion(question);
        }
        return "redirect:/exam/question";
    }
    @ResponseBody
    @RequestMapping(value = "deleteQuestion")
    public boolean deleteQuestion(@RequestParam("id") Integer id){
        System.out.println("&&&&&&&&&&&&&&&");
        System.out.println("id_+_+_+_" + id);
        try {
            questionService.deleteQuestion(id);
            return true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 自动生成试卷：随机从题库抽取一定数量和一定难度（可交由用户设置，也可固定试卷难度为ABC三档，A档试卷困难题大于0.8的占比20%，中档题大于0.4的占比50%，BC档以此类推）的题目并生成试卷（要求设计页面或弹出框来设置试卷属性）
     * 手动生成试卷：要求试题管理页面按考试科目显示试题列表，通过复选框或其他方式批量添加试题到试卷
     */
    @RequestMapping(value = "paper")
    public String paper(@RequestParam(value="pn", defaultValue="1")Integer pn,Model model) {
        //传入当前页，以及页面的大小
        PageHelper.startPage(pn,5);
        List<Paper> papers = paperService.queryAllPapersAdmin();
        List<Exam> exams = examService.queryAllExams();
        for(Paper paper: papers) {
            System.out.println(paper);
        }
        //pageinfo包装查询后的结果，只需要将pageinfo交给页面就行
        //封装了分页的信息,6表示底部连续显示的页数
        PageInfo page = new PageInfo(papers, 6);
        model.addAttribute("pageInfo",page);
        model.addAttribute("exams",exams);
        return "exam/paper";
    }

    @RequestMapping(value = "releasePaper")
    public boolean releasePaper(@RequestParam("id") Integer id) {
        System.out.println("&&&&&&&&&&&&&&&");
        System.out.println("id_+_+_+_" + id);
        try {
            paperService.releasePaperById(id);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    @RequestMapping(value = "deletePaper")
    public boolean deletePaper(@RequestParam("id") Integer id){
            System.out.println("&&&&&&&&&&&&&&&");
            System.out.println("id_+_+_+_" + id);
            try {
                paperService.deletePaperById(id);
                return true;
            }catch (Exception e){
                e.printStackTrace();
                return false;
            }
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
        //String[] times = paper.getExamTime().toString().split(":");
        //System.out.println("times === " + times);
        //String time = times[0] + ":" + times[1];
        //model.addAttribute("time", time);
        //System.out.println("time========" + time);
        model.addAttribute("paper",paper);
        //System.out.println("paperTime======" + paper.getExamTime());
        return "exam/startExam";
    }

    /*根据查询条件显示考试信息
      @param paperName
      @param examId
      @param pn
      @param model
      @return
      */
    @RequestMapping(value = "queryExam")
    public String queryExam(HttpServletRequest request, @RequestParam(value="pn", defaultValue="1")Integer pn, Model model){
        String paperName = request.getParameter("paperName");
        String pType = request.getParameter("paperType");
        String originPage = request.getParameter("originPage");
        Integer paperType = null;
        if(pType != "" && pType != null){
            paperType = Integer.parseInt(pType);
        }
        System.out.println("paperName ==="+ paperName +"*******paperType ====" + paperType);
        //传入当前页，以及页面的大小
        PageHelper.startPage(pn,5);
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
        if(originPage.equals("main")){
            return "exam/main";
        }else if(originPage.equals("paper")){
            return "exam/paper";
        }else{
            return "info/error";
        }
    }


    @ResponseBody
    @RequestMapping(value="paperSubmit")
    public Object paperSubmit(HttpServletRequest request, Model model){
        AjaxResult ajaxResult = new AjaxResult();
        try{
            String paperId = request.getParameter("paperId");
            String[] errorQue = request.getParameterValues("errorQue[]");
            String totalScore =  request.getParameter("totalScore");
            if(errorQue != null){
                for(String e : errorQue){
                    System.out.println(e);
                }
                int[] errorQueId = StringToInt(errorQue);
                System.out.println("***********************");
                List<Question> errorQuestions =  questionService.queryQuestionsByIds(errorQueId);
                for(Question err : errorQuestions){
                    System.out.println(err);
                }
                model.addAttribute("errorQuestions", errorQuestions);
            }
            model.addAttribute("paperId", paperId);
            model.addAttribute("totalScore", totalScore);
            ajaxResult.setSuccess(true);
        }catch (Exception e){
            e.printStackTrace();
            ajaxResult.setSuccess(false);
        }
        return ajaxResult;
    }

    public int[] StringToInt(String[] arrs){
        int[] ints = new int[arrs.length];
        for(int i=0;i<arrs.length;i++){
            ints[i] = Integer.parseInt(arrs[i]);
        }
        return ints;
    }
    @RequestMapping(value = "queryExamsByName")
    public String queryExamsByName(String examName, Model model,@RequestParam(value="pn", defaultValue="1")Integer pn){
        //传入当前页，以及页面的大小
        PageHelper.startPage(pn,5);
        System.out.println("examName====" + examName);
        List<Exam> exams = examService.queryExams(examName);
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
     * 将考试信息插入到数据库中并跳转到考试中心
     * @return
     */
    @RequestMapping(value = "close")
    public String close(int paperId, int userId, int userScore, Model model){
        System.out.println("****************");
        System.out.println("paperId====" + paperId);
        System.out.println("userId====" + userId);
        System.out.println("userScore====" + userScore);
        System.out.println("****************");
        //将考试记录插入到数据库中
        paperService.insertExamRecord(paperId,userId,userScore);
        model.addAttribute("userId",userId);
        return "info/close";
    }


    /**
     * 根据用户id查询考试记录并显示
     * @param
     * @param model
     * @param pn
     * @return
     */
    @RequestMapping(value = "examRecord")
    public String examRecord(HttpServletRequest request,Model model,@RequestParam(value="pn", defaultValue="1")Integer pn){
        User user = (User)request.getSession().getAttribute("user");
        int userId = user.getUserId();
        System.out.println("*********************");
        System.out.println("userId******=====" + userId);
        System.out.println("*********************");
        //传入当前页，以及页面的大小
        PageHelper.startPage(pn,5);
        //根据用户id查询考试记录
        List<Paper> papers = paperService.queryPapersByUserId(userId);
        for(Paper paper : papers){
            System.out.println(paper);
        }
        System.out.println("*********************");

        PageInfo page = new PageInfo(papers, 6);
        model.addAttribute("pageInfo",page);
        return "/exam/examRecord";
    }
    @ResponseBody
    @RequestMapping(value = "addPaper")
    public Integer addPaper(HttpServletRequest request){

        String paperName = request.getParameter("paperName");
        Integer examCode = Integer.parseInt(request.getParameter("examCode"));
        Integer singleQuestion = Integer.parseInt(request.getParameter("singleQuestion"));
        String paperDegree = request.getParameter("paperDegree");
        String examTime = request.getParameter("examTime");

        //根据科目类别查询当前题库数量是否满足
        List<Question> result = questionService.queryQuestionsByExamCode(examCode);
        if(result.size() < singleQuestion){
            return result.size();//单选题不符合条件
        }
        //计算试卷分数
        int totalScore = 0;
        List<Integer> queIds = new ArrayList<>();
        for(Question question : result.subList(0,singleQuestion)){
            totalScore += question.getQueScore();
            queIds.add(question.getId());
        }
        Paper paper = new Paper();
        paper.setPaperName(paperName);
        paper.setPaperType(examCode);
        paper.setSingleQueNum(singleQuestion);
        paper.setPaperDegree(paperDegree);
        paper.setPaperScore(totalScore);
        paper.setExamTime(strToTime(examTime));
        if(request.getParameter("id") != null){
            paper.setId(Integer.parseInt(request.getParameter("id")));
            paperService.updatePaper(paper);
        }else{
            paper.setCreateDate(new Date());

            paperService.insertPaper(paper);

            System.out.println("***********paperId" + paper.getId());
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("paperId", paper.getId());
            map.put("queIds", queIds);
            paperService.insertQuestionsToPaper(map);
        }
        return -1;
    }
    /**返回java.sql.Time格式
     * @param
     *
     * */
    public static Time strToTime(String strDate) {
        String str = strDate;
        SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss");
        java.util.Date d = null;
        try {
            d = format.parse(str);
        } catch (Exception e) {
            e.printStackTrace();
        }
        java.sql.Time time = new java.sql.Time(d.getTime());
        return time.valueOf(str);
    }

    //上传文件
    //@ResponseBody
    @RequestMapping(value = "fileUpload")
    public Object fileUpload(@RequestParam("file") MultipartFile file,
                             HttpServletRequest request, HttpServletResponse response){
        AjaxResult result = new AjaxResult();
        try{
            // @RequestParam("file") MultipartFile file 是用来接收前端传递过来的文件
            // 1.创建workbook对象，读取整个文档
            InputStream inputStream = file.getInputStream();
            POIFSFileSystem poifsFileSystem = new POIFSFileSystem(inputStream);
            HSSFWorkbook wb = new HSSFWorkbook(poifsFileSystem);
            // 2.读取页脚sheet
            HSSFSheet sheetAt = wb.getSheetAt(0);
            //3.循环读取某一行
            for (Row row : sheetAt){
                //4.读取每一行的单元格
                String stringCellValue = row.getCell(0).getStringCellValue();//第一列数据
                String stringCellValue2 = row.getCell(1).getStringCellValue();//第二列数据
                System.out.println("**************");
                System.out.println(stringCellValue);
                System.out.println("**************");
            }
            result.setSuccess(true);
        }catch (Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    @RequestMapping(value = "uploadFile")
    @ResponseBody
    public Map<String,String> uploadFile(MultipartFile excelFile){
        Map<String, String> ret = new HashMap<String, String >();
        if(excelFile == null){
            ret.put("type", "error");
            ret.put("msg", "请选择文件!");
            return ret;
        }
        return ret;
    }
}
