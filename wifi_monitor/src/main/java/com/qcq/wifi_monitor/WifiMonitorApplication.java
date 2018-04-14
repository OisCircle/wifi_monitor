package com.qcq.wifi_monitor;


import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
@MapperScan("com.qcq.wifi_monitor.mapper")
public class WifiMonitorApplication extends SpringBootServletInitializer {
    public static void main(String[] args) {
        SpringApplication.run(WifiMonitorApplication.class, args);
    }
}