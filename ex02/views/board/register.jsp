<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!-- 게시판이 들어갈 핵심적인 페이지의 내용 부분 위까지를 잘라서 header.jsp의 내용으로 처리한다.  -->
<%@include file="../includes/header.jsp"%>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Tables</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				Board Read Page
			</div>

			<!-- /.panel-heading -->
			<div class="panel-body">
                            <!-- 테이블 시작  -->
                            
                 <!--            POST방식이므로 <form>태그를 이용해서 필요한 데이터를 전송한다. 
                            <input>이나 <textarea>태그의 name 속성은 BoardVO 클래스의 변수와 일치시켜준다.  -->
                            
                             	<form role="form" action="/board/register" method="post">
                             	  <div class="form-group">
                             	  <label>제목</label>
                             	  <input class="form-control" name='title'>
                             	  </div>
                             	  
                             	  <div class="form-group">
                             	  <label>내용</label>
                             	  <textarea class="form-control" rows="3" name='content'></textarea>
                             	  </div>
                             	  
                             	  <div class="form-group">
                             	  <label>작성자</label>
                             	  <input class="form-control" name='writer'>
                             	  </div>
                             	  
                             	  <button type="Submit" class="btn btn-default">Submit Button</button>
                             	  <button type="Reset" class="btn btn-default">Reset Button</button>
                  
                             	</form>
                             <!-- 테이블 끝  -->
                            </div>
                        </div>
                    </div>
                </div>
                
<!-- 게시판이 들어갈 핵심적인 페이지의 내용의 아래 부분을 잘라서 footer.jsp의 내용으로 처리한다.  -->
<%@include file="../includes/footer.jsp" %>              
              
              
