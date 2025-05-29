package com.example.project_server.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Article {

	private int id;
	private String regDate;
	private String updateDate;
	private int memberId;
	private int boardId;
	private String title;
	private String body;
	private int hitCount;
	private int reactionPoints;

	private String extra__writer;
	
	private String extra__commentsCount;

	private boolean userCanModify;
	private boolean userCanDelete;
}
