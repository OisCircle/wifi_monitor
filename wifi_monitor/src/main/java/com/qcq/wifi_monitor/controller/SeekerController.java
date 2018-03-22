package com.qcq.wifi_monitor.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.qcq.wifi_monitor.entity.Info;
import com.qcq.wifi_monitor.entity.Seeker;
import com.qcq.wifi_monitor.service.InfoService;
import com.qcq.wifi_monitor.service.SeekerService;
import com.qcq.wifi_monitor.util.MathUtil;

@RestController
public class SeekerController {
	@Resource
	SeekerService seekerService;
	@Resource
	InfoService infoService;
	@RequestMapping(value="/left")
	public ModelAndView left(ModelAndView mv){
		mv.setViewName("left");
		return mv;
	}
	@RequestMapping("/main")
	public ModelAndView main(ModelAndView mv){
		mv.setViewName("main");
		return mv;
	}
	@RequestMapping("/top")
	public ModelAndView top(ModelAndView mv){
		mv.setViewName("top");
		return mv;
	}
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
		List<Map<String,Double>> coordinates=MathUtil.getCoordinates(infos);
		mv.getModelMap().put("infos", infos);
		mv.getModelMap().put("coordinates",coordinates);
		mv.setViewName("seeker");
		return mv;
	}
}
