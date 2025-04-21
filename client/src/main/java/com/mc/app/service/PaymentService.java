package com.mc.app.service;

import com.mc.app.dto.Payments;
import com.mc.app.frame.MCService;
import com.mc.app.repository.PaymentRePository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class PaymentService implements MCService<Payments,Integer> {

    final PaymentRePository paymentRepository;

    @Override
    public void add(Payments payments) throws Exception {
        paymentRepository.insert(payments);
    }

    @Override
    public void mod(Payments payments) throws Exception {
        paymentRepository.update(payments);
    }

    @Override
    public void del(Integer integer) throws Exception {

    }

    @Override
    public Payments get(Integer integer) throws Exception {
        return paymentRepository.selectOne(integer);
    }

    @Override
    public List<Payments> get() throws Exception {
        return paymentRepository.select();
    }

    public Payments getOneTwo(Payments payments) throws Exception {
        return paymentRepository.selectOneTwo(payments);
    }

    public List<Payments> selectPyAll(Payments payments) throws Exception {
        return paymentRepository.selectPyAll(payments);
    }

    public Payments selectPayment(Integer integer) throws Exception {
        return paymentRepository.selectPayment(integer);
    }

}
