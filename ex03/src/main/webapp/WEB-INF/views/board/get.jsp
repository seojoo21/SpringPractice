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
                             
                <!-- 댓글 목록 시작  -->
                	<br>
                    <div class='row'>
                      <div class='col-lg-12'>
                      <!--  /.panel  -->
                        <div class="panel panel-default">
                      	  <div class="panel-heading">
                      	    <i class="fa fa-comments fa-fw"></i> 댓글
                      	     <button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>댓글 작성 </button>
                      	</div>
                      	
                      	<!-- /.panel-heading -->
                      	<div class="panel-body">
                      	  <ul class="chat">
                      	    <!-- start reply -->
                      	     <!--  <li class="left clearfix" data-rno='12'>
                      	        <div>
                      	          <div class="header">
                      	            <strong class="primary-font">user00</strong>
                      	          	<small class="pull-right text-muted">2018-01-01 13:13</small>
                      	          </div>
                      	       	  <p> good job!</p>
                      	       </div>
                      	      </li> -->
                      	      <!-- end reply -->
                      	  </ul>
                      	 <!-- /l end ul -->
                      	</div>
                      	<!-- /.panel .chat-panel 추가: 댓글 페이지 번호 출력 부분-->
                      	<div class="panel-footer"></div>                      
                        </div>
                      </div>
                      <!-- ./ end row -->
                    </div>          
                            </div>
                        </div>
                    </div>
                   </div>
                   
				<!-- 댓글 작성을 위한 모달창 Modal -->
                            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="myModalLabel">댓글창</h4>
                                        </div>
                                        <div class="modal-body">
                                          <div class="form-group">
                                            <label>댓글</label>
                                            <input class="form-control" name='reply' value='New Reply!!!!'>
                                        </div>
                                        <div class="form-group">
                                          <label>댓글 작성자</label>
                                          <input class="form-control" name='replyer' value='replyer'>
                                        </div>
                                        <div class="form-group">
                                          <label>댓글 작성일</label>
                                          <input class="form-control" name='replyDate' value=''>
                                        </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button id='modalModBtn' type="button" class="btn btn-warning">수정</button>
                                            <button id='modalRemoveBtn' type="button" class="btn btn-danger">삭제</button>
                                            <button id='modalRegisterBtn' type="button" class="btn btn-primary">등록</button>
                                            <button id='modalCloseBtn' type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                                        </div>
                                    </div>
                                    <!-- /.modal-content -->
                                </div>
                                <!-- /.modal-dialog -->
                            </div>
                            <!-- /.modal -->                   

<!-- 게시물의 조회 페이지에서 사용하기 위해 작성된 reply.js 파일 추가  -->
<script type="text/javascript" src="/resources/js/reply.js"></script>

<script>

