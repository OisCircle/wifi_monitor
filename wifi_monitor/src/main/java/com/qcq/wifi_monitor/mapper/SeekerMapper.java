package com.qcq.wifi_monitor.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.qcq.wifi_monitor.entity.Seeker;
@Repository
public interface SeekerMapper {
	public List<Seeker> selectAll();
	public Seeker selectOne(int id);
}
