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

    public Employee getEmp(Integer id) {
        Employee employee=employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    /*
    * 员工更新
    * */
    public void updataEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }
/*
* 员工删除
*
* */
    public void deleteEmp(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    public void deleteBatch(List<Integer> ids) {
        EmployeeExample example=new EmployeeExample();
        EmployeeExample.Criteria criteria=example.createCriteria();
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(example);

    }
}
