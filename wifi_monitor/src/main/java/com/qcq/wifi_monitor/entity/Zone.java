package com.qcq.wifi_monitor.entity;

public class Zone {
	int id;
	String name;
	String description;
	Double x;
	Double y;
	public Zone(){
		
	}
	public Zone(int id, String name, String description, Double x, Double y) {
		super();
		this.id = id;
		this.name = name;
		this.description = description;
		this.x = x;
		this.y = y;
	}
	@Override
	public String toString() {
		return "Map [id=" + id + ", name=" + name + ", description=" + description + ", x=" + x + ", y=" + y + "]";
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Double getX() {
		return x;
	}
	public void setX(Double x) {
		this.x = x;
	}
	public Double getY() {
		return y;
	}
	public void setY(Double y) {
		this.y = y;
	}
}
