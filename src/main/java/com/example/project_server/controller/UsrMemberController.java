package com.example.project_server.controller;

import com.example.project_server.service.ArticleService;
import com.example.project_server.service.CertificateService;
import com.example.project_server.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.ui.Model;
import com.example.project_server.service.MemberService;
import com.example.project_server.util.Ut;

import jakarta.servlet.http.HttpServletRequest;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@Controller
public class UsrMemberController {

	@Autowired
	private Rq rq;

	@Autowired
	private MemberService memberService;

	@Autowired
	private CertificateService certificateService;
    @Autowired
    private ArticleService articleService;

	@RequestMapping("/usr/member/join")
	public String join() {

		return "/usr/member/join";
	}

	// 액션메서드
	@RequestMapping("/usr/member/doJoin")
	@ResponseBody
	public String doJoin(String loginId, String loginPw, String checkLoginPw, String name, LocalDate birthday, String nickName, String cellPhone, String email) throws IOException {

		if(Ut.isEmpty(loginId)) return Ut.jsHistoryBack("F-1", "아이디를 작성해주세요.");
		if(Ut.isEmpty(loginPw)) return Ut.jsHistoryBack("F-2", "비밀번호를 작성해주세요.");
		if(Ut.isEmpty(name)) return Ut.jsHistoryBack("F-3", "이름을 작성해주세요.");
		if(Ut.isEmpty(name)) return Ut.jsHistoryBack("F-4", "생일을 작성해주세요.");
		if(Ut.isEmpty(nickName)) return Ut.jsHistoryBack("F-5", "닉네임를 작성해주세요.");
		if(Ut.isEmpty(cellPhone)) return Ut.jsHistoryBack("F-6", "전화번호를 작성해주세요.");
		if(Ut.isEmpty(email) || !email.contains("@")) return Ut.jsHistoryBack("F-7", "이메일을 작성해주세요.");
		if(!loginPw.equals(checkLoginPw)) return Ut.jsHistoryBack("F-8", "비밀번호가 일치하지 않습니다.");

		int id = memberService.doJoin(loginId, loginPw, name, birthday, nickName, cellPhone, email);

		if(id == -1) return Ut.jsHistoryBack("F-8", Ut.f("%s는 이미 사용 중인 아이디입니다.", loginId));
		if(id == -2) return Ut.jsHistoryBack("F-9", Ut.f("이름 %s과 이메일 %s은(는) 이미 사용 중입니다.", loginId, email));

		Member member = memberService.getMemberById(id);

		rq.printConfirmAndRedirect(Ut.f("%s님 가입을 축하합니다.", name), "/");

		return Ut.jsReplace("S-1", Ut.f("%s 님 회원가입을 축하합니다.", nickName), "/");
	}
	@RequestMapping("/usr/member/login")
	public String login() {

		return "/usr/member/login";
	}

	@RequestMapping("/usr/member/doLogin")
	@ResponseBody
	public String doLogin(HttpServletRequest req, String loginId, String loginPw) {

		Rq rq = (Rq) req.getAttribute("rq");

		if(Ut.isEmpty(loginId)) return Ut.jsHistoryBack("F-1", "아이디를 입력해주세요");
		if(Ut.isEmpty(loginPw)) return Ut.jsHistoryBack("F-2", "비밀번호를 입력해주세요");

		Member member = memberService.getMemberByLoginId(loginId);

		if(member == null) return Ut.jsHistoryBack("F-3", "존재하지 않는 아이디입니다.");
		System.out.println(Ut.sha256(loginPw));

		if (member.getLoginPw().equals(Ut.sha256(loginPw)) == false) {
			return Ut.jsHistoryBack("F-4", Ut.f("비밀번호가 일치하지 않습니다."));
		}

		rq.login(member);

		return Ut.jsHistoryBack("S-1", Ut.f("%s님 환영합니다", member.getNickName()));
	}

	@RequestMapping("/usr/member/doLogout")
	@ResponseBody
	public String doLogout(HttpServletRequest req) {

		Rq rq = (Rq) req.getAttribute("rq");

		rq.logout();

		return Ut.jsHistoryBack("S-1", "로그아웃 되었습니다..");

	}

	@RequestMapping("/usr/member/modify")
	public String modify(Model model, HttpServletRequest req) {

		Rq rq = (Rq) req.getAttribute("rq");
		Member member = memberService.getMemberById(rq.getLoginedMemberId());

		model.addAttribute("member", member);

		return "/usr/member/modify";
	}

	@RequestMapping("/usr/member/checkPw")
	@ResponseBody
	public ResultData checkPw(HttpServletRequest req, String pw) {

		Rq rq = (Rq) req.getAttribute("rq");
		Member member = memberService.getMemberById(rq.getLoginedMemberId());

		if(!member.getLoginPw().equals(pw)) {
			return ResultData.from("F-1", "비밀번호가 일치하지 않습니다.");
		}

		return ResultData.from("S-1", "비밀번호 확인이 완료되었습니다.");
	}

