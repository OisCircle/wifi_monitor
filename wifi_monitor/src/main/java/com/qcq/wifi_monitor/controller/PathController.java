package com.qcq.wifi_monitor.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.qcq.wifi_monitor.dto.SeekerFilterDTO;
import com.qcq.wifi_monitor.entity.Info;
import com.qcq.wifi_monitor.entity.Path;
import com.qcq.wifi_monitor.entity.Seeker;
import com.qcq.wifi_monitor.service.InfoService;
import com.qcq.wifi_monitor.service.PathService;
import com.qcq.wifi_monitor.service.SeekerService;

@RestController
public class PathController {
	@Resource
	PathService pathService;
	@Resource
	SeekerService seekerService;
	@Resource
	InfoService infoService;
	@RequestMapping(value="/path")
	public ModelAndView path(ModelAndView mv,String mac,int minute){
		List<Path> paths=pathService.selectByMac(mac);
		
		SeekerFilterDTO dto=new SeekerFilterDTO(-1,minute,-130);
		List<Seeker> seekers=seekerService.selectAll();
		mv.getModelMap().put("seekers", seekers);
		//将每一个seeker最新探测到的所有信号们放入List数组
		List<List<Info>> listInfos = new ArrayList<List<Info>>();
		for (int i = 0; i < seekers.size(); ++i) {
			dto.setId(seekers.get(i).getId());
			listInfos.add(infoService.selectLatestInfos(dto));
		}
		mv.getModelMap().put("listInfos", listInfos);
		
		mv.getModelMap().put("paths", paths);
		mv.setViewName("path");
		return mv;
	}
	
	@RequestMapping(value="/linkPath")
	public ModelAndView linkPath(ModelAndView mv,String mac,int minute){
		List<Path> paths=pathService.selectByMac(mac);
		
		SeekerFilterDTO dto=new SeekerFilterDTO(-1,minute,-130);
		List<Seeker> seekers=seekerService.selectAll();
		mv.getModelMap().put("seekers", seekers);
		//将每一个seeker最新探测到的所有信号们放入List数组
		List<List<Info>> listInfos = new ArrayList<List<Info>>();
		for (int i = 0; i < seekers.size(); ++i) {
			dto.setId(seekers.get(i).getId());
			listInfos.add(infoService.selectLatestInfos(dto));
		}
		mv.getModelMap().put("listInfos", listInfos);
		
		mv.getModelMap().put("paths", paths);
		mv.setViewName("linkPath");
		return mv;
	}
}
