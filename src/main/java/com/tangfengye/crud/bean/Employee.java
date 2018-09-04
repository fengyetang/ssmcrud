package com.tangfengye.crud.bean;

import javax.validation.constraints.Pattern;

public class Employee {
    private Integer empId;


    @Pattern(regexp = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)",message = "用户名必须为2-5位中文或6-16位英文数字的组合(包含大小写和下划线)")
    private String empName;

    private String gender;
    @Pattern(regexp = "(^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$)",message = "邮箱格式不正确")
    private String email;

    private Integer dId;
    private Department department;

    public Employee() {
        super();
    }

    public Employee(Integer empId, String empName, String gender, String email, Integer dId) {
        this.empId = empId;
        this.empName = empName;
        this.gender = gender;
        this.email = email;
        this.dId = dId;
    }

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }
    public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getdId() {
        return dId;
    }

    public void setdId(Integer dId) {
        this.dId = dId;
    }

    @Override
    public String toString() {
        return "Employee{" +
                "empId=" + empId +
                ", empName='" + empName + '\'' +
                ", gender='" + gender + '\'' +
                ", email='" + email + '\'' +
                ", dId=" + dId +
                ", department=" + department +
                '}';
    }
}