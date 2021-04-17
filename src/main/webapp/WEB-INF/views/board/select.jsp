<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>

            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Board Detail</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Board Detail Page
                        </div>
                        <%-- <div><%=request.getParameter("no") %></div> --%>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        	<!-- <form role="form" action="#" method="post"> -->
                        		<!-- 글 번호 -->
                        		<c:forEach items="${board }" var="board">
                        		<div class="form-group">
                        			<label>No</label><input class="form-control" name="no"
                        			value='<c:out value="${board.no }" />' readonly="readonly">
                        		</div>
                        		<div class="form-group">
                        			<label>Title</label><input class="form-control" name="title"
                        			value="<c:out value='${board.title }' />" readonly="readonly">
                        		</div>
                        		<div class="form-group">
                        			<label>Text Area</label>
                        			<textarea class="form-control" rows="3" name="content" readonly="readonly"><c:out value='${board.content }' />
                        			</textarea>
                        		</div>
                        		<div class="form-group">
                        			<label>Writer</label><input class="form-control" name="writer"
                        			value="<c:out value='${board.writer }' />" readonly="readonly">
                        		</div>
                        		
                        		<!-- 버튼에 직접 링크 처리 -->
                        		<%-- 
                        		<button data-oper="update" class="btn btn-default">
                        		onclick="location.href='/board/update?no=<c:out value="${board.no }" />'">Update(Modify)</button>
                        		<button data-oper="list" class="btn btn-info"
                        		onclick="location.href='/board/list'">List</button>
                        		--%>
                        		<!-- 다양한 상황을 처리하기 위해 <form> 태그 사용 -->
                        		<button data-oper="update" class="btn btn-default">Update(Modify), Delete</button>
                        		<button data-oper="list" class="btn btn-info">List</button>
                        		<!-- 브라우저에서는 <form> 태그의 내용은 보이지 않고 버튼만 보임 -->
                        		<form id='operForm' action="/board/update" method="get">
                        			<input type='hidden' id='no' name='no' value='<c:out value="${board.no}" />'>
                        			<input type='hidden' id='pageNum' name='pageNum' value='<c:out value="${cri.pageNum }" />'>
                        			<input type='hidden' id='amount' name='amount' value='<c:out value="${cri.amount }" />'>
                        			<!-- 조회 페이지에서 Criteria의 type과 keyword에 대한 처리 -->
                        			<input type='hidden' id='type' name='type' value='<c:out value="${cri.type }" />'>
                        			<input type='hidden' id='keyword' name='keyword' value='<c:out value="${cri.keyword }" />'>
                        		</form>
                        	
                        		</c:forEach>
                        	<!-- </form> -->	                           
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-6 -->
            </div>
            <!-- /.row -->
            <script> console.log('<c:out value="${cri.pageNum}" />') </script>
            <!-- 댓글 관련 JavaScript 모듈 -->
            <script type="text/javascript" src="/resources/js/reply.js"></script>
            
            <script>
            	
	    		console.log("-------------");
	    		console.log("JS TEST");
	    		
	    		//var bnoValue = "917481";
	    		var bnoValue = $("#no").val();
	    		
	    		//for replyService add test
	    		//add()에 던져야하는 파라미터는 JavaScript의 객체 타입으로 만들어서 전송해주고, Ajax 전송 결과를 처리하는 함수를 파라미터로 같이 전달
	    		replyService.add( // select.jsp 내부에서 Ajax 호출은 replyService라는 이름의 객체에 감춰져 있으므로 필요한 파라미터들만 전달하는 형태로 간결해진다
	    				{reply:"JS Test", replyer:"tester01", bno:bnoValue}, // JavaScript의 객체 타입으로 만들어서 전송해주고, Ajax 전송 결과를 처리하는 함수를 파라미터로 같이 전달
	    				function(result) {
	    					alert("RESULT : " + result);
	    				}
	    		);
            </script>
            
            <!-- 버튼을 클릭하면 operForm action 실행 -->
            <script type="text/javascript">
            	$(document).ready(function(){
            		//reply.js의 실행 확인
    	    		//console.log(replyService);
            		
            		var operForm = $("#operForm");
            		
            		$("button[data-oper='update']").on("click", function(e) {
            			
            			operForm.attr("action", "/board/update").submit();
            			
            		});
            		
            		$("button[data-oper='list']").on("click", function(e) {
            			
            			operForm.find("#no").remove(); // list로 이동하는 경우에는 아무런 데이터도 필요하지 않으므로 form 내의 no태그를 삭제
            			
            			operForm.attr("action", "/board/list").submit();
            		})
            		
            	})
            </script>
<%@ include file="../includes/footer.jsp" %>