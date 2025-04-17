package com.mc.app.service;

import com.mc.app.dto.SocialUser;
import com.mc.app.dto.User;
import com.mc.app.frame.MCService;
import com.mc.app.repository.SocialUserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class SocialUserService implements MCService<SocialUser, String> {

    final SocialUserRepository socialUserRepository;

    @Override
    public void add(SocialUser user) throws Exception {
        socialUserRepository.insert(user);
    }

    @Override
    public void mod(SocialUser user) throws Exception {
        socialUserRepository.update(user);
    }

    @Override
    public void del(String s) throws Exception {
        socialUserRepository.delete(s);
    }

    @Override
    public SocialUser get(String s) throws Exception {
        return socialUserRepository.selectOne(s);
    }

    @Override
    public List<SocialUser> get() throws Exception {
        return socialUserRepository.select();
    }

    public User getBySocialId(String s) throws Exception {
        return socialUserRepository.selectUserBySocialId(s);
    }
}