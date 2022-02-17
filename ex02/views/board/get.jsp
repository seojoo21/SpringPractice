<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- 게시판이 들어갈 핵심적인 페이지의 내용 부분 위까지를 잘라서 header.jsp의 내용으로 처리한다.  -->
<%@include file="../includes/header.jsp" %>

            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Tables</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="index.html">Dashboard</a></li>
                            <li class="breadcrumb-item active">Tables</li>
                        </ol>
	            <!--         필요하면 사용해도 되는 것이니 이 부분은 일단 주석 처리 해놓음 
                        <div class="card mb-4">
                            <div class="card-body">
                                DataTables is a third party plugin that is used to generate the demo table below. For more information about DataTables, please visit the
                                <a target="_blank" href="https://datatables.net/">official DataTables documentation</a>
                            </div>
                        </div> -->
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                Board Read Page
                            </div>
                            <!-- 테이블 시작  -->
                          		<div class="form-group">
                          		<label>#번호</label>
                          		<input class="form-control" name='bno' value='<c:out value="${board.bno}"/>' readonly="readonly">
                          		</div>
                          		
                          		<div class="form-group">
                          		<label>제목</label>
                          		<input class="form-control" name='title' value='<c:out value="${board.title}"/>' readonly="readonly">
                          		</div>
                          		
                          		<div class="form-group">
                          		<label>내용</label>
                          		<textarea class="form-control" rows="3" name='content' readonly="readonly">
                          		<c:out value="${board.content }" />
                          		</textarea>
                          		</div>
                          		
                          		<div class="form-group">
                          		<label>작성자</label>
                          		<input class="form-control" name='writer' value='<c:out value="${board.writer}"/>' readonly="readonly">
                          		</div>
                          		
                          		<!-- 수정 버튼 -->
                          		<button data-oper='modify' class="btn btn-default">
                          		<a href="/board/modify?bno=<c:out value="${board.bno}"/>">
                          		수정</a></button>
                          		<!-- 목록 페이지 이동 버튼  -->
                          		<button data-oper='list' class="btn btn-info">
                          		<a href="/board/list">목록으로</a>
                          		</button>
                          		
                        <!--   		수정과 삭제가 필요한 페이지로 링크 처리를 하기 위해 form 태그 이용 (타입은 hidden)  -->
                          		<form id='operForm' action="/board/modify" method="get">
                          			<input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno }"/>'>
                          		</form>
                          		
                             <!-- 테이블 끝  -->
                            </div>
                        </div>
                    </div>
                </main>

<!-- 사용자가 수정, 목록 페이지 이동 버튼을 클릭하면 operForm이라는 id를 가진 <form> 태그를 전송해야 하므로 
페이지 하단에 추가적인 JavaScript 처리가 필요 -->

<script type="text/javascript">
$(document).ready(function() {
	
	var operForm = $("#operForm");
	
/* 	사용자가 수정 버튼을 클릭하면 bno값을 같이 전달하고 <form>태그를 submit시켜서 처리한다.  */
	
	$(button[data-oper='modify']).on("click", function(e) {
		
		operForm.attr("action", "/board/modify").submit();
		
	});
	
/* 	사용자가 list로 이동하는 경우에는 아직 아무런 데이터도 필요하지 않으므로 
	<form>태그 내의 bno태그를 지우고 submit을 통해 리스트 페이지로 이동한다. */
	
	$(button[data-oper='list']).on("click", function(e) {
		
		operForm.find("#bno").remove();
		operForm.attr("action", "/board/list");
		operForm.submit();
		
	});
});

</script>

<!-- 게시판이 들어갈 핵심적인 페이지의 내용의 아래 부분을 잘라서 footer.jsp의 내용으로 처리한다.  -->
<%@include file="../includes/footer.jsp" %>              
              
