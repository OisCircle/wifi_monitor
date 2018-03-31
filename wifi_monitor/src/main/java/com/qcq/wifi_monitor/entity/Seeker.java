package com.qcq.wifi_monitor.entity;

public class Seeker {
	int id;
	int type;
	double x;
	double y;
	int indoor_x;
	int indoor_y;
	String location;
	int isForbidden;
	int zone_id;
	public Seeker(){
		
	}
	public Seeker(int id, int type, double x, double y, int indoor_x, int indoor_y, String location, int isForbidden,
			int zone_id) {
		super();
		this.id = id;
		this.type = type;
		this.x = x;
		this.y = y;
		this.indoor_x = indoor_x;
		this.indoor_y = indoor_y;
		this.location = location;
		this.isForbidden = isForbidden;
		this.zone_id = zone_id;
	}
	@Override
	public String toString() {
		return "Seeker [id=" + id + ", type=" + type + ", x=" + x + ", y=" + y + ", indoor_x=" + indoor_x
				+ ", indoor_y=" + indoor_y + ", location=" + location + ", isForbidden=" + isForbidden + ", zone_id="
				+ zone_id + "]";
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public double getX() {
		return x;
	}
	public void setX(double x) {
		this.x = x;
	}
	public double getY() {
		return y;
	}
	public void setY(double y) {
		this.y = y;
	}
	public int getIndoor_x() {
		return indoor_x;
	}
	public void setIndoor_x(int indoor_x) {
		this.indoor_x = indoor_x;
	}
	public int getIndoor_y() {
		return indoor_y;
	}
	public void setIndoor_y(int indoor_y) {
		this.indoor_y = indoor_y;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public int getIsForbidden() {
		return isForbidden;
	}
	public void setIsForbidden(int isForbidden) {
		this.isForbidden = isForbidden;
	}
	public int getZone_id() {
		return zone_id;
	}
	public void setZone_id(int zone_id) {
		this.zone_id = zone_id;
	}
}
