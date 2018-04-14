package com.qcq.wifi_monitor.internalLogic.parser;


import java.util.Map;

public interface Parser {
	public Map<String,Object> parse(String strParsed, String separator);
}
