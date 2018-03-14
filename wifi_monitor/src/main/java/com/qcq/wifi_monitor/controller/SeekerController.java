package com.qcq.wifi_monitor.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.qcq.wifi_monitor.entity.Info;
import com.qcq.wifi_monitor.entity.Seeker;
import com.qcq.wifi_monitor.service.InfoService;
import com.qcq.wifi_monitor.service.SeekerService;

@RestController
public class SeekerController {
	@Resource
	SeekerService seekerService;
	@Resource
	InfoService infoService;
	@RequestMapping(value="/index")
	public ModelAndView index(ModelAndView mv){
		List<Seeker> seekers=seekerService.selectAll();
		
		mv.getModelMap().put("seekers", seekers);
		mv.setViewName("index");
		return mv;
	}
	@RequestMapping(value="/seeker")
	public ModelAndView seeker(ModelAndView mv,int id){
		List<Info> infos=infoService.selectLatestInfos(id);
		mv.getModelMap().put("infos", infos);
		
		mv.setViewName("seeker");
		return mv;
	}
}
