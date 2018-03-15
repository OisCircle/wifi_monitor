package com.qcq.wifi_monitor.mapper;

import java.util.List;

import com.qcq.wifi_monitor.entity.Path;

public interface PathMapper {
	public void insertPaths(List<Path> paths);
	public List<Path> selectByMac(String mac);
}
