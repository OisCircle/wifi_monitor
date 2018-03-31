package com.qcq.wifi_monitor.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.qcq.wifi_monitor.entity.Zone;
@Service
public interface ZoneService {
	public Zone selectOne(int id);
	public List<Zone> selectAll();
	public String update(Zone zone);
	public String add(Zone zone);
	public String delete(int id);
}
