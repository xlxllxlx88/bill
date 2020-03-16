/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.example.bill.service;

import java.util.List;

public interface BillService {
	/*이현희:3. 서비스 만들기(처음만들때 리스트가져오는 메서드 까지 같이 만듦)*/
	
	/** 경비관리 리스트 */
	List<BillVO> getBillList(BillVO billVO) throws Exception;

	/*이현희:11. 저장 서비스 만들기*/
	/** 경비등록 */
	void billAdd(BillVO billVO) throws Exception;
	
	/*이현희:25 경비상세 메서드*/
	/** 경비관리 상세 */
	Object getBillDtl(BillVO billVO) throws Exception;
	
	/*이현희:33. 수정메서드*/
	/** 경비 수정 */
	void billModify(BillVO billVO) throws Exception;
	
	/*이현희:42. 수정메서드*/
	/** 경비 삭제 */
	void billRemove(BillVO billVO) throws Exception;
}
