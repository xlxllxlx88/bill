<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 이현희:7. List jsp 만들기 -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title> 경비관리
    </title>
    <link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>

    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script type="text/javaScript" language="javascript" defer="defer">
    	

    	var popup;	// 팝업객체
    	
    	// 이현희:7_2_2. 등록버튼 만들기 - function 만들기 (Popup)
    	function fn_goAdd() {
    		// 등록창 팝업
    		popup = window.open("/billAddView.do", "PopupAdd", "width=750, height=280");
    	}
    	
    	//이현희:20 조회 function
    	// 검색 이벤트 (등록연월, 사용내역, 처리상태)
    	function fn_selectList() {
    		location.href = '/billList.do?searchYm=' + $("#searchYm").val()
					      	    + '&searchDtlCd=' + $("#searchDtlCd").val()
					  	   		+ '&searchStatusCd=' + $("#searchStatusCd").val(); 	
    	}
    	
    	// 이현희:17 저장 부모창 재조회
    	function fn_popCallBack(gubun) {
    		if (gubun == 'add' || gubun == 'del') {
    			popup.close();
    			fn_selectList();
    		} else if (gubun == 'mod') {
    			fn_selectList();
    		}
    		
    	}
    	
    	// 이현희:23 상세 팝업 이벤트
    	function fn_goBillDtl(billNum) {
    		popup = window.open("/billDtlView.do?billNum=" + billNum
    								+ "&searchYm=" + $("#searchYm").val()
    								+ "&searchDtlCd=" + $("#searchDtlCd").val()
    								+ "&searchStatusCd=" + $("#searchStatusCd").val()
    						   ,"PopupDtl"
    						   ,"width=750, height=650");
    	}
    	
    	//이현희:50 엑셀다운로드 이벤트
	    function fn_excelDown() {
    		var excelForm = document.excelForm;
    		excelForm.searchYm = $("#searchYm").val();
    		excelForm.searchDtlCd = $("#searchDtlCd").val();
    		excelForm.searchStatusCd = $("#searchStatusCd").val();
    		excelForm.action = 'billExcelDown.do';
    		excelForm.submit();
	    }
    
	</script>
