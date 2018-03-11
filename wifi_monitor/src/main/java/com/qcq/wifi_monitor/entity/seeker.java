package com.qcq.wifi_monitor.entity;

public class Seeker {
	int id;
	int type;
	double x;
	double y;
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
	@Override
	public String toString() {
		return "seeker [id=" + id + ", type=" + type + ", x=" + x + ", y=" + y + "]";
	}
	public Seeker(int id, int type, double x, double y) {
		super();
		this.id = id;
		this.type = type;
		this.x = x;
		this.y = y;
	}
}
