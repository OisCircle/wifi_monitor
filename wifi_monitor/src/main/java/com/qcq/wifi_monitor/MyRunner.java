package com.qcq.wifi_monitor;

import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import com.qcq.wifi_monitor.entity.Info;
import com.qcq.wifi_monitor.entity.Phone;
import com.qcq.wifi_monitor.entity.S_P;
import com.qcq.wifi_monitor.entity.Seeker;
import com.qcq.wifi_monitor.internalLogic.parser.Parser;
import com.qcq.wifi_monitor.internalLogic.parser.ParserImpl;
import com.qcq.wifi_monitor.mapper.InfoMapper;
@Component
public class MyRunner implements CommandLineRunner{

	int port=8080;
	DatagramSocket ds;
	DatagramPacket dp;
	byte[] buf=null;
	String strReceive;
	//s e p e r a t o r
	Map<String,Object> parseResult=null;
	int items;
	int i=1;
	Parser parser=new ParserImpl();
//		ApplicationContext ctx=ApplicationContextProvider.getApplicationContext();
//		InfoMapper infoMapper=ctx.getBean(InfoMapper.class);
	@Resource
	InfoMapper infoMapper;
	
//		@Resource
//		InfoMapper infoMapper;
//		ApplicationContext ctx=new ClassPathXmlApplicationContext("applicationContext.xml");
//		InfoMapper infoMapper=ctx.getBean(InfoMapper.class);
	@Override
	public void run(String... args) throws Exception {
			try {
				ds=new DatagramSocket(port);
				System.out.println("monitor is online, waiting for data...");
//				test to send something
				String strSend="true";
				InetAddress addr=InetAddress.getByName("39.108.162.211");
				DatagramPacket send=new DatagramPacket(strSend.getBytes(), strSend.length(), addr,8080);
				ds.send(send);
				while(true){
						
					buf=new byte[1024];
					dp=new DatagramPacket(buf, buf.length);
						ds.receive(dp);
//						System.out.println("from client:");
						strReceive=new String(dp.getData(),"gb2312");
						strReceive=strReceive.trim();
						//出现;;
						System.out.println("receive data: "+strReceive);
						if(strReceive.indexOf("？")!=-1||strReceive.indexOf("?")!=-1){
							System.out.println("存在问号?");
							dp.setLength(1024);
							continue;
						}
						if(strReceive!=null){
							strReceive=strReceive.replaceAll(";;", ";");
							this.receive(strReceive);
							System.out.println("执行第"+(i++)+"次 receive();");
						}

						//					String strReceive=new String(dp.getData(),0,dp.getLength())+" from "+dp.getAddress().getHostAddress()+":"+dp.getPort();
//						System.out.println(strReceive);
						
//						String strSend="client respond";
//						DatagramPacket send=new DatagramPacket(strSend.getBytes(), strSend.length(), dp.getAddress(),8080);
//						ds.send(send);
						
//						dp.setLength(1024);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally{
				ds.close();
				System.out.println("退出while循环.................");
			}
			System.out.println("退出while循环.................");
		}
		/**
		 * @param strReceive
		 */
		public void receive(String strReceive){
			//parse
			if(strReceive!=""||strReceive.indexOf("?")!=-1){
				this.parseResult=parser.parse(strReceive,";");
			}else{
				System.out.println("错误信息:"+strReceive);
			}
			
			//save
			if(parseResult!=null){
				try{
				Seeker seeker=(Seeker) parseResult.get("seeker");
				List<Phone> phones=(List<Phone>) parseResult.get("phones");
				List<S_P> s_ps=(List<S_P>) parseResult.get("s_ps");
				List<Info> infos=(List<Info>) parseResult.get("infos");
				
				infoMapper.insertSeeker(seeker);
				infoMapper.insertPhones(phones);
				infoMapper.insertS_Ps(s_ps);
				infoMapper.insertInfos(infos);
				}catch(Exception e){
					e.printStackTrace();
				}
			}else{
				System.out.println("message wrong:"+strReceive);
			}
		}
}