/*  게시물 하단에 댓글 화면이 자동으로 따라옴  */
$(document).ready(function() {
	
	var bnoValue = '<c:out value="${board.bno}" />';
	var replyUL = $(".chat");
	
	showList(1); //페이지 번호를 파라미터로 받도록 설계, 만일 파라미터가 없는 경우 자동으로 1페이지가 됨 
	
/* 	//댓글 페이지 처리 전 댓글 목록 이벤트 처리 함수 
	//브라우저에서 DOM 처리가 끝나면 자동으로 showList가 호출되면서 <ul>태그 내에 내용으로 처리됨 
	//만일 1페이지가 아닌 경우라면 기존 <ul>에 <li>들이 추가되는 형태임
	function showList(page){
		
		replyService.getList({bno:bnoValue,page: page|| 1}, function(list) {
			
			var str = "";
			if(list == null || list.length == 0) {
				replyUL.html("");
				
				return;
			}
			for (var i=0, len = list.length || 0; i < len; i++) {
				str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
				str +="<div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>";
				str +="<small class='pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small></div>";
				str +="<p>"+list[i].reply+"</p></div></li>";
			}
			replyUL.html(str);
		}); //end function
	}//end showList */
	
	/* 댓글 조회 화면 하단 댓글 페이지 번호 출력  */
	/* showReplyPage()는 기존에 Java로 작성되는 PageMaker의 JavaScript 버전에 해당한다.  */
	var pageNum = 1;
	var replyPageFooter = $(".panel-footer");
	
	function showReplyPage(replyCnt) {
		
		var endNum = Math.ceil(pageNum/10.0)*10;
		var startNum = endNum - 9;
		
		var prev = startNum != 1;
		var next = false;
		
		if(endNum * 10 >= replyCnt) {
			endNum = Math.ceil(replyCnt/10.0);
		}
		
		if(endNum * 10 < replyCnt){
			next = true;
		}
		
		var str ="<ul class='pagination pull-right'>";
		
		if(prev){
			str += "<li class='page-item'><a class='page-link' href='"+(startNum-1)+"'>Previous</a></li>";
		}
		
		for(var i = startNum; i <= endNum; i++) {
			var active = pageNum == i ? "active" : "";
			
			str+="<li class='page-item " + active + "'><a class='page-link' href='"+ i +"'>" + i + "</a></li>";
			
		}
		
		if(next) {
			str+="<li class='page-item'><a class='page-link' href='"+ (endNum + 1) +"'>Next</a></li>";
			
		}
		
		str+="</ul></div>";
		
		console.log(str);
		
		replyPageFooter.html(str);
		
	}
	
	//댓글 페이지 처리 후 댓글 목록 이벤트 처리 함수
	function showList(page){
		
		console.log("show list" + page);
		
		replyService.getList({bno:bnoValue, page:page|| 1}, function(replyCnt, list) {
			
			console.log("replyCnt: " + replyCnt);
			console.log("list: " + list);
			console.log(list);
			
			if(page == -1){
				pageNum = Math.ceil(replyCnt/10.0);
				showList(pageNum);
				return;
			}
			
			var str = "";
			
			if(list == null || list.length == 0) {				
				return;
			}
			
			for (var i=0, len = list.length || 0; i < len; i++) {
				str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
				str +="<div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>";
				str +="<small class='pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small></div>";
				str +="<p>"+list[i].reply+"</p></div></li>"; 
			}
			
			replyUL.html(str);
			
			showReplyPage(replyCnt); 
		}); //end function
	}//end showList
	
	//페이지 번호를 클릭했을 때 새로운 댓글을 가져오도록 한다. 
	replyPageFooter.on("click", "li a", function(e){
		e.preventDefault();
		console.log("page click");
		
		var targetPageNum = $(this).attr("href");
		
		console.log("targetPageNum: " + targetPageNum);
		
		pageNum = targetPageNum;
		
		showList(pageNum);

	});
	
	var modal = $(".modal");
	var modalInputReply = modal.find("input[name='reply']");
	var modalInputReplyer = modal.find("input[name='replyer']");
	var modalInputReplyDate = modal.find("input[name='replyDate']");
	
	var modalModBtn = $("#modalModBtn");
	var modalRemoveBtn = $("#modalRemoveBtn");
	var modalRegisterBtn = $("#modalRegisterBtn");
	var modalCloseBtn = $("#modalCloseBtn");
	
	$("#addReplyBtn").on("click", function(e){
		
		modal.find("input").val("");
		modalInputReplyDate.closest("div").hide();
		modal.find("button[id != 'modalCloseBtn']").hide();
		
		modalRegisterBtn.show();
		
		$(".modal").modal("show");
	});
	
	modalRegisterBtn.on("click", function(e) {
		
		var reply = {
				reply : modalInputReply.val(),
				replyer : modalInputReplyer.val(),
				bno:bnoValue
		};
	    replyService.add(reply,function(result){
	    	alert(result);
	    	modal.find("input").val("");
	    	modal.modal("hide");
	    	
	    	// showList(1); // 페이지 처리 전 댓글 마지막 목록 조회  
	    	showList(-1); // 페이지 처리 후 댓글 마지막 목록 조회
	    });
	});
	
	/* 댓글 조회 클릭 이벤트 처리 */
	$(".chat").on("click", "li", function(e){
	    
	    var rno = $(this).data("rno");
	    
	    replyService.get(rno, function(reply){
	    
	      modalInputReply.val(reply.reply);
	      modalInputReplyer.val(reply.replyer);
	      modalInputReplyDate.val(replyService.displayTime( reply.replyDate))
	      .attr("readonly","readonly");
	      modal.data("rno", reply.rno);
	      
	      modal.find("button[id !='modalCloseBtn']").hide();
	      modalModBtn.show();
	      modalRemoveBtn.show();
	      
	      $(".modal").modal("show");
	          
	    });
	  });
	
	/* 댓글 수정 이벤트 처리  */
	modalModBtn.on("click", function(e){
		
		var reply = {rno:modal.data("rno"), reply: modalInputReply.val()};
		
		replyService.update(reply, function(result){
			
			alert(result);
			modal.modal("hide");
			// showList(1); //페이지 처리 전 댓글 마지막 목록 조회
			showList(pageNum); //페이지 처리 후 현재 댓글이 포함된 페이지로 이동 
		});
	});
	
	/* 댓글 삭제 이벤트 처리  */
	modalRemoveBtn.on("click", function(e){
		
		var rno = modal.data("rno");
		
		replyService.remove(rno, function(result){
			
			alert(result);
			modal.modal("hide");
			// showList(1); //페이지 처리 전 댓글 마지막 목록 조회
			showList(pageNum); //페이지 처리 후 현재 댓글이 포함된 페이지로 이동 
		})
	});
		
});
</script>

<!-- 댓글 등록 테스트 시작 (reply.js의 replyService.add test) -->
<!-- <script>

console.log("==================");
console.log("JS TEST");

var bnoValue = '<c:out value="${board.bno}"/>';

//for replyService add test
replyService.add(
		{reply:"JS TEST", replyer:"tester", bno:bnoValue},
		function(result) {
			alert("RESULT: " + result);
		}
	);

</script>  -->

<!-- 모든 댓글을 가져오는지 확인 시작 (reply.js의 replyService.getList test)-->
<!-- <script>

console.log("================");
console.log("JS TEST");

var bnoValue = '<c:out value="${board.bno}"/>';

replyService.getList({bno:bnoValue, page:1}, function(list){
	
	for (var i=0, len = list.length||0; i<len; i++){
		console.log(list[i]);
	}
});
</script> -->

<!-- 댓글 삭제 테스트 (reply.js의 replyService.remove test) -->
<!-- <script>
replyService.remove(23, function(count){
	
	console.log(count);
	
	if(count === "success") {
	   alert("REMOVED");
	}
   }, function(error) {
	   alert("ERROR");	
});

</script> -->

<!-- 댓글 수정 테스트 (reply.js의 replyService.update test) -->
<!-- <script>

console.log("==================");
console.log("JS TEST");

var bnoValue = '<c:out value="${board.bno}"/>';

replyService.update({
	rno : 22,
	bno : bnoValue,
	reply : "Modified Reply..."
  }, function(result) {
	  alert("수정 완료");
});

</script> -->

<!-- 댓글 조회 테스트 (reply.js의 replyService.get test) -->
<!-- <script>
replyService.get(10, function(data){
	console.log(data);
});
</script> -->

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
              