package com.example.project_server.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MemberCert {

	private int id;
	private int certId;
	private int memberId;
	private String certname;
	private String certificateNumber;
	private LocalDate startDate;
	private LocalDate endDate;
	private LocalDateTime regDate;
	private LocalDateTime updateDate;
	private boolean alert;

	private int extra__rankNum;
	private String extra__memberName;
	private String extra__memberEmail;
}
