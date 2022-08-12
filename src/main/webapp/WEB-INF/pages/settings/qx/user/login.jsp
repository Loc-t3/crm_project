<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	/*动态获取文件的路径*/
String basepath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";


%>
<html>
<head>
<%-- 此处必须包含在 head 中	作为基础的路径为接下来的链接进行拼接--%>
	<base href="<%=basepath%>">
<meta charset="UTF-8">
<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" /><%--${pageContext.request.contextPath }--%>
<script type="text/javascript" src="jquery/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		$(function (){
			//在全局中设置键盘的事件
			$(window).keydown(function (e) {
				//如果按下的是enter键 则提交登录请求
				if (e.keyCode==13){
					$("#loginBtn").click();
				}
			});
			//对登录按钮添加点击事件
			$("#loginBtn").click(function ()
					{
						//获取输入框的用户和密码 以及记录状态的按钮
						var loginAct  = $("#loginAct").val().trim();
						var loginPwd  = $("#loginPwd").val().trim();
						var loginRem  = $("#loginRem").prop("checked");

						//对表单进行数据验证 判断不为空
						if (loginAct==""){
							alert("用户名不能为空");
							return;

						}
						if (loginPwd==""){
							alert("密码不能为空");
							return;

						}
						//用 ajax 发送请求 获取数据 进行判断
						$.ajax({
							url:'settings/qx/user/login.do',

							data:{
								loginAct:loginAct,
								loginPwd:loginPwd,
								loginRem:loginRem,
							},
							type:"post",
							dataType:"json",
							success:function (data) {
								//获取状态码
								if (data.code=="1"){

									//跳转至主业务界面
									window.location.href="workbench/index.do"

								}else{
									// 提示信息
									$("#msg").text(data.message);
								}


							}
							,
							beforeSend:function () {
								// 当Ajax向后台发送请求之前，会自动执行本函数
								// 改函数的返回值能够决定 ajax 是否真正像后台发送请求
								// 如果返回 true 则ajax会真正向后台发送请求，返回false则不发送请求
								$("#msg").text("正在努力验证中-----");
								return true;
								
							}
						})


					}
			)


		})
	</script>
</head>
<body>
	<div style="position: absolute; top: 0px; left: 0px; width: 60%;">
		<img src="image/IMG_7114.JPG" style="width: 100%; height: 90%; position: relative; top: 50px;">
	</div>
	<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
		<div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">CRM &nbsp;<span style="font-size: 12px;">&copy;2019&nbsp;动力节点</span></div>
	</div>
	
	<div style="position: absolute; top: 120px; right: 100px;width:450px;height:400px;border:1px solid #D5D5D5">
		<div style="position: absolute; top: 0px; right: 60px;">
			<div class="page-header">
				<h1>登录</h1>
			</div>
			<form action="workbench/index.html" class="form-horizontal" role="form">
				<div class="form-group form-group-lg">
					<div style="width: 350px;">
						<input class="form-control" id="loginAct" type="text" value="${cookie.loginAct.value}" placeholder="用户名">
					</div>
					<div style="width: 350px; position: relative;top: 20px;">
						<input class="form-control" id="loginPwd" type="password" value="${cookie.loginPwd.value}"  placeholder="密码">
					</div>
					<div class="checkbox"  style="position: relative;top: 30px; left: 10px;">
						<label>
							<c:if test="${not empty cookie.loginAct and not empty cookie.loginPwd}">
								<input type="checkbox" id="loginRem" checked>
							</c:if>
							<c:if test="${ empty cookie.loginAct or empty cookie.loginPwd}">
								<input type="checkbox" id="loginRem" >
							</c:if>
							 十天内免登录
						</label>
						&nbsp;&nbsp;
						<span id="msg"></span>
					</div>
					<button type="button" id="loginBtn" class="btn btn-primary btn-lg btn-block"  style="width: 350px; position: relative;top: 45px;">登录</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>