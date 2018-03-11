package com.qcq.wifi_monitor.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.qcq.wifi_monitor.entity.User;
import com.qcq.wifi_monitor.mapper.UserMapper;

@Service
public class UserService {
	@Resource
	UserMapper tm;
	public User selectOne(){
		return tm.selectOne();
	}
}
