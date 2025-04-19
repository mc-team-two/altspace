<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!-- pagination start -->
<div class="col text-center ">
  <ul class="pagination justify-content-center">
    <%--이전--%>
    <c:choose>
      <c:when test="${cpage.getPrePage() != 0}">
        <li class="page-item">
          <a  class="page-link"  href="<c:url value="${target}/get?pageNo=${cpage.getPrePage()}" />">&lt;</a>
        </li>
      </c:when>
      <c:otherwise>
        <li class="page-item disabled">
          <a  class="page-link"  href="#">&lt;</a>
        </li>
      </c:otherwise>
    </c:choose>

    <%--nav--%>
    <c:forEach begin="${cpage.getNavigateFirstPage() }" end="${cpage.getNavigateLastPage() }" var="page">
      <c:choose>
        <c:when test="${cpage.getPageNum() == page}">
          <li class="page-item active">
            <a class="page-link"  href="<c:url value="${target}/get?pageNo=${page}" />">${page }</a>
          </li>
        </c:when>
        <c:otherwise>
          <li class="page-item">
            <a class="page-link"  href="<c:url value="${target}/get?pageNo=${page}" />">${page }</a>
          </li>
        </c:otherwise>
      </c:choose>
    </c:forEach>

    <%--다음--%>
    <c:choose>
      <c:when test="${cpage.getNextPage() != 0}">
        <li class="page-item">
          <a class="page-link"  href="<c:url value="${target}/get?pageNo=${cpage.getNextPage()}" />">&gt;</a>
        </li>
      </c:when>
      <c:otherwise>
        <li class="page-item disabled">
          <a class="page-link"  href="#">&gt;</a>
        </li>
      </c:otherwise>
    </c:choose>
  </ul>
</div>
<!-- pagination end -->