package com.qcq.wifi_monitor.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.qcq.wifi_monitor.entity.Zone;
import com.qcq.wifi_monitor.mapper.ZoneMapper;
@Service
public class ZoneServiceImpl implements ZoneService{
	@Resource
	ZoneMapper mapper;
	@Override
	public Zone selectOne(int id) {
		return mapper.selectOne(id);
	}
	@Override
	public List<Zone> selectAll() {
		return mapper.selectAll();
	}
	@Override
	public String update(Zone zone) {
		String status="更新成功";
		try {
			mapper.update(zone);
		} catch (Exception e) {
			status="更新失败,请查看后台";
		}
		return status;
	}
	@Override
	public String add(Zone zone) {
		mapper.add(zone);
		String status="添加成功";
		if(zone.getId()==0)
			status="添加失败，请确认地图名称是否重复...";
		return status;
	}
	@Override
	public String delete(int id) {
		String status="删除成功";
		try {
			mapper.delete(id);
		} catch (Exception e) {
			status="删除失败...请查看后台";
		}
		return status;
	}
}
