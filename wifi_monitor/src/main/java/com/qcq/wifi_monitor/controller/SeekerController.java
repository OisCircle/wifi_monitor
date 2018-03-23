package com.qcq.wifi_monitor.controller;

import java.util.ArrayList;
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
		
		//将每一个seeker最新探测到的所有信号们放入List数组
		List<List<Info>> listInfos=new ArrayList<List<Info>>();
		for(int i=0;i<seekers.size();++i){
			listInfos.add(infoService.selectLatestInfos(seekers.get(i).getId()));
		}
		mv.getModelMap().put("listInfos", listInfos);
		
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
