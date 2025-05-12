package com.mc.app.repository;

import com.mc.app.dto.Reviews;
import com.mc.app.dto.Wishlist;
import com.mc.app.frame.MCRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface WishlistRepository extends MCRepository<Wishlist,Integer> {
    int wishlistInsert(Wishlist wishlist);
    Wishlist wishlistSelect(Wishlist wishlist);
    List<Wishlist> getMyWishlists(Wishlist wishlist);
}
