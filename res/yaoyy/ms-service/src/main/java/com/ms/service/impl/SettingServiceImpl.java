package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.SettingDao;
import com.ms.dao.model.Setting;
import com.ms.dao.vo.SettingVo;
import com.ms.service.SettingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class SettingServiceImpl  extends AbsCommonService<Setting> implements SettingService{

	@Autowired
	private SettingDao settingDao;


	@Override
	public PageInfo<SettingVo> findByParams(SettingVo settingVo,Integer pageNum,Integer pageSize) {
    PageHelper.startPage(pageNum, pageSize);
    	List<SettingVo>  list = settingDao.findByParams(settingVo);
        PageInfo page = new PageInfo(list);
        return page;
	}

	@Override
	@Transactional
	public void save(Setting setting) {
		List<Setting> settingOld = findAll();
		if (settingOld.size() > 0) {
			setting.setId(settingOld.get(0).getId());
			update(setting);
		} else {
			create(setting);
		}
	}

	@Override
	@Transactional
	public void tel(String tel) {
		Setting setting = new Setting();
		setting.setConsumerHotline(tel);
		save(setting);
	}

	@Override
	@Transactional
	public void bank(String account, String card, String bank) {
		Setting setting = new Setting();
		setting.setPayBankCard(card);
		setting.setPayAccount(account);
		setting.setPayBank(bank);
		save(setting);
	}

	@Override
	public Setting find() {
		Setting setting = null;
		List<Setting> settingOld = findAll();
		if (settingOld.size() > 0) {
			setting = settingOld.get(0);
		}
		return setting;
	}

	@Override
	public ICommonDao<Setting> getDao() {
		return settingDao;
	}

}
