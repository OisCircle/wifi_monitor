package com.qcq.wifi_monitor.controller;


import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class SessionAttributeSettingController {
	@ResponseBody
	@RequestMapping(value="/sessionAttributeSetting",method=RequestMethod.POST)
	public String ajax(HttpSession session,int selectedId){
		session.setAttribute("selectedId", selectedId);
		return "选取成功";
	}
	
	@RequestMapping(value="/intoAjaxPage")
	public ModelAndView ajaxTest(ModelAndView mv){
		mv.setViewName("ajaxTest");
		return mv;
	}
}
