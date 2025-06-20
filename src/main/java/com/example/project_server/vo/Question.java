package com.example.project_server.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Question {
	
	private int id;
	private int certId;
	private int examId;
	private int subjectId;
	private int questNum;
	private String body;
	private boolean hasImage;
	private String imgUrl;
	private LocalDateTime regDate;
	private LocalDateTime updateDate;

	private List<Choice> extra__choices;

}