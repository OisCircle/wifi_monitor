package com.qcq.wifi_monitor.mapper;

import com.qcq.wifi_monitor.dto.IndoorPathDTO;
import com.qcq.wifi_monitor.entity.Path;

import java.util.List;

public interface PathMapper {
	public void insertPaths(List<Path> paths);

	public List<Path> selectByMac(String mac);

	public int selectCountByMac(String mac);

	public List<Path> selectByMacAndZoneId(IndoorPathDTO dto);
}
