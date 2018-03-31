package com.qcq.wifi_monitor.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.qcq.wifi_monitor.dto.SeekerFilterDTO;
import com.qcq.wifi_monitor.entity.Info;
import com.qcq.wifi_monitor.entity.Seeker;
@Service
public interface InfoService {
	public List<Info> selectLatestInfos(SeekerFilterDTO dto);
	public void insertSeeker(Seeker seeker);
	public void insertInfos(List<Info> i);
	public List<Info> selectLatestInfosByMinute(SeekerFilterDTO dto);
}
