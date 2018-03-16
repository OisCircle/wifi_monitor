package com.qcq.wifi_monitor.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.qcq.wifi_monitor.entity.Path;
import com.qcq.wifi_monitor.service.PathService;

@RestController
public class PathController {
	@Resource
	PathService service;
	@ResponseBody
	@RequestMapping(value="/path")
	public List<Path> path(String mac){
		List<Path> paths=service.selectByMac(mac);
		System.out.println(paths.get(0).getStart_time());
		System.out.println(paths.get(0).getEnd_time());
		
		return paths;
	}
}
