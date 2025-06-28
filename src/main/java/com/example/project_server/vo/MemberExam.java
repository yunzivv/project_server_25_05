package com.example.project_server.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MemberExam {

	private int id;

	private int memberId;
	private int certId;
	private Integer examId;

	private LocalTime elapsedTime;
	private int totalQuest;
	private int correctQuest;

	private LocalDateTime regDate;
	private LocalDateTime updateDate;
}