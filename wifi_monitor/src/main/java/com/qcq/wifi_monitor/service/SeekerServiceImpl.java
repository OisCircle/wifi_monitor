package com.qcq.wifi_monitor.service;

import java.util.List;

import javax.annotation.Resource;

import com.qcq.wifi_monitor.entity.Seeker;
import com.qcq.wifi_monitor.mapper.SeekerMapper;

public class SeekerServiceImpl implements SeekerService{
	@Resource
	SeekerMapper sm;
	@Override
	public List<Seeker> selectAll() {
		List<Seeker> seekers=sm.selectAll();
		return seekers;
	}

	@Override
	public Seeker selectOne() {
		//88733613是暂定的值，以后要修改
		Seeker seeker=sm.selectOne(8733613);
		return seeker;
	}
	
}
