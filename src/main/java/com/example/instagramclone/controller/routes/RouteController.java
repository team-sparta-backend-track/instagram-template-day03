// controller/RouteController.java
package com.example.instagramclone.controller.routes;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@Slf4j
public class RouteController {

    @GetMapping("/")
    public String index() {
        // Day 1: 무조건 인덱스 페이지로 이동 (인증 체크 생략)
        return "index";
    }

    // 회원가입 페이지 열기
    @GetMapping("/signup")
    public String signUp() {
        return "auth/signup";
    }

    // 프로필 페이지 열기
    @GetMapping("/{username}")
    public String profilePage() {
        return "components/profile-page";
    }

    // 해시태그 페이지 열기
    @GetMapping("/explore/search/keyword/")
    public String hashtag() {
        return "components/hashtag-search";
    }

}
