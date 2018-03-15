package com.qcq.wifi_monitor.dto;

import java.util.Date;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;

import com.qcq.wifi_monitor.entity.Seeker;

public class PhoneRoute {
	public PhoneRoute(String mac){
		this.mac=mac;
	}
	String mac;
	BlockingQueue<Date> time=new ArrayBlockingQueue<Date>(2);
	BlockingQueue<Seeker> seekers=new ArrayBlockingQueue<Seeker>(2);
	public void add(Date time,Seeker seeker){
		this.time.add(time);
		this.seekers.add(seeker);
		return ;
	}
	public String getMac() {
		return mac;
	}
	public void setMac(String mac) {
		this.mac = mac;
	}
	public BlockingQueue<Date> getTime() {
		return time;
	}
	public void setTime(BlockingQueue<Date> time) {
		this.time = time;
	}
	public BlockingQueue<Seeker> getSeekers() {
		return seekers;
	}
	public void setSeekers(BlockingQueue<Seeker> seekers) {
		this.seekers = seekers;
	}
	@Override
	public String toString() {
		return "PhoneRoute [mac=" + mac + ", time=" + time + ", seekers=" + seekers + "]";
	}
}
