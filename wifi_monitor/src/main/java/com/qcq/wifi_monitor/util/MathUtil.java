package com.qcq.wifi_monitor.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.qcq.wifi_monitor.entity.Info;

public class MathUtil {
	//圆的半径和信号的范围和放大的倍数
	private static int radius=350;
	private static int range=130;
	private static Double magnification=(double)radius/(double)range;
	//
	private static double x;
	private static double y;
	private static double r;
	private static double pi=Math.PI;
	//放在外面new会出错
//	private static List<Map<String,Double>> coordinates=new ArrayList<Map<String,Double>>();
//	private static Map<String,Double> coordinate=new HashMap<String, Double>();
	public static List<Map<String,Double>> getCoordinates(List<Info> infos){
		List<Map<String,Double>> coordinates=new ArrayList<Map<String,Double>>();
		//角度的增量，每次增加一个角度
		Double angleIncrement=2*pi/(infos.size());
		Double angle=(double) 0;
		for(int i=0;i<infos.size();++i){
			Map<String,Double> coordinate=new HashMap<String, Double>();
			r=infos.get(i).getRssi()*(-1);
			Double x=(r*Math.cos(angle)*magnification);
			Double y=(r*Math.sin(angle)*magnification);
			
			coordinate.put("x", x);
			coordinate.put("y", y);
			coordinates.add(coordinate);
			angle+=angleIncrement;
//			System.out.println(coordinates.get(i).get("x"));
		}
		
		
//		for(int j=0;j<coordinates.size();++j){
//			System.out.println(coordinates.get(j).get("x"));
//		}
		return coordinates;
	}
	
}
