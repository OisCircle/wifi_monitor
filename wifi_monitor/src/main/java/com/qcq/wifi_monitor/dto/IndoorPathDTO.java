package com.qcq.wifi_monitor.dto;

public class IndoorPathDTO {
	int zoneId;
	String mac;
	
	public IndoorPathDTO(){
		
	}
	public IndoorPathDTO(int zoneId, String mac) {
		super();
		this.zoneId = zoneId;
		this.mac = mac;
	}
	@Override
	public String toString() {
		return "IndoorPathDTO [zoneId=" + zoneId + ", mac=" + mac + "]";
	}
	public int getZoneId() {
		return zoneId;
	}
	public void setZoneId(int zoneId) {
		this.zoneId = zoneId;
	}
	public String getMac() {
		return mac;
	}
	public void setMac(String mac) {
		this.mac = mac;
	}
}
