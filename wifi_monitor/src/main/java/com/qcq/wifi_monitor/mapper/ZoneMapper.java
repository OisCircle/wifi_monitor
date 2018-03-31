package com.qcq.wifi_monitor.mapper;

import java.util.List;

import com.qcq.wifi_monitor.entity.Zone;

public interface ZoneMapper {
	public Zone selectOne(int id);
	public List<Zone> selectAll();
	public void update(Zone zone);
	public void add(Zone zone);
	public void delete(int id);
}
