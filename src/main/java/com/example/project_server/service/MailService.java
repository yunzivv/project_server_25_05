package com.example.project_server.service;

import java.io.UnsupportedEncodingException;
import java.time.LocalDate;
import java.util.List;

import com.example.project_server.repository.MemberRepository;
import com.example.project_server.vo.Member;
import com.example.project_server.vo.MemberCert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.example.project_server.vo.ResultData;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

@Service
public class MailService {

    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private JavaMailSender sender;

    @Value("${custom.emailFrom}")
    private String emailFrom;
    @Value("${custom.emailFromName}")
    private String emailFromName;

    private static class MailHandler {

        private JavaMailSender sender;
        private MimeMessage message;
        private MimeMessageHelper messageHelper;

        public MailHandler(JavaMailSender sender) throws MessagingException {
            this.sender = sender;
            this.message = this.sender.createMimeMessage();
            this.messageHelper = new MimeMessageHelper(message, true, "UTF-8");
        }

        public void setFrom(String mail, String name) throws UnsupportedEncodingException, MessagingException {
            messageHelper.setFrom(mail, name);
        }

        public void setTo(String mail) throws MessagingException {
            messageHelper.setTo(mail);
        }

        public void setSubject(String subject) throws MessagingException {
            messageHelper.setSubject(subject);
        }

        public void setText(String text) throws MessagingException {
            messageHelper.setText(text, true);
        }

        public void send() {
            try {
                sender.send(message);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public ResultData send(String email, String title, String body) {

        MailHandler mail;
        try {
            mail = new MailHandler(sender);
            mail.setFrom(emailFrom.replaceAll(" ", ""), emailFromName);
            mail.setTo(email);
            mail.setSubject(title);
            mail.setText(body);
            mail.send();
        } catch (Exception e) {
            e.printStackTrace();
            return ResultData.from("F-1", "메일 발송 실패하였습니다.");
        }

        return ResultData.from("S-1", "메일이 발송되었습니다.");
    }

    @Scheduled(cron = "0 10 12 * * *") // 초 분 시 일 월 요일
    public void notifyCertificateExpiry() {
        LocalDate targetDate = LocalDate.now().plusDays(3);

        List<MemberCert> endingMemberCerts = memberRepository.getCertsEndingOn(targetDate);

        for (MemberCert endingMemberCert : endingMemberCerts) {
            String memberName = endingMemberCert.getExtra__memberName();
            String memberEmail = endingMemberCert.getExtra__memberEmail();
            String certName = endingMemberCert.getCertname();
            LocalDate endDate = endingMemberCert.getEndDate();

            String title = "[자격증 만료 알림] " + certName + " 자격증이 곧 만료됩니다!";
            String body = String.format("""
            <div>
                <h2>%s님, 안녕하세요.</h2>
                <p>등록하신 <strong>%s</strong> 자격증이 <strong>%s</strong>에 만료됩니다.</p>
                <p>유효기간을 확인하고 연장하세요.</p>
            </div>
        """, memberName, certName, endDate);

            this.send(memberEmail, title, body);
        }
    }

}