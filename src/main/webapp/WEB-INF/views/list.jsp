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
     <%--   &lt;%&ndash;&lt;%&ndash;引入jquery的CDN&ndash;%&gt;&ndash;%&gt;--%>
        <script src="http://cdn.bootcss.com/jqeuery/2.1.1/jquery.min.js">
        </script>
       <%-- &lt;%&ndash;&lt;%&ndash;引入样式&ndash;%&gt;&ndash;%&gt;--%>
        <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
        <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
         <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
        <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    </head>
<body>
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
            <button class="btn btn-primary">
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
            <table class="table table-hover">
                <tr>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>

                        <c:forEach items="${pageInfo.list}" var="emp">
                <tr>
                        <th>${emp.empId}</th>
                        <th>${emp.empName}</th>
                        <th>${emp.gender=="M"?"男":"女"}</th>
                        <th>${emp.email}</th>
                        <th>${emp.department.deptName}</th>
                    <th>
                        <button class="btn btn-primary btn-sm">
                            <span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
                            新增
                        </button>
                        <button class="btn btn-danger btn-sm">
                            <span class="glyphicon glyphicon-trash " aria-hidden="true"></span>
                            删除
                        </button>
                    </th>
                </tr>
                        </c:forEach>

            </table>
        </div>
    </div>
        <%--显示分页信息--%>
    <div class="row">
        <%--分页文字--%>
        <div class="col-md-6">
            当前${pageInfo.pageNum}页，总共有${pageInfo.pages}页，总${pageInfo.total}条记录数
        </div>
            <%--分页条信息--%>
            <div class="col-md-6">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <li>
                            <a href="${APP_PATH}emps?pn=1">首页</a>
                        </li>
                        <c:if test="${pageInfo.hasPreviousPage}">
                            <li>
                                <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <c:forEach items="${pageInfo.navigatepageNums }" var="page_Num">
                           <c:if test="${page_Num==pageInfo.pageNum }">
                               <li class="active"><a href="#">${page_Num }</a></li>
                           </c:if>
                            <c:if test="${page_Num!=pageInfo.pageNum}">
                                <li ><a href="${APP_PATH}emps?pn=${page_Num}">${page_Num}</a></li>
                            </c:if>
                        </c:forEach>
                        <c:if test="${pageInfo.hasNextPage}">
                        <li>
                            <a href="${APP_PATH}emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                        </c:if>
                        <li>
                            <a href="${APP_PATH}emps?pn=${pageInfo.pages}">末页</a>
                        </li>
                    </ul>
                </nav>
            </div>

    </div>
</div>
</body>
</html>
