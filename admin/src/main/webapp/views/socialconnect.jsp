<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    #phone{
        width:auto;
        margin-top: 10px;
    }
    #socialconnect_btn{
        margin-top: 30px;
    }
</style>

<script>

    const socialconnect = {

        init:function(){
            $('#socialconnect_btn').click(()=>{
                this.check();
            });
        },

        check:function(){
            let phone = $('#phone').val();

            console.log('휴대폰번호: %s',phone);

            if(phone == '' || phone == null || phone.length != 11){
                $('#msg').text('휴대폰 번호 11자리를 입력하세요.');
                $('#phone').focus();
                return;
            }

            let c = confirm('해당 번호로 가입된 이력이 있습니다. 연동하시겠습니까?');
            if(c == true){
                this.send();
            }
        },

        checkPhone:function(phone){
            $.ajax({
                url:'<c:url value="/checkphone"/>',
                data:{cid:phone},
                success:(result)=>{
                    //alert(result);
                    if(result == 1){
                        $('#msg').text('연동이 완료되었습니다.');
                        $('#phone').off('blur')
                    }else{
                        $('#msg').text('연동 후 서비스를 이용할 수 있습니다.');
                        $('#phone').blur(()=>{
                            $('#phone').focus();
                        });
                    }
                },
                error:()=>{}
            });
        },
        send:function(){
            $('#socialconnect_form').attr('method','post');
            $('#socialconnect_form').attr('action','<c:url value="/gosocialconnect"/>');
            $('#socialconnect_form').submit();
        }
    }
    $(function(){
        socialconnect.init();
    });

</script>

<div class="col-sm-10">
    <h4>원활한 서비스 이용을 위해 추가 정보 입력이 필요합니다.</h4>

    <div class="col-sm-8">
        <form id="socialconnect_form" style="display: flex; align-items: center;">
            <div class="form-group" style="margin-right: 10px;">
                <label for="phone">휴대폰 번호</label>
                <input type="text" name="phone" class="form-control" placeholder="하이픈(-) 없이 입력" id="phone">
            </div>
            <button id="socialconnect_btn" class="btn btn-primary">입력</button>
        </form>

        <div class="col-sm-4">
            <p id="msg">메세지</p>
        </div>

    </div>
</div>