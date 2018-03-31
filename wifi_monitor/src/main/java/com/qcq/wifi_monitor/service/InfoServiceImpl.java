package com.qcq.wifi_monitor.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.qcq.wifi_monitor.dto.SeekerFilterDTO;
import com.qcq.wifi_monitor.entity.Info;
import com.qcq.wifi_monitor.entity.Seeker;
import com.qcq.wifi_monitor.mapper.InfoMapper;
@Service
public class InfoServiceImpl implements InfoService{
	@Resource
	InfoMapper mapper;
	@Override
	public List<Info> selectLatestInfos(SeekerFilterDTO dto) {
		List<Info> infos=mapper.selectLatestInfos(dto);
		return infos;
	}
	@Override
	public void insertSeeker(Seeker seeker) {
		mapper.insertSeeker(seeker);
	}
	@Override
	public void insertInfos(List<Info> infos) {
		mapper.insertInfos(infos);
	}
	@Override
	public List<Info> selectLatestInfosByMinute(SeekerFilterDTO dto) {
		return mapper.selectLatestInfosByMinute(dto);
	}

}
