package com.qcq.wifi_monitor.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.qcq.wifi_monitor.entity.Info;
import com.qcq.wifi_monitor.entity.Path;
import com.qcq.wifi_monitor.entity.Phone;
import com.qcq.wifi_monitor.entity.S_P;
import com.qcq.wifi_monitor.entity.Seeker;
@Repository
public interface InfoMapper {
	public void insertSeeker(Seeker seeker);
	public void insertPhones(List<Phone> phones);
	public void insertS_Ps(List<S_P> s_ps);
	public void insertInfos(List<Info> infos);
	//筛选出某个探针最新的每个phone的信号
	public List<Info> selectLatestInfos(int id);
	//筛选出某个探针指定最近xxx	小时		内收到的信号
	public List<Info> selectLatestInfosByHour(int id,int hour);
	//筛选出某个探针指定最近xxx	分钟		内收到的信号
	public List<Info> selectLatestInfosByMinute(int id,int minute);
}
