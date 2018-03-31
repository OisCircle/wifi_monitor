package com.qcq.wifi_monitor.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.qcq.wifi_monitor.entity.Seeker;
@Repository
public interface SeekerMapper {
	public List<Seeker> selectAll();
	public Seeker selectOne(int id);
	public void add(Seeker seeker);
	public void deleteById(int id);
	public void update(Seeker seeker);
	public void setIsForbidden(Seeker seeker);
}
