<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="MEMBER JOIN"></c:set>
<%@ include file="../common/head.jspf" %>

<script type="text/javascript">

    $(document).ready(function () {
        $('.back').addClass('hidden');

        setTimeout(function () {
            const coverLogo = $('.member_loading');
            coverLogo.addClass('actived');
            coverLogo.on('transitionend', function () {
                coverLogo.addClass('hidden');
            });
        }, 1300);

        setTimeout(function () {
            const $cover = $('.join_cover');
            $cover.addClass('slide');
            $cover.on('transitionend', function () {
                $cover.addClass('hidden');
            });
        }, 1500);

        setTimeout(function () {
            $('.join_form').removeClass('opacity-0');
        }, 1800);

        const $steps = $(".step");

        function getCurrentStepIndex() {
            return $steps.index($(".step.active"));
        }

        function showStep(index) {
            $steps.each(function (i) {
                const $step = $(this);
                $step.removeClass("active end");

                if (i === index) {
                    $step.addClass("active");
                } else if (i < index) {
                    $step.addClass("end");
                }
            });

            updateButtons(index);
        }

        function updateButtons(index) {
            const isFirst = index === 0;
            const isLast = index === $steps.length - 1;

            $(".prev-btn").toggleClass("hidden", isFirst);
            $(".next-btn").toggleClass("hidden", isLast);
            $(".submit-btn").toggleClass("hidden", !isLast);
        }

        $(".next-btn").on("click", function () {
            $('.text-red-500').addClass('hidden');

            const currentIndex = getCurrentStepIndex();
            const nextIndex = currentIndex + 1;

            if (currentIndex === 0) {
                const name = $('input[name="name"]').val();
                const birthday = $('input[name="birthday"]').val();


                if (!name) {
                    $('#name-error').removeClass('hidden');
                    return;
                }
                if (!birthday) {
                    $('#birthday-error').removeClass('hidden');
                    return;
                }
            }

            if (currentIndex === 1) {
                const id = $('input[name="loginId"]').val();
                const pw = $('input[name="loginPw"]').val();
                const pwCheck = $('input[name="checkLoginPw"]').val();
                const idValid = /^[A-Za-z0-9]{4,20}$/.test(id);
                const pwValid = /^[A-Za-z0-9!@#$%^&*()_+\[\]{};':"\\|,.<>\/?`~\-]{6,20}$/.test(pw);

                if (!idValid) {
                    $('#id-error').removeClass('hidden');
                    return;
                }
                if (!pwValid) {
                    $('#pw-error').removeClass('hidden');
                    $('#pw-check-error').addClass('hidden');
                    return;
                } else if (pw !== pwCheck) {
                    $('#pw-check-error').removeClass('hidden');
                    $('#pw-error').addClass('hidden');
                    return;
                }
            }

            if (currentIndex === 2) {
                const phone = $('input[name="cellPhone"]').val();
                const email = $('input[name="email"]').val();
                const phoneValid = /^[0-9]{10,11}$/.test(phone);
                const emailValid = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);

                if (!phoneValid) {
                    $('#phone-error').removeClass('hidden');
                    return;
                } else {
                    $('#phone-error').addClass('hidden');
                }

                if (!emailValid) {
                    $('#email-error').removeClass('hidden');
                    return;
                } else {
                    $('#email-error').addClass('hidden');
                }
            }

            if (nextIndex < $steps.length) {
                showStep(nextIndex);
            }
        });

        $(".prev-btn").on("click", function () {
            const currentIndex = getCurrentStepIndex();
            const prevIndex = currentIndex - 1;

            if (prevIndex >= 0) {
                showStep(prevIndex);
            }
        });

        // 초기 설정
        showStep(0);
    });

</script>

