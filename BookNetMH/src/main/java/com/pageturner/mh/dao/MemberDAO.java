package com.pageturner.mh.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.pageturner.mh.vo.MemberVO;

//@Component
public class MemberDAO {
	@Autowired
	SqlSessionTemplate sqlSession;
	
	public int editUser(MemberVO mVO) {
		return sqlSession.update("mSQL.editUser", mVO);
	}
}
