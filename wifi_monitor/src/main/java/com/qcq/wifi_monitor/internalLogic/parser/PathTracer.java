package com.qcq.wifi_monitor.internalLogic.parser;

import java.util.List;

import com.qcq.wifi_monitor.entity.Info;
import com.qcq.wifi_monitor.entity.Path;
import com.qcq.wifi_monitor.entity.Seeker;

public interface PathTracer{
	public List<Path> trace(List<Info> infos, Seeker seeker);
}
