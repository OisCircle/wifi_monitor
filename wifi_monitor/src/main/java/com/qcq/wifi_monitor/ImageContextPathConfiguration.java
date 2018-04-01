package com.qcq.wifi_monitor;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
//配置绝对路径地址
//只需要再这里更改就行了
@Configuration
public class ImageContextPathConfiguration extends WebMvcConfigurerAdapter {
	static String basePath="C:/wifi_monitor_local_resources/images/";
	public static String getBasePath(){
		return basePath;
	}
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		/**
		 * @Description: 对文件的路径进行配置,创建一个虚拟路径/Path/**
		 *               ，即只要在<img src="/Path/picName.jpg" />便可以直接引用图片 这是图片的物理路径
		 *               "file:/+本地图片的地址" @Date： Create in 14:08 2017/12/20
		 */
		registry.addResourceHandler("/path/**")
				.addResourceLocations("file:/"+basePath);
		super.addResourceHandlers(registry);
	}
}