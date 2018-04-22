package com.qcq.wifi_monitor.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.qcq.wifi_monitor.dto.IndoorPathDTO;
import com.qcq.wifi_monitor.entity.Path;
import com.qcq.wifi_monitor.mapper.PathMapper;
@Service
public class PathServiceImpl implements PathService{
	@Resource
	PathMapper mapper;
	@Override
	public List<Path> selectByMac(String mac) {
		return mapper.selectByMac(mac);
	}

	@Override
	public int selectCountByMac(String mac) {
		return mapper.selectCountByMac(mac);
	}

	@Override
	public List<Path> selectByMacAndZoneId(IndoorPathDTO dto) {
		return mapper.selectByMacAndZoneId(dto);
	}
}
