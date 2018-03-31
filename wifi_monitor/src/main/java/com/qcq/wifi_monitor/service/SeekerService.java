package com.qcq.wifi_monitor.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.qcq.wifi_monitor.entity.Seeker;
@Service
public interface SeekerService {
	public List<Seeker> selectAll();
	public Seeker selectOne(int id);
	public String add(Seeker seeker);
	public String deleteById(int id);
	public String update(Seeker seeker);
	public String setIsForbidden(Seeker seeker);
}
