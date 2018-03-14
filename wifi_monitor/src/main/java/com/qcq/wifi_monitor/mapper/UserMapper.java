package com.qcq.wifi_monitor.mapper;

import org.springframework.stereotype.Repository;

import com.qcq.wifi_monitor.entity.User;
@Repository
public interface UserMapper {
	public User selectOne();
}