<div class="join_fullPage h-screen flex justify-center items-center"
     style="background-color: rgba(0, 0, 0, 0.3);">

    <div class="flex w-3/5 h-2/3 bg-grey-1 rounded-3xl shadow-2xl overflow-hidden relative">
        <div class="member_loading folding-text absolute w-full h-full z-50 text-10xl">
            <span>C</span><span>E</span><span>R</span><span>T</span><span>I</span><span>F</span><span>Y</span>
        </div>
        <div class="join_cover bg-grey-1 rounded-3xl text-8xl">
        </div>
        <div class="join_form w-1/2 h-full flex flex-col justify-center items-center opacity-0">
            <form name="login" action="doJoin" method="POST" class="w-5/6 h-full flex flex-col items-center">
                <input type="hidden" name="afterLoginUri" value="${param.afterLoginUri}"/>
                <div class="join_steps w-full h-full relative overflow-hidden">
                    <!-- Step 1 -->
                    <div class="step step-1 absolute w-full h-full transition-all duration-500 flex flex-col items-center justify-center active">
                        <input type="text" name="name"
                               class="bg-white border-grey- text-sm rounded-lg block p-4 mb-4"
                               placeholder="이름"/>
                        <div class="error text-red-500 text-sm hidden" id="name-error">이름을 입력하세요.</div>
                        생년월일
                        <input type="date" name="birthday"
                               class="bg-white border-grey- text-sm rounded-lg block p-4 mb-4"/>
                        <div class="error text-red-500 text-sm hidden" id="birthday-error">생년월일을 입력하세요.</div>
                    </div>

                    <!-- Step 2 -->
                    <div class="step step-2 absolute w-full h-full transition-all duration-500 flex flex-col items-center justify-center">
                        <input type="text" name="loginId"
                               class="bg-white border-grey- text-sm rounded-lg block p-4 mb-4"
                               placeholder="아이디"/>
                        <div class="error text-red-500 text-sm hidden" id="id-error">영문 대소문자와 숫자 조합으로 4~20자 입력하세요.
                        </div>
                        <input type="password" name="loginPw"
                               class="bg-white border-grey- text-sm rounded-lg block p-4 mb-4"
                               placeholder="비밀번호"/>
                        <div class="error text-red-500 text-sm hidden" id="pw-error">영문 대소문자와 숫자, 특수기호 조합으로 6~20자 입력하세요.
                        </div>
                        <input type="password" name="checkLoginPw"
                               class="bg-white border-grey- text-sm rounded-lg block p-4 mb-4"
                               placeholder="비밀번호 확인"/>
                        <div class="error text-red-500 text-sm hidden" id="pw-check-error">비밀번호가 일치하지 않습니다.</div>
                    </div>

                    <!-- Step 3 -->
                    <div class="step step-3 absolute w-full h-full transition-all duration-500 flex flex-col items-center justify-center">
                        <input type="tel" name="cellPhone" pattern="[0-9]{11}" required
                               class="bg-white border-grey- text-sm rounded-lg block p-4 mb-4"
                               placeholder="전화번호(숫자만)"/>
                        <div class="error text-red-500 text-sm hidden" id="phone-error">전화번호 형식이 올바르지 않습니다.</div>
                        <input type="email" name="email"
                               class="bg-white border-grey- text-sm rounded-lg block p-4 mb-4"
                               placeholder="e-mail">
                        <div class="error text-red-500 text-sm hidden" id="email-error">이메일 형식이 올바르지 않습니다.</div>
                        <input type="text" name="nickName"
                               class="bg-white border-grey- text-sm rounded-lg block p-4 mb-4"
                               placeholder="닉네임">
                        <div class="error text-red-500 text-sm hidden" id="nickName-error">닉네임 형식이 올바르지 않습니다.</div>
                    </div>
                </div>

                <div class="mt-auto flex justify-between w-1/2 px-6 pb-8 absolute bottom-0 left-0">
                    <button type="button"
                            class="prev-btn hidden bg-grey-3 text-white font-bold py-2 px-4 rounded">
                        이전
                    </button>
                    <div class="flex-grow"></div>
                    <button type="button"
                            class="next-btn bg-blue-2 text-white font-bold py-2 px-4 rounded">
                        다음
                    </button>
                    <button type="submit"
                            class="submit-btn hidden bg-blue-2 hover:bg-green-600 text-white font-bold py-2 px-4 rounded">
                        회원가입
                    </button>
                </div>

                <%--                <div class="flex flex-col w-2/3 h-full mb-4">--%>
                <%--                    <input type="text" name="name"--%>
                <%--                           class="bg-white border-grey-2 text-sm rounded-lg block p-3 mb-4"--%>
                <%--                           placeholder="이름">--%>
                <%--                    <input type="text" name="loginId"--%>
                <%--                           class="bg-white border-grey-2 text-sm rounded-lg block p-3 mb-4"--%>
                <%--                           placeholder="ID">--%>
                <%--                    <input type="text" name="loginPw"--%>
                <%--                           class="bg-white border-grey-2 text-sm rounded-lg block p-3 mb-4"--%>
                <%--                           placeholder="Password">--%>
                <%--                    <input type="password" name="checkLoginPw"--%>
                <%--                           class="bg-white border-grey-2 text-sm rounded-lg block p-3 mb-4"--%>
                <%--                           placeholder="비밀번호 확인">--%>
                <%--                    <input type="text" name="nickName"--%>
                <%--                           class="bg-white border-grey-2 text-sm rounded-lg block p-3 mb-4"--%>
                <%--                           placeholder="닉네임">--%>
                <%--                    <input type="tel" name="cellPhone" pattern="[0-9]{11}" required--%>
                <%--                           class="bg-white border-grey-2 text-sm rounded-lg block p-3 mb-4"--%>
                <%--                           placeholder="전화번호">--%>
                <%--                    <!-- 			<div class="text-neutral-400 mb-6 px-2">Enter your tel without highpen(-)</div> -->--%>
                <%--                    <input type="email" name="email"--%>
                <%--                           class="bg-white border-grey-2 text-sm rounded-lg block p-3 mb-4"--%>
                <%--                           placeholder="e-mail">--%>
                <%--                    <button type="submit"--%>
                <%--                            class="p-3 mb-2 font-semibold bg-blue-2 text-grey-1 rounded-lg">--%>
                <%--                        JOIN--%>
                <%--                    </button>--%>
                <%--                </div>--%>
                <%--                <div class="login-menu flex justify-around my-4 px-20 w-full">--%>
                <%--                    <a class="hover:text-underline" href="login">SIGN IN</a>--%>
                <%--                </div>--%>
            </form>
        </div>
        <div class="w-1/2 relative bg-blue-2 flex items-center">
            <img src="/image/signup2.png" alt="LOGIN IMG">
            <div class="absolute" style="top: 0; left: -20px;">
                <svg width="20" height="20" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <mask id="join_up">
                            <g transform="translate(100, 0) scale(-1, 1) rotate(90 50 50)">
                                <rect width="100" height="100" fill="white"/>
                                <circle cx="100" cy="0" r="100" fill="black"/>
                            </g>
                        </mask>
                    </defs>
                    <rect width="100" height="100" fill="#2f73d9" mask="url(#join_up)"/>
                </svg>


            </div>
            <div class="absolute" style="top: calc(100% - 20px); left: -20px;">
                <svg width="20" height="20" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <mask id="join_down">
                            <g transform="translate(100, 0) scale(-1, 1)">
                                <g transform="scale(1, -1) translate(0, -100)">
                                    <g transform="rotate(90 50 50)">
                                        <rect width="100" height="100" fill="white"/>
                                        <circle cx="100" cy="0" r="100" fill="black"/>
                                    </g>
                                </g>
                            </g>
                        </mask>
                    </defs>
                    <rect width="100" height="100" fill="#2f73d9" mask="url(#join_down)"/>
                </svg>
            </div>
            <a href="login" class="block max-w-max absolute text-grey-1 font-bold" style="left: 20px; bottom: 20px;">SIGN
                IN <i class="ml-2 fa-solid fa-angle-right"></i>
            </a>
        </div>
    </div>
</div>
<%@ include file="../common/foot.jspf" %>