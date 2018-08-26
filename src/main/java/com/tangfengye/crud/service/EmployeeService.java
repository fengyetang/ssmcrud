package com.tangfengye.crud.service;

import com.tangfengye.crud.bean.Employee;
import com.tangfengye.crud.bean.EmployeeExample;
import com.tangfengye.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;
    /*
    *查询所有员工
    *
    * */
    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null) ;
    }
    /*
    * 员工保存方法
    * */
    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }
/*
* 检验用户名是否可用
* */
    public boolean checkUser(String empName) {
        EmployeeExample example=new EmployeeExample();
        EmployeeExample.Criteria criteria= example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
       long count=employeeMapper.countByExample(example);
        return count==0;
    }
}
