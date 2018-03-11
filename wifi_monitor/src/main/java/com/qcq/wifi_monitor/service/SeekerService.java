package com.qcq.wifi_monitor.service;

import java.util.List;

import com.qcq.wifi_monitor.entity.Seeker;

public interface SeekerService {
	public List<Seeker> selectAll();
	public Seeker selectOne();
}
