package com.qcq.wifi_monitor.service;

import java.util.List;

import com.qcq.wifi_monitor.entity.Path;

public interface PathService {
	public List<Path> selectByMac(String mac);
}
