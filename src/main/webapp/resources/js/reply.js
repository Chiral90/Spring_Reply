/**
 * 
 */

console.log("Reply Module....");
//JavaScript의 즉시 실행함수는 () 안에 함수를 선언하고 바깥쪽에서 실행 (function())(); 형태
//즉시 실행함수는 함수의 실행 결과가 바깥쪽에 선언된 변수에 할당
var replyService = (function(){
	//replyService라는 변수에  name 속성에 'AAAA'라는 속성값을 가진 객체가 할당
	//return {name:"AAAA"}
	/*
	function add(reply, callback) {
		consol.log("reply....");
	}
	return {add:add};
	//결과 : replyService객체의 내부에는 add라는 메서드가 존재하는 형태
	*/
	
	// Ajax를 이용해서 POST 방식으로 호출하는 코드
	// 만약 Ajax 호출이 성공하고 callback 값으로 적절한 함수가 존재하면 해당 함수를 호출해서 결과를 반영
	
	function add(reply, callback, error) { // 파라미터로 callback과 error를 지정
		console.log("add reply....");
		
		$.ajax({
			type : 'post',
			url : '/replies/new',
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8", // 데이터 전송 타입
			success : function(result, status, xhr) {
				if (callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		})
	}
	return {
		add : add
	};
	
	function getList(param, callback, error) { // param이라는 객체를 통해서 필요한 파라미터를 전달받아 json 목록을 호출
		
		var bno = param.bno;
		
		var page = param.page || 1;
		
		$.getJSON("replies/pages/" + bno + "/" + page + ".json",
				function(data) {
					if (callback) {
						callback(data);
					}
		}).fail(function(xhr, status, err) {
			if (error) {
				error();
			}
		});
		
	}
	return {
		add : add,
		getList : getList
	};
	
	function remove(rno,callback, error) { // delete 방식으로 데이터를 전달하므로, $.ajax()를 이용해서 구체적으로 type 속성으로 'delete'를 지정
		$.ajax({
			type : 'delete',
			url : '/replies/' + rno,
			success : function(deleteResult, status, xhr) {
				if (callback) {
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er) {
				if (error) error(er);
			}
		})
	}
	return {
		add : add,
		getList : getList,
		remove : remove
	};
	
	
})();
