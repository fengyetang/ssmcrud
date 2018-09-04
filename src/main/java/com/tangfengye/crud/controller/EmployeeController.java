package com.tangfengye.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.tangfengye.crud.bean.Employee;
import com.tangfengye.crud.bean.Msg;
import com.tangfengye.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.naming.Binding;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/*
* 处理员工crud请求
*
* 1.要支持jsr303校验
* 2.导入Hibernate-Validator包
* */
@Controller
public class EmployeeController {
@Autowired
EmployeeService employeeService;


/*
* 单个删除和批量删除二合一
*批量删除：1-2-3，id中用横杠隔开
* */
@ResponseBody
@RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
public Msg deleteEmpById(@PathVariable("ids")String ids){
   // System.out.println(id);
    System.out.println("0000000000000");
   //批量删除
    if(ids.contains("-")){
        List<Integer> del_ids=new ArrayList<>();
        String[] str_ids = ids.split("-");
        for (String string:str_ids){
            del_ids.add(Integer.parseInt(string));
        }
       // System.out.println("00000000000011111111");
       // System.out.println(del_ids);
    employeeService.deleteBatch(del_ids);
    }else {
       Integer id=Integer.parseInt(ids);
        employeeService.deleteEmp(id);

    }

    return Msg.success();

}


/*
* 员工更新方法
* */
@ResponseBody
@RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
public Msg saveEmp(Employee employee){
  // System.out.println("aaaaaaaaaa");
    employeeService.updataEmp(employee);
    System.out.println(employee);
    return  Msg.success();

}
/*
* 根据员工id查询员工
* */
@RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
@ResponseBody
public Msg getEmp(@PathVariable("id")Integer id){
    Employee employee = employeeService.getEmp(id);
    return Msg.success().add("emp",employee);
}


/*
* 检查用户名是否可用
* */
@RequestMapping("/checkuser")
@ResponseBody
public Msg checkuser(@RequestParam("empName")String empName){
    //先判断用户名是否是合法的表达式
    String regx="(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)";
    if (!empName.matches(regx)){
        return Msg.fail().add("va_msg","用户名必须是6-16位数字和字幕的组合或者2-5位中文");
    }

    //数据库用户名重复校验
    boolean b=employeeService.checkUser(empName);
    if (b){
        return Msg.success();
    }
    else {
        return Msg.fail().add("vs_msg","用户名不可用");
    }
}
    /*
     * 员工保存
     * 导入jason包
     * */
@RequestMapping(value = "/emp",method = RequestMethod.POST)
@ResponseBody
public Msg saveEmp(@Valid Employee employee, BindingResult result){
    if (result.hasErrors()){
        Map<String,Object> map=new HashMap<>();
        //校验失败，因该返回失败,再莫要狂中显示校验失败的错误信息
       List<FieldError> errors = (List<FieldError>) result.getFieldError();
       for (FieldError fieldError:errors){

           System.out.println("错误的字段名"+fieldError.getField());
           System.out.println("错误信息："+fieldError.getDefaultMessage());
          map.put(fieldError.getField(),fieldError.getDefaultMessage());
       }
      return  Msg.fail().add("errorFields",map);
    }else {
        employeeService.saveEmp(employee);
        return Msg.success();
    }
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
    //在查询之前只需要调用，传入页码，以及每页的大小
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
