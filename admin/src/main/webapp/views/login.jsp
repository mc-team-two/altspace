<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
    const login = {
        init:function(){
            $('#login_btn').click(()=>{
                this.send();
            });
        },
        check:function(){},
        send:function(){
            $('#login_form').attr('method','post');
            $('#login_form').attr('action','<c:url value="/gologin"/>');
            $('#login_form').submit();
        }
    }
    $(function(){
        login.init();
    });
</script>

<div class="col-sm-10">
    <h2>Login Page</h2>
    <div class="row">
        <div class="col-sm-6">
            <form id="login_form">
                <div class="form-group">
                    <label for="id">Id:</label>
                    <input type="text" name="id" class="form-control" placeholder="Enter id" id="id">
                </div>
                <div class="form-group">
                    <label for="pwd">Password:</label>
                    <input type="password" name="pwd" class="form-control" placeholder="Enter password" id="pwd">
                </div>
            </form>
            <button id="login_btn" class="btn btn-primary">LOGIN</button>
        </div>
        <div class="col-sm-6">
            <c:choose>
                <c:when test="${msg != null}">
                    <h3>${msg}</h3>
                </c:when>
                <c:otherwise>
                    <h3>로그인하세요.</h3>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

</div>