package com.qcq.wifi_monitor.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.qcq.wifi_monitor.dto.SeekerFilterDTO;
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
	public ModelAndView index(ModelAndView mv,int minute){
		SeekerFilterDTO dto=new SeekerFilterDTO(0,minute,-130);
		List<Seeker> seekers=seekerService.selectAll();
		mv.getModelMap().put("seekers", seekers);
		
		//将每一个seeker最新探测到的所有信号们放入List数组
		List<List<Info>> listInfos=new ArrayList<List<Info>>();
		for(int i=0;i<seekers.size();++i){
			dto.setId(seekers.get(i).getId());
			listInfos.add(infoService.selectLatestInfos(dto));
		}
		mv.getModelMap().put("listInfos", listInfos);
		
		mv.setViewName("index");
		return mv;
	}
	@RequestMapping(value="/seeker")
	public ModelAndView seeker(ModelAndView mv,int id,int minute,int rssi){
		SeekerFilterDTO dto=new SeekerFilterDTO(id,minute,rssi);
		List<Info> infos=infoService.selectLatestInfosByMinute(dto);
		List<Map<String,Double>> coordinates=MathUtil.getCoordinates(infos);
		mv.getModelMap().put("seeker_id", id);
		mv.getModelMap().put("infos", infos);
		mv.getModelMap().put("coordinates",coordinates);
		mv.setViewName("seeker");
		return mv;
	}
	@RequestMapping(value="/latestMinute")
	public ModelAndView latestMinute(ModelAndView mv,int id,int minute,int rssi){
		SeekerFilterDTO dto=new SeekerFilterDTO(id,minute,rssi);
		List<Info> infos=infoService.selectLatestInfosByMinute(dto);
		List<Map<String,Double>> coordinates=MathUtil.getCoordinates(infos);
		mv.getModelMap().put("seeker_id", id);
		mv.getModelMap().put("infos", infos);
		mv.getModelMap().put("coordinates",coordinates);
		mv.setViewName("seeker");
		return mv;
	}
	
	//以下是针对设备管理界面上面的增删改查
	@RequestMapping(value="/seekerAdd")
	public String seekerAdd(int id,int type,double x,double y,int indoor_x,int indoor_y,String location,int isForbidden,int zone_id){
		Seeker seeker=new Seeker(id, type, x, y, indoor_x, indoor_y, location, isForbidden, zone_id);
		return seekerService.add(seeker);
	}
	@RequestMapping(value="/seekerDelete")
	public String seekerDelete(int id){
		return seekerService.deleteById(id);
	}
	@RequestMapping(value="/seekerUpdate")
	public String seekerUpdate(int id,int type,double x,double y,int indoor_x,int indoor_y,String location,int isForbidden,int zone_id){
		Seeker seeker=new Seeker(id, type, x, y, indoor_x, indoor_y, location, isForbidden, zone_id);
		return seekerService.update(seeker);
	}
	@RequestMapping(value="/seekerSelectOne")
	@ResponseBody
	public Seeker seekerSelectOne(int id){
		return seekerService.selectOne(id);
	}
	@RequestMapping(value="/seekerSelectAll")
	@ResponseBody
	public List<Seeker> seekerSelectAll(){
		return seekerService.selectAll();
	}
	@RequestMapping(value="seekerSetIsForbidden")
	public String seekerSetIsForbidden(int id,int isForbidden){
		Seeker seeker=new Seeker();
		seeker.setId(id);
		seeker.setIsForbidden(isForbidden);
		return seekerService.setIsForbidden(seeker);
	}
}
