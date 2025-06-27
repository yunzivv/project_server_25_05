<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="MY PAGE"></c:set>
<%@ include file="../common/head.jspf" %>

<script>
    $(document).ready(function () {

        $('.header').addClass('active');
        $('.nav_box > ul > li:nth-child(4) i').addClass('active');

        $('.side_bar_left').addClass('active');
        $('.side_bar_left > .myPage_sub_menu ').removeClass('hidden');
        $('.side_bar_left > .myPage_sub_menu > li:nth-child(2) > a').addClass('active');
        $('.side_bar_left > .myPage_sub_menu > li:nth-child(2) > a > i').addClass('active');
    });
</script>
<link
  rel="stylesheet"
  href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css"
/>
<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>

<div class="flex w-full">
  <div class="side hidden xl:block shrink-0" style="width: 250px;">
    <%@ include file="../common/side.jspf" %>
  </div>

  <div class="flex-grow flex flex-col items-center pt-20" style="border-top-left-radius: 3rem;">
    <div id="cert" class="w-2/3 flex flex-col">
      <div>총 자격증: ${certs.size()}개</div>

      <form action="/usr/cert/doAdd" method="post" class="relative">
        <input type="hidden" name="certId" id="certIdHidden_myCert">
        <input type="text" name="certName" id="certNameInput_myCert" placeholder="자격증명" autocomplete="off" />
        <div id="autocompleteBox_myCert" style="border: 1px solid #ccc; display: none; position: absolute;"></div>
        <input type="text" name="certificateNumber" placeholder="자격번호">
        <input type="date" name="startDate" placeholder="취득일">
        <input type="date" name="endDate" placeholder="만료일">
        <button type="submit">확인</button>
      </form>

      <div class="swiper mySwiper mt-10 w-full max-w-[1500px]">
        <div class="swiper-wrapper">
          <c:forEach var="cert" items="${certs}">
            <div class="swiper-slide">
              <div class="slide-card p-3 rounded-xl overflow-hidden bg-grey-1 shadow-md relative" style="width: 500px; height: 313px;">
                <div class="cardCover w-full h-full absolute top-0 left-0 bg-white/50 z-10 transition-opacity"></div>
                <div class="cardHead h-1/6 text-center text-3xl font-bold text-grey-100 tracking-widest">회원정보자격</div>
                <div class="flex h-2/3">
                  <div class="img w-1/3 h-full p-2"><img src="/image/user.png" alt="USER"></div>
                  <div class="info flex flex-col justify-between w-2/3 h-full text-lg p-5">
                    <span>자 격 명: ${cert.certname}</span>
                    <span>성    명: ${member.name}</span>
                    <span>자격번호: ${cert.certificateNumber}</span>
                    <span>취 득 일: ${cert.startDate}</span>
                  </div>
                </div>
                <div class="cardBottom h-1/6 flex justify-between items-center p-2 text-center">
                  <button class="px-3 py-2 rounded-md hover:bg-gray-200" onclick="confirmDelete(${cert.id})">삭제</button>
                  <div class="font-black text-lg text-Kakao3">CERTIFY</div>
                  <div class="flex items-center">
                    알림&nbsp;&nbsp;
                    <label class="inline-flex items-center cursor-pointer">
                      <input type="checkbox" class="sr-only peer" ${cert.alert ? "checked" : ""} onchange="toggleAlertMode(${cert.id})">
                      <div class="relative w-11 h-6 bg-gray-200 rounded-full peer-checked:bg-blue-600 after:content-[''] after:absolute after:top-[2px] after:start-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:after:translate-x-full"></div>
                    </label>
                  </div>
                </div>
              </div>
            </div>
          </c:forEach>
        </div>
        <!-- Navigation -->
        <div class="swiper-button-next"></div>
        <div class="swiper-button-prev"></div>
      </div>

      <table class="hidden">
        <thead class="h-5 text-grey-1 bg-neutral-800">
          <tr>
            <th class="px-6 py-4">NO</th>
            <th class="px-6 py-4">자격증명</th>
            <th class="px-6 py-4">자격번호</th>
            <th class="px-6 py-4">취득일</th>
            <th class="px-6 py-4">만료일</th>
            <th class="px-6 py-4">설정</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="cert" items="${certs}">
            <tr class="hover:bg-neutral-100 border-b-grey-1">
              <td class="px-5 py-3">${cert.extra__rankNum}</td>
              <td class="px-5 py-3">${cert.certname}</td>
              <td class="px-5 py-3">${cert.certificateNumber}</td>
              <td class="px-5 py-3">${cert.startDate.toString().substring(0, 10)}</td>
              <td class="px-5 py-3">${cert.endDate.toString().substring(0, 10)}</td>
              <td class="px-5 flex justify-center">
                <button class="p-3 mr-2 rounded-md hover:bg-gray-200" onclick="confirmDelete(${cert.id})">삭제</button>
                <label class="inline-flex items-center cursor-pointer">
                  <input type="checkbox" class="sr-only peer" ${cert.alert ? "checked" : ""} onchange="toggleAlertMode(${cert.id})">
                  <div class="relative w-11 h-6 bg-gray-200 rounded-full peer-checked:bg-blue-600 after:content-[''] after:absolute after:top-[2px] after:start-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:after:translate-x-full"></div>
                </label>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </div>
</div>

<script>
  const swiper = new Swiper(".mySwiper", {
    slidesPerView: 3,
    spaceBetween: -80,
    centeredSlides: true,
    loop: true,
    speed: 600,
    allowTouchMove: false,
    navigation: {
      nextEl: ".swiper-button-next",
      prevEl: ".swiper-button-prev"
    },
    on: {
      slideChangeTransitionEnd: function () {
        document.querySelectorAll(".swiper-slide").forEach((slide, i) => {
          const cover = slide.querySelector(".cardCover");
          if (slide.classList.contains("swiper-slide-active")) {
            cover?.classList.add("opacity-0");
          } else {
            cover?.classList.remove("opacity-0");
          }
        });
      }
    }
  });
</script>

<style>
  .swiper-slide {
    transform: scale(0.85);
    transition: transform 0.4s ease;
    opacity: 0.5;
  }

  .swiper-slide.swiper-slide-active {
    transform: scale(1);
    opacity: 1;
    z-index: 10;
  }
</style>

<script>
  function toggleAlertMode(certId) {
    fetch("/usr/member/alertModeCert?memberCertId=" + certId, { method: "POST" })
      .then((res) => {
        if (!res.ok) throw new Error("요청 실패");
        return res.text();
      })
      .catch((err) => {
        alert("알람 상태 변경 중 오류 발생");
        console.error(err);
      });
  }

  function confirmDelete(id) {
    if (confirm("정말 삭제하시겠습니까?")) {
      location.href = "../cert/doDelete?id=" + id;
    }
  }
</script>
