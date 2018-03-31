  package com.qcq.wifi_monitor.internalLogic.parser;


import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.qcq.wifi_monitor.entity.Info;
import com.qcq.wifi_monitor.entity.Seeker;

@Component
public class ParserImpl implements Parser{
	@SuppressWarnings("unchecked")
	@Override
	public Map<String,Object> parse(String strParsed,String separator) {
		try{
			String sep;
			String str;
			String sub;
			Map<String,Object> result=null;
			sub=null;
			str=strParsed;
			sep=separator;
			//测试符号，完成后删除
			sep=";";
			result=new HashMap<String, Object>();
			//开始解析
			if(str.indexOf(sep)==-1)
				return null;
			sub=str.substring(0, str.indexOf(sep));
			str=str.substring(str.indexOf(sep)+1);
			int seekerId=Integer.valueOf(sub.substring(0, sub.indexOf(",")));
			int seekerType=Integer.valueOf(sub.substring(sub.indexOf(",")+1,sub.lastIndexOf(",")));
			
			//x,y暂时设置成0.1
			Seeker seeker=new Seeker(seekerId,seekerType,0.1,0.1,0,0,null,0,-1);
			result.put("seeker", seeker);
			
			
			List<Info> infos=new ArrayList<Info>();
			while(true){
				try{
					sub=str.substring(0, str.indexOf(sep));
					str=str.substring(str.indexOf(sep)+1);
					String mac=sub.substring(0, sub.indexOf(","));
					sub=sub.substring(sub.indexOf(",")+1);
					sub=sub.substring(sub.indexOf(",")+1);
					int rssi=Integer.valueOf(sub.substring(0, sub.indexOf(",")));
					//过滤00开头的mac
					if(!mac.startsWith("00"))
						infos.add(new Info(-1, rssi, mac, new Date(), seeker.getId()));
					
					if(str.length()<=1||str.equals("")||str.equals("\r\n"))
						break;
				}catch(IndexOutOfBoundsException e){
					System.out.println("index out of bounds");
					return null;
				}catch(NumberFormatException e){
					System.out.println("number format exception");
					return null;
				}
			}
			result.put("infos", infos);
			
			//控制台输出
			System.out.println("result:");
			
			Seeker s=(Seeker)result.get("seeker");
			System.out.println(s);
			List<Info> sn=(List<Info>)result.get("infos");
			System.out.println(sn);
			return result;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
//	public static void main(String[] args) {
//		Parser p=new ParserImpl();
//		p.parse("8733613,13,10;60:0b:03:09:55:30,13,-88,8733613;24:1f:a0:f5:97:26,13,-60,8733613;a0:89:e4:5a:71:8c,13,-41,8733613;5c:cf:7f:f0:37:94,13,-72,8733613;5c:cf:7f:3d:77:de,13,-47,8733613;68:c6:3a:85:41:f8,13,-48,8733613;a0:89:e4:95:cd:65,13,-59,8733613;20:8b:37:25:63:ac,13,-80,8733613;68:c6:3a:85:3d:95,13,-13,8733613;34:e2:fd:a2:8e:d9,13,-85,8733613;", ",");
//	}
}