	// 로그인 체크 -> 유무 체크 -> 권한 체크

	@RequestMapping("/usr/member/doModify")
	@ResponseBody
	public String doModify(HttpServletRequest req, String loginId, String loginPw, String name, String nickName, String cellPhone, String email) {

		Rq rq = (Rq) req.getAttribute("rq");
		int loginedMemberId = rq.getLoginedMemberId();

//		if(Ut.isEmpty(loginId)) return Ut.jsHistoryBack("F-1", "아이디를 작성하세요.");
//		if(memberService.isUsableLoginId(loginId)) return Ut.jsHistoryBack("F-7", "사용 중인 아이디입니다.");
		if(Ut.isEmpty(loginPw)) return Ut.jsHistoryBack("F-2", "비밀번호를 작성하세요.");
		if(Ut.isEmpty(name)) return Ut.jsHistoryBack("F-3", "이름을 작성하세요.");
		if(Ut.isEmpty(nickName)) return Ut.jsHistoryBack("F-4", "닉네임을 작성하세요.");
		if(Ut.isEmpty(cellPhone)) return Ut.jsHistoryBack("F-5", "전화번호를 작성하세요.");
		if(Ut.isEmpty(email) || !email.contains("@")) return Ut.jsHistoryBack("F-6", "이메일을 정확히 작성하세요.");

		int memberUpdate = memberService.modifyMember(loginedMemberId, loginId, loginPw, name, nickName, cellPhone, email);

		return Ut.jsReplace("S-1", Ut.f("%s 회원님 정보 수정이 완료되었습니다.", nickName),
				"../member/myPage");
	}
	@RequestMapping("/usr/member/findLoginId")
	public String showFindLoginId() {

		return "usr/member/findLoginId";
	}

	@RequestMapping("/usr/member/doFindLoginId")
	@ResponseBody
	public String doFindLoginId(@RequestParam(defaultValue = "/") String afterFindLoginIdUri, String name,
								String email) {

		Member member = memberService.getMemberByNameAndEmail(name, email);

		if (member == null) {
			return Ut.jsHistoryBack("F-1", "존재하지 않는 아이디입니다.");
		}

		// 화면에서 출력
		return Ut.jsReplace("S-1", Ut.f("너의 아이디는 [ %s ] 야", member.getLoginId()), afterFindLoginIdUri);
	}


	@RequestMapping("/usr/member/findLoginPw")
	public String showFindLoginPw() {

		return "usr/member/findLoginPw";
	}

	@RequestMapping("/usr/member/doFindLoginPw")
	@ResponseBody
	public String doFindLoginPw(@RequestParam(defaultValue = "/") String afterFindLoginPwUri, String loginId,
								String email) {

		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			return Ut.jsHistoryBack("F-1", "존재하지 않는 아이디입니다.");
		}

		if (member.getEmail().equals(email) == false) {
			return Ut.jsHistoryBack("F-2", "이메일 주소가 잘못되었습니다.");
		}

		ResultData notifyTempLoginPwByEmailRd = memberService.notifyTempLoginPwByEmail(member);

		return Ut.jsReplace(notifyTempLoginPwByEmailRd.getResultCode(), notifyTempLoginPwByEmailRd.getMsg(),
				afterFindLoginPwUri);
	}

	@RequestMapping("/usr/member/myInfo")
	public String showMyInfo(Model model, HttpServletRequest req) {

		Rq rq = (Rq) req.getAttribute("rq");
		Member member = memberService.getMemberById(rq.getLoginedMemberId());

		List<MemberCert> certs = certificateService.getMemberCerts(rq.getLoginedMemberId());
		List<Article> articles = articleService.getArticlesByMemberId(rq.getLoginedMemberId());

		model.addAttribute("member", member);
		model.addAttribute("certs", certs);
		model.addAttribute("articles", articles);

		return "/usr/member/myInfo";
	}

	@RequestMapping("/usr/member/myCert")
	public String showMyPage(Model model, HttpServletRequest req) {

		Rq rq = (Rq) req.getAttribute("rq");

		Member member = memberService.getMemberById(rq.getLoginedMemberId());
		List<MemberCert> certs = certificateService.getMemberCerts(rq.getLoginedMemberId());
		List<Article> articles = articleService.getArticlesByMemberId(rq.getLoginedMemberId());

		model.addAttribute("member", member);
		model.addAttribute("certs", certs);

		return "/usr/member/myCert";
	}

	@RequestMapping("/usr/member/myPost")
	public String showMyPost(Model model, HttpServletRequest req) {

		Rq rq = (Rq) req.getAttribute("rq");

		Member member = memberService.getMemberById(rq.getLoginedMemberId());
		List<MemberCert> certs = certificateService.getMemberCerts(rq.getLoginedMemberId());
		List<Article> articles = articleService.getArticlesByMemberId(rq.getLoginedMemberId());

		model.addAttribute("member", member);
		model.addAttribute("articles", articles);

		return "/usr/member/myPost";
	}
}
