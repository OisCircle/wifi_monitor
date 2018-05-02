package com.qcq.wifi_monitor.service;

import java.util.List;

import javax.annotation.Resource;

import com.qcq.wifi_monitor.dto.SeekerLocation;
import org.springframework.stereotype.Service;

import com.qcq.wifi_monitor.entity.Seeker;
import com.qcq.wifi_monitor.mapper.SeekerMapper;
@Service
public class SeekerServiceImpl implements SeekerService{
	@Resource
	SeekerMapper sm;
	@Override
	public List<Seeker> selectAll() {
		List<Seeker> seekers=sm.selectAll();
		return seekers;
	}

	@Override
	public Seeker selectOne(int id) {
		Seeker seeker=sm.selectOne(id);
		return seeker;
	}

	@Override
	public String add(Seeker seeker) {
		sm.add(seeker);
		return "添加成功";
	}

	@Override
	public String deleteById(int id) {
		sm.deleteById(id);
		return "删除成功";
	}

	@Override
	public String update(Seeker seeker) {
		sm.update(seeker);
		return "更新成功";
	}

	@Override
	public String setIsForbidden(Seeker seeker) {
		sm.setIsForbidden(seeker);
		return "更改成功";
	}

	@Override
	public List<Seeker> selectByZoneId(int id) {
		return sm.selectByZoneId(id);
	}

	@Override
	public SeekerLocation getLocationAndRssi(String mac, int seeker_id) {
		return sm.getLocationAndRssi(mac, seeker_id);
	}

}
