<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<title>emplist</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/views/css/style.css" />

		<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
		<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

		<script type="text/javascript">
			$(function () {
				//为删除按钮绑定事件
				$(document).on("click",".delete-btn",function () {
					var delete_id = $(this).attr('delete_id');
					//弹出删除提示框
					if(confirm("确定删除吗?")){
						//确认
						$.ajax({
							url:"${pageContext.request.contextPath}/views/stu/" + delete_id,
							type:"POST",
							data:"_method=DELETE",
							success:function (data) {
								if(data == "success"){
									//重新加载页面
									location.reload();
								}
							}
						});
					}
				});
			});
		</script>

	</head>
	<body>
		<div id="wrap">
			<div id="top_content"> 
				<div id="header">
					<div id="rightheader">
						<p>
							<%=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date())%>
							<br />
							<a href="${pageContext.request.contextPath}/views/login.jsp" class="label label-success">安全退出</a>
						</p>
					</div>
					<div id="topheader">
						<h1 id="title">
							<a href="#">学生管理系统</a>
						</h1>
					</div>
					<div id="navigation">
					</div>
				</div>
				<div id="content">
					<p id="whereami">
					</p>
					<h1>
						<span class="label label-primary">欢迎!用户:${username}</span>
					</h1>
					<table class="table table-hover table-striped">
						<tr class="table_header">
							<td>
								ID
							</td>
							<td>
								姓名
							</td>
							<td>
								照片
							</td>
							<td>
								性别
							</td>
							<td>
								年龄
							</td>
							<td>
								相关操作
							</td>
						</tr>

						<c:forEach items="${pageInfo.list}" var="stu">
							<%--<c:if test="${stu.id % 2 == 0}">
								<tr class="row1">
							</c:if>
							<c:if test="${stu.id % 2 == 1}">
								<tr class="row2">
							</c:if>--%>
							<tr>
								<td>
									${stu.id}
								</td>
								<td>
									${stu.name}
								</td>
								<td>
									<img src="${pageContext.request.contextPath}/views/img/nane.gif" style="height: 60px;">
								</td>
								<td>
									${stu.sex == 'm' ? '男':'女'}
								</td>
								<td>
									${stu.age}
								</td>
								<td>
									<button class="btn btn-warning delete-btn" delete_id="${stu.id}">删除</button>&nbsp;<button class="btn btn-warning"><a href="${pageContext.request.contextPath}/views/updateStu/${stu.id}" style="text-decoration: none;color: white">更新</a></button>
								</td>
							</tr>
						</c:forEach>
					</table>

					<%-- 分页 --%>
					<div class="row">
						<%-- 分页信息 --%>
						<div class="col-md-6">
							<h4>
								<span class="label label-danger">当前第${pageInfo.pageNum}页,总${pageInfo.pages}页,总${pageInfo.total}条记录</span>
							</h4>
						</div>
						<%-- 分页条信息 --%>
						<div class="col-md-6">
							<nav aria-label="Page navigation">
								<ul class="pagination">
									<%-- 点击跳转至首页 --%>
									<li><a href="${pageContext.request.contextPath}/views/stus?pn=1">首页</a></li>
									<%-- 是否含有上一页 --%>
									<c:if test="${pageInfo.hasPreviousPage}">
										<%-- 若存在上一页，则显示上一页按钮 --%>
										<li>
											<a href="${pageContext.request.contextPath}/views/stus?pn=${pageInfo.pageNum - 1}"
											   aria-label="Previous">
												<span aria-hidden="true">&laquo;</span>
											</a>
										</li>
									</c:if>
									<%-- 共有navigatepageNums页 --%>
									<c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">
										<%-- 若页码处于当前页，则激活按钮状态 --%>
										<c:if test="${pageNum == pageInfo.pageNum}">
											<li class="active"><a href="#">${pageNum}</a></li>
										</c:if>
										<c:if test="${pageNum != pageInfo.pageNum}">
											<%-- 点击页码，跳转至对应页面 --%>
											<li><a href="${pageContext.request.contextPath}/views/stus?pn=${pageNum}">${pageNum}</a></li>
										</c:if>
									</c:forEach>
									<%-- 是否含有下一页 --%>
									<c:if test="${pageInfo.hasNextPage}">
										<%-- 若存在下一页，则显示下一页按钮 --%>
										<li>
											<a href="${pageContext.request.contextPath}/views/stus?pn=${pageInfo.pageNum + 1}"
											   aria-label="Next">
												<span aria-hidden="true">&raquo;</span>
											</a>
										</li>
									</c:if>
									<%-- 点击跳转至最后一页 --%>
									<li><a href="${pageContext.request.contextPath}/views/stus?pn=${pageInfo.pages}">末页</a></li>
								</ul>
							</nav>
						</div>
					</div>

					<p>
						<input type="button" class="button" value="添加学生信息" onclick="location='${pageContext.request.contextPath}/views/addEmp.jsp'"/>
					</p>
				</div>
			</div>
			<div id="footer">
				<div id="footer_bg">
					@author wwj
				</div>
			</div>
		</div>
	</body>
</html>
