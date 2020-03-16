/*
 * Copyright 2011 MOPAS(Ministry of Public Administration and Security).
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
package egovframework.example.bill.service.impl;

import java.util.List;

import egovframework.example.bill.service.BillVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("billMapper")
public interface BillMapper {

	/*이현희:5. 매퍼 만들기(처음만들때 리스트가져오는 메서드 까지 같이 만듦)*/
	
	/** 경비관리 리스트 */
	// 경비관리 리스트 쿼리  id
	List<BillVO> getBillList(BillVO billVO) throws Exception;
	
	/*이현희:12. 저장 서비스임플 만들기*/
	/** 경비등록 */
	// 경비등록 insert 쿼리 id
	void billAdd(BillVO billVO) throws Exception;
	
	/*이현희:27 경비상세 메서드*/
	Object selectBillDtl(BillVO billVO) throws Exception;
	
	/*이현희:35. 수정 매퍼 만들기*/
	/** 경비수정*/
	void billModify(BillVO billVO) throws Exception;
	
	/*이현희:44. 삭제메서드*/
	void billRemove(BillVO billVO) throws Exception;
	
}
