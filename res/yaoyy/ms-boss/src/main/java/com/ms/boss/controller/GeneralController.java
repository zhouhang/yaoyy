package com.ms.boss.controller;

import com.ms.dao.model.Area;
import com.ms.dao.model.Code;
import com.ms.dao.vo.CodeVo;
import com.ms.service.AreaService;
import com.ms.service.CodeService;
import com.ms.tools.entity.Result;
import com.ms.tools.ueditor.CropInfo;
import com.ms.tools.ueditor.CropResult;
import com.ms.tools.ueditor.UEditorResult;
import com.ms.tools.upload.UploadService;
import com.ms.tools.utils.GsonUtil;
import com.ms.tools.utils.WebUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

import static com.ms.tools.utils.GsonUtil.*;

/**
 * 公共URL访问
 * Created by wangbin on 2016/6/27.
 */
@Controller
@RequestMapping(value = "gen")
public class GeneralController extends BaseController{

    @Autowired
    UploadService uploadService;

    @Autowired
    CodeService codeService;

    @Autowired
    AreaService areaService;

    /**
     * 上传商品图片信息
     * @param img
     * @return
     */
    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    @ResponseBody
    public CropResult updateFile(@RequestParam(required = false) MultipartFile img) throws Exception{
        return uploadService.uploadImage(img);
    }

    /**
     * 图片裁剪
     * @return
     */
    @RequestMapping(value = "/clipping", method = RequestMethod.POST)
    @ResponseBody
    public CropResult clipping(CropInfo cropInfo) throws Exception{
        return uploadService.cropImg(cropInfo);
    }


    /**
     * 富文本编辑器上传图片方法
     * @param upfile
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/uploadFile", method = RequestMethod.POST)
    @ResponseBody
    public UEditorResult updateUEditorFile(@RequestParam(required = false) MultipartFile upfile) throws Exception{
        CropResult cropResult = uploadService.uploadUeditorImage(upfile);
        return UEditorResult.success(upfile.getOriginalFilename(),upfile.getOriginalFilename(),cropResult.getUrl() );
    }

    /**
     *返回 code
     * @param code
     * @return
     */
    @RequestMapping(value = "/code/{code}", method = RequestMethod.POST)
    @ResponseBody
    public Result code(@PathVariable("code") String code) {
        CodeVo vo = new CodeVo();
        vo.setCode(code);

        return Result.success("code").data(codeService.findAllByParams(vo));
    }

    @RequestMapping(value = "/area")
    @ResponseBody
    public void area(HttpServletRequest request,
                     HttpServletResponse response,
                     @RequestParam(required = false) Integer parentId) {
        List<Area> areaList = null;
        //父类ID为空，查询全部省
        if (parentId == null) {
//            areaList = areaService.findByLevel(1);
        } else {
            areaList = areaService.findByParent(parentId);
        }

        String result = toJsonInclude(areaList, "id", "areaname");
        WebUtil.printJson(response, result);
    }
}