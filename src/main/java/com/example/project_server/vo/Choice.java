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
public class Choice {

	private int id;
	private int questId;
	private int label; // 선택지 번호
	private String body;
	private boolean isCorrect;
	private LocalDateTime regDate;
	private LocalDateTime updateDate;
}