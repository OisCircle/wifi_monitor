package com.qcq.wifi_monitor.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class ApplicationTestController {
	@RequestMapping(value="/applicationTest")
	public ModelAndView applicationTest(ModelAndView mv){
		mv.setViewName("applicationTest");
		return mv;
	}
	@RequestMapping(value="/applicationTest2")
	public ModelAndView applicationTest2(ModelAndView mv){
		mv.setViewName("applicationTest2");
		return mv;
	}
}
