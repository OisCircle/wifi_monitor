package com.qcq.wifi_monitor.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.qcq.wifi_monitor.dto.SeekerTimeSearchingDTO;
import com.qcq.wifi_monitor.entity.Info;
import com.qcq.wifi_monitor.entity.Phone;
import com.qcq.wifi_monitor.entity.S_P;
import com.qcq.wifi_monitor.entity.Seeker;
import com.qcq.wifi_monitor.mapper.InfoMapper;
@Service
public class InfoServiceImpl implements InfoService{
	@Resource
	InfoMapper mapper;
	@Override
	public List<Info> selectLatestInfos(int id) {
		List<Info> infos=mapper.selectLatestInfos(id);
		return infos;
	}
	@Override
	public void insertSeeker(Seeker seeker) {
		mapper.insertSeeker(seeker);
	}
	@Override
	public void insertPhones(List<Phone> phones) {
		mapper.insertPhones(phones);
	}
	@Override
	public void insertS_Ps(List<S_P> s_ps) {
		mapper.insertS_Ps(s_ps);
	}
	@Override
	public void insertInfos(List<Info> infos) {
		mapper.insertInfos(infos);
	}
	@Override
	public List<Info> selectLatestInfosByHour(SeekerTimeSearchingDTO dto) {
		return mapper.selectLatestInfosByHour(dto);
	}
	@Override
	public List<Info> selectLatestInfosByMinute(SeekerTimeSearchingDTO dto) {
		return mapper.selectLatestInfosByMinute(dto);
	}

}
