package com.qcq.wifi_monitor.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class AjaxTestController {
	@ResponseBody
	@RequestMapping(value="/testAjax",method=RequestMethod.POST)
	public Map<String,String> ajax(){
		Map<String,String> map=new HashMap<String, String>();
		map.put("hello", "hello hello");
		map.put("world", "world world");
		System.out.println("into ajax controller");
		return map;
	}
	
	@RequestMapping(value="/intoAjaxPage")
	public ModelAndView ajaxTest(ModelAndView mv){
		mv.setViewName("ajaxTest");
		return mv;
	}
}
