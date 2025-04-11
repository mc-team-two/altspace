package com.mc.app.repository;

import com.mc.app.dto.SocialUser;
import com.mc.app.dto.User;
import com.mc.app.frame.MCRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface SocialUserRepository extends MCRepository<SocialUser, String> {
}