package com.qcq.wifi_monitor.internalLogic.parser;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.BlockingQueue;

import com.qcq.wifi_monitor.dto.PhoneRoute;
import com.qcq.wifi_monitor.entity.Info;
import com.qcq.wifi_monitor.entity.Path;
import com.qcq.wifi_monitor.entity.Seeker;


public class PathTracerImpl implements PathTracer{
	//路径列表，返回路径
	public static List<Path> paths;
	public static Path path;
	//每一个mac对应一个route
	public static List<PhoneRoute> routes=new ArrayList<PhoneRoute>();
	
	
	//根据infos和seeker的坐标，返回用户路径信息
	//返回路径列表，多个
	@Override
	public List<Path> trace(List<Info> infos,Seeker seeker) {
		//
		
		//每次进入方法都清空paths
		paths=new ArrayList<Path>();
		//如果routes空，初始化，下面的for无需执行
		if(routes.size()==0){
			for(int i=0;i<infos.size();++i){
				routes.add(new PhoneRoute(infos.get(i).getMac()));
				routes.get(routes.size()-1).add(infos.get(i).getTime(), seeker);
				System.out.println("初始化routes："+routes.size());
			}
			return null;
		}
		//每个相同的mac存进一个route
		for(int i=0;i<infos.size();++i){
			//判断mac是否在routes里面
			for(int j=0;j<routes.size();++j){
				//如果在routes里面
				if(infos.get(i).getMac().equals(routes.get(j).getMac())){
					//这里不考虑队列满了的情况，因为如果不在routes里面，会自动新建一个PhoneRoute并加入mac，所以如果在routes里面，里面一定只有一个mac
					//让数据入队
					routes.get(j).add(infos.get(i).getTime(), seeker);
					
					//这时候已经有两个队列元素
					
					//判断两个路径是否符合输出条件，是的话则放入paths中
					path=pathProvider(routes.get(j));
					if(path!=null)
						paths.add(path);
					//跳出循环
					break;
				}
				else if(j==routes.size()-1){
					//如果不在routes里面，add一个PhoneRoute对象，并且入队，存入mac，入队time，seeker
					routes.add(new PhoneRoute(infos.get(i).getMac()));
					routes.get(routes.size()-1).add(infos.get(i).getTime(), seeker);
					System.out.println("mac不在routes里面,添加了一个route");
				}
			}
		}
		System.out.println("routes:"+routes.size());
		for(int i=0;i<routes.size();++i){
			System.out.println(routes.get(i).getMac());
		}
		if(paths.size()==0)
			return null;
		else 
			return paths;
		
	}
	public static Path pathProvider(PhoneRoute route){
		//最小的秒数，判断是否取入路径的最小时间
		int minimumSecond=300;
		//最大的秒数，判断是否取入路径的最大时间
		int maximumSecond=3600;
		try {
			//第一个取出来，第二个peek（）方法，不取出来
			System.out.println("取出来之前seeker:"+route.getSeekers().size()+"   mac:"+route.getMac());
			Seeker seeker1=route.getSeekers().take();
			Seeker seeker2=route.getSeekers().peek();
			System.out.println(seeker1+"\n"+seeker2);
			System.out.println("取出来之后seeker:"+route.getSeekers().size()+"   mac:"+route.getMac());
			System.out.println(seeker1+"\n"+seeker2);
			Date time1=route.getTime().take();
			Date time2=route.getTime().peek();
			//如果在同一个seeker，那么返回null
			if(seeker1.getId()==seeker2.getId())
				return null;
			//计算时间差
			long timeGap=(time2.getTime()-time1.getTime())/1000;
			//判断时间差是否在最小和最大判断时间之内
			
			
			/*
			 * 
			 * 
			 *这句话是测试用的，取消时间限制 
			 * 
			 * 
			 */
			if(true){
				
				
				
				
				
//			if(timeGap>=minimumSecond&&timeGap<=maximumSecond){
				Path path=new Path(-1, route.getMac(), seeker1.getX(), seeker1.getY(), seeker2.getX(), seeker2.getY(), time1, time2,seeker1.getId(),seeker2.getId());
				System.out.println("path:\n\n\n\n\n"+path);
				return path;
			}
		} catch (InterruptedException e) {
			System.out.println("pathProvider（）方法出错...............");
			e.printStackTrace();
		}
		return null;
	}
}
