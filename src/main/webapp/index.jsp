<%--
  Created by IntelliJ IDEA.
  User: sian1
  Date: 2018/8/19
  Time: 15:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>

<title>员工列表</title>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Bootstrap -->
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<%--员工添加得模态框--%>
<div class="modal fade" id="empAddModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@tangfengye.com">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%--部门提交id即可--%>
                            <select class="form-control" name="dId" id="dept_add_select">

                            </select>

                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>


<%--搭建显示页面--%>
<div class="container">
    <%--标题--%>
    <div class="row"></div>
    <div class="col-md-12">
        <h1>SSM-CRUD</h1>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_model_btn">
                新增
            </button>
            <button class="btn btn-danger">
                删除
            </button>
        </div>
    </div>
    <%--显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                </thead>
               <tbody>
               </tbody>
            </table>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <%--分页文字--%>
        <div class="col-md-6" id="page_info_area">
        </div>
        <%--分页条信息--%>
        <div class="col-md-6" id="page_nav_area">
        </div>
    </div>
</div>
<script type="text/javascript">
    //获取总记录数
    var totalRecord;
    $(function(){
        //去分页得首页
        to_page(1);
    });
    function to_page(pn) {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn="+pn,
            type:"GET",
            success:function (result) {
                // console.log(result);
                //1.解析并显示员工信息
                build_emps_table(result);
                //2.解析并显示分页信息
                build_page_info(result);
                //解析显示分页条数据
                build_page_nav(result);
            }
        });
    }
    function build_emps_table(result) {
        $("#emps_table tbody").empty();
        var emps=result.extend.pageInfo.list;
        $.each(emps,function (index,item) {
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender=='M'?"男":"女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
           /*
           *  <button class="btn btn-primary btn-sm">
                            <span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
                            新增
                        </button>
           * */
            var  editBtn=$("<button></button>").addClass("btn btn-primary btn-sm")
                .append($("<span></span>").addClass("glyphicon glyphicon-edit"))
                .append("编辑");
            var  delBtn=$("<button></button>").addClass("btn btn-danger btn-sm")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("删除");
            var btnTd=$("<td></td>").append(editBtn).append("  ").append(delBtn);
            //append方法执行完成后还是返回原来的元素
            $("<tr></tr>").append(empIdTd)
                           .append(empNameTd)
                           .append(genderTd)
                           .append(emailTd)
                           .append(deptNameTd)
                           .append(btnTd)
                            .appendTo("#emps_table tbody");

        });
    }
    //解析显示分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
$("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页，总共有"+result.extend.pageInfo.pages+"页，总"+
    result.extend.pageInfo.total+"条记录数");
        totalRecord=result.extend.pageInfo.total;
    }
    //解析显示分页条,点击分页信息要能去下一页
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        //page_nav_areav
        var ul=$("<ul></ul>").addClass("pagination");

        //构建元素，为元素添加翻页得事件
    
        var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
        if(result.extend.pageInfo.hasPreviousPage==false)
        {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else {
            firstPageLi.click(function () {
                to_page(1);
            });

            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum-1);
            });
        }


        var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
       if (result.extend.pageInfo.hasNextPage==false) {
           nextPageLi.addClass("disabled");
           lastPageLi.addClass("disabled");
       }else {
           nextPageLi.click(function () {
               to_page(result.extend.pageInfo.pageNum+1);
           });
           lastPageLi.click(function () {
               to_page(result.extend.pageInfo.pages);
           });
       }

        //添加首页和前一页
        ul.append(firstPageLi).append(prePageLi);
        $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
            var numLi=$("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum==item){
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });
        //添加下一页和末页得提示
        ul.append(nextPageLi).append(lastPageLi);
        //把ul加入nav元素中
        var navEle=$("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }
    //点击新增页面弹出模态框
    $("#emp_add_model_btn").click(function () {
       //发送ajax请求，查出部门信息，显示在下拉列表中
        getDepts();
        //弹出模态框
      $("#empAddModel").modal({
          backdrop:"static"
      });
    });
    //查出所有部门信息显示在唉下拉列表中
    function getDepts() {
        $.ajax({
            url:"${APP_PATH}/depts",
            type:"GET",
            success:function (result) {
              // console.log(result);
                //显示部门信息在下拉列表中
               // $("#dept_add_select").append("");
                $.each(result.extend.depts,function () {
                    var optionEle=$("<option></option>").append(this.deptName).attr("value",this.deptId);
                    optionEle.appendTo("#dept_add_select");
                });
            }
        });
    }
    //校验表单数据
    function validate_add_form(){
//拿到校验数据，使用正则表达式
        var empName=$("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
        //alert(regName.test(empName));
           if (!regName.test(empName)){
           //alert("用户名可以市2-5位中文或者6-16位小数");
               show_validate_msg("#empName_add_input","error","用户名可以是2-5位中文或者6-16位小数");
            return false;
        }else {
               show_validate_msg("#empName_add_input","success","");
           }
        //2.校验邮箱信息
       var email=$("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
          // alert("邮箱格式不正确");
            show_validate_msg("#email_add_input","error","邮箱格式错误");
          // console.log();
            return false;
        }else{
            show_validate_msg("#email_add_input","success","");
        }
        return true;

    }

    //校验信息
  function show_validate_msg(ele,status,msg){
        //清除当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if ("success"==status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else  if ("error"==status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

//员工姓名输入框绑定事件
    $("#empName_add_input").change(function () {
        //发送ajax请求校验用户名是否可用
        var empName=this.value;
    $.ajax({
    url:"/checkuser",
    data:"empName="+empName,
    type:"post",
    success:function (result) {
        if (result.code==100){
            console.log(result);
        show_validate_msg("#empName_add_input","success","用户名可用");
        }
        else{
            console.log(result);
            show_validate_msg("#empName_add_input","error","用户名不可用");

        }
    }
});
    });

    //点击保存，保存员工。
    $("#emp_save_btn").click(function () {
        //1.模态框中填写的表单数据提交给服务器进行保存
        //先对提交给服务器的数据进行校验
        if(!validate_add_form()){
            return false;
        }
        //3.发送ajax请求保存员工
         $.ajax({
            url:"${APP_PATH}/emp",
            type:"POST",
            data:$("#empAddModel form").serialize(),
            success:function (result) {
               // console.log(result);
              //  alert(result.msg);
                //1.关闭模型框
                $("#empAddModel").modal('hide');
                //2.来到最后一页,显示刚才存储的数据
                //发送ajax请求显示最后一页数据
                to_page(totalRecord);

            }
        });
    });

</script>
</body>
</html>
