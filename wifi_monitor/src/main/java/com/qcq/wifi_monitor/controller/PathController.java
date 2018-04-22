package com.qcq.wifi_monitor.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import com.qcq.wifi_monitor.vo.Minute;
import com.qcq.wifi_monitor.vo.SelectedId;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.qcq.wifi_monitor.dto.IndoorPathDTO;
import com.qcq.wifi_monitor.dto.SeekerFilterDTO;
import com.qcq.wifi_monitor.entity.Info;
import com.qcq.wifi_monitor.entity.Path;
import com.qcq.wifi_monitor.entity.Seeker;
import com.qcq.wifi_monitor.service.InfoService;
import com.qcq.wifi_monitor.service.PathService;
import com.qcq.wifi_monitor.service.SeekerService;

@Controller
public class PathController {
	@Resource
	PathService pathService;
	@Resource
	SeekerService seekerService;
	@Resource
	InfoService infoService;
	static String mac;
	@RequestMapping(value="/path")
	public ModelAndView path(ModelAndView mv,String mac){
		List<Path> paths=pathService.selectByMac(mac);
		
		SeekerFilterDTO dto=new SeekerFilterDTO(-1, Minute.getMinute(),-130);
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
	@RequestMapping(value="/path_count")
	@ResponseBody
	public int path_count(String mac){
		return pathService.selectByMac(mac).size();
	}
	
	@RequestMapping(value="/linkPath")
	public ModelAndView linkPath(ModelAndView mv,String mac){
		SeekerFilterDTO dto=new SeekerFilterDTO(-1,Minute.getMinute(),-130);
		List<Seeker> seekers=seekerService.selectAll();
		mv.getModelMap().put("seekers", seekers);
		//将每一个seeker最新探测到的所有信号们放入List数组
		List<List<Info>> listInfos = new ArrayList<List<Info>>();
		for (int i = 0; i < seekers.size(); ++i) {
			dto.setId(seekers.get(i).getId());
			listInfos.add(infoService.selectLatestInfos(dto));
		}
		mv.getModelMap().put("listInfos", listInfos);
		
		List<Path> paths=pathService.selectByMac(mac);
		mv.getModelMap().put("paths", paths);
		mv.setViewName("linkPath");
		return mv;
	}
	
	@RequestMapping(value = "/pathCount")
	@ResponseBody
	public int pathCount(String mac) {
		return pathService.selectCountByMac(mac);
	}

	@RequestMapping("/indoor_linkPath")
	public ModelAndView indoor_linkPath(ModelAndView mv,String mac) {
		this.mac = mac;
		IndoorPathDTO dto=new IndoorPathDTO(SelectedId.getSelectId(),mac);
		List<Path> paths = pathService.selectByMacAndZoneId(dto);
		 SeekerFilterDTO dto2=new SeekerFilterDTO(0,Minute.getMinute(),-130);

		   List<Seeker> seekers=seekerService.selectByZoneId(SelectedId.getSelectId());

		   mv.getModelMap().put("seekers", seekers);



		   //将每一个seeker最新探测到的所有信号们放入List数组

		   List<List<Info>> listInfos=new ArrayList<List<Info>>();

		   for(int i=0;i<seekers.size();++i){

		      dto2.setId(seekers.get(i).getId());

		      listInfos.add(infoService.selectLatestInfos(dto2));

		   }

		   mv.getModelMap().put("listInfos", listInfos);
		mv.getModelMap().put("paths", paths);
		mv.setViewName("indoor_linkPath");
		return mv;
	}

	@RequestMapping("/indoor_linkPath_count")
	@ResponseBody
	public int indoor_linkPath_count(String mac) {
		IndoorPathDTO dto=new IndoorPathDTO(SelectedId.getSelectId(),mac);
		List<Path> paths = pathService.selectByMacAndZoneId(dto);
		int count= paths.size();
		return count;
	}

	@RequestMapping("/indoor_linkPath_Paths")
	@ResponseBody
	public List<Path> indoor_linkPath_Paths() {
		IndoorPathDTO dto=new IndoorPathDTO(SelectedId.getSelectId(),this.mac);
		List<Path> paths = pathService.selectByMacAndZoneId(dto);
		return paths;
	}
}
