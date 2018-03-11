package com.qcq.wifi_monitor.controller;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.qcq.wifi_monitor.entity.User;
import com.qcq.wifi_monitor.service.UserService;

@RestController
public class HelloWorldController {
	@Resource
	UserService ts;
	
	//默认返回字符串
	@RequestMapping(value="/hello",method=RequestMethod.GET)
	public String hello(){
		return "MyJsp";
	}
	//返回jsp页面
	@RequestMapping(value="/hello2",method=RequestMethod.GET)
	public ModelAndView hello2(ModelAndView mv){
//		mv.setViewName("index.html");
		mv.setViewName("MyJsp");
		return mv;
	}
	@RequestMapping(value="/test",method=RequestMethod.GET)
	public ModelAndView test(ModelAndView mv){
		User user=ts.selectOne();
		mv.getModel().put("user", user);
		mv.setViewName("index");
		return mv;
	}
}
