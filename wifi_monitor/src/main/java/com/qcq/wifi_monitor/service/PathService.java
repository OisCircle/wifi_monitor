package com.qcq.wifi_monitor.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.qcq.wifi_monitor.entity.Path;
@Service
public interface PathService {
	public List<Path> selectByMac(String mac);
}
