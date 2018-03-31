package com.qcq.wifi_monitor.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.qcq.wifi_monitor.dto.SeekerFilterDTO;
import com.qcq.wifi_monitor.entity.Info;
import com.qcq.wifi_monitor.entity.Path;
import com.qcq.wifi_monitor.entity.Seeker;
@Repository
public interface InfoMapper {
	public void insertSeeker(Seeker seeker);
	public void insertInfos(List<Info> infos);
	//筛选出某个探针最新的每个phone的信号，分钟筛选
	//参数：id,minute
	public List<Info> selectLatestInfos(SeekerFilterDTO dto);
	//筛选出某个探针指定最近xxx	分钟		内收到的信号
	public List<Info> selectLatestInfosByMinute(SeekerFilterDTO dto);
}
