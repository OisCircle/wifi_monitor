package com.qcq.wifi_monitor.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.qcq.wifi_monitor.entity.Zone;
import com.qcq.wifi_monitor.service.ZoneService;
@RestController
public class ZoneController {
	@Resource
	ZoneService zoneService;
	
	@RequestMapping(value="/zoneAdd")
	@ResponseBody
	public String add(String name,String description,double x,double y){
		Zone zone=new Zone(0, name, description, x, y);
		String status=zoneService.add(zone);
		return status;
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