</head>
<body style="text-align:center; margin:0 auto; display:inline; padding-top:100px;">

	<form name="excelForm" id="excelForm">
		<input type="hidden" name="searchYm"/>
		<input type="hidden" name="searchDtlCd"/>
		<input type="hidden" name="searchStatusCd"/>
	</form>
	
    <form:form commandName="BillVO" id="listForm" name="listForm" method="post">
        <div id="content_pop">
           <!-- 타이틀 -->
           <div id="title">
              <ul>
                 <li>
                 	<img src="<c:url value='/images/egovframework/example/title_dot.gif'/>" alt=""/>
                   	경비관리
                 </li>
              </ul>
           </div>
           
           <!-- 검색 -->
           <!-- // 이현희:18 검색조건 -->
           <div id="search">
           	<ul>				
				<li><label for="searchYm">등록연월</label>			
					<input type="text" name="searchYm" id="searchYm" maxlength="6" value="${searchYm}"/>
				</li>						
				<li>			
					<span class="btn_blue_l">					 
					<a href="javascript:fn_selectList();">검색</a>					
					<img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>					
					</span>					
				</li>					
			  </ul>	 	
			  <ul>	
			    <li><label for="searchDtlCd">사용내역</label>
			    	<!-- name id 잊지말기 -->
			    	<select	name="searchDtlCd" id="searchDtlCd">
			    		<option value="">전체</option>
			    		<!-- c태그로 검색 값 유지 -->
			    		<option value="NB" <c:if test="${searchDtlCd eq 'NB'}">selected</c:if> >식대(야근)</option>
			    		<option value="NT" <c:if test="${searchDtlCd eq 'NT'}">selected</c:if> >택시비(야근)</option>
			    		<option value="HT" <c:if test="${searchDtlCd eq 'HT'}">selected</c:if> >택시비(회식)</option>
			    		<option value="S"  <c:if test="${searchDtlCd eq 'S'}">selected</c:if> >사무용품 구매</option>
			    		<option value="G"  <c:if test="${searchDtlCd eq 'G'}">selected</c:if> >교육비</option>
			    		<option value="J"  <c:if test="${searchDtlCd eq 'J'}">selected</c:if> >접대비</option>
			    	</select>		
				</li>			
		   	 </ul>
		   	 <ul>	
			    <li><label for="searchStatusCd">처리상태</label>
			    	<select	name="searchStatusCd" id="searchStatusCd">
			    		<option value="">전체</option>
			    		<option value="J" <c:if test="${searchStatusCd eq 'J'}">selected</c:if> >접수</option>
			    		<option value="S" <c:if test="${searchStatusCd eq 'S'}">selected</c:if> >승인</option>
			    		<option value="O" <c:if test="${searchStatusCd eq 'O'}">selected</c:if> >지급완료</option>
			    		<option value="N" <c:if test="${searchStatusCd eq 'N'}">selected</c:if> >반려</option>
			    	</select>		
				</li>			
		   	 </ul>		
           </div> 
           
           <!-- 이현희:7_1. List 만들기 (일단 기능 다 빼고 데이터가 잘 나오는지 확인만 가능한 리스트)-->
           <div id="table">
              <table width="100%" border="0" cellpadding="0" cellspacing="0" >
                 <caption style="visibility:hidden"></caption>
                 <colgroup>
                    <col width="40"/>
                    <col width="100"/>
                    <col width="200"/>
                    <col width="100"/>
                    <col width="100"/>
                    <col width="80"/>
                    <col width="100"/>
                 </colgroup>
                 <tr>
                    <th align="center">순번</th>
                    <th align="center">사용일</th>
                    <th align="center">사용내역</th>
                    <th align="center">사용금액</th>
                    <th align="center">승인금액</th>
                    <th align="center">처리상태</th>
                    <th align="center">등록일</th>
                 </tr>
                 
                 <!-- billList 키, list 값 -->
                 <c:forEach var="list" items="${billList}" varStatus="status">
                     <tr>
                        <td align="center">${list.no }</td>
                        <td align="center">
                        	<!-- parseDate는 String형을 Date형을 변경, ${list.useDt} 데이터 형식과  yyyymmdd 동일하게 패턴 입력, -->
                        	<fmt:parseDate  value='${list.useDt}' var='tran_useDt' pattern='yyyymmdd'/>
                        	<!-- formatDate는 지정한 패턴(yyyy-mm-dd)에 맞게 노출 -->
                        	<fmt:formatDate value="${tran_useDt}" pattern="yyyy-mm-dd"/>
                        </td>
                        <!-- 이현희:22 상세 href 연결-->
                        <td align="center"><a href="javascript:fn_goBillDtl('${list.billNum}');">${list.dtlNm}</a></td>
                        <td align="center">${list.useAmt}</td>
                        <td align="center">
                        	<c:if test="${ empty list.apprAmt }">
                        	<!-- 승인금액이 없을 땐 '-' -->
                        	-
                        	</c:if>
                        	<c:if test="${ !empty list.apprAmt }">
                        	<!-- 승인금액이 있을 땐 데이터 -->
                        	${list.apprAmt}
                        	</c:if>
                        </td>
                        <td align="center">${list.statusNm}</td>
                        <td align="center">${list.regDt}</td>
                     </tr>
                 </c:forEach>
              </table>
           </div>
           <!-- /btn --> 
           <div id="sysbtn">
             <ul>
             	<!-- 이현희:7_2. 등록버튼 만들기-->
             	<!-- 이현희:7_2_1. 등록버튼 만들기 - function 부르는 부분 -->
                 <li>
                     <span class="btn_blue_l">
	                     <a href="javascript:fn_goAdd();">등록</a>
	                     <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
                     </span>
                 </li>
                 <!-- 이현희:49. 엑셀다운로드 -->
                 <li>
                     <span class="btn_blue_l">
	                     <a href="javascript:fn_excelDown();">엑셀다운로드</a>
	                     <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
                     </span>
                 </li>
              </ul>
           </div>
        </div>
    </form:form>
</body>
</html>