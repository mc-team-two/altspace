package com.mc.app.service;

import com.mc.app.dto.User;
import com.mc.app.frame.MCService;
import com.mc.app.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class UserService implements MCService<User, String> {

    final UserRepository userRepository;

    @Override
    public void add(User user) throws Exception {
        userRepository.insert(user);
    }

    @Override
    public void mod(User user) throws Exception {
        userRepository.update(user);
    }

    @Override
    public void del(String s) throws Exception {
        userRepository.delete(s);
    }

    @Override
    public User get(String s) throws Exception {
        return userRepository.selectOne(s);
    }

    @Override
    public List<User> get() throws Exception {
        return userRepository.select();
    }

    public User getByEmail(String email) {
        return userRepository.selectByEmail(email);
    }


    public void softDel(String id) {
        userRepository.softDelete(id);
    }

}