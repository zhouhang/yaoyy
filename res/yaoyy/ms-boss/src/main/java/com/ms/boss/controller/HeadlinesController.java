package com.ms.boss.controller;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.Article;
import com.ms.dao.vo.ArticleTagVo;
import com.ms.dao.vo.ArticleVo;
import com.ms.service.ArticleService;
import com.ms.tools.annotation.SecurityToken;
import com.ms.tools.entity.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Author: koabs
 * 4/20/17.
 * 药商头条管理
 */
@Controller
@RequestMapping("/headlines/")
public class HeadlinesController {
    @Autowired
    private ArticleService articleService;

    /**
     * @param articleVo
     * @param pageNum
     * @param pageSize
     * @param model
     * @return
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public String list(ArticleVo articleVo, Integer pageNum, Integer pageSize, ModelMap model) {
        articleVo.setType(2);
        PageInfo<ArticleVo> pageInfo = articleService.headlinesList(articleVo, pageNum, pageSize);
        model.put("pageInfo", pageInfo);
        return "headlines_list";
    }

    /**
     * 添加文章页面
     * @return
     */
    @RequestMapping(value="create",method= RequestMethod.GET)
    @SecurityToken(generateToken = true)
    public String createArticle(ModelMap model){
        // 获取所有的标签列表
        List<ArticleTagVo> list = articleService.tags();
        model.put("tags",list);
        return "headlines_edit";
    }


    /**
     * 保存文章
     * @param article
     * @return
     */
    @RequestMapping(value="save",method = RequestMethod.POST)
    @ResponseBody
    @SecurityToken(validateToken=true)
    public Result save(ArticleVo article){
        articleService.createTouTiao(article);
        return Result.success().msg("修改成功");
    }

    @RequestMapping(value="editor/{id}",method = RequestMethod.GET)
    @SecurityToken(generateToken = true)
    public String edit(@PathVariable("id") Integer id,ModelMap model){
        ArticleVo article = articleService.findVoById(id);
        model.put("article", article);
        // 获取所有的标签列表
        List<ArticleTagVo> list = articleService.tags();
        model.put("tags",list);
        return "headlines_edit";
    }
}
