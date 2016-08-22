<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" charset="utf-8">
	function logoutFun(b) {
		$.getJSON('${pageContext.request.contextPath}/sysUser/logout.do', function(result) {
			if (b) {
				location.replace('${pageContext.request.contextPath}/index.jsp');
			} else {
				$('#sessionInfoDiv').html('');
				$('#user_login_loginDialog').dialog('open');
				$('#layout_east_onlineDatagrid').datagrid('load', {});
			}
		});
	}
	function userInfoFun() {
		$('<div/>').dialog({
			href : '${pageContext.request.contextPath}/sysUser/userInfo.do',
			width : 490,
			height : 285,
			modal : true,
			title : '用户信息',
			buttons : [ {
				text : '修改密码',
				iconCls : 'icon-edit',
				handler : function() {
					var d = $(this).closest('.window-body');
					$('#user_userInfo_form').form('submit', {
						url : '${pageContext.request.contextPath}/sysUser/modifyUserPwd.do',
						success : function(result) {
							try {
								var r = $.parseJSON(result);
								if (r.success) {
									d.dialog('destroy');
								}
								$.messager.show({
									title : '提示',
									msg : r.msg
								});
							} catch (e) {
								$.messager.alert('提示', result);
							}
						}
					});
				}
			} ],
			onClose : function() {
				$(this).dialog('destroy');
			},
			onLoad : function() {
			}
		});
	}
</script>
<div id="sessionInfoDiv" style="position: absolute;right: 5px;top:10px;">
	<c:if test="${sessionInfo.userId != null}">[<strong>${sessionInfo.loginName}</strong>]，欢迎你！您使用[<strong>${sessionInfo.ip}</strong>]IP登录！</c:if>
</div>
<div style="position: absolute; right: 0px; bottom: 0px; ">
	<a href="javascript:void(0);" class="easyui-menubutton" data-options="menu:'#layout_north_kzmbMenu',iconCls:'icon-help'">控制面板</a> 
</div>

<div id="layout_north_kzmbMenu" style="width: 100px; display: none;">
	<div onclick="userInfoFun();">个人信息</div>
	<div class="menu-sep"></div>
	<div>
		<span>更换主题</span>
		<div style="width: 120px;">
		<div onclick="changeTheme('default');">default</div>
		<div onclick="changeTheme('gray');">gray</div>
		<div onclick="changeTheme('metro');">metro</div>
		<div onclick="changeTheme('bootstrap');">bootstrap</div>
		<div onclick="changeTheme('black');">black</div>
		</div>
	</div>
	<div class="menu-sep"></div>
	<div onclick="logoutFun();">锁定窗口</div>
	<div onclick="logoutFun(true);">重新登录</div>
</div>
