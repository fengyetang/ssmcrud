package com.tangfengye.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.tangfengye.crud.bean.Employee;
import com.tangfengye.crud.bean.Msg;
import com.tangfengye.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/*
* 处理员工crud请求
* */
@Controller
public class EmployeeController {
@Autowired
EmployeeService employeeService;
/*
* 检查用户名是否可用
* */
@RequestMapping("/checkuser")
@ResponseBody
public Msg checkuser(@RequestParam("empName")String empName){
    boolean b=employeeService.checkUser(empName);
    if (b){
        return Msg.success();
    }
    else {
        return Msg.fail();
    }
}
    /*
     * 员工保存
     * 导入jason包
     * */
@RequestMapping(value = "/emp",method = RequestMethod.POST)
@ResponseBody
public Msg saveEmp(Employee employee){
employeeService.saveEmp(employee);
return Msg.success();
}

@RequestMapping("/emps")
@ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue="1")Integer pn, Model model){
    PageHelper.startPage(pn,5);
    //startpage后面紧跟着的这个查询就是一个分页查询
    List<Employee> emps=employeeService.getAll();
    //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了
    //分装了详细的分页信息，包括查询出来的数据，传入连续显示的页数
    PageInfo page=new PageInfo(emps,5);
    //model.addAttribute("pageInfo",page);
    return Msg.success().add("pageInfo",page);
}

/*@RequestMapping("/emps")
public String getEmps(@RequestParam(value = "pn",defaultValue="1")Integer pn, Model model){
    //这不是一个分页查询
    //在查询之前只需要调用，传入有人吗，以及每页的大小
    PageHelper.startPage(pn,5);
    //startpage后面紧跟着的这个查询就是一个分页查询
    List<Employee> emps=employeeService.getAll();
    //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了
    //分装了详细的分页信息，包括查询出来的数据，传入连续显示的页数
    PageInfo page=new PageInfo(emps,5);
    model.addAttribute("pageInfo",page);
    return "list";
}*/
}
