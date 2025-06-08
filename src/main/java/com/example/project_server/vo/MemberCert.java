package com.example.project_server.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MemberCert {

	private int id;
	private int certId;
	private String certname;
	private String certificateNumber;
	private LocalDateTime startDate;
	private LocalDateTime endDate;
	private LocalDateTime regDate;
	private LocalDateTime updateDate;

	private int extra__rankNum;
}
