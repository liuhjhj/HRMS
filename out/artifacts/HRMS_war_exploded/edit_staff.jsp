<%@ page import="java.io.PrintWriter" %><%--
  Created by IntelliJ IDEA.
  User: liu24
  Date: 2019/6/4
  Time: 17:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="edit" class="com.connect_database"/>
<html>
<head>
    <title>保存员工信息</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    edit.setUsername((String) session.getAttribute("username"));
    edit.setPassword((String) session.getAttribute("password"));
    edit.connect();
    try {   //删除-更新-添加
        String delete;
        String[] deleteString = request.getParameterValues("checkbox"); //利用CheckBox的value属性来进行删除
        if (deleteString != null) {   //删除数据
            if (deleteString.length > 0) {
                delete = deleteString[0];
                for (int i = 0; i < deleteString.length; i++) {
                    delete = deleteString[i];
                    if (delete != null) {
                        String sql = "delete from staff where number='" + delete + "';";
                        edit.executeUpdate(sql);
                    }
                }
            }
        }
    }catch (Exception e) {
        e.printStackTrace();
    }
    try {   //同时进行删除和更新操作会导致此try-catch块报错
        int count = (int) session.getAttribute("count");
        session.removeAttribute("count");
        for (int i = 0; i <= count; i++) {  //更新数据
            String name = request.getParameter(i + "name");
            String number = request.getParameter(i + "number");
            String age = request.getParameter(i + "age");
            String sex = request.getParameter(i + "sex");
            String department = request.getParameter(i + "department");
            if ((!name.equals("")) && (!number.equals(""))  //有try-catch块,这行if可要可不要
                    && (!age.equals("")) && (!sex.equals(""))   //(不要的话可能会报SQL错误)
                    && (!department.equals(""))) {
                String sql = "update staff set name = '" + name + "' " +
                        ", age = " + age + " "+
                        ", sex = '" + sex + "' " +
                        ", department = '" + department +
                        "' where number=" + number + ";";
                edit.executeUpdate(sql);
            }
        }
    }catch (Exception e) {
        e.printStackTrace();
    }
    try {
        String add_name=request.getParameter("add_name");   //添加数据
        String add_age = request.getParameter("add_age");
        String add_sex = request.getParameter("add_sex");
        String add_department = request.getParameter("add_department");
        if ((!add_name.equals("")) && (!add_age.equals("")) //有try-catch块,这行if可要可不要
                && (!add_sex.equals("")) && (!add_department.equals(""))) { //(不要的话可能会报SQL错误)
            String sql = "insert into staff values(null,'" + add_name +
                    "',"+ add_age + ",'" + add_sex + "','" + add_department + "');";
            edit.executeUpdate(sql);
        }
    }catch (Exception e){
        e.printStackTrace();
    }
    edit.disconnect();
    response.setCharacterEncoding("utf-8"); //弹出窗口
    PrintWriter output = response.getWriter();
    output.print("<script>alert('保存完成'); " +
            "window.location='staff.jsp' </script>");
    output.flush();
    output.close();
%>
</body>
</html>
<!--一个未知的空指针错误
java.lang.NullPointerException
    at org.apache.jsp.edit_005fstaff_jsp._jspService(edit_005fstaff_jsp.java:164)
    at org.apache.jasper.runtime.HttpJspBase.service(HttpJspBase.java:70)
    at javax.servlet.http.HttpServlet.service(HttpServlet.java:741)
    at org.apache.jasper.servlet.JspServletWrapper.service(JspServletWrapper.java:476)
    at org.apache.jasper.servlet.JspServlet.serviceJspFile(JspServlet.java:385)
    at org.apache.jasper.servlet.JspServlet.service(JspServlet.java:329)
    at javax.servlet.http.HttpServlet.service(HttpServlet.java:741)
    at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231)
    at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)
    at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:53)
    at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)
    at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)
    at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:200)
    at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:96)
    at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:490)
    at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:139)
    at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:92)
    at org.apache.catalina.valves.AbstractAccessLogValve.invoke(AbstractAccessLogValve.java:678)
    at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:74)
    at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:343)
    at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:408)
    at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:66)
    at org.apache.coyote.AbstractProtocol$ConnectionHandler.process(AbstractProtocol.java:836)
    at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1839)
    at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49)
    at java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1128)
    at java.base/java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:628)
    at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)
    at java.base/java.lang.Thread.run(Thread.java:834)
-->