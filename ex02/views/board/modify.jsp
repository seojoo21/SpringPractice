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
                                Board Modify Page
                            </div>
                            <!-- 테이블 시작  -->
                            
                              <!--   POST방식이므로 <form>태그를 이용해서 필요한 데이터를 전송한다.  
                              	get.jsp와 비슷하지만 제목, 내용을 수정할 수 있도록 readonly 속성을 없앤다. 
                               -->
                          
                            	<form role="form" action="/board/modify" method="post">
                            	
                          		<div class="form-group">
                          		<label>#번호</label>
                          		<input class="form-control" name='bno' value='<c:out value="${board.bno}"/>' readonly="readonly">
                          		</div>
                          		
                          		<div class="form-group">
                          		<label>제목</label>
                          		<input class="form-control" name='title' value='<c:out value="${board.title}"/>' >
                          		</div>
                          		
                          		<div class="form-group">
                          		<label>내용</label>
                          		<textarea class="form-control" rows="3" name='content'>
                          		<c:out value="${board.content }" />
                          		</textarea>
                          		</div>
                          		
                          		<div class="form-group">
                          		<label>작성자</label>
                          		<input class="form-control" name='writer' value='<c:out value="${board.writer}"/>' readonly="readonly">
                          		</div>
                          		
                          		<!-- 등록일과 수정일이 나중에 BoardVO로 수집되어야 하므로 날짜 포맷을 'yyyy/MM/dd'로 하여 추가한다. (날짜 포맷 일치 해야함)  -->
                          		
                          		<div class="form-group">
                          		<label>작성일</label>
                          		<input class="form-control" name='regDate' value='<fmt:formatDate pattern = "yyyy/MM/dd" value="${board.regdate}"/>' readonly="readonly">
                          		</div>
                          		
                          		<div class="form-group">
                          		<label>수정일</label>
                          		<input class="form-control" name='updateDate' value='<fmt:formatDate pattern = "yyyy/MM/dd" value="${board.updateDate}"/>' readonly="readonly">
                          		</div>
                          		
                          		<!-- 수정,삭제,목록으로 돌아가기 버튼  -->
                          		<button type="submit" data-oper='modify' class="btn btn-default">수정</button>
                          		<button type="submit" data-oper='remove' class="btn btn-danger">삭제</button>
                             	<button type="submit" data-oper='list' class="btn btn-info">목록으로</button>
                          		
                          		</form>
                             <!-- 테이블 끝  -->
                            </div>
                        </div>
                    </div>
                </main>
         
<!-- 수정, 삭제, 목록으로 돌아가기 버튼별 동작을 자바스크립트로 설정       -->  
<script type="text/javascript">
$(document).ready(function() {
	
	var formObj = $("form");
	
	$('button').on("click", function(e) {
		e.preventDefault();
		
		var operation = $(this).data("oper");
		
		console.log(operation);
		
		if(operation==='remove'){
			formObj.attr("action", "/board/remove");
			
		} else if (operation === 'list') {
			formObj.attr("action", "/board/list").attr("method","get");
			formObj.empty(); // 'board/list'로의 이동은 아무런 파라미터가 없기 때문에 <form>태그의 모든 내용은 삭제한 상태에서 submit()을 진행한다. 
		}
		formObj.submit();
	});
});

</script>
                
<!-- 게시판이 들어갈 핵심적인 페이지의 내용의 아래 부분을 잘라서 footer.jsp의 내용으로 처리한다.  -->
<%@include file="../includes/footer.jsp" %>              
              
