package com.qcq.wifi_monitor.entity;

public class Phone {
	String mac;

	public String getMac() {
		return mac;
	}

	public void setMac(String mac) {
		this.mac = mac;
	}

	@Override
	public String toString() {
		return "Phone [mac=" + mac + "]";
	}

	public Phone(String mac) {
		super();
		this.mac = mac;
	}
}
