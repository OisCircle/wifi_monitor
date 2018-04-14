package com.qcq.wifi_monitor.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.qcq.wifi_monitor.vo.Minute;
@RestController
public class MinuteController {
	Minute minute=new Minute(60);
	@RequestMapping(value="/setMinute")
	public void setMinute(int minute){
		this.minute.setMinute(minute);
		System.out.println("成功设置全局分钟:"+minute);
	}
	@RequestMapping(value="/getMinute")
	@ResponseBody
	public int getMinute(){
		return this.minute.getMinute();
	}
}
