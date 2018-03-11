package com.qcq.wifi_monitor.mapper;

import java.util.List;

import com.qcq.wifi_monitor.entity.Seeker;

public interface SeekerMapper {
	public List<Seeker> selectAll();
	public Seeker selectOne(int id);
}
