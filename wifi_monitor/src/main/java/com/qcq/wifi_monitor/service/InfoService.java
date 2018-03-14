package com.qcq.wifi_monitor.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.qcq.wifi_monitor.entity.Info;
import com.qcq.wifi_monitor.entity.Phone;
import com.qcq.wifi_monitor.entity.S_P;
import com.qcq.wifi_monitor.entity.Seeker;
@Service
public interface InfoService {
	public List<Info> selectLatestInfos(int id);
	public void insertSeeker(Seeker seeker);
	public void insertPhones(List<Phone> phones);
	public void insertS_Ps(List<S_P> s_ps);
	public void insertInfos(List<Info> i);
}
