package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.CommodityDao;
import com.ms.dao.ICommonDao;
import com.ms.dao.CategoryDao;
import com.ms.dao.model.Category;
import com.ms.dao.model.Commodity;
import com.ms.dao.vo.CategoryVo;
import com.ms.dao.vo.CommodityVo;
import com.ms.service.CategorySearchService;
import com.ms.service.CategoryService;
import com.ms.dao.enums.CategoryEnum;
import com.ms.service.CommodityService;
import com.ms.tools.upload.PathConvert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CategoryServiceImpl  extends AbsCommonService<Category> implements CategoryService{

	@Autowired
	private CategoryDao categoryDao;

	@Autowired
	private PathConvert pathConvert;

	@Autowired
	private CommodityService commodityService;

	@Autowired
	private CommodityDao commodityDao;


	//@Autowired
	//private CategorySearchService categorySearchService;

	/**
	 * 品种图片保存路径
	 */
	private String folderName = "category/";


	@Override
	public PageInfo<CategoryVo> findByParams(CategoryVo categoryVo,Integer pageNum,Integer pageSize) {

		pageNum = pageNum==null?1:pageNum;
		pageSize = pageSize==null?10:pageSize;
    	PageHelper.startPage(pageNum, pageSize);
    	List<CategoryVo>  list = categoryDao.findByParams(categoryVo);
		list.forEach(category->{
			category.setPictureUrl(pathConvert.getUrl(category.getPictureUrl()));
		});
        PageInfo page = new PageInfo(list);
        return page;
	}

	@Override
	public List<CategoryVo> findAllCategory(CategoryVo categoryVo) {
		List<CategoryVo> list=categoryDao.findAllCategory(categoryVo);
		return list;
	}

	@Override
	public List<CategoryVo> searchCategory(CategoryVo categoryVo) {
		List<CategoryVo> categoryVoList=categoryDao.findByParams(categoryVo);
		categoryVoList.forEach(category->{
			category.setPictureUrl(pathConvert.getUrl(category.getPictureUrl()));
		});
		return categoryVoList ;
	}

	@Override
	@Transactional
	public void save(CategoryVo categoryVo) {
		categoryVo.setPictureUrl(pathConvert.saveFileFromTemp(categoryVo.getPictureUrl(),folderName));
		Date now=new Date();
		if (categoryVo.getStatus()==null){
			categoryVo.setStatus(CategoryEnum.STATUS_ON.getValue());
		}
		if (categoryVo.getLevel()==null){
			categoryVo.setLevel(CategoryEnum.LEVEL_BREED.getValue());
		}
		if (categoryVo.getId()==null){
			categoryVo.setCreateTime(now);
			categoryVo.setUpdateTime(now);
			categoryDao.create(categoryVo);
		}
		else{
			categoryVo.setUpdateTime(now);
			categoryDao.update(categoryVo);
			//如果下架品种对应所有商品进行下架处理

			Commodity commodity=new Commodity();
			commodity.setCategoryId(categoryVo.getId());
			commodity.setStatus(categoryVo.getStatus());
			commodityService.updateStatusByCategoryId(commodity);
		}
		//categorySearchService.save(categoryVo);

	}

	@Override
	public Category findById(Integer id) {
		Category category=categoryDao.findById(id);
		category.setPictureUrl(pathConvert.getUrl(category.getPictureUrl()));
		return category;
	}

	@Override
	public CategoryVo getVoById(Integer id) {
		return categoryDao.getVoById(id);
	}

	@Override
	public PageInfo<CategoryVo> findVoByPage(int pageSize, int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		List<CategoryVo>  list = categoryDao.findVoByPage();
		PageInfo page = new PageInfo(list);
		return page;

	}


	@Override
	public ICommonDao<Category> getDao() {
		return categoryDao;
	}

	@Override
	@Transactional
	public int deleteById(int id) {
		//categorySearchService.deleteByCategoryId(id);
		commodityDao.deleteByCategoryId(id);
		return super.deleteById(id);
	}

	@Override
	public PageInfo<CategoryVo> findByParamsBiz(CategoryVo categoryVo, Integer pageNum, Integer pageSize) {
		PageInfo<CategoryVo> pageInfo = findByParams(categoryVo,pageNum,pageSize);
		List<CategoryVo>  list = pageInfo.getList();
		Iterator<CategoryVo> iter = list.iterator();
		while(iter.hasNext()){
			CategoryVo vo = iter.next();
			CommodityVo commodity = minimumCommodity(vo.getId());
			if (commodity!= null ){
				vo.setDefaultCommodityId(commodity.getId());
				vo.setDefaultCommodityPrice(commodity.getPrice());
				vo.setDefaultCommodityUnitName(commodity.getUnitName());
			} else {
				iter.remove();
			}
		}
		pageInfo.setList(list);
		return pageInfo;
	}

	@Override
	public List<CategoryVo> findByIds(String ids) {
		if(ids == null)
			return null;
		List<Integer> list = new ArrayList<>();
		for(String id :ids.split(",")){
			list.add(Integer.parseInt(id));
		}
		return categoryDao.findByIds(list);

	}


	/**
	 * 查找最低价商品
	 * @param categoryId
	 * @return
     */
	public CommodityVo minimumCommodity(Integer categoryId){
		List<CommodityVo> commodities = commodityService.findByCategoryId(categoryId);
		if(commodities.isEmpty()){
			return null;
		}
		commodities.sort((CommodityVo c1,CommodityVo c2)->c1.getPrice().compareTo(c2.getPrice()));
		return commodities.get(0);
	}





}
