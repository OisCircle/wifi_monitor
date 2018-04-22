package com.qcq.wifi_monitor.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.qcq.wifi_monitor.ImageContextPathConfiguration;
import com.qcq.wifi_monitor.util.FileUtil;

@RestController
public class ImageUploadController {
	String filePath=ImageContextPathConfiguration.getBasePath();
	@RequestMapping(value="/imageTest",method=RequestMethod.POST)
	public ModelAndView imageTest(ModelAndView mv,MultipartFile file,String fileName){
		System.out.println("fileName-->" + fileName);
//		filePath = "C:\\wifi_monitor_local_resources\\images\\"; 
		System.out.println("filePath:"+filePath);
		try {
			FileUtil.uploadFile(file.getBytes(), filePath, fileName);
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		
		
		mv.setViewName("imageTest2");
		return mv;
	}
	@RequestMapping(value="/toImageTest")
	public ModelAndView toImageTest(ModelAndView mv){
		mv.setViewName("imageTest");
		return mv;
	}
	@RequestMapping(value="/imageTest2")
	public ModelAndView imageTest(ModelAndView mv){
		mv.setViewName("imageTest2");
		return mv;
	}

	//上传图片
	@RequestMapping(value="/imageUpload",method=RequestMethod.POST)
	public String imageUpload(MultipartFile file,String fileName){
		String status="上传成功";
//		filePath = "C:\\wifi_monitor_local_resources\\images\\";
		try {
			FileUtil.uploadFile(file.getBytes(), filePath, fileName);
		} catch (Exception e) {
			status="上传失败";
		}
		return status;
	}
}
