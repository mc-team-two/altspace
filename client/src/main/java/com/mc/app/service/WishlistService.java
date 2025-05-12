package com.mc.app.service;

import com.mc.app.dto.ReviewImage;
import com.mc.app.dto.Reviews;
import com.mc.app.dto.Wishlist;
import com.mc.app.frame.MCService;
import com.mc.app.repository.WishlistRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class WishlistService implements MCService<Wishlist,Integer> {

    private final WishlistRepository wishlistRepository;

    @Override
    public void add(Wishlist wishlist) throws Exception {
    }

    @Override
    public void mod(Wishlist wishlist) throws Exception {

    }

    @Override
    public void del(Integer integer) throws Exception {
        wishlistRepository.delete(integer);
    }

    @Override
    public Wishlist get(Integer integer) throws Exception {
        return null;
    }

    @Override
    public List<Wishlist> get() throws Exception {
        return List.of();
    }

    public int wishlistInsert(Wishlist wishlist) throws Exception {
        return wishlistRepository.wishlistInsert(wishlist);
    }

    public Wishlist wishlistSelect(Wishlist wishlist) throws Exception {
        return wishlistRepository.wishlistSelect(wishlist);
    }

    public List<Wishlist> getMyWishlists(Wishlist wishlist) throws Exception {
        return wishlistRepository.getMyWishlists(wishlist);
    }

}
