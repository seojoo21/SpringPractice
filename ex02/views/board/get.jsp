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
                          		
                          	<%-- 페이징 처리 중 조회 페이지에서 다시 목록 페이지로의 이동 시 페이지 번호 유지를 위해 기존 방식 주석 처리 
                          		<!-- 수정 버튼 -->
                          		<button data-oper='modify' class="btn btn-default">
                          		<a href="/board/modify?bno=<c:out value="${board.bno}"/>">
                          		수정</a></button>
                          		
                          		<!-- 목록 페이지 이동 버튼  -->
                          		<button data-oper='list' class="btn btn-info">
                          		<a href="/board/list">목록으로</a>
                          		</button> --%>
                          		
                          		<button data-oper='modify' class="btn btn-default">수정</button>
								<button data-oper='list' class="btn btn-info">목록으로</button>
                          		
                        <!-- 수정과 삭제가 필요한 페이지로 링크 처리를 하기 위해 form 태그 이용 (타입은 hidden) -->
                        <!-- 페이징 처리 중 조회 페이지에서 다시 목록 페이지로의 이동 시 페이지 번호 유지를 위해 Criteria 클래스의 변수 pageNum, amount를 추가 -->
                          <form id='operForm' action="/board/modify" method="get">
							 <input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'>
						     <input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
						     <input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
						<!-- 조회 페이지에서의 다시 목록 페이지로 이동 시 검색 처리 결과 유지를 위해 type과 keyword의 처리를 추가한다.  -->
		                    <input type='hidden' name='type' value='<c:out value="${cri.type}"/>' />
		                    <input type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>' />
                          </form>
                          		
                             <!-- 테이블 끝  -->
                            </div>
                        </div>
                    </div>
                   </div>

<!-- 사용자가 수정, 목록 페이지 이동 버튼을 클릭하면 operForm이라는 id를 가진 <form> 태그를 전송해야 하므로 
페이지 하단에 추가적인 JavaScript 처리가 필요 -->

<script type="text/javascript">
$(document).ready(function() {
	
	var operForm = $("#operForm");
	
/* 	사용자가 수정 버튼을 클릭하면 bno값을 같이 전달하고 <form>태그를 submit시켜서 처리한다.  */
	
	$("button[data-oper='modify']").on("click", function(e) {
		
		operForm.attr("action", "/board/modify").submit();
		
	});
	
/* 	사용자가 list로 이동하는 경우에는 아직 아무런 데이터도 필요하지 않으므로 
	<form>태그 내의 bno태그를 지우고 submit을 통해 리스트 페이지로 이동한다. */
	
	$("button[data-oper='list']").on("click", function(e) {
		
		operForm.find("#bno").remove();
		operForm.attr("action", "/board/list");
		operForm.submit();
		
	});
});

</script>

<!-- 게시판이 들어갈 핵심적인 페이지의 내용의 아래 부분을 잘라서 footer.jsp의 내용으로 처리한다.  -->
<%@include file="../includes/footer.jsp" %>              
              
