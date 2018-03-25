package com.qcq.wifi_monitor.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.qcq.wifi_monitor.entity.Path;
import com.qcq.wifi_monitor.service.PathService;

@RestController
public class PathController {
	@Resource
	PathService service;
	@RequestMapping(value="/path")
	public ModelAndView path(ModelAndView mv,String mac){
		List<Path> paths=service.selectByMac(mac);
		
		mv.getModelMap().put("paths", paths);
		mv.setViewName("path");
		return mv;
	}
	
	@RequestMapping(value="/linkPath")
	public ModelAndView linkPath(ModelAndView mv,String mac){
		List<Path> paths=service.selectByMac(mac);
		
		mv.getModelMap().put("paths", paths);
		mv.setViewName("linkPath");
		return mv;
	}
}
