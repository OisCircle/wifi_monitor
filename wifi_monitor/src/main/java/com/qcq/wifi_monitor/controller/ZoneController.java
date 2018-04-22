package com.qcq.wifi_monitor.controller;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.qcq.wifi_monitor.ImageContextPathConfiguration;
import com.qcq.wifi_monitor.entity.Zone;
import com.qcq.wifi_monitor.service.ZoneService;
import com.qcq.wifi_monitor.util.FileUtil;
@Controller
public class ZoneController {
	@Resource
	ZoneService zoneService;

	@RequestMapping(value = "/map")
	public ModelAndView map(ModelAndView mv) {
		mv.setViewName("map");
		return mv;
	}
	@RequestMapping(value="/zoneAdd",method=RequestMethod.POST)
	public ModelAndView add(ModelAndView mv,String name,String description,double x,double y,MultipartFile file){
		String filePath=ImageContextPathConfiguration.getBasePath();
		try {
			FileUtil.uploadFile(file.getBytes(), filePath, name+".jpg");
		} catch (Exception e) {
			System.out.println("图片上传失败...");
		}
		Zone zone=new Zone(0, name, description, x, y);
		String status=zoneService.add(zone);
		mv.setViewName("map");
		return mv;
	}
	@RequestMapping(value="/zoneDelete")
	@ResponseBody
	public String delete(int id){
		String status=zoneService.delete(id);
		return status;
	}
	@RequestMapping(value="/zoneUpdate")
	@ResponseBody
	public String update(int id,String name,String description,double x,double y){
		Zone zone=new Zone(id, name, description, x, y);
		String status=zoneService.update(zone);
		return status;
	}
	@RequestMapping(value="/zoneSelectOne")
	@ResponseBody
	public Zone selectOne(int id){
		Zone zone=zoneService.selectOne(id);
		return zone;
	}
	@RequestMapping(value="/zoneSelectAll")
	@ResponseBody
	public List<Zone> selectAll(){
		List<Zone> zones=zoneService.selectAll();
		return zones;
	}
}
