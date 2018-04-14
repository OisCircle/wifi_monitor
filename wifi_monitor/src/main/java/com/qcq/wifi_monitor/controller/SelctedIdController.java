package com.qcq.wifi_monitor.controller;


import javax.servlet.http.HttpSession;

import com.qcq.wifi_monitor.vo.SelectedId;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

//zone的selectedId在这里存储
@RestController
public class SelctedIdController {
    SelectedId selected = new SelectedId();

    @ResponseBody
    @RequestMapping(value = "/setSelectedId")
    public String setSelectedId(int selectedId) {
        selected.setSelectId(selectedId);
        return "设置成功";
    }

    @ResponseBody
    @RequestMapping(value = "/getSelectedId")
    public int getSelectedId(){
        return selected.getSelectId();
    }

}
