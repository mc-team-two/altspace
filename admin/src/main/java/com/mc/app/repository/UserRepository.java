package com.mc.app.repository;

import com.mc.app.dto.User;
import com.mc.app.frame.MCRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface UserRepository extends MCRepository<User, String> {
    User selectByEmail(String email);
}