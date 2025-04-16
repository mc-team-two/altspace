<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>

</script>

<div class="card shadow mb-4">
    <div class="card-header py-3">
        <h6 class="m-0 font-weight-bold text-primary">DataTables Example</h6>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <thead>
                <tr>
                    <th>Image</th>
                    <th>Id</th>
                    <th>Name</th>
                    <th>Price</th>
                    <th>Reg Date</th>

                </tr>
                </thead>

                <tbody>
                <c:forEach var="item" items="${itemlist}">
                    <tr>
                        <td>
                            <a href="<c:url value="/item/detail"/>?id=${item.itemId}">
                                    <%--                                    <img  src="<c:url value="/imgs"/>/${item.itemImgname}">--%>
                                <img src="<c:url value="/imgs"/>/${item.itemImgname}">
                            </a>
                        </td>
                        <td>${item.itemId}</td>
                        <td>${item.itemName}</td>
                        <td>
                            <fmt:formatNumber type="number" pattern="###,###원" value="${item.itemPrice}" />                           </td>
                        <td>
                            <fmt:formatDate  value="${item.itemRdate}" pattern="yyyy-MM-dd" />
                        </td>

                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>