package com.mc.controller;

import com.mc.app.dto.Payments;
import com.mc.app.dto.Reviews;
import com.mc.app.dto.User;
import com.mc.app.dto.Wishlist;
import com.mc.app.repository.WishlistRepository;
import com.mc.app.service.WishlistService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/wishlist")
public class WishListController {

    private final WishlistService wishlistService;
    String dir ="wishlist/";

    @RequestMapping("")
    public String wishlist(Model model, HttpSession httpSession) throws Exception {

        User user = (User)httpSession.getAttribute("user");

        if (user == null) {
            return "redirect:/login"; // 세션 만료나 비로그인 처리
        }

        // user 객체에서 아이디 가져오기
        String userId = user.getUserId();

        // DB 조회용 객체 생성
        Wishlist wishlist = new Wishlist();
        wishlist.setUserId(userId);

        // 실제 DB 조회(여러 건 가져올 수 있음)
        List<Wishlist> wishlists = wishlistService.getMyWishlists(wishlist);

        model.addAttribute("wishlists", wishlists);
        model.addAttribute("headers", dir + "headers");
        model.addAttribute("center", dir + "center");
        model.addAttribute("footer", dir + "footer");
        return "index";
    }

    @ResponseBody
    @RequestMapping("/add")
    public Map<String, Object> addWishlist(@RequestParam("accommodationId") int accommId,
                                           HttpSession httpSession) throws Exception {
        Map<String, Object> result = new HashMap<>();

        User user = (User)httpSession.getAttribute("user");

        if (user == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return result;
        }

        // user 객체에서 아이디 가져오기
        String userId = user.getUserId();

        // DB 조회용 객체 생성
        Wishlist wishlist = new Wishlist();
        wishlist.setUserId(userId);
        wishlist.setAccommodationId(accommId);

        int wishlistId = wishlistService.wishlistInsert(wishlist);
        result.put("success", true);
        result.put("wishlistId", wishlistId);

        return result;
    }

    @ResponseBody
    @RequestMapping("/delete")
    public Map<String, Object> deleteWishlist(@RequestParam("wishlistId") int Id) {
        Map<String, Object> result = new HashMap<>();

        try {
            wishlistService.del(Id); // 실제 삭제 처리
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "삭제 중 오류 발생");
        }

        return result;
    }
}
