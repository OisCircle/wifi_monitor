package com.qcq.wifi_monitor.vo;

//前端选取的分钟数在这里
public class Minute {
	static int minute;
	public static int getMinute() {
		return minute;
	}
	public static void setMinute(int minute) {
		Minute.minute = minute;
	}
	public Minute(int minute) {
		this.minute = minute;
	}
}
